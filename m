Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018528376
	for <git@vger.kernel.org>; Sat, 18 May 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716028377; cv=none; b=QFmmHX2df0u0YQvtMUvwDqOXgnr9lZnGBuQt9FjE3A/jWoUqwcV5n91X/rYz2UIy6nzcLws1OFo+2No0GA0cZrJx6zpikr8aJXEQ1e0gVtcHA2KFfviITUgy5Yv9CvplfcfZXBVYWAh9UYidpf6nXuf7eymEB1JQNj571RHXEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716028377; c=relaxed/simple;
	bh=NACUjCKOyFbBT9Jcvg+gdcvRvWOxx7KfWVnfiD/FlN4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ER8mSNlkC8rEGEsn1TMswQkzgVpMYiWxN+Dtx8yo/r59QdszVu+y2DNWTUyT4CONrSOPo9EcA5+WNrhakafn7Qw1F7fzlxmKmeXIl8J8PPO7PmHLHfXS2JmH0qRerbTfye1P49Nx3RAXjV0PBxecVljBVWLmMKw4PVAygD1W5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRakvG9M; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRakvG9M"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420180b59b7so7826915e9.0
        for <git@vger.kernel.org>; Sat, 18 May 2024 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716028373; x=1716633173; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6d3NikhGkK867apaAyTM/p8Uvw8q8n1MJ0T9cVpYng=;
        b=hRakvG9MPwS4oPvxBXP/mE6chfK48u6/ZukeW8ruQSB+/4ZYJLFSk/VphK2GCJOhZJ
         9Rkz398bAXIXvwj1zDL1i6V8T8Z6HKYSb0UGyRzLaeG8U15ZI6U3XsY8vfKcMLfCFkrf
         nsWrAiOvcoWmRfOS1KW0seCSVPpfBwpdc0KIQze+kXI3KFokhXGxV3olAoPk7hYDwOVz
         NN9bEC7Cr8d9IX6IMAigPJ2SbOwBxD56lRmkv5vmHLVBf83PAYzQitZNMlAmOvWzAaAv
         040BBaAMB5CSBONZnHMujlc83nvOfO+sYehoij1suBX1qKF53AumurjFAf8CatDRHgyJ
         +D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716028373; x=1716633173;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6d3NikhGkK867apaAyTM/p8Uvw8q8n1MJ0T9cVpYng=;
        b=GgrBNl23oONOvHnLcy7Bf6pxuanL5PYcffEXzhA+3wSdsHWy5/weNsqGxYFxyPsgVk
         OJU12GyFPQ85silZ0WYM/PoyHQ48JfqRh/RYdDTjHrWegMvph7urbKVkStnv2AMCyBqq
         ORh30cnwUAKMNJggQOF7Beq4ucYblv8pMKpvVCr7fMJV+258lkj1sbJUAxn3Z09bMCOa
         OQYDHJLWfBOtAWIPmHsRadSPnp3xcNqYn7sEg4aOoH5v/RWg8uSer1CVgu1lafSZBvvR
         ECl3eNE6C/zoc4DT/t2j/0zEEYtxOlqROfYyzJry97KGMnEyyNXTFjqQbj6CeqQPx7NQ
         z6PA==
X-Gm-Message-State: AOJu0Yy3bk7ypciVBlY0mXdntqi+LcAkZLUlCCtCzQemC/IwEtYDJU1z
	ctADW0atc5kLNTFcmV7zzrPJZ2gLcBzNMZxvGoI9wt6Dcw/2oWA+ALwhzA==
X-Google-Smtp-Source: AGHT+IE50Dt3PT4RUHurVORMzJ4OHeMBaIaz+b06LYaRfkMf2DVTpHn/F/9/gQAemiNP7Ojfmonpog==
X-Received: by 2002:a05:600c:1d83:b0:420:1157:95b4 with SMTP id 5b1f17b1804b1-4201157977dmr167852985e9.12.1716028373012;
        Sat, 18 May 2024 03:32:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4202de3a79bsm77189255e9.6.2024.05.18.03.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 03:32:52 -0700 (PDT)
Message-Id: <57db89a14977bdff01f8f82cb4d6f85cc49d4b55.1716028366.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 May 2024 10:32:41 +0000
Subject: [PATCH v2 3/8] Revert "core.hooksPath: add some protection while
 cloning"
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This defense-in-depth was intended to protect the clone operation
against future escalations where bugs in `git clone` would allow
attackers to write arbitrary files in the `.git/` directory would allow
for Remote Code Execution attacks via maliciously-placed hooks.

However, it turns out that the `core.hooksPath` protection has
unintentional side effects so severe that they do not justify the
benefit of the protections. For example, it has been reported in
https://lore.kernel.org/git/FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io/
that the following invocation, which is intended to make `git clone`
safer, is itself broken by that protective measure:

	git clone --config core.hooksPath=/dev/null <url>

Since it turns out that the benefit does not justify the cost, let's revert
20f3588efc6 (core.hooksPath: add some protection while cloning,
2024-03-30).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c        | 13 +------------
 t/t1800-hook.sh | 15 ---------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/config.c b/config.c
index 85b37f2ee09..8c1c4071f0d 100644
--- a/config.c
+++ b/config.c
@@ -1525,19 +1525,8 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
 
-	if (!strcmp(var, "core.hookspath")) {
-		if (current_config_scope() == CONFIG_SCOPE_LOCAL &&
-		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
-			die(_("active `core.hooksPath` found in the local "
-			      "repository config:\n\t%s\nFor security "
-			      "reasons, this is disallowed by default.\nIf "
-			      "this is intentional and the hook should "
-			      "actually be run, please\nrun the command "
-			      "again with "
-			      "`GIT_CLONE_PROTECTION_ACTIVE=false`"),
-			    value);
+	if (!strcmp(var, "core.hookspath"))
 		return git_config_pathname(&git_hooks_path, var, value);
-	}
 
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 7ee12e6f48a..2ef3579fa7c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -177,19 +177,4 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 	test_cmp expect actual
 '
 
-test_expect_success 'clone protections' '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
-	mkdir -p my-hooks &&
-	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1
-	EOF
-
-	git hook run test-hook 2>err &&
-	grep "Hook ran" err &&
-	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=true \
-		git hook run test-hook 2>err &&
-	grep "active .core.hooksPath" err &&
-	! grep "Hook ran" err
-'
-
 test_done
-- 
gitgitgadget

