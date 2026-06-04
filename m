Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771AC14B977
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575669; cv=pass; b=a5X0fxAVnMKMNwno4SAgmmcFWFuRi3Z4B9V6sZyAgFfB55FX+/Si7ePYTfSKbTvKe0dqIIPph1Y1qSXdlWyf3FzfRakH2PXE9FZK0gNPnz56GYaMZJtnkJLbfbfwdNAdFD+DUfVAI6nB/2gUlG6lFoA8Wz99JdamKz6Bze2LC2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575669; c=relaxed/simple;
	bh=YnUaQUAYVhQoDJqBF+5B7O87ZqRpyW9hYBqywaZ2dVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp3n3rW/6ZM3mW3l6P19d2QOSuJr4uKIoI2wVIT0hxd4b1Pw71+KZFbuFQyXmATc/bCsuROFL1MUcdVOaw1jtsVGj4DCL5+eNggqw2v0/TjCS0iPDyl8EhRB751wtFvxndfgPeYhz9ZHQ8juJK3kOxrjlREtouJmsmPu6PnTp9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=IiT2Wbfv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="IiT2Wbfv"
ARC-Seal: i=1; a=rsa-sha256; t=1780575661; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZPmxAC0Sxnv8W/5rW25hxnT80xxkBdzjqVRLPGq1YguGeCfNa5Z2PtGx2rZHocZJOaY/wyqF+flDw5DTBkMEZNhUN9Pm/XYj4WyysqznX3BpZw84l4D16fELr61dKGOu++UIfjkTBf/gmjWFXKq08XCbq9GtzpxZLEP99+33jM8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780575661; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YnUaQUAYVhQoDJqBF+5B7O87ZqRpyW9hYBqywaZ2dVM=; 
	b=mvPPRwxDtWqow9HsVRkZnZyW70FKVOerXD/SLzzn9deKimd1a8F5VrsZ4dg1PDq9CyWtXrFuSvkz+APVNhQlL54wGSAlsFOQQlXGwm1wPYAJcTN5D076x5Px8YN1tFaWMYYNDrIsnqQPdFIiudJ05+AC3Kyuj0GbQ8QimAvChZ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780575661;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=YnUaQUAYVhQoDJqBF+5B7O87ZqRpyW9hYBqywaZ2dVM=;
	b=IiT2WbfvQhPGV0kmFRRZhjC2b4XGPjrvgU3vzI60yQnclLWSGfeonscz1IJ9gZjc
	SSGWAePrFzZsG+u27x2SsV5aTNLbppj9KwfPmDZw1aWOArcWp1sGi2NTB5KFxknI6XC
	lSszMvSRMyZt9JauqvCzmMLka/JhrbfwWmsmCS00=
Received: by mx.zohomail.com with SMTPS id 1780575659972543.6300659408696;
	Thu, 4 Jun 2026 05:20:59 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:20:54 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Jeff King <peff@peff.net>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] log: improve --follow following renames in merge commits
Message-ID: <aiFtpkk_xN1897IE@collabora.com>
References: <ahFDgq4TAcs29zCA@collabora.com>
 <ahqDqSH7yfYVOOyE@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahqDqSH7yfYVOOyE@collabora.com>
X-ZohoMailClient: External

Hi Jeff,

On Sat, May 30, 2026 at 08:29:03AM +0200, Miklos Vajna <vmiklos@collabora.com> wrote:
> Could you please comment on this, if this tweaked rule and its
> implementation in the patch looks OK to you? Let me know if I should
> just wait some more.

Just to come back to this, the idea was to make the --follow behavior
slightly more useful by not always assuming we should follow a first
parent in merge commits, but see if only one parent has effective
changes to the followed file, and if so, follow that one.

I did this by doing a diff on the followed path in each parent, then
mark the parent as "interesting" if DIFF_FILE_VALID() says so. This is
true if the file is touched or the rename happens inside the merge
commit (vs that parent), but it's not true if the file is really not
touched or the file only shows up as an addition. And if we have only
have one interesting parent, then switch to this, even if it's not the
first parent. With this rule, I think we address your worry case about
"making some other cases" worse and this still works for the subtree
case, and this is relatively easy to do.

What do you think?

Thanks,

Miklos
