Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC00CC636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 07:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjBTHig (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 02:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjBTHie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 02:38:34 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F76B444
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 23:38:33 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EAB1F32009D0;
        Mon, 20 Feb 2023 02:38:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 Feb 2023 02:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676878712; x=1676965112; bh=7r4F4wjq4x
        OOpqhA10zqcDMNrv7Svi1fbEi0S0B4BVc=; b=NQ5hWotzndW1gQXViKL2+DqouV
        Awq2UwxhtdyfyqB4OPQq6srNHcD0fosNlrF+DwDKdYCrULLUsXMQgim2ROlYjRCE
        wVugYaRuUoNAVTcgoN5OTCz4MPKm/ULG9Id8mGv3MpgzLuyGGRJ6eYfB915OVkht
        How/LGRD1U3mDR30KUdHOcAMTaDvylG7HnDR3UK/oiguVB/NIlTowQJxy6XvPj4y
        FQrpX/NinPvifIZiSEv6H8KrpPmuC3yqrI1TrSinhDI6pU6VxQYN1q6Kbolcw7Vs
        H7hHHLLE+B74V06LRdmAjyor4H+yxHANHxMuyKvwCKappKCrwEPrZvIZGHFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676878712; x=1676965112; bh=7r4F4wjq4xOOpqhA10zqcDMNrv7S
        vi1fbEi0S0B4BVc=; b=HdWmfbt07dKq2TPWzLkOzi6eN6k7Yue2/+0gjOPEtXYy
        DFE6N2uLDlHnwk11eUsntYtNbO+bY/NvEfggWd1i/hlhHQIZLSsyM+fBArah3mU9
        CsxO94EBN13SkJGE+WzuBEiUCIXUtSYFbELBJvVYxCq8Az+0YUQX6xXGuD7kweOG
        fWM/PWS9YO/PGyxXC0JPwQVSKpXOyE5ee3LSyXTi4cSZinTRksNGNmGJId9Xxl6o
        iR1ahxG+4NxqYlqaM5K4pVEwCzccmcvSrYQNeG03k3GeLX4T5nGK2hcOmxofYhJx
        mPMrCBoHB1jMtYDFb1ABWs4nY4y8HM3NZyQUAixFnw==
X-ME-Sender: <xms:eCPzY9w4ByKAlAhVjKy_yGeJOokJ_UM-EnOd91ToCHD4CuWE8mnqMw>
    <xme:eCPzY9T57nRiDzt75IXZ9p_M-V3FYb9CVeSG0F4bHJX6ukU9y1u0dVZVZrOUdABYB
    rK3RFDUywfC1IVyig>
X-ME-Received: <xmr:eCPzY3UvBZ2Fb9g41cXra-hTl6KtRfRiJWZVBQa5pnTSMYaRRbHJcYMINgzdeOjEf61MjmLEdn87NwOTFrx_7Zp5mD70XbJB3QsPa9S62IM1FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejgedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:eCPzY_i-l_4IW1oShUL9r1IfmO3rZHBQJ8f8Ir4ooUa_rJUnB9SPUg>
    <xmx:eCPzY_DjEhWi2zGRZZhomv1kRZ0Y8QcxjZKm5zpDzOwGKcqgE5f5iQ>
    <xmx:eCPzY4JJ-7N84VXoqMD1YUkXg4NkU9jgHMkl24uq2OOu37RQ3fo-1A>
    <xmx:eCPzYyrmWiUoYBj8rENo7Cvk1Ej5f6B-ywX39hxXqlPlF7RXApV4Jg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Feb 2023 02:38:31 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d82c6da1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Feb 2023 07:38:26 +0000 (UTC)
Date:   Mon, 20 Feb 2023 08:38:29 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] delta-islands: fix segfault when freeing island marks
Message-ID: <Y/MjdRq2dTbqh0a/@ncase>
References: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
 <xmqqfsb5qzqj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pfWf6zrcL7hDQ6dY"
Content-Disposition: inline
In-Reply-To: <xmqqfsb5qzqj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pfWf6zrcL7hDQ6dY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 09:36:20AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In 647982bb71 (delta-islands: free island_marks and bitmaps, 2023-02-03)
> > we have introduced logic to free `island_marks` in order to reduce heap
> > memory usage in git-pack-objects(1). This commit is causing segfaults in
> > the case where this Git command does not load delta islands at all, e.g.
> > when reading object IDs from standard input. One such crash can be hit
> > when using repacking multi-pack-indices with delta islands enabled.
> >
> > The root cause of this bug is that we unconditionally dereference the
> > `island_marks` variable even in the case where it is a `NULL` pointer,
> > which is fixed by making it conditional. Note that we still leave the
> > logic in place to set the pointer to `-1` to detect use-after-free bugs
> > even when there are no loaded island marks at all.
> > ---
>=20
> Missing sign-off?

Oops, right. Please feel free to add it when pulling:

    Signed-off-by: Patrick Steinhardt <ps@pks.im>

If you prefer I'd also be happy to send another iteration of this patch,
potentially including a direct test for git-pack-objects(1). I'm still
not sure whether it'd be worth it though given that it's implicitly
covered by the higher-level test that checks for the segfault by using
git-multi-pack-index(1).

Patrick

--pfWf6zrcL7hDQ6dY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmPzI3QACgkQVbJhu7ck
PpQTtA//TN21J6jwO5QJUlvb0ddLxR8sXkJxhCEY3l2ghPLhhXQ/3EMHj1pN22mZ
/V8zu3HtRAP53JO4W9aSz5siapPA+BrMDQyGbn4bcn7gYl9EVm497QD5NZlTNr+s
tDbe2blvsFxfNwpZRKSrOfMZlRXYF5uXY3Jt+3WH/AgsjfbEQBur4pgzalbaD4NF
lLQwN3mBJzTASi8VjwigOxEvwdWxQdmBiwSmU4Q//CMlhGWm/xs3mzcjnbBPFMh7
AuWvafKJY6jJXgpVkyiHwfADXOMbyP7ZymSuFQWdavUcZHAaEoCVGKD3ciFUAVTO
A8DEYLBCgk7v4KF01Nv6Q0ck13K1a7VbbBcoij7O+X7/HhqIZS6XoXTiqbw0fpe0
OgLQZxjA728wR3998toaqAxv0jWx/35O6DjDnM2n/sRIGI2fo46cllKyZGxP60r+
8zwoampQWaahYy0RL784FP3mGXyC70YwijMfn18xZPbareZgupf9bRqm28cBqi27
98eu3Ju86oaDFsRTPnoisXIo4gSOUAWFaSqCUCKlKIvBCJYMRMPn6T1SDWDzSBL7
mgit9eLlxOcEHuI3We20iAecO11upsOGQslMp+5jbkTRXWwey1jtqAzUeNlj5Gu7
UBTiidgLy7pyuPYFd9eBhMAUr3yPiYMAfLF6u97dqqFOUYh13Rg=
=MPgT
-----END PGP SIGNATURE-----

--pfWf6zrcL7hDQ6dY--
