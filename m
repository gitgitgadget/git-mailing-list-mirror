Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C331DFCE
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996394; cv=none; b=TxBgcozvOh79/aZwc1bDk7PINUNmI+lxLNn74vRFeraNWIEOHmbjvQwTJbnEQ39UV4NkOPMrerBifra/c0EbBZBmLAh7okGqnq4qNnJNn7pIHCkpnYDAEFjZKrROXb2tahrca1BOoxHwAq56d+Qx1n8rD8PZUsliL618MEFYP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996394; c=relaxed/simple;
	bh=yrlRcs+s9+jh1wZYUgmFcXIRFiuGFM/H2WLtDeFymqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poqsGvoTC+hLs8UYmFN9YPBQh6fBPK1Av4VC1tZNIPciwe3ZpTJuCCr8ECX6W18wKDfL3UUcT0R+5hTrMSSIVtaWACU/+0Zr4w3G6xiuhdXcsInW/jLpWmoJPVdMdoCFxZ2Ne5mTcoOb1FWI/v4rJEvPH4nW8nTOSvbXRF1wjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OCAX0DP0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Za3+Bd8K; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OCAX0DP0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Za3+Bd8K"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id C7CB11C00146;
	Mon,  6 May 2024 07:53:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 06 May 2024 07:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714996391; x=1715082791; bh=lt6Cbl9PLg
	aIS4ueCuh9XXEbVU465aCgYpEjBK2m4BM=; b=OCAX0DP04BRwSMrhd1VbGiOyh4
	1JPoGROBF9g2mRzZmakcRy2fatKppppwosnTgaDXYS6KNzrBw6MZpEAu8KeCam6R
	HOtk1psXkaZMKAavN3/kAxxE7ADduE6I0yxAbO1CF38AFppNrCxwwkZ4w8noQIFg
	3dkYkTtkZj9PJKbH2dkxFN3QsV+A6rgJ0pjZfXaB39Yq8gdz3ApbvU5cPbkhmifx
	AX9AUrpwD9u0BPKbfVofBZUi19Bp6MnZqCgZlgLppqVDbvm6apPtJn813mL7/yAg
	rvf2NSlqI/tYfFE1nzByIW/x1WZd0KfTjec0gM4zzxW7nstjCw4+YuWLNpnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714996391; x=1715082791; bh=lt6Cbl9PLgaIS4ueCuh9XXEbVU46
	5aCgYpEjBK2m4BM=; b=Za3+Bd8KD/CnaHKExBd1cBlsOPhO/H0GNI2jQao04xpe
	6ePtla98QJAh99Y78NFN71iqX8WlRKn+D5MLrqgdZ0/IQqVGRn3euCK8DiXEaDTE
	JzHLWXMhMn0Wbk2J8FzaKCxQsFob4PY/qOEitFB4xXE/L4DiOwdnR8zPFi5y97qi
	BVIf3Ut9Y6GtYGhwHr8wi9wqQpjOSWW7yp/Yxyw3d2mjSNDezYzwn43IpIlIhRwb
	WPhhSqP/hdMCHcSPWjXoyUB/VVvSx9j4fFnMCtXfGsWCjav9J41QaA0I8DiBoJX3
	sXLzrNO+JrrIu8CVB5Sj5V1sqM6zZFh1Vqs+6yc1VA==
X-ME-Sender: <xms:p8Q4ZnzCsRWmllrwhgkmIO3xotuWeeq_UcVqnj8oyZVa2PaNnjWPJw>
    <xme:p8Q4ZvRSsQu3YsCY3sEXYB9n1xO-ojTeLWADofyNyJAwGbclwMrKl9zb7iMf6ii_7
    DZlSFABOpqSFNb3fw>
X-ME-Received: <xmr:p8Q4ZhXiV1NXsFBdBzgtzP4aXbrjxZATLxj7ZbDbDgt9Qi91SFMlwRBgftKBTwuE1VbQInzfY3MbTeqQ1qwvXmAvc6nNcJVDXAMwQUR72v1OPKSq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:p8Q4ZhiNyVcTJX5Rf3wp7xFWU7GtAaw-U4a8Xl7LXVM1qPwayAlQNA>
    <xmx:p8Q4ZpBn-JMrLkAn78a-ibCizW1j1LmRFx9EAIB4uPHaOd59_9hXKQ>
    <xmx:p8Q4ZqIUdgcnn0y4SUO9ciLO-sGT5nASWMBCFOoW1cwRUqh-UgUoNQ>
    <xmx:p8Q4ZoDmxTfPybjGJLk8F4VjKA-Mnycd3fzy_nvdUZGwhTC9MefMSw>
    <xmx:p8Q4Zs7yDqe-Ic9l29njEklCJdSegPHXUlxz5wisLZ17ncylbYHnWCfK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 07:53:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6ed68d48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 11:53:03 +0000 (UTC)
Date: Mon, 6 May 2024 13:53:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/23] pack-bitmap-write.c: select pseudo-merge commits
Message-ID: <ZjjEo8XU5hPPQSYf@tanuki>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <12b432e3a8adcda6228beae2b41b2363a6ce82a0.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KW9eeTczx35lGoYN"
Content-Disposition: inline
In-Reply-To: <12b432e3a8adcda6228beae2b41b2363a6ce82a0.1714422410.git.me@ttaylorr.com>


--KW9eeTczx35lGoYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 04:43:41PM -0400, Taylor Blau wrote:
[snip]
> diff --git a/Documentation/config/bitmap-pseudo-merge.txt b/Documentation/config/bitmap-pseudo-merge.txt
> new file mode 100644
> index 00000000000..90b72522046
> --- /dev/null
> +++ b/Documentation/config/bitmap-pseudo-merge.txt
> @@ -0,0 +1,75 @@
> +bitmapPseudoMerge.<name>.pattern::
> +	Regular expression used to match reference names. Commits
> +	pointed to by references matching this pattern (and meeting
> +	the below criteria, like `bitmapPseudoMerge.<name>.sampleRate`
> +	and `bitmapPseudoMerge.<name>.threshold`) will be considered
> +	for inclusion in a pseudo-merge bitmap.
> ++
> +Commits are grouped into pseudo-merge groups based on whether or not
> +any reference(s) that point at a given commit match the pattern, which
> +is an extended regular expression.
> ++
> +Within a pseudo-merge group, commits may be further grouped into
> +sub-groups based on the capture groups in the pattern. These
> +sub-groupings are formed from the regular expressions by concatenating
> +any capture groups from the regular expression, with a '-' dash in
> +between.
> ++
> +For example, if the pattern is `refs/tags/`, then all tags (provided
> +they meet the below criteria) will be considered candidates for the
> +same pseudo-merge group. However, if the pattern is instead
> +`refs/remotes/([0-9])+/tags/`, then tags from different remotes will
> +be grouped into separate pseudo-merge groups, based on the remote
> +number.
> +
> +bitmapPseudoMerge.<name>.decay::
> +	Determines the rate at which consecutive pseudo-merge bitmap
> +	groups decrease in size. Must be non-negative. This parameter
> +	can be thought of as `k` in the function `f(n) = C *
> +	n^(-k/100)`, where `f(n)` is the size of the `n`th group.
> ++
> +Setting the decay rate equal to `0` will cause all groups to be the
> +same size. Setting the decay rate equal to `100` will cause the `n`th
> +group to be `1/n` the size of the initial group.  Higher values of the
> +decay rate cause consecutive groups to shrink at an increasing rate.
> +The default is `100`.
> +
> +bitmapPseudoMerge.<name>.sampleRate::
> +	Determines the proportion of non-bitmapped commits (among
> +	reference tips) which are selected for inclusion in an
> +	unstable pseudo-merge bitmap. Must be between `0` and `100`
> +	(inclusive). The default is `100`.

I think for this config to be actionable for anybody we need to explain
what "unstable" or "stable" bitmaps are and what the tradeoff is that
the user needs to pick here. Like, why would I want to set this higher
or lower than the default value, or modify it at all?

I think the same is true for most of the other parts of the docs here,
as well. We explain what those configs do, but basically leave the
reader on their own to figure out what the real-world consequences are
and why they would even want to configure those in the first place.

I spent quite some time on this series now, so I'll stop reading at this
point. Thanks!

Patrick

--KW9eeTczx35lGoYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4xKIACgkQVbJhu7ck
PpREkA//fBxLKmJoDKictODpIbD+QrAwVWJYIG70Jcw+KD/0ZzW7JmrzkRBLJzOm
Glvg+38eYxJNfElypVNxhl1U3W/dz9cM/9RLoTbxCEgXPgmcEKMUxrah5S0aKBX4
NzJctfKMWSN+z4UNEIVY4viU3hLv8XEJWGJ/BS1eGMvkHveWQaoRMege2WOeA4Jo
lKFO7pOajlkuQifdRtH3jq+e5aRvXoMXO2zo+HX3Da6YDhOSrc136LejuTpcXl0U
2L3hwqQJRIP7FnoNpdICvEvi5b8S0DMnCZ6l3VUDD4EtOdnkpiPTVhKgKRfFBTJk
7KLSk4vtnzcTVQ37IwO32ZTH0Kx4Fzq56SnYD4G2f6bMr51GAsynjRdevZn87H0U
73AjScw2JXQK1mGfHKiozSvHqB4NTeF7w0+7wLS1/EjtxfCdDiUSiGYC+Ugtl2u5
enUffUL/cCEc6IpcJHctEgwkleLPU2Ol0fA+Ep2CtQCyQOevNX9Ky+LhC46gnNGP
y8f6Sm3LBBOg0XZy+aXxquNr0r8bhYls7Jh84yIfhDrp0p2mmjcD82rm0IRhn+PR
sBHJlGBar7LIiDldcqvDOg/yQmjEKe7+gKpsiM+pM/k2q+cTza98GdzDIuOkWufW
/w2EqLrBO/a0DSrTBuktqawKbb7/KVLUxDGMMWGlspLwFRHcxd4=
=7UvY
-----END PGP SIGNATURE-----

--KW9eeTczx35lGoYN--
