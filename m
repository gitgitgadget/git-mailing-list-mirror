Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD2C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjHGSvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjHGSvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:51:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A28171E
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:51:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso7865537e87.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691434303; x=1692039103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWK128KV/FPC578HhVA3Ufgz0FEGPzPqKqZtsyfJpNs=;
        b=IbTAXrIN62E2DqxjVIXE9PPDSUgObIFg2SvjRUfPbccs36ku1Z/hG/xfo+9/l8jpe9
         KP+b6mlqH6fjeQebmuW0azH60j/4dUoLvTf/ZBcxcWhB3p+7wLLYTPTn6a+rQeRSIrJy
         u9STxR3v+74QHC+yWZIRPBPM5a+2H4r9VRDMd/czWBI6yJYXulgucnmg2zwEnC8KLRsN
         izjezhdd6C0wZDgvjKx31AJJC9tkdPrQGf9ZWOecDR0ko1fy22TyX9DQlrD0tUEpavwY
         zzeWOe3m7FtdoYeVh52ZD1d2ynnBuSjRdQJxLZy2xdf2jgEA8X8411gbbeZNP8dx1XfI
         63IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434303; x=1692039103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWK128KV/FPC578HhVA3Ufgz0FEGPzPqKqZtsyfJpNs=;
        b=RTOKXnHN/sT7bAsC3WVmzgdbCD5IkqPGYfpE1wtK5jN20wsodvfinz2bcYhR56MUw0
         A3rUbnrEiaDCKUoQ4jx87TSKPzMiON9rzYFeeExbtHxA5KgLtW4ALV81TO70g3vFKleF
         iHoZUmMLNmEV+Uyumzoce6c5ZMCPRkZwJXosaEl6FRpvyS/2sjNnsmudRPD7tLPZp7ac
         QWGWBQoP4UboNAJCWlQs3lbXfd1w0CnjdNaeLm1/h0UTVTWUUl6OSyzsS3l0OI3VRWkg
         GIbVxZ6u6Rm3TOO3qZk1u3nS0DUdEQy1PZMaw3HR6QINYqtnyl9LzU0nMqoylLZHTMKa
         TV0w==
X-Gm-Message-State: AOJu0YzePOyQOlKyFf/yFY0TkrqQT9VZnZfOozBphRDcVKBPghACXrQY
        rpJGxXfrtrq9ROlVxJW6shw+ooczXPc=
X-Google-Smtp-Source: AGHT+IGuPVsKUQkNfNUVvVuX031xgyrfyd9m42ATkCcm8chxY+we0bTYLPmPOfX4jDkw7mE/MQn8kA==
X-Received: by 2002:a2e:9b09:0:b0:2b4:6e21:637e with SMTP id u9-20020a2e9b09000000b002b46e21637emr7257949lji.16.1691434302476;
        Mon, 07 Aug 2023 11:51:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020adfe4c8000000b00317046f21f9sm11287015wrm.114.2023.08.07.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:51:42 -0700 (PDT)
Message-ID: <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 18:51:35 +0000
Subject: [PATCH 1/6] maintenance: add get_random_minute()
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

When we initially created background maintenance -- with its hourly,
daily, and weekly schedules -- we considered the effects of all clients
launching fetches to the server every hour on the hour. The worry of
DDoSing server hosts was noted, but left as something we would consider
for a future update.

As background maintenance has gained more adoption over the past three
years, our worries about DDoSing the big Git hosts has been unfounded.
Those systems, especially those serving public repositories, are already
resilient to thundering herds of much smaller scale.

However, sometimes organizations spin up specific custom server
infrastructure either in addition to or on top of their Git host. Some
of these technologies are built for a different range of scale, and can
hit concurrency limits sooner. Organizations with such custom
infrastructures are more likely to recommend tools like `scalar` which
furthers their adoption of background maintenance.

To help solve for this, create get_random_minute() as a method to help
Git select a random minute when creating schedules in the future. The
integrations with this method do not yet exist, but will follow in
future changes.

One thing that is important for testability is that we notice when we
are under a test scenario and return a predictable result. The schedules
themselves are not checked for this value, but at least one launchctl
test checks that we do not unnecessarily reboot the schedule if it has
not changed from a previous version.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index f3942188a61..66a972bc292 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1708,6 +1708,23 @@ static int get_schedule_cmd(const char **cmd, int *is_available)
 	return 1;
 }
 
+MAYBE_UNUSED
+static int get_random_minute(void)
+{
+	static int random_initialized = 0;
+
+	/* Use a static value when under tests. */
+	if (!getenv("GIT_TEST_MAINTENANCE_SCHEDULER"))
+		return 13;
+
+	if (!random_initialized) {
+		srand((unsigned int)getpid());
+		random_initialized = 1;
+	}
+
+	return rand() % 60;
+}
+
 static int is_launchctl_available(void)
 {
 	const char *cmd = "launchctl";
-- 
gitgitgadget

