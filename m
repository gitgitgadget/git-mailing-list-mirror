Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574625569
	for <git@vger.kernel.org>; Mon, 26 May 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242156; cv=none; b=PaSrzNZ3BRQzRs/jr+MeumzSYd5gTghPX/VphIHEbUpsZ93VSQvOc1pJcSqJvuAHrqRRqyvp/IJv8RLzatQM1yv07ZQA4F+bSeExYAKLq0HVpuXI7c/0kDqMZoD5kNc3yyz4XCv55zrbAkILGHm+7IdOE6RyhyJDixtFe5oNEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242156; c=relaxed/simple;
	bh=RyqJ/R/xgQ4+omBgZYNX9IixdQhllX2EkxZRVRe/lRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGAqWFrTBLYpg3nBRhe/8cd5KtRbqIKUyutGuuYECSr6fQrd3fH5AYJjD67mV+mIiNhBX0Kvyg/HBDPFZ0NCFrhAqM8zzGvgvGwOxbpyBjuTtv6DnufO6GyKE6jwIKujhCm1xU86cr9490Ug410ycNRMtd1lHgK4aPctQtxtTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cvqHk7aT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+hbxnNL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cvqHk7aT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+hbxnNL"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E214114012C;
	Mon, 26 May 2025 02:49:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 26 May 2025 02:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748242153;
	 x=1748328553; bh=3G4HonjbIHSxWv9319weI5c1sqgjRN5LXqBP9d3tW7w=; b=
	cvqHk7aToXozvICLCXLCGU9GIv14BCiLQza0y6w6669aBhCvPbPto4MYIrZcOe32
	Lkzzvh0UKIBWn7N1uUg0hyQw2lbsNvf6Q+unvNCPaBga2QDW1DJi6Tw6oTW5mhzx
	lXhzsfqYL33PDe36Jk0dkyhMvaee+XW2yJ1OA1Hwj77ZR5OJd/EVz/p8n2k//Vr2
	mOoAPKUeS7MCIiFhijmQ5k/Xv/JaKcCTevC+8wHSc5CSO4qYw1KpeP/t9g3GxGBi
	Nm+CAs4oJDr0lrvgNCnFPdSd7D82DOvinyDQV6VjHCavHjIQQe5cJbKrOvgRN8r+
	zEytVVSXKZZh7ixRVtzdcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748242153; x=
	1748328553; bh=3G4HonjbIHSxWv9319weI5c1sqgjRN5LXqBP9d3tW7w=; b=H
	+hbxnNLkSOaoJB5u3e+fu6scP4ItI5cgfPurqTWq4nTvGxbgd30nDFveAsVp49TR
	hxDOgY7nqQjGBKUjt/WEm9eW5V1zv5m3Gh61Y7nKbFSKY9TORkQdWSUXOO56mubc
	YaW8ddtAD8D1llQECEZcxWTmEL4boeI42uSHNYs8vQP44ayHnMzb5GYutfcAR2SC
	86puptx6zIUfKX/fp8yGw6PcLCpfKIeNEuXORL8AqxN2gM3f0EtRZVx3WXen9bYO
	fFJg6BWCe7o/njTIFv6mjJWYlW3T7sR06YjaVmc+9wDNShZxnffOjRcqC56SYHpX
	6Zs5yfsKJqUQ2FL4lkJAg==
X-ME-Sender: <xms:6A40aOrYCVP_QrJrg6wxVvBPC7FRPJGOBhmNwpQDKth07MlUon6sMg>
    <xme:6A40aMqzwV_UVhoP-pARyM6oaA6_z-5u6WKCTzroxEyABSa5hiWLmf9f_7tmKYzFg
    qDWMONl0J3feLGBdg>
X-ME-Received: <xmr:6A40aDNhma5bfXefKFRkpeGAi34bTzrzHTEMmT3QCbp58Oj3hILbmhBMRFVmGxa9XRYV4fmJHH7sJlsymMW9HnAqcCeCvYkACq2w9axIIMIDCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieekheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhm
    rghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6A40aN6giT5FX05UfT6MJNonp3_IX0XIpcKOC4fGvZesixIqXAUOrQ>
    <xmx:6A40aN62DFT64qE-TfS8O1gW1jI7nijE1oXdqiNAMwykhWPfWWKyjA>
    <xmx:6A40aNjsQ8-PUq_23-RIcPTzngrR1AaBkXdaevCudLMoZHsPi87bWw>
    <xmx:6A40aH55c2Ctg2ITaBveJgEZgpNnw06QKWFJ1xjZjHn4I065_8dn1A>
    <xmx:6Q40aAUAPhecvtW-w54Sb6_3wmfH4qhFpf3I0IunRXgKQPQO238zgmIb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 02:49:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86c7d922 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 06:49:09 +0000 (UTC)
Date: Mon, 26 May 2025 08:49:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] pack-bitmap: remove checks before bitmap_free
Message-ID: <aDQO4Vkj7POztMnC@pks.im>
References: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>

On Sun, May 25, 2025 at 05:09:43AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In pack-bitmap.c:find_boundary_objects, we build a roots_bitmap and
> cascade it to cb.base. However, I’m wondering why we only free
> roots_bitmap when the cascade succeeds. It seems we could safely remove
> this check and always free roots_bitmap afterward, which might provide
> some performance benefits.

This commit message isn't quite a convincing one. As author of a patch
the onus falls on you to explain why the change is sensible, but even
more importantly it also falls on you to explain why it is correct.

It is of course fine to ask for help and input, but in that case you
should probably mark the patch accordingly, for example with the RFC
tag.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index ac6d62b980c..8727f316de9 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1363,8 +1363,8 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
>  			bitmap_set(roots_bitmap, pos);
>  		}
>  
> -		if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
> -			bitmap_free(roots_bitmap);
> +		cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
> +		bitmap_free(roots_bitmap);
>  	}

We know that `roots_bitmap` is always allocated via `bitmap_new()`, so
it won't ever be a `NULL` pointer and should in theory always be free'd.
Furthermore, we know that the pointer never escapes the local scope,
either.

The next question would thus be: what does `cascade_pseudo_merges_1()`
do with the bitmap? Are there situations where it does free it for us,
or where it moves ownership of that bitmap? So let's go down the call
chain:

  - `cascade_pseudo_merges_1()` passes it on to
    `cascade_pseudo_merges()`.

  - `cascade_pseudo_merges()` passes it on to `apply_pseudo_merge()`.

`apply_pseudo_merge()` itself then checks whether the pseudo-merge is a
subset of the `roots_bitmap` and, if not, ORs the pseudo-merge into it.

None of these operations move around ownership or free the bitmap, so
this looks like a true memory leak in case `cascade_pseudo_merges_1()`
returns non-zero. Which would raise another question: when exactly does
it return non-zero, and can we trigger the memory leak via a test?

Information like this should ideally be part of the commit message
itself. It helps reviewers to figure out _why_ a change is correct and,
if anybody were to dig into history, would also help them to have enough
context.

Thanks!

Patrick
