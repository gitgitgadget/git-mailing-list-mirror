Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5951F453
	for <e@80x24.org>; Tue, 23 Oct 2018 01:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeJWJe6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 05:34:58 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45643 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 05:34:58 -0400
Received: by mail-pl1-f201.google.com with SMTP id s24-v6so31578216plp.12
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 18:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nlm7IvrfwvTxC93LKY/RBTcXyCdUHuM4hwiLZpGMzzs=;
        b=UO7B7wNcsApPLuv4YcKtEDXZo6KOrBXPZ18tioo4DfRh4br3/tB0RxOwfsWMfutcH1
         b0OQ2vhmXQvq+SIiRxiNe2RsHxQJ2piDMLurZyzlcTomjZFV1nU+SmUUSp7NpsY05GfP
         azietf+7ardv+HMOIgU9Duft6g5F1rX/wmZb2sOa8+o16hh8swJfY/N6viKubB8F+U0c
         edM5cAoAASrkqrd6C2xIIwjh33YbdVar6UErdMqeOv3mYzNtLVTko1Wm9gFgOK0Iuqir
         qcBkR4C3a90OgnGgxyfkH8LhS5nNhbc/li6k87W/0ZCHCbntx/5CuToQ5nYK+zH27aGP
         Mh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nlm7IvrfwvTxC93LKY/RBTcXyCdUHuM4hwiLZpGMzzs=;
        b=jv6nGWNgraIASIqIK2nmzcJBaXzxnQwXaWU4y6+AVomuDrGa4zpc+9kad8vUwUyxYh
         9mPAc0L1vYzj1cGLpgz7K397xaLMb/KWWhJxEvV2BWw6YnWKR07rL/TRLmoRmyzwFxhT
         9wsMwjbNTPNszTlx55RF9CXmKAuYHEqkoKbpHjiLt7rWeXfSLicCIZIgJhZV5VfD08Fu
         Fi41Q9ZPvql1KiB5NZADrXdwv0QbYDhK3CeIjZgs5tcwbWoXaDCJlYkW3DFG41slTqiB
         gUCMEw97/4La4D8FPDTfdCccFnk+wwp8+girO2rYNssyLCJGiPeu5AOIMBT4TTcZL0sE
         u4Qw==
X-Gm-Message-State: ABuFfoiOlOQ9eu9t9o62DyR5yWxPCH+erBEweZ7jJpwHaE9a+1i86tgh
        1tlc15gIhi5RLQbTKmKYJhw2s2RdrsV5quqm8VCC98L1dedes2b1iKt1cxHaTKsezMM7PlxHLq9
        winEqZigKJDjugbm+yRWBAKw2g18IHJKBMge2INMSipPHxS1YBa+PwVVUbH0=
X-Google-Smtp-Source: ACcGV61j6P1SYjnLlbBOFTeOV57rfJmW8PmZO7bSs/tOYnTTCU3u0U+VS2qQhCN4p3aB73y0Jdk5MLAzAhhl
X-Received: by 2002:a62:998d:: with SMTP id t13-v6mr24855556pfk.19.1540257238432;
 Mon, 22 Oct 2018 18:13:58 -0700 (PDT)
Date:   Mon, 22 Oct 2018 18:13:42 -0700
In-Reply-To: <cover.1540256910.git.matvore@google.com>
Message-Id: <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1540256910.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC 2/2] exclude-promisor-objects: declare when option is allowed
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, gitster@pobox.com,
        pclouds@gmail.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --exclude-promisor-objects option causes some funny behavior in at
least two commands: log and blame. It causes a BUG crash:

	$ git log --exclude-promisor-objects
	BUG: revision.c:2143: exclude_promisor_objects can only be used
	when fetch_if_missing is 0
	Aborted
	[134]

Fix this such that the option is treated like any other unknown option.
The commands that must support it are limited, so declare in those
commands that the flag is supported. In particular:

	pack-objects
	prune
	rev-list

The commands were found by searching for logic which parses
--exclude-promisor-objects outside of revision.c. Extra logic outside of
revision.c is needed because fetch_if_missing must be turned on before
revision.c sees the option or it will BUG-crash. The above list is
supported by the fact that no other command is introspectively invoked
by another command passing --exclude-promisor-object.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 builtin/pack-objects.c | 1 +
 builtin/prune.c        | 1 +
 builtin/rev-list.c     | 1 +
 revision.c             | 3 ++-
 revision.h             | 1 +
 t/t4202-log.sh         | 4 ++++
 t/t8002-blame.sh       | 4 ++++
 7 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b059b86aee..c409fa25d6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3108,6 +3108,7 @@ static void get_object_list(int ac, const char **av)
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
+	revs.allow_exclude_promisor_objects_opt = 1;
 	setup_revisions(ac, av, &revs, NULL);
 
 	/* make sure shallows are read */
diff --git a/builtin/prune.c b/builtin/prune.c
index 41230f8215..11284d0bf3 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -120,6 +120,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	read_replace_refs = 0;
 	ref_paranoia = 1;
+	revs.allow_exclude_promisor_objects_opt = 1;
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5064d08e1b..2880ed37e3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -374,6 +374,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
+	revs.allow_exclude_promisor_objects_opt = 1;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 	revs.do_not_die_on_missing_tree = 1;
 
diff --git a/revision.c b/revision.c
index a1ddb9e11c..28fb2a70cd 100644
--- a/revision.c
+++ b/revision.c
@@ -2138,7 +2138,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
-	} else if (!strcmp(arg, "--exclude-promisor-objects")) {
+	} else if (revs->allow_exclude_promisor_objects_opt &&
+		   !strcmp(arg, "--exclude-promisor-objects")) {
 		if (fetch_if_missing)
 			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
 		revs->exclude_promisor_objects = 1;
diff --git a/revision.h b/revision.h
index 1cd0c4b200..0d2abc2d36 100644
--- a/revision.h
+++ b/revision.h
@@ -156,6 +156,7 @@ struct rev_info {
 			do_not_die_on_missing_tree:1,
 
 			/* for internal use only */
+			allow_exclude_promisor_objects_opt:1,
 			exclude_promisor_objects:1;
 
 	/* Diff flags */
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 153a506151..819c24d10e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1703,4 +1703,8 @@ test_expect_success 'log --source paints symmetric ranges' '
 	test_cmp expect actual
 '
 
+test_expect_success '--exclude-promisor-objects does not BUG-crash' '
+	test_must_fail git log --exclude-promisor-objects source-a
+'
+
 test_done
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 380e1c1054..eea048e52c 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -118,4 +118,8 @@ test_expect_success '--no-abbrev works like --abbrev=40' '
 	check_abbrev 40 --no-abbrev
 '
 
+test_expect_success '--exclude-promisor-objects does not BUG-crash' '
+	test_must_fail git blame --exclude-promisor-objects one
+'
+
 test_done
-- 
2.19.1.568.g152ad8e336-goog

