Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93681C04A6A
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjHGSvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjHGSvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:51:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18C7171C
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:51:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-317e427488aso1397140f8f.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691434303; x=1692039103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+BtuboBjFPEmV67Rer1J24wk6zjGENS1FELhnkdM3w=;
        b=rekL1sBlxd2Hcyb5HRKsLWwYrM9bZ23G+YxWS+qBcoCmbbRNqDhfLUwUwmod0qTyIp
         nTwdS7xVHuKEAzz1qCTvvsKbjADKIa0g4qOB1vCOTUKmdPIGFratFrK6iBCsg4htqYkx
         sqZXOHHpKom8nujHnMLAN9JkVSWPYa2SziHuSt1pZ9Ijd9hVI6P0vb2wJ950djtYPLow
         ydu8wy6dMOom6ceLGX+GCx1eFO4hJe/m+82sP6PBzcvpQVQwowgEt/Nyc6fuatFrtVF9
         g1yx/u6d6MIWrbKItbI/zoIy30HrXNbY3gGQvlY7sd0lfhrw0cQZgETjoaRWvTauez04
         iZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434303; x=1692039103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+BtuboBjFPEmV67Rer1J24wk6zjGENS1FELhnkdM3w=;
        b=KS8tarvErWskmRSRNrQoEy0OoFMNysuplxGEJmYsjA1+RbkcGOUy1QYs1Nujf3aVk0
         KH7Eh/uEMez1SCHGIFfNGql8LW4fV5jmBp3KbMF+vj1fnG4c5FUV1j3o/roSAR8kUCnn
         O7z9Abzak2kF8xzIjhqbjgnfEuTY1OqUzEd5EKW39CFcFJaRp1cXGTuRpWYSldPiZDsS
         cRWn6BkWGG0b1dkyhwHjBW761doiUZtC9r0LjWFAXalcf/kVJbxVyLrkwvk7jsXyHS6w
         /HSCQOnRc6KZMA0Jfl3f15hmNRpUdXxHRpjE/P3EhN576Nh6nHruEbHwM7/vKng45Rhj
         DfXQ==
X-Gm-Message-State: AOJu0YyAHHNJ52J7aifZs/PeuZX0qm/fejpzhD8gmZUxo4JcKjXuG3aJ
        V5CxRoF2b0i2qrsFmvha8OjMGRKAicM=
X-Google-Smtp-Source: AGHT+IGZc/2ud9mx1lRfQHrFFhAXBtzbledBbXqASC4tse0Znv35yxV9VobL+Rq6B+3MDOJtjE3qQA==
X-Received: by 2002:a5d:420e:0:b0:317:6f08:8371 with SMTP id n14-20020a5d420e000000b003176f088371mr7431941wrq.48.1691434303000;
        Mon, 07 Aug 2023 11:51:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3-20020adfed43000000b0031759e6b43fsm11297769wro.39.2023.08.07.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:51:42 -0700 (PDT)
Message-ID: <babf62ec6d5181c65dd4b653ba9ae24e62a88830.1691434300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 18:51:36 +0000
Subject: [PATCH 2/6] maintenance: use random minute in launchctl scheduler
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
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
index 66a972bc292..51d6c7620ff 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1708,7 +1708,6 @@ static int get_schedule_cmd(const char **cmd, int *is_available)
 	return 1;
 }
 
-MAYBE_UNUSED
 static int get_random_minute(void)
 {
 	static int random_initialized = 0;
@@ -1837,6 +1836,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	struct strbuf plist = STRBUF_INIT, plist2 = STRBUF_INIT;
 	struct stat st;
 	const char *cmd = "launchctl";
+	int minute = get_random_minute();
 
 	get_schedule_cmd(&cmd, NULL);
 	preamble = "<?xml version=\"1.0\"?>\n"
@@ -1862,29 +1862,30 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
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

