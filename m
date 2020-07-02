Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B390C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399A320780
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 19:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlSezPBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGBTZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBTZD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 15:25:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4833C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 12:25:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so9343892pje.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hF2UjjQkr2LxfdZBbXJWulsNlCLtR4dt2Jo05xbiLQo=;
        b=OlSezPBTzqt4g7WYAzeFOlUzXdP0odEwqzRemdT5A1TzwX67TPNlmoUBo8S04K/15M
         Cknna2i+I7a3CEPUIICDkc6MbQHTFKgJjNmcEBLI3ESbIms0qsmer8NcXF7cymBGQXJ+
         /wV/Shf9BSobh7P7WkLeTM6+ngb07OffajOokT+ln5I4SoHNDyxR4rkj+GNCqF8+5UlB
         +j86Y6eM43mNT84Yx3UW4/hQO9t1Q5pFWMvdY85+KDd3FBQfI0j5/ySzzbojKWvjjjwo
         UjSYllTXO5AAk/zVwxUFrfE+ZjjwGjpTt4gtnbnnKCmHAJyqV4wlq4+NGqvbuNjOkjYc
         kk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hF2UjjQkr2LxfdZBbXJWulsNlCLtR4dt2Jo05xbiLQo=;
        b=Zh8tPgk6F+0ymOQC/5r5AUexkdsfj9nrNJU/+qtDivUZOfYMB7xX2gQgMpQ+x4EJo7
         2Y1IAcyGuQaEkd2HM846I2ZGkxrfDAZsMJkwk8NFwRRpw+EN94wI8wzkE3PT1OiGUZNK
         LlxJ/SHlvlp8A5PmIpxtQVlJlpqfRExX0++DNlWhLx7PO6eMq0QpHFqR2NrxuRdU3Edt
         nWKeQA77Eqj+/0ey0M3Xmsqo/n5aSYmyBpusXu9u1wb6XZR5oPTAgHI/y+/mVNXuTBX7
         JKbvub5ZEET1OsNPuR2gqvUPgYeC7Nw/yGDVV899j/tYIM0of+zgrzu2CbwG1zHFAZhe
         DHkg==
X-Gm-Message-State: AOAM531Gs57IZQ30///dnOL3Z9D7Y0HQ4HJ3BopKNnXO+bBm6UoR1kJ+
        ccCHRJQkctVCSblXxBHnhzt9getur6Zxww==
X-Google-Smtp-Source: ABdhPJxsDur0y0a+vpT2/0dOGVSTRW7in66NhW6/Nn3dLqG7/7jSTPJ0hnveyHfre2ke/cjXvCtOpw==
X-Received: by 2002:a17:90a:d684:: with SMTP id x4mr20208888pju.62.1593717901997;
        Thu, 02 Jul 2020 12:25:01 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.244])
        by smtp.gmail.com with ESMTPSA id c2sm9266739pgk.77.2020.07.02.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 12:25:01 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        liu.denton@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, sbeller@google.com, pclouds@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 3/4] diff: change scope of the function count_lines()
Date:   Fri,  3 Jul 2020 00:54:08 +0530
Message-Id: <20200702192409.21865-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

Change the scope of function count_lines for allowing the function
to be reused in other parts of the code as well.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 diff.c | 2 +-
 diff.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 4a2c631c37..39ddbcf451 100644
--- a/diff.c
+++ b/diff.c
@@ -547,7 +547,7 @@ struct emit_callback {
 	struct strbuf *header;
 };
 
-static int count_lines(const char *data, int size)
+int count_lines(const char *data, int size)
 {
 	int count, ch, completely_empty = 1, nl_just_seen = 0;
 	count = 0;
diff --git a/diff.h b/diff.h
index 9443dc1b00..bd96c8c434 100644
--- a/diff.h
+++ b/diff.h
@@ -495,6 +495,7 @@ void free_diffstat_info(struct diffstat_t *diffstat);
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg);
 
+int count_lines(const char *data, int size);
 int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
-- 
2.27.0

