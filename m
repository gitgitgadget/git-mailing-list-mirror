Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117DF155A25
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494069; cv=none; b=JtqMBN88e+BV4U97GhjhaYr8DEyF7FAD9OdUCfvvucHsaQTxHVkKrCqDo+Ky/pYZiTukLGcbyE/djztLDfZ8J1RAzWtyL1jCZLcZfp+bV/G7FMRBWhluIkE0TrtT6fyMKDNJuT38N7aQbhb/yMdIfOgcN+nF5qRNIxYAnbdB1m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494069; c=relaxed/simple;
	bh=KRTHLtKZI/7HkXltdb7YDf/DwvPHewK3qOGPtGdTD34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fzCw+4TAYIu9cA9fmRQIWEjCmIo1GFa2zMLFyInZCZQGBZJpgKoEERsVHGJBfdepcq9OicB7OcnC5avOpMjrEaWd+FMKmDvjLtaSwa9qRNWdXQAPlA7AFEp4QtB0h1nTyy7uoHkkZKLG43KJ3kj5esNMSwmJ/A/V9hLrP62hsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zOiLR8Dq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GkkyB6iI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zOiLR8Dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GkkyB6iI"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DF8F114035C;
	Mon,  9 Jun 2025 14:34:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Jun 2025 14:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749494067; x=1749580467; bh=xyQf8Ogct3
	qwE1sIwAYHws1O7Q17qPIACI7UFsX0+GU=; b=zOiLR8DqBkyUP5CZXlGSPNMZvn
	ewSbK+upfeQeVUeHzlSQa40VM5RzozmWF8piXDuRuBRb91+Rw7YCvQ5T4ohhIqui
	bDscCQpVxQpVIlF+/+uSOuzL1m8iqD2bWbgG5Yzwaf65FM2/EZxYq9v9Tb+n1wzH
	15tf+0pE7UH+cLLz6uxnAIPGKmV8HfNvU7a8mjHsHXtFUjaGMazlqLhBhKaQb12C
	wC5SICynLL/48uyVVkWmlRIKIOJnCFLCxtX1TwyfFCGd7MTR5pJ4/is+avoHMNe6
	JY94g4QuSZ/1oFwbxRTF3qDbHKVOygqeeaWpOyolOYnW2nvanavdcCGPkKzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749494067; x=1749580467; bh=xyQf8Ogct3qwE1sIwAYHws1O7Q17qPIACI7
	UFsX0+GU=; b=GkkyB6iIFI9etaneGFZl6j9KlYh7+XEhHMNyRMR7nNt7BP5bx2/
	hkkIE88ZiiN82l93knsd1r4fFiXu0jXfGj1ZLmBW3XWNWm2gNZZjHpIx0dsqZnIF
	lkJxsZCkrnRlbKvaOCGz0rxS3YSjxjLhO7hK0gRtiAcRoqJTNyrlVJ/NzTb6JYli
	NXJzfNgb/QyPMvXUBx00xH1CLs/tTTL1e+5PCVH2TfCBKGeIGDdT7atxJEaShyg+
	HvlC1/FG6BwDR9G6rEFgp8hFXY1XO2PptirbwB+9d0FOwhL28k8u+vJz9CWw9C/F
	GsYxNU3lSb+P4roJJDVcHhRXJCTThF2OoFw==
X-ME-Sender: <xms:MilHaHS0U94w7ALqWDZohWUFYIr143_cxPj9-WUBzx6kJttsnK5qlA>
    <xme:MilHaIwpqhj7-e7ISI4FyIhlh6YJp4Hr1UfzGNYayqNJdhrUjRe-Gbf3LGDdV5YSp
    3vuphoAaVjbzFSXjA>
X-ME-Received: <xmr:MilHaM3QNw7xLsA8Of2VfN8bZfv8Uj6BY2H53wa5R4PWy9p8nRCOQPdvukPw-zfyU_T1y7HwsugI6VIb2GUy7i9mZpGy7QETX-Qr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MilHaHCBO7vBztYZ6d8-jCb7SLepbBAw_f__W-hGyc7OcCN7DxHRQg>
    <xmx:MilHaAiBJN4QCTY5dJLAfmPxOrpDkeTZw-FgeZrP7bL-nREJW2aw-A>
    <xmx:MilHaLq8vsVd5-FleJ-CMDjs0qiiMQnhgXN2At1CbgntDBg2GhZHVg>
    <xmx:MilHaLgI20npU945kJXlA6iUBVpEELcDQu5fJhBv4Lkfq1xGwRc2JQ>
    <xmx:MylHaF5_KGJAavHh7QqiQywi0Jp3--GrCDT30K9tK9zL5Lzw6kJv8KKz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 14:34:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] doc: maintenance: fix linkgit syntax
In-Reply-To: <567195e5577c6c32b46f784a797fbf366873a0f3.1749484736.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 9 Jun 2025
	17:59:42 +0200")
References: <567195e5577c6c32b46f784a797fbf366873a0f3.1749484736.git.code@khaugsbakk.name>
Date: Mon, 09 Jun 2025 11:34:25 -0700
Message-ID: <xmqqsek8rcge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     I get no more hits with this search
>     
>         cd Documentation
>         git grep --no-index ':git-.*[123456789]' -- '*.html'

Thanks for being thorough.

The patch looks good.  Will queue.


>  Documentation/git-maintenance.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
> index 931f3e02e85..540b5cf68b0 100644
> --- a/Documentation/git-maintenance.adoc
> +++ b/Documentation/git-maintenance.adoc
> @@ -172,7 +172,7 @@ rerere-gc::
>  
>  worktree-prune::
>  	The `worktree-prune` task deletes stale or broken worktrees. See
> -	linkit:git-worktree[1] for more information.
> +	linkgit:git-worktree[1] for more information.
>  
>  OPTIONS
>  -------
>
> base-commit: 8db3019401f8093fb895f581be641fe7e05aa755
