Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96E3DBD67
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648142; cv=none; b=tYr8w0yn2+n7NnjkhzHJhv8XnAJfMSJ1v5kYWuWsmbXgf90qTU2VVmProbzd9js+X8KMuz2GKtGu632JDPUsLyIqa6If5J9Qc9ygWqTrOHvd6hQhRtbX4POA3fBkFLpWU/NWJTXFWHpWPQMfcCaldlt+XidN7NzPcdJBsbKL7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648142; c=relaxed/simple;
	bh=57Vbf3coY3ga4MdXAmBJ+7vV2a4fHMkBsS/Vdaddq7w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N4/5Zi6MB752wrVonc/qG2OJ1vfZIbbP/12pHFdYr612gnQ/eSC4JvfUY5MeY4iv3Nd3SZUtlvU7gkoniwsil2YUVObc4bHaVNu1ryO4Eo0eNZRpHfuNfB1FiyMPIi6VARsHC0KmOTMkZ90KRNDSePWNH7Ixx6WKFc0viwAcikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g23nXwlT; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g23nXwlT"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124a635476fso8394997c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648140; x=1773252940; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q2QPD1f7XnNwF0bKW9R8uyMGA56xCYIdJ9IGRRFsII=;
        b=g23nXwlTvus13mmyISsE0z/IRdIipFTCHu4N5AxZrD0jWS2xiJ3ESs1KUMZ/f50dvJ
         9jb22QL0i/KrwHAFcyWVixpth31i6JWw+NCGMHpXfPaKWhJMBR8ezJv8N5V2MV4HMJD4
         Y8PA1f6Yf2jaI3G4F7N7p9cdtB7A3wfiAZyjrCC7oDg0zrvGSA4u+eY9d9d5euMxWYWE
         Mw69nd/3JSWkYjqLM+U/tgnuN3c8j9GWYUQ2kSzaxHtKAW2EneRgt9tAxT2Soe2MprbD
         lAAdzj0VlShJ7yyK/v14C7ut4bAJCF7QaPpsz12wmmx43n7Jlu1KnI4FmwoMZtrcG5k8
         GugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648140; x=1773252940;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8q2QPD1f7XnNwF0bKW9R8uyMGA56xCYIdJ9IGRRFsII=;
        b=oMNUG75GHSzVMZoSwIS1WJMlk4weFjFhX5Y3DUPKJ3GdseMV/PHy5LmXIxRJGT5gTK
         d+d5j0H2CWBFa0yFYzQDJUgZbuLjaiZf0jXjMCb+y3TUb0DyTU7k/R449stSSb74yrgT
         2QPsAZRQrPar5IA5gqOXdxa8PJfD+s20fNhxjn2otKDH40EdxwhHmSmkf8F7E2M3OpEw
         6XI2V+al8WvBlXwIPX1vHhehG7/rtn55CHc7pJiEl+qyWYrsJILI5SC+7VMW08REPbKB
         J/xMpCzhi3nIU8rrcyP5ZqPio+6TJrFieVSMKsIiuiYg/GJy0dsf8kiIp5LxkEX5cbMJ
         NVOQ==
X-Gm-Message-State: AOJu0YyObgwE04xEr4fArLCjywOLqtQrotGA3+3dqEauKy05/tfnZ8zl
	0XINCzNXJKDUq3Qc27agENkWEXEGA5FlK8j4Aw8fPONs0b5+oMdsqNI+0FOdtvKd
X-Gm-Gg: ATEYQzw5xo71SKon8UFptUH8NQ2WB02JVLQP6L+kem9CZ5y8lcVg2VKWJ1hvCHeB2Ue
	XbT3uvPoZDMHKzhoWF+Wo/h8sb31b/MtEFGQPgZCvoA+98EHdPjMKXl8PNesZhhu0Hh8P4JpsHH
	fGUxLGu9ALSXqupC8DK1TDpT5vfKkH7uVR0qJmWhyRoeEvipOk8K/V8xr4jYA59v8u3kVwtYXT/
	HRLKYbpAwUbPhrI3xH5KrvwY88PVl9z2aa8KTG6KNeDt2799v1Cr3flKrOVmeASPmXwX2o0hsy3
	h0n+DeRNINnTK/32jQTliqvaYdCBfmG7Wk5CFvIcGu3RrTfWfOQgyd/EaHWTpFP/CZrpUUlIyFj
	/Ae9+0Oc+aXjjOeC6u3pWyBpMeSF9J0YLLPZLJBF82qnJOlviwBAtRzi39U14ytKdirapI//EyH
	NiRRtTsYyw4KKRMn+Zred4j/jSMrrGx4HAEBo2
X-Received: by 2002:a05:7022:f109:b0:127:9cad:1923 with SMTP id a92af1059eb24-128b70753a5mr973208c88.5.1772648139705;
        Wed, 04 Mar 2026 10:15:39 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1279cbd1993sm10187931c88.2.2026.03.04.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:38 -0800 (PST)
Message-Id: <29a6461915ce9d2abedb29e475d589bb8d24934a.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:21 +0000
Subject: [PATCH v8 08/12] run-command: add close_fd_above_stderr option
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

Add a new option to struct child_process that closes file descriptors
3 and above in the child after forking but before exec.  Without this,
long-running child processes inherit pipe endpoints and other
descriptors from the parent environment.

The upper bound for the fd scan comes from sysconf(_SC_OPEN_MAX),
capped at 4096 to avoid excessive iteration when the limit is set
very high.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 run-command.c | 11 +++++++++++
 run-command.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..cbadcf5ff8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -832,6 +832,17 @@ fail_pipe:
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
index 0df25e445f..a1aa1b1069 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,6 +141,15 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
+
+	/**
+	 * Close file descriptors 3 and above in the child after forking
+	 * but before exec.  This prevents the long-running child from
+	 * inheriting pipe endpoints or other descriptors from the parent
+	 * environment (e.g., the test harness).
+	 */
+	unsigned close_fd_above_stderr:1;
+
 	void (*clean_on_exit_handler)(struct child_process *process);
 };
 
-- 
gitgitgadget

