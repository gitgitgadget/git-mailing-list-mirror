Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC11520951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdCNVq5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:46:57 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36024 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdCNVqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:46:53 -0400
Received: by mail-pg0-f42.google.com with SMTP id g2so79008151pge.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oESNxshky/2hB2RwQWILlVeOSE1QSewr3/tnR4m3E/g=;
        b=ege8BLCaEbJgTDCeNJNUHNLBZtga4GT24/VGtaEYZzKH+pbYVeqVkJ6Fcb7Zp/9cF6
         0Jbx7ccbuasBu9hfVfTPokZhWh0DqUjIeWsu3SP8ucYF70a4DEHoXPo7F0a7GxZKOC4g
         jbpENRIsUrnskGR0PA8r/gNhY5xhY3dyEsubC/n2MOGzR9XiRIzq0MzCw4oDkhy5qpz5
         UwLMuJQe27dwBNtnDIjiD6AGKd4sJE3c/xy46cptt5U2Z+px8WjVF9DZY3jp7R+DCD7d
         qlns+oOR5B8XFTQRrx4DuotD/J0mUgEbAcmUdxUEfFpkEnS1ibxxirwoJnrhiC83aQz0
         Fj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oESNxshky/2hB2RwQWILlVeOSE1QSewr3/tnR4m3E/g=;
        b=BkvZMhZyiBAGqtVyzZdtw82mMJ90pTfvttrQyT9cSTiZYO5f+tSvaJGW+v4Qqymmj9
         031rqJbr7NhBRO/r1NZMIFuYSXk5jHsmMkMWXhYmyQRuevL4e82lQJOviSnW8AaphMpQ
         gLDiHxo9XFImfNPNRhS8G988qWbmPBulONr192/sjaWF2bGQe2tzQO9js6TcD4NY5/iQ
         6ElTQBZSz6kuWg+WvgZZkG083fpcg3Fr6DTr4iX4YWQeApXuF2+ANUgJ0OZtrDd31S7d
         Ie6OYVOngCWqIhkmYVolgiqyT2bZHIg6FlavLrVdl55FiC/QLhw9ijvkltqVb0YIYx0w
         x3tA==
X-Gm-Message-State: AMke39mZ4o2pK+90P2LVTGNik4vqlLN9BfnQkRq+8e1aOz27daHqUeycXj1h+xQuhjYSoUqF
X-Received: by 10.99.241.83 with SMTP id o19mr45446305pgk.81.1489528012486;
        Tue, 14 Mar 2017 14:46:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id m6sm40258303pfm.22.2017.03.14.14.46.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:46:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com,
        Valery Tolstov <me@vtolstov.org>
Subject: [PATCH 02/19] submodule--helper.c: remove duplicate code
Date:   Tue, 14 Mar 2017 14:46:25 -0700
Message-Id: <20170314214642.7701-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Valery Tolstov <me@vtolstov.org>

Remove code fragment from module_clone that duplicates functionality
of connect_work_tree_and_git_dir in dir.c

Signed-off-by: Valery Tolstov <me@vtolstov.org>
Reviewed-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 899dc334e3..86bafe1660 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -579,9 +579,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *name = NULL, *url = NULL, *depth = NULL;
 	int quiet = 0;
 	int progress = 0;
-	FILE *submodule_dot_git;
 	char *p, *path = NULL, *sm_gitdir;
-	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	char *sm_alternate = NULL, *error_strategy = NULL;
@@ -653,27 +651,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&sb);
 	}
 
-	/* Write a .git file in the submodule to redirect to the superproject. */
-	strbuf_addf(&sb, "%s/.git", path);
-	if (safe_create_leading_directories_const(sb.buf) < 0)
-		die(_("could not create leading directories of '%s'"), sb.buf);
-	submodule_dot_git = fopen(sb.buf, "w");
-	if (!submodule_dot_git)
-		die_errno(_("cannot open file '%s'"), sb.buf);
-
-	fprintf_or_die(submodule_dot_git, "gitdir: %s\n",
-		       relative_path(sm_gitdir, path, &rel_path));
-	if (fclose(submodule_dot_git))
-		die(_("could not close file %s"), sb.buf);
-	strbuf_reset(&sb);
-	strbuf_reset(&rel_path);
+	/* Connect module worktree and git dir */
+	connect_work_tree_and_git_dir(path, sm_gitdir);
 
-	/* Redirect the worktree of the submodule in the superproject's config */
 	p = git_pathdup_submodule(path, "config");
 	if (!p)
 		die(_("could not get submodule directory for '%s'"), path);
-	git_config_set_in_file(p, "core.worktree",
-			       relative_path(path, sm_gitdir, &rel_path));
 
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
 	git_config_get_string("submodule.alternateLocation", &sm_alternate);
@@ -689,7 +672,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	free(error_strategy);
 
 	strbuf_release(&sb);
-	strbuf_release(&rel_path);
 	free(sm_gitdir);
 	free(path);
 	free(p);
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty

