Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95145013A9
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784202; cv=none; b=evBf91GFo11YsFJAXL9hKeVLW+Yle46zVTC9XLrUTLRdEy77Kn5adOi78pWZUOW9Cs7VeLvmWBP1iJHBS48w8FNKhdohRLWF9YGEcQD3CG2xkwepqHanry6epVCPD5SDUQBBejIBkNtHvORdkU4Unl/2Bzvd9IPjfd+Dp7OACEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784202; c=relaxed/simple;
	bh=AOzt/YTI/ILLs9IYpchTVpAiQ7qMhNvW9ATlR/ovttU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZn/Ks8T7JCufw0JVijVAIXijj2Mb8T9oyGuuC9ngYafrZKhceI+aNzu3YES1DpTLr55T4JiTjq/jwur6eRpCLNKJvV4s/gcF5dfJfee06E6BhBb2N+4pjIoTpqZ85XPHIyjXOSSKuXQhSyWMOH2SITwnjsZhOv5N7gQ7qrS8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k+U7bur2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x1/2Wi79; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k+U7bur2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x1/2Wi79"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CE2E9EC02CC;
	Wed, 30 Sep 2026 12:03:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 12:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790784196; x=1790870596; bh=4E/P37Rsoc
	FDWxX34te9BUVPwvpfU+eF7nu4NXtqlPs=; b=k+U7bur2Aldusf7t63P7LekUWc
	gqPOrhMTHfMGlIv8ncHl+tDFbRyFzMZDmywXgEAawSkxbAvcgEPcdcgz0KGfJIEB
	vk2ohsvaNFd2CO1XrF9pG0ZvIeadaG1KR73RZHZyfiroKJ5ZoR30GBi0JDRcKPuq
	JuvSyP7v2EVttMR6eJS1EGc/rthONW4OfgdSEgtCQNbd97BwYCBl95gKVlaOL7oI
	gIbyPupvb65Cq+da6zQP4XgWukDRhB2yS+TqeN5cJVWw8pO3qs/SvaBcLn+N7rh9
	jk/zWw0fjwwPcUOm/YAjnOUApVixK9WssQq80e1gL1qPHz9P1IQp0C+dlQcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790784196; x=1790870596; bh=4E/P37RsocFDWxX34te9BUVPwvpfU+eF7nu
	4NXtqlPs=; b=x1/2Wi79qg2iUd55f6W72LZynHLs4rKRKlnPScFSf6xOYE2mCHL
	Cw4XAxFI5zpcej4XIoJ8fju1lLA3EXDlEdNmK3gSwjg5JylHrqwqQws2N5eGZzDU
	Rh5fpw3gEdT9PTC+umD6VwIDuUv9OrH4Yv/BoR2uzIprC/VlH2SKV7Pk9dO6EkVf
	X2mN07ZhPOAJcvQk/3fI5NJVRSZtxQ5zhZhPzoXFCWM1WsTS8qgggL8B77YlMuKq
	Ufwnz5HHont+ZSZqYTUq8As5UYMYjOU9QNqa9vkTHNmNbNzuqAA5jywctjL2z6iD
	k04N2fqdlf7NQ1aJx79rHbJoaza12uKgbZA==
X-ME-Sender: <xms:xDK9amiI-m2IQYo_wA0q3vL73Ydx8a9sMSB9xEOP25Pq3sFz7Nymjw>
    <xme:xDK9aud764v6lDKaiTdY6j8s3u-WQyagGdpuloFy91GRw0J00KsD8Gmt7I-X9t4_Y
    HmayD8W6o_GG49OAFib83ON0oIHkSlGteThco5VAuok1hTwikbq4A>
X-ME-Received: <xmr:xDK9ardTB-T0qYz8a2i7crIUR9Lesf5om-rAWt2VTkZXGcoB_S2u1A>
X-ME-Proxy-Cause: dmFkZTFgN/9YbfLZhW4QN1kBQsLKAEcNQqwK4hX8ZmP16ZeV/T1Nr1/5km2quo57j7DQ1f
    u2a09diqxFMKNNV3mlJGr2EKbfqTkiMvYcVrTmopnOQhikLyeE90QtHvoYQLOklybpphEw
    RdQecvhf/6HM1Phpt+yqNCSOIhkXoPr4aJ6RIYcUafQlHQVeJEw46px/Xjj3s4Mo4etIv2
    x7mLQTmBC0w4k3REar5oqg1qJCKHe0rM/Pe4MeYfvfF4S+FQ40Zd1CueGFClytlVv3h6EZ
    ktf2YbEDUJr7YAcYdgDF9LY2GEDyWD+rvyUjMaw//iZfo56uZh+A+0xIgQowYF6zsPa1Js
    gtKxeRW6qFreWZsOo7Qz/2cPh3kHshr9Co1cY0b3WarsGnJd6ogwpqf2uDumqTjry1VMPP
    QtgyORrXArZBOcsIeSj4SdeVNUnvLTN2KpXFwnufv5P8fmFfgqItAeHyoemB/bW3xvrYCF
    0sSkVdQXOA0GIVzpJqnY1KVSnKOnelUNeHzhRjL19ZxOxzoWjnL/kThE29JTv6dKrKqch5
    o3qn+hb8kBAGgnbcQsro07OVb+P3/HTMYgTRJzp7sMvfLvG4v49sTWECW1HtbCI5795uKb
    /hY8ZrnP8AcxkE/nX+nOMWPgcCEXtEZ7/QV4boCWYRGmCpEBYoBDv83qIR5g
X-ME-Proxy: <xmx:xDK9ao-S03Of8lUvUan3VQpHVubAspdOIK_k_Zv8YeeKHkU4AZaHAg>
    <xmx:xDK9anlc9-4gEZrj-Y_gatCF9kI9bD8vxLB2xp7RjPzCVh_jSKZoAw>
    <xmx:xDK9aq-WhDTdjQ1jQNPYHp-pAhyZRrLTM1xIJZNJdjMt7Iq5OjvYsQ>
    <xmx:xDK9alls_JSa0TKYt5tvM5Txl6lbMcK5ckOmujxg2B2H9IvH07ZTMg>
    <xmx:xDK9audsjc6YUfYjPfGCoxvocA68VGCSy3jAKJg8t5H6SpmsH10tFUT1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 12:03:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1184630 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 16:03:15 +0000 (UTC)
Date: Wed, 30 Sep 2026 18:03:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 4/4] setup: communicate why a directory is not a
 valid git directory
Message-ID: <ar0ywAlMDuzK1Hvb@pks.im>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-5-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929102513.712181-5-kaartic.sivaraam@gmail.com>

On Tue, Sep 29, 2026 at 03:55:10PM +0530, Kaartic Sivaraam wrote:
> At the moment, there are a few scenarios in which the error message
> surrounding an invalid Git repository is a bit blunt:
> 
>   $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
>   fatal: not a git repository: 'repo.git'
> 
> In this case, even though repo.git is a valid Git repository,
> we get an output saying it is not since the GIT_OBJECT_DIRECTORY
> does not point to a valid object directory. At the moment, the
> user is on their own in figuring this out.
> 
> Instead, make it more easy for users to figure such issues

s/more easy/easier/

> particularly in cases where they have explicitly specified
> a Git directory. This intends to improve the error reporting UX
> by clarifying why the specified repository is not considered valid.

Which I think is a good motivation.

> We achieve this by means of using the new helper
> is_git_directory_verbose() that has been introduced. With the
> same, we get a more helpful error message as follows:
> 
>   $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
>   fatal: not a git repository: 'repo.git'
>   reason: cannot access object directory '/does/not/exist' set via $GIT_OBJECT_DIRECTORY

Having a separate "reason:" line feels a bit off to me, but that may be
subjective. I'd have preferred to have it on the same line, or maybe
first have "error:" followed by "fatal:".

> diff --git a/setup.c b/setup.c
> index a0fb68f7f6..a0d3c0c5bb 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1195,6 +1195,7 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
>  					  int *nongit_ok)
>  {
>  	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
> +	struct strbuf invalid_gitdir_reason = STRBUF_INIT;

Nit, please feel free to ignore: I'd just have called this `errbuf`.

Patrick
