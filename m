Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8063DBD47
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648144; cv=none; b=gnCI5ULqbHb7SEayVBbnPw3nx2XgabA+Tw1sI3czQJRgPAsgb1HlL+9sk8G51MivAQdqNx2H9lrGNlrM7p700J8USUJCPY27DrLjP45nnOfF/BO9AEMZOAy0smtHSnPh8b2Lbaovileclb9rZX8br+j7P5DH7NwYQ4x31pX7XA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648144; c=relaxed/simple;
	bh=iWHi/Iy6Jg9VFB2Ce9XDASiFMpsfM1rNBVIoij/oyeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hczyhycweKQKmeLVqMxqAQnInQ9BV3Ap/Fifc18RSh1JmrkjGt4pwwG3j0SBdxTrUGM9QT83p6bXNnM7ka68jzUZ5EYkh32MTOQti8EfXgk8O/8BN/3aSnYl1lhA/XrI2WRz1+UtrnuZw77hyDNrWe2RuBNRYDCEHdBtn6shlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqMEB+vo; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqMEB+vo"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732e6a123so590027c88.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648141; x=1773252941; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=jqMEB+voO8L1DZt4ItB076tlqdafq3so7TYMZ/ViZ+eAqOidzQzqEDbokUqxqkniOA
         55pqKVzedZR0oWya4ztFDMX07RJdnNinRaj1j/WdNJZlt8GIPNNeD4zQDlBb9peUmUtZ
         k5ih1npJTyw0AJnEK2FGqj8RGIvUW2ccDCfPqfo//wcl0vJac9yVTCWnBFmoKbIytlpZ
         xNtSA83ASbtW3q0YMMi8P7xeM+aChGYC6xAD0SDbyyNTi4qFISkcsd6TMQNg4Hjb6az8
         MBHmTBOjCEsQHxramnTTkFPE9lCRGO9QUtDjN4mK3C7XrRn2wVibxZdk29rYjTlkewXL
         tVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648141; x=1773252941;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=vwPWGSyq1POCSuWIxawrXH6SexbMbxeoY5DfpwBMLgn+O+/sJW69XqOGgVp8KMTz5Y
         AQqAYTGtXEI0CLXEUKwQLftzea7ft7k7x3LxLCPpgxcmrUKkXDC9a90mYUEm7Mu9mnJh
         vvJxqjvgTZaaTbXKFHTiJ5QMedif7AzctT0M/WLigUXM/h/gWzRR/2uHokVMQ1IPlC16
         g4oAJ5IIMxhZzXngkCb48P/GwQdENxtEPXQVI9rfJjjkKW7JGPzbiAElnKPRmmErPvjV
         kDtdLivyW4n4tsbjSsD5F7llLYgvVevCwcliSaPizLRLhDMCmWZR+Kdiu07d8stbYT+H
         /ZjA==
X-Gm-Message-State: AOJu0Yzh8ExfZpqBAiRZHpEOnxctHaC3onCUhQrp0rnwqZ3EFm7xl0L3
	hsS5OJeDvDaoZAifJnOXV4oRNqrJHKX8YpOSwNSNkgc2CV3ICZ4t9T+f7/dzTG1G
X-Gm-Gg: ATEYQzyDL9AdTfaJa6CfCp/aCJC75co5Ec+yVO8yK/hw/h+CEm5aEc1n6r78W3p0x74
	7xFpkmN9pC0irYtkf2otNthHGCX1ljqorYmx+HFv1LfxF0vHSHDHwKBgInm/5hWrcSoDlpUFyPD
	U+wRpjf6nMChpM59cl/5xFo1Te+eEf5IutsxYaQbZWXvcCUqltYJO/ynJjUAHafxMO9gkqfuYgQ
	WxCEfmG17BSwwP3dfSjz3mxuy52X+cOaEx7N+BaYUG4d7yYGJHx3kdjlBqHPJuvyQay+cLusuwO
	G/3woEHaGCQ8y91HfpiWAw2Av2QPoXpd1FwU2JejUj7U9MTpNGP6wrh7fjbHicsjqPfnPQVNo02
	pw8RkGL0RpepJi4AWQZPGPU5XZIhAG8ab1xIg2pusaurZRUQ45F43bcYq/WHEGTee1Mukbtg+uU
	29gEsxsdWKI+JjweBGLiWoTYsiNA==
X-Received: by 2002:a05:7022:4197:b0:11d:f89d:85a0 with SMTP id a92af1059eb24-128b70d1073mr1310203c88.27.1772648141491;
        Wed, 04 Mar 2026 10:15:41 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df391sm22505720c88.5.2026.03.04.10.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:40 -0800 (PST)
Message-Id: <b596c5004d8c4c706d890192c40c570afdcfc179.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:22 +0000
Subject: [PATCH v8 09/12] fsmonitor: close inherited file descriptors and
 detach in daemon
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

When the fsmonitor daemon is spawned as a background process, it may
inherit file descriptors from its parent that it does not need.  In
particular, when the test harness or a CI system captures output through
pipes, the daemon can inherit duplicated pipe endpoints.  If the daemon
holds these open, the parent process never sees EOF and may appear to
hang.

Set close_fd_above_stderr on the child process at both daemon startup
paths: the explicit "fsmonitor--daemon start" command and the implicit
spawn triggered by fsmonitor-ipc when a client finds no running daemon.
Also suppress stdout and stderr on the implicit spawn path to prevent
the background daemon from writing to the client's terminal.

Additionally, call setsid() when the daemon starts with --detach to
create a new session and process group.  This prevents the daemon
from being part of the spawning shell's process group, which could
cause the shell's "wait" to block until the daemon exits.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 16 ++++++++++++++--
 fsmonitor-ipc.c             |  3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index c8ec7b722e..b2a816dc3f 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1439,7 +1439,7 @@ done:
 	return err;
 }
 
-static int try_to_run_foreground_daemon(int detach_console MAYBE_UNUSED)
+static int try_to_run_foreground_daemon(int detach_console)
 {
 	/*
 	 * Technically, we don't need to probe for an existing daemon
@@ -1459,10 +1459,21 @@ static int try_to_run_foreground_daemon(int detach_console MAYBE_UNUSED)
 		fflush(stderr);
 	}
 
+	if (detach_console) {
 #ifdef GIT_WINDOWS_NATIVE
-	if (detach_console)
 		FreeConsole();
+#else
+		/*
+		 * Create a new session so that the daemon is detached
+		 * from the parent's process group.  This prevents
+		 * shells with job control (e.g. bash with "set -m")
+		 * from waiting on the daemon when they wait for a
+		 * foreground command that implicitly spawned it.
+		 */
+		if (setsid() == -1)
+			warning_errno(_("setsid failed"));
 #endif
+	}
 
 	return !!fsmonitor_run_daemon();
 }
@@ -1525,6 +1536,7 @@ static int try_to_start_background_daemon(void)
 	cp.no_stdin = 1;
 	cp.no_stdout = 1;
 	cp.no_stderr = 1;
+	cp.close_fd_above_stderr = 1;
 
 	sbgr = start_bg_command(&cp, bg_wait_cb, NULL,
 				fsmonitor__start_timeout_sec);
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index f1b1631111..6112d13064 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -61,6 +61,9 @@ static int spawn_daemon(void)
 
 	cmd.git_cmd = 1;
 	cmd.no_stdin = 1;
+	cmd.no_stdout = 1;
+	cmd.no_stderr = 1;
+	cmd.close_fd_above_stderr = 1;
 	cmd.trace2_child_class = "fsmonitor";
 	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
 
-- 
gitgitgadget

