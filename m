Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE03520987
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756337AbcJWJ1Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34957 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754826AbcJWJ1V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so5222928wma.2
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uhcb7dPn2oMkdoMyVb522SI7lGivGAld6piRhtBW03E=;
        b=ZrPfHzAiRr2iAcRKu79W8Ll2AbFc+uAjWrKOAhYaEw4fg3hbn7ob1R2uFkUE6G1mJA
         mjIsW54zXcRzNxXh3QOVD4xIugLuW1stNDbHG4c1o0XP2P0ASOrBmbYCY23Fsrg/oZKF
         7UxJKBl/Q73/bXTzIA0IqewaSFhYRpywmexBSPVD8yQo9CgBYhuaWi/2OqLYzBetv4J8
         b8xWwCbmCYNW1nPmhLICqC9lUo7Y4iG0nuj+/OTxuA/w6AgFVr+QUY6wVHTjWJXk1qv1
         tYmP0Mu1ViqF69cUj9fKaJSl6hLKoBBaQ9hkgQPgNnuaoL3AmKgk90UdCR0S0oXCdq18
         Jr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uhcb7dPn2oMkdoMyVb522SI7lGivGAld6piRhtBW03E=;
        b=FmVSdvR4MInI/iH1ZUxM41/JTc0ttKSQ80rk4MFGKsKszhikYtQDT2wSYpwFBWzC17
         Dk84XyTYeg5UsXFzz2sWB3RUCtNf3MZ9/zesAsB0mRpYX6cAIjacc5GCsZ6iHYRHWO5B
         RtTUzPnWsSjNpxxPoV2u2mdpSK8jvKoEHhASwwayInQ7mz8vD/Vj/kKuDp25UkL4mZns
         nit9nCiDJi86x2lJMmYxR6DEXPatKzWWjVD8Q2B2I6bJIqIEMmfDMYXTVDjvOq1OxFVm
         y8ZAlpFODHBxjLTTxFFPSmvKhE/SsApLzknVfZ0l5GRkqrsCf0wVYNr8W2Dxousi3Qpf
         vABg==
X-Gm-Message-State: AA6/9RmpPe2uTvgxslPCwIHLk2mjSGZUM8TweqFUgYAM2HJ8SZdPYbeGcn7kM5HPheWCng==
X-Received: by 10.28.67.68 with SMTP id q65mr10669295wma.119.1477214840111;
        Sun, 23 Oct 2016 02:27:20 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:19 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 09/19] config: add git_config_get_max_percent_split_change()
Date:   Sun, 23 Oct 2016 11:26:38 +0200
Message-Id: <20161023092648.12086-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new function will be used in a following commit to get the
value of the "splitIndex.maxPercentChange" config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h  |  1 +
 config.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/cache.h b/cache.h
index 394da60..faceceb 100644
--- a/cache.h
+++ b/cache.h
@@ -1810,6 +1810,7 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
+extern int git_config_get_max_percent_split_change(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index 036e29b..5580f56 100644
--- a/config.c
+++ b/config.c
@@ -1719,6 +1719,22 @@ int git_config_get_split_index(void)
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
+		error("splitindex.maxpercentchange value '%d' "
+		      "should be between 0 and 100", val);
+		return -1;
+	}
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
-- 
2.10.1.462.g7e1e03a

