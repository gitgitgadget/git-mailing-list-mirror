Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832781AA7A6
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673398; cv=none; b=AH0zZ2MV4uBS022LwvkgLsiayxgsjFCUZqs9Onje+U3fMp58BiOTemZoH3yixQ8btXZtI81qLwyy9BPe1ZmMNN85KMCy14o7PoKV/E0uMldI4urr/SV0GztcD6Fj3Epk/6+cjY0iM8+rj+erWqBhbD4DEtHuehMdJNp2UKcwltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673398; c=relaxed/simple;
	bh=ImalA7KrcNK+APa/qQxkv6SqAq/ekvSFebfYLzv9OOc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RKQpKFE67TDZKANPB8v5jCmPfzCPv9gPlvurzj5X7H0vxzvfwa2ZJ0R9joOAw6bn2sodorqx/C9Q+cq43K72A2iFdkmtvwzAJ+y2qUmCIv9Togjcryx4GjCQEX3/rjSNIvBolIaOldvg/OUp5YV/CPoj/zksMv5Zgducvlsk/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr9Cy+Z6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr9Cy+Z6"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb3b3e643dso451385185a.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673396; x=1773278196; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIehvUcycCAIkmDBeIOnoHLklz8dJtEueF7EIyTx6ZA=;
        b=Tr9Cy+Z6DoQKqNxZgk7DMYBXxKh0e6jtWOjND9gOpIVWeSGFHM7yb6LmVLd6LXhzR2
         7HzOIFZ89i6nvCVy3EMN0KaHoMQcwn7ild/R+kkq8KeNXCz39bRbBGVGtn91ianI6doK
         3g/0C3X77ipFir8tCVc2wITOe81SIxdhIUzhApfbReXHFP/3/7B51vRb7tbymb5AQANl
         GObSEtEjcp0wfjNpiZ2OBf7h9YfQDzrIyCvlJASBXyW181yMrlXHSgx9un+DlQEubqua
         f/JkjwlzHheKyjruuqEnA0DdFRXZpaRlBgs3sn4+UzXhQ8pYXHZa9yHNX6Qs9A+5fzj7
         iS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673396; x=1773278196;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIehvUcycCAIkmDBeIOnoHLklz8dJtEueF7EIyTx6ZA=;
        b=jc+iyIzpbei9S8pO7EOt+BMCIkeCtARNbWHAsDUKHWceOSwCPxK2lDbDrYUvTxgSAb
         +mVlyr0srj47YdQmAJdamNPG1/N9bB8iAbKSunexIM1dFFWMEmcBfOT/J9qmi4tJRINs
         +3+tQT5kfFlwPAoBZ+/LUkJleSQLs9geeJg6KUmbjZ/8pVydbcGcAMAx+0aaixk4SX9S
         9/QlUxjELRVLs8Tt0tPn4aY/7QJBFpn37vZdlj2stD+lmvhU/HSBoKgL4HjfhpQycitx
         ut2KvdZeoCGQv4DDnVzDsKeTD2Vjx4XMihQdwiiFgZubqcMOY4CI0CeGcnn9+oOikWa9
         Tszw==
X-Gm-Message-State: AOJu0YxGVSn1Bv4pj7tC82HTn79uk8te9LWtW7r9y6T6oWFDY0zmw8Qk
	I0pHS8dCETM3fQE6sT3Gj6HCVnbsx3ml9e3RgEToh4d+hReXCJ8MqrcIHueGXEya
X-Gm-Gg: ATEYQzw5+SjLr76wKWBiYde+Smk7HOK5OSrhdzrGSPWwSnC+y4SVGAHAoNee2pBtLOu
	XgVn3xSXZOLIKfx/FJrwBYHbrANYzfPoG1VGudzIeJI6JaXs2M9LycGljSUYrle3QImGkMpvsQO
	3tZjgFp6KTJ7fMmXHUmx5eALnGdlZKDOVcmIpskgf33uzOzstxComi94vmq+rXj3GtcCXxWtgq4
	9LPydj/0mbMU/JjC+e42sDEOm6nsLT7M+iXkbqKr85SnNYlHWybYYMtwjjt52G94VGu00fVVyej
	qgd2OW7CTQoE6UeIDRxJspWlM3loI0Db5wzWiwDJAoj6+8E7FjN/GVno8RL56nxt4/O6I9ZbSMh
	Cf7P0p/sveOibrEJ+b1YqkBW9e3LzSp4GjyiY09qXBr1WgmLzcA3/Ygox9cRFuBJmOFPjxy8V3U
	o0bb4zuYuc9/GOrCICu6nahws=
X-Received: by 2002:a05:620a:2944:b0:8c7:9e6:3a72 with SMTP id af79cd13be357-8cd5aec377amr516464185a.6.1772673396005;
        Wed, 04 Mar 2026 17:16:36 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf673060sm1727769085a.14.2026.03.04.17.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:35 -0800 (PST)
Message-Id: <5db0591c155e02e778eff0916af78c17cd7e488b.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:15 +0000
Subject: [PATCH v10 09/12] fsmonitor: close inherited file descriptors and
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

