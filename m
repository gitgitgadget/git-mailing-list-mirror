Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DA33507C
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420204; cv=none; b=CUaDHOOHYLuClg1kM0O8pFjJrVqDysw6iQVdyL3P8KpbbfBmzPk7W4CWfsj8i/yJkMJGaSf/BL7fDHkXUeLM4KZvDRHax1Zfj2bvXCHbdkXdEy3foHZDKe/+a+kAExT6xKtl3nPglNTNGzufI/qKInwVaMPSIT/KD+PFawWhWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420204; c=relaxed/simple;
	bh=egashDc/OylS+mWi6e3U6mf2wSS7stFV8csy5H4kDhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jPza0Rl/21R2tNNppBvM54F774nB13WRaxvP5RzLP7vfi448SGGF5kG7Lk43T9WLtBi2LHUf0KWvqO/wX3RANKZ3GMbn8c1Fd+eMRARckt0bWSXoY9hYfbbRqFqgdHOTjyECdX4DOnjw8ilj8dqgXUeYlRdWl7nbjV8LzvpPVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hOLAxpJj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fwgl21jY; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hOLAxpJj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwgl21jY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 261E77A026C;
	Wed, 25 Mar 2026 02:30:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 02:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774420201; x=1774506601; bh=mZV5miT6kt
	YoC0DMrmjjp4Cw0lVJIzpAbf6vhdY9oGY=; b=hOLAxpJj3NOLz2SerY+WALs/be
	O8Xqsqd8MBAffqY8zN1+/CNYd1OA44Bq27M/DNWs7yKfXNJJDIlTP691HcApRFzw
	Y17DRfa+AJerux393KX+J2zw8nk3Kd0EYmKHwYXbHKjSfJhuhY25g+RWj97n2DW8
	eb7hf0HLs+YPF4CGMT+tINGA6xOCoZEe/3ahr/Sra5rglwoFhsczbmDcvSPoDuII
	8ZpB960eLmrhcVseMjyxkiQ8H277mliqyGgfGWCpyFXMBAIO2wur9Ytf//M10Zvh
	GQviLi5C8QMcVB+rtrpmUcwaTSCS2DsOqT02mMt37c+aPWObHyhxI/BDuMPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774420201; x=1774506601; bh=mZV5miT6ktYoC0DMrmjjp4Cw0lVJIzpAbf6
	vhdY9oGY=; b=fwgl21jY5mnk8oxnBn51xLVLUh1AW//xNdiLlKhlJBPWvDtJOFA
	+j+biIbzL9LHTXeEfAeeLC9skn9YlpcFNCx0K7lRG226d7T5R8kdc7jri+v+Y9N8
	OGAt5bgRYUll3gtJdlaUUF9mH+emiMC2kKQXch+AxY4siP7xwd1HEQqMG/tRqDgd
	sFi9u8Ix7gvrQ7caqjByNN5zzXeZL+yJURD70o+1N5j9RMf06qc46HMmkiCEPddK
	4HtAESkbIjJlTqzjQT3zn0AGaVos7JF0+10kxfDTJ4qcPSA14RaqEik09Kz8oU1y
	P2uo8WgQoL3wEGggrELEzTH6Cuz8BBEBl0w==
X-ME-Sender: <xms:6YDDaeZBSfk_4mFDjwV48q2wLB8w4-fV-VuO6W1KmtxeQj3To7xl0w>
    <xme:6YDDad-ZOaGeBlG0CnvDA4Nbk0MzL11KPonYjRzzG5eMdvfAxI6DvfpQ9nrpEQJ40
    bYQszTokFCruilxDETS-lxhNrWs7ItjxVu23ypj-q7urwyr5SJfDg>
X-ME-Received: <xmr:6YDDadYW_xS5-5V8I9lVX8yxxsxuW9DZOzgz1rlBpiqHAzW0hVLNM2gb5FGW6Ph4l5wNjHs4GwXVe04aqr3LkZuFrVEZpUTVmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:6YDDaXf-3fBQjYWSjboMXpom2LuM_qlsI3yp2AjsUe0aJWsOGf_sag>
    <xmx:6YDDaaka9iTCbbZOt7AMY6om74tnouasmGCZOUJGlq1W7bNFEo1tTA>
    <xmx:6YDDaX2ni9PJvMWaYovi1AX-yLQpFSFw2KVJJCx3fXBuXaVEfHtzjw>
    <xmx:6YDDaTcH7et3w6JNspdKqZIknJ_mJc4QrBhKrRBtErcDQoVnD_Q3eQ>
    <xmx:6YDDacypgdD2ijYV-6g-kZ-FCK5RjGfeblgffqfc55Mn6tg2EwL4F7Ri>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:30:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  newren@gmail.com,  phillip.wood123@gmail.com,  karthik.188@gmail.com,
  johannes.schindelin@gmx.de,  toon@iotcl.com
Subject: Re: [PATCH v5 2/2] replay: add --revert mode to reverse commit changes
In-Reply-To: <20260324220401.47040-3-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Wed, 25 Mar 2026 03:34:01 +0530")
References: <20260313054035.26605-1-siddharthasthana31@gmail.com>
	<20260324220401.47040-1-siddharthasthana31@gmail.com>
	<20260324220401.47040-3-siddharthasthana31@gmail.com>
Date: Tue, 24 Mar 2026 23:29:59 -0700
Message-ID: <xmqqh5q4xvyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> diff --git a/builtin/replay.c b/builtin/replay.c
> index 2cdde830a8..d3c1d920f0 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -83,7 +83,7 @@ int cmd_replay(int argc,
> ... 
>  	/* Parse ref action mode from command line or config */
>  	ref_mode = get_ref_action_mode(repo, ref_action);
>  
> +	/*
> +	 * Cherry-pick/rebase need oldest-first ordering so that each
> +	 * replayed commit can build on its already-replayed parent.
> +	 * Revert needs newest-first ordering (like git revert) to
> +	 * reduce conflicts by peeling off changes from the top.
> +	 */
> +	int desired_reverse = !opts.revert;
> +

Compiler notices -Werror=declaration-after-statement error here.

>  	repo_init_revisions(repo, &revs, prefix);
