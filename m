Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1367E110
	for <git@vger.kernel.org>; Sat,  3 Jan 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445240; cv=none; b=JiblgpmIKraoKWN1l9RU5e0bsXRRerYl1GlIO0Zzj+DOlvqErl7NDWuXXSZER8oseWRlw28xpl05lO+yVYZbsru+DtPbzhIVyYGH5z3EIR+DWmnJo4mvGAPx7nCsa65I4McFreBqv98rZkhnJL30Nll2UhV8jAL4heVH/fZZ7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445240; c=relaxed/simple;
	bh=2nj2OSqIpeeTQJQNcfzbLxAOaj9f2ENHyMX70j64Xxs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Hp/AvlPgJYWE/lTwTBcYCLbKkAYkJGbkKm+j2pXUCS/DmEAAaz+DImuHroVbx32kF3YO9AmNCSunbKJ34aNH9z87VYaLyfiH1nQQ6bKdLpki56S9s/GJjcC6SZz1ZSc4NP2dzFDH9hFPGUYzLr6pXx/yj/kT8Q00Lm68uJ+E2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGi6Kkpx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGi6Kkpx"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b29ff9d18cso1500234685a.3
        for <git@vger.kernel.org>; Sat, 03 Jan 2026 05:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445237; x=1768050037; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBA5vS+r4ECRgftp/gJ/SuBLin1dOrPU0bWByGwQCsI=;
        b=iGi6KkpxN7H023wmHXaI9skf57V4P89cLiRHgHDVLUE0z8WI1onSCOPFvHW/TbwUTn
         hIv1Z5RrSnNpgv1Bnuv26HTAptRTpqGs/HLLI1qlSJVHBkAvmxtq0hsjbsyZsP9LTLcV
         VDGigFLodPC3juYlBKcTB1YVnCp3tCKx/vYE/J1J6d6Ne7pS4p49kwBIlmpmC3zdV6ts
         7M7POmts3nYsCwxn4aWI2A7+GcuwGZFGYXEZ0hkNcei/Fl5jpS5nfy1X28bzdfSYi1gG
         dag92sqdfb9Y8cEDknEAIqahPl5uOq3v51o2zNBnHu0a+h5KeXcCpVIi7NLq6NaTLPG8
         sbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445237; x=1768050037;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KBA5vS+r4ECRgftp/gJ/SuBLin1dOrPU0bWByGwQCsI=;
        b=TZWBvbVNi9yGaj69TfYrU6XxZvYdPF1c8I5eE5zTutzOCTv01WtJ80JIAmvzb4eGFk
         GBoPNFkcY3cnfnfxJqEPu+r3ubJPAJWfrc4Uflt6WDDS+5k/PUF2IMlgiCCzjfqyGhG/
         Pe5mG6B1SmGZljHSbv//8KG+RGyy1zY3dbi/7+EslCtJu4XpsFhdihBFE1rhFvGC/wuy
         Uc7r0fcgnZikpmpipTMezwqAmPNRPwY9RK9shqeXBUEAPNPFTRzWMdVvRxxkrqjaTClk
         HcyUq9LAtQaCd2yHFiFrlhEW/sQJCXUJVp9TCM2IirhnBRHBxe5gg3Us7b/JsgeZnUbN
         /KSQ==
X-Gm-Message-State: AOJu0Yz2KkBpYCUpixTb8tZopJLr/TW8q/iFy7PW++MoSn7vEkzQuHaO
	Vkl0ALbZ9bk5j+vv2jMxlzJ0d0wgv3vt8WYRr7eT5lqec4H9BlPJ4jpuUEvBsg==
X-Gm-Gg: AY/fxX7aMqXIGtN1qHNf0/wJvMM2cTTwrc98XBZ9Op3c97MhxgJDjeBS1yBeZ+CKwmr
	VthMjs9l4AnIo1SrtyhLykmfLL+B7OgVh5lcnSDqFhRY8zQ2ntsFEU8qka1ZQshUJc0Kh+7X0FO
	y4oitYgVdJmaluPEBCC4oCgdYFwMi1NkjMYhgclr79Wd27kiJsnl10TuSoXfF+Eb8O3gd9vdIyZ
	Zdj5zdBlKBr1H6fv8icAkdVLWerdEqrPssm69LhQ9oPdKXy+cWEx8MPNgM5gqJ5oT//tJ3B1B6T
	S+zGZ/hzUtAClfjLwFxRNWrHqKD+PaOz9645kJUvnY93CEBToYKgvMlAe5NlwrEtiQX14ZVFuJs
	1O6/Ym54MOZd1fBvKO5rOZsODYbj6K6mxChUH1GYTsunPzPKjglUe73aS5Ce6QGBHbnpV/cGk1F
	y7OebZ/Wbee3Uo
X-Google-Smtp-Source: AGHT+IHpb2JNLxFhczBPDq1jEpJZbqs1McYYFodiC6eiFuud+9msMZqTrsA1vb7iZ6v42KEtH+yJJg==
X-Received: by 2002:a05:620a:170b:b0:8b2:f962:79aa with SMTP id af79cd13be357-8c0906edaecmr5758300585a.72.1767445237158;
        Sat, 03 Jan 2026 05:00:37 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c09678afa6sm3432656285a.2.2026.01.03.05.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:00:36 -0800 (PST)
Message-Id: <pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
References: <pull.2138.v13.git.git.1767409701.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Jan 2026 13:00:34 +0000
Subject: [PATCH v14 0/2] status: show comparison with push remote tracking branch
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

Harald Nordgren (2):
  refactor: format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 171 ++++++++++++++++++++++++-------
 t/t6040-tracking-info.sh | 210 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 344 insertions(+), 37 deletions(-)


base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v14
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v13:

 1:  a2c160c53e = 1:  a2c160c53e refactor: format_branch_comparison in preparation
 2:  891239211e ! 2:  b9b2f15498 status: show comparison with push remote tracking branch
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
       
      +static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
      +{
     ++	struct remote *remote;
      +	const char *push_remote;
     ++	char *push_dst = NULL;
     ++	char *tracking_ref;
      +	const char *resolved;
     -+	struct strbuf ref_buf = STRBUF_INIT;
     -+	char *ret = NULL;
     ++	char *ret;
      +
      +	if (!branch)
      +		return NULL;
     @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_
      +	if (!push_remote)
      +		return NULL;
      +
     -+	strbuf_addf(&ref_buf, "refs/remotes/%s/%s", push_remote, branch->name);
     ++	remote = remotes_remote_get(the_repository, push_remote);
     ++	if (!remote)
     ++		return NULL;
     ++
     ++	push_dst = remote_ref_for_branch(branch, 1);
     ++	if (!push_dst) {
     ++		if (remote->push.nr)
     ++			return NULL;
     ++		push_dst = xstrdup(branch->refname);
     ++	}
     ++
     ++	tracking_ref = (char *)tracking_for_push_dest(remote, push_dst, NULL);
     ++	free(push_dst);
     ++
     ++	if (!tracking_ref)
     ++		return NULL;
      +
      +	resolved = refs_resolve_ref_unsafe(
      +		get_main_ref_store(the_repository),
     -+		ref_buf.buf,
     ++		tracking_ref,
      +		RESOLVE_REF_READING,
      +		NULL, NULL);
      +
     -+	if (resolved) {
     -+		if (full_ref_out)
     -+			*full_ref_out = xstrdup(resolved);
     -+		ret = refs_shorten_unambiguous_ref(
     -+			get_main_ref_store(the_repository), resolved, 0);
     ++	if (!resolved) {
     ++		free(tracking_ref);
     ++		return NULL;
      +	}
      +
     -+	strbuf_release(&ref_buf);
     ++	if (full_ref_out)
     ++		*full_ref_out = xstrdup(resolved);
     ++	ret = refs_shorten_unambiguous_ref(
     ++		get_main_ref_store(the_repository), resolved, 0);
     ++	free(tracking_ref);
      +	return ret;
      +}
      +
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	EOF
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'status shows remapped push refspec' '
     ++	(
     ++		cd test &&
     ++		git checkout -b feature8 origin/main &&
     ++		git config remote.origin.push refs/heads/feature8:refs/heads/remapped &&
     ++		git push &&
     ++		advance work &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature8
     ++	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
     ++
     ++	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status shows remapped push refspec with upstream remote' '
     ++	(
     ++		cd test &&
     ++		git checkout -b feature9 upstream/main &&
     ++		git config remote.origin.push refs/heads/feature9:refs/heads/remapped &&
     ++		git push origin &&
     ++		advance work &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature9
     ++	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
     ++
     ++	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
      +
       test_done

-- 
gitgitgadget
