Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16BCC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 11:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbiBQLiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:38:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiBQLhy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 06:37:54 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E624F18
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 03:37:36 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2C5A23201D5E;
        Thu, 17 Feb 2022 06:37:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 17 Feb 2022 06:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=bShHKkJaO73VgrkuCksUG/yi0LbfjESbtFZvDQ
        Xa6Ao=; b=tR6+SxsKc6/+ETuk+qcysaGQkIhsYqz1Cewucjci1Hpv0LqLH+gvd5
        SrQmG+E47gzTDIQRF/JKk5XNuiqY4k6ntqHHD9NM6dNJmF+hHKnB8VtrqLvF9fai
        d4OIbsRQFMlydphapfBTd+bGXTZl0Lc9RbNrAbhePIDuI2L4QFcAJezwLmYvn0ua
        jxKlKMPTE/ENMD1PERFVCNxKKr2G7kUqjUgn8CMlpsuOtebnjsIwsM0AyQ/tNF2p
        k++w44U401AtoXOasgw44YxLohprsDRN0MryCc3ISjxsjIRws1zhRW45wz8To7Jr
        kjVYIpqzsX7xLI6N6IV71PVAU93SpQWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bShHKkJaO73VgrkuC
        ksUG/yi0LbfjESbtFZvDQXa6Ao=; b=X5PgU0NPPK11G++0WH3WXRA2GGEECavWs
        kwCBMCbK2K+MwJ3gSshOVMwzxBspzxCixna40pf/DPV66TDfWppsmY7sG5FSSTwR
        eUyZBmU2mVzfdopi2xKjIvay3L4wzlvV+rB+Q8JnfIsc1Yp2TJi/TsSGg/2nk5ks
        EAykAvhmbrPWy//mctqxWUvrJbWBynA+aeFwBCNmtzz4EzutN/xMDGBY9RerlM5m
        4/WV56CLiey4qAtNXdrEKMeTyGpie0Qaj2h3msEd4GD/ZoK0qPYV2exIkxtBIDhV
        ZSERBa31x1Lbb2zqnlWp+D4jF/RY51DkQcbUba/5ILmFAM3Bw55vA==
X-ME-Sender: <xms:fjMOYs-VEpP2v_Ik6BIaZknDL7hsAnO7QunkeOCnwITZYMqTbiFNTg>
    <xme:fjMOYkvfSzb-ecdmib1N44y9kpY7Vis8KOHCgnkVABntSt201JqncA8HLbZtYNFZZ
    jMTsCo0l5LjPQlSGw>
X-ME-Received: <xmr:fjMOYiDNbyNeWsMFCRORRd0CjQQXSUQPw4bLps_uImV04Bff185psOt__N5Pd1gh3CGjpoRq-PwERHJ96WwaN6xHjpIl2T_JE5HU2SWB8U54KqhKDsUjJAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:fjMOYseCSKcBAes_YJeVAy1R_g1LEtJsCxbx0J_Q6XbbVaRnJUk0Jw>
    <xmx:fjMOYhM9Fr2BJUL9QLOxbBYP-W4q1qU6mLhyXnfkNJIrqpfFnuPG-w>
    <xmx:fjMOYmmvwcXmUNordlgeJJfw5oI3xjiGJKDdSFxqUVbGP7McnYeAzg>
    <xmx:fjMOYjVuva8rK5mlQUxJiZFnBPBaflJOQLFD4OMhhaLffxlSeUi4-g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 06:37:33 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2d8f3ec9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 11:37:32 +0000 (UTC)
Date:   Thu, 17 Feb 2022 12:37:31 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] fetch: make `--atomic` flag cover backfilling of tags
Message-ID: <Yg4ze+TMUWEQmszJ@ncase>
References: <cover.1644565025.git.ps@pks.im>
 <55dbe19a1a4d05d84c81356af1a3f04b65f8aa7b.1644565025.git.ps@pks.im>
 <CAP8UFD1bdLESqzbZcYKYfib836vrDTfyCmYfT-9B-1ToJB0EWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0Vl95ZHpWy1jXZbC"
Content-Disposition: inline
In-Reply-To: <CAP8UFD1bdLESqzbZcYKYfib836vrDTfyCmYfT-9B-1ToJB0EWg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0Vl95ZHpWy1jXZbC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 09:11:55AM +0100, Christian Couder wrote:
> On Mon, Feb 14, 2022 at 10:13 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > When fetching references from a remote we by default also fetch all tags
> > which point into the history we have fetched. This is a separate step
> > performed after updating local references because it requires us to walk
> > over the history on the client-side to determine whether the remote has
> > announced any tags which point to one of the fetched commits.
> >
> > This backfilling of tags isn't covered by the `--atomic` flag: right
> > now, it only applies to the step where we update our local references.
> > This is an oversight at the time the flag was introduced: its purpose is
> > to either update all references or none, but right now we happily update
> > local references even in the case where backfilling failed.
>=20
> Also it looks like the backfilling of tags itself isn't atomic, right?
> Some tags could be backfilled while others aren't.

Right.

> > Fix this by pulling up creation of the reference transaction such that
> > we can pass the same transaction to both the code which updates local
> > references and to the code which backfills tags. This allows us to only
> > commit the transaction in case both actions succeed.
>=20
> Maybe this could be seen as a regression by users who are mostly
> interested in the local references though.

Even though the commit message discern "local references" and
"backfilled tags", ultimately they're the same. Both are references that
end up in your local refdb, so from the point of the user there is no
real difference here. Documentation of the `--atomic` flag only says
that "either all refs are updared, or on error, no refs are updated". I
think that the current behaviour does not fit the description.

> > Note that we also have to start passing the transaction into
> > `find_non_local_tags()`: this function is responsible for finding all
> > tags which we need to backfill. Right now, it will happily return tags
> > which we have already been updated with our local references. But when
>=20
> s/we have/have/
>=20
> > we use a single transaction for both local references and backfilling
> > then it may happen that we try to queue the same reference update twice
> > to the transaction, which consequentially triggers a bug. We thus have
>=20
> s/consequentially/consequently/
>=20
> > to skip over any tags which have already been queued. Unfortunately,
> > this requires us to reach into internals of the reference transaction to
> > access queued updates, but there is no non-internal interface right now
> > which would allow us to access this information.
>=20
> This makes me wonder if such a non-internal interface should be
> implemented first. Or if some function to queue a reference update
> could check if the same reference update has already been queued.

Yeah. I noted that ommission in the cover letter already, but didn't yet
want to fix that before getting some initial feedback. I'll add
something like a `for_each_queued_reference_update()` in v2 of this
series though.

Patrick

--0Vl95ZHpWy1jXZbC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOM3oACgkQVbJhu7ck
PpRJlA//X2aO0P+2rmWicQv1vYj1o5NONO8A+mx05rfYuX83Ekm9S8iC2zKqb0y+
z6p1FV4tBVxq4JaFqf1IoplabpntShx2aHsFOcUO5oTRdN3tLDk1gXDRBuHMcOWS
hnguFlWDR0xNZsQxIvOP8WjkLEAzkqrSeFSuoHny9RjqmpokSpF45FOG9kaOs6fz
6J4LTp3z2F+CPG0fDs/ARN6E2IS242M/4RM63bqKwu3+lOJ7UewfIUWPK8KVrD3V
UUZ6DOhDwM//nZgeRz5U9WDe1mvuplmkDq27HWDCahqzOI8KaslmTncxsVPj3z7c
3xRM/7eiZsdgxVeoL1hV23czj19ADSOBwCOyCWlzUYiHjJS6TG8M2fQ6Tv46jSyw
7ZfmX2UgkxEar8AITlubWaTSl48YaQ8bM4AZFEyRdcbUYKR6WyYhL3HPiAN4uxVz
YwOkMq5QH/qsKjZ436+hkonc8WY6qIDMULJkjo1zlUZDraEvdvjdPFFE7FoKcmbY
7ZnABpEpxzOA/gIMa2c9+oQ+hXaPXUkScysn0fdk7ZhOyrdPUolYLypdGjPiwFue
ZWnUE76xSBF97rpuhTugSiaayw5dN7hwSfcKnHPnO0bpeOb8q7Ka2ANNflphtMaS
Yw6kzMv4LZflcDJbegfBmd9r2VxV94Mv+ViRv8MZc/JwqyrfKL4=
=A8M3
-----END PGP SIGNATURE-----

--0Vl95ZHpWy1jXZbC--
