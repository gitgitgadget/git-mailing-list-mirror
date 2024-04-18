Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26212EBD8
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444791; cv=none; b=NtJl8iza4LW7q9eOuFKaELMvG4vDAZlV1XRSwJns0Ks1NVL68I1Wip3PEpnZ5w9wj62m27ZMgdZ69K+DjqgH+Iv6hDi+wgb5Ppaw43CorwrZGEKQjI0LYqHwxoxv62aK8aD0s/btYOKCORgPmWiEQviAYidCbobkCCgS3S9f5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444791; c=relaxed/simple;
	bh=44KQ3EAkN/r9Lpt3Z6TN3KeZHAMWTXNsgYBp9Ne5Afw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jRMLXrRiIVjUZnd4B8rouoNmJXtLBefr44hu+55gN9AG0cMjUyP2G1jV9dfxoTRFULtNIHvMuK9/CE9zmrB5SWtK83prYnM6nSZmBoBM9F1AIYc8jOUk9c6gZk8yDV3l4IUSH7KBKO4gjzteOnUyosDDRTPfiqN3WrH9mg1eE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBgQEoml; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBgQEoml"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a526d381d2fso343435766b.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713444787; x=1714049587; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgi/Px72RN4U4mvle4UUACuUiAdUWBL0SgFuvVN5L7U=;
        b=ZBgQEoml1iM6oOvr6X+fToV1jDQIABGJh4TMj6zd2CR0/vZzJTsmjU5BnWEL7LrtZ1
         IwyPx9u5Cg6iovESXOzzS4i4d/SFONxyTkr7legQGrMhxDv+pGT9OEKnITqndqnRINST
         wAMVe5DgWgHWIulqXc0bwWqpl5rspUlXlHIiH/wOi7sVSs1XYVnagD0gyEKmN/Wen8ly
         aVC8F/1zvkTgfjdboxAGyfiJjzUZ7XUI/1aNSyDrzO+Oq5R3c8jgaZ7EOp6dbwhnaJDM
         OTGu3czIKUgu9WxmjYr1SeIN5ahbc06DCElLjYlycba7K4gcQfQ0MV6N0WBwgLTbVKqS
         sPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444787; x=1714049587;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgi/Px72RN4U4mvle4UUACuUiAdUWBL0SgFuvVN5L7U=;
        b=BWv0UAUPzsR1NgsA/RjbJdh2djPtaV4vVxcp/rNqmXwsr3NXbnIDbvsd7YpjnbEsiS
         JBhPOGIgbLIO3cvhYYGEuBsxH8JatcpcHB8HqeC7Nb1+npng3gvsy+dGjY8JQ1oYoNGR
         wHfPvO7aUhzHuyk0M83laCzd0pb48VpeOSh2YYIkGm9sD89McyBFnkrvPXX0Y5h302vv
         d0P67IMs4/WNKqq6CY/184f+FQSs9w+RV/MIWd5pSAGHi1i4tpHtfGA7fR4DdB7n8qb6
         oB6QrjnEgD/wLkcHIq7Q7iHYGv+0K9wN9JGFp1+J4/a6bLiEkqjCSRp/VpZFt2bDTGik
         IdCA==
X-Gm-Message-State: AOJu0Yx+Dj+ZxssqjvlonvGnm3mp7iQzsyBNxwpbGd8okdpvr+NllPaP
	iHd1zYTYFEXubBByvWmDrfNZiJKMqwSl/LMGX4VB1Pu4bMniCzdg4RLNWQ==
X-Google-Smtp-Source: AGHT+IH/SGHzkQoBBX1DibYpgudmxzJIVfaqzdxsYsQvJ4o2b7ny9vXwDrFaioeXYUY9BDnZv/uXwQ==
X-Received: by 2002:a17:907:2684:b0:a55:7669:8b4a with SMTP id bn4-20020a170907268400b00a5576698b4amr1260801ejc.32.1713444787279;
        Thu, 18 Apr 2024 05:53:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hx11-20020a170906846b00b00a46d2e9fd73sm846048ejc.222.2024.04.18.05.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:53:06 -0700 (PDT)
Message-Id: <1ae11553052cb3f48447eb5df6cbf6f185fa81db.1713444783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
	<pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 12:53:03 +0000
Subject: [PATCH v2 2/2] maintenance: running maintenance should not stop on
 errors
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In https://github.com/microsoft/git/issues/623, it was reported that
maintenance stops on a missing repository, omitting the remaining
repositories that were scheduled for maintenance.

This is undesirable, as it should be a best effort type of operation.

It should still fail due to the missing repository, of course, but not
leave the non-missing repositories in unmaintained shapes.

Let's use `for-each-repo`'s shiny new `--keep-going` option that we just
introduced for that very purpose.

This change will be picked up when running `git maintenance start`,
which is run implicitly by `scalar reconfigure`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/gc.c           | 7 ++++---
 t/t7900-maintenance.sh | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index cb80ced6cb5..b069aa49c50 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1858,6 +1858,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 		   "<string>%s/git</string>\n"
 		   "<string>--exec-path=%s</string>\n"
 		   "<string>for-each-repo</string>\n"
+		   "<string>--keep-going</string>\n"
 		   "<string>--config=maintenance.repo</string>\n"
 		   "<string>maintenance</string>\n"
 		   "<string>run</string>\n"
@@ -2100,7 +2101,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	      "<Actions Context=\"Author\">\n"
 	      "<Exec>\n"
 	      "<Command>\"%s\\headless-git.exe\"</Command>\n"
-	      "<Arguments>--exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%s</Arguments>\n"
+	      "<Arguments>--exec-path=\"%s\" for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%s</Arguments>\n"
 	      "</Exec>\n"
 	      "</Actions>\n"
 	      "</Task>\n";
@@ -2245,7 +2246,7 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 			"# replaced in the future by a Git command.\n\n");
 
 		strbuf_addf(&line_format,
-			    "%%d %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%s\n",
+			    "%%d %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%%s\n",
 			    exec_path, exec_path);
 		fprintf(cron_in, line_format.buf, minute, "1-23", "*", "hourly");
 		fprintf(cron_in, line_format.buf, minute, "0", "1-6", "daily");
@@ -2446,7 +2447,7 @@ static int systemd_timer_write_service_template(const char *exec_path)
 	       "\n"
 	       "[Service]\n"
 	       "Type=oneshot\n"
-	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
+	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=%%i\n"
 	       "LockPersonality=yes\n"
 	       "MemoryDenyWriteExecute=yes\n"
 	       "NoNewPrivileges=yes\n"
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0943dfa18a3..8595489cebe 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -639,9 +639,9 @@ test_expect_success 'start from empty cron table' '
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
-	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
-	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
-	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
+	grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
+	grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
+	grep "for-each-repo --keep-going --config=maintenance.repo maintenance run --schedule=weekly" cron.txt
 '
 
 test_expect_success 'stop from existing schedule' '
-- 
gitgitgadget
