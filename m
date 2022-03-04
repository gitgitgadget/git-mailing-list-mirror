Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A298BC433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbiCDSdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbiCDSdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05C1BC9D
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bk29so13943995wrb.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyfhvIom/XBiKTdFqJJiAKkF9UOyG71GIMIawXuvj5A=;
        b=CUy/4GzR0A34jS2kJZ6RkZ/mddD9qtsmK2hdwcGIg0KHUa4jJIUMJCeN8Vzc0t8kj4
         IONOqDwRdVFZe7VAo0k43BwM1p1qIyYCk7upH9ivjzYHFzeGcAvvPRFvG9xmPdtXmnud
         nU32N/Byr294qRKfBh8/U8CavScB6GowsOeaYIEK1MGSprFgLEhqcH7Zmh6/UPDRhph2
         bE/zCpDHQ0esPpPK3uYTILM+znSbfJxaTrZyCvCSMhxPtLoNMF4DZ5XG/O4F6DK/Rl9l
         b1HJjkzMqENPt5wFgbY5CrmdV4LTcJi6fgLDL/HJGngf1W28149xCf9Zz64qwkUAZ2aQ
         QGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyfhvIom/XBiKTdFqJJiAKkF9UOyG71GIMIawXuvj5A=;
        b=wxjV7k/7BURtuWzkWtCHzxqJFaFXnBIP/mbmePyMsgWop9U77WtHAwMRxadSESHJM4
         3wte9YqkkBNNCrKQIdP0o6b9pluujOHm/Qu8Iw4tEeBwU/O+L+BnEHd0VUa/+o0HaYoa
         9g4Pw0MITqFknhKHVAu8JCwHmqDbUeuGN2bVtZJ+Vj1rmHcf1qrCDwdA17Y4LWsIqZhl
         lOk8wRargd0cVmmUf3bILWcyQ+5eURXnHa5CfDl3SWUz6gola7rx7/XpyezTdqgldB87
         jmdkfzPEKCrxdUxU0pJ078OXN4D4e51d4TO1L+KoKvdIYpMTAyVIGUraIAGVyeIu/l8G
         ybaA==
X-Gm-Message-State: AOAM530zlhGyNhj6k9evgHtzv3lxpyw7P2RyxbRuxGRwsRSkPQKVeNBq
        s1iw5baAMXmLuBYl/MATcmLyxXbtIIp9fw==
X-Google-Smtp-Source: ABdhPJymD7MBq5IBntGOVqMm8U7IxJItl6szHOOoqSWKdg5q+cLvXX+0+Fj90dIUsLKNh9+JgPoEEw==
X-Received: by 2002:adf:eb45:0:b0:1ef:6070:7641 with SMTP id u5-20020adfeb45000000b001ef60707641mr16056wrn.301.1646418744108;
        Fri, 04 Mar 2022 10:32:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/14] urlmatch.c: add and use a *_release() function
Date:   Fri,  4 Mar 2022 19:32:07 +0100
Message-Id: <patch-v2-04.14-d51f6ae0963-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plug a memory leak in credential_apply_config() by adding and using a
new urlmatch_config_release() function. This just does a
string_list_clear() on the "vars" member.

This finished up work on normalizing the init/free pattern in this
API, started in 73ee449bbf2 (urlmatch.[ch]: add and use
URLMATCH_CONFIG_INIT, 2021-10-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/config.c | 2 +-
 credential.c     | 1 +
 urlmatch.c       | 5 +++++
 urlmatch.h       | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 542d8d02b2b..ebec61868be 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -612,7 +612,7 @@ static int get_urlmatch(const char *var, const char *url)
 
 		strbuf_release(&matched->value);
 	}
-	string_list_clear(&config.vars, 1);
+	urlmatch_config_release(&config);
 	string_list_clear(&values, 1);
 	free(config.url.url);
 
diff --git a/credential.c b/credential.c
index e7240f3f636..f6389a50684 100644
--- a/credential.c
+++ b/credential.c
@@ -130,6 +130,7 @@ static void credential_apply_config(struct credential *c)
 	git_config(urlmatch_config_entry, &config);
 	string_list_clear(&config.vars, 1);
 	free(normalized_url);
+	urlmatch_config_release(&config);
 	strbuf_release(&url);
 
 	c->configured = 1;
diff --git a/urlmatch.c b/urlmatch.c
index 03ad3f30a9c..b615adc923a 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -611,3 +611,8 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 	strbuf_release(&synthkey);
 	return retval;
 }
+
+void urlmatch_config_release(struct urlmatch_config *config)
+{
+	string_list_clear(&config->vars, 1);
+}
diff --git a/urlmatch.h b/urlmatch.h
index 34a3ba6d197..9f40b00bfb8 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -71,5 +71,6 @@ struct urlmatch_config {
 }
 
 int urlmatch_config_entry(const char *var, const char *value, void *cb);
+void urlmatch_config_release(struct urlmatch_config *config);
 
 #endif /* URL_MATCH_H */
-- 
2.35.1.1248.gb68c9165ad8

