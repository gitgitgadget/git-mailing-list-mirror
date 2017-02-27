Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5248D1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbdB0SCN (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:13 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35497 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751451AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wr0-f193.google.com with SMTP id q39so11341896wrb.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hHcQG/KMC3PHJ1RhWDJ8ce6waRUWoGz+MjMz9raP1nY=;
        b=bnXHwMGydi2e3egoDvf9qtaZH5A7+da043J+NecNcLhU7vwpDnJvuIYu0kSEDqanm0
         EItHygbrmfYCDB9Z4pJp2FXzicT0QcqvS8qyGE5F3Eu/ABE/jIIb0j3CqJk1dep+cJvo
         mlrTGVTXaGjoyOKAq+xIYwEeTnwdScP+zRhG2IUb9pKiESawNSgHaS11PSTVKThwDSpZ
         0/cGzGPBpiNz+SKt3qpz3fFfpSA2tLh4k/tXh0u6rUxnQZz74dq9mjWG5zC7TaWZww+V
         qM0k2RhoIRc9tWH+vKGUvse4aTJ+hsiEksuhl7PQ6Xwfd/dH/TLJZKZBpSruXtTz3OYc
         yqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hHcQG/KMC3PHJ1RhWDJ8ce6waRUWoGz+MjMz9raP1nY=;
        b=RXq9G5rfA6UpbvM01rfT4WQjJvtX7M9ttYe/Jzc8DFH5f/kNIvH9rmYSGWVRmJs6vO
         rooySUnzMOGYInCBKA89af+nQtzX+C149DBvd8WjeGV5naallSA1LmqXH7usaO8js6TW
         HVy8d29ArJxmrZ5y4KaW39xl3ztFHDPi7Nj3IJQ2KIEHf9ES9zXd6k6nJvqEAGpl2N+v
         Xcj5SbEExqJ38aJ19BxFq2/R2WcQWMgeLul6RlAVxRyHHo7Ojw30NPEdd9XdwGyc0bnq
         qAm9a+ba/c0cPac9BOTuHeciy7Q0X+YDN23pi9+9siRCHpZM3seEc9ZxLNL5mRJSfOG8
         8KYA==
X-Gm-Message-State: AMke39nUqisgRJVSrDbmdlwnmk1j5s5HTZZAK8Bm6q/Az6UzNxoNxMMJ89Rag6dHuufsow==
X-Received: by 10.223.167.71 with SMTP id e7mr16087273wrd.154.1488218450777;
        Mon, 27 Feb 2017 10:00:50 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:49 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 10/22] config: add git_config_get_max_percent_split_change()
Date:   Mon, 27 Feb 2017 19:00:07 +0100
Message-Id: <20170227180019.18666-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new function will be used in a following commit to get the
value of the "splitIndex.maxPercentChange" config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h  |  1 +
 config.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/cache.h b/cache.h
index 014aa7ea11..955e80913e 100644
--- a/cache.h
+++ b/cache.h
@@ -1883,6 +1883,7 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
+extern int git_config_get_max_percent_split_change(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index 2a97696be7..35b6f02960 100644
--- a/config.c
+++ b/config.c
@@ -1746,6 +1746,21 @@ int git_config_get_split_index(void)
 	return -1; /* default value */
 }
 
+int git_config_get_max_percent_split_change(void)
+{
+	int val = -1;
+
+	if (!git_config_get_int("splitindex.maxpercentchange", &val)) {
+		if (0 <= val && val <= 100)
+			return val;
+
+		return error(_("splitIndex.maxPercentChange value '%d' "
+			       "should be between 0 and 100"), val);
+	}
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
-- 
2.12.0.22.g0672473d40

