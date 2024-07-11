Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814E1A254C
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739508; cv=none; b=Wt0brzb8d6UQMf07c6Avy4bQF826vcQPKEDJ4/vObgoQdPsHkYRCbcZtw/FNbsMwtArdI2n/1U37/yGhK9JkqHPD2A2ith9JLIiehlo4d5WaCbC9p4alhkxo40oC0qN3PzITziHskC8ZCMBkwmzHbLdhJ7H6I3P8Ao/ZbZcXHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739508; c=relaxed/simple;
	bh=wGI/u536ygogFWY5DiujXv3jyD5Cg7FCZEx8VWytJyU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G2xH9ovUKsRCQ33pMvY9Jh2kW+lh81EMcwkK7dR9HJfrhZSyiRRjP+jL+H18LV5nsmdLl7p46KtN4fu8AGerPn8BxoVPcQ/oSYADmyoxcsa0QY08l6Pgem4yRqp/ZzqUObYm4yI7xSvCF78P0TPAW3HySoIN0rL4snONY0mp20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLflORXs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLflORXs"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367a081d1cdso734659f8f.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739504; x=1721344304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKBFxlpxtqw+lcKlQZcVepA2RqMBX87eNLI9J5v2lpI=;
        b=JLflORXsopr1Wh76maomSK44dPGw5wMNw2mC3jVHNIrWSroQlxjjyx6ezFkHp7wVO/
         s/4M0z85UkMi+poj7lADZWyAp3pOuF+k6ykzYPktCrYFjjXVrAki6OT4jXrSRITmxV/j
         uFqJofbvKq7LTmklUEwh7dKOpSSTUPfPrVehC0wp7vUKLXs2EhvjKDMQOCNXRNkpmT1g
         QvJ/JU8iLYC6v6V+pn9qgznflnuk6L3Uv6OSqDwVRhcoEM859iHHUg8THYVpnJnF+kxL
         n2U1kjZx9i3SQL6ibLK4Mc2Xro+7da/DhkCY3l7QrS6hvP9+D6zc4okUL8wkYeefqPdC
         PZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739504; x=1721344304;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKBFxlpxtqw+lcKlQZcVepA2RqMBX87eNLI9J5v2lpI=;
        b=vjOfSiooMqdLPX6Ts8O0HRB7eO9Cq10I34RtvTPYeaY5mQD6Q1W940IgYdhabF4Q4r
         sgPvSD8hAxKKnyTgak+pffUU9eErPLcWQbG5zd93P51RvdhD1IZjcNPHPAO44zzJNaW7
         rLtnfurzAdW6a/ksxK94JGxC5C47Gtcrnf2dpOshzhbqYJKZ6/8uz18cCIfbFEYOAw+J
         n1WTT1DhXWB5/upV/VtrQMeLVjJumOxeciFYOxmT19GIv95dCAqZL0RNGoOP6tUhxH2h
         fiZsGHYwDKsyZm/xjrXpVF9SmV4h6cz2fR4IS3a3PxnMiNlXMWjTxMunepBwvZJGidbv
         AotA==
X-Gm-Message-State: AOJu0YzezB2mnFj8W85lx+f1rL8GjLDAwsKMzOg1k924DMU0Kt50aiEK
	7nNXcRpVX+fZY7/FT+aHWKtAeY01IIWYf9XkBoOwnacLpyhLw1WWDsWErg==
X-Google-Smtp-Source: AGHT+IF8HjJOiMpLpVjk40EL5Qv7GTbD0jh+b1g0EHT0JBLmyqp1UU2cZaItrMokrH8VOvWy76x6gg==
X-Received: by 2002:a5d:4ac5:0:b0:367:9792:8bd4 with SMTP id ffacd0b85a97d-367ceac4988mr6213796f8f.43.1720739504400;
        Thu, 11 Jul 2024 16:11:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7ed52sm8958450f8f.6.2024.07.11.16.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:11:43 -0700 (PDT)
Message-Id: <a74a7b4bb1129a33230e63ba72c656f52adb0e61.1720739496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 23:11:35 +0000
Subject: [PATCH v2 6/7] run-command: declare the `git_shell_path()` function
 globally
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

The intention is to use it in `git var GIT_SHELL_PATH`, therefore we
need this function to stop being file-local only.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 2 +-
 run-command.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 60a79db8f0e..45ba5449323 100644
--- a/run-command.c
+++ b/run-command.c
@@ -274,7 +274,7 @@ int sane_execvp(const char *file, char * const argv[])
 	return -1;
 }
 
-static char *git_shell_path(void)
+char *git_shell_path(void)
 {
 #ifndef GIT_WINDOWS_NATIVE
 	return xstrdup(SHELL_PATH);
diff --git a/run-command.h b/run-command.h
index 55f6631a2aa..03e7222d8b5 100644
--- a/run-command.h
+++ b/run-command.h
@@ -195,6 +195,11 @@ int is_executable(const char *name);
  */
 int exists_in_PATH(const char *command);
 
+/**
+ * Return the path that is used to execute Unix shell command-lines.
+ */
+char *git_shell_path(void);
+
 /**
  * Start a sub-process. Takes a pointer to a `struct child_process`
  * that specifies the details and returns pipe FDs (if requested).
-- 
gitgitgadget

