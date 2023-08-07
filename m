Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BA9C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjHGSvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjHGSvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:51:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC6A1722
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:51:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so41782685e9.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691434303; x=1692039103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwyFLOWeSTzKIMd3976gguwZWIzMKJF0Jjqe1sR02Ok=;
        b=LiiG9dSj5rjwLnO7HSzEaeCTekDMcwCCnn5fqgtJfjOZ1nbh9xbQlb2g3SlJj0/7uw
         /a5+P7PdzxR14Cml2Em7isnsANgy3KhArdzj7b4BvtdmKI0ft71LfQQtKYkGxr2ELaBC
         vRM56SGgnrx1PX4t3FzoeEqShOOOV0pgFDO/Ar1eoxWGYO4GwqySoh2GIXgLpe3ZXqkv
         15FOUkxjqO1r3307X5zhBk0q6LvNkEV2tNOBUqPDSxlYOQCd+5ZmD8/4ecdGSJq4FWqa
         V0Mmai/zerTxJn2AlDvOWhmcUu7LBuy03Hpxa+8YL6K0u+q37SENtje7Y9UjvAC+CxLP
         Z/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434303; x=1692039103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwyFLOWeSTzKIMd3976gguwZWIzMKJF0Jjqe1sR02Ok=;
        b=KCLx/ODMmdEKlBLuUSaOXpyP1skvSr3Ttffh87/tjPe58N/x6qrrP+NBPE3E3hxjIS
         3oRZF7P7zhWt+YLv1rbif4n5KkTss+zcSLTKtXbseo5vCLUqHNdyyS9akQ4S3x3ZU/uR
         lw38Le6q9ldKCNt62TPYK1CoCNIC5MJ1F0v1S9oJpQ929MQ1pAGlNKHeIQQ0X14QjBt6
         NkXj4bwycefWmns+OqMZmzPtqpMVlM+YYieuBj0oQr8i42eQc64IqnLe4by/GIdxrk2v
         DRgiFCn9PYguVBm73k3uKv6CDg9ytbi1mdGMT/+gEG1JO9gj+nqWG6TYTSvDeknGQHpa
         CNtw==
X-Gm-Message-State: AOJu0YzOAM8nC4b6cw1L+q5I9jG8wGcKiR6BMy/sNfAk/KAMWPRva0yN
        ncOG/cD/EQIQVtWqnHqZVauzLtTWyqM=
X-Google-Smtp-Source: AGHT+IE3IQI1CyvT+pcbr2WNtO6u7BIT86M5zNE0jGX7A/FXM+wSGm3ijou7ZLfMYDtvGsWtJ47yGw==
X-Received: by 2002:adf:e5d0:0:b0:314:10d8:b482 with SMTP id a16-20020adfe5d0000000b0031410d8b482mr5707015wrn.65.1691434303682;
        Mon, 07 Aug 2023 11:51:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4c89000000b00317f3fd21b7sm1118651wrs.80.2023.08.07.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:51:43 -0700 (PDT)
Message-ID: <1048dff1d3a241effe7235716b1f5d9c46f7478b.1691434300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 18:51:37 +0000
Subject: [PATCH 3/6] maintenance: use random minute in Windows scheduler
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

Add this random minute to the Windows scheduler integration.

We need only to modify the minute value for the 'StartBoundary' tag
across the three schedules.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 51d6c7620ff..f059c9f89d5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2002,6 +2002,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	const char *frequency = get_frequency(schedule);
 	char *name = schtasks_task_name(frequency);
 	struct strbuf tfilename = STRBUF_INIT;
+	int minute = get_random_minute();
 
 	get_schedule_cmd(&cmd, NULL);
 
@@ -2022,7 +2023,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	switch (schedule) {
 	case SCHEDULE_HOURLY:
 		fprintf(tfile->fp,
-			"<StartBoundary>2020-01-01T01:00:00</StartBoundary>\n"
+			"<StartBoundary>2020-01-01T01:%02d:00</StartBoundary>\n"
 			"<Enabled>true</Enabled>\n"
 			"<ScheduleByDay>\n"
 			"<DaysInterval>1</DaysInterval>\n"
@@ -2031,12 +2032,13 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 			"<Interval>PT1H</Interval>\n"
 			"<Duration>PT23H</Duration>\n"
 			"<StopAtDurationEnd>false</StopAtDurationEnd>\n"
-			"</Repetition>\n");
+			"</Repetition>\n",
+			minute);
 		break;
 
 	case SCHEDULE_DAILY:
 		fprintf(tfile->fp,
-			"<StartBoundary>2020-01-01T00:00:00</StartBoundary>\n"
+			"<StartBoundary>2020-01-01T00:%02d:00</StartBoundary>\n"
 			"<Enabled>true</Enabled>\n"
 			"<ScheduleByWeek>\n"
 			"<DaysOfWeek>\n"
@@ -2048,19 +2050,21 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 			"<Saturday />\n"
 			"</DaysOfWeek>\n"
 			"<WeeksInterval>1</WeeksInterval>\n"
-			"</ScheduleByWeek>\n");
+			"</ScheduleByWeek>\n",
+			minute);
 		break;
 
 	case SCHEDULE_WEEKLY:
 		fprintf(tfile->fp,
-			"<StartBoundary>2020-01-01T00:00:00</StartBoundary>\n"
+			"<StartBoundary>2020-01-01T00:%02d:00</StartBoundary>\n"
 			"<Enabled>true</Enabled>\n"
 			"<ScheduleByWeek>\n"
 			"<DaysOfWeek>\n"
 			"<Sunday />\n"
 			"</DaysOfWeek>\n"
 			"<WeeksInterval>1</WeeksInterval>\n"
-			"</ScheduleByWeek>\n");
+			"</ScheduleByWeek>\n",
+			minute);
 		break;
 
 	default:
-- 
gitgitgadget

