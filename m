Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94771397
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767568888; cv=none; b=GFi/H8s4cyublnaVEgv0ySKkAT4b4PryIwLs+8AWjuRD/kBqufhSdQzcdS7qEdhTomwmNsHLjsUMoD7QQRMHwjp+nAXWiqrxlWJNrx9B+8JAoNxVvRriZ75WBRF8yhN2AJn1FDlPJN8bA5IVFsWeWYk7A+WT2dQ1tu5q7/uGVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767568888; c=relaxed/simple;
	bh=MO2ebjRGKhzapl/imXtLgdYh4xeEvcEKftVqjWM4iA8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mtB/KbLp1hrw/wAKhbPIz+vUhLKRj20bcUloEXKSx8oxNgy4nuV6PacapAzLRLpJYQ+C6bqUHrlMDipOSNzsD9TlQmsn5yzgv1GSmrwhjVpK3ZFC9jkrwEqfo3SOeSO3U8F8uIXA4knjWRWM6Gn38VPPRGNPRn9fidF0GdqWp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzmFCAfD; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzmFCAfD"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c305b7c472so159221385a.0
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 15:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767568884; x=1768173684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyCA/co1WTTK8caenjOZMM/kn0/wdaSC7Q6CA9fbyOM=;
        b=CzmFCAfDTXKyKO4CHqe3qedFaE7cSFf/2YB6w8zu9X9zYvrsmuNlGnVc8qVzaUI3BP
         ux871hMFeB2Wz4gnHFzCEVvbne2mOZDXR2EVrfxLh1O/xmhoGcKkooRZd64UE7vX0DsT
         Nc8JQNBhWaGevRAYWnQPrTb0r1E6cDu5qSzVl+H53IJWdFmfNGJinPxIMjSjvUcWnyID
         wJ4DcTs5H9e/CXuCNthN8wN8iUiGzRYsbbzmADeZgzgtXOx0u4cDtjrwXJJT+zCjMlsD
         kbTTxZGJAua2ksR8Tu5KQgzdfztloEdET72/A2DPR8/iSeWPE3G+jj4HhcxxFaMYWxRh
         mIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767568884; x=1768173684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vyCA/co1WTTK8caenjOZMM/kn0/wdaSC7Q6CA9fbyOM=;
        b=V8CGYgM7fzRolemMt3SCx3V3Sx1M2lBWrADKt3wxmhwKznt6aNDqgyziaW2KnmakQh
         GunI1E2pT5NbIf6IeoVhBKCOje0Yj3YTuDaHZbnM/UXfUjYP626CiuuJAtHh+5AzPUwU
         ljGieNEEXvWpBcUiiW0k26i7VooJbocQivta95hhihrBZggm8Rwnr3Mk34ZaPLkvVKC3
         3WWX9vzwBCzmpG6u0i5R2D3d+Ytv6SXEBWOoWSv1Jn3u5q+T8Hqna74BkIa11rnOKRlR
         dasmc+mWiw5rwuu0TmLeDZsocz1u4f14QLGN2FYSAYxrbLKCOzMWuCyNvJP+DEO0Sa1J
         fpNw==
X-Gm-Message-State: AOJu0YxPaUJQZwDF822xlnyFKGEA0ddSfR2cv8vz1QXochssikM+Nwh/
	UCrJ5rrsCmY59WljKf/DEvrCJbQZZi4LXxNhnLlKshJiNd2nGMDtsZ7P97qg/ttC
X-Gm-Gg: AY/fxX7NmQTcXrO/u5BeCgcekMuhyzIC2ZgPA6426tPrDy22VoB9P0kNhMOjDBxwSK7
	OBiSitk9wKlNkiKXktCZadiyTJLfpLUKvdpK0zH+MIGgu2ff7LK02CojglnOoPeNw4fZ+wsIjhG
	dyuOm9n9p8+WyDtKwjr7JhnSt9oRVs1IIQsO+EefHOAkVLobFY1Y9HuPJdYbQjnStbuLGA/Yr1j
	6//QK9X/KR9DtYV0FI8tZ4Mj9Icdq6sVkAOmBofvhn8QZ1OD+rR7n1No//ZRTR5riNEEumyOhvW
	7TOd49ZPiOk5duY212ZKYf6+z/vDWs+49AcgH1DX+E2TeueYuKsp7kiKQ26UzXEWcvcZdMfp+6c
	l+BUH2r6o53G/baIZJshbddAUmESmFUJG6lsV/Qqe9yTEZ5dVGMHUjTxwC+dUx4mVc3R8Qyxmto
	0qgg1/gyEAIwYrfw==
X-Google-Smtp-Source: AGHT+IFapw49jQI4AM5LAIf6BGNMkwnpPMolJ1eSEQjFYBm2r33nmThS7Pr4lTRyYjCZkWt4Equw8A==
X-Received: by 2002:a05:620a:7114:b0:8be:8e2a:3132 with SMTP id af79cd13be357-8c08fd2d107mr6923526085a.58.1767568884354;
        Sun, 04 Jan 2026 15:21:24 -0800 (PST)
Received: from [127.0.0.1] ([20.102.223.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975ec0f0sm3617787685a.50.2026.01.04.15.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 15:21:22 -0800 (PST)
Message-Id: <pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
References: <pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 23:21:20 +0000
Subject: [PATCH v16 0/2] status: show comparison with push remote tracking branch
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

 remote.c                 | 171 ++++++++++++++++++++++++-------
 t/t6040-tracking-info.sh | 210 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 345 insertions(+), 36 deletions(-)


base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v16
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v16
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v15:

 1:  cf4e9779c5 = 1:  cf4e9779c5 refactor format_branch_comparison in preparation
 2:  a435cf4ce4 ! 2:  06cb483f61 status: show comparison with push remote tracking branch
     @@ remote.c
       
       enum map_direction { FROM_SRC, FROM_DST };
       
     -+enum branch_type {
     -+	PUSH = 1 << 0,
     -+	PULL = 1 << 1
     ++enum branch_mode_flags {
     ++	BRANCH_MODE_PULL = (1 << 0),
     ++	BRANCH_MODE_PUSH = (1 << 1),
      +};
      +
       struct counted_string {
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +
      +	if (full_ref_out)
      +		*full_ref_out = xstrdup(resolved);
     ++
      +	ret = refs_shorten_unambiguous_ref(
      +		get_main_ref_store(the_repository), resolved, 0);
      +	free(tracking_ref);
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       				     int ours, int theirs,
       				     const char *branch_name,
       				     enum ahead_behind_flags abf,
     -+				     enum branch_type bt,
     ++				     enum branch_mode_flags advice_flags,
       				     int show_divergence_advice)
       {
       	if (abf == AHEAD_BEHIND_QUICK) {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   ours),
       			branch_name, ours);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if ((bt & PUSH) && advice_enabled(ADVICE_STATUS_HINTS))
     ++		if ((advice_flags & BRANCH_MODE_PUSH) &&
     ++		    advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addstr(sb,
       				_("  (use \"git push\" to publish your local commits)\n"));
       	} else if (!ours) {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   theirs),
       			branch_name, theirs);
      -		if (advice_enabled(ADVICE_STATUS_HINTS))
     -+		if ((bt & PULL) && advice_enabled(ADVICE_STATUS_HINTS))
     ++		if ((advice_flags & BRANCH_MODE_PULL) &&
     ++		    advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" to update your local branch)\n"));
       	} else {
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       			   ours + theirs),
       			branch_name, ours, theirs);
      -		if (show_divergence_advice &&
     -+		if ((bt & PULL) &&
     ++		if ((advice_flags & BRANCH_MODE_PULL) &&
      +		    show_divergence_advice &&
       		    advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addstr(sb,
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       	const char *full_base;
       	char *base;
       	int upstream_is_gone = 0;
     -+	enum branch_type base_bt = PUSH | PULL;
     ++	enum branch_mode_flags base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;
      +	int push_ours, push_theirs, push_sti;
      +	char *full_push = NULL;
      +	char *push = NULL;
     -+	enum branch_type push_bt = 0;
     ++	enum branch_mode_flags push_branch_modes = 0;
       
       	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
       	if (sti < 0) {
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      +		push_sti = stat_branch_pair(branch->refname, full_push,
      +					   &push_ours, &push_theirs, abf);
      +		if (push_sti >= 0) {
     -+			base_bt = PULL;
     -+			push_bt = PUSH;
     ++			base_branch_modes = BRANCH_MODE_PULL;
     ++			push_branch_modes = BRANCH_MODE_PUSH;
      +		}
      +	}
      +
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
       	} else {
      -		format_branch_comparison(sb, ours, theirs, base, abf, show_divergence_advice);
     -+		format_branch_comparison(sb, ours, theirs, base, abf, base_bt,
     -+					 show_divergence_advice);
     ++		format_branch_comparison(sb, ours, theirs, base, abf,
     ++					 base_branch_modes, show_divergence_advice);
      +	}
      +
     -+	if (push_bt & PUSH) {
     ++	if (push_branch_modes & BRANCH_MODE_PUSH) {
      +		strbuf_addstr(sb, "\n");
      +		format_branch_comparison(sb, push_ours, push_theirs, push, abf,
     -+					 push_bt, 0);
     ++					 push_branch_modes, 0);
       	}
       
       	free(base);

-- 
gitgitgadget
