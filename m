Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F66201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbdBYU3c (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:29:32 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33650 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbdBYU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:28:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so7824554wmv.0
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 12:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8poMXsIr4avpX+tejiWhjJ0hbNZgDX/V3DA93Zaoadk=;
        b=XlMsL8LxyEtrrOpiZisPoCm98rqwo2TDxK10cA8KD+dYu6uyGNHi7GHjMP5LGzFjAQ
         6KGE1bxkZV62c20Wba4JffPUd1GvFDkOygPk/LlvxV7cCGrQ2wbKkldGpnDEWpltjRkY
         Zzix29fLvgvkA1DPoG6IQP4Zy8I/szfDh1U0Ga3/q4de3qjX/bs9W6WyPA3xowTRpUiB
         GZTTz42kIpk+1r6eVdAlOLl8Mk2B0UO4vG+oCOz2OMhOY6B0u/oKd0S5NVhPvYEOyXD0
         /MLD3ZSffCKEgiPCR2xCiSQoIbTuFHXcHDagqsKfbw6baJOEFGF+YN+Y5bT1WiU6ECGP
         jUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8poMXsIr4avpX+tejiWhjJ0hbNZgDX/V3DA93Zaoadk=;
        b=pjdom0eoH00EbXtHIAN3zFTzMXSMXbGbqPg0Yh6DrOLTLSFxqwDuOKnukOOSzT3qfP
         tFFqlWtbeWegy6oqfnCC2Piuk2jq6C7xU8KGn1ZWsXDpfXD86R5+/MYrU4hA+BOuZzTd
         4zu3dLByaYddiKa3Z/9jtA4ZNqTBq+HWmEYs3lj9BGQT+uAmxet+6+Wk8H9KngmAoCjY
         CDqcQNmCPT/ab651DmSvEKPd5jT6YZRgJJCVAI8fGXVamZYW0wF6LVGRyRrE4T1Nqc9M
         BtRnVu0Cb40WZfwha86O1qYeuQMTkuNWjHRIs4wmYY4bdYx3yNBaQXwZSp7MRUjopFr9
         CcwQ==
X-Gm-Message-State: AMke39nxgF8SwgyF4xvDNppGgrvCKgrHXURCFzSqDe4ENSL5KOdM7BavS51N/X8ZZWSEOA==
X-Received: by 10.28.19.78 with SMTP id 75mr8067312wmt.108.1488054447646;
        Sat, 25 Feb 2017 12:27:27 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id i203sm7575019wmf.12.2017.02.25.12.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Feb 2017 12:27:26 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 0/6] stash: support pathspec argument
Date:   Sat, 25 Feb 2017 21:33:00 +0000
Message-Id: <20170225213306.2410-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g275aeb250c.dirty
In-Reply-To: <20170219110313.24070-1-t.gummerer@gmail.com>
References: <20170219110313.24070-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio for more comments on the last round, and Peff for reading
through it as well.

Changes since v6:

- If no --include-untracked option is given to git stash push, and a
  pathspec is not in the repository, error out instead of ignoring
  it.  This brings it in line with things like checkout, and also
  allows us to simplify the code internally.
- Simplify the code for rolling back the changes from the working
  tree.  This is enabled by the changes to the pathspec handling.
- There's no more "xargs -0", so there should be no more portability
  concerns.
- Adjust the tests and improve some of the titles a bit

Interdiff:
diff --git a/git-stash.sh b/git-stash.sh
index 18aba1346f..28d0624c75 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -278,12 +278,15 @@ push_stash () {
 		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
 	fi
 
+	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
+
 	git update-index -q --refresh
 	if no_changes "$@"
 	then
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
+
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
@@ -296,23 +299,9 @@ push_stash () {
 	then
 		if test $# != 0
 		then
-			saved_untracked=
-			if test -n "$(git ls-files --others -- "$@")"
-			then
-				saved_untracked=$(
-					git ls-files -z --others -- "$@" |
-					    xargs -0 git stash create -u all --)
-			fi
-			git ls-files -z -- "$@" | xargs -0 git reset ${GIT_QUIET:+-q} --
-			git ls-files -z --modified -- "$@" | xargs -0 git checkout ${GIT_QUIET:+-q} HEAD --
-			if test -n "$(git ls-files -z --others -- "$@")"
-			then
-				git ls-files -z --others -- "$@" | xargs -0 git clean --force -d ${GIT_QUIET:+-q} --
-			fi
-			if test -n "$saved_untracked"
-			then
-				git stash pop -q $saved_untracked
-			fi
+			git reset ${GIT_QUIET:+-q} -- "$@"
+			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")
+			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
 		else
 			git reset --hard ${GIT_QUIET:+-q}
 		fi
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index c0ae41e724..f7733b4dd4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -800,7 +800,7 @@ test_expect_success 'create with multiple arguments for the message' '
 	test_cmp expect actual
 '
 
-test_expect_success 'stash -- <filename> stashes and restores the file' '
+test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	>foo &&
 	>bar &&
 	git add foo bar &&
@@ -812,7 +812,7 @@ test_expect_success 'stash -- <filename> stashes and restores the file' '
 	test_path_is_file bar
 '
 
-test_expect_success 'stash with multiple filename arguments' '
+test_expect_success 'stash with multiple pathspec arguments' '
 	>foo &&
 	>bar &&
 	>extra &&
@@ -842,25 +842,29 @@ test_expect_success 'stash with file including $IFS character' '
 	test_path_is_file bar
 '
 
-test_expect_success 'stash push -p with pathspec shows no changes only onece' '
-	>file &&
-	git add file &&
-	git stash push -p not-file >actual &&
+test_expect_success 'stash push -p with pathspec shows no changes only once' '
+	>foo &&
+	git add foo &&
+	git commit -m "tmp" &&
+	git stash push -p foo >actual &&
 	echo "No local changes to save" >expect &&
+	git reset --hard HEAD~ &&
 	test_cmp expect actual
 '
 
 test_expect_success 'stash push with pathspec shows no changes when there are none' '
-	>file &&
-	git add file &&
-	git stash push not-file >actual &&
+	>foo &&
+	git add foo &&
+	git commit -m "tmp" &&
+	git stash push foo >actual &&
 	echo "No local changes to save" >expect &&
+	git reset --hard HEAD~ &&
 	test_cmp expect actual
 '
 
-test_expect_success 'untracked file is not removed when using pathspecs' '
+test_expect_success 'stash push with pathspec not in the repository errors out' '
 	>untracked &&
-	git stash push untracked &&
+	test_must_fail git stash push untracked &&
 	test_path_is_file untracked
 '
 

Thomas Gummerer (6):
  stash: introduce push verb
  stash: add test for the create command line arguments
  stash: refactor stash_create
  stash: teach 'push' (and 'create_stash') to honor pathspec
  stash: use stash_push for no verb form
  stash: allow pathspecs in the no verb form

 Documentation/git-stash.txt        |  25 ++++++--
 git-stash.sh                       | 114 +++++++++++++++++++++++++++-------
 t/t3903-stash.sh                   | 122 ++++++++++++++++++++++++++++++++++++-
 t/t3905-stash-include-untracked.sh |  26 ++++++++
 4 files changed, 257 insertions(+), 30 deletions(-)

-- 
2.11.0.301.g275aeb250c.dirty

