Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AC18EAB
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718036; cv=none; b=l0joz3hwytOxwjqWKLIeUcsNJW1+bkMcmTpg88pwzWyJZ97kLI63EewujHLQatOOHzeqblDp9g25Hk4s3qjV3S7msyA+NGBXmqkh7zYxF1uJsGoD5epb6w9pwAyx9tklWAPbYcfeR0ic6cZ2H+c2oAwGwFyADRTPTO9GeatJ3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718036; c=relaxed/simple;
	bh=8bgzKwD0hyAP0yDxrOPx4M6993+Xbw21AWXIjJUpo6w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Iadh0xg9eJDgmpRfYexMa1AqqufDzTsZG3iTOniG3YccW2idiVdXtyBAfARCtacg8yGyJgDAKyN9OfVzzkhaBkcVWua5MEVnJ9jfFEFVRiknzD8IodNrsvV/+pMYISWyRw5B11KvraWe5tXEkpOflwsbPcxFiMTidBxDdZpsA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mySvE2O2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mySvE2O2"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5399041167cso2465161e87.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727718032; x=1728322832; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEllTuLuNtjQ93H7t5Hv7yEVIGBQW6XlLdpJkeouHk0=;
        b=mySvE2O2CcMu3M2fuWF1uqnWvlLX7lq2Dw4Q7gi2O+mvF9pEsiXeINngyJza7X6hCx
         XoicSRJ41SDbgMtEKQvV5TngPFa0gNXtmAQETtYTLl2KZKHOqqJ/iOTrxCZGBNwjXWA+
         2JnksUUCXBGzp83E4rLSy+pjRKjVQe3w2rYTY0yBdKVjCOQu96/Xuh0WC0QY5bvCiBy9
         8V8hjOtdfEcPJsEbaSY8Ldohc2pcKYUqqoeYKZYK2zah8rsJe5EBHkAYE+OAgpiixDox
         qgI1dUEKZlJ+yb4DbM+pJm/XVsWGNUSU92mIDs5QzHUQffGkjHntLO6SzWWqN8SAMo3i
         ITkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718032; x=1728322832;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEllTuLuNtjQ93H7t5Hv7yEVIGBQW6XlLdpJkeouHk0=;
        b=trs98P4I+WCzBHYsdN4Qmpdnz3IvU5l7lvOt3ouZz91lwyyHZFybu2412DDHsnBHC5
         MlZlTDqyrBrkX3noIhTY7m1SPOU6MVMsKtzBIqFebzrGiTKQp6o7vSHfhlknFWRCPTUe
         pqN6v/4dbBJAeaXPyMOeyN8bSNBo+8nNsUenp1MCxKsKCHiA9KwHTkObhRzHTi2Mf7FO
         a6Lojllm6F8ZDHSjgRPZVlX2kXe9lI2hR4aY4HFfita2i3IEZaxyU/ZnvwAR2FitdvQs
         Ow8S3AQORuDfCje/KzIifFMraBfOJzpPkKfc/GWrIw0kE7kBjOVRuX57cQj6U/lSDDhh
         RSrQ==
X-Gm-Message-State: AOJu0YyNf+pwIn8TEp8X5L00LdofVYp4ZDFMS5YdvLGZNZFewEWfeLaI
	BOqyq0+Tq9WCwIFkku7B20qen4YQL4Gd8rhSZt7MmfabFXdwo0Dlmt3Mkg==
X-Google-Smtp-Source: AGHT+IHCEgB2V36zAY9LpbZHUKBc9vpM2bL/prRT2qF8HF34zMXPf7SsXVOKI3RLGvEwuJ2bNwe6tg==
X-Received: by 2002:a05:6512:130f:b0:539:905c:15c5 with SMTP id 2adb3069b0e04-539905c1862mr4219112e87.35.1727718031907;
        Mon, 30 Sep 2024 10:40:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2998634sm555884266b.206.2024.09.30.10.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:40:31 -0700 (PDT)
Message-Id: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 17:40:26 +0000
Subject: [PATCH v2 0/4] Remove the_repository global for am, annotate, apply, archive builtins
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
    John Cai <johncai86@gmail.com>

Remove the_repository global variable for the annotate, apply, and archive
bulitins.

Changes since V1:

 * in patch 1, only pass in repo to the bulitin if the repo exists

John Cai (4):
  git: pass in repo for RUN_SETUP_GENTLY
  annotate: remove usage of the_repository global
  apply: remove the_repository global variable
  archive: remove the_repository global variable

 builtin/annotate.c |  5 ++---
 builtin/apply.c    |  9 ++++-----
 builtin/archive.c  |  5 ++---
 git.c              | 11 +++++++++--
 4 files changed, 17 insertions(+), 13 deletions(-)


base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1788%2Fjohn-cai%2Fjc%2Fremove-global-repo-a-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1788/john-cai/jc/remove-global-repo-a-v2
Pull-Request: https://github.com/git/git/pull/1788

Range-diff vs v1:

 1:  eceb2d835be ! 1:  5d72c31c6f3 git: pass in repo for RUN_SETUP_GENTLY
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## git.c ##
     +@@ git.c: static int handle_alias(int *argcp, const char ***argv)
     + 
     + static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct repository *repo)
     + {
     +-	int status, help;
     ++	int status, help, repo_exists;
     + 	struct stat st;
     + 	const char *prefix;
     + 	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
     +@@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
     + 
     + 	if (run_setup & RUN_SETUP) {
     + 		prefix = setup_git_directory();
     ++		repo_exists = 1;
     + 	} else if (run_setup & RUN_SETUP_GENTLY) {
     + 		int nongit_ok;
     + 		prefix = setup_git_directory_gently(&nongit_ok);
     ++
     ++		if (!nongit_ok)
     ++			repo_exists = 1;
     + 	} else {
     + 		prefix = NULL;
     + 	}
      @@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
       	trace2_cmd_name(p->cmd);
       
     @@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv,
      +	status = p->fn(argc,
      +		       argv,
      +		       prefix,
     -+		       ((p->option & RUN_SETUP) || (p->option & RUN_SETUP_GENTLY))? repo : NULL);
     ++		       repo_exists ? repo : NULL);
       	validate_cache_entries(repo->index);
       
       	if (status)
 2:  1bf2b017dd3 = 2:  2a29d113815 annotate: remove usage of the_repository global
 3:  4ce463defa8 = 3:  d64955a2e27 apply: remove the_repository global variable
 4:  f6c32ec609c = 4:  857291d7f7d archive: remove the_repository global variable

-- 
gitgitgadget
