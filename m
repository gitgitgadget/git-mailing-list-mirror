Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644AFC433E1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CFB2074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9w1+D5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgG1WZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgG1WZL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:25:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2BC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n21so7468111ybf.18
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6OE/uE69yRebrRJPaGprkkwEu88LuiF7HtXoJUEcU5w=;
        b=k9w1+D5r+kVCEIn4FMZCnM/Hn5ca8ce9vxDi5U2VLU29+AQwar4n+ylWo1v/37t2XQ
         nOQMEKEVRwkAm89+PcxNtikID0ZZJxdnghJy5ks0ccV5oSzZT2PXePa1Uy+OhUPuVAP5
         wOE6qHm/Zib/a1VRLUtPTP7opFPnXKgk2LVRw6G40X/PtVlUoj5NQUj4doeH1Iuzv0Z+
         9WPo8bxvvpgxKv4SGQJJEgI60JZ/0bNt2WtiFDiX+vp0u08RSCtiTv9j6v8zsB9CmuYl
         leVEidp/ITDVV6QYs3msZzuoSj+rpWx4IjUq5x+skJwYSXQxnbreimemNvtc+JP8mkcL
         rDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6OE/uE69yRebrRJPaGprkkwEu88LuiF7HtXoJUEcU5w=;
        b=Bwp6D5BxGX6+oGORN/6Q7n/bKod9r/mUh4hAEyy0ohTC87Dmv/N88TD0hTFBMlQXvu
         9oCPUiZlpMsJR9IT/7mW0J9cncp+kGE815W6pirEx5P+oS44R9pN0/1idYgb3GQz/xSb
         RGomk9sPXO7DdCA/hXHAOHg+ENZnmYoUJKmavaEEs8b/Dv009xs7k892/wNb8fYGgKU4
         iMQRqO/aBlXumIY/CzJ3aEugMzWMcztqqDUjXNQcEcPH/Ybsfg3/nw59llKAnkDYbnj/
         O4aOSVVthcCqBfrrORq/IyUo+wkDhs/ATGtdijjo2hi1CPbKSUEgcVOYbZJYOIp6w/e4
         BYUg==
X-Gm-Message-State: AOAM5307xqK88850naNaYmkIKZsezT9Zi2IMSMIpp54PenaT1pj8Tgao
        ocNBuQmln+ccHnoCrvlWfTvlF6WRTS542+U4lDqpgiNp8NGomy++xFmFxGe0cxKmB7jbbZ68VOu
        G3VafevddhzkUH2nM/7PI/Rl7ew/LtC2i1+Ni6owfO2Obogb7mn2k+tDd2K1WaTGiZ8AltnHqiQ
        ==
X-Google-Smtp-Source: ABdhPJw4hwBi9uP+cLl3avIsIZUMZHVo9qg+xtcVCTwzEPJSxSVvnEJSMGwM4/AejzLM7jZ2aKBf7HJB9ZGgd+XKCCI=
X-Received: by 2002:a25:9c06:: with SMTP id c6mr47599723ybo.403.1595975109970;
 Tue, 28 Jul 2020 15:25:09 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:24:53 -0700
In-Reply-To: <20200728222455.3023400-1-emilyshaffer@google.com>
Message-Id: <20200728222455.3023400-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200728222455.3023400-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v3 4/6] hook: add --porcelain to list command
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git hook list --porcelain <hookname>', which prints simply the
commands to be run in the order suggested by the config. This option is
intended for use by user scripts, wrappers, or out-of-process Git
commands which still want to execute hooks. For example, the following
snippet might be added to git-send-email.perl to introduce a
`pre-send-email` hook:

  sub pre_send_email {
    open(my $fh, 'git hook list --porcelain pre-send-email |');
    chomp(my @hooks = <$fh>);
    close($fh);

    foreach $hook (@hooks) {
            system $hook
    }

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    | 13 +++++++++++--
 builtin/hook.c                | 17 +++++++++++++----
 t/t1360-config-based-hooks.sh | 12 ++++++++++++
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index e458586e96..0854035ce2 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,7 +8,7 @@ git-hook - Manage configured hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' list <hook-name>
+'git hook' list [--porcelain] <hook-name>
 
 DESCRIPTION
 -----------
@@ -43,11 +43,20 @@ Local config
 COMMANDS
 --------
 
-list <hook-name>::
+list [--porcelain] <hook-name>::
 
 List the hooks which have been configured for <hook-name>. Hooks appear
 in the order they should be run, and note the config scope where the relevant
 `hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
++
+If `--porcelain` is specified, instead print the commands alone, separated by
+newlines, for easy parsing by a script.
+
+OPTIONS
+-------
+--porcelain::
+	With `list`, print the commands in the order they should be run,
+	separated by newlines, for easy parsing by a script.
 
 GIT
 ---
diff --git a/builtin/hook.c b/builtin/hook.c
index a0759a4c26..0d92124ca6 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -16,8 +16,11 @@ static int list(int argc, const char **argv, const char *prefix)
 	struct list_head *head, *pos;
 	struct hook *item;
 	struct strbuf hookname = STRBUF_INIT;
+	int porcelain = 0;
 
 	struct option list_options[] = {
+		OPT_BOOL(0, "porcelain", &porcelain,
+			 "format for execution by a script"),
 		OPT_END(),
 	};
 
@@ -29,6 +32,8 @@ static int list(int argc, const char **argv, const char *prefix)
 			      builtin_hook_usage, list_options);
 	}
 
+
+
 	strbuf_addstr(&hookname, argv[0]);
 
 	head = hook_list(&hookname);
@@ -41,10 +46,14 @@ static int list(int argc, const char **argv, const char *prefix)
 
 	list_for_each(pos, head) {
 		item = list_entry(pos, struct hook, list);
-		if (item)
-			printf("%s:\t%s\n",
-			       config_scope_name(item->origin),
-			       item->command.buf);
+		if (item) {
+			if (porcelain)
+				printf("%s\n", item->command.buf);
+			else
+				printf("%s:\t%s\n",
+				       config_scope_name(item->origin),
+				       item->command.buf);
+		}
 	}
 
 	clear_hook_list();
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 46d1ed354a..ebf8f38d68 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -72,4 +72,16 @@ test_expect_success 'git hook list reorders on duplicate commands' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list --porcelain prints just the command' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	$ROOT/path/def
+	$ROOT/path/ghi
+	EOF
+
+	git hook list --porcelain pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

