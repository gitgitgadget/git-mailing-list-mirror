Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB04C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 12:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiBQMrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 07:47:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiBQMrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 07:47:32 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C9F4666A
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 04:47:18 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BA3343201487;
        Thu, 17 Feb 2022 07:47:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 17 Feb 2022 07:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=obhBI0tMWWpBgM/yTjbtGh2AmAL0YmLmthJpP1
        ur1oo=; b=PobodLhF73nsCQbx6Crrs5W+cQxC3/t646xruxMkF6zhBSrObnCDbC
        5/kn7/bK3pki/190G/Qmxek1CbTKymscz0DjhtG2M0finCLuK7cpcZOFXVZkO5RM
        1CF6XtLzGYSn+BTEkis7DgNbYcXYOg31fkWNH3fpVehN1WkKmMFy1JDvf4B/7a4C
        q2ksUxbeMlZgxs4uzULocSZdZRsJnK6XsmyOePcgAHPOYtqKXTUdPhn3vBSvNbX9
        k5B8lTZPM3ZhHxBG0SU1w3P1IXllWck7zeubvnfvF+CEfzXOsU/0i6FoBWLqRgr0
        T6dEPzpWKchlWNChcE58b5KEJdrcHDOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=obhBI0tMWWpBgM/yT
        jbtGh2AmAL0YmLmthJpP1ur1oo=; b=afxuIalNxyW48gf/3tregMTIhAbwFPTMj
        cNdDmAa+hGa+wFGOsd7+5ZOe5s77OPy8rcTzx2liTwT5rh6BD1V38j0YEraAPs2Y
        3NANlve/wY6AF507Nshdnzr429CPcV/8J3Cdrvu13xs7cddch29yRaq5MJzyA/yh
        lzT4k/jc4PPZOprAb76dtNG0VaOS+nuTBpChuzzG2BBPerG3xSbQrKy1lohOU9H1
        QUe4F76zbuqXwWdmsxe/m8B6hkQImOgh7bm3EUnZTWWvaN4yDgMz6uHYuCuehBwa
        L6hzlwvMj8m18CL/9P7bOCDmzd53ZZ/QbIwYxI1tOmRyZ2tH2eV4Q==
X-ME-Sender: <xms:00MOYtyYQmO_ezI6UWmY7RN0HprCkVmTmfYWLKXvbzi2bDtB4pYlUQ>
    <xme:00MOYtTZdhP8t_b7ALnOyM_A0Q-dW4nxIbK-GHomnRARDZY_p82PJoiuPf8xG2nyr
    AXdXKHTJKeI3l3AOw>
X-ME-Received: <xmr:00MOYnWPH7A4lUaobr2jbz6VDuyMUOksNC3II4_ZfLvSEtqsvg65lcLKtjepU7q4fhAVunHYxhdwNGaeYiGEgByUv14VzRlTgzXCCLxmXSVRSQlayj0sAXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:00MOYvieElND-dA4_Eo-5A5v2Gj_npe3sDiQT85da1RqkD91YsGS_A>
    <xmx:00MOYvBDpPKhkh5wLEHl39vDmk39hqWRpj7hRsQLv5HhQcuFtGyr_A>
    <xmx:00MOYoIpISfvo9lUUCIyKw7qmC1fSCZwhWTYTTHvX5PlQA_bk1oh-Q>
    <xmx:1EMOYk6RUWOyErWgwe5Q0Kom0Yv7YjtVFwZoVOGSy1qnusnB0JLVKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 07:47:15 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b92c1d53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 12:47:12 +0000 (UTC)
Date:   Thu, 17 Feb 2022 13:47:11 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 4/6] fetch: report errors when backfilling tags fails
Message-ID: <Yg5Dz/VNW+2osN1s@ncase>
References: <cover.1644565025.git.ps@pks.im>
 <54fdee845bea7f67f46817417f8e5a504bd39665.1644565025.git.ps@pks.im>
 <CAP8UFD0MQCpFfWg2FP3S1VpDAxCwp3WGucFPn7K9BZ7UnckNLw@mail.gmail.com>
 <Yg4xEQmXyzSeYZ1k@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y2mad1KueBvFMxMM"
Content-Disposition: inline
In-Reply-To: <Yg4xEQmXyzSeYZ1k@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--y2mad1KueBvFMxMM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 17, 2022 at 12:27:15PM +0100, Patrick Steinhardt wrote:
> On Tue, Feb 15, 2022 at 08:52:14AM +0100, Christian Couder wrote:
> > On Fri, Feb 11, 2022 at 9:03 PM Patrick Steinhardt <ps@pks.im> wrote:
> > >
> > > When the backfilling of tags fails we do not report this error to the
> > > caller, but only report it implicitly at a later point when reporting
> > > updated references.
> >=20
> > Probably stupid question: are we sure that it's a bug and not a feature?
>=20
> Good question, and I don't have a definitive answer for it. But to me it
> very much smells like a bug: if I ask for a fetch and the fetch fails to
> populate some of the data I have asked for, then I want to get a
> notification on that failure.
>=20
> > > This leaves callers unable to act upon the
> > > information of whether the backfilling succeeded or not.
> > >
> > > Refactor the function to return an error code and pass it up the
> > > callstack. This causes us to correctly propagate the error back to the
> > > user of git-fetch(1).
> >=20
> > Even if it would have been the right behavior when backfilling tags
> > was implemented to return an error when backfilling tags fails, I
> > think it's interesting to ask ourselves if this change could be seen
> > as a regression by some users.
>=20
> Yeah, it's not all that clear-cut because auto-following of tags is a
> bit obscure. But our default behaviour is to fetch tags pointing into
> the history, and if a user didn't want that they should've passed
> `--no-tags` to git-fetch(1). So conversely, we should assume that a user
> is asking for auto-filling of tags if we're not told otherwise, which
> also means that it is a failure if this fails.
>=20
> At least that's my take, but I'm happy to hear arguments against my
> viewpoint.
>=20
> Patrick

I just noticed that we have in fact landed a change in the exact same
spirit on `main` via c9e04d905e (fetch --prune: exit with error if
pruning fails, 2022-01-31). So there is precedent that we fix up these
missing error codes, and that gives me more confidence that doing the
same fixup for the tag-backfill is the correct thing to do.

Patrick

--y2mad1KueBvFMxMM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOQ84ACgkQVbJhu7ck
PpR+5g//UvaNgMlKCPSUEjzqXOeVatahZUihGsdU9doDVo036wP9gOidb/LaRDKn
QMOCw5R6C8huprek4SreBZJdraXF84z+diODjQPx5TRDMGO2j2CbaIHzm/nzcEbf
st1CtvbqAPHxG6Wab484ucCmd1ROJ+19lhyvdqjcw4Em2+amzxiHhLHA/3kcmRXc
eX3JHk2z1t4atz5okYoH3Ey4oMl+XiaeweyRKFSTpGSw4bez15E9q0QXoTJPxkKU
jMuuPDfg53D8tkuTCUeMXbFF7URbcfbelOYgk+7OtncKiLOzj6FI19fXWmtMYOlt
QcbY45py3GaCzDTwepqeLH9xY0KlMR32272+NQTLps7bRVt/pEqVu+QbUJ8SINGM
fr1V3yvND2oR8lcbvTo1856l78uwVCElz+oiA6eTeLz4J6F2BGnwTNa1DsgjRNnp
8JOugsboRr2/NQaDB3UKwUw2BZY/8doD/E1QqRHDJxWiY/KrOCARCu2vjYjkTEpR
fTYuZFAoIEyeWIIpEnJjtIVh1v9KTluC2vxUkk/9XLxx2s8KsXPJvXHzreXWBwgv
4jryMRZRh6BqJN7A2+aevAgQri/zbMxsb6wDS2AkNZj9ddMViuBt3za84b1XgwQL
NIiooU3Pi47MDXUeEZrNPnixrbGpXQ7WXVBtPi7FHyZKdZXk3rc=
=k52y
-----END PGP SIGNATURE-----

--y2mad1KueBvFMxMM--
