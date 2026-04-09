Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4D220F49
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710793; cv=none; b=olrnZTRW/c6l6Jmswkfc+UCwPd9Omcdrn5x217YyV18CngMn0MK0hI9V0Eb+xyqS8T/OZcdIONugWqxD+NV8IsF3U0tJ/vGxQaqV7e7jLgsEVT5RTm/wTj4bp80+Eacbem9sWdk8qkaB3a3hooLf3WY7mx8CglQhKZc2aQulnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710793; c=relaxed/simple;
	bh=okdl+0uUaqS6blDRN4er+hR3UqeoFu6NWPRmZZPDXeM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G/fY+VEvwQ5SRTrJ0JhNOYA/Ii3wnjGf1lwfWoLoQfyoS+eYkoZEGnhAdIBn2SRg718V41HJHocGwdYve+4vNvB/df8OW9bNZ18BiAgPYaj24hO5t+RxPSPciclZmf4sjGndPu+eBKWzKJbqrhB4yIDvUsQF+VpvPXnXVYN3ug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgtfwzrK; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgtfwzrK"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8dbbc6c16b2so51809785a.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710791; x=1776315591; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=hgtfwzrKPj5S9AL11G5pW9nKAs7fgdkOgswxmajWc1NU2w4gr7AjIoGvA0PReUhVGJ
         4ImuweGmR2iYZv6IHCK+jcC7VEbP2+M0abbZ0elugtu+O5XWveoyC5m7kdGahM1rA82J
         pUbfUfWheQKd4ZItkkhjhhT07AlJdXsBQvGB24jjqu5FaUDxd0Sx088mX00qH7XSDyzx
         bLbkJwFZu89a1kM6GA8pLMsqfdDqiXLVBWTOT/+H6r62ip4yA56CwsUwapl1Ifjdhcg6
         3XMIrAXoDtkH1xDFNgckk1otfnOEHRYACU+tb5J/ddN9Hvd915lTRlMu2WNaTq4lOWU+
         1xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710791; x=1776315591;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=Kx9jDjRh5eBypVw2pZqs8lafUCnhBjRDIR2kXOLCJoXAJHeFcYbeandoiwkRJPwmrJ
         rnsnmCOc+yepEsmAjZRz+K4YBOsyuPUS7cXWaWv64O4j2o6z2he9ikNFDeC1vfJ1MCh3
         ChgWasaU0XQ6AzJw8JqNUm+ZW8qVdE3EHkwK0eCadPn3GZTP/7VJgP5jG+LtyS7VJVyJ
         cD3P/rFrHWsVepP6CUPmcJYoQ9d8XR32QPNX9S++gd3FHn2UjRgtbInJhqXU7l0ljYJO
         gAfFacsT/Xu2h5PKbT4um57niEDeqsTzIoBwK4ywaiGzFvjLLPXezppWDewW6HfXcMN2
         4MRQ==
X-Gm-Message-State: AOJu0Yy6mrGZWBRNIEPcmnU4xaQ+4M+p8YKTGUnE3JOHxdewJbbFuej4
	ay6UhrlRVsPtn2vUUQO6rHW7sTlpXP6hACz1ZyqKbursTdUCebjAHKRURNlnrg==
X-Gm-Gg: AeBDiet6FhyFNmD2PFfhLCDcYSIVq/hacgG+AzMi1QwIvrWEhA5pIdA/OX3B598LqeO
	Q+eTrApCuOT4tX0WCLbyFlNZM2fZIaNHm0lELAHOJHjnJEMFRY3mBSIyCc669/tFrere24kQVHv
	PbipbEz9IYp+JC+89qWpMuAgvCmw7yymI+hYzwo5H38sac1uWZZ03MUn0TJ9oWrTTNYx1zoN2jx
	KC0wmmVIoV0BaveM2jdbeR8u5J7Ot8u3NyyDoGnGhfouZJj8KyqMhLCjlHO0W6VN50kJHlRuptC
	u1jUO+7jO+dnzhEVfzXMu5pdWLSn7RAQSadJ05GWTG3lJbq13eSbeUanqoqPT1BFUvOmL9SLUXY
	gvJD4J6BzCr3lfZ0P/8hZMagulyyGU/deI8Tm3TbPqdHRCSGj4K3FLP0+OGRh43VZRHAs/CZbzk
	nnmsf2DRX4hfr1lFT7bso76ZARNOu5cKoeusjuyg==
X-Received: by 2002:a05:620a:7011:b0:8cf:dd93:aca5 with SMTP id af79cd13be357-8dc468d1668mr263446185a.34.1775710791042;
        Wed, 08 Apr 2026 21:59:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5d5a096sm1709192685a.19.2026.04.08.21.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:50 -0700 (PDT)
Message-Id: <5791edbef245a00c158a8c865a0a9eb052151fbb.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:31 +0000
Subject: [PATCH v14 09/13] run-command: add close_fd_above_stderr option
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

Add a close_fd_above_stderr flag to struct child_process.  When set,
the child closes file descriptors 3 and above between fork and exec
(skipping the child-notifier pipe), capped at sysconf(_SC_OPEN_MAX)
or 4096, whichever is smaller.  This prevents the child from
inheriting pipe endpoints or other descriptors from the parent
environment (e.g., the test harness).

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 run-command.c | 12 ++++++++++++
 run-command.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..f4361906c9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -546,6 +546,7 @@ static void atfork_parent(struct atfork_state *as)
 		"restoring signal mask");
 #endif
 }
+
 #endif /* GIT_WINDOWS_NATIVE */
 
 static inline void set_cloexec(int fd)
@@ -832,6 +833,17 @@ fail_pipe:
 			child_close(cmd->out);
 		}
 
+		if (cmd->close_fd_above_stderr) {
+			long max_fd = sysconf(_SC_OPEN_MAX);
+			int fd;
+			if (max_fd < 0 || max_fd > 4096)
+				max_fd = 4096;
+			for (fd = 3; fd < max_fd; fd++) {
+				if (fd != child_notifier)
+					close(fd);
+			}
+		}
+
 		if (cmd->dir && chdir(cmd->dir))
 			child_die(CHILD_ERR_CHDIR);
 
diff --git a/run-command.h b/run-command.h
index 0df25e445f..fdaa01e140 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,6 +141,15 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
+
+	/**
+	 * Close file descriptors 3 and above in the child after forking
+	 * but before exec.  This prevents the child from inheriting
+	 * pipe endpoints or other descriptors from the parent
+	 * environment (e.g., the test harness).
+	 */
+	unsigned close_fd_above_stderr:1;
+
 	void (*clean_on_exit_handler)(struct child_process *process);
 };
 
-- 
gitgitgadget

