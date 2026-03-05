Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C222A80D
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671940; cv=none; b=fiYC1CDxV2Kbe4q3mA9G2MN7NIUcLu2mBK4Sr4PXf3//8tQT/bfl2eVDKPDgoWSb6y/a2TXTPJRPmaea+OqRD30yzbuJIOjR/9tYI/avvhZPc2Eus1LFcnQX5L6znxbySEVU9BBpoDRdujH4aA84TduP3CEC2dVodPRBnkH/XGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671940; c=relaxed/simple;
	bh=ImalA7KrcNK+APa/qQxkv6SqAq/ekvSFebfYLzv9OOc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N9BgxvOoAZCPVhvBwC2plXwF6y07pqx+e7sAdyV/7FpP5Iha6lNtwI6UA2rDhvGGMnwP3YRBqcxX9edia6uoGgtJ0AKzWggPsZ3SVhhC9sC1IcOskPWNwLGBRZLBh2ZiMUm1daKodJi5VOMOaMt5O4ydm3V8IKcnbb2MdQztun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeGTWTPY; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeGTWTPY"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1277e072e2dso4172775c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671937; x=1773276737; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIehvUcycCAIkmDBeIOnoHLklz8dJtEueF7EIyTx6ZA=;
        b=XeGTWTPYwGfAYaEwSDRE1O7KqUNTH5ssigjvQDa0z6MEsaf2ygM2gSvyF4K/TVYXsg
         qjNDgwPOIVwLWs990X7VUd10BtSts8/VcQwMIBBLJqgACEtcoI82qJrGPr85a1xBtbHn
         M2oqHHNa8u2Cza3aVrQfIR8xelgRL2XjJTKh0PkHZ67e7lpac0WAKZneGHdVCTlpGQ3p
         B3qt1aH5fcylXw50zvxH7FQbCuL6eUYna5OqMkTfkyL9ljThWp+u3YBwfem4EP0VeQnX
         pS3VBzZqxwW361b6d/FXmkPl+sCy0Jwi8ObkMSMJ2YTyt1caExpmsH3XQw6QaI51IyBz
         0UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671937; x=1773276737;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIehvUcycCAIkmDBeIOnoHLklz8dJtEueF7EIyTx6ZA=;
        b=fDFKHBtG4RKrWqRSGH4S7lUEkVMtvDO90UCHjj3zQroriacq7Ul2wzQbusxm7wnELJ
         8EDzVU/yGmkNe5qtC73wfQhzdVNzUh83w6PyJd2YpNngeirr/Lew/lirQEnq4jUpZ9WW
         ubKhD2SlsGjKA1hHKMsceaA7DG44GNlS7Tqwh2ySRlst+7HOSXfOi6tMwV+s0kG9zg43
         /iRWXQc0jqkr9tob/vY9xgP6RWGehajBPw+1Fbj7G/f0EbQgKgoUdt8lte+Cejciz4k5
         DzV5Wr9tom9X0WV2rmRttq2dbWKjGwZEecASYkEhGRjJold5DkivKxHt4DNLBCdfd53d
         ySRg==
X-Gm-Message-State: AOJu0Yy1I7HDPdU/BDbLwmmd8+EE1IowJ/vOhPP3kjeG0YhG7xxJ3A/s
	rvwruQW397LCXvBNSOIqdkoEYpzkweI2CEbGW0nRIRtDPt0XRM14EMJSGCqX7g==
X-Gm-Gg: ATEYQzwXUKVtC2dX4IG11FC+sk4X6YVgDlUz0JAt1JzZFVKLIPAtCVMQWjMKDl2Fdu7
	uZv5A+9rKnd5S7Zc/smtxum38NSjrtYpEd1eTPx0L/tOfQbiFHYj0S3pDGAbIpWVZpmZplqI0MQ
	QC5lbbu3MsiCjXq1xsn/asQ72CtiwFmPrZ+JJplrowyiHW/n3yHYi+6IfPAKyXvB1MiRrCEYrnj
	4GIbV6l9SMgMrvr75CHdiShOPi3KpIcepWX9us0cdORPUV5sz4KUFQTXAOK39tKhK/CHvQbC5nk
	qKPbe16lSRLIOBio+baFjnWCtLSUMQ98ZPLHWfC7gDU8tNqh522YK7jvNXsM/IRJUr9S0ousZvQ
	phyLFhFXHTpe1yivr48HfT2+jVLbo2DyCw2zGQLx2hhaRI0Ar6OJEKkEDvcUJo2jclBVLqHeRxu
	d0PpkTdEzsLVZDHUR+QHJjt+pQ
X-Received: by 2002:a05:7022:49f:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-128bbfe8808mr239260c88.16.1772671936524;
        Wed, 04 Mar 2026 16:52:16 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899dfc47sm23830379c88.6.2026.03.04.16.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:16 -0800 (PST)
Message-Id: <c963074cbd8ae0e7da783ec0abd2996eea788823.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:57 +0000
Subject: [PATCH v9 09/12] fsmonitor: close inherited file descriptors and
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
index c8ec7b722e..d2f250bd06 100644
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
+	cp.pre_exec_cb = close_fd_above_stderr;
 
 	sbgr = start_bg_command(&cp, bg_wait_cb, NULL,
 				fsmonitor__start_timeout_sec);
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index f1b1631111..61cb789339 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -61,6 +61,9 @@ static int spawn_daemon(void)
 
 	cmd.git_cmd = 1;
 	cmd.no_stdin = 1;
+	cmd.no_stdout = 1;
+	cmd.no_stderr = 1;
+	cmd.pre_exec_cb = close_fd_above_stderr;
 	cmd.trace2_child_class = "fsmonitor";
 	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
 
-- 
gitgitgadget

