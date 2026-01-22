Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34038887A
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108237; cv=none; b=DJXnsywo6ouSrhxuUtZjunNrGGWhrbgK2XJ0lUBj9Tu+683WvZwDrpRRcV6AKiJMQTqOj0D7B8TMLuMeaSCvhCril+3l+5tPWQnGVRrle5FT96ydWAnvh0Uj6bnkJO8VtBoEXqjtAafbk2YhHqqTtAS3ihlZWoiJAmyYq/xgH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108237; c=relaxed/simple;
	bh=3XZ5TDiY6+KAghgfyeeVe8ggkGYy950ZNvLlKgnCvaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cfLN99BW4QHQY35D/UJA/W4Mg+X7Ain2B5vacaiMxqS00Z+BSyevhEZU63RrlxYC7Uf9hw6mMue+vSfsH6QR9URbcPgu4/XzU8J7F6Hjl1SXmMIQEXOxFlET5rAzQW6uiaS8GzCQ467yt0Qpl3cRu0qeiFzbBRRXFKxVXI5t9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i0c9zh/M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kroSwHOM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i0c9zh/M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kroSwHOM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A0A0EC0128;
	Thu, 22 Jan 2026 13:57:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 22 Jan 2026 13:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769108224; x=1769194624; bh=46Dgrg1cff
	HHSpMZo3gK7GjnE9loUpz3FI6P4X1xz9k=; b=i0c9zh/MFDu2fI4L8ohsWnVOw5
	UyeUJWI4PBJPOPoa5ZAPUcZ570bVLWzhK2rjmEDAER2u9FRqiUFW1L77cPIUSKH7
	3yRga0SHbrVnMYAwaOkGdjpgYEAwRxsrhPQTx1yHwufqBVWBwpqvqO2zoz5jsjn+
	MsSu+YHAMb6SkRz+shvktxtCll3XX8lMgUX9sc1ElWI8Cigc46CQV1D5CyDtQ+ju
	axdNYTFqToysodfOieE9UYTMjnEPDGFwglQmY2aPZ49HcdGTzss0Bi1OJ+dTp2Ol
	0Z1nFM6FWYb0EGyFjfDjAm0yQzYH48CA9/mzLgKPFibuua3/xfGAS7cPhCzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769108224; x=1769194624; bh=46Dgrg1cffHHSpMZo3gK7GjnE9loUpz3FI6
	P4X1xz9k=; b=kroSwHOMRPaLYQiyuTHlaUKkbdi4V2qBbpCO4LdrcCMQCE7/pN/
	FROiIWL+wg5k0lKRxhZtEPtLlyxGEeb55CFOLmoidrUky8cBI+osv8bq8AJZC/dA
	cd3xF1XMGbEqsMJgiMkntBiB+yUGPKhQDAt3G9YM97QhhNra7Zf+qC6lNlxa5fxX
	OivGucsKnRYipZbwFdz6cvI6/wMnT7rZZNmVn3D4+TMyWPiPC5gm266ooEMyJsae
	ABGeEHG9MTLUeTfTa/zKV7Cc4t47PhfztT9kIQuCCMEDV7k2Aps/8UvEbPjYOFxv
	vTgnTZ5Dt9rVR9yw2ppxqQyxL29oSL6sWLA==
X-ME-Sender: <xms:AHNyaURMBSiqiwE4wiUlF28poQBWelbY4YqZfmctFmuLbFXaVr0nrA>
    <xme:AHNyaYxRpXZtR3W8JTnzdnHi6jQAkz5hD8dNKir-aHFMZ9xoeB_1qQPQr8-calVbR
    VX9ioLqcey07ZThu90CThkUnMGAmmMmP4iHh3QvL_q0RS0JbrveCQ>
X-ME-Received: <xmr:AHNyaW2OoQ5b5Y6DMJ3acH2VxxNIlWkms4gkl3YnNkSFmk6nCXO9NtZlqYpIWq-z5jHwlaYad4wA-k6mNZG7bDmVBxOAz55gFq0mz-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeileefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtd
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AHNyaW6gWwzicpM2f5TNiqGuppeiqFF7Uzhr6XX2PTmfWuh2o-8Sig>
    <xmx:AHNyaZVYz4ug-ol7KxcjbizP5-N1YEqOJSkPUNmCa6so8Us4aYdXxg>
    <xmx:AHNyaVDj0P5hn9fuCQGoXsvs7G2zrpE-RgHGiHcPqyG586QTR6ZG8w>
    <xmx:AHNyaY681aDhfpoTCGzAct6WzVKcCe228e6Ki0jDpYw_yoWVXUEZzA>
    <xmx:AHNyaYyonJQ08STGFUvjAe6aJTOnY3E0v4UZdANYBskevsHGiSAzhCfb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 13:57:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH] reset: avoid reflog update on no-op reset
In-Reply-To: <20260122154743.20496-3-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Thu, 22 Jan 2026 15:47:45 +0000")
References: <20260122154743.20496-3-pushkarkumarsingh1970@gmail.com>
Date: Thu, 22 Jan 2026 10:57:02 -0800
Message-ID: <xmqqwm19mq69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> When "git reset" is invoked with a target that already matches HEAD,
> it currently writes a reflog entry even though no reference is updated.
>
> Detect this no-op case and avoid updating ORIG_HEAD and HEAD, skipping
> the reflog entry entirely.

I am mildly negative on this one.  A scripted use that gets which
commit to reset to from the caller in the outside world, e.g.,

    #!/bin/sh
    git reset --hard "$1"
    git diff --stat @{1}

would be confused if reflog does not reliably store the state before
running "reset --hard" to @{1}.  In other words ...

> Add a regression test to ensure no reflog entry is written for a no-op
> reset.

... this change may already be a regression for existing users.
