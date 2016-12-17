Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43BD6203EA
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757495AbcLQO4Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:16 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33768 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757346AbcLQO4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:14 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so18015092wjc.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cpfkqv2ba7NlLkNaRzLZ8tc1xXrGbJuGYxX08KErOwg=;
        b=udsvdL38z64Rf37EWH0tpT6b3s/iy8xT9FwX5WejgrqimP+ACuZcruuc45lm96xsV4
         rHFjiZb+K8TNEX73rX1WPJxvPdOvkEYGcWWuh+65aPkAZ7olw+xdnSClEa8EdOVctkim
         p0aM17gKtIDjLb+30o5DHj0XtWkpo+ET1g10RnVZD8GrBzrzg/wnTfG/nCW1rIguwj3o
         duhB44Kpkp6e9ABAjNKlvUjqg1cnnT4wSXa7xl2ktcWAQ3tW48RHepQfiv704JCp+zrl
         1mBA+/IMs2DiQ/wsU/QBDSo+NHv/g+H5u5j6Er36AW47F3HINIjPi5/JvKBQizl8Nee9
         qQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cpfkqv2ba7NlLkNaRzLZ8tc1xXrGbJuGYxX08KErOwg=;
        b=Cai/GOsIe5pCI81t770THh90ZQoKFwu6alqrVhU7oEL5uLpqlAOIBz/jO8Z4zx6o0W
         9CxSkAOy2E0oBECvhbKUFVySzXCYM+dz7gQ+dQU6la276hCeIA+Bg4znEcoQYhMmsJ80
         O4PfJZvsDwfwg8YbYr7sWUFU/HuEQE5pddQCbIQX7RT5ktICeTVaYa2uNFfsBaszXjlj
         QxCORsTcXO8eZmRjf16lkSk9qIpCHij4tKSdzdO22gEBR+BDyKOpvYulGr9ld5O+jvUC
         tnTBeWfNvx2bJNqMXfvcVM2PsVXN8Fmt505Iy9BL9ORgziB8ks5JNPn6B+zNMndH41bk
         TtVA==
X-Gm-Message-State: AIkVDXKxSfJtyL74MyYrKvuyyeycA78wh00bebuJCoaoCoYlPTAHyuo+8nsYzoCdriLoaw==
X-Received: by 10.194.44.41 with SMTP id b9mr8438451wjm.56.1481986573138;
        Sat, 17 Dec 2016 06:56:13 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:12 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 09/21] config: add git_config_get_max_percent_split_change()
Date:   Sat, 17 Dec 2016 15:55:35 +0100
Message-Id: <20161217145547.11748-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
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
index c126fe475e..e15b421b6f 100644
--- a/cache.h
+++ b/cache.h
@@ -1822,6 +1822,7 @@ extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
+extern int git_config_get_max_percent_split_change(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index c1343bbb3e..3e96c223f5 100644
--- a/config.c
+++ b/config.c
@@ -1719,6 +1719,21 @@ int git_config_get_split_index(void)
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
2.11.0.49.g2414764.dirty

