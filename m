Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9031F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbeC0Fpl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:45:41 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37222 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeC0Fpk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:45:40 -0400
Received: by mail-pl0-f65.google.com with SMTP id w12-v6so13478409plp.4
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 22:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zxcKEweOa51Rw+ZSvBkFhCz41U1yV6mYRsBw0pT0ZbQ=;
        b=T4jQprNS67+T5QbT2rIg0DpjFnx+G12cW8KegrxmC7GJCPLUMsPdVZCEpoBrv4bNic
         b3pDBWwZSve9YS2i57mNHB8avA9AkK9kaum41UP0esOUTSKt24E895cmgTx1vIU4P8uQ
         zDnfc48Xgc4TY5/f8XhfphXtv3LrEoPk/ML0az4mvZlDnb/VKaCLetJ0IV8x7OmyvPIb
         uhi26INkURfHjUF79/C+MqylWvYzXztvtmBnag+q2ANA3Hm+iJlzXNauljpmbe3X76Ld
         7bzizszIzcFGkVOUxnULAUaKdOqCIkPofyP/BrZAsUzwll+LFc+u+PPJq/6pi4ZF13et
         mQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zxcKEweOa51Rw+ZSvBkFhCz41U1yV6mYRsBw0pT0ZbQ=;
        b=XW1VzLP4QFhmlZvcou35IN3qugwBSby92U2vY/rMyWYkif84usMLoFI0wYcXpxJOSv
         0pPWh2MGTKPadAfxgZhqV7t0cHrhoAr+4j7q8VCQkU01rk3YqcZS1+2oZyDzEhH3dWrg
         vFC9mIbcXspFLWorfcZQVxDZGVSWWb6q0FSYjDeLkpv+NwYjI9UZhZCWFUuxcUdpwcEP
         +BDOqmDj5i9fBOTITZx98qQu8sp06tbkay/3+8cBIITIs2ZGEGFOs1RxpLFDsz3XEyld
         k+aPb57P1kfsdwIthVhXp/sb1bhfhyuU56+czfjfh33Nubc52QbXfcDTFPazwnhkqPEG
         Ac7g==
X-Gm-Message-State: AElRT7F3ggx9mabR7nVEGy+hsDPeSzhrkzAmQgCtHzHewtYlIQJfL1T+
        Atkl9LlAq9Y6PV9ZSOd2O252cUQ=
X-Google-Smtp-Source: AG47ELu390e8tIzcT6l+6a49gOHQHOYp3Q+bNzT4gIK3b9LS2YF/I9hTmeZem+3lM6QasBogoyNpwA==
X-Received: by 2002:a17:902:4545:: with SMTP id m63-v6mr38316112pld.149.1522129539778;
        Mon, 26 Mar 2018 22:45:39 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id n8sm898733pff.131.2018.03.26.22.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 22:45:39 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v3 4/5] stash: convert branch to builtin
Date:   Mon, 26 Mar 2018 22:44:31 -0700
Message-Id: <20180327054432.26419-5-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180327054432.26419-1-joel@teichroeb.net>
References: <20180327054432.26419-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash branch to the helper and delete the apply_to_branch
function from the shell script.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 17 ++---------------
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 0d7a0d55e..d755faf33 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,6 +13,7 @@
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
 };
@@ -27,6 +28,11 @@ static const char * const git_stash_helper_apply_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_branch_usage[] = {
+	N_("git stash--helper branch <branchname> [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_clear_usage[] = {
 	N_("git stash--helper clear"),
 	NULL
@@ -507,6 +513,45 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int branch_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *branch = NULL;
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+	struct stash_info info;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_branch_usage, 0);
+
+	if (argc == 0)
+		return error(_("No branch name specified"));
+
+	branch = argv[0];
+
+	if (get_stash_info(&info, argc - 1, argv + 1))
+		return -1;
+
+	argv_array_pushl(&args, "checkout", "-b", NULL);
+	argv_array_push(&args, branch);
+	argv_array_push(&args, oid_to_hex(&info.b_commit));
+	ret = cmd_checkout(args.argc, args.argv, prefix);
+	if (ret) {
+		free_stash_info(&info);
+		return -1;
+	}
+
+	ret = do_apply_stash(prefix, &info, 1);
+	if (!ret && info.is_stash_ref)
+		ret = do_drop_stash(prefix, &info);
+
+	free_stash_info(&info);
+
+	return ret;
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	int result = 0;
@@ -533,6 +578,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		result = clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "branch"))
+		result = branch_stash(argc, argv, prefix);
 	else {
 		error(_("unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 0b8f07b38..c5fd4c6c4 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -598,20 +598,6 @@ drop_stash () {
 	clear_stash
 }
 
-apply_to_branch () {
-	test -n "$1" || die "$(gettext "No branch name specified")"
-	branch=$1
-	shift 1
-
-	set -- --index "$@"
-	assert_stash_like "$@"
-
-	git checkout -b $branch $REV^ &&
-	apply_stash "$@" && {
-		test -z "$IS_STASH_REF" || drop_stash "$@"
-	}
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -672,7 +658,8 @@ pop)
 	;;
 branch)
 	shift
-	apply_to_branch "$@"
+	cd "$START_DIR"
+	git stash--helper branch "$@"
 	;;
 *)
 	case $# in
-- 
2.16.2

