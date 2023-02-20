Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FBFC636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 07:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBTHe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 02:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBTHez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 02:34:55 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F88CC24
        for <git@vger.kernel.org>; Sun, 19 Feb 2023 23:34:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6693A3200D73;
        Mon, 20 Feb 2023 02:34:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 20 Feb 2023 02:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676878493; x=1676964893; bh=mm0ijSqDai
        IoaP+/HyCNJO0bgqGoGaElFDAgnUKMYP4=; b=QhpFZnxb8yXPdxhAcZbkl0/TDw
        vVyGfFOb2GfhN2xn+7ymgJUX5Ji8qxSVYV4LXrGzWoTkybV2ofPdmnt9jMQng7Dw
        GWCtN8p06zvIR33rzaNBtU1bsHjNSL4mNBKBikWQJkBaRj9HRbnAf7sY9L/cX1ca
        8TWAFU21ZUtz35169XE232Ju33ZnuMJCbVfEH7COdIZ/Gmm1XINZMHfdUi9SQTcZ
        k30MCtuInqnHRL/OxsHyE4YTuuBI4oAIEcifXyCp1m3HzhxjrY2bwI0vZ01OblnF
        yaqxdrn7JMeyqaA5s3pAc80ZWX5ZslPLTbruNRX0te+WD8blUd8Lz8L6Bt0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676878493; x=1676964893; bh=mm0ijSqDaiIoaP+/HyCNJO0bgqGo
        GaElFDAgnUKMYP4=; b=MF1+gdVLaJNj2zOHpsb7oy2/W/ne4WnuN/R7boYjnMdq
        P9+ft6QuR3LmWxcSxWpCfKqDfrZ7BHsg1gJAW/kZSiDxgeqOJXAWj1rTWDvoQrVd
        e6vssYHGNa16O8gPoXFHQSHG90XIYqhUaDhgt7nEv+eeSGhTeyZyXkEk9viozg6d
        e0X2RQ+vvMNuTe0JKVqjecdpHCmJVJJTHtcvLDSL37ZBE0KPGY3G/2ct/94XgQDh
        EUPiKEVi8kxhJvLsEzrHvxE6tKsluHnUwMvbN9T32D2R/JH5xpcst3f09NJzTkkI
        ZQt0tOrTmIp7b/zu5WHmAUOJyPP7RmeFsZ/yCN+U6g==
X-ME-Sender: <xms:nCLzYyLgacv6sMHdEm3t0S6tM7ATajb3KFFBafkuVpNnjnj3Mf6Elg>
    <xme:nCLzY6IWwR7t-fzezzJ4bNzN5BIgVkLSkv8HdRq6IsoABt3ieiyH4x1Gg2lWaphrt
    l8gdZKoy9JrLTYRtg>
X-ME-Received: <xmr:nCLzYyuHROOxBbxzGwix_8mQrZrMy9tK4DAGSKEYrn9_xYI1JONzA_oKwNMMd6tG0JCvzg-R4vLzHXlio8UUug85VdpjIWD20w2lHcVhYEAlxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejgedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nCLzY3abJYCIq-7OErvr_440hkbVqMpENT3jG_kLB1jSVWGsDmLxsA>
    <xmx:nCLzY5b5ujqXdVxfx_kGiV-ifNmZxe6nciqQia09MO-6GO6jniGB0g>
    <xmx:nCLzYzClB6kyZPaJsUKAJ1MqKNnEDG-LV_BANOHUApGHhHOATVADBA>
    <xmx:nSLzY6A-TUII3fj6BtVMMYixt6Vu2sLA5yrwYgaAUEatg7-k2fq3-g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Feb 2023 02:34:51 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 705568a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Feb 2023 07:34:42 +0000 (UTC)
Date:   Mon, 20 Feb 2023 08:34:45 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] delta-islands: fix segfault when freeing island marks
Message-ID: <Y/MilQXhFTcoefyT@ncase>
References: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
 <xmqqbkltqykk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ur2Y6e2fu89ibYiE"
Content-Disposition: inline
In-Reply-To: <xmqqbkltqykk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ur2Y6e2fu89ibYiE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 10:01:31AM -0800, Junio C Hamano wrote:
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
>=20
> There still are unprotected uses of island_marks in delta-islands.c
> after this patch, but I think they are safe.
>=20
>  * The callchain deduplicate_islands() -> mark_remote_island_1() ->
>    create_or_get_island_marks() assume island_marks is not NULL, and
>    the only caller of deduplicate_islands(), load_delta_islands(),
>    initializes island_marks() before calling into it.
>=20
>  * set_island_marks() assumes island_marks is not NULL.  One of its
>    two callers, resolve_tree_islands() ensures island_marks is not
>    NULL before proceeding.  The other one, propagate_island_marks(),
>    also assumes island_marks is not NULL, and is called only from
>    pack-objects.c::show_commit() when use_delta_islands is set.  It
>    is not apparent if island_marks has already populated when this
>    happens, though.
>=20
> I think early in the pack-objects process, prepare_pack() calls
> resolve_tree_islands() but as we have seen, it just punts when
> island_marks is NULL, and not populates.  But get_object_list()
> explicitly calls load_delta_islands() when use_delta_islands is
> set, and that happens way before prepare_pack() gets called, so we
> should be safe.
>=20
> Thanks.

Agreed. I also had a look at the other usages of `island_marks` and
couldn't find any obvious way to access it without it being initialized.

Patrick

--ur2Y6e2fu89ibYiE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmPzIpQACgkQVbJhu7ck
PpSkLw/+Msfpx3x3fP7dJKUxuS51Qp+Uu5g4+upy1vuPsdyEbKN/RNEkKTWbpKxp
FyCgfPL7Bwf88UIsFli7g0+mhZVYuTxFG3OCInbti6ZeST5505VWchIqmhF9POBN
9P0FVlHvKqNtxXcq81PF8Tm8j3aEL8nUNBIe0qYu9VnOLvR3hyVLzs14Mxg53R9E
6IVc60EVKXbwa1cdTmodbFJMlFYKHP5O/WXcho12V33cQcWGFUIEnFjQZgJSwwX3
eAkmL7G1paQ5GS+/If1/YR9R4mjhY3QNfkOd2W3+anX48fN3v9nDjEq7g2lrRoxI
MuLLxsHBb56raKhL7ByefPWyF96QNfHq+Gche1++jHnHRDN75963WitSKrzTTEXb
MvHBp+yQZla+dIQtTg2VHKsR1MjaPtb40NpHMLIoqZHkzciW9ZGdvmLWEo6PdF4V
gh81+MW68AcqkKX0oxvaepovmk/fxVKN7mjWdlWPTlWIFp8dcJ2fCi06g9NuDbqx
2H9r7vny6tDdJkYxab1JfvfZStkb4mNM6w2EGAazLf+13o7586Qu9RFLXeT3+m5p
XmXzyq1oJ+LDowkdXOyunCuVVvL/5Dq+KfNfGshccNqEgKGTaeGMf4I8aEA6fG1u
QT9BqHkkrzGDUAvP8XLdRv+dCuCsr6Z/XHTM+SFsI+NroOPcO6g=
=0Eg3
-----END PGP SIGNATURE-----

--ur2Y6e2fu89ibYiE--
