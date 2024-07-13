Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69A1411DE
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720904911; cv=none; b=nmuZKrPPbOl64pJwGSy4THjrc8oK0o43NwFPzCrLJ9uCiBWOa3t83Qrua6fYSW4Liqvn8JFlUZUOzH4k075vo6MXKLzrE9Pt50HHaVu1/vubwbc5SeiC6t6HwYwSfjcq7uZbfP3TfVF6L6tL+JJsTFaxs6KhoGKjB81vEI2FlH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720904911; c=relaxed/simple;
	bh=u8yaTDujhV2/Nu4OVUSQjQlDfgzdR329gA/H50m5rl8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VHaV0+5FZd0aJB1vt8bllLEp2VbftJDUx8YNYii0zsW9AKsrJ/awFYIYQUaospH+MwKgMcbZA8UjO5vGfNfB5Kb/eMSMJTB/FoucFHUjfd11rSx88xL03jyOK8XdHRsZbEcjaoRnKevHLFRql3WhOZ0gBN+bsxgdRZCowKt9O+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8MNVvIK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8MNVvIK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42797289c8bso22553645e9.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720904908; x=1721509708; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CocVMwk0JIazwXWV9OwSdYVdQb6i/4AS+rSFmyyw4fI=;
        b=D8MNVvIKnM+vFOAELHQZICEgwwHsM3QuNEeIaPgUjmraxGh8RXOnsKhuIe5oczEfdJ
         rJvwNm4DFaoLu7ZHTW0NK6nzocXX5ABSDgbuTqQMeUPsyaKOBEBTh+lWcDgRc/yYw/Nw
         YPak3BRcKl9uS6f8OkpUSgaSRlKIhNjO/O6tfuDs7zTDjo0ehS3dYsaJnhWLf7tb6lwU
         uwP9RI52x+CpfPR7l+A+mUUkpTJhItvMhokakor/+vPQrDmtBuLte+IPYHDBKjXimfy2
         5UgQ8PYk0vMbDATkt5o+wHMTqwqHJ/Xc7jMTxAA4GDuWIEAGu2pPscxZN8Zsc3yf0zmZ
         w3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720904908; x=1721509708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CocVMwk0JIazwXWV9OwSdYVdQb6i/4AS+rSFmyyw4fI=;
        b=HJN2so1E2mRHQam7EXUGQgs0ULB7gVG39wRtNVrYIYHwSBJv1BT72sj5OFIXhljgEB
         6Dvk469XGTg5jMiwFjqMSKgjjw7e+Cf38PY+uaNlfM4PA4lMewaDZ/U0u7eZPygLLTyH
         mkv4QD1JrivXDnviI3QaesiD73ljuMUpfWgfA9HPEVwwM0BoTS2xarAMEmR+mPpdFUm4
         KWN05EQX+FpQmiwLN7KhwmVO97rnlmnZnpDFHF864GPvdxHPUW8zXaOR01g/PziAvQPY
         feCfmHzYFtnWyKy37LTnt/5AqHaWcz3WTGj+tXt0KG7V1E/WFelZWYM6JbA1YCZ+LvEU
         vplg==
X-Gm-Message-State: AOJu0YzNwmdWwD5VBO/HxhF4H91wz1ERO7RygTo9AKm0NYSHZGi9R2KH
	ekYCMqtqA3RS2cSr7SaRZew4tgIu4+7zo1+pjnKaHXkNQj6OpBaH+Bkzeg==
X-Google-Smtp-Source: AGHT+IE83J523w8We6kN0ozoYhxpPAnjYWBJMVNBDjJ7nYmRYX/K7DSJA10cGzTCBFlJ8foHZAYUSQ==
X-Received: by 2002:a05:600c:42d3:b0:426:5546:71a with SMTP id 5b1f17b1804b1-426705ce6f0mr95601275e9.2.1720904907640;
        Sat, 13 Jul 2024 14:08:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e83273sm33295895e9.17.2024.07.13.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:08:27 -0700 (PDT)
Message-Id: <e0970381042e4e35074c5f095959d3379aad6d9d.1720904905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jul 2024 21:08:18 +0000
Subject: [PATCH v3 1/7] run-command: refactor getting the Unix shell path into
 its own function
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This encapsulates the platform-specific logic better.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index d9f80fabe6e..59e433bf91c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -274,17 +274,22 @@ int sane_execvp(const char *file, char * const argv[])
 	return -1;
 }
 
+static const char *git_shell_path(void)
+{
+#ifndef GIT_WINDOWS_NATIVE
+	return SHELL_PATH;
+#else
+	return "sh";
+#endif
+}
+
 static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
 {
 	if (!argv[0])
 		BUG("shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
-#ifndef GIT_WINDOWS_NATIVE
-		strvec_push(out, SHELL_PATH);
-#else
-		strvec_push(out, "sh");
-#endif
+		strvec_push(out, git_shell_path());
 		strvec_push(out, "-c");
 
 		/*
-- 
gitgitgadget

