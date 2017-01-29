Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650EA1F6DC
	for <e@80x24.org>; Sun, 29 Jan 2017 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbdA2UXD (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jan 2017 15:23:03 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35724 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdA2UXB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2017 15:23:01 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so4336319wmu.2
        for <git@vger.kernel.org>; Sun, 29 Jan 2017 12:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zf2Gzvs3i9ieyZerF4ICJa07rQ3Cpbt/cKlsQcbtj4A=;
        b=GB6iPSYtGyWXBa5Pe5cwkFO9J+Zqjxl4uhFL322qHYnOxJSPmVIzvAkFG4Q2fw8KZ6
         9u9PMGZGI02ofzcQStBTeqve/rg5EAPsZL0G1QvKYjjEZGgHlpd7sxJsw9f6jjPSYoqS
         mG0u+FuWvAu7tMuw7j2RGvap3pEbBgPPVGCkCyjGvIdHNUkLxT8vUkWXLdIj8wq9e7fM
         cRes/2xF1Pjr94w+WTx3oTeERNH7rwrrp88tQer+q8gUffUr9rK2m5dnfG6I6wQi3xlk
         9bGb98OlGMdh2dDYrVFtDKyksRbKrX0FVPIMpJswBY89Ch+OIl7ouxQ0iM5pwWxdhmag
         +G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zf2Gzvs3i9ieyZerF4ICJa07rQ3Cpbt/cKlsQcbtj4A=;
        b=MUHhLVMqOFplu2PT/mBv5wt6cmQFOTDMsenlU6wHYEVo/i8G7lv2DJ2L+T3kx4pVgn
         AjvNh28gGUPKlrM1mxzIXRIjNleTmli9y60ABE0yyfwl57Kk11bvDS1MuSU4aoCoOFwf
         5b6ytDRUzazyhXBFl2n2CV9edSznW8XhkRTjN7UrOHe1FLrBurUjZxw7HX6Tf1yDauM/
         4qgqZch4Rq67vRZor1IyKD1NqCUrxicraSirnhtfQQZl+iXi5l+R7VSXkJEINFfLZRS3
         AC0Q+wLFLZK/1ROXZqNJjvaZdFzBLKJGeBUEqj26rhWqQ+xE6FGru4JdtKN6lmixNb9v
         rZmw==
X-Gm-Message-State: AIkVDXJKBytEOghgIZkitLjw+pP/125GgyaDSINwYQmpgSrqLWNs/pt0T1KHT4LXt0XjyQ==
X-Received: by 10.28.60.66 with SMTP id j63mr11518234wma.74.1485720953778;
        Sun, 29 Jan 2017 12:15:53 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id e6sm19272240wrc.30.2017.01.29.12.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jan 2017 12:15:53 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/4] introduce new format for git stash create
Date:   Sun, 29 Jan 2017 20:16:03 +0000
Message-Id: <20170129201604.30445-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.297.g9a2118ac0b.dirty
In-Reply-To: <20170129201604.30445-1-t.gummerer@gmail.com>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170129201604.30445-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git stash create currently supports a positional argument for adding a
message.  This is not quite in line with how git commands usually take
comments (using a -m flag).

Add a new syntax for adding a message to git stash create using a -m
flag.  This is with the goal of deprecating the old style git stash
create with positional arguments.

This also adds a -u argument, for untracked files.  This is already used
internally as another positional argument, but can now be used from the
command line.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt |  1 +
 git-stash.sh                | 50 +++++++++++++++++++++++++++++++++++++++++----
 t/t3903-stash.sh            | 18 ++++++++++++++++
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 0fc23c25ee..0bce33e3fc 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message>]
+'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
diff --git a/git-stash.sh b/git-stash.sh
index 8528708f61..5f08b43967 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -56,8 +56,50 @@ clear_stash () {
 }
 
 create_stash () {
-	stash_msg="$1"
-	untracked="$2"
+	stash_msg=
+	untracked=
+	new_style=
+	while test $# != 0
+	do
+		case "$1" in
+		-m|--message)
+			shift
+			stash_msg="$1"
+			new_style=t
+			;;
+		-u|--include-untracked)
+			shift
+			untracked="$1"
+			new_style=t
+			;;
+		*)
+			if test -n "$new_style"
+			then
+				echo "invalid argument"
+				option="$1"
+				# TRANSLATORS: $option is an invalid option, like
+				# `--blah-blah'. The 7 spaces at the beginning of the
+				# second line correspond to "error: ". So you should line
+				# up the second line with however many characters the
+				# translation of "error: " takes in your language. E.g. in
+				# English this is:
+				#
+				#    $ git stash save --blah-blah 2>&1 | head -n 2
+				#    error: unknown option for 'stash save': --blah-blah
+				#           To provide a message, use git stash save -- '--blah-blah'
+				eval_gettextln "error: unknown option for 'stash create': \$option"
+				usage
+			fi
+			break
+			;;
+		esac
+		shift
+	done
+
+	if test -z "$new_style"
+	then
+		stash_msg="$*"
+	fi
 
 	git update-index -q --refresh
 	if no_changes
@@ -265,7 +307,7 @@ push_stash () {
 	git reflog exists $ref_stash ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
-	create_stash "$stash_msg" $untracked
+	create_stash -m "$stash_msg" -u "$untracked"
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
@@ -697,7 +739,7 @@ clear)
 	;;
 create)
 	shift
-	create_stash "$*" && echo "$w_commit"
+	create_stash "$@" && echo "$w_commit"
 	;;
 store)
 	shift
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0171b824c9..34e9610bb6 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -784,4 +784,22 @@ test_expect_success 'push -m shows right message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'deprecated version of stash create stores correct message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create "create test message") &&
+	echo "On master: create test message" >expect &&
+	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'new style stash create stores correct message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create -m "create test message new style") &&
+	echo "On master: create test message new style" >expect &&
+	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.297.g9a2118ac0b.dirty

