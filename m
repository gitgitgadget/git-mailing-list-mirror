Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28049201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935130AbdBQWlU (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:41:20 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36367 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964795AbdBQWlN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:41:13 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so4804404wmd.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YbVrXvGpydWdclq5O+teR7mQ96Ts149+O/wCCHZyfsA=;
        b=EYN/GPYTr/htFPSI88xXsiU57aaH2pEBYzdi5v5OXMNoL7vTQyos7R2bl3xbfb+Dkt
         sC8G8T/FcIuFumIgy/i/xQGijva+WqUSq/Ebv7E9pHgQSMX0hY5ossMI65gL/qoVfTfs
         qkum7qlumqeRdobcdx1LMFjpSzllW6gIxrawC7WPmmmHG5WZFFJwra+oUEZ3ddIzD7lw
         2viojesfIL0ggmDj7rlRSdfJk/vUNY+Eguql+ZXjC/Ac1Nu30lSo9dM1S3UQ+7BkilqJ
         ecvJy9FHmSAQ0/DjP266UhgF8gm+IMHOltT9+U+5CzUt2vjIfETmhzN4aPNaR5EI9NHq
         MbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YbVrXvGpydWdclq5O+teR7mQ96Ts149+O/wCCHZyfsA=;
        b=ceqPX2c6/5IfR7iJPPGu9vYBtB2iseLzipG1Ttho1qgr5SiFh+K7awPzZGF6P2NKOC
         psMh4UQUGOen1cIgavb5gKV/xWpuhDjXPiTc47FuI9ctM4KNSKoZUqBApmKs8YzDsEm1
         fLxk5uuBWhaF/7IF3dx30C84WIV1SPJarWJVRwelgcop9rl9ML+2yTdrKs/UzqaxynZZ
         qY/AmIY/CpSjUgCgv65QJTQOFDyjIHfj0LHAWhYVqxi/yqNBpVuvGqdfjAnv8orewNU+
         1B5w+gl/pJuB1eLvSV0kMOmh44SmwerD6rluO+K9qGxDbxJJatrQAxXPy5tc7Xm++OEf
         HnHA==
X-Gm-Message-State: AMke39kDFUqisUS12g9NLya/f2ZExJ3vJF02POOYtS5aLOefWwo7OyBAcYVKZ7UIvwvnbg==
X-Received: by 10.28.238.140 with SMTP id j12mr3422153wmi.35.1487371271895;
        Fri, 17 Feb 2017 14:41:11 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id d42sm14578773wrd.7.2017.02.17.14.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Feb 2017 14:41:11 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 6/6] stash: allow pathspecs in the no verb form
Date:   Fri, 17 Feb 2017 22:41:41 +0000
Message-Id: <20170217224141.19183-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g27b9849079.dirty
In-Reply-To: <20170217224141.19183-1-t.gummerer@gmail.com>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
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
 git-stash.sh     |  3 +++
 t/t3903-stash.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 2a33614cb7..1446fbe2e8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -667,12 +667,15 @@ apply_to_branch () {
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
index 7f90a247b4..c0ae41e724 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -872,4 +872,19 @@ test_expect_success 'untracked files are left in place when -u is not given' '
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
2.11.0.301.g27b9849079.dirty

