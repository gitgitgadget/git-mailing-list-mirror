Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D6DC04E69
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjHJUj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjHJUjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:39:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868B90
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so2084667e87.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699991; x=1692304791;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyVIVcXnMJ/sAFRD9OUPebLLA7kp94IwaUsqTrPoYfU=;
        b=byFIdY5sRGtEWXthww1QuSMQvzf+sRz1/dH7Zx4Us0/3qaOBY0m9Tho8rguWW+0Prs
         A1sWNXPoE1aTNy8F21+Kqx+LF84rTShnH8EWhZJUk469+cidOAK5cenKiqZhGTGOmlFf
         wf3c8YOm4C3rByt4kTkR8OxizhzIEsY8DU2Lby87eVWrdKxN+MrYfz/HOF0Jm9mt7qBT
         bJetac+5YRSt7zvCmfbLarOV3T4SnRCuvwGanymz6pgCvihbEYrAq6/iuvzSB8T57TsO
         8Y1qvsBYqJRa9XXUhkAjIwNQIxtWMPK+B+Ubrhoj2TnlcRabfb1K7H2p3Ebj5XWckQLv
         S87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699991; x=1692304791;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyVIVcXnMJ/sAFRD9OUPebLLA7kp94IwaUsqTrPoYfU=;
        b=YY6juSGvRTgOfq9M9BAF1+o+thKVCdtM+nJIO68tAFzpz1gcedJbfyH5PXghJ2Ul2t
         jPRvlK9XIM9ReU6az3U2ui+tvNRolJpDJ9WxQsB3rNbzVGJ5tOdMgPAxCc+q+C2BY6Ak
         0PVXtfv3AkS7JmPU4Jt1wyn3C+9bkSH9EQ0MpikWAQw13wr/Sf0Q5q6L+fFg1BCYqI45
         1XuPFJfzmFBnU1pJcPdPYCZuekMZrgXYOYZMku/FGonLP9+QOTGI46BPt/GEc1L0VnwV
         ndPruun94gGXuke9cHC046d7c6lsX7Lj+zDVchChDgAl/4is72vtNLZQ/OEyCANpfqA8
         IIBg==
X-Gm-Message-State: AOJu0YzjcTKG1zQyEa0iDQhSjGXr8E3wjts4D3ilAUBQ97btBKMmuXlf
        ctgh5IXeDa29/tm9cj0QqOEnJ2tpeIA=
X-Google-Smtp-Source: AGHT+IHmHjOYWWCpv48HnM2OPryzUVEWpVAKZCT9JxL/cJrPnVEelY8ZoSloJOZTe773eBkdle+cOQ==
X-Received: by 2002:a05:6512:2312:b0:4fb:7642:88dd with SMTP id o18-20020a056512231200b004fb764288ddmr3807527lfu.67.1691699991111;
        Thu, 10 Aug 2023 13:39:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m25-20020a17090607d900b009893b06e9e3sm1376934ejc.225.2023.08.10.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:39:50 -0700 (PDT)
Message-ID: <f6d9c4f3b02653be7139c5cc0adb90564c6f7b12.1691699987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 20:39:42 +0000
Subject: [PATCH v2 3/8] maintenance: use random minute in Windows scheduler
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

Add this random minute to the Windows scheduler integration.

We need only to modify the minute value for the 'StartBoundary' tag
across the three schedules.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 286ce131a5c..78924bb32c6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1995,6 +1995,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	const char *frequency = get_frequency(schedule);
 	char *name = schtasks_task_name(frequency);
 	struct strbuf tfilename = STRBUF_INIT;
+	int minute = get_random_minute();
 
 	get_schedule_cmd(&cmd, NULL);
 
@@ -2015,7 +2016,7 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	switch (schedule) {
 	case SCHEDULE_HOURLY:
 		fprintf(tfile->fp,
-			"<StartBoundary>2020-01-01T01:00:00</StartBoundary>\n"
+			"<StartBoundary>2020-01-01T01:%02d:00</StartBoundary>\n"
 			"<Enabled>true</Enabled>\n"
 			"<ScheduleByDay>\n"
 			"<DaysInterval>1</DaysInterval>\n"
@@ -2024,12 +2025,13 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
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
@@ -2041,19 +2043,21 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
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

