From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v10 0/2] introduce --[no-]autostash command line flag
Date: Mon, 21 Mar 2016 23:48:01 +0530
Message-ID: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
Cc: gitster@pobox.com, Matthieu.Moy@grenoble-inp.fr,
	pyokagan@gmail.com, sunshine@sunshineco.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:18:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai4Pd-0006H5-OT
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 19:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757732AbcCUSSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 14:18:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33919 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629AbcCUSSj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 14:18:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id n5so31354451pfn.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=h4VH/N6NX9THmeYsrUwlog8YnUtMqumyzL/kMzFxn64=;
        b=TQ3hzGMO9USF/K+skMBkppaVuGVr4XVEdBCQPRkXmcYDNTCMcctM/fAz52v7UUAly/
         H6KG+0TG+WHySbeK6mLzGTv/GqHyD0KkovBqM+uPrTOmc+7dAXHN9uLomMMoMQmcofSh
         3+PkdLjR40d+mJdT7F3xrBlM7SQbt0Q598Qf9ZZ6nkOUNBsPvAGeBAe5LOJFb9brLUtG
         /pvoRJmKihGW5OSldZHozYnSekZjGiaAomt3ZNocxE48LRXEtWHg2/Hk2BOHznH1ybsy
         qzwdMWY5hrmu3U8LRAx/Jdd9L2FSlOmT9ywVqs5gfeqCiywAVhisGN1gfgE5k24shWv/
         XGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h4VH/N6NX9THmeYsrUwlog8YnUtMqumyzL/kMzFxn64=;
        b=FKgQkRYP6NiqBoUmWvUasezFm0bc2JXHbgDIvcDo4q6mJDWvxMB4vtp5XEcDA4qy/T
         /KOl8ne8lzPI+opqoKvkvPkvyqEUiSeEzXjzQr/ahScPflykU56sd8DBjGsfuptRqJGe
         jc7hgQx51Yx3R5qjocSJyln7nZry390qma+H6KdlR6Osrq1so4ka2DezVifGO/7CMuRB
         ugWOVKB7meIUB+I32mF5u//J9yukYE+8IeUyaeA1BKwgp7AoLcbNgIxkdrIu/njI2wvx
         jrnKcZCmhogv4Yu43hZrG/RHCbtCzBdzT5qYYgNym8MFRtdjqwOkp7npTWhztPvt7F4s
         AxAA==
X-Gm-Message-State: AD7BkJKaKo6t/2rjseQa2UyVhGSTrKD2Z3hBZP1ij19i4Qsgv/ELBJQZoElp+N8tXZx7yQ==
X-Received: by 10.98.73.88 with SMTP id w85mr48068310pfa.82.1458584318810;
        Mon, 21 Mar 2016 11:18:38 -0700 (PDT)
Received: from localhost.localdomain ([1.39.36.202])
        by smtp.gmail.com with ESMTPSA id ud8sm42378768pac.11.2016.03.21.11.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 11:18:37 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289434>

Following series of patches introduce --[no-]autostash command line flag
for "git pull --rebase".

[PATCH v10 1/2] git-pull.c: introduce git_pull_config()
It's a clean-up patch for changes introduced in [PATCH v10 2/2].

[PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Changes introduced w.r.t. previous patch:

* Unnecessary tight coupling between git-rebase and git-pull introduced
  in previous patch has been removed by passing "--[no-]autostash" option
  to git-rebase only when user explicitly tell via command line.

* Patch looks more clearer than before as "autostash" variable is used for
  implementation of logic (thanks to Eric).

* Test titles are modified for better understanding of tests.

* Two new tests are added to cover all the combinations of
  "--[no-]autostash" and rebase.autoStash.

* Two more tests are added to checkout for error when "git pull
  --[no-]autostash" is called. Here I'm forced to use "test_i18ncmp"
  instead of "test_i18ngrep" to compare the expected error message with
  the actual because grep was, unfortunately, reading "--[no-]autostash"
  as an option and thus leading to test failure.

Previous patch: http://thread.gmane.org/gmane.comp.version-control.git/289127

Here's the interdiff between previous patch and current patch.

diff --git a/builtin/pull.c b/builtin/pull.c
index 671179b..d98f481 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -308,6 +308,7 @@ static enum rebase_type config_get_rebase(void)
 
 	return REBASE_FALSE;
 }
+
 /**
  * Read config variables.
  */
@@ -804,7 +805,10 @@ static int run_rebase(const unsigned char *curr_head,
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
 		argv_array_push(&args, opt_gpg_sign);
-	argv_array_push(&args, opt_autostash ? "--autostash" : "--no-autostash");
+	if (opt_autostash == 0)
+		argv_array_push(&args, "--no-autostash");
+	else if (opt_autostash == 1)
+		argv_array_push(&args, "--autostash");
 
 	argv_array_push(&args, "--onto");
 	argv_array_push(&args, sha1_to_hex(merge_head));
@@ -854,13 +858,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		die(_("--[no-]autostash option is only valid with --rebase."));
 
 	if (opt_rebase) {
+		int autostash = config_autostash;
+		if (opt_autostash != -1)
+			autostash = opt_autostash;
+
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		if (opt_autostash == -1)
-			opt_autostash = config_autostash;
-
-		if (!opt_autostash)
+		if (!autostash)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 85d9bea..745e59e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,7 +255,19 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
 	test "$(cat new_file)" = dirty &&
 	test "$(cat file)" = "modified again"
 '
-test_expect_success 'pull --rebase: --autostash overrides rebase.autostash' '
+
+test_expect_success 'pull --rebase --autostash & rebase.autostash=true' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
+test_expect_success 'pull --rebase --autostash & rebase.autoStash=false' '
 	test_config rebase.autostash false &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
@@ -266,8 +278,7 @@ test_expect_success 'pull --rebase: --autostash overrides rebase.autostash' '
 	test "$(cat file)" = "modified again"
 '
 
-test_expect_success 'pull --rebase --autostash works with rebase.autostash set true' '
-	test_config rebase.autostash true &&
+test_expect_success 'pull --rebase: --autostash & rebase.autoStash unset' '
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
 	git add new_file &&
@@ -277,7 +288,7 @@ test_expect_success 'pull --rebase --autostash works with rebase.autostash set t
 	test "$(cat file)" = "modified again"
 '
 
-test_expect_success 'pull --rebase: --no-autostash overrides rebase.autostash' '
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash=true' '
 	test_config rebase.autostash true &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
@@ -286,7 +297,7 @@ test_expect_success 'pull --rebase: --no-autostash overrides rebase.autostash' '
 	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
 '
 
-test_expect_success 'pull --rebase --no-autostash works with rebase.autostash set false' '
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash=false' '
 	test_config rebase.autostash false &&
 	git reset --hard before-rebase &&
 	echo dirty >new_file &&
@@ -295,6 +306,26 @@ test_expect_success 'pull --rebase --no-autostash works with rebase.autostash se
 	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
 '
 
+test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
+test_expect_success 'pull --autostash (without --rebase) should error out' '
+	test_must_fail git pull --autostash . copy 2>actual &&
+	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
+	test_i18ncmp actual expect
+'
+
+test_expect_success 'pull --no-autostash (without --rebase) should error out' '
+	test_must_fail git pull --no-autostash . copy 2>actual &&
+	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
+	test_i18ncmp actual expect
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&


Mehul Jain (2):
  git-pull.c: introduce git_pull_config()
  pull --rebase: add --[no-]autostash flag

 Documentation/git-pull.txt |  9 ++++++
 builtin/pull.c             | 30 ++++++++++++++++++--
 t/t5520-pull.sh            | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 3 deletions(-)

-- 
2.7.1.340.g69eb491.dirty
