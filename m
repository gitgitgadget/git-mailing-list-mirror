Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BA130AC1
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824955; cv=none; b=aK5GGHDHsU80DsWhbMiapouZRjffbE14G/Nwv4DWPk2iqyxV1uEosj3fQTJqHXKoFDB7IlVhnSRC3r+0/eIjBphKBq83Enyuae+FxUIv4QsxdjChe7LXZ+Gpw786KZr3C2NOL+GDYagEzaZx6e4bXzW1HJdOgbgcbN0CeCnIq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824955; c=relaxed/simple;
	bh=m20nHkEJ9M9RgMnpiunE57cAJy/LUOenPGO0EFxA04U=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gay27USvIpmqq3qo7r6L/waey6JhHEulU8VEPHqF6CBKVH9C0U4usG+MFA7ZzF5bS2pb1sg8YpwF/HKgIs5uI7+1HWzb4ISE3Ko35BCk4ZFKs1wnX3WCOTzyqo9E15G7qGC4yaSijA4rEDlZefmkMV+91KEaSC6CjNS2M0XO4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTAL/0VD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTAL/0VD"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d6f26ff33so742247f8f.0
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 07:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709824952; x=1710429752; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgER52tmIvBJG4lqzwRTZ1uvr/BPpXF0FMqkFydmFc4=;
        b=iTAL/0VDvvHl0i9/MdLruMgpuZJDBCFZdukQNfdOYzy1thfszPgFcsvCoNcOp3rcOL
         84KyVxFvTFo2p7sqX6OB75iwNnvnvq1BqE/Wk7xYeLy6SqOfqOX2AnTz4JAbiH68MhNH
         0OmFPDhGC/3e8rJQhqiyL7Mfq9eo+8EcfyavmksGNJdhwtY2BfUUuN28fROC7+/yjYHF
         8d4Ljx1ApCsgjQwmQQQyqP44QInIbY51hRPHNVaMr8Xz7chrzovDcTInXhTeJCT84hSG
         vytbnKyvKgJK1SBa+FDhapJAdSO72mTsr/J33Mj+uJy7FoKeHPE0WxXlHXwTiVwj8ui8
         nQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709824952; x=1710429752;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgER52tmIvBJG4lqzwRTZ1uvr/BPpXF0FMqkFydmFc4=;
        b=s3bYGpO0vVuR2aO6adSKW8FDZOyeEkw/zqulCYe0ef+Efroe26j5m8Q0+jn1t2n+ZI
         zHVvvT+MW6S+sRuMTBwXxdJDaTrOcfaCFHShJNKpi118LMFWYPc0U0WMKM9nvOjXvVr/
         XEfTy6Q2sZxkZhIpI+Bo4neirCFFOiP1PXIB6nfouc7298EV8sa63MXiUH9TwBFB+QUK
         WyFMiBZeF3AQUQEI3jzpLqRgt6ixc9++W23PbdlHHNTPIRET1OP/f5nhhQGZ1cKxHXal
         cD2k6p/UYe9fXt/hTcbW5rYB8qb9uP8NmSom15SzuUxEWcOl9WsU7jNvg4Ukv+BSUZF6
         RGgQ==
X-Gm-Message-State: AOJu0Ywx4XONt77Y4XHIFIk3AfbO8Aq/Qm14L25DIwGPCHN0Y7I3wvF5
	Oq+bGFwKM6S8ngqDHIyd+7zBbW0UhbHCo13DlJiayASAq7SdYsZ7IehyjsJA
X-Google-Smtp-Source: AGHT+IEdn5jhhPQ6b37TYcae/l0gJj6SlY/p2kwkNP9hqbvdh7eKdJXkdDqabT5QZwAQlSmSbgdf5g==
X-Received: by 2002:a5d:6e48:0:b0:33d:6c9f:39d6 with SMTP id j8-20020a5d6e48000000b0033d6c9f39d6mr13658211wrz.40.1709824951661;
        Thu, 07 Mar 2024 07:22:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600003cc00b0033e451a9b64sm9252474wrg.61.2024.03.07.07.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:22:31 -0800 (PST)
Message-ID: <65068e97597241e297f5d7cdb60012be1784e9dc.1709824949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1679.v2.git.1709824949.gitgitgadget@gmail.com>
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
	<pull.1679.v2.git.1709824949.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 Mar 2024 15:22:28 +0000
Subject: [PATCH v2 2/3] trace2: avoid emitting 'def_param' set more than once
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
Cc: Josh Steadmon <steadmon@google.com>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

During nested alias expansion it is possible for
"trace2_cmd_list_config()" and "trace2_cmd_list_env_vars()"
to be called more than once.  This causes a full set of
'def_param' events to be emitted each time.  Let's avoid
that.

Add code to those two functions to only emit them once.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t0211-trace2-perf.sh |  2 +-
 trace2.c               | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 588c5bad033..7b353195396 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -470,7 +470,7 @@ test_expect_success 'expect def_params during shell alias expansion' '
 	grep "d1|main|def_param|.*|ENV_PROP_FOO:blue" actual
 '
 
-test_expect_failure 'expect def_params during nested git alias expansion' '
+test_expect_success 'expect def_params during nested git alias expansion' '
 	test_when_finished "rm prop.perf actual" &&
 
 	test_config_global "trace2.configParams" "cfg.prop.*" &&
diff --git a/trace2.c b/trace2.c
index f1e268bd159..facce641ef3 100644
--- a/trace2.c
+++ b/trace2.c
@@ -464,17 +464,29 @@ void trace2_cmd_alias_fl(const char *file, int line, const char *alias,
 
 void trace2_cmd_list_config_fl(const char *file, int line)
 {
+	static int emitted = 0;
+
 	if (!trace2_enabled)
 		return;
 
+	if (emitted)
+		return;
+	emitted = 1;
+
 	tr2_cfg_list_config_fl(file, line);
 }
 
 void trace2_cmd_list_env_vars_fl(const char *file, int line)
 {
+	static int emitted = 0;
+
 	if (!trace2_enabled)
 		return;
 
+	if (emitted)
+		return;
+	emitted = 1;
+
 	tr2_list_env_vars_fl(file, line);
 }
 
-- 
gitgitgadget

