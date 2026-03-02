Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17845282F19
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487631; cv=none; b=Yf7AmXZDkaQzBfNojPdrC+VPvZDAuQwO8g4wApvwjvSPNa3JOWRjovFL8ix/vaQrn32lVGw6rRD7Hhxx1yumiNhjJj2NjRCSGTO6LD8etGbJp0MpWzy3TB8ZDxFE8fo0IUVKJPjEDD78n+9Kpnz89uplG+tljbGQEODeFq5Vp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487631; c=relaxed/simple;
	bh=GKaOn9oIPRSyzsYlDqKjefJE7MONc13h/Amqfv1VUOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XRU7ItGB3hcI4aAchA5GIcf1lhFFhn4S0hVI/FY5MgKNcYg/4ELJWRX9HZrvpLG/BfSFq6d2KmjOeLVJItcs0G5Jw2eI0SWmUKmRsbmj19keDSyAUhJnc51Yypp/IeDkCrnoqY50LyVhVBLHLns9L1GCfSBlj3RUvrSiPyUufII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KNUNynVq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXsVSjbO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KNUNynVq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXsVSjbO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 51410EC05DE;
	Mon,  2 Mar 2026 16:40:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 02 Mar 2026 16:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772487629; x=1772574029; bh=WbhPkMSSIm
	49i7XUqmMhiHOGc+7z3hJ/BhqN0b1mPVE=; b=KNUNynVq8EEEsyk8FVWaB4N8QQ
	H1AiJEyCS+8bJ7TUiq9NBCHq/KAJI0Sv16jd9FTQofpAvsWGyn7kvDfEPMxUyMJT
	pRofKg3mDAIIDhisKHSuziEUcTH4qxkon43si+Q95BOh4G8VmhAOG986bT0vAn2o
	pGIZh4PJHgnE0PmWnTmf3mjKHQuL393YjkhyhPaJEw3THL6NE6DFIR/AMPaAAO+C
	GgCiGogE5wnRpJO+qglTojyJuxEgY5uFwu0SgmRIdQ20/QrQ8g9SSMzuOyzDGZaU
	CyKVCtc0w4U4Cqn6QA7dGDnCXrfQgPwxrKQaNPFPJ8XWecZO7GVBnnI89S8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772487629; x=1772574029; bh=WbhPkMSSIm49i7XUqmMhiHOGc+7z3hJ/Bhq
	N0b1mPVE=; b=PXsVSjbOQVpEkZBBZMOYkQqp8PkwNd7PPfy3qmk5eTCdxWiouKO
	mIuYJ0bL0HFkyVAydLTdHHHx28xwxsp9GTQCOY9Ks3Jv7cUuW7/1J5UA/2dEAtyl
	cBXzJ5jb7VuZGkgsAfTvQZxNKGPhavirDoIzBHXgYRk6Av7iZb+6cy7LLr2R66OH
	clCzm/a9qK27cIBpmrw+2h+dEmQmM1QaK8DIcJLfNfFmuZjUghJdglG4/5Q6vx16
	90L789P6UnmTpDQi6YhKAytxec4lu/QPKb7vU0Gd8BHQB6/ouESjGoJTR8TD6W+H
	XfxecyjfTQJMofCfPkIW03rv71iPwnVxK0A==
X-ME-Sender: <xms:zQOmaYOo0e6-MctpnoaT-5kLc_ur4rh_AV4BBk4VNJf6Y9q7XOwSUA>
    <xme:zQOmaSqz3_aTbfGpUuF077_W_8xZwHaNqthoFbbiZmaHVwSi7oa9IRYHUwu084-dp
    NgnF723Gk8Dgytym-GT_SQuXR4YLSJMOZscZlBrTrriO9f5N-rQQwY>
X-ME-Received: <xmr:zQOmaZFfsvfDmA687ajX7PDsGKLSpGewY4Zz8V_uI6fsKkHye3Rn1dAfqEeyMxL8AuTagAiyvSrcNZp03OUz3SKhQmy-yWWKiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptefgjeehvdeivdelheevieevheetgefhudeihfekveffudeuhffffeetgeff
    vddtnecuffhomhgrihhnpehrvggtvghivhgvqdhprggtkhdrtgifnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:zQOmaXpmaHSOBRx62ndKgE2zcFMT3M1YqcVxHO8XAQQqTlF0w4Agig>
    <xmx:zQOmaSYNcwcNRQDKWZfokZHVNhpGogfGs6UhwmCTq1hrkH8Z7hd-0g>
    <xmx:zQOmaQXcBCy9yZdTExE1Rscgh5e-BJfOo6LH9OeehmXrF-7Gm1PKnA>
    <xmx:zQOmab-iYlTE1ddlWA8TW1a1TG2Hso_tSHuWN1O3SlZwPqmH6kXy4w>
    <xmx:zQOmaT9zYyvaI-hyqN0EZu2lo9iF2QHpeHLglHDYPXq9DIc1y2AeVr0B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 16:40:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer
 <emilyshaffer@google.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] builtin/receive-pack: avoid spinning no-op sideband
 async threads
In-Reply-To: <20260302191704.1814567-2-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 2 Mar 2026 21:17:04 +0200")
References: <20260302191704.1814567-1-adrian.ratiu@collabora.com>
	<20260302191704.1814567-2-adrian.ratiu@collabora.com>
Date: Mon, 02 Mar 2026 13:40:27 -0800
Message-ID: <xmqq4imxzz90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> @@ -980,6 +983,9 @@ static int run_update_hook(struct command *cmd)
>  	int saved_stderr = -1;
>  	int code;
>  
> +	if (!hook_exists(the_repository, "update"))
> +		return 0;
> +
>  	strvec_pushl(&opt.args,
>  		     cmd->ref_name,
>  		     oid_to_hex(&cmd->old_oid),

Shouldn't we consolidate the two instances of hardcoded string
"update" in this function by introducing

	static const char hook_name[] = "update";

in the function scope and using it?

> @@ -1674,6 +1680,9 @@ static void run_update_post_hook(struct command *commands)
>  	int sideband_async_started = 0;
>  	int saved_stderr = -1;
>  
> +	if (!hook_exists(the_repository, "post-update"))
> +		return;
> +
>  	for (cmd = commands; cmd; cmd = cmd->next) {
>  		if (cmd->error_string || cmd->did_not_exist)
>  			continue;

Ditto for "post-update".

Will queue with the following change squashed in.

 builtin/receive-pack.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git c/builtin/receive-pack.c w/builtin/receive-pack.c
index 62c576c247..bf5d7e6dd0 100644
--- c/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
@@ -977,13 +977,14 @@ static int run_receive_hook(struct command *commands,
 
 static int run_update_hook(struct command *cmd)
 {
+	static const char hook_name[] = "update";
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	struct async sideband_async;
 	int sideband_async_started = 0;
 	int saved_stderr = -1;
 	int code;
 
-	if (!hook_exists(the_repository, "update"))
+	if (!hook_exists(the_repository, hook_name))
 		return 0;
 
 	strvec_pushl(&opt.args,
@@ -994,7 +995,7 @@ static int run_update_hook(struct command *cmd)
 
 	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
 
-	code = run_hooks_opt(the_repository, "update", &opt);
+	code = run_hooks_opt(the_repository, hook_name, &opt);
 
 	finish_sideband_async(&sideband_async, saved_stderr, sideband_async_started);
 
@@ -1674,13 +1675,14 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 static void run_update_post_hook(struct command *commands)
 {
+	static const char hook_name[] = "post-update";
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	struct async sideband_async;
 	struct command *cmd;
 	int sideband_async_started = 0;
 	int saved_stderr = -1;
 
-	if (!hook_exists(the_repository, "post-update"))
+	if (!hook_exists(the_repository, hook_name))
 		return;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
@@ -1693,7 +1695,7 @@ static void run_update_post_hook(struct command *commands)
 
 	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
 
-	run_hooks_opt(the_repository, "post-update", &opt);
+	run_hooks_opt(the_repository, hook_name, &opt);
 
 	finish_sideband_async(&sideband_async, saved_stderr, sideband_async_started);
 }
