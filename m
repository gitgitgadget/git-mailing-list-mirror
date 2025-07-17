Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D1B1D86D6
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721669; cv=none; b=WL92GHSH3TT95bUR7VjS3/+cS2mo3AhWhLO4fPo4O0j48PHjZrjGmUXW20q2V+OmddoIshHHIkSZ7Wz2umQOum2FNVZASqgLIPIukNgC258P28dgEQ1la5sFMiGijw7ICKUifE2EIwMjvSWfgE3oaT0MttYD9oHEnsZ0j+0+c6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721669; c=relaxed/simple;
	bh=JJvvQgPQSzrDgnVGeNjE7p1bIPLbQT6NvLouLA9sNC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wd56F1iLFtnP+JRc3zSmZ0Qyt4+8Ttx7erh2cVRAhGxzA1jCyKqSjHwV162OO0+Orj1L6cLaXICYWzAwIgGuMsxzdfy6/7oGWbhenVBH09THgGL13xz4/rZ46eXeuU32RLoRNt4ktupMy9f2uIhidfsQQFuYhpmv396J4gw1kcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEqHwE3p; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEqHwE3p"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b3226307787so357817a12.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 20:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752721667; x=1753326467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s2UvKKXzXtnNaDjXQuKqhGbObjV5TVAhriM6D8G7aY=;
        b=hEqHwE3pOxNIrAPrjIlVLI7y76yNTd5mL2kXZd1u4BOoWI43TYBlBSqFikhcpvz6co
         qdy0oBR2GePxS7+JNPslv2zZClmA1NZWYE1uyRXEnIZksgd8tYTo3PH2hPvrfCnFsgPa
         8m922+RPHCWEbz3muGk0+06AomJlvaV3e072V3IYcXNw+gOOkRboYrq+lFkAdk11skzO
         uP2Vz7vUETF4Lf51q/a2q5XovMkBq3/c8aA3BC0fesvkCgPMICGfB/WYS4o6CcDgaHjo
         +/o6gHHe7flRFUYD0+Wru2vrOxF3ELErVwV9eFES7f1tpmHtQbdC65UmMGL+TCEOemEx
         qPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752721667; x=1753326467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s2UvKKXzXtnNaDjXQuKqhGbObjV5TVAhriM6D8G7aY=;
        b=dAHMiN4dVTP1aVUHVxj+i12uOy7BViupz5YsEHlccCZteWAt6ZgErP+cSMNQquE9lA
         s2GejCu4YiYaEpyIzzsiowrwlMtk+H1lkBfwmNgP7OT8KZjwQPVIUXXOUt+vwwLn63+P
         DfNDxMwZAI4M0ONoF8fV6o+ExASD4u4B4q9XHLQzw4/AEPnssx7T45fGgmZZYMVzEPsi
         jEnw/zJ/PmEYVBexvz1pH1KJU1oYp8N9UE/uX9aTIo9LKYDhQ/S98ZA9jvW+IOL1nE6q
         jESpfvr3yGsDF5ctdBImwZbaoE0p6hxadYXbE5yTVbuT/y9Gp/DVCFDluj/M+CZRxKC3
         24tg==
X-Gm-Message-State: AOJu0YzS0yoBRRH8WEw8bVDRuEg8LftocdzwjvJRjFb1seIqVl5KFLVY
	Qj6yTbg8qV8WWa0x2k4gHUH7gdnTVGRTNq46V9V5bC4a3THKotAfIpZQ
X-Gm-Gg: ASbGncv4zp8ETbyA/kmXEUKtVsfjIkNOh05ymraPEHquZWosTPKoVf6l5cLwCnbgwuB
	se+cZtvuyvjwXByFzZE16vohdUDeEo/1GC6JuUR3MIlfqZFlKD5EoYJ0XRDlbX+Md1VcACVnrlS
	93/GKsa/c07L7lFtJFwl2I/Y9KZO5GvY/Zpoh1r4gnxJdqIvP4O960bYXBmVDMfEOvI0a1AiIBP
	+iiTtxl3GJofeK98JExF6xvUIE1UtlIsubuaKRD3dadZPnQKeeQZY8dDX0Tx+tm70ZFIEfX64hM
	e8XRq3LTNUsrwue0KW/qfc6LQPGKdNlnhT0lK1MRtsGtbUR40pYQc6Nvjra+ZoZj9lCxr3Zef30
	/okpPPPjYp7MvDYDasVULJ/Yf3Qf/7EsUUD2jOo0=
X-Google-Smtp-Source: AGHT+IGDRS1alKbV2QY0X7o/JtAUvQNiShn8qJS+9OlGy7pFwIGmgBM21Gl3hTyOV8GWfqKrz/j30A==
X-Received: by 2002:a17:90b:2e4a:b0:31c:203f:cacd with SMTP id 98e67ed59e1d1-31c9f4c4df5mr6010244a91.22.1752721666437;
        Wed, 16 Jul 2025 20:07:46 -0700 (PDT)
Received: from localhost.localdomain ([188.253.126.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf805f19sm480222a91.30.2025.07.16.20.07.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Jul 2025 20:07:46 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	hi@looping.me,
	j6t@kdbg.org,
	yldhome2d2@gmail.com
Subject: [PATCH] pull: add pull.autoStash config option
Date: Thu, 17 Jul 2025 11:07:32 +0800
Message-Id: <20250717030732.75106-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqq5xfsdv3w.fsf@gitster.g>
References: <xmqq5xfsdv3w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git uses the `rebase.autoStash` option to decide if git-pull is allowed
when the working tree has uncommitted changes. However, since the
documentation does not explicitly state this, users may find it difficult
to associate `rebase.autoStash` with the git-pull command. Add
`pull.autoStash` option along with its documentation.

`pull.autoStash` provides the same functionality as `rebase.autoStash`
but is more user-friendly because its prefix clearly associates it
with git-pull commands. Additionally, when both options are set,
`pull.autoStash` takes precedence and overrides the value of
`rebase.autoStash`.

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
 Documentation/config/pull.adoc |  9 +++++++++
 builtin/pull.c                 | 10 +++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/pull.adoc b/Documentation/config/pull.adoc
index 9349e09261..da9686dbd2 100644
--- a/Documentation/config/pull.adoc
+++ b/Documentation/config/pull.adoc
@@ -13,6 +13,15 @@ pull.rebase::
 	of merging the default branch from the default remote when "git
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
+
+pull.autoStash::
+	When true, Git will automatically perform a `git stash` before the
+	operation and then restore the local changes with `git stash pop`
+	after the merge or rebase is complete. This means that you can run
+	pull on a dirty worktree. Noticed that `rebase.autoStash` provides
+	the same functionality, but `pull.autoStash` overrides its behavior
+	when both are set. This option can be overridden by the `--no-autostash`
+	and `--autostash` options of linkgit:git-pull[1]. Defaults to false.
 +
 When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
diff --git a/builtin/pull.c b/builtin/pull.c
index c593f324fe..dfc3d4656b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -90,7 +90,8 @@ static char *opt_ff;
 static const char *opt_verify_signatures;
 static const char *opt_verify;
 static int opt_autostash = -1;
-static int config_autostash;
+static int config_rebase_autostash;
+static int config_pull_autostash = -1;
 static int check_trust_level = 1;
 static struct strvec opt_strategies = STRVEC_INIT;
 static struct strvec opt_strategy_opts = STRVEC_INIT;
@@ -367,7 +368,10 @@ static int git_pull_config(const char *var, const char *value,
 			   const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "rebase.autostash")) {
-		config_autostash = git_config_bool(var, value);
+		config_rebase_autostash = git_config_bool(var, value);
+		return 0;
+	} else if (!strcmp(var, "pull.autostash")) {
+		config_pull_autostash = git_config_bool(var, value);
 		return 0;
 	} else if (!strcmp(var, "submodule.recurse")) {
 		recurse_submodules = git_config_bool(var, value) ?
@@ -1052,7 +1056,7 @@ int cmd_pull(int argc,
 
 	if (opt_rebase) {
 		if (opt_autostash == -1)
-			opt_autostash = config_autostash;
+			opt_autostash = config_pull_autostash == -1 ? config_rebase_autostash : config_pull_autostash;
 
 		if (is_null_oid(&orig_head) && !is_index_unborn(the_repository->index))
 			die(_("Updating an unborn branch with changes added to the index."));
-- 
2.39.5 (Apple Git-154)

