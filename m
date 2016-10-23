Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1AA620229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756402AbcJWJ1g (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32928 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756353AbcJWJ12 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id d128so5249187wmf.0
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mEQaCzmCF/G6FDylIbD2PbUytwGjndLwuixw2u9YtP0=;
        b=G97y8JOUrT7sxZ44S+hnZiI5peE4BpfNBni7P/58EJBPBqvZOFKsDSGEUBP648RYCD
         e29K/dn22HFckVmv/IQaKkfO8shgF9qA2bax/E4Fdc5J1eEu5Xfg8c5Bb6qnPa8SnNaW
         BUh8jL8IsZU2fVeWzqn75Iz8++HkLVX0vAXmD8OvVg8zXGF8AGLemnkaxtvh5dyavN/k
         nL3VIm6MK2+w4q4Qx7vX1/Wj7ZYo6gIZDzYh/ImUEkAwecMBhLIISmNotMZFV7MLX6qf
         m9yjL9yzNjfwTrcEZDdzx1YyjEz6YigGclsWlAATT9JnpaRarhZcWBJTE6qcvKgZlKOC
         McHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mEQaCzmCF/G6FDylIbD2PbUytwGjndLwuixw2u9YtP0=;
        b=Qp7VJke8M6bdu4sZ5LmIP08K8rCG785pVKUQKQBkg020zs5nmfw7btkMgsuZ68BdVe
         HuyRS5vtoei6F/zhEFsZhBZ/wrj+YkqK0mzum331iuraaYLO6nT1G09K0lsn6OwYfdiJ
         JLoV0ENK0LMtGL4DQjjQVwEVWoLe2S2bdr1vWdQ+Ad+7g4BR/5fsaOZyXyPasBf6/rXq
         C81zOKSP4DWM0ANhK6vjAUvwF7AoxdSMK2V16x+vJ5bddYs3FzmgmWcw9zQlkuV+rGW3
         OU8X6+8XzYFzZ44kIna7KS70GHNzsVxBHr3qx9uzH9sIhqHA9qVtt7yROvEa0Tr9Ne0B
         qqlQ==
X-Gm-Message-State: ABUngvdPSqxMF+Bd2eJ66rCHNMglcwwu2EVdjYjQWhxd/FgPK6Jsx6DQkVl/lshvndorQw==
X-Received: by 10.194.190.233 with SMTP id gt9mr7409538wjc.46.1477214846864;
        Sun, 23 Oct 2016 02:27:26 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:26 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 15/19] config: add git_config_get_date_string() from gc.c
Date:   Sun, 23 Oct 2016 11:26:44 +0200
Message-Id: <20161023092648.12086-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used in a following commit to get the expiration
time of the shared index files from the config, and it is generic
enough to be put in "config.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/gc.c | 15 ++-------------
 cache.h      |  1 +
 config.c     | 13 +++++++++++++
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 069950d..c1e9602 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -62,17 +62,6 @@ static void report_pack_garbage(unsigned seen_bits, const char *path)
 		string_list_append(&pack_garbage, path);
 }
 
-static void git_config_date_string(const char *key, const char **output)
-{
-	if (git_config_get_string_const(key, output))
-		return;
-	if (strcmp(*output, "now")) {
-		unsigned long now = approxidate("now");
-		if (approxidate(*output) >= now)
-			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
-	}
-}
-
 static void process_log_file(void)
 {
 	struct stat st;
@@ -111,8 +100,8 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
-	git_config_date_string("gc.pruneexpire", &prune_expire);
-	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
+	git_config_get_date_string("gc.pruneexpire", &prune_expire);
+	git_config_get_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config(git_default_config, NULL);
 }
 
diff --git a/cache.h b/cache.h
index a625b47..bcfc0f1 100644
--- a/cache.h
+++ b/cache.h
@@ -1811,6 +1811,7 @@ extern int git_config_get_bool(const char *key, int *dest);
 extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
+extern int git_config_get_date_string(const char *key, const char **output);
 extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
diff --git a/config.c b/config.c
index 5580f56..f88c61b 100644
--- a/config.c
+++ b/config.c
@@ -1685,6 +1685,19 @@ int git_config_get_pathname(const char *key, const char **dest)
 	return ret;
 }
 
+int git_config_get_date_string(const char *key, const char **output)
+{
+	int ret = git_config_get_string_const(key, output);
+	if (ret)
+		return ret;
+	if (strcmp(*output, "now")) {
+		unsigned long now = approxidate("now");
+		if (approxidate(*output) >= now)
+			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
+	}
+	return ret;
+}
+
 int git_config_get_untracked_cache(void)
 {
 	int val = -1;
-- 
2.10.1.462.g7e1e03a

