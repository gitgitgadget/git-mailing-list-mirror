Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5E5C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 06:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A8B2313B
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 06:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbhATGkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 01:40:51 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58323 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729862AbhATG3U (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Jan 2021 01:29:20 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B528E177A;
        Wed, 20 Jan 2021 01:28:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 20 Jan 2021 01:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nEFEvDywGoAYryxb49ifUF3J9j5
        rMHTf13CuG/zgJI0=; b=oG5Ff3isBkAykzkxkWoCC63W40oWT5fLf62EM5NBuSB
        1mlkYqHIaapamHT9NYVQCiEZ0nNabpVDgq0aSGQbZzveSbK8i6cvjYkcgsLGMJOO
        u/lE9eyoiPZ/TGl5F2lkYPlgWhpFvfvWu6cwH2/jM5kVKu+KwZ1DR6NLN9CWdBTk
        wvpz0BNI0W746eUrp7Sloer4Qgl+PAOPDIJZ5Onqh3R5JBms81ldhV3XGkkwc+S7
        ErMSLj+AkLhRbswaX6toMckg4PfehbDJ4OQswEUiB0DYty3lDso4UORW6QHP1gCM
        IeHnTsNIDLXLAW3VGTpkd8+dp2M4lfZz4ze9NpArU7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nEFEvD
        ywGoAYryxb49ifUF3J9j5rMHTf13CuG/zgJI0=; b=YIxEk6ZRTW/KrnNwBDCj8r
        dhlX85yWI/Q1JgEDBbgkxGtjZ4UdwZCgnehpvuwUQrSSMB1dEcEgv2eNdaShPDF/
        lfq6akHtpzF5f+xy4owMN2axqXxKHp6ZKLiRXFtacPP4/lJwycVdbDU3ipPRU9XA
        9qKJGVvC54R5roOJCektHHQOi1CpIx+Vps1zkINcQNSvoBCj3ORJm18vU1eK19TR
        dDKz7W7ucRnWEYVwtYqald7Io1CccLuKBckumtiVLJsDPVzk6IWOReUNZEmkklDd
        9ZEty6QZmQH9YLM1kP9WORPT9LgxqI1654G74+AF+UIZp68txdDFwesragCB4Vxg
        ==
X-ME-Sender: <xms:d80HYNalGrEwbQpIaQLfeBi1M2BZ-hF4w8erzrWqfgMdj4ttFEcHeQ>
    <xme:d80HYEb8lBa62GVTZpchcvzXvM5WMIeHLXrSZZlfe15FRXWaSRVDxzcr73-GwfbUs
    n5GWB1CAWLSv0QvXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddugdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucfkphepkeelrdduvddrfeeirdeitdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:d80HYP-l_rNw4hH0UllsfUQBmtZzyLCvfnIpvDPW_udfeDi56NPxuQ>
    <xmx:d80HYLozh9rsD8_pZnaemcuFa20xV4g8mladGTJT6tlN64XMB8i-2A>
    <xmx:d80HYIrmxbuFggDm3xui4s5mx4lnCXWKs_7rZG9aRvYjMrIJHadErA>
    <xmx:eM0HYFA8xz_fz0ynqteiVorHO1rFuBvqX-4Q7UHB8zb1aCy-6iwxrw>
Received: from vm-mail.pks.im (dynamic-089-012-036-060.89.12.pool.telefonica.de [89.12.36.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id 41DCF24005B;
        Wed, 20 Jan 2021 01:28:07 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a511053b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 20 Jan 2021 06:28:04 +0000 (UTC)
Date:   Wed, 20 Jan 2021 07:28:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com
Subject: Re: [PATCH RESEND] refs: Always pass old object name to reftx hook
Message-ID: <YAfNcyZ7mj4J69XT@ncase>
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
 <ae5c3b2b783f912a02b26142ecd753bf92530d2f.1610974040.git.ps@pks.im>
 <xmqq4kjdkgol.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t7Lgiiij6uyretFv"
Content-Disposition: inline
In-Reply-To: <xmqq4kjdkgol.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t7Lgiiij6uyretFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 02:45:30PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Inputs of the reference-transaction hook currently depends on the
> > command which is being run. For example if the command `git update-ref
> > $REF $A $B` is executed, it will receive "$B $A $REF" as input, but if
> > the command `git update-ref $REF $A` is executed without providing the
> > old value, then it will receive "0*40 $A $REF" as input. This is due to
> > the fact that we directly write queued transaction updates into the
> > hook's standard input, which will not contain the old object value in
> > case it wasn't provided.
>=20
> In effect, the user says "I do not care if this update races with
> somebody else and it is perfectly OK if it overwrites their update"
> by not giving $B.
>=20
> > While this behaviour reflects what is happening as part of the
> > repository, it doesn't feel like it is useful. The main intent of the
> > reference-transaction hook is to be able to completely audit all
> > reference updates, no matter where they come from. As such, it makes a
> > lot more sense to always provide actual values instead of what the user
> > wanted. Furthermore, it's impossible for the hook to distinguish whether
> > this is intended to be a branch creation or a branch update without
> > doing additional digging with the current format.
>=20
> But shouldn't the transaction hook script be allowed to learn the
> end-user intention and behave differently?  If we replace the
> missing old object before calling the script, wouldn't it lose
> information?
>=20
> The above is not an objection posed as two rhetoric questions.  I am
> purely curious why losing information is OK in this case, or why it
> may not be so OK but should still be acceptable because it is lessor
> evil than giving 0{40} to the hooks.
>=20
> Even without this change, the current value the hook can learn by
> looking the ref up itself if it really wanted to, no?

I think the biggest problem is that right now, you cannot discern the
actual intention of the user because the information provided to the
hook is ambiguous in the branch creation case: "$ZERO_OID $NEW_OID $REF"
could mean the user intends to create a new branch where it shouldn't
have existed previously. BUT it could also mean that the user just
doesn't care what the reference previously pointed to.

The user could now try to derive the intention by manually looking up
the current state of the reference. But that does feel kind of awkward
to me.

To me, having clearly defined semantics ("The script always gets old and
new value of the branch regardless of what the user did") is preferable
to having ambiguous semantics.

Patrick

--t7Lgiiij6uyretFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmAHzXIACgkQVbJhu7ck
PpRxKA/+LY7eiHNRrgZeOj6qexMPv7eQb/zq0uvp+k/klnDTrh6swUJfClHXLhgH
ODC4BGWt3j3nKWBTNT/2GNfBl5brTCAm00H8WZ2eMO/l/AcscbG1zplspgGA3zkg
zGj5pS8GCgdde4Zbp9otc6vcdFxIhCoTqc8QbMle+YTyZYLdV3QY7gTQZi8a9Knh
aSVjCVR9ybGmov89rcJYcx1cS59kjd7cMiaXi8wtwSgwdnsa8SCmaZMgQIuHbTnn
eio/JV3Ueh8NFx7f6sc1D4dv6ETRoBq0fSE1fygWyP9J/U1grb2ueYlUfvLxNtyp
9gPQyu7QsVlgYhK6L3IlOKLXSwrGEuk+EMnkIwBFPjMAmB95NP3TjxMucTEcsjKk
KMlPxUNqaUM+3ikLCdYkUwU/US1ot1kC77YT3cJrgkDa5c33vpXizJVg9cBcvuTp
Sz9rczLc5g7ERwYOgq7FIzHlY6sj3rh6f43edwX2SJ+B5JozZ+ONlFgzUh0HuJIB
xp4fLWVKH0fGjqklrbpqlt6qFsaEC2/zjJOSmjb71c6GBhFIuD+p3Ycp6txxyOyo
e+CigDd14BT9fvyYWIIl4LoQvA/odKe3ogc4SmZWonC45flUKfeOFS4D/pjVm7Y+
0HEluFahWOo2zURy8526Wc63uQTJJh+Onr1sTvh6+7HgdfFAOk0=
=GgZs
-----END PGP SIGNATURE-----

--t7Lgiiij6uyretFv--
