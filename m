Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495862F25FD
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608274; cv=none; b=cigcVl9qg98+0gCRf3QC9t17Rro6/fyBEDg6Bkh0VwLmGqKTimWJwPta/6g0tkg9vHU6j508eZPVgQjwm/v8zk7XjmO9kYRBVfZ3beQEf1t8bWz5h+SeoQBmGIvyzcXUsHBB3T5P5EVBypCmzITvKInOnRhxoawg38o2aKHhIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608274; c=relaxed/simple;
	bh=b+r2yHFFyGJncQJHxTyrbJYVznrRG1c1MtNlh8tUg5Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MpJaA4iqRHVp27w5id82PcUC4fbVPFB15277RL0v4YoeN8dSZvsSiRlJFO6CNemT39PhdFd7KCkM4pdsIsB1cJJyWCF+CK+p6j5LE6ZAwA0LDlU//4FY9MK81lcSoQMt6QR03mKJCVO0ItcOBXOFH2D6iZXGBTuJAAuLLrSXiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JubwlWzZ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JubwlWzZ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8bc53dae8c2so2127695485a.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 02:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767608271; x=1768213071; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LufYpI57WxnPblQadlLbmJPabn7oCC2FjbzTKiOo4JI=;
        b=JubwlWzZyt3ivLzc7YYXZ6L0ZydzoZC9EPJSSF3CHZScnfO8WBUv5AKqqpWtuCZi2y
         3Yw+CsJSqKvA9ETFaHrmZtgr1SpfOL3MXtJn/NGvk4rSOAgeUnCQrjeToQzdfpX5rTxL
         Bf0LzxED+J4vcOqbGxgVRisV7AYeXWMWaMf6bh8la5h18EITFsvM+aG7Aux+Xofz/5VF
         yROlHwB2BcKrILIah9fijVwfzBAH9P/l6AQRPTKJZIs5b3eJt/CJBNSpI/+snWpvmgKK
         YZWjciwIaq/b/8ZGvT5nQIKkhzS/Gt7oHcI+IED8yOdiY28d8Bv4yjuDW0ZjiGkGWqg/
         DJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767608271; x=1768213071;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LufYpI57WxnPblQadlLbmJPabn7oCC2FjbzTKiOo4JI=;
        b=lCSnjJ7l/ukqbZFOEA2UlQfpmHCOjXGRLL5prEqI1019jRhp2Bqvn8N7ydu1lzrEIc
         o9oOKXMhxFaZIvfd3UY2Prdq2z0RhYzVXCe4DPO8qXJ3Glaer8fC2QQ/W1mrijMVT5zp
         Kkq/LJ5u7wuMcE/pJSvTbPOpodjnAdpdDQbJgiEdwCcQpsMJVGhuLIXcZ0PhzZ5fw4A3
         daD9rzflWOpQETFFCg6xcxd2E3C2pQriH325ogQasPX4LNhHvh1q7PPM6UUupVmhQL5Z
         9TL5wEpdwdrx8ZZ7VuHuwOxzvC//7hK0GVGdH1rQc+qcstPYwv4WGuBOKPHmjBXaJEXe
         VaRQ==
X-Gm-Message-State: AOJu0YxIw3jwzzoYAGc0gZFAAF9Fa4L76Mw5bEcNDlIYUSfsCA4LctYN
	PzhXiBQZXHZV1/oVUJ/K5sqbqgjqr4tVoOGf9rFzUmUGSFOkbh+wx2fj2NgXqw==
X-Gm-Gg: AY/fxX45N/T6DOK5/jLPmeqLlaVPosElw9cSKCaNRbgHj1Xz2/cjbbWxP48sTrg0eCn
	HtcvGlgY0Msy5IYY89bijeoLM9BpsBiOLr7RlSO+Itj7q5Ihm913tpjj2SH3MG0cmEOp11zW93r
	yJNrC6Xky0dRaA785jEFeVaIURTz/oSnFAaWZLmyZyt8OGUEnS1knL0GNFdH/xbw7M3MKYaPv3r
	CZyK1/CY/oackTU3Oxx/mAs17cBx2OyYNhWQdnL5Nq9onEGDTRG3eRaONmg0XLE0O3iymgWgjcx
	Necz8wYnYtvV5T/s2qwKSFYkMlLgo9DQX8eXiAe4q/oKgq/boe5sJroxM6mL4EO2W1bOSIGBjIi
	GNXEC/MmbhhzgMAWguCt3V4d5OJ5C/CruKwXF9ah21fK9KEWfVhqHhVSR85X5zr5W8EUfFsAoAC
	Y7U9B2vGoEAtl6HA==
X-Google-Smtp-Source: AGHT+IH0vPF2eOTeT0SYg/sRy/vXnd1740a5ADJY/w8ULuBhVhvjbZ6x//SkfVZHd7XbrjMmKypxzw==
X-Received: by 2002:a05:620a:28c6:b0:8b3:274c:d9f8 with SMTP id af79cd13be357-8c08fab5bf8mr7479797985a.22.1767608270641;
        Mon, 05 Jan 2026 02:17:50 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f880bsm3715982885a.32.2026.01.05.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:17:50 -0800 (PST)
Message-Id: <pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
References: <pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Jan 2026 10:17:47 +0000
Subject: [PATCH v17 0/2] status: show comparison with push remote tracking branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 169 ++++++++++++++++++++-----
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 397 insertions(+), 34 deletions(-)


base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v17
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v17
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v16:

 1:  cf4e9779c5 ! 1:  b62a9feb4d refactor format_branch_comparison in preparation
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      -int format_tracking_info(struct branch *branch, struct strbuf *sb,
      -			 enum ahead_behind_flags abf,
      -			 int show_divergence_advice)
     -+static void format_branch_comparison(struct strbuf *sb,
     -+				     int ours, int theirs,
     -+				     const char *branch_name,
     -+				     enum ahead_behind_flags abf,
     -+				     int show_divergence_advice)
     - {
     +-{
      -	int ours, theirs, sti;
      -	const char *full_base;
      -	char *base;
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      -			strbuf_addstr(sb,
      -				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
      -	} else if (!sti) {
     --		strbuf_addf(sb,
     --			_("Your branch is up to date with '%s'.\n"),
     ++static void format_branch_comparison(struct strbuf *sb,
     ++				     int sti,
     ++				     int ours, int theirs,
     ++				     const char *branch_name,
     ++				     enum ahead_behind_flags abf,
     ++				     int show_divergence_advice)
     ++{
     ++	if (!sti) {
     + 		strbuf_addf(sb,
     + 			_("Your branch is up to date with '%s'.\n"),
      -			base);
     --	} else if (abf == AHEAD_BEHIND_QUICK) {
     -+	if (abf == AHEAD_BEHIND_QUICK) {
     ++			branch_name);
     + 	} else if (abf == AHEAD_BEHIND_QUICK) {
       		strbuf_addf(sb,
       			    _("Your branch and '%s' refer to different commits.\n"),
      -			    base);
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       		if (advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
       				    "git status --ahead-behind");
     -+	} else if (!ours && !theirs) {
     -+		strbuf_addf(sb,
     -+			_("Your branch is up to date with '%s'.\n"),
     -+			branch_name);
     - 	} else if (!theirs) {
     - 		strbuf_addf(sb,
     +@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       			Q_("Your branch is ahead of '%s' by %d commit.\n",
       			   "Your branch is ahead of '%s' by %d commits.\n",
       			   ours),
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +			strbuf_addstr(sb,
      +				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
      +	} else {
     -+		format_branch_comparison(sb, ours, theirs, base, abf, show_divergence_advice);
     ++		format_branch_comparison(sb, sti, ours, theirs, base, abf, show_divergence_advice);
      +	}
      +
       	free(base);
 2:  06cb483f61 ! 2:  1348542edc status: show comparison with push remote tracking branch
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +}
      +
       static void format_branch_comparison(struct strbuf *sb,
     + 				     int sti,
       				     int ours, int theirs,
       				     const char *branch_name,
       				     enum ahead_behind_flags abf,
      +				     enum branch_mode_flags advice_flags,
       				     int show_divergence_advice)
       {
     - 	if (abf == AHEAD_BEHIND_QUICK) {
     + 	if (!sti) {
     +@@ remote.c: static void format_branch_comparison(struct strbuf *sb,
     + 		strbuf_addf(sb,
     + 			    _("Your branch and '%s' refer to different commits.\n"),
     + 			    branch_name);
     +-		if (advice_enabled(ADVICE_STATUS_HINTS))
     ++		if ((advice_flags & BRANCH_MODE_PUSH) &&
     ++		    advice_enabled(ADVICE_STATUS_HINTS))
     + 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
     + 				    "git status --ahead-behind");
     + 	} else if (!theirs) {
      @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   "Your branch is ahead of '%s' by %d commits.\n",
       			   ours),
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       			strbuf_addstr(sb,
       				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
       	} else {
     --		format_branch_comparison(sb, ours, theirs, base, abf, show_divergence_advice);
     -+		format_branch_comparison(sb, ours, theirs, base, abf,
     +-		format_branch_comparison(sb, sti, ours, theirs, base, abf, show_divergence_advice);
     ++		format_branch_comparison(sb, sti, ours, theirs, base, abf,
      +					 base_branch_modes, show_divergence_advice);
      +	}
      +
      +	if (push_branch_modes & BRANCH_MODE_PUSH) {
      +		strbuf_addstr(sb, "\n");
     -+		format_branch_comparison(sb, push_ours, push_theirs, push, abf,
     ++		format_branch_comparison(sb, push_sti, push_ours, push_theirs, push, abf,
      +					 push_branch_modes, 0);
       	}
       
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success 'status --no-ahead-behind tracking origin/main shows only main' '
     ++	(
     ++		cd test &&
     ++		git checkout b4 &&
     ++		git status --no-ahead-behind >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch b4
     ++	Your branch and ${SQ}origin/main${SQ} refer to different commits.
     ++	  (use "git status --ahead-behind" for details)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success 'status shows ahead of both origin/main and feature branch' '
      +	(
      +		cd test &&
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success 'status --no-ahead-behind shows diverged from origin/main and ahead of feature branch' '
     ++	(
     ++		cd test &&
     ++		git checkout feature4 &&
     ++		git status --no-ahead-behind >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature4
     ++	Your branch and ${SQ}origin/main${SQ} refer to different commits.
     ++
     ++	Your branch and ${SQ}origin/feature4${SQ} refer to different commits.
     ++	  (use "git status --ahead-behind" for details)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success 'setup upstream remote' '
      +	(
      +		cd test &&
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success 'status --no-ahead-behind with upstream remote and push branch up to date' '
     ++	(
     ++		cd test &&
     ++		git checkout feature7 &&
     ++		git push origin &&
     ++		git status --no-ahead-behind >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature7
     ++	Your branch is up to date with ${SQ}upstream/main${SQ}.
     ++
     ++	Your branch is up to date with ${SQ}origin/feature7${SQ}.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success 'checkout shows push branch up to date' '
      +	(
      +		cd test &&

-- 
gitgitgadget
