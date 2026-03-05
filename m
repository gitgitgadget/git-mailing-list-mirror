Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F29310763
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693738; cv=none; b=KFEYOhqgzGKp/JjlrqNZgiG0SBhfXMwzHYScQwY1Za/6gA9G5QicB0Ft42JZMXZeD52INTvBmjznY2ci7ARnn2U9lw1RgFkF28s093zaqRw8b2QckOrkt2INYDnfVTwGQqpExxFdZKKxz4tQhLR/R85ouJFAWutLIu9C+18qBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693738; c=relaxed/simple;
	bh=iWHi/Iy6Jg9VFB2Ce9XDASiFMpsfM1rNBVIoij/oyeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YYzsC0RdFk2D2QsW5U677Jg710KQeJ1Pj0eHC+zA81MvoAB79kzzLO9wYhWl/HUta+1Xk1nmdCZcsvSwO1EowYPpDg4uIhoiSRTaikTmhfgS8+nsvi6/85b88nm6eP5yO1tRIsLf9zLAYBWevm58x/YeY8gFvD8mlUkXsPwwjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOVROQ0k; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOVROQ0k"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdecd00ebdso4563549eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693736; x=1773298536; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=GOVROQ0kGiBqhhymXU4Uxfv6JOvRQPX1TgUdSK9fv85r0A04/Qr9RCgO0umkYxq4iY
         ikR/tqi610fEXhNiZQ+4bTq9F/A7q4+Jhz+TIBP6yPjH0VcCLDlqvoGBJTfsfN0DeiDt
         Ogmen0Ieo8O0KjHpyGrRGQI2hVTsnL6Xb99VkKtDRd0K8L0uPqJLVhA2SANNvj3e65Rm
         qmLbw865oNfnN21Sy2+uSjGTKrbO45+zy7v3RE17+CW5p/fNA4P4PUq9wGSUKGtNPeIY
         FhbQRWhtgXwAuYoApcaY0TjmjCibn/F8uHohlmvwJnYK0epBjD+0LA0daoJ4ihxaUUeF
         0fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693736; x=1773298536;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=GiislVF7mDfGb6kAPmLbJifGUOskKtNN9tWdZId7WbYwQL0QftvDeMf0Kw8cZYc4ed
         pfPICilSOakXCPM/cMBEayyV1LRRsJJ2v50P5WU7I6euPbL/KeHht3NpDBg2T3O4Xfoy
         YBqjErHigBQkkiANyYauYnjZIAjJlGfa7fyw9ATKWYvrOVH7GoJtbHQTFOdg+TcMScf1
         qfdeqYBXdA9um3X+CY9foioM0X/dwJ3Sks2F+GtbfAiHd9CR53yJPxPNWMuty8INAuCj
         KIUPDdvAFKE1yJoOnWOcjNbRPPbwRIcE1K6h6hpQpnJwCpg7KUsyWN7DqbV/6NiXVUKT
         l0IA==
X-Gm-Message-State: AOJu0YxyztTj4Tu8VohRvC/Bhmz1TaK3VLotrzi16SD5ojJ6WLzXjBZL
	mqyYFLz4vKRGk3QJtWoELTQ+n6bONySvHMnoWoVlNI7VZMCLu5Ru3JCchD+nxw==
X-Gm-Gg: ATEYQzzvP78RZOvCA+ieLHnQwEHY7tQnN/0D3/OWzdWRNT9Z1o2VUubEzNjNIivCgQ1
	wRHAXYtzo/FuAfSHa6ODOKxFHegk12h0ag1p/D+vhohqX22E5U5CRlJOdNFGwE+SLqsrVui2zoV
	rak4dE7/XBzgxU1+oUjU7GBszf1dBHhT5QPfHJEUjFEaZoYLlYvsA1Nbr8DHtB467aIw58NmWP2
	VumJAIaERL9KJPVfN+Ki87BmsvL5tjaB4zjFaoLmT4qbIzwuuUh8Z8vlMQ9Nte/re9ytdJLt/0U
	oW5wpcJFtdS92w3MEkaYDAODS0VOS5K2Y9R2hLwntr61mPKTZKzdvnoyA9w6B4aUraRgOjIch3o
	19qOuj+3+S2G58lpda9+x+sRYgpgfHCWftQv6+SdHvuXRUZbuBOd9c13o8K6I8EGfKY3XqxVr4B
	wh4PDCoKZQrSQoigHmUx7ac5+u3w==
X-Received: by 2002:a05:7301:408d:b0:2ba:a1a5:b5b1 with SMTP id 5a478bee46e88-2be30fdbf5emr1765085eec.7.1772693735971;
        Wed, 04 Mar 2026 22:55:35 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1e02f95sm16611035eec.13.2026.03.04.22.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:35 -0800 (PST)
Message-Id: <057b3098bcbea0302877bab0abbb9f9a21194f40.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:09 +0000
Subject: [PATCH v11 09/12] fsmonitor: close inherited file descriptors and
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

