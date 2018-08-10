Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0142A1F428
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbeHJTXV (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46530 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeHJTXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so8845221wrw.13
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nspjmAMLETwXpgEGrsuhvZqAJjQ6FETd/T+UcbSx/bA=;
        b=TgsgxQQBby4VCRhHk/CdJNWtQ8oXu9q4rSQ1GQD4sX9JhCaPSIOS3PKCllBy5xv6ed
         6z82qZwzOcOuHvzlHqniQSS4ql2TjVQKL5EWuxpE4KWzsGaCz9QlibVAbfRk1UiOgan+
         Ow2ZGwqvIdLFLCDQDvOUvpSRxPIeFJUwuV8KkI/xTuwV/t5tX8ecTVwTvYNVfb8VIy0Q
         DPIcizRII8kH9zrt/ZeUcrp7fSaaomOCb0TmuqKWn6BHflmIiN3BGGb/QzdP0b9Zltpb
         sm6mEODfsYxj0qDewYqyZmLpQZ/AntT1JutCsaRUHAUEvd+HAnBjTx4oQDdmW+0ACxun
         q+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nspjmAMLETwXpgEGrsuhvZqAJjQ6FETd/T+UcbSx/bA=;
        b=fQcnHHtMnZymQtLR3svX6SOW5/rwXoAwK0sYiLF34LZtcjv6CsIeydFzKKGXH//RW5
         yWKN/MQ/ttScmIDV6CXuUUoV6/zrPBNxUd/WK+xSMez/UhTKnEaB3ZTOp+nQoL+jiVdL
         qfBsVfynfV+nbY6noGvBfFwjdm/o5l5JREuYJvIw1oJzrW2ovFmSSX+CyRJBaTrJAmog
         EuMGNVe/nT4bxLwpAcU0gJO+MuSsMPU9cw06t8MjkBhWJxek537JkE4LoTXclz1FEkfr
         oHmprhN0FgxitrC2ROFSNa/fe1eQvoUlMG4fYOPZxElMgL+239QteGgma3uDPAA8au0U
         XHmQ==
X-Gm-Message-State: AOUpUlEfXF+GA8CyEPhieGWok5rc98XIJ+5vfYrWA1fDz4BcmlG6l0TF
        cRkJrO2kktCF9i6kbhi5tEmcyUFz
X-Google-Smtp-Source: AA+uWPzrlV/pVz2tz/6etaHnPsGJo0nM8z7cOcz8E0Z67BZ1aEFfUmFUdZZsQ7yLoPsn0sV99Ar10g==
X-Received: by 2002:adf:e14a:: with SMTP id f10-v6mr4558513wri.42.1533919960830;
        Fri, 10 Aug 2018 09:52:40 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:39 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 16/20] rebase -i: rewrite init_basic_state() in C
Date:   Fri, 10 Aug 2018 18:51:43 +0200
Message-Id: <20180810165147.4779-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites init_basic_state() from shell to C.  The call to
write_basic_state() in cmd_rebase__helper() is replaced by a call to the
new function.

The shell version is then stripped from git-rebase--interactive.sh.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v5.

 builtin/rebase--helper.c   | 23 ++++++++++++++++++++++-
 git-rebase--interactive.sh |  9 ---------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 63c5086e42..f8128037d3 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -5,10 +5,13 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "argv-array.h"
+#include "refs.h"
 #include "rerere.h"
 #include "alias.h"
 
+static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
+static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
@@ -44,6 +47,24 @@ static int get_revision_ranges(const char *upstream, const char *onto,
 	return 0;
 }
 
+static int init_basic_state(struct replay_opts *opts, const char *head_name,
+			    const char *onto, const char *orig_head)
+{
+	FILE *interactive;
+
+	if (!is_directory(path_state_dir()) && mkdir_in_gitdir(path_state_dir()))
+		return error_errno(_("could not create temporary %s"), path_state_dir());
+
+	delete_reflog("REBASE_HEAD");
+
+	interactive = fopen(path_interactive(), "w");
+	if (!interactive)
+		return error_errno(_("could not mark as interactive"));
+	fclose(interactive);
+
+	return write_basic_state(opts, head_name, onto, orig_head);
+}
+
 static const char * const builtin_rebase_helper_usage[] = {
 	N_("git rebase--helper [<options>]"),
 	NULL
@@ -198,7 +219,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		if (ret)
 			return ret;
 
-		return !!write_basic_state(&opts, head_name, onto, head_hash);
+		return !!init_basic_state(&opts, head_name, onto, head_hash);
 	}
 
 	usage_with_options(builtin_rebase_helper_usage, options);
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6367da66e2..761be95ed1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -51,14 +51,6 @@ initiate_action () {
 	esac
 }
 
-init_basic_state () {
-	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
-	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
-	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
-
-	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
-}
-
 git_rebase__interactive () {
 	initiate_action "$action"
 	ret=$?
@@ -67,7 +59,6 @@ git_rebase__interactive () {
 	fi
 
 	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
-	init_basic_state
 
 	git rebase--helper --init-basic-state ${upstream:+--upstream "$upstream"} \
 		${onto:+--onto "$onto"} ${head_name:+--head-name "$head_name"} \
-- 
2.18.0

