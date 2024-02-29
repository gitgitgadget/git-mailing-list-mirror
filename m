Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CA13442D
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233643; cv=none; b=NxHEWBo5gS+rDQsU+7atG2JLlSa4Sf3vrq0fEvGop51861X2TebWgW/RnYULy3XLNx8SqKfcwzmLbR/1qYoCV1LYk7fW8E7uqPz6z+oBHMFRtZ461RI0o5qSnGSszmsBh66cDgRqmfPGVk5N3Ziuyp1wWUCKT0+q30lxqY2+mXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233643; c=relaxed/simple;
	bh=HiJ2JAX0OyEhExPmVxMg77vcaKg+kQCjYU7aFUSTqPI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KmbPilYKMrOYkCvDMofRfDJl3EAdTLQII8YzlP33R84NKomkS275yGAIQr0Rzl1p6UcO3TqI/0U8N0Un9B9brO1sIdN7q9GnlJ4f79c2tzfXAhLw/kr1vCdrjdjcTzzvqN/0VfrFgm4XLTuEzqMfUanyO3R/0zGkO0JUPH3uZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlmayW5Q; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlmayW5Q"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d2ff28f1c3so11243831fa.2
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709233640; x=1709838440; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxDtNpdYBqkBfY3Dzm/qUSTX4ix/yjbVRLJWNMcNqLU=;
        b=HlmayW5QToBKA8g+QYJIkfoH851qlDeZqD0dyIUa/dQO12DMol+IgH36ChIy/T/6Zc
         0vTqE/hsxHktmhwkqYZ28Cjfg+ktWnzvdLykrY46wnUfj7+j0bTONxVP70VBd5SDx1lh
         k0Y4Zn8TXWaO0S/c0lqBRSQ2wNPV4c9+lnnfHs6JNVehIa0fNsMrC1heQkjdRR45bvn8
         9r4m8xPQmSvLmtHHn1n9U1oJw5rn49nGKsbSrRjLOB3b+0pmbD+022YE8d9iMVh3B0Qg
         Wx6oOcclGoPSdndLpMue2FFrkotRpj7GB6Owb8qhqj5P8+dHnW3cQyP91rhBNcmfcW/7
         9UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709233640; x=1709838440;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxDtNpdYBqkBfY3Dzm/qUSTX4ix/yjbVRLJWNMcNqLU=;
        b=pB4biTve5c9PngueBR8dhzDVIYA3WWbEaHlAhunVWvVQwps0wyvPJm2l/8dXH7A+7t
         OfDB/Llno99Ewmq7j0pCPLxQ6z66buG0R5T9p+fExcB/Lt37FJgSBBjpCUor3ug2vHMX
         RLEjAOZkrsxxFnu3q2Vn0qkCtkGOCbRfW8erqlgoBYLHb0aLCj2BIyIERl14uHgHdSET
         Mq0TR8GyIHUM9xvc1bXWJfcr20NorHs5YMht65jHn1xATv1c6JFimrSXHg7WkjNBiQah
         3p46L3Ri3jAvHzBau/JTIUfF/FQ/sKtXQ7KE0wu1szZeHVoDYsPQo9L1o12CNwYX9A8c
         ftBQ==
X-Gm-Message-State: AOJu0Yz2A9g0AIos1o+KeoEdZxfmXfmoFxo81uUuuVU9DVnJu7H24GGm
	zwwrDjRvCqrGZ+K/zULug9ZlCg7gT+N3/JmOPABHmkN5pbI6/LF2/s3vMGJQ
X-Google-Smtp-Source: AGHT+IEZiVIfGDpmRh230SAnatnQh6vFU4N/ikMo6BipOzz8ay/5pxFw05Bjzajc4DLh6jKsgBiafg==
X-Received: by 2002:a2e:9613:0:b0:2d2:ed31:9fa6 with SMTP id v19-20020a2e9613000000b002d2ed319fa6mr1996020ljh.49.1709233639819;
        Thu, 29 Feb 2024 11:07:19 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k5-20020a2e2405000000b002d2c066b01bsm307890ljk.16.2024.02.29.11.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:07:19 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH] clean: improve -n and -f implementation and documentation
References: <xmqq34v6gswv.fsf@gitster.g>
Date: Thu, 29 Feb 2024 22:07:18 +0300
In-Reply-To: <xmqq34v6gswv.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	09 Jan 2024 12:20:48 -0800")
Message-ID: <875xy76qe1.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

What -n actually does in addition to its documented behavior is
ignoring of configuration variable clean.requireForce, that makes
sense provided -n prevents files removal anyway.

So, first, document this in the manual, and then modify implementation
to make this more explicit in the code.

Improved implementation also stops to share single internal variable
'force' between command-line -f option and configuration variable
clean.requireForce, resulting in more clear logic.

The error messages now do not mention -n as well, as it seems
unnecessary and does not reflect clarified implementation.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-clean.txt |  2 ++
 builtin/clean.c             | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 69331e3f05a1..662eebb85207 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -49,6 +49,8 @@ OPTIONS
 -n::
 --dry-run::
 	Don't actually remove anything, just show what would be done.
+	Configuration variable clean.requireForce is ignored, as
+	nothing will be deleted anyway.
 
 -q::
 --quiet::
diff --git a/builtin/clean.c b/builtin/clean.c
index d90766cad3a0..fcc50d08ee9b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -25,7 +25,7 @@
 #include "help.h"
 #include "prompt.h"
 
-static int force = -1; /* unset */
+static int require_force = -1; /* unset */
 static int interactive;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
@@ -128,7 +128,7 @@ static int git_clean_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "clean.requireforce")) {
-		force = !git_config_bool(var, value);
+		require_force = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -920,7 +920,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
 	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
-	int ignored_only = 0, config_set = 0, errors = 0, gone = 1;
+	int ignored_only = 0, force = 0, errors = 0, gone = 1;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf abs_path = STRBUF_INIT;
 	struct dir_struct dir = DIR_INIT;
@@ -946,21 +946,21 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_clean_config, NULL);
-	if (force < 0)
-		force = 0;
-	else
-		config_set = 1;
 
 	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
 			     0);
 
-	if (!interactive && !dry_run && !force) {
-		if (config_set)
-			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
+	/* Dry run won't remove anything, so requiring force makes no sense */
+	if(dry_run)
+		require_force = 0;
+
+	if (!force && !interactive) {
+		if (require_force > 0)
+			die(_("clean.requireForce set to true and neither -f, nor -i given; "
+				  "refusing to clean"));
+		else if (require_force < 0)
+			die(_("clean.requireForce defaults to true and neither -f, nor -i given; "
 				  "refusing to clean"));
-		else
-			die(_("clean.requireForce defaults to true and neither -i, -n, nor -f given;"
-				  " refusing to clean"));
 	}
 
 	if (force > 1)

base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
-- 
2.25.1

