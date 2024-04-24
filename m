Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889261649DB
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975307; cv=none; b=OOh+AuIYPx72ywufQB9+HAYzYPPcLajd2JesOx0url8MDHVRA6a7Tf1l+C9kCR/eHpcnEHBR551sUqfILvEo3peVR7loyx1KwCu7jKADf94sJs5+nHws/xQzS4b50o2p/WF6gcgJ9uOvYPCApczdqCDoSdZah9dSbYtSuGfhpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975307; c=relaxed/simple;
	bh=44KQ3EAkN/r9Lpt3Z6TN3KeZHAMWTXNsgYBp9Ne5Afw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HbrnKX0fqe6fP0qBjwJBOfBaCoSWpAMcpO2TrHg5lllitIv2e4ObSgDuKINK/GuEBPEbWNqzTFN2gIkoB8hZwi62s94go5t9EeCeFCqAWXil58XE0rXeskVKxM/+uh2BlogaHD1WsISqizSBGigWj3Tyr+pHaOlYKg89UP+IoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhr9ohZc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhr9ohZc"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-349545c3eb8so5159271f8f.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975303; x=1714580103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgi/Px72RN4U4mvle4UUACuUiAdUWBL0SgFuvVN5L7U=;
        b=fhr9ohZc0ltepN0wr5WAjvJS0Rhk0iJ0FDOtnvaci3VKC+Ebq377B1ZdZuxQ0lgJwi
         +hBXRrhI/jgwnK+VpIXUF3IzA45d5lbjYF681irvCh/mHwarI7ch+QhFfJZ9S7C/DJ4g
         kgpoRtJL2dypvrPTNZS2lprIEPLWTLym1D+HcadiKg8z2lKnxAaLTnZE/2TH9tDhdKvt
         1RotFLoVDWNAHld6wRSisfDqODk8H0GGNqfiK14Rq91ksxJTUtAbz5We2ygL0HnGDJ1c
         3g0fOpNktyZUB++qOjPmUVX7KvYE0yGPui1epMpQIjQDjpAgg18889lbZripRppU45zb
         cG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975303; x=1714580103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgi/Px72RN4U4mvle4UUACuUiAdUWBL0SgFuvVN5L7U=;
        b=VWd0Da7r4JLO3wzeoFPdmnQZB8ySjg1qclWlIMfqVOn/eBikRiEleQUW55pj/UBHJb
         TThfPotUGtPWt011RnulefC9CJb/xMJfL7bV3eaFAlTbTnu78SXDyBAxsUNsSHtK8Elc
         zP/Pxyy3GF1HDsXJJNmWLCTLb3TFCiKyy387BhKAHCyQC28QTnNO8bFdUHenrPlntfQe
         Hq0WtEh6be0r0f3iU2I5BoPe2/ZuDiibo3Mn6dlSWXSUdoYW9wSH1XijWYhtXlkUcYjC
         Dp23+BUE3IG5gYCOReX1NdyKnv2AauyQ8eTFIrueFTUAG74p1kT7D+M3jnoqmqX5SfRk
         Yb3g==
X-Gm-Message-State: AOJu0Yw1a3jg/IWPPTzQtPb4LrVePG90mwgklMdqaKeYxOrS9V+nDnoF
	7uYyWXGcwAQffduI2aT5D64Uk6qQMWjOMa2HT7bzJXorG7dgpGAyD6EqWA==
X-Google-Smtp-Source: AGHT+IF9jZQq8xB1jikdYoqsgPJhjUJMxGGu96ZHE4AxfxHuKyDZRphNgKEmstqolqQIBIIHgu95CQ==
X-Received: by 2002:a5d:574a:0:b0:34a:e73a:56a3 with SMTP id q10-20020a5d574a000000b0034ae73a56a3mr1888243wrw.7.1713975303165;
        Wed, 24 Apr 2024 09:15:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b004169836bf9asm28069227wmq.23.2024.04.24.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:15:02 -0700 (PDT)
Message-Id: <540962859c599cb8896ab0860592412568e9b44b.1713975300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1719.v3.git.1713975299.gitgitgadget@gmail.com>
References: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
	<pull.1719.v3.git.1713975299.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Apr 2024 16:14:59 +0000
Subject: [PATCH v3 2/2] maintenance: running maintenance should not stop on
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
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
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
