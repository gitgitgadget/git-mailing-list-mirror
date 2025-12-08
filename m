Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601C269D18
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218447; cv=none; b=gzVKQAyg+QetbWtehpm7BsT7O325ZndY2Lw04ElMhlpZ/gSp9bY8s0mSWnJhQ29B4W1rcasWAhjbK4FJVABnzU4j8TOEwnCNpCzrnOQKQqgJ0dELBmEvrdSDjnwr4W5GUc9eJO+xB0c8dxp1lBscUNsaA78u5C7esiQhMB3oKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218447; c=relaxed/simple;
	bh=8G/0B7Rz9/nHW7t8+INtr2KG1rt440ExaSG+jwjggEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRTm88koZAvsgbWixgo0835TAUKOQGzJOr+MzlDgdDA3Q26KOGNoyoJm8n4VfP98rNzkK/+Mi1m+FAVi86XWxMVkkn07dI8HQW4MuQQhuDg3qbQCf6u3SP6XaaqPM0hn4/yNEKWmBobybtnoACiMvDdJ8cVqT0sQ7tcHg556heI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i9H7d44P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=paOSl1XM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i9H7d44P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="paOSl1XM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C3E9CEC0084;
	Mon,  8 Dec 2025 13:27:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 08 Dec 2025 13:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765218444; x=1765304844; bh=15fsMOT7ZG
	6buVkUcTShZF+D6Zizbthul6uZjI/jbVw=; b=i9H7d44PRF+i4MJl9QtHMd7i/h
	ncttSIKPpFXJZtqOImMyW5JJAiBLpQX+qSrkyKcpfJ7txz1sTwDYxXvIharfpM2N
	fGzuzcKCAptYllmn3qbxE+G9B2VQS+dxuk34JxVJ2QUn6R7aK0Bl3NOfnyb2MRgd
	VhN1VUssZWHIONRPQ0ucp4QDwz+99DyUxZFRD+S+I+VvlEc/TxCzdOVSqkGJY86g
	azM4/GSG7reAJgZ3IOQ+sC8pcS7cXNCzco3MfeZ7s1qEd+AfLUjfFQp68hsulGTv
	Nqz2xwWzdpM6ZHXD5aiJjSxSOlWMZYRkhi/Rw0R5Ug9oUIEC2SWtKLTkSO+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765218444; x=1765304844; bh=15fsMOT7ZG6buVkUcTShZF+D6Zizbthul6u
	ZjI/jbVw=; b=paOSl1XMoMryrG3T0CCY3dn0+oxehsgKJ6/1nLHUjgeJi12Qjab
	7jjN9kpA7yrhBXgbEeAGz3Go3KC6qnNaop/+dC/Ye/mfOh5q5Sc9zQdf6Uei8ZQE
	XpVIJLVdALWeuzj3MVoIkh/ei/EnE9XsbkCXho0IrL3Ojrp5v9WJ3vmJl1F9nWfZ
	B/nY53jlS1uWFg6MAiKe/gq/SNrlFgagYhKP1cHUajy7SVma70fsDVFl49jKb5Eo
	6npt65uWUKZW4guIjcoLplT9zqaPsUSp651wIKft/wgzr+KYpeQRvIyWZRe0hcMn
	GD0Y3tjwg94NXkqdUqwHkc0C/9cdb1rpBUg==
X-ME-Sender: <xms:jBg3aVPFJ5nccHHBpreHq3eu_buXW-7ZDhUOlpbLYmE83kcWRm0dvA>
    <xme:jBg3ae186O7R43Xh3DTw5cZdGuhDiy2XPwnZd99ZMA_hEn3Fa68901odThUxaYPP3
    P11cfe5pIVZyl-DwVj2-IbtT1CfcVXk3RKVIMl8ikqiXjraWcArNfs>
X-ME-Received: <xmr:jBg3acmxyOwbdGUT9F14utlzIXKYC4rZQyZllTgEsV9hDVGqSLwU4JCfUfOiFQfqEuFjXgq1hWMb3iulYrxZlTueI_JxXARp6SHMFzIrKjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:jBg3adVyG9obzs8CYj03vh_g7lnqXhqRNAKjmWfqraOkcgr0gU5nUQ>
    <xmx:jBg3aav_TE6IGaMNwiLcqjH-8Q61YaJ7JYlcS4nEAFV0K3btOlAEDg>
    <xmx:jBg3aYbXHITjAKOjJkCQ-k3rluBFKRV92s3zXKdIDuMlPI9jcniiiw>
    <xmx:jBg3aRVwq2M9eqcNQ9YecAe2UxgUXO4my4oLzPYgtuhkTFtKeaIX0g>
    <xmx:jBg3aZ2CN2mxWg10vE8r-q9DhVHNnpKvmIz9RH1vclBuj14dBpjWm1uK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:27:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8c8e4d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:27:22 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:27:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/17] t/helper/test-read-midx.c: plug memory leak when
 selecting layer
Message-ID: <aTcYhKOIu7ebJ_xV@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <43ef3d0013f1534c7ff8b1a7c4a17fb0c9b68684.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ef3d0013f1534c7ff8b1a7c4a17fb0c9b68684.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:43PM -0500, Taylor Blau wrote:
> diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
> index dee603b3cd0..6e03aabca79 100644
> --- a/t/helper/test-read-midx.c
> +++ b/t/helper/test-read-midx.c
> @@ -26,9 +26,10 @@ static int read_midx_file(const char *object_dir, const char *checksum,
>  			  int show_objects)
>  {
>  	uint32_t i;
> -	struct multi_pack_index *m;
> +	struct multi_pack_index *m, *tip;
> +	int ret = 0;
>  
> -	m = setup_midx(object_dir);
> +	m = tip = setup_midx(object_dir);
>  
>  	if (!m)
>  		return 1;

I was briefly wondering whether we should also convert this into a `goto
out`. It's of course not required, as setting up the MIDX has just
failed. But it would simplfy things a bit as we now have a single exit
path, only.

I don't mind this too much though.

> @@ -36,8 +37,11 @@ static int read_midx_file(const char *object_dir, const char *checksum,
>  	if (checksum) {
>  		while (m && strcmp(get_midx_checksum(m), checksum))
>  			m = m->base_midx;
> -		if (!m)
> -			return 1;
> +		if (!m) {
> +			ret = error(_("could not find MIDX with checksum %s"),
> +				    checksum);
> +			goto out;
> +		}
>  	}
>  
>  	printf("header: %08x %d %d %d %d\n",

We change the return code from 1 to -1, but that ultimately shouldn't
matter much.

I'll stop reviewing here and will have a look at the remaining two
patches with some fresh eyes. But so far this was a nice read, thanks!

Patrick
