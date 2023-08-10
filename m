Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0154C04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjHJUjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHJUjw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:39:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94822733
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf1f632b8so189961166b.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691699990; x=1692304790;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTlu6ioOuZXbw26fjIFdlY7LR+y8R0cVsTh8z5RJBQY=;
        b=o8pJfJSIBLtVkXErLyYqK2oju8MT7IjromXaCcAnzASVYhKkAiUkxVsDkHIpOETIV2
         QuymCBO9nyYmIGBgCc4BUW/5mGfQ3HH1yfNXE1ABYUDPZgQlaik6TIFFfHIkpDfbz3HY
         CeCHF6hqa3F0iug70U+QNpTrKpjIsA7GaEfRIeyCeuywpj7RxGK2prtodAG+c81/wKKS
         qRZziyxCGUGcgU+UxMNSY6VvQdR5y5N1OrAcz8PiVAKNf9AeEZ+4ulfwHN3f0MldjyDJ
         ccBwTUuO8vVry5Dc9fu3zzvne21A9Wba1HflCkF5NPi1n4sPRasMzXvWwGCaG3C3qlCs
         PHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699990; x=1692304790;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTlu6ioOuZXbw26fjIFdlY7LR+y8R0cVsTh8z5RJBQY=;
        b=NnqUu8Y3ztb0ONfhbu92AZThzAuOZpnOcuB6Ov9bGz0//e5jCExQHoEQ/eOMCDKMiq
         WpTI7nwMXkj55fgsoJ7AUkMMZ9ypY4bY8aMCB09lkQmo2i/kcRvo9VOkzyqaMNvFfpnO
         aHeJ/2vmuQ5xCvU+Zsx1k6TnCAkgcx+8bq3aPERog1Do4A9koPbghpRc+NXi2OdfOQoJ
         HXbXVGbdKF719y5fHxhAGrbcTVqSNOtZpTEt6oRp6hNzIDjlAEw4fsgFNoWowPcRGFQ9
         Im+B3b/SZVabJ9rmru1BDPx7k2HZxI4RFhZ46mYJk1TTIF2xHBddqEQQArcF//9w2AxS
         4IGQ==
X-Gm-Message-State: AOJu0YypQwgcd/sm9p/EPt0lI9pcoYWt9opNnx/qzTEc7tu3t+Gi6b99
        6ISkBuCeU84uvwiOIy48rzH5wipiRq0=
X-Google-Smtp-Source: AGHT+IFrZNYZQn7YRhFJF8xsvwSdEPEyI5o5Viye1ohgtw9s/6tebmR1T8qnyy6Z256CpFgB7+J9xQ==
X-Received: by 2002:a17:906:2ce:b0:99c:bb4d:f5a1 with SMTP id 14-20020a17090602ce00b0099cbb4df5a1mr3438ejk.4.1691699989787;
        Thu, 10 Aug 2023 13:39:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709060a0e00b0099b5a71b0bfsm1375124ejf.94.2023.08.10.13.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:39:49 -0700 (PDT)
Message-ID: <edc08023ed51890f0390aacf783d7213e82704a7.1691699987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 20:39:40 +0000
Subject: [PATCH v2 1/8] maintenance: add get_random_minute()
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

To avoid multiple sources of randomness in the Git codebase, create a
new helper function, git_rand(), that returns a random uint32_t. This is
similar to how rand() returns a random nonnegative value, except it is
based on csprng_bytes() which is cryptographic and will return values
larger than RAND_MAX.

One thing that is important for testability is that we notice when we
are under a test scenario and return a predictable result. The schedules
themselves are not checked for this value, but at least one launchctl
test checks that we do not unnecessarily reboot the schedule if it has
not changed from a previous version.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 10 ++++++++++
 wrapper.c    | 10 ++++++++++
 wrapper.h    |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 19d73067aad..2ebae7bc17c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1708,6 +1708,16 @@ static int get_schedule_cmd(const char **cmd, int *is_available)
 	return 1;
 }
 
+MAYBE_UNUSED
+static int get_random_minute(void)
+{
+	/* Use a static value when under tests. */
+	if (getenv("GIT_TEST_MAINT_SCHEDULER"))
+		return 13;
+
+	return git_rand() % 60;
+}
+
 static int is_launchctl_available(void)
 {
 	const char *cmd = "launchctl";
diff --git a/wrapper.c b/wrapper.c
index 5160c9e28de..48065c4f533 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -819,3 +819,13 @@ int csprng_bytes(void *buf, size_t len)
 	return 0;
 #endif
 }
+
+uint32_t git_rand(void)
+{
+	uint32_t result;
+
+	if (csprng_bytes(&result, sizeof(result)) < 0)
+		die(_("unable to get random bytes"));
+
+	return result;
+}
diff --git a/wrapper.h b/wrapper.h
index 79a9c1b5077..79c7321bb37 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -139,4 +139,10 @@ void sleep_millisec(int millisec);
  */
 int csprng_bytes(void *buf, size_t len);
 
+/*
+ * Returns a random uint32_t, uniformly distributed across all possible
+ * values.
+ */
+uint32_t git_rand(void);
+
 #endif /* WRAPPER_H */
-- 
gitgitgadget

