Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76469316902
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055722; cv=none; b=fx5yt3H00wApe5pwLwut2kG/vp1ExOQrUo8l84hVl84qx65CTjl9rasxPGM+JNYp4qqeDQYl+974RNyDzZ+DLpbvneSugXEPibdNTE7Styo/mwEuJEnOpIIw/uGqrTB4R2s166azOtRIdbztHZCmbhkCR5AhirRTg52z9QZhRdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055722; c=relaxed/simple;
	bh=HI4xtsjJvlbar0WYjGaKfwarrddmi0a5++MlnIEG0iA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsMQg1HgxZobJllMpqQ/hkx98uoQE06CGxzNOomj73vTgBcatbR6xLl24Cmx9+IQRUyadb1AzYUpXdDsfUN+uzKX1fqxLz0lXKl5ulbY1BDvqVRrPa/mBMnBnAgEnGo+CDIAddbI2KakHCnG8bSo1TRJzQUxMtJ7YUJXngWlJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xyAi2pDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EgciKn3y; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xyAi2pDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EgciKn3y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4D5714000FC;
	Wed, 25 Feb 2026 16:42:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Feb 2026 16:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772055720; x=1772142120; bh=NoqJO9uu0f
	XurLU8XNpJFT0H4NrrNmR10Jw2K0hwndI=; b=xyAi2pDAC8c45jX2+lldl6CB/E
	u91L/2iRUGSOf5S35upa+9YunlYGpWlDoU/aXSV05FrPyPvTgifukuz2Iyi9rsIU
	4iw43CQu6KBUxi/FAyuh3Va6eKrC6tvukhFya/h8luC+QJTk/QIhZMHohAICa19o
	IdBHYxZ3j4aPv325D+8cxulyQKT74gIZOyxn9EwDQtT2h7xHAsaN6OCppRBTVHWi
	WeukGynWJ4ZPg+uSk+0GPe6zLZAgaNhPUcaMezO0J3NLjOuHVHWOdv3CfUUYKxGb
	kxd/gLlZscvy+dWk1/xLHyOsay8mMsb7LlTShRQDW7VIqIXAr9FLjKX/qEnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772055720; x=1772142120; bh=NoqJO9uu0fXurLU8XNpJFT0H4NrrNmR10Jw
	2K0hwndI=; b=EgciKn3yNC8+PyerZtvh/F29aMzckzend6MliWCzfjmFPOATutH
	ipneca1Rbxr6mTG1pfT2UNfuHJeWr4ZDcEl2JhjtMQpZyzpaz64Er2QdHk5EZwwx
	fC8S/fi6x4OT/fpXOmZ5V2Gpkuri6KsgpbCDCqmkx4Qzo+YfCvgzVGHQ2wHExzWr
	ntaq7nmq+hx1VnW/LYt//1PRSru8Rv80/ciVs9ZOptzkZspf/Mz4j2xd0blT4Tyj
	7L8Krcz/WR1tKHswlMtHpx9AvFCZxXFw0I9K4QLdCol3xrl98lrYqPVu2ltRT8rV
	O2wBNj0houuKxCppEZK4kZIDX0Kl7bRYgOQ==
X-ME-Sender: <xms:qGyfaaH0IOrwUgfxE52sq4VpYiek60owA6Im9EevTY8pzvP3wAimag>
    <xme:qGyfaW1hTxH1obtWf6RFXGwP_0Q9FvBO4Av6ZuD4nhGNjoHbEI7A0kcthlGVjHyZa
    zErhEIR4VQu1tshRsYwUh-q-Pb6EEbcY5tpU27UJErmFKAmDTRy>
X-ME-Received: <xmr:qGyfaamTcYx9AiYmT8IAHxThfUDIlVcK6T9Xm6BFJirpk_hxKUuLL_gMJpBwkJbhs_KJBabwj8c_4f53yJgEkCimTjIwb_70LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvg
    hkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qGyfae9x57n3yUhpVR2zvmYpWTlVBuylboqXlQcynTOuzZ6YbOE8zQ>
    <xmx:qGyfaXqWOGYsQAPGGyI7zjwDDABkwzZUdRDdPVRKRiox6ht0pQ9pLg>
    <xmx:qGyfafn1-jdWvgzJgC92dwpKatHW117h-29J2A1QKasKiegzWyjWCQ>
    <xmx:qGyfaWiy1fUFMIY0bakbtb-oal6Hpvw0xp2Fal2MkcmHQoIT1qRE4g>
    <xmx:qGyfaXiLyeJBZu71AnAOG43xS9OK5siuVZSX3uikWu-WooXLZp3qVAhP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:42:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v6 09/10] run-command: add close_fd_above_stderr option
In-Reply-To: <817489b3ea6a0831e4b815df1c4a0c0e100a2683.1772050636.git.gitgitgadget@gmail.com>
	(Paul Tarjan via GitGitGadget's message of "Wed, 25 Feb 2026 20:17:15
	+0000")
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<817489b3ea6a0831e4b815df1c4a0c0e100a2683.1772050636.git.gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 13:41:59 -0800
Message-ID: <xmqqikbk8pqw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> Add a new option to struct child_process that closes file descriptors
> 3 and above in the child after forking but before exec.  This prevents
> long-running child processes from inheriting pipe endpoints or other
> descriptors from the parent environment.
>
> The upper bound for the fd scan comes from sysconf(_SC_OPEN_MAX),
> capped at 4096 to avoid excessive iteration when the limit is set
> very high.
>
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>  run-command.c | 11 +++++++++++
>  run-command.h |  9 +++++++++
>  2 files changed, 20 insertions(+)

All makes sense.

I somehow find it a bit surprising that we did not already have this
feature anywhere, as closing all except for the low file descriptors
connected to stdio by default is fairly a common thing to do.


> diff --git a/run-command.c b/run-command.c
> index e3e02475cc..cbadcf5ff8 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -832,6 +832,17 @@ fail_pipe:
>  			child_close(cmd->out);
>  		}
>  
> +		if (cmd->close_fd_above_stderr) {
> +			long max_fd = sysconf(_SC_OPEN_MAX);
> +			int fd;
> +			if (max_fd < 0 || max_fd > 4096)
> +				max_fd = 4096;
> +			for (fd = 3; fd < max_fd; fd++) {
> +				if (fd != child_notifier)
> +					close(fd);
> +			}
> +		}
> +
>  		if (cmd->dir && chdir(cmd->dir))
>  			child_die(CHILD_ERR_CHDIR);
>  
> diff --git a/run-command.h b/run-command.h
> index 0df25e445f..a1aa1b1069 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -141,6 +141,15 @@ struct child_process {
>  	unsigned stdout_to_stderr:1;
>  	unsigned clean_on_exit:1;
>  	unsigned wait_after_clean:1;
> +
> +	/**
> +	 * Close file descriptors 3 and above in the child after forking
> +	 * but before exec.  This prevents the long-running child from
> +	 * inheriting pipe endpoints or other descriptors from the parent
> +	 * environment (e.g., the test harness).
> +	 */
> +	unsigned close_fd_above_stderr:1;
> +
>  	void (*clean_on_exit_handler)(struct child_process *process);
>  };
