Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50AF201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbdB1Uey (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:34:54 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33197 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbdB1Ueh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:34:37 -0500
Received: by mail-wr0-f195.google.com with SMTP id g10so2992395wrg.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 12:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwYHJWCd7noR1Xb8n82u+86lqkGVYbanPJLdjH7HEf0=;
        b=gl3Dvp1xBdmbntbFBEoCy8v/+HErdnv8H3XyU2RJNJz/qvw7VK7Jac1w74GVk+4cpB
         0AaUW5OJ8ihBeLWCvg5wUpb0KlVpg/6Jclg4zMd+R/5HjC9MR3rwcvZwtWRei2AJJZ4K
         6rwcDQNe7K2ebBIGtArlmKUoP5nI41xPQ5XmDqrFZd1DFWjSg2LieW+tm0gpd7QtAp7H
         acCxmF06xv4GLo45ZEgaE+mT15cNaAn9u/7rI8qAKDKtF26EyoLfY4Qav9lyLD9BsQo4
         Y655PrRfUyXu6GprxtiosqltHlpUgXp+9v1XnfwfpP34sAlcEYaYDFUf9Vu6RWSJFxvB
         0DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwYHJWCd7noR1Xb8n82u+86lqkGVYbanPJLdjH7HEf0=;
        b=enY5yHwzhnZ3vJk72PaZIldpWJeJED88WKCsntApdkZLOp84m5HL8wi5NMyIEiu8Yw
         H/wEC1jhwlYbqHnYqp2I1JhKwEH32wlHl7TdS0FWNpp8JR6CQ9LHIS67WKpJ+b+AtFtv
         vF7a7bOsASuVX10MrQCDKBtznSByUdkPz3ELm+ho1m/VrNmwWD6KlovTjw1v5ySvbjKu
         Ds1DhsrXpXr+VbWZqrWHGAUpol3PyB7ZnsSs6HcMh00YYH0w217TgK6/nV9OTvXIwY9D
         BNlVsk3tXVmxnZf29aij3vSHD2r60pB2wrwp/hLYVb7qPD3sG3UmKTgYtzGjD8IAALI4
         LNFQ==
X-Gm-Message-State: AMke39lmIebYBwUQ1VIXlB4nozbJkqFredIJkPmzzRFtHBBfGmW0MgvlgMQVmmssFKk0tA==
X-Received: by 10.223.135.153 with SMTP id b25mr3966678wrb.169.1488314032694;
        Tue, 28 Feb 2017 12:33:52 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id e6sm3732935wrc.30.2017.02.28.12.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Feb 2017 12:33:51 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 6/6] stash: allow pathspecs in the no verb form
Date:   Tue, 28 Feb 2017 20:33:40 +0000
Message-Id: <20170228203340.18723-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.428.g67fe103aa
In-Reply-To: <20170228203340.18723-1-t.gummerer@gmail.com>
References: <20170225213306.2410-1-t.gummerer@gmail.com>
 <20170228203340.18723-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that stash_push is used in the no verb form of stash, allow
specifying the command line for this form as well.  Always use -- to
disambiguate pathspecs from other non-option arguments.

Also make git stash -p an alias for git stash push -p.  This allows
users to use git stash -p <pathspec>.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 11 +++++++----
 git-stash.sh                |  3 +++
 t/t3903-stash.sh            | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 4d8d30f179..70191d06b6 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -54,10 +54,13 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 	Save your local modifications to a new 'stash' and roll them
 	back to HEAD (in the working tree and in the index).
 	The <message> part is optional and gives
-	the description along with the stashed state.  For quickly making
-	a snapshot, you can omit _both_ "save" and <message>, but giving
-	only <message> does not trigger this action to prevent a misspelled
-	subcommand from making an unwanted stash.
+	the description along with the stashed state.
++
+For quickly making a snapshot, you can omit "push".  In this mode,
+non-option arguments are not allowed to prevent a misspelled
+subcommand from making an unwanted stash.  The two exceptions to this
+are `stash -p` which acts as alias for `stash push -p` and pathspecs,
+which are allowed after a double hyphen `--` for disambiguation.
 +
 When pathspec is given to 'git stash push', the new stash records the
 modified states only for the files that match the pathspec.  The index
diff --git a/git-stash.sh b/git-stash.sh
index f3c2f86804..207c8126f4 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -657,12 +657,15 @@ apply_to_branch () {
 	}
 }
 
+test "$1" = "-p" && set "push" "$@"
+
 PARSE_CACHE='--not-parsed'
 # The default command is "push" if nothing but options are given
 seen_non_option=
 for opt
 do
 	case "$opt" in
+	--) break ;;
 	-*) ;;
 	*) seen_non_option=t; break ;;
 	esac
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index e875fe8259..89877e4b52 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -892,4 +892,19 @@ test_expect_success 'untracked files are left in place when -u is not given' '
 	test_path_is_file untracked
 '
 
+test_expect_success 'stash without verb with pathspec' '
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_done
-- 
2.12.0.428.g67fe103aa

