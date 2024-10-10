Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74464198E9B
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594834; cv=none; b=md6TIIf19Y2KHpUgD8px6yP0qGKe5XbNqVRjXPWxiv8BrdTZrZfERK1AU/72nmwmfshcXz+38sCR1HEmMmEfEe7cHWuQlKbzFAn7Ku8afOrmiA1oF8SwUEj0gmD2tpsNFrUF5n2MqGmYD2lU87dknDm9irAQuIPXaNi871BAcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594834; c=relaxed/simple;
	bh=Vcvb0nR92lOFed98s8bI4oiZkqRzSbPwumLQW+uwlwU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MzSonaVrlyhxzpxcxijNPkPuDNyz/COaOrRMe/zjUumYLRJC+LqZrpp1jKpVIhDGAIpGR8O7covhStuXW7MZh2ME/r1x8y25bWgO2vkhSonRfZ1KEpUUU5r1QiViNGTAiKiuRNlieJSTgsEIhgbDZaln9q8iK7frpZqukBFdIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdKSP8UE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdKSP8UE"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9932aa108cso214326066b.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594830; x=1729199630; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NldXoQFsMKP5XRjZG3Zqfga+bbRSOVsK8atZ/eWris=;
        b=WdKSP8UE+MJmSKQoks7hv5ul49wH91tuSo/AiKfJ4XjN/6wx6i9ZZLwiV/R+VFIaq8
         srYAMyHxMsjhitxOfTWTcZzzwYoYewZtO+S9URVnl3//BVgqFebWnmCFFKlxxZCJM+M/
         L+eFEg5x/w/mMYPj3A1GOkgbpn1YBOvUf10jh20Of5LwEFhww0z5EwpME6B4couZzukI
         sBTDRUU1dtIzv/cuZhWN5wXfFbfHM+iKrl3IjWGkmyEGYO+WJhLM+4Tnn69B+uz0jSXn
         lX7xbjaGGtIYQ5Oityni8uh7SOaLIL78JUcBeeP5qhmO8OqMTQHnlPIM3p1VQ7gzhGYe
         oGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594830; x=1729199630;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NldXoQFsMKP5XRjZG3Zqfga+bbRSOVsK8atZ/eWris=;
        b=baJrO7BkbDHLCA9cafT7sUihXw+EIzub/TGmEdaMjAcRqHGbhq1IPl8wiKlkjSAoed
         BVmhf+xpnP5lgaP34mm1SFcJp0HtTWlSMGjF+H75YlOYozZsVByQk7jfwSgpWzDHLukl
         +SW6bVyj+CHnBb5RrfYvy44SR+UsSdN6Z+j4kWkO+XK/UMCWaJHXWMnrSe0S2Yk/1Z3q
         KT0JYiGlqXl+O+CvlXhyRTSv7yb6H+waftvsJympZZNXr+LxYT3gL+4khv8tKnAClesa
         v4+8JhsnhPhURdOAUuY8jlMvsHeSWINwZbHg7zMGVfU+WZFrXAYQH+f7zTY3oJuI6iR3
         dRYg==
X-Gm-Message-State: AOJu0Yx0iYUbNtZ3hiSPRq/rqPcFPHzPZp8QbzPKEV4/Vk23PKT2pyH1
	9kXSIdq7iwwToz2iYAA3uHqFNAgKwZ2DvqF49b7imTfL7vnQSgYXn6YKRw==
X-Google-Smtp-Source: AGHT+IFrdHq0EMD7kFc1Y9iUjWyDErRy86dvJ8gs9IuR4wkgghLgIAbi3pk8POS6kgLXWByxz0ViZA==
X-Received: by 2002:a17:907:f797:b0:a99:7c14:919d with SMTP id a640c23a62f3a-a99b96ad6b6mr24653066b.50.1728594830126;
        Thu, 10 Oct 2024 14:13:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dc679sm137001166b.167.2024.10.10.14.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:13:49 -0700 (PDT)
Message-Id: <d59b85b529865793c652d983d71a9fbb7e16b3e3.1728594828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>
References: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
	<pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Oct 2024 21:13:46 +0000
Subject: [PATCH v4 1/3] git: pass in repo to builtin based on
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

