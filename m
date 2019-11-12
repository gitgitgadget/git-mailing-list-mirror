Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF33B1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKLKij (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54536 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfKLKih (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id z26so2517968wmi.4
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsQZugQmzx96C464Lk8l0tqamlHfE4WUnRulbZfg6J0=;
        b=j8s41WnLpYXx5TXDUHXlJdbf3fVs+gowL/3z2RMyxKkW3szHXc6K06bVUjlmo220y1
         69wBajBT8A+Rwl9kxHGe6uxvIhJ/lHB94CWbIJBkpIs96/rLJAQ+qYFw1WWTF9SSKBxW
         4Gy2NzAJ3pcxHN/PA9LIrAg1zCuxF50oJcWSxYn4ADPU6PcgXRQwOCl2QmjdSy13OF7c
         ggH2NzFCoAW//kRuPbyfPTeETVsXxFx9MQfCPhZyMJbx9frlGp4MlixR03tz19LuBqHy
         RJ/RW1J6tzUp0l40ct8s0X1hhU4jkzAkOFscNitr0ONhZOnjNotWyRnqInTBHV2zhlTn
         B+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsQZugQmzx96C464Lk8l0tqamlHfE4WUnRulbZfg6J0=;
        b=QNcjp3RjZMDQX4HG29ACHJthbAHI8vJB+llkkCTbBBugO5KsBc0aVSTHyvudELfgKL
         orw9SFz9ZhBiOTkU/7sRepOR/KPDz4UEyH2P02lUjrD4tWxB08V+8kzEnswnnSgDDeh4
         6hfPvHSqijs1QQWhrdtGevbk87yTBwk7m4PMHhbGv/jW7SA5UzNreDX78kq7/lss0xUA
         d2M6YvhzTEyWa7/+qzYWA+ukAPRDj/ZdhlHq+C3uYw1UuwW38JrvZwyylh72DDUZ/Typ
         Bz+BBA8OnfUqSyDrLVIEnC7yaoq49mlHTRxAAgmbVs+iYtRUSwPZrEJbFttgvLQYXinT
         pQgg==
X-Gm-Message-State: APjAAAVXUEjGEWA7w8/+gwcBQvVEpZ/37bAlmJn/FjDvSCBGcaKIKh7E
        r1lGl6Ysd5UkFqAyjfWuY/0=
X-Google-Smtp-Source: APXvYqzSSLcE7HK03ePzGsKD/oSI5UoXfXMPT3ZVKwFEtVnZnrTwGf0gujJigKSsJoXqeDA1iThlQg==
X-Received: by 2002:a7b:cf32:: with SMTP id m18mr3339880wmg.166.1573555115526;
        Tue, 12 Nov 2019 02:38:35 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:34 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 05/13] name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
Date:   Tue, 12 Nov 2019 11:38:13 +0100
Message-Id: <20191112103821.30265-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index e40f51c2b4..7e003c2702 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -102,7 +102,7 @@ static void name_rev(struct commit *commit,
 	}
 
 	if (name == NULL) {
-		name = xmalloc(sizeof(rev_name));
+		name = xmalloc(sizeof(*name));
 		set_commit_rev_name(commit, name);
 		goto copy_data;
 	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-- 
2.24.0.388.gde53c094ea

