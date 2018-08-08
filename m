Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7BD1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeHHVU0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37922 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeHHVU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so2931331wro.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YFzl9QJYlYNJ/XhD7wVapkxAZAf8t1H9UFDaWaKaXzg=;
        b=YyzDfx8rPurCoH91WC0HpX+bp7oogO9VQp00PmgiJ3o4IvaXQlXC/tT2ifEcqSZl9k
         rcBHwuFnYkSu1MfkaFYnWwKzv1InwCK5ksgpvVvaGavlo3LXOoI+OehaddYZMDh5kZMM
         8Y/Y765fBNAfpj6T9I1bjJdP6KAXFxZlXEQgIUvmzmgMj/r7cGJSzcJZGBXyxrIxXU5/
         g0Q7FqGnMEkD2u4qGp7z68qqJtgFq7FDYaOM6dX+9xo0/x6qWJYQK7m1ejMLc6WUpb1W
         Vqp4tRayuosVtfR0+epR4CfHOOBE23qkAJipMO46v7o08F8ORAxCatTrJkugnyt3x76M
         VTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFzl9QJYlYNJ/XhD7wVapkxAZAf8t1H9UFDaWaKaXzg=;
        b=bknERIzfWBuX+dWjr7T/KyeI4e7AzzWNHF483iyQ7jGqVJfOPnNZiZTO0dXhjxLndw
         h+vSKWqEivLcDwecN8GlMhMk/Qgelhuqspf5J2rPReZydbclfzA1BlKFFnRwdKBc/NFS
         2q3LkqmpV1/sL/ZmSKdQAYjfJ8KInSWPfQQjNvMOny5eapIM7pIgMQ8c0Q2bsc2zdZtQ
         lt/rf/IB2+ZA4fhYlNYyVOSBU30eOrMAVyHAt9M0KBWRvj64Mo0PBIbvlPMSYCIRMVcg
         wJNAbH3UmkA6d50q7i6H/ebaZnnR0YwBoxJjJR6AnkmpT+RVxm3vtwFG5GC/5+lZCcH9
         8d9Q==
X-Gm-Message-State: AOUpUlEEDdk2m8gczz6hENuO5vv3neL2xl7aWR/MFKOsmAqTceu0X9sY
        2FtwkyYsuApgjPpIP17OR+u+v4h9
X-Google-Smtp-Source: AA+uWPyqE0mfifUkvFhSQOsX4XD8DD/WyNAaL78ifaGNj0TWnK570UdiBSt0QJMBjQT4PMb5ye3oJA==
X-Received: by 2002:a5d:4643:: with SMTP id j3-v6mr2667150wrs.52.1533754763377;
        Wed, 08 Aug 2018 11:59:23 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.22
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:22 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 08/26] stash: convert pop to builtin
Date:   Wed,  8 Aug 2018 21:58:47 +0300
Message-Id: <0996e18f410508602525c71e49a0d6614169b77e.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref functions from the shell script now that they
are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 36 ++++++++++++++++++++++++++++++-
 git-stash.sh            | 47 ++---------------------------------------
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 1e4d07295..d6bd468e0 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,7 +13,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
@@ -24,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_pop_usage[] = {
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_apply_usage[] = {
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
@@ -541,6 +546,33 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int index = 0, ret;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_pop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	assert_stash_ref(&info);
+	if ((ret = do_apply_stash(prefix, &info, index)))
+		printf_ln(_("The stash entry is kept in case you need it again."));
+	else
+		ret = do_drop_stash(prefix, &info);
+
+	free_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	const char *branch = NULL;
@@ -603,6 +635,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
 
diff --git a/git-stash.sh b/git-stash.sh
index 29d9f4425..8f2640fe9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -554,50 +554,6 @@ assert_stash_like() {
 	}
 }
 
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	res=$?
-	cd_to_toplevel
-	return $res
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash entry is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -655,7 +611,8 @@ drop)
 	;;
 pop)
 	shift
-	pop_stash "$@"
+	cd "$START_DIR"
+	git stash--helper pop "$@"
 	;;
 branch)
 	shift
-- 
2.18.0.573.g56500d98f

