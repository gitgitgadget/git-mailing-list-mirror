Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5A11F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeHaBqE (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:46:04 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42144 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeHaBqD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:46:03 -0400
Received: by mail-wr1-f46.google.com with SMTP id v17-v6so9367839wrr.9
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bTKd4AesT2+iw79nYM0j2f3Aipc+EaXwNssBjuC5KNM=;
        b=t6f69aMl3eT83+6BY3ibAWGoAXlBmWg78YKl0Pe0esyi8pEv+z2ldR19vhwjC4II3s
         F69MP/pXrwfppm9rJsoJMQwe7WcLaurXlQBodjCO75sq+Ga3KoWqdm+wVLY/t727W/l2
         dyZXOuJndng5RUPmJ2vBOwXB6tLJOEeSYjn+bGgj19H9yAtKf3bWaMOSvGAbCPYCqTJf
         NfRI4s6CiXjj0zva/+K+j851HdBu6tRbzbE0NAxGlmJfqnImd0ZqJlTq+xJE7kP+8nhO
         9AGiCxXCupD5ltsKky2wN7gmJvoA8/2tyGjMgkQ0n/G8o/V5ZVKMa4y1PjzXGHUrJonO
         OCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTKd4AesT2+iw79nYM0j2f3Aipc+EaXwNssBjuC5KNM=;
        b=Dm+2W7VfjBGaaaNaomIy5sVHbBeiuFB3Tm89oCN7NnzsxHzW0mHj2He3w4lgkvRCKD
         c4xqTFDmboS8HtFnNiqZyEkqi5ZBLSyWL8qN//Mw9zXjGdPqi0lcYyfwWeyz9mmILW34
         n+PYIGYuce8RjuE6T/1BiG/PHO7bglEQ+lc6BCbX2J/0yYQ9oZfU/xm1Y6rc3gxbn6jb
         MVHe1rD0oJU+zLMwKTcW8d7O54Cmmtk68d6oPgzTFOhDZP1MA32bOz1duRkBlbyeooAF
         XD9ANK3YCBHdbHyQvftlouvhw76nwa68lWuPl7EJrAudv3sJ/59PAS32AsAAoohjJPp2
         K1Ig==
X-Gm-Message-State: APzg51Bc2/yJ5lUnX/k3cZVcZMuFZ8NumY4Ka9clCod+OSr8hL0rhQGz
        fOTwMf3IUGQ3ngSAOhlAaDbvZ5Jm
X-Google-Smtp-Source: ANB0Vdb4urKa+hddQUiKcpyrS40KvJnBivs6RKPzQOIbikb3PQ2YQ0TkPAv1cZ3ZPIPsfWvkovn+WA==
X-Received: by 2002:adf:9281:: with SMTP id 1-v6mr9269475wrn.69.1535665309979;
        Thu, 30 Aug 2018 14:41:49 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.49
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:49 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 13/20] stash: convert store to builtin
Date:   Fri, 31 Aug 2018 00:40:43 +0300
Message-Id: <5466d911db63333c21317714e15b5bff827008a6.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash store to the helper and delete the store_stash function
from the shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 55 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 43 ++------------------------------
 2 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 02b593e0cd..87568b0f34 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -58,6 +58,11 @@ static const char * const git_stash_helper_clear_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_store_usage[] = {
+	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static int quiet;
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -723,6 +728,54 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	return diff_result_code(&rev.diffopt, 0);
 }
 
+static int do_store_stash(const char *w_commit, const char *stash_msg,
+			  int quiet)
+{
+	int ret = 0;
+	int need_to_free = 0;
+	struct object_id obj;
+
+	if (!stash_msg) {
+		need_to_free = 1;
+		stash_msg  = xstrdup("Created via \"git stash store\".");
+	}
+
+	ret = get_oid(w_commit, &obj);
+	if (!ret) {
+		ret = update_ref(stash_msg, ref_stash, &obj, NULL,
+				 REF_FORCE_CREATE_REFLOG,
+				 quiet ? UPDATE_REFS_QUIET_ON_ERR :
+				 UPDATE_REFS_MSG_ON_ERR);
+	}
+	if (ret && !quiet)
+		fprintf_ln(stderr, _("Cannot update %s with %s"),
+			   ref_stash, w_commit);
+	if (need_to_free)
+		free((char *) stash_msg);
+	return ret;
+}
+
+static int store_stash(int argc, const char **argv, const char *prefix)
+{
+	const char *stash_msg = NULL;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_STRING('m', "message", &stash_msg, "message", N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_store_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (argc != 1) {
+		fprintf_ln(stderr, _("\"git stash store\" requires one <commit> argument"));
+		return -1;
+	}
+
+	return do_store_stash(argv[0], stash_msg, quiet);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -757,6 +810,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!list_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "show"))
 		return !!show_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "store"))
+		return !!store_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 0d05cbc1e5..5739c51527 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -191,45 +191,6 @@ create_stash () {
 	die "$(gettext "Cannot record working tree state")"
 }
 
-store_stash () {
-	while test $# != 0
-	do
-		case "$1" in
-		-m|--message)
-			shift
-			stash_msg="$1"
-			;;
-		-m*)
-			stash_msg=${1#-m}
-			;;
-		--message=*)
-			stash_msg=${1#--message=}
-			;;
-		-q|--quiet)
-			quiet=t
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-	test $# = 1 ||
-	die "$(eval_gettext "\"$dashless store\" requires one <commit> argument")"
-
-	w_commit="$1"
-	if test -z "$stash_msg"
-	then
-		stash_msg="Created via \"git stash store\"."
-	fi
-
-	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
-	ret=$?
-	test $ret != 0 && test -z "$quiet" &&
-	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
-	return $ret
-}
-
 push_stash () {
 	keep_index=
 	patch_mode=
@@ -308,7 +269,7 @@ push_stash () {
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
-	store_stash -m "$stash_msg" -q $w_commit ||
+	git stash--helper store -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
@@ -468,7 +429,7 @@ create)
 	;;
 store)
 	shift
-	store_stash "$@"
+	git stash--helper store "$@"
 	;;
 drop)
 	shift
-- 
2.19.0.rc0.22.gc26283d74e

