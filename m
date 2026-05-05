Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B782194C96
	for <git@vger.kernel.org>; Tue,  5 May 2026 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960971; cv=none; b=dKwZPE/aVqwajJoKIauMI+COJ4oGSFY4RuGmlTp7wLp4XqZ3ce1w02rU/31y2XWnGueiBkN2MV4l60soZNW0gPY9XY2IDOGLZLkSazVZw/2N8P/sfwdxCuO9X1RcgnIwWsWNwJKDV3qVkfXVx1iLJJRlwKGLrq7Pn1Hr76hvZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960971; c=relaxed/simple;
	bh=1Qi5MBCx1hdTlnStczr3lXdRfmDPw++kSmAN9C+ygXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D391e7W4C3o05OUyCnsGfTAvvXnNqMc/lF3JePTnjvX3XU8Ea+DkHIGKmn+zK4a3s7cCSONw9RVlxFc0iBad0CUvNxvpSvSYTdSpAFeaXIVmBW92xyy3ZNg+ydpya6l7rNDOk1RY9rMJiPHc1UcqQgHv1BMNBRiPe9SaZqwTjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bZMxB1z8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PvQkMdBl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZMxB1z8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PvQkMdBl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 55FEA7A0047;
	Tue,  5 May 2026 02:02:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 05 May 2026 02:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1777960969; x=1778047369; bh=mbNZKNonve
	aaFW+3nkWzqjevgInT2powGvxZWizuHLg=; b=bZMxB1z8cqwcgRAe3RS3x8eocj
	nO/PS9rsmKDuai6POoTOlMXW92ExKA/5H6qz/fyDqTdZbxLoqtj11V45AQSEaeeX
	FPkTB+5tOLcne1MKZULmUn0XEETGrQp5W6SYp3v+EJrFGdBeW5e9HI1P0d+VKymU
	7vaE85LeOc+EI+qMBN9HJJZPOCZREMbaurpV0hq93MeumATYIB7jxVFly5AwLRay
	2kXjs0xh5gyUqRIacGd3k3pQiir1r0/TK7RDCXNKGICdY958cXY6TSJ9K7UYMTql
	yZkFXFw4iwUhWOpOQNOyjfMOerBd/+c27B6OeTCpKrP1Vy8WG5kMJ+K/9RIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777960969; x=1778047369; bh=mbNZKNonveaaFW+3nkWzqjevgInT2powGvx
	ZWizuHLg=; b=PvQkMdBl6U8Ucuay2+5TyOjIEasj5RM3NwFa0V9v6TzttAn9lTg
	YL1APJUsiu4CyIOEcCM10vaC1DdL1Ix0AwcmB4IvAZdoDfAiSz5csWJhinKUqsGN
	mYtoFTuFm5vh5a+VTGiFj3qfkTtIw6tLZgr7tr4zSyhv2RbZ3900XjEqks3G71U1
	g+aE/391QdpAgf3SifX9uTxN8C0xkEMivv/7saHmnY46GGYypRyyZZcOJ1FWL+hM
	njkZ9Y2EVduinNCkNBfe7wD5lkqD6mzmfp9Jv2a13MLZb96BxpHoNKLDRZKih3rq
	z0yh1Z46t3dORgcXxgRl2uep/R30EMsyhjw==
X-ME-Sender: <xms:CIj5aQT0nP9Op0ZJU6C5__y6_xbIa7cpgPENtaC-Rwn0k6_x-y9w9w>
    <xme:CIj5aVN1kfbZshBgOxACWrIc7GdyVbvGwnmZ_9t3OCYzoI2lRI2IGHelAa18cLtvF
    4erQd6UwRsXuuFN2s_LWQdNL2vpT3KzXLb9OQGvJpBEu3iIU61kqQ>
X-ME-Received: <xmr:CIj5abOOWQLnpglMj-28XwQpcuRlHStTbra5tJWFndLSHH7POIjMxVcAMCoEAhBD1NkGv6LlE8Bf_5g0a0lcCFzlLU3UwsmACDJLlEbazA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddtleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjohgvrhhgsehthh
    grlhhhvghimhdrihhopdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:CIj5adsXJSbUxAHArkoJXMbf5Ef0e9VboYJFa5wy4ceAjlNNol2UMg>
    <xmx:CIj5adVlf-MvUw4WXFvjbNzKcA8wJl-4T1rNq3u0ROSSX_VuZcU1rA>
    <xmx:CIj5ads6qfMDm8KETIg-kYNJpOtrdBVR3yRCcA_tEIuqXh9GReNmAA>
    <xmx:CIj5aRXbpWOf2Q2bsXgctK8ctB07LhjyXfPU0Pz3ib5XCdHv5mRkKQ>
    <xmx:CYj5afaLWt7icEnut0_jsNEeS92gPpcl_ctG4FuS9FjPsBPB5IzupjCy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 02:02:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 404a02aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 May 2026 06:02:46 +0000 (UTC)
Date: Tue, 5 May 2026 08:02:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Joerg Thalheim <joerg@thalheim.io>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7703: ignore 'total' line when comparing ls -l output
Message-ID: <afmIAxNKOlRCxwKn@pks.im>
References: <20260504101429.340123-1-joerg@thalheim.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504101429.340123-1-joerg@thalheim.io>

On Mon, May 04, 2026 at 12:14:29PM +0200, Joerg Thalheim wrote:
> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> index 04d5d8fc33..9b5a428620 100755
> --- a/t/t7703-repack-geometric.sh
> +++ b/t/t7703-repack-geometric.sh
> @@ -299,9 +299,9 @@ test_expect_success '--geometric --write-midx retains up-to-date MIDX without bi
>  		test_path_is_file .git/objects/pack/multi-pack-index &&
>  		test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
>  
> -		ls -l .git/objects/pack/ >expect &&
> +		ls -l .git/objects/pack/ | sed 1d >expect &&
>  		git repack --geometric=2 --write-midx --no-write-bitmap-index &&
> -		ls -l .git/objects/pack/ >actual &&
> +		ls -l .git/objects/pack/ | sed 1d >actual &&
>  		test_cmp expect actual
>  	)
>  '
> @@ -316,9 +316,9 @@ test_expect_success '--geometric --write-midx retains up-to-date MIDX with bitma
>  	test_path_is_file repo/.git/objects/pack/multi-pack-index &&
>  	test-tool chmtime =0 repo/.git/objects/pack/multi-pack-index &&
>  
> -	ls -l repo/.git/objects/pack/ >expect &&
> +	ls -l repo/.git/objects/pack/ | sed 1d >expect &&
>  	git -C repo repack --geometric=2 --write-midx --write-bitmap-index &&
> -	ls -l repo/.git/objects/pack/ >actual &&
> +	ls -l repo/.git/objects/pack/ | sed 1d >actual &&
>  	test_cmp expect actual
>  '

Hm. So all we're interested in is the mtime of these files as an
indicator whether they have been rewritten or not. I don't think there's
an easy, portable via POSIX tooling to retrieve that. But we don't need
it, because our test-tool already supports this functionality:

    $ test-tool chmtime --get <files>

So how about we do the below patch instead?

Thanks!

Patrick

diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 04d5d8fc33..ec7032bf5d 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -299,9 +299,9 @@ test_expect_success '--geometric --write-midx retains up-to-date MIDX without bi
 		test_path_is_file .git/objects/pack/multi-pack-index &&
 		test-tool chmtime =0 .git/objects/pack/multi-pack-index &&
 
-		ls -l .git/objects/pack/ >expect &&
+		test-tool chmtime --get .git/objects/pack/* >expect &&
 		git repack --geometric=2 --write-midx --no-write-bitmap-index &&
-		ls -l .git/objects/pack/ >actual &&
+		test-tool chmtime --get .git/objects/pack/* >actual &&
 		test_cmp expect actual
 	)
 '
@@ -316,9 +316,9 @@ test_expect_success '--geometric --write-midx retains up-to-date MIDX with bitma
 	test_path_is_file repo/.git/objects/pack/multi-pack-index &&
 	test-tool chmtime =0 repo/.git/objects/pack/multi-pack-index &&
 
-	ls -l repo/.git/objects/pack/ >expect &&
+	test-tool chmtime --get repo/.git/objects/pack/* >expect &&
 	git -C repo repack --geometric=2 --write-midx --write-bitmap-index &&
-	ls -l repo/.git/objects/pack/ >actual &&
+	test-tool chmtime --get repo/.git/objects/pack/* >actual &&
 	test_cmp expect actual
 '
