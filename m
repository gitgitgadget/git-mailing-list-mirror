Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAE1BC2A
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099049; cv=none; b=BYe8SJS5TOnHA52/pZ2QG0ELpXm+qcQIvSDTSCLOoFUQZ8hyt3gtt1YomkzJ8UgMgelUJx+Eu/AcNYKF9w4Xy/OX9+xrAtqWAs15nqXuMPwSD4HFDc44LS3ge4RGfT9ZaHyIAzalGIDqtfj8pG7y2HGuar6vWbsH8CKhuvIrQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099049; c=relaxed/simple;
	bh=Vcvb0nR92lOFed98s8bI4oiZkqRzSbPwumLQW+uwlwU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lDkU/sFSb6pRSQplIYeV54xRlANZbCoihj9FuRYKU4+5njbL6jYKUsJPI4i9mNmrGB1JgDW9ZXCd1He4sU09bii6CsFcb5Sz7VgszLYxgy4wT0SeV/yDoHSU70a4/qF3ZUaq94bZWF044je3S94lHuT2hMa/6cXUEtuNjayW7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+0eYHpV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+0eYHpV"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so3166388a12.2
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 20:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728099046; x=1728703846; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NldXoQFsMKP5XRjZG3Zqfga+bbRSOVsK8atZ/eWris=;
        b=e+0eYHpVulkFf4qbZ9lQbyzRVavyEPL97ngRwxNhr2oQnhb5aq63hRzDTvaN6IrUgp
         qtDZ3xJfyINX+Y37Hg6hZyuD3o2Sjt1EWeAS/8wANpvBRQ8r4fdnVKSPv/D+dfCHZl97
         7vcAd9VybaHy/5TSv2i3ZpMOTN7jjygLVR5cwmtMzUwZL3sfCcRQz1Y2s9pHsTY7mYSw
         6WerirPvwoawv2qFe51YDYBusZ9W2/VRInyhwKBu2o26deVpWwQ6OcX2Vd8+EJwQPVeB
         0biq87+6ten89D5PDwvMS1901H2Jf5bI+eZjxq36C0HZjS+sHK88b8HuGh/6jI7qY7NL
         HKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099046; x=1728703846;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NldXoQFsMKP5XRjZG3Zqfga+bbRSOVsK8atZ/eWris=;
        b=w//HLGmlww2ZBaCLcEIfrAIs9dyYo1dofI/tHueKgSJ/sLvE8vL9Q2SI1yr55PNj9E
         Kt6l0i0d2KI6l6ckxh/Ca1STUgZ8YNtMaermAyklkk41BINQV0R4tHUwoeN6zejioygz
         kMB9+UN0sTRZRTtQEIYuD7ZY0u+0bF0hOgRSOXbMLwhOBVn7P+uX+M0XJds8V8JQckkF
         S4HMpswnroBk4G+Y7qgBy70Gp6SWuFAnUyiH1AgUFx1r5aGmJpSx7VDnQYUlAwqlBYLN
         Z8BmXHJ+H5M67+opNdf1X1H4PvYaZ2oc7R2JZ71dPOrXvUJBrJlDlflEghUkKy4LALKu
         l0aQ==
X-Gm-Message-State: AOJu0YwxrRlwNDqW4XUuTHLtivIOehwepwwhVT6ZPLK/DbDagp41qV8H
	g6cYwg5ADaGbN8v/rFI7/taa8dlz96DGEmEYzX75D7Z4KZgcmOQbswLFng==
X-Google-Smtp-Source: AGHT+IF5dcjmTON+fQP5Mel5fkrYYroRNnNP7azBEz6m/lVEktH8kHJ8KKl6GqQ1u1Q/S1Vw1LTclA==
X-Received: by 2002:a17:906:fe4d:b0:a90:1300:e613 with SMTP id a640c23a62f3a-a991c077ddbmr460408066b.55.1728099045725;
        Fri, 04 Oct 2024 20:30:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e784666sm75187166b.100.2024.10.04.20.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 20:30:45 -0700 (PDT)
Message-Id: <8009fdb38b0b4c3880588119b99ac5387d398540.1728099043.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
References: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
	<pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Oct 2024 03:30:41 +0000
Subject: [PATCH v3 1/3] git: pass in repo to builtin based on
 setup_git_directory_gently
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

The current code in run_builtin() passes in a repository to the builtin
based on whether cmd_struct's option flag has RUN_SETUP.

This is incorrect, however, since some builtins that only have
RUN_SETUP_GENTLY can potentially take a repository.
setup_git_directory_gently() tells us whether or not a command is being
run inside of a repository.

Use the output of setup_git_directory_gently() to help determine whether
or not there is a repository to pass to the builtin. If not, then we
just pass NULL.

As part of this patch, we need to modify add to check for a NULL repo
before calling repo_git_config(), since add -h can be run outside of a
repository.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/add.c | 3 ++-
 git.c         | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 773b7224a49..7d353077921 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -385,7 +385,8 @@ int cmd_add(int argc,
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
 
-	repo_config(repo, add_config, NULL);
+	if (repo)
+		repo_config(repo, add_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
diff --git a/git.c b/git.c
index 2fbea24ec92..47741be3e4c 100644
--- a/git.c
+++ b/git.c
@@ -444,6 +444,7 @@ static int handle_alias(int *argcp, const char ***argv)
 static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct repository *repo)
 {
 	int status, help;
+	int no_repo = 1;
 	struct stat st;
 	const char *prefix;
 	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
@@ -455,9 +456,9 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 
 	if (run_setup & RUN_SETUP) {
 		prefix = setup_git_directory();
+		no_repo = 0;
 	} else if (run_setup & RUN_SETUP_GENTLY) {
-		int nongit_ok;
-		prefix = setup_git_directory_gently(&nongit_ok);
+		prefix = setup_git_directory_gently(&no_repo);
 	} else {
 		prefix = NULL;
 	}
@@ -480,7 +481,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	trace2_cmd_name(p->cmd);
 
 	validate_cache_entries(repo->index);
-	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
+	status = p->fn(argc, argv, prefix, no_repo ? NULL : repo);
 	validate_cache_entries(repo->index);
 
 	if (status)
-- 
gitgitgadget

