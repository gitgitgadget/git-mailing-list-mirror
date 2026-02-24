Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA73335BBB
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969630; cv=none; b=Wmt70GmUbDs2wKp/y/L/POh6d0yrMc3WZmr+CvVowr6IZoyDF6xdjxpiObzjVXv4g96qWAtcjHMnYHDUxlCYIF0uDnrH89tdGkzeHuUcApn2J3W+XWIeWnhhS3IL5ujYHc2Hw0oWM6E67CxLwKl+vFiZ7TGFYdTiIokKtLDiaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969630; c=relaxed/simple;
	bh=K15vs3VOazZMulacno1mY70Azh3Kw0Vn5KtLvkgzN20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vDudjpRrXj2gj0zPSG5BfKAOuLb9xhCtbzfkymtahTN1YL+j/Z4gIbUbRef8tAcWArPnGoOTmhCwFOfX2sanH7+ngRNZ3ZglshbmqVTDHtsLOv1x0uS5rGNokHzuUwn62ocjPTg+aPWKz11YekR1nH3PZJmG49OhAVEMunuS5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jN6gkklF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P21BQ1ia; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jN6gkklF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P21BQ1ia"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A0FDC1D001B1;
	Tue, 24 Feb 2026 16:47:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 24 Feb 2026 16:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771969627; x=1772056027; bh=YSFqOR92xH
	D1IjEMtwQlTK6Vtw5QHTW7jKJOmh5GtIE=; b=jN6gkklFEuXdJo039BgYJMTC9n
	Nb6o5lDfYOpNH4NNuBx6AP3Wk7F/VnIaI+/mQGMu4sINJyytoShapuQThbOleUgc
	ji3yD2Y4t9Fl9kFyht8YlPbKqs31s6+ZRIsb4OsyI0I0h40Vc4RjPeU27D0deRfi
	szUMraYrGFzGUcZix/kVb8/07wXWGfrJ27iaslqmKBOTQOnZltq2RYl12ei7KDDW
	BgQewynzTePU3e3Ok3AJh5o/YPXo29Gw9FF3CFgbE7tFo8L3CptMwZQJIDnx/ACA
	wSgaT/vNbLsH9N06Q7uxCaUO/9I53XBo83cxRUwBk1W5MSWNkq+rf2YE2ccQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771969627; x=1772056027; bh=YSFqOR92xHD1IjEMtwQlTK6Vtw5QHTW7jKJ
	Omh5GtIE=; b=P21BQ1iaTp0At5c4+xMBilSKouDeYAc5Jf0TaJsEMEHr46DtG53
	9/WHihA9hfuAJLUJyrMKqc2L5oa6NocU+/RTPujc3qjVUcTBCf0AJxNvULvKg3+A
	RcvV3rYSJmxTQG53E0vJtx1U+A2gPNAh80dJ9KrF0EgBEJG3ooS3pbp5acHUbgmR
	1r8lb80tYyXZUTySL7T0bA44pZwKtzshWJYtfWL8dQBncYk7AfbhOPP9hG//utfr
	zxstvQ08GNZms4edCWkGn/tCMNDUsmFF+Bv+tLd5DOmQddd/FQYS3JrBlHb6cM/s
	intS2PWeDJwMOfTGSsFj1frJGBRYm+Xq35w==
X-ME-Sender: <xms:Whyeaecl5VlaHBeJ2calU05qguBYKCpwYPh6c5SQXurW6JUz9O5I2A>
    <xme:WhyeaXSo-_dtuRT0wINgED7waY7NYx09C7J5sqBA7R2szOeECkcguuKQMn_fSA6Eb
    QtofSUeEEGPnpZpszv2-B05m4Foqp0WLT4sXUJVxhfcF1p0mst_>
X-ME-Received: <xmr:WhyeaVuv-yWZJzEFuR9cwx9UqKzfdpk_qmhERerjzlxht8RlwVHVYIEpQjg6BplMlsV1S-vNG8rwks_9L2lm00fY-lpW7-YvXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrghsthgtrghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WhyeaYeJglLQSJYUeGlQtsAXBFk3nVk2W2glLtB1Xlrvrmz00SQzRA>
    <xmx:WhyeafZm1mtglve5YCtgZvrX2pF3P_lAzxAR6ROMy8_yAvPyBxjEPA>
    <xmx:WhyeaabYSqoPrrdM-ZL0DxAkSdJcTmBSt7_zeIv3dld3yY1LMf2PgQ>
    <xmx:WhyeaUKzTvBBBYKyI-ikM2spwdjbM3BRzBPLfGZW-3RIyQgBFV4JJA>
    <xmx:WxyeaRj7Si6PDjoH0_5d9R4xop-6i14UljNJxYMmI2e8JD4xujtSby8R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 16:47:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  fastcat@gmail.com,  Eric Sunshine
 <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
In-Reply-To: <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Tue, 24 Feb 2026
	21:35:24 +0000")
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
	<pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
Date: Tue, 24 Feb 2026 13:47:05 -0800
Message-ID: <xmqqv7flervq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  static int run_command_on_repo(const char *path, int argc, const char ** argv)
>  {
> -	int i;
> +	int res;
>  	struct child_process child = CHILD_PROCESS_INIT;
> +	char **envvars;
> +	size_t envvar_nr = 0;
>  	char *abspath = interpolate_path(path, 0);
>  
> +	while (local_repo_env[envvar_nr])
> +		envvar_nr++;
> +
> +	CALLOC_ARRAY(envvars, envvar_nr);
> +
> +	for (size_t i = 0; i < envvar_nr; i++) {
> +		envvars[i] = getenv(local_repo_env[i]);
> +
> +		if (envvars[i]) {
> +			unsetenv(local_repo_env[i]);
> +			envvars[i] = xstrdup(envvars[i]);
> +		}
> +	}
>
>  	child.git_cmd = 1;
>  	strvec_pushl(&child.args, "-C", abspath, NULL);
>  
> -	for (i = 0; i < argc; i++)
> +	for (int i = 0; i < argc; i++)
>  		strvec_push(&child.args, argv[i]);
>  
>  	free(abspath);
>  
> -	return run_command(&child);
> +	res = run_command(&child);
> +
> +	for (size_t i = 0; i < envvar_nr; i++) {
> +		if (envvars[i]) {
> +			setenv(local_repo_env[i], envvars[i], 1);
> +			free(envvars[i]);
> +		}
> +	}
> +
> +	free(envvars);
> +	return res;
>  }
  

Doesn't run_command() let you unsetenv in the child without
affecting the parent process?

Looking at run-command.c:prep_childenv(), it seems that you can pass
"VAR=VAL" to "export VAR=VAL" in the child, and pass "VAR" to "unset
VAR" in the child.

Or is it essential to unset in both parent and child while the child
is working and that is why we unset in the parent and then restore
later?  I find this highly confusing.


>  int cmd_for_each_repo(int argc,
> diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
> index 512af34c82..d55557a934 100755
> --- a/t/t0068-for-each-repo.sh
> +++ b/t/t0068-for-each-repo.sh
> @@ -10,7 +10,7 @@ TEST_NO_CREATE_REPO=1
>  test_expect_success 'run based on configured value' '
>  	git init one &&
>  	git init two &&
> -	git init three &&
> +	git -C two worktree add --orphan ../three &&
>  	git init ~/four &&
>  	git -C two commit --allow-empty -m "DID NOT RUN" &&
>  	git config --global run.key "$TRASH_DIRECTORY/one" &&
> @@ -35,7 +35,17 @@ test_expect_success 'run based on configured value' '
>  	git -C three log -1 --pretty=format:%s >message &&
>  	grep again message &&
>  	git -C ~/four log -1 --pretty=format:%s >message &&
> -	grep again message
> +	grep again message &&
> +
> +	git -C three for-each-repo --config=run.key -- commit --allow-empty -m "ran from worktree" &&
> +	git -C one log -1 --pretty=format:%s >message &&
> +	grep worktree message &&
> +	git -C two log -1 --pretty=format:%s >message &&
> +	! grep worktree message &&
> +	git -C three log -1 --pretty=format:%s >message &&
> +	grep worktree message &&
> +	git -C ~/four log -1 --pretty=format:%s >message &&
> +	grep worktree message
>  '
>  
>  test_expect_success 'do nothing on empty config' '
