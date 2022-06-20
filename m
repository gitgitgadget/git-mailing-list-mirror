Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC139C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 07:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiFTHeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 03:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiFTHeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 03:34:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B4EE32
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 00:34:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 26EFB5C0111;
        Mon, 20 Jun 2022 03:34:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Jun 2022 03:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655710455; x=1655796855; bh=W3ZhPips/5
        OXZ2GfBa1fpjjxBaUVj3yWqzxLBtZChXw=; b=Jt9fJtELC59FZ712ekJkdgDVaO
        2osoG4+JiTJ1q6qEFgJgQy2uCk0d7psLGTm+p1tlbaiwxxuN2OP31Eb1Del6yq09
        gAjJGFuVN/vHmOO7DSNH3jBSdgQKOZVkKAlZFfIGVWH985R9iGmDVd1nyqwWTx2d
        cjH+1AcflQEZrkEpNCFaG+MCWs5U0L1HK/V8JaM+IgLnnGiZzUvIF62eAoVnLkvF
        fQfPHzIX2qTXRrgg1wirtVif7Mt7+WNi3sg0gPaIbToCcWdyra5JSRzoCTnI40YV
        ZJGIWckmiiFBuG+9gyF/iDXEsBZfP3Ut8G9Ox+vr2uv2tPiJekFmw5RVDWOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655710455; x=1655796855; bh=W3ZhPips/5OXZ2GfBa1fpjjxBaUV
        j3yWqzxLBtZChXw=; b=jATRQBSQtflFwdoQbS8el8kTMUqDvWybiJJKZ0wgCWE1
        EU0jv6w+QRaiHEIVGBJFMShG1Uzn+MtpqBZpTzU/5ToV0BnGkoII26a9/skdSLk5
        lQozjnKMp01MPEIthTz/5tJ50qxeWvg+IX7U3Sc9ZVQxzij61Idz4Mw+BufWtT8L
        FFeZGHeAm3zAfbB1U8epRQFrC2B1GgTPBK8l/KNdvi9Vij9qkF+ixyWULli5NmMP
        qFsE+Bqsx+DqqNYTlueXijiS1N9wdC1tJ7YfewvU/ukdzEJ3AbNnQXv1naVkMTEN
        ++Yar0KGLlkOROl7mDsl95Vm0D2dlyV9g/58MCfOgQ==
X-ME-Sender: <xms:9iKwYvsRqJo5PukKp-7GiaA5QGe5kSw-OQ1jya95euL-XafOf9uw6A>
    <xme:9iKwYgdGEV_J4hxxDgHz0Iig_19SPIQ2r3M83l7S9tF_RXrplsa4xfHNQRjV5clcb
    a0a6dD58EL4k5YEKA>
X-ME-Received: <xmr:9iKwYixzGZfPY2wMtul3yo2cvg7KJdyLELYtsh9DRy7_FS4e7dhm8F-ZVmBD1CTttOCe0LOZ8DXyAVPZNTzo1LPmO4yFOuWvoPPfV24cSdg_npXUphgyEtIGoHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeftddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepieevkedtgffgleeugfdvledvfedthf
    egueegfeevjeelueefkeegfeffhefglefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:9iKwYuP9wswSWzdv7-kqeVBg-PRNF7nRBKY9xmDgjUZSwAQqTdUr0w>
    <xmx:9iKwYv_Pp4KVPh-IyHNiUxAh3k_k5QDltkHD0UBPn2Ff8ZA6CRJCTA>
    <xmx:9iKwYuVFTcgdx-IAiMfQ-NcKQShdzAdQS10V4Sx9_Cd8z5oZ5vrAfQ>
    <xmx:9yKwYql52sp_tSN_pP9Xt856xykEZ2dSdvOrMY9T_-61r4MZ01YJGw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 03:34:13 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 686d43cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Jun 2022 07:07:25 +0000 (UTC)
Date:   Mon, 20 Jun 2022 09:07:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com
Subject: Re: [PATCH v1] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
Message-ID: <YrAcrNApaZDngLL+@ncase>
References: <cover.1655350442.git.hanxin.hx@bytedance.com>
 <20220618030130.36419-1-hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sa6Wt5dXjCesml9v"
Content-Disposition: inline
In-Reply-To: <20220618030130.36419-1-hanxin.hx@bytedance.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sa6Wt5dXjCesml9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 18, 2022 at 11:01:30AM +0800, Han Xin wrote:
> If a commit is in the commit graph, we would expect the commit to also
> be present. So we should use has_object() instead of
> repo_has_object_file(), which will help us avoid getting into an endless
> loop of lazy fetch.
>=20
> We can see the endless loop issue via this[1].
>=20
> 1. https://lore.kernel.org/git/20220612161707.21807-1-chiyutianyi@gmail.c=
om/
>=20
> Signed-off-by: Han Xin <hanxin.hx@bytedance.com>

Thanks a lot for working on this issue!

> ---
>  commit-graph.c                             |  2 +-
>  t/t5329-no-lazy-fetch-with-commit-graph.sh | 50 ++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5329-no-lazy-fetch-with-commit-graph.sh
>=20
> diff --git a/commit-graph.c b/commit-graph.c
> index 2b52818731..2dd9bcc7ea 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -907,7 +907,7 @@ struct commit *lookup_commit_in_graph(struct reposito=
ry *repo, const struct obje
>  		return NULL;
>  	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
>  		return NULL;
> -	if (!repo_has_object_file(repo, id))
> +	if (!has_object(repo, id, 0))
>  		return NULL;

Agreed, this change makes sense to me.

>  	commit =3D lookup_commit(repo, id);
> diff --git a/t/t5329-no-lazy-fetch-with-commit-graph.sh b/t/t5329-no-lazy=
-fetch-with-commit-graph.sh
> new file mode 100755
> index 0000000000..ea5940b9f1
> --- /dev/null
> +++ b/t/t5329-no-lazy-fetch-with-commit-graph.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +
> +test_description=3D'test for no lazy fetch with the commit-graph'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '

Nit: I find it a bit confusing that you only call the first test case
`setup`, while all the other tests except for the last one are also only
setting up the necessary state.

> +	git init --bare dest.git &&
> +	test_commit one &&
> +	git checkout -b tmp &&
> +	test_commit two &&
> +	git push dest.git --all
> +'
> +
> +test_expect_success 'prepare a alternates repository without commit two'=
 '
>=20
> +	git clone --bare dest.git alternates &&
>=20
> +	oid=3D$(git -C alternates rev-parse refs/heads/tmp) &&
> +	git -C alternates update-ref -d refs/heads/tmp &&
> +	git -C alternates gc --prune=3Dnow &&
> +	pack=3D$(echo alternates/objects/pack/*.pack) &&
> +	git verify-pack -v "$pack" >have &&
> +	! grep "$oid" have
> +'

Instead of going into the low-level details you could just verify that
`git cat-file -e $oid` returns `1`.

> +
> +test_expect_success 'prepare a repository with a commit-graph contains c=
ommit two' '
> +	git init source &&
> +	echo "$(pwd)/dest.git/objects" >source/.git/objects/info/alternates &&
> +	git -C source remote add origin "$(pwd)/dest.git" &&
> +	git -C source config remote.origin.promisor true &&
> +	git -C source config remote.origin.partialclonefilter blob:none &&
> +	# the source repository has the whole refs contains refs/heads/tmp
> +	git -C source fetch origin &&
> +	(
> +		cd source &&
> +		test_commit three &&
> +		git -c gc.writeCommitGraph=3Dtrue gc
> +	)
> +'
> +
> +test_expect_success 'change the alternates of source to that without com=
mit two' '
> +	# now we have a commit-graph in the source repository but without the c=
ommit two
> +	echo "$(pwd)/alternates/objects" >source/.git/objects/info/alternates
> +'
> +
> +test_expect_success 'fetch the missing commit' '
> +	git -C source fetch origin $oid 2>fetch.out &&
> +	grep "$oid" fetch.out
> +'

This test passes even without your fix, albeit a lot slower compared
to with it. Can we somehow cause it to fail reliably so that the test
becomes effective in catching a regression here?

> +test_done
> --=20
> 2.36.1
>=20

Patrick

--sa6Wt5dXjCesml9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmKwHKsACgkQVbJhu7ck
PpRmqg//f15ryJDej7D6RkLRBAhmpZTlV+memmkleRMhg0wvmyWAaIJrpRkGIvrn
q6UhzKuZW5i9i8EOVzxDwibSt+Yd1lr9nEjhSZqcwiYGOXqegZjeVgQ/c1+nYOGH
xuI8LMZwJl0To7Ibbx9bxvOF1ZXDynqBCIJ7Q+tojR+GpmQHhL6UXzvX2TV150eS
+hoy5FfYdYAMFiAaKdEI7UWcUz84ZQr6fuVjnKflcRZuiWUUZjOsdn//34MJ2wxR
c2NmISYgNtcLozMnuYiV3CjJlLryrz3CBQmqNlwW11vGEFjSYwciDIsLTt8pb3Cx
WMzLcPNqHPtWPoq9gn/RImy95r5x051WZk9eqVz2r55liAADkJI4BZcXojwx3xnp
QG0m5JobQ8BIPGSPaH0OEYeoc5U7GzVwkEAD/FeM1P9/IZ/bsKpXq1ZcowpzllcX
WvylTf7yGj8ZCRAGfRpox0azZWSFOfuSK9e/oz7Zlfrap9MSiJ/X8EPUa2qNyy1I
YqHTI3+wfuWnr+2qpWe81sdnMT3n1tDsRDjnZytBRcQVRijY5YksQm/0VrFmjon6
rod9gX+5BCxLqZOV9uHZ6xwUPnRfjhR5n3fMLAr0QnRzHWyMNunMM1SzAIYMOP+K
kD2/RU/lhhWRM1+WfXRT8Iv/p/EyUaTn4asTZ/XHcplAztKeIxM=
=6FYe
-----END PGP SIGNATURE-----

--sa6Wt5dXjCesml9v--
