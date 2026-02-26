Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A69142E019
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122887; cv=none; b=tArPSoXBAOck4TYDzPWfms/rh4/bXiW2xEBwHAShsXvrLT0fWSEl6kstSRbgbkeUK1wBz6k4EZXWm3sDFih6e+zizz+uCw1AwxcfveE/K15+dFVr+xxLT3Kj4in00bd00eFhr7R3tL/wbkQ3OvhLfRQbfuI6MYbqg4AzP7etJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122887; c=relaxed/simple;
	bh=d5UbyfPGzlZj7iSDuN/ZkX9FKM81YO66zpYAaoPAuoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q5vBX00hLdlhDwW7ZzGmyVuS1XyxHsg+DGOfNI25XVCu7eJHxHJV0ih86gUAgmI8MPYjrrpngZmYkl9SnYFfCRPMUyIxyVlQfFVQjGHdzHIa/4kmRkRcCzFAZ6DqhYMkqZALmEiztbtGmIW13/qMwei+mNk2SbqIp1vUC2zpJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MIiOmCjq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSgeXwfr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MIiOmCjq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSgeXwfr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E9D8EC0942;
	Thu, 26 Feb 2026 11:21:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Feb 2026 11:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772122885; x=1772209285; bh=24rxIwIevo
	nnQ0cHw/utLXqY7AkG3WwNFbjwOIncG7w=; b=MIiOmCjq9dpRYyFyPsyPgq2tQ0
	rUO5K/qi74A4k+Qvpdn5Z+mSYIEEpOSxqhaP9ERkd1c7C3f06KwHi4o3TbHXSVnT
	NW/fATrVzqaKy2iVWiPzrL/U/f0lDVCFaD+gsgLYWnm8Bqp/vOPX9a+FLRVJxZ3E
	p4lsEbP1Jj6hr6iobdPOebh/eIBhfaiSzouALIE7pIj3h1+u4MWjZcSK+ckBmYGR
	ADo5zEHD7tr7iYIt1n9Y5GgvBzUMYCm3/MlYBE/hGHDCgCZGsp7xyIvOc6Ld1Un7
	I7nbx3ljoQbUd0/7TFU0n4D17LONnErZ35whCRprj/Sirc01FdVP7BmJ84Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772122885; x=1772209285; bh=24rxIwIevonnQ0cHw/utLXqY7AkG3WwNFbj
	wOIncG7w=; b=YSgeXwfr1OtL54BP2du5MCQU6HzFcnPvRE5vxVWTYt7lOER4HKC
	BShtjqWrgg8XF5RFiQtQG10mhJcbzqaaBUDJBqxN6VIJNHgWj6H6YqKNZdEfm2fE
	ejJpX2DDgXMiCL39mkUi2Bebi3+0Fd+SO7y0kcuuj62s0mcmctx4aP/2CyooYmuP
	17TG+bqlDuYYP0qM7p3oRWTeSFhNuQOB2SPRBHI0nB0A++wGvFbXRofDiTazz6MK
	q+PtMNDimrr4u9XzmJ+jrlLYVBlKpOA7cDWergg3VnGChbsghdkOrjXE/HFgNd+X
	P9PqDmu4aMJcamS8KYNQEtfrrx3PuMM2eQw==
X-ME-Sender: <xms:BXOgaXtJwisKD55SEb2ysIsShMfTvUaVGUPQUqU_lt2ktWhgh8EQZQ>
    <xme:BXOgaXjGiiXie2qzTzlTRnKwtzHLXRwjMGYAZu-7PonDKQ6xQHz2VAN-YSt-oYdK1
    kEJYNourx4_qobH20zJEFuFLiZwAZ1YcQjTIH9ay9pLbxtDuSYkchM>
X-ME-Received: <xmr:BXOgaQ8Pk0S-TQz12WH1a65Dfd3XbiRbATeq8Y-DtNm3WwZWTmnjPuFF6N_Mk2ggWHnIJZe_XWmV0WZR1G6Vzdy6Sffs3P-wMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepfhgrshhttggrthesghhmrghilhdrtghomhdprhgtphhtthho
    pehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BXOgaSsB4qrs2PE2aE1epMDEw-yVp0ZDBKzGC5YQr2D0cEO_-NzzmQ>
    <xmx:BXOgacqvKVV31z1dsL_FLd6b5kugf-08JuiFq5cYh3bTCuckz6yYzg>
    <xmx:BXOgaepSn9EgHsAhO_cf7ljvWA2sWpgfUQsA8rSa6ZuM0L5MmKY6Og>
    <xmx:BXOgaTbaz0NdNpOu3uAexkt2nLRe3bz5V4Yz1-Pm0ACAD9YOWFEScQ>
    <xmx:BXOgaV8ZuuqJY-GAZus9T28TRYRHCo20OASthY7NlLqhNoJ8d0vLzRaS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 11:21:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  fastcat@gmail.com,  Eric
 Sunshine <sunshine@sunshineco.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
In-Reply-To: <08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com> (Derrick
	Stolee's message of "Thu, 26 Feb 2026 10:29:47 -0500")
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
	<pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
	<xmqqv7flervq.fsf@gitster.g>
	<eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
	<20260225131344.GA2139176@coredump.intra.peff.net>
	<08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com>
Date: Thu, 26 Feb 2026 08:21:23 -0800
Message-ID: <xmqqsean4gsc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 2/25/2026 8:13 AM, Jeff King wrote:
>> On Wed, Feb 25, 2026 at 06:44:51AM -0500, Derrick Stolee wrote:
>> 
>>>> Looking at run-command.c:prep_childenv(), it seems that you can pass
>>>> "VAR=VAL" to "export VAR=VAL" in the child, and pass "VAR" to "unset
>>>> VAR" in the child.
>
>> But I really think you should consider keeping config-related variables
>> in place, as prepare_other_repo_env() does. Otherwise something like:
>> 
>>   git -c pack.threads=1 for-each-repo repack -ad
>> 
>> will ignore that config in the sub-processes (whereas it currently is
>> respected).
>> 
>> And for that, you do need to loop yourself.
>
> Great point. Here's another attempt:
>
> static int run_command_on_repo(const char *path, int argc, const char ** argv)
> {
> 	int i = 0;
> 	struct child_process child = CHILD_PROCESS_INIT;
> 	char *abspath = interpolate_path(path, 0);
>
> 	while (local_repo_env[i]) {
> 		/*
> 		 * Preserve pre-builtin options:
> 		 * - CONFIG_ENVIRONMENT, CONFIG_DATA_ENVIRONMENT, and
> 		 *   CONFIG_COUNT_ENVIRONMENT persist -c <name>=<value>
> 		 *   and --config-env=<name>=<envvar> options.
> 		 * - NO_REPLACE_OBJECTS_ENVIRONMENT persists the
> 		 *   --no-replace-objects option.
> 		 *
> 		 * Note that the following options are not in local_repo_env:
> 		 * - EXEC_PATH_ENVIRONMENT persists --exec-path option.
> 		 */
> 		if (strncmp(local_repo_env[i], "CONFIG_", 7) &&

Minor nit: !starts_with() lets you avoid counting bytes yourself and
hardcoding "7" here.

> 		    strcmp(local_repo_env[i], NO_REPLACE_OBJECTS_ENVIRONMENT))
> 			strvec_push(&child.env, local_repo_env[i]);
>
> 		i++;
> 	}
>
> 	child.git_cmd = 1;
> 	strvec_pushl(&child.args, "-C", abspath, NULL);
>
> 	for (i = 0; i < argc; i++)
> 		strvec_push(&child.args, argv[i]);

If argv[argc] == NULL, then here is where we want strvec_pushv().

> 	free(abspath);
>
> 	return run_command(&child);
> }
>
> This comment details my findings from comparing the list in
> local_repo_env[] and the top-level options listed in
> Documentation/git.adoc. That's how I was able to find that
> --exec-path sets an environment variable that's NOT in the
> list and we want to be sure we don't set it.

Hmph, wouldn't we want to use specified exec-path inside ...

    git --exec-path=~/my/git/libexec for-each-repo sh -c "do things"

... "do things" script when we find Git related binaries?  Or am I
not getting what you are describing here?

> Should we add the comparison to EXEC_PATH_ENVIRONMENT as a
> precaution to make sure it's not added to local_repo_env in
> the future? Or is that too defensive?
>
> Thanks,
> -Stolee
