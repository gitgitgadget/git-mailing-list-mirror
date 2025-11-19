Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700A3002D0
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577582; cv=none; b=TG0yE0GVXZD6ve8We4YJfZJnZ1YJEc/Kigij32H4UuiHHeCeVVqO20VfqBiZ+ZYC5K4nbAEP8dCkIoeGS+wgAoBg8bMu3cl+9U86pr/W3MyiMnMJzmaoRQ7LSuPs0e0wL1CDUJ2w1IYT8DdMTl4aqETZSNW1k+jXdwLH6yZlNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577582; c=relaxed/simple;
	bh=1ux+xSBSlv/xiADt8MtIG2LdaEypUKwbopRe9WvTu48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nwt/gLf1Um5xvTYjEfioG2tb+lcZtcyJrPlldM06UDXQ6ESIpSQs9kLglG/1XD4BHgYD20TXeEeroS9AK8G+cwTiNOQSG5opB71ogCdlNg1l+4y3xPliokJiZdiow+w5nMh9hVnjI2UnW/ZFezvVJ7DIG1UUtJFo37EAsfq6yj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gccvFY0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tjgqSTgg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gccvFY0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tjgqSTgg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 43233EC072F;
	Wed, 19 Nov 2025 13:39:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 19 Nov 2025 13:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763577573; x=1763663973; bh=fEqdSVnUsa
	E81IPPljEvuO+4CAE2eiV5riDR/QAXV9w=; b=gccvFY0IjgRXMQ+ROSj/FdUktW
	E5IirSsuWxz4wkn4kE38/thvv7mFYAaQThkSzbnawXMqUJIihpi/fEQdUcdiWyaM
	9rktifufp3uU3I4UUUKv7WPjd42WZEIJfsVesUfKwhoUoFEnPS4iSTdqafneM6t8
	jRMz/whnscnOv67TzO39kfbUVzJmWMVY++9RORQ4BDYNlRb0w0vveaH6yQW4OP32
	My9QrH96jtcTRWVgq50oa5xZQ3DuaiGzazbm+wN95jLHVTzkJGICGJiEybLoWHdc
	8MKPcXOuOOQ3cvDZwOi/6jTJfh0rO2BiBJtXtlslZX+HrqOebF9gtN20HPJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763577573; x=1763663973; bh=fEqdSVnUsaE81IPPljEvuO+4CAE2eiV5riD
	R/QAXV9w=; b=tjgqSTggt+aVM11yR8HyBQVi+HfmIDUADhSd4o22JBRIG7dcTfR
	IFzfc3yM9tXeLJzi0G5RoF4FdCCoelYBC6ucXC62boESnvJePlqVr/2JGN7Uk2XL
	MVCPcd3P74dodVy1x0JNb+L73vCj6b2uyUc8SXDVGP2M1Di5MNyVKavGQa91JCro
	0h8PRBfbr2sXtByy3Xo+6LSXvJA5/AcBHDNrrGFF8x+xpAP2kNOSuBL5srl8U5MF
	Ak+BRPpoxQ1Qcber/k/JPCvA4RKVECpDXr7h91BdiH6PjqqOVw5dAdDkBaiqiZQ5
	qxTRaVOUxv1zgpGzE0AXVglpPDiSQPRnTOA==
X-ME-Sender: <xms:5Q4eaU4tJNp6wZi8sF-0pHNrcnRHAwQEajTDsZm6v_tNSx43ncWTCA>
    <xme:5Q4eaf577D4mqQCwZt9q11sgd5OObG8uid3Z8UBoDjKQdKZan3MiXg6JbKkMVhJ75
    avvXh8OwCeZ2DrOF91xQq69Z_tPfIVh81XuvhTU2hQhCeLRUu1gsg>
X-ME-Received: <xmr:5Q4eaaGNffzeKuF7P1Vmk5-xJnwAJGWZjIruRTBGUITinKY12YRbjHUOP5cBizGoLP5xtFLyVTQRCCJq3rAhNeXdjFfSC36pxdcy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peguvghlihhlrghhfihusehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopeguvghlihhlrghhfihusehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5Q4eaXXx112rNo6IPAqnllp8DpkB3otJHFbZQUzHyNeFxlu-A7ID1g>
    <xmx:5Q4eaWU9gIhYpWbYrPlzfrljiNo4_MBIrhPvJP9aOuExwSm23IVgXw>
    <xmx:5Q4eaVLCkre4XZZGPNvH5ivH5dC6r7eIIFhAXL4fDUybcfNT_shV3Q>
    <xmx:5Q4eaeA9yMrpdhrsnyIws2sn4orphBkObDSCFxREFDPnHa1DikW9lg>
    <xmx:5Q4eaeXKt2D3QeevZkQ3dlPRsEsL_anMPShTAm9_qxHvl4ldzGgg1Ooo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 13:39:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Delilah Ashley Wu <delilahwu@microsoft.com>,
  Derrick Stolee <stolee@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Delilah
 Ashley Wu <delilahwu@linux.microsoft.com>
Subject: Re: [PATCH/RFC 3/4] config: read global scope via config_sequence
In-Reply-To: <9d8af4e6164002b8096fc03fa8189a670133bc77.1760058849.git.gitgitgadget@gmail.com>
	(Delilah Ashley Wu via GitGitGadget's message of "Fri, 10 Oct 2025
	01:14:08 +0000")
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
	<9d8af4e6164002b8096fc03fa8189a670133bc77.1760058849.git.gitgitgadget@gmail.com>
Date: Wed, 19 Nov 2025 10:39:31 -0800
Message-ID: <xmqqms4hc1ek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Delilah Ashley Wu <delilahwu@microsoft.com>
>
> The output of `git config list --global` should include both the home
> (`$HOME/.gitconfig`) and XDG (`$XDG_CONFIG_HOME/git/config`) configs,
> but it only reads from the former.

", but" -> "to match the information given by the command without
--global, but".

> This patch introduces a regression. If both global config files are
> unreadable, then `git config list --global` should exit non-zero. This
> is no longer the case, so mark the corresponding test as a "TODO known
> breakage" and address the issue in the next patch, config: keep bailing
> on unreadable global files.

That is rather unfortunate, as we do try hard to avoid deliberate
regressions in our history.  The reason why this step cannot be done
without first introducing a regression is...?

If the reason is "it would make a single patch too big", perhaps we
can do it in two steps, one preliminary "git_config_sequence() learns
an extra barf-if-no-input parameter that causes it to return error if
no files in the specified sequence exists" step, followed by this
change that starts using git_config_sequence() to handle "--global",
which uses that new flag to ensure that there won't be a regression?

>  	if (opts->use_global_config) {
> +		/*
> +		 * Since global config is sourced from more than one location,
> +		 * use `config.c#do_git_config_sequence()` with `opts->options`
> +		 * to read it. However, writing global config should point to a
> +		 * single destination, set in `opts->source.file`.
> +		 */
> +		opts->options.ignore_repo = 1;
> +		opts->options.ignore_cmdline= 1;
> +		opts->options.ignore_worktree = 1;
> +		opts->options.ignore_system = 1;
> +		opts->source.scope = CONFIG_SCOPE_GLOBAL;

Very nicely done.

Thanks.
