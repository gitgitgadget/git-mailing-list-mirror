Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FF33DF
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390554; cv=none; b=oHoClpArM4WxGpopHHSokBM3WwGPJ7MPi8giKJH9iwkEK7AupaNYdPmCJknEuFAmWVjpMSpVtd8j69RzEoTsv2FHpOuucdVgXqLEMtnx4rZ5r5fcOYBl4ooD1/GPwMJ1KRY5Celrs79GiZ4ACoqg+ltdFZTt534nmMI/7hkxrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390554; c=relaxed/simple;
	bh=KMSjCfMurk5zS0ItXmb9jPpI2hx+UmRLmWLn26kY+go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pephZMkgWyb2P0GCGCjVL7bMrE8DkX3SE18GT5Ek2qq62ZYvcaxN5o+L6O8YrvBCPdWQpTGiE6BiTlDtDJaLkWuXD/i/iVaY7sPLUtkf+LLVpkbIlA8Dx2QngO4E2RnJ4Nwezr5eJxYPXqKVOmbkRt+QWA1PhaTLuMeS01TNAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9FH07oJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9FH07oJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22398e09e39so45370525ad.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390552; x=1741995352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaVIBUR2+3LQOqSFdcyd8jdcIr31CphUIj7XI2Ih8lM=;
        b=d9FH07oJEDOx5lTl9mJc16TVtE+7Fm0be8GrQwhN9z5ni2RNK40L7wLH98mOf8RLhy
         TozCwmuXXrzjPA8v2m1GJ7E5zmrc1DA7SaY4PLhpMztdNJ8vxWRxLztfi7xDTHZ3jP5F
         GBhQSAU8xKUkV9Lkkq5xwt7AB+VaE809vShzdhDoHauJRhRyrZ2oc5rDtsK5SmP0bWZ4
         6WzCwGBHxvHfH/xeGIgVSRVDlYTghjXlDTQX9QWZPBsaFcSYKBpSRvermgJa8S102vG0
         tTGq2+tvIrmtRdu3jh4z19ruo9VNv0RWcUcToGuKGGrfM2FrCDipqXT7vSuGeSEyOPvb
         yD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390552; x=1741995352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaVIBUR2+3LQOqSFdcyd8jdcIr31CphUIj7XI2Ih8lM=;
        b=kX+PNysInehH9Bfu480AOXCDVqw4cwH+iJyqACKk4TMUhZp62SraFXySul8YJ31JzP
         p++/oGFkT5w0QsMCLhw9GjimtyOOuanEagQGIoEf505JBe/v0sQYUz99PQTHggKygVRq
         APy9Mof9g6Wd6WFLonXbkqiAOXtbQU/jR1nFOnJPlW10tTl1TNzLTjmD1uWx76YII4f9
         BYeUfPHVYr3W+YZKSV6e8HahKO6LwWdarJxrfuoKawMvnFyRSUUJ2Q8YmfaIRsARRcmH
         FQgipbcbaXDV9wbT85+25e0D5YjRK0bYrdWKI5YPS2ihXZsBFD+vPsjkYy2ve8VPVZdX
         gOZQ==
X-Gm-Message-State: AOJu0Yya2q7rrmhu2qbJSGcUO/vjrpgfup740+8U1ez1NYZ6uCQlhYnw
	I+c5gTWhPBZqKqPjFodifmENO6ktnTbG2p3fEw+QTjytgZ2BwRUcKOL1sf6bhy8=
X-Gm-Gg: ASbGnctfZqoofcnUTCrIsLnc/HTovjo6CfMDowMaseQtqP8evlC6/VPC1nJX2vTXXz2
	FxuYBDC751TwdXhARBqluNjYA8p+2UIXXUxiC4RNxZRkYHbZdS/C8o5/XaRMrZEd0a1V8IRCLJl
	dk7AC625h4p5fBsb4Nfnllt2SdLXec6SWLQm4WSnicV4MO0Sfz15aNcnKFN032bhG8CZpzuJjU3
	ooc9R2T6qNRAQVp4lf+NSn8s9VpmvjkNi7CJx/w5zJJ9srOSKO7DjfVQge8eRFxTcnxWXL/OAuA
	zPzV4EbVcHDy1uJ2EoR5Y0oSJ460vEmxRuUIu9NTqbDDviwVUB+DOKxiEKP5EpI9Yww6nQ==
X-Google-Smtp-Source: AGHT+IF9zq7of6t3GaMAYPhbzVp0GDuO7+yNK3agJ7Hy7GfQ66ovP1ONBwrC6diSzWRg0K7mL2JqLA==
X-Received: by 2002:a05:6a00:194b:b0:732:5611:cbb5 with SMTP id d2e1a72fcca58-736aaa56ddemr6149106b3a.11.1741390552060;
        Fri, 07 Mar 2025 15:35:52 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bcb8de04sm423880b3a.154.2025.03.07.15.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:35:51 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/8] config: teach repo_config to allow `repo` to be NULL
Date: Sat,  8 Mar 2025 05:05:00 +0530
Message-ID: <20250307233543.1721552-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
References: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
 <20250307233543.1721552-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `repo` value can be NULL if a builtin command is run outside
any repository. The current implementation of `repo_config()` will
fail if `repo` is NULL.

If the `repo` is NULL the `repo_config()` can ignore the repository
configuration but it should read the other configuration sources like
the system-side configuration instead of failing.

Teach the `repo_config()` to allow `repo` to be NULL by calling the
`read_very_early_config()` which read config but only enumerate system
and global settings.

This will be useful in the following commits.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 config.c | 4 ++++
 config.h | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/config.c b/config.c
index 36f76fafe5..c5181fd23b 100644
--- a/config.c
+++ b/config.c
@@ -2526,6 +2526,10 @@ void repo_config_clear(struct repository *repo)
 
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
+	if (!repo) {
+		read_very_early_config(fn, data);
+		return;
+	}
 	git_config_check_init(repo);
 	configset_iter(repo->config, fn, data);
 }
diff --git a/config.h b/config.h
index 5c730c4f89..29a0277483 100644
--- a/config.h
+++ b/config.h
@@ -219,6 +219,15 @@ void read_very_early_config(config_fn_t cb, void *data);
  * repo-specific one; by overwriting, the higher-priority repo-specific
  * value is left at the end).
  *
+ * In cases where the repository variable is NULL, repo_config() will
+ * skip the per-repository config but retain system and global configs
+ * by calling read_very_early_config() which also ignores one-time
+ * overrides like "git -c var=val". This is to support handling "git foo -h"
+ * (which lets git.c:run_builtin() to pass NULL and have the cmd_foo()
+ * call repo_config() before calling parse_options() to notice "-h", give
+ * help and exit) for a command that ordinarily require a repository
+ * so this limitation may be OK (but if needed you are welcome to fix it).
+ *
  * Unlike git_config_from_file(), this function respects includes.
  */
 void repo_config(struct repository *r, config_fn_t fn, void *);
-- 
2.48.1

