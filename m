Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25618A6DF
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911278; cv=none; b=pUwncfNM9QKBKZOn1ddQJm0w69dsoeErf0I7tgqFc0vrvqPGAHGv8eFBN9b97tf8i2drPcU6NgiNVpuPe1/eC0NWukP0b/x9CxmXu0R1cQg35StBai8VY2Gnof7e/cs26T4GjB8aNb6esMQEGE1mK5pwUNWGHnkMjKIKURjaMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911278; c=relaxed/simple;
	bh=T2EpUx2p/IZhNe5NLxVxsi3iPS37IKdnIwjuxX7V4gA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTIuqnuuU8aveXzWnc59kg4xGE3v7PSb9IcTJIQOZ/usW8uhZmXpGQhY0/IUUlPt3rm1tRzpXRTXiV/DR15psvI+txoXorVzRBrvZxFdy37Qtdrrp9sQCSjthGDbyzq06RZ3u1TfBg3wUUbYzyt++GlMLRqbglNPr65S3yyI/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lzi1ZcOv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZ+QY1p7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lzi1ZcOv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZ+QY1p7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B6DAA1400213;
	Mon,  7 Jul 2025 14:01:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 07 Jul 2025 14:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751911274; x=1751997674; bh=0nnV8By0fk
	CEuBZcTxtr4lPQz61Xi9EBv1xVx/Gs4bg=; b=Lzi1ZcOvBq6BINLH9tw+r6z+PN
	oP7neK5K6kHCjBNf5vE0JF4jKS0iYextoQzmuptNZ51wTW4rMPDW3XRlVLIMjK9L
	+wYYf2qkVv1exz29ShM2eUdjrmelns/jJm9g17ZZqle3tKqzvb1wgErHUHr62I91
	NW6UkUxgOe3ThBybNi851exIRJDVwyjUmcUoY2N373aKEO+d5RhigPQuDxJdKihd
	ZqttwB8m+fPM7869WtaA3sj4T0Ogi3ZVmBQZDm1/NXt3DHkh6Dbst8Lyw1GbiZQl
	jReNZ6j3iC+lzD0slIHf+Jhe5dABOzvTavkL+ei9/O33f3s+BRVXcikEAo8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751911274; x=1751997674; bh=0nnV8By0fkCEuBZcTxtr4lPQz61Xi9EBv1x
	Vx/Gs4bg=; b=YZ+QY1p75s+Bu4ctWq7sKYXcOyqxZGvdRwTiccsa0LkNTcVKWAr
	rOIRNp96qDmuBB+JCyEGcDl2qfYTxpBd/87tm7mWr2rOZtyOpo2XjSLtaZqem+Bk
	P1eIbJfu+C75uI3mhErduGE3UUL/DA87jEoTJH29bc1tgMc2sxYge8ONnly3RCpY
	UPtfzFHJu4P5WsGHc2myP8Vyo27zi5iwdSmJLIfo+ToENXS6tS+L6MJ/a6Zwm8ff
	GmbyE4E9UxPCygvTajsrZvGUaT8D7UGO9LbFAV+li2919/eedNeNAkc2MzclDD28
	/0JTSE0zdh+At0B2IkR0Mjhb2CWHI3wu1FA==
X-ME-Sender: <xms:agtsaFL3fuCzS55jB_Jq-xpVpsbF4E_AHzX3iX25HupRN14j0e0-9g>
    <xme:agtsaEYCWfia85NWSKYcjfrmqk3isYlPS-RzuRw7ZXE6XEyFcnmGXa6FQ-lvrJ7Jb
    z9G1KgYWFcxH8o0aw>
X-ME-Received: <xmr:agtsaHJfQ2shdkSCDXapvaRENiqSZyhQoPbGCglZN06S8Xe2f1b9Sjuma8pjIMc2FnetGw12da9aNsuKZ3HLmHQwXYy-TTzwCbFQzw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrnhihrghn
    ghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:agtsaCCL6XYdS4UD1AdSf3hSkBHmnLEEZgWzQiduJYyZqJYcuBPqUg>
    <xmx:agtsaMp9gIDEjC5M-3aN8OZCG4-cllnqgb7OQaO71H39Kr9uaMa-Bw>
    <xmx:agtsaNgUxLeTWfvh0vKSgNw0HQ0yDpJNWzOSqSYoxe6Yfj72qle1kA>
    <xmx:agtsaJCwhVOVbN_ENwn9LLYg5QMZ8QcWN0OPHBiaelcA019z4GO8Kg>
    <xmx:agtsaCCoG6esahE6V8bKbz05VIr8Xw6RAo6Yn9JWZymlUb6ykuBitEQS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 14:01:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] read-cache: report lock error when refreshing index
In-Reply-To: <20250703074502.45593-1-hanyang.tony@bytedance.com> (Han Young's
	message of "Thu, 3 Jul 2025 15:45:02 +0800")
References: <20250701115719.85226-1-hanyang.tony@bytedance.com>
	<20250703074502.45593-1-hanyang.tony@bytedance.com>
Date: Mon, 07 Jul 2025 11:01:12 -0700
Message-ID: <xmqq8qkz5193.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

> In the repo_refresh_and_write_index of read-cache.c, we return -1 to
> indicate that writing the index to disk failed.
> However, callers do not use this information. Commands such as stash print
>   "could not write index"
> and then exit, which does not help to discover the exact problem.
>
> We can let repo_hold_locked_index print the error message if the locking
> failed.
>
> Signed-off-by: Han Young <hanyang.tony@bytedance.com>
> ---
> Changes since v1:
> also check the "could not write index" error output
>
>  read-cache.c     |  2 +-
>  t/t3903-stash.sh | 18 ++++++------------
>  2 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index c0bb760ad..50e842bfa 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1456,7 +1456,7 @@ int repo_refresh_and_write_index(struct repository *repo,
>  	struct lock_file lock_file = LOCK_INIT;
>  	int fd, ret = 0;
>  
> -	fd = repo_hold_locked_index(repo, &lock_file, 0);
> +	fd = repo_hold_locked_index(repo, &lock_file, gentle ? 0 : LOCK_REPORT_ON_ERROR);

Let's wrap this line to stay under 80-columns, i.e.

	fd = repo_hold_locked_index(repo, &lock_file,
				    gentle ? 0 : LOCK_REPORT_ON_ERROR);

No need to resend, as I've done so locally while applying.
