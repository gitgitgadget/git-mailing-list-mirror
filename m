Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B6C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbjHJUjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjHJUjw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:39:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230462737
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3178fa77b27so1145434f8f.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699990; x=1692304790;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLLpD9Qi5cOXrWeRuVA5eZ7qq1szHJn7MosVOt346hQ=;
        b=PpHtvTaQswxFxBxVn9loIz0VJ/0bpkxLXGG2ZQG3j1n+2P1njK1iUho3ooagA5Pzsj
         cm4fQz/IRSr5DzJqq62OCJnEMwRc3RRI9mwo7bNdwJnKEKxNJpZFtaXupOVFlued8Nlx
         HoXl0+aElxglKDA8GOiDzg9rmzZCxnIkwhejFTQCuFnu2wtIOZktxekM6BA95WCZuo70
         pOa06iEJ8WDMZq4XtEH8uF/J7in/EBJM+mz3RuZa375DoJ1U6f3PM2e3bsRafYFkAff5
         KSnkcA0q6CpEmBFZ70eMVXEdFXMxurwSurROvYMY6rvJ3D+Nit3o+s3bMy9AC6ZX/bfX
         ZWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699990; x=1692304790;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLLpD9Qi5cOXrWeRuVA5eZ7qq1szHJn7MosVOt346hQ=;
        b=b1nTk6Y2l9SRIMARR4NjD1NMWx5U9oJc5n7t8b5i4irB7R2l8ANZK7p5q5A4d+dqY0
         oXpfR/JI7mixmPyInk5qXhHPCK2BXEt2B7DCRpMom58hWcBijMWxYu3LsnPAze50X+3s
         5qDD7Ll9TnVGf1v8vRY3W4lUwcHxIG0FEF2qZfHpSNb6SylJgU8LV7IBsDkXRiW546k+
         QdjBiCHrJ1e8z6E0C4cgAnzAByaKaa8bvI67io3cB/VpYA3AMeZlzSiSQ1Ze9RrlSCbb
         r0xhUu+GfqR61pKN7MP7gBLl2u/WcDNSBBGNVKYCBMJZrLlTvpBGIfO0QMejnJ8Vc/jD
         oPDA==
X-Gm-Message-State: AOJu0YzP+w/TpRUIIuay/xG0/Z08oCoien43S0eK5yJlshUgNtmFFT4o
        9Pxqj30RSxDb6Brk6xFkmCbwFP5cvrg=
X-Google-Smtp-Source: AGHT+IHlcoPC7rCYioFKfYE2b4+buiw6gLleqqW+WQKxckKj2gp9iCdgEhBvUK+Rrak7TsJUADtYkw==
X-Received: by 2002:a5d:4bc9:0:b0:313:f61c:42ab with SMTP id l9-20020a5d4bc9000000b00313f61c42abmr2829808wrt.56.1691699990334;
        Thu, 10 Aug 2023 13:39:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a17090682c600b0098669cc16b2sm1383261ejy.83.2023.08.10.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:39:50 -0700 (PDT)
Message-ID: <72ec86f2f882a575544aef71517b0727f2510a0e.1691699987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 20:39:41 +0000
Subject: [PATCH v2 2/8] maintenance: use random minute in launchctl scheduler
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The get_random_minute() method was created to allow maintenance
schedules to be fixed to a random minute of the hour. This randomness is
only intended to spread out the load from a number of clients, but each
client should have an hour between each maintenance cycle.

Use get_random_minute() when constructing the schedules for launchctl.

The format already includes a 'Minute' key which is modified from 0 to
the random minute.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 2ebae7bc17c..286ce131a5c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1708,7 +1708,6 @@ static int get_schedule_cmd(const char **cmd, int *is_available)
 	return 1;
 }
 
-MAYBE_UNUSED
 static int get_random_minute(void)
 {
 	/* Use a static value when under tests. */
@@ -1830,6 +1829,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	struct strbuf plist = STRBUF_INIT, plist2 = STRBUF_INIT;
 	struct stat st;
 	const char *cmd = "launchctl";
+	int minute = get_random_minute();
 
 	get_schedule_cmd(&cmd, NULL);
 	preamble = "<?xml version=\"1.0\"?>\n"
@@ -1855,29 +1855,30 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	case SCHEDULE_HOURLY:
 		repeat = "<dict>\n"
 			 "<key>Hour</key><integer>%d</integer>\n"
-			 "<key>Minute</key><integer>0</integer>\n"
+			 "<key>Minute</key><integer>%d</integer>\n"
 			 "</dict>\n";
 		for (i = 1; i <= 23; i++)
-			strbuf_addf(&plist, repeat, i);
+			strbuf_addf(&plist, repeat, i, minute);
 		break;
 
 	case SCHEDULE_DAILY:
 		repeat = "<dict>\n"
 			 "<key>Day</key><integer>%d</integer>\n"
 			 "<key>Hour</key><integer>0</integer>\n"
-			 "<key>Minute</key><integer>0</integer>\n"
+			 "<key>Minute</key><integer>%d</integer>\n"
 			 "</dict>\n";
 		for (i = 1; i <= 6; i++)
-			strbuf_addf(&plist, repeat, i);
+			strbuf_addf(&plist, repeat, i, minute);
 		break;
 
 	case SCHEDULE_WEEKLY:
-		strbuf_addstr(&plist,
-			      "<dict>\n"
-			      "<key>Day</key><integer>0</integer>\n"
-			      "<key>Hour</key><integer>0</integer>\n"
-			      "<key>Minute</key><integer>0</integer>\n"
-			      "</dict>\n");
+		strbuf_addf(&plist,
+			    "<dict>\n"
+			    "<key>Day</key><integer>0</integer>\n"
+			    "<key>Hour</key><integer>0</integer>\n"
+			    "<key>Minute</key><integer>%d</integer>\n"
+			    "</dict>\n",
+			    minute);
 		break;
 
 	default:
-- 
gitgitgadget

