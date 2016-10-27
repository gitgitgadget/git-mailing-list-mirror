Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2062C20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943031AbcJ0WjH (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:39:07 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35813 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942966AbcJ0WjF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:39:05 -0400
Received: by mail-pf0-f171.google.com with SMTP id s8so25078929pfj.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c/Tmg80hDvEKXzsqzU8Lv8VJtix0ae/KaRGXbSxpNCE=;
        b=EP8HupwHKNKTXnHkdpFCL6ic3T+Rl32VuCM0oXpylRIzg6C26UtAO0brE8b5Wlvz0p
         BYzupKrbXJN5+IiJy/aLcZdx1dR4ILqpASawexgFqjko3kC4u/qVKLu3BxMLmILdL2Vd
         AzN3AwvmU+BiyKutHFWj8EUokK2we+JLaUUCheHDsBRqPIbh0TpYtFF1NL+BNCmxc8ro
         5d+vVdRf3cQHpZl5B9AJ7K/DbkkPS9x1LqIekQnEuVA+bUKMf2Ns9L+uEeCQ3kTYuhSn
         8CseBu/KTgwZKxpA9bWThEFqjnuu79Uhuos34TvsbExVLyUSFk6RuLtM9WsEs97YEFux
         NUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c/Tmg80hDvEKXzsqzU8Lv8VJtix0ae/KaRGXbSxpNCE=;
        b=Q1EaAIEKAzneRvVvaGhLttTqEGfGHH1JWTTlxS34qXs9sBmehIt8MWGmXm+PBrk16O
         XqWkDWjF38TamgEBUQVkXU5yscQsymGCDgsG3FDZ/KNHLGrd4fA7Gu1csQEovM/eoeeU
         Ko58JcbaRjEfCE9S5+2k8yjUGJ85gq4pDi++zC+0DiNRGns3g5oFDEq/jJRkL2sJcQ6I
         gi/+BA0hkilpLWl7HWCjYbicxuR239SxtKUDID2shVz/k4oX/7HV8VbFp8OXW7Xp+AUs
         +b1ldvC4KwJ+6AXChmec2dFwMwa57KibgNfbw11f+Bbzs7GR3xlYsIAlmUBqvUOAxgWE
         QiNw==
X-Gm-Message-State: ABUngvfQhyeRV8HZNzfW16r0BKdyOhuBC/NS0m1eEEug07v4a/2mqdX+cnvqa4t9SKKfyoS2
X-Received: by 10.98.102.221 with SMTP id s90mr18692492pfj.146.1477607944256;
        Thu, 27 Oct 2016 15:39:04 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.37.191])
        by smtp.gmail.com with ESMTPSA id d2sm8129400pfd.38.2016.10.27.15.39.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 27 Oct 2016 15:39:03 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/5] submodules: add helper functions to determine presence of submodules
Date:   Thu, 27 Oct 2016 15:38:30 -0700
Message-Id: <20161027223834.35312-2-bmwill@google.com>
X-Mailer: git-send-email 2.10.1.613.g6021889
In-Reply-To: <20161027223834.35312-1-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add two helper functions to submodules.c.
`is_submodule_initialized()` checks if a submodule has been initialized
at a given path and `is_submodule_checked_out()` check if a submodule
has been checked out at a given path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 39 +++++++++++++++++++++++++++++++++++++++
 submodule.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/submodule.c b/submodule.c
index 6f7d883de..029b24440 100644
--- a/submodule.c
+++ b/submodule.c
@@ -198,6 +198,45 @@ void gitmodules_config(void)
 	}
 }
 
+/*
+ * Determine if a submodule has been initialized at a given 'path'
+ */
+int is_submodule_initialized(const char *path)
+{
+	int ret = 0;
+	const struct submodule *module = NULL;
+
+	module = submodule_from_path(null_sha1, path);
+
+	if (module) {
+		struct strbuf buf = STRBUF_INIT;
+		char *submodule_url = NULL;
+
+		strbuf_addf(&buf, "submodule.%s.url",module->name);
+		ret = !git_config_get_string(buf.buf, &submodule_url);
+
+		free(submodule_url);
+		strbuf_release(&buf);
+	}
+
+	return ret;
+}
+
+/*
+ * Determine if a submodule has been checked out at a given 'path'
+ */
+int is_submodule_checked_out(const char *path)
+{
+	int ret = 0;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s/.git", path);
+	ret = file_exists(buf.buf);
+
+	strbuf_release(&buf);
+	return ret;
+}
+
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst)
 {
diff --git a/submodule.h b/submodule.h
index d9e197a94..bd039ca98 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern int is_submodule_initialized(const char *path);
+extern int is_submodule_checked_out(const char *path);
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.10.1.613.g6021889

