Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0998221262
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494555; cv=none; b=hUD4AU+UnUGXNlDJA6r1T/6bfte3D/z204ZkUfhG7r5oDLGLmPlI/Wq0qgZKfKybbdi47ken1e/aoTVAoa5k/dNnhHDLWEfehikSB+IhxHhD4hGqUnlL+0Ejovr5vQXZkIK1pCeQpwhxsRongGZdcz6HY0mV8FHM8zchEf4Ho1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494555; c=relaxed/simple;
	bh=O1aO0RkHBKN0wC3ICcFE7lAo+DSUwYgXOHSUZDJQUAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LsgguVBD55I1u6/z4iPPGfCWvei/c1FTZ2edt8SYdQCuhDQMaTYQo9ra1ZhwJF8h1gKDO8hq7EluWy/y3Bk9oTGmuk2tQn4v3zU4RvWB3gBSlt4QV+oL30qMaYd4GNkuqR8949HrIx4FasFD/tBaIZK6eUIleB09TzciTwJq1P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xKKqBZH6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2BSFd+W; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xKKqBZH6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2BSFd+W"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A375C25402E5;
	Mon,  9 Jun 2025 14:42:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Jun 2025 14:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749494552; x=1749580952; bh=iRWMU4XXhA
	IR1AV8Fpq2I7FqAiJCKKbRK01EHjcupF0=; b=xKKqBZH6DLKkLL/vlTHohjacmM
	wZ/AjsJ1s3aDTHjfL3bLPUAhPcdDEWvIjJGQYgWEXsuFs06n+XH0MvMPOj8fjSzN
	HbI6UXwK60rfWz7HvwiQxd+OluwnTof8YxSNrVuNsmkZgxNketzpmewLxrAUX3SD
	l7XX+dJ7rCqhlosA+LauE2SezvlnjZdjgYpl/bbWlBa9cYgky5bBE214IqS3zlKy
	dZm2vskFpmEtUsrFiRtOQoJvvyxAUTt2/5QW1W4aQ6PGHoEANgu3U70Gx/EIblfJ
	nRFbSYmx9iM/Yt1pMXFklzgrWb8LqKb3F0wvQgxCOuNXNebgaGmloIaokiFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749494552; x=1749580952; bh=iRWMU4XXhAIR1AV8Fpq2I7FqAiJCKKbRK01
	EHjcupF0=; b=V2BSFd+W7Pd8ZmwGkYxo/9ypTDbgsr1KONl5wZsyGc0cQi02pdz
	MfahtQGxCRFCYyRy4lti0X2vJ8y6ixLtsHbA/ahp4l/0cPm7NZ1ByajH/PQszDWa
	crcBFcLPdCXbXYMCg+OpS26e9J738DsdzVKOtoGaDZY1YEfaxcjEg99dT5uSZ9tZ
	/KUdIN5s2k16jxD9jmLb/IDRPnD3HK+/zVo1lcpy13fGsPoou6h1L8ybmOsfZPfb
	PWHwAU6JEK20iBaxJ9LMYz2FXXJZR+PIf3Ohvviefmmpaxbhmw6d8doX1iKWECop
	LvLp+Xhe1xdMlba++anXYg4+LGPIfdBBAeA==
X-ME-Sender: <xms:GCtHaG5Xs38okGqe3j_fN2JUw1MX0erxmbHCKcDIgkn2VNa9sCAc2w>
    <xme:GCtHaP4pR8WXuBlO4YwKc4WyaPGpIbMTC5RrObnHlxim-Nh0iDzvqtrD426qDBFQC
    dEC9Fyq47FCBWH2DA>
X-ME-Received: <xmr:GCtHaFdtj-Bcz7sI9rnbzSPkFLnNTJQSqWgrmjto5Yp3vD3FFGJTAUI6Z079M-MfbW6ax6cYA5bk3fkCgblbITsapVAQCDLDpghv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GCtHaDIkZfwRlF4AXKJnWSTGopCozssbR5snYwvai-GpQ8Rijw253Q>
    <xmx:GCtHaKIZ8UtZgwvt2YQvGaPqmevk4LcFUIilMWIG0A2Qoczi8-f6Dw>
    <xmx:GCtHaEwS7pCTVrEOLv6p3zEBh7Kt4hQTyAVHK8lOPyZKbf_Gd8DXVA>
    <xmx:GCtHaOKje9LJlXSZdRM_XEo8U1gkADin0O6vNDwU3MOchaK-fT5rDg>
    <xmx:GCtHaHVjhsMcOYd8_Iz1QJkeOUHBM_2VK70_U6z9xAmq5vOFPFe0IaN_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 14:42:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao
 <ziyao@disroot.org>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v16 07/10] imap-send: add ability to list the available
 folders
In-Reply-To: <PN3PR01MB9597440624DB4F9871F069FAB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 9 Jun 2025 07:20:38 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597440624DB4F9871F069FAB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 09 Jun 2025 11:42:30 -0700
Message-ID: <xmqqh60orc2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> diff --git a/imap-send.c b/imap-send.c
> index a4cccb9110..f03a92a2fb 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -45,15 +45,21 @@
>  #endif
>  
>  static int verbosity;
> +static int list_folders = 0;

Let's lose " = 0" here.

Do not explicitly initialize globals to 0 or NULL; let BSS take care
of the zero initialization, instead.

> -static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
> +static char const * const imap_send_usage[] = {
> +	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>"),
> +	"git imap-send --list",
> +	NULL
> +};

Good.
