Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4633985
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671938; cv=none; b=Umz5jJUBulNxze56uMwDvLpxsZ3lemr5VMVh0HCjOJP4BiuiEjiQ54/3bMiG9RCVUqC1idANLDGU7eLXBbxy2YQEFVV5M3IJdNWaYwwDFD25TZaoBTiVK2fFy64A9GDRPCcea9dbZUY10THo/JnbEazEEnuoOc/tl80Mh3rDOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671938; c=relaxed/simple;
	bh=z2kpQN8eXVzVRk+YNpEqT0u4alBsZfpx17Ir5hqpqwA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Zi6Zv1qUjnSfP3DWPX5nJwYjfJQf8Q4yy3cE6Sj0kfu22YiM7agccs4DIvFwmAIBWKuXwGV+Y8RnEBtPlP6twB5VMk+Avtu7rgWw8F9LKlN2zw9vwq8y2wNqdxgCJ/rbd2Yy9Hkl/kKyYjXJEuf32qQWonlY5ciS59mrVPWji3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNvh9uK3; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNvh9uK3"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so6188819eec.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671935; x=1773276735; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVCxtZ9T9BCseA1BVQktZq/fH62L/SMOtAfjZOemys8=;
        b=VNvh9uK3WrHx81hr7VReftOTzJsyR1NdXWxdbttjrLr9Ctd5KYBtrEfQVyM9oREhOv
         ivlz0dAHjkYjAgkKmNaJjUrSgrXDQ3vE39ZR+gLh6r7e0K5XPx5E61HC5y4SvNNr+SUC
         50XvgnkOgTGCruU3b41uGuUC7A2otslAbxf90dU4tNrMSk9DOx5a/Dno57jOjiBe/k3D
         ipXjkvooHkJinTpsBds/ChZSHf/dMJGlHQ3sKOIM2mVg3XgiQcl50bq4845iBZv9ielx
         GqhOYFzVFB54hNQCJJ5SETlnMadJrsgEMojVWvqNGM3TsXn0VZcGghRWBvZEXdQInac5
         3XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671935; x=1773276735;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVCxtZ9T9BCseA1BVQktZq/fH62L/SMOtAfjZOemys8=;
        b=gKuitYX3qfSzAaOsqXLQNNzugWv7HK/YIK1HX4qDczN3l2IBe2tk4TzfHmdMWuHKH3
         bKonn+wS7ivGnDW0KK+rvRe9CJCHWIwtd9hSMkFAdlxCdWF5HWsclM96quAEvnLSOUzy
         Q8pB4AHeFhuI2orr4mT5/8mLaB3SknX23DiqmV6mqjH5bZr+fLP9d+4B1GHFaLO58zQu
         yqOkRsM+GSEQtrHrTAbWcW/Uj1RP2jsPiFBjSbkU5ZIEcJwCsqe+1E+LXPim1GxGM7fs
         INX1N5Pxss2Ia06IWWgPDDMz1eqLb7l0G390Rk3INWAepgvu8Jj2NTsPiIbzGM4TC140
         6u5w==
X-Gm-Message-State: AOJu0Yym0qRFfBl0U/9d4FXGCGCs7RKUk517OBrUrIkydxVA29prhACF
	dO/B04BR45ZWaczY8tpH1ALQV6fXKwpJWRt6mOd15zbiLYyKqxELcgoq5FIDSA==
X-Gm-Gg: ATEYQzxSt1z19tEJg2JSIRawIHLjzFhqjzws7qSqj7wr2doCgt6kuF6UnUqT35yJdnW
	VMeyGBxUKhQYjzY7FGdjtfX93WaiJTAnRChSypP7bIjTg/XfWBQ2V+NTvYX2AJIEGZpxwYpgVcU
	yfFJQAnOjnMlXphC0cN7u4bVPZcxBKQgmTIyvXAevZ2AMGMDSl2NyrTHnQ9smK4QnEoeLIALW0W
	8+8mn2A33mWONLBMD6TGMS1+B7LUij1bRxdE3nREDleyjo3RUITRdhVsTQ6J4Xa3IBne5yA7CGM
	s/k66fQLtSDRtug56F+GpOxSae2SH2VNzsedojeKEUim4uxrBJPrXVe7Eq/OLx/VkaFOk5G79R7
	4rgdNqPQ48KgHUHO5cVYlWvuSGuUrlDseZYOcMk5XyvU8jwTDht99o0YnF/qKHgQE22h6iCw5z8
	Z6Y2CV1wfsmHDFAnshZeBguWUv
X-Received: by 2002:a05:7300:dc8c:b0:2be:1803:7e11 with SMTP id 5a478bee46e88-2be311bd422mr1459826eec.30.1772671935043;
        Wed, 04 Mar 2026 16:52:15 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdf662eb6dsm11575336eec.2.2026.03.04.16.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:14 -0800 (PST)
Message-Id: <31fa1fb324be240e28bd360ee3afc45d8fb8444f.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:56 +0000
Subject: [PATCH v9 08/12] run-command: add pre-exec callback for child
 processes
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

Add a pre_exec_cb function pointer to struct child_process that is
invoked in the child between fork and exec.  This gives callers a
place to perform setup that must happen in the child's context,
such as closing inherited file descriptors.

Provide close_fd_above_stderr() as a ready-made callback that
closes file descriptors 3 and above (skipping the child-notifier
pipe), capped at sysconf(_SC_OPEN_MAX) or 4096, whichever is
smaller.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 run-command.c | 15 +++++++++++++++
 run-command.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..b9bc84ca1b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -674,6 +674,18 @@ static void trace_run_command(const struct child_process *cp)
 	strbuf_release(&buf);
 }
 
+void close_fd_above_stderr(void)
+{
+	long max_fd = sysconf(_SC_OPEN_MAX);
+	int fd;
+	if (max_fd < 0 || max_fd > 4096)
+		max_fd = 4096;
+	for (fd = 3; fd < max_fd; fd++) {
+		if (fd != child_notifier)
+			close(fd);
+	}
+}
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -832,6 +844,9 @@ fail_pipe:
 			child_close(cmd->out);
 		}
 
+		if (cmd->pre_exec_cb)
+			cmd->pre_exec_cb();
+
 		if (cmd->dir && chdir(cmd->dir))
 			child_die(CHILD_ERR_CHDIR);
 
diff --git a/run-command.h b/run-command.h
index 0df25e445f..7ea5c6e005 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,6 +141,14 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
+
+	/**
+	 * If set, the callback is invoked in the child between fork and
+	 * exec.  It can be used, for example, to close inherited file
+	 * descriptors that the child should not keep open.
+	 */
+	void (*pre_exec_cb)(void);
+
 	void (*clean_on_exit_handler)(struct child_process *process);
 };
 
@@ -149,6 +157,13 @@ struct child_process {
 	.env = STRVEC_INIT, \
 }
 
+/**
+ * Close file descriptors 3 and above.  Suitable for use as a
+ * pre_exec_cb to prevent the child from inheriting pipe endpoints
+ * or other descriptors from the parent environment.
+ */
+void close_fd_above_stderr(void);
+
 /**
  * The functions: start_command, finish_command, run_command do the following:
  *
-- 
gitgitgadget

