Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B18635D
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864137; cv=none; b=useXE2GTD9xUTfQNtHndZoBI+0x7NRPWP2jFUg5S7aDTe6qf1XmNDipzinZTUkQ3IBp5JZ2dN6aUw1MziGQVl9R4WHXqzkzLXSNkDWROwfcK67SX9LfbfwGblcPjcjVigy5ZAvZloWJV+nJMvvSm4xJTa+XocubVBpvE5TTXIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864137; c=relaxed/simple;
	bh=OhuuvLAzXfBUJtmzxuRYIifux1MuRkp64l+jJcffW0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpUXcDuPsC5FZHR/GK3jmdG2prCPZKr7fZc2UmwPkq4EX+vEHIZ0hzR8UmsQ5Tz/ZdGM8QVy5YkvmTBXsmyYrDsffgcHq9ZiVSEECyfUceIszglSeTmPaCKG/8SvV2BBgttrzYIRhz67qZdLF74qbf7chb3VuXRjhTReurcWMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T47a/xkX; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T47a/xkX"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c7e5fb8c38so895197fac.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742864134; x=1743468934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd3oltE/uxbCecctEkRNByk8f5NSGLoeHxJ8n7hm3Ew=;
        b=T47a/xkXVEAa49o8kkCePpyeF17izEXHpTmTgZx3Pb1AzvLgQcCnmDNZnM8GhCMCVW
         5Hj0uY2QtfquZj/IzLTRtrpd6jN8Akaa8/eK4qQM/4CFWYCqGRLjmcqQOHPnLMX73hJj
         J27oIkwoclkoW28zTm8DcNWsX/9dmITEfo7He5t4a4WEBU58/A9A/7HMbFCH9jqpB0En
         vaBaBJUfuVetD66Cp/Ajtu4WDMEJ4Cw+MzUsznmEE06lpTAaIAXyUgcbphVerIBCPIHO
         Wz3T6WLg5O9Y4rm1txyGohk1Ox3oeysjonp/4SBPIC7rUPSk1fwnZKZcrO2wq95SZBC2
         XKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742864134; x=1743468934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd3oltE/uxbCecctEkRNByk8f5NSGLoeHxJ8n7hm3Ew=;
        b=rf5/XxcGhph7Vm1iHTwb6M3iYJ8k0lrSByBCkBFEzzgkr45HXO/2I4G+XsBVzrxwq4
         6naHzkmOHdh5kGzm00QVOSEwzCL0zrnn+2vpq64d64ofw8E7Cb5wPqAEQXmhytXXnmsq
         depgqD687zNluRjCvAVZaT873GSAlBEGlk1FR987bcdUK5rEk9i2ZEmhw9rnwvGkSL8U
         yax47a8TYgyc2cisXfe9CvXJjdNDVm7icsm2/agoUezZHAjLKN/ybkM9OLU96ZpHdcuU
         bD7Af84jk/oY+3wpGeWFWbCDxfJJUPI8Byr7sge3nzHBaKkdlgnkuwnT8RdIj0WVMqHJ
         5xvw==
X-Gm-Message-State: AOJu0YxpHHbT/GdtJ5G6IO5g6mEDFWb85YRq2kx6lvMqgkxabK32ZmUI
	+L3hzUAHVPmqIJ7LEQYm5zcZq7CNLD2JKIr7hucStKbnDixZ+4UX/XL0ng==
X-Gm-Gg: ASbGncv4ETo5LoPNzk7qO+gc7LrXjMxhFaUI0Xjp2lVMnktsB/JFWz6KP75ZVworZJb
	jsyAYrQF+V1ZLGxUYx+SLsYlBFjYx1xjQDBNenW/VsUK9fuaJ5VPJnLSbQ2fgbQFEWED0qCQ7JT
	8An11F8EQHUg94pHEYzhoFqxFlzERPVI8lZk6MrVRAIirnlh9SCFmJ9aTBaSzSZg/j3zFoo8f2G
	wc2eA3b2lhJ+b69MYI2FEchMtUjtkOx3KQ60KzX//iJX/aEXImhf9ecvVd24vFSNV4Frg0D5IoE
	l0Wdk4BbIdhTEpBgWLOqgHxEvPv48FpSPx4dC/6Ov5Ecbo8dcgcD
X-Google-Smtp-Source: AGHT+IFpCrjLuPQ4DW7l/ab/7Wsmq51VgwAn5EbY3owu1qOfsJiRRik6hLgSuMapP+tHWkFb0kFQVA==
X-Received: by 2002:a05:6871:1c2:b0:29d:c832:7ef6 with SMTP id 586e51a60fabf-2c78051a29bmr8995475fac.39.1742864134309;
        Mon, 24 Mar 2025 17:55:34 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0ac7bbafsm1735316a34.65.2025.03.24.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:55:33 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	alan@norbauer.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 3/3] advice: allow disabling default branch name advice
Date: Mon, 24 Mar 2025 19:51:48 -0500
Message-ID: <20250325005148.1771502-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325005148.1771502-1-jltobler@gmail.com>
References: <20250321231639.180762-1-jltobler@gmail.com>
 <20250325005148.1771502-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default branch name advice message is displayed when
`repo_default_branch_name()` is invoked and the `init.defaultBranch`
config is not set. In this scenario, the advice message is always shown
even if the `--no-advice` option is used.

Adapt `repo_default_branch_name()` to allow the default branch name
advice message to be disabled with the `--no-advice` option and
corresponding configuration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 advice.c        | 1 +
 advice.h        | 1 +
 refs.c          | 3 ++-
 t/t0001-init.sh | 8 ++++++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 1df43b7536..e5f0ff8449 100644
--- a/advice.c
+++ b/advice.c
@@ -51,6 +51,7 @@ static struct {
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
+	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
 	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
diff --git a/advice.h b/advice.h
index d233cfc693..727dcecf4a 100644
--- a/advice.h
+++ b/advice.h
@@ -18,6 +18,7 @@ enum advice_type {
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
+	ADVICE_DEFAULT_BRANCH_NAME,
 	ADVICE_DETACHED_HEAD,
 	ADVICE_DIVERGING,
 	ADVICE_FETCH_SET_HEAD_WARN,
diff --git a/refs.c b/refs.c
index 118465271d..bf9a40d6af 100644
--- a/refs.c
+++ b/refs.c
@@ -664,7 +664,8 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 	if (!ret) {
 		ret = xstrdup("master");
 		if (!quiet)
-			advise(_(default_branch_name_advice), ret);
+			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
+					  _(default_branch_name_advice), ret);
 	}
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c49d9e0d38..f11a40811f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -830,6 +830,14 @@ test_expect_success 'advice on unconfigured init.defaultBranch' '
 	test_grep "<YELLOW>hint: " decoded
 '
 
+test_expect_success 'advice on unconfigured init.defaultBranch disabled' '
+	test_when_finished "rm -rf no-advice" &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+		git -c advice.defaultBranchName=false init no-advice 2>err &&
+	test_grep ! "hint: " err
+'
+
 test_expect_success 'overridden default main branch name (env)' '
 	test_config_global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
-- 
2.49.0

