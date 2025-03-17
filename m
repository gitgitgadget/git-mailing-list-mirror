Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C417A311
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242679; cv=none; b=G4WjS3gAqLf5o+OXyQ2kceWs9f7Bu+u222aVNDXyCR8ZUb9kZTkbcuWZtaPEAc3s8zBIoPNONc2QeAW9jexGELGqKakgatiJU+3e5Y2hpsiQTGm6F6fZM7usb40Umk37imcg4tu/j4fLeML3tcWyEkwqykxrMAeAcucA+Vb9i4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242679; c=relaxed/simple;
	bh=o1TYVf5YGKosGyztQnOalCW0FuDevwKo/brAf84CRvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dOCjEGZ+ajKUtbvc48tixM2O7trduEgZ2Sx7v24OhPhoE8TTjUvFNd+sTjtbqP35M3lVvsSFlOwMvqwlMW2M0mlMhgvwvJATdhnGsJHnYe23eYi0oNo4GQtvMVK3FLpFTXUumDG5OJ5sMJHDVzFVpmau6XSaxhV1J8YIUbUt0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RXuPv/EI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWKkPwsf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RXuPv/EI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWKkPwsf"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 444321140101;
	Mon, 17 Mar 2025 16:17:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 17 Mar 2025 16:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742242676; x=1742329076; bh=fg1fw+TvHX
	kGVMv2HdpeRkhOqyLlQ+hqc90sW/Lq/w0=; b=RXuPv/EIGnVf4m7d6cF5ECxVOc
	HqSHb6/IXHMgzsc405bsq0U5IBUNq/8D9Fcw256tjO8qY3NLBrX2eQbzjDd9dBou
	g5XG1R0dt1fOzBWVN/zpZIMfgQ3iG9JAsAGxtUNE3PSRuRlTjybqz/FEpwj1+tMx
	ZKREHSR7tiX1fgGhR3H9DC7di+/predvCnsL/+/wtpSKH1I9cQTt1WNs4HJ0R9zh
	4krabxcE77prjPDqTQSZnlTKS/eEUT1r/kYL49Z+VCMz0JK7QhgwAR6HEOcImFyv
	camPgyIZKRr5HKQMpeS4vCIyr1pxh2lG5M71NkrlvIkZxUsbN/tCHI4iNOXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742242676; x=1742329076; bh=fg1fw+TvHXkGVMv2HdpeRkhOqyLlQ+hqc90
	sW/Lq/w0=; b=CWKkPwsfRHJVioILzNFo/B/kLh9YyXvIUm4ylbBED7ryzDMSg6o
	6/XZoe57KEoa+o3IgF598r7fDd6ghtsOg5BL3gAxFR69QO5uC351sClNglkRH8jn
	KPnCnOtwikpLvdxN7p2JusNwrUpnqWU1eSwVhGDzdU1xOfNf5nOdLJ0C7bIAwDfJ
	bhIP7Gzr5lSaZmv73H5midhim1KJtCHVU8dOb2Rldk5QD2Ka3URSI1U5UlRNU1ip
	BRnKr1q7xBgKuODZpOcc3nY2ykaqyBcPFNtdX/PfG9tHkGKeiMX4U945eUg/bcYd
	vzRYobc1GP7MnoYwhmIpLvtrs/lf9QQyEAw==
X-ME-Sender: <xms:dIPYZzEQ94KaHOg7q34btWu0j5DVS0whNowb8Auw3KU7ERjz2WiplA>
    <xme:dIPYZwUH4G5DF1Bcxh8KKvJdVeyUEkuf0t3-Hy0u24oumc9X4kajN3L7IgHS18p-6
    R90STqa0ebaC5i7_A>
X-ME-Received: <xmr:dIPYZ1LTrUG7MMM9f49m91ifvqyA6Bad46Ct6eJmx5bpAqcvFo3kGh7YgAUeolBP4lIXFTXQ7ThVc9dkSzLu2UbWbcrBsxwT7o8XAOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurd
    gsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgtlhhouhgushesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dIPYZxESWlNh5WspmwePISnhyfIffYWDiejcRNHf9hPnJN8eFXTl1g>
    <xmx:dIPYZ5W7hAuDE_ZcMxRhJ5k3qRsCJ7Saq2S6zANouVz8FZmJso2mWg>
    <xmx:dIPYZ8NYTsza-z7u_f20f5ttjNuymvKEuSwnK3jLGU3hkEIfA9B3rA>
    <xmx:dIPYZ42OfMH_gFHu3fs-rb2IGl6aViLPzqigwO3lyg45M5xK3a_hTQ>
    <xmx:dIPYZ_yB6s80pvAhfl82j_W9EnNWD18lMXRVEFif7z1PXguSNUd7LExr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 16:17:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org,  =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy
 <pclouds@gmail.com>
Subject: Re: [PATCH] docs: clarify meaning of core.commentString=auto
In-Reply-To: <20250315140913.577404-1-oswald.buddenhagen@gmx.de> (Oswald
	Buddenhagen's message of "Sat, 15 Mar 2025 15:09:13 +0100")
References: <20250315140913.577404-1-oswald.buddenhagen@gmx.de>
Date: Mon, 17 Mar 2025 13:17:54 -0700
Message-ID: <xmqqv7s78l8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> -If set to "auto", `git-commit` would select a character that is not
> -the beginning character of any line in existing commit messages.

This is so far in the past but I suspect this was deliberately left
vague so that we can add (or subtract) the set of possible letters
to use.

> +If set to "auto", `git-commit` will select the first character
> +from the set "#;@!$%^&|:" that does not appear at the beginning
> +of any line in the prepared commit message prior to editing.

So I am not sure if this is an improvement.

> +Note that this makes it impossible to include comments in the
> +prepare-commit-msg hook's output or the commit message template.

Care to rephrase?  There are degrees of possibilities and "makes it
impossible" is being overly broad.

I suspect you are saying that it is not nice to make it the
responsibility of the end-user who chooses "auto" to ensure that
they adjust the default '#' comments injected from the template or
hook output when

 - they have a line that begins with '#' in their message;
 - the "auto" mechanism chooses to use ';' as the comment character;
 - the template is written assuming '#' as the comment character and
   has comments.

before making a commit.  But "this makes it impossible" does not
quite convey that to casual readers.

Thanks.
