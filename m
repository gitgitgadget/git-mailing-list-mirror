Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2425B20899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbdHBTlK (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:41:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33365 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdHBTlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:41:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id q189so186016wmd.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N41SvyNkBdhKL7g9tGK0MvDhm++LslhD4MkrcVXylDU=;
        b=a3I3KYaDaOfdMyom518MsyWnoWY762503ZfdbEOuZV90jIolqObwIR3b/TclVGfAbJ
         l4dDaL7qLPkmuMWwbVoJh/igopAPRNUbYOrCNJS0k+beM8AzYocoenAzhYq+T1fROoQd
         j6g+n/nhJcapOY0QMhcAcp6jbC9ckKQrWZ+A6Is0svM9oXGgcWALyj+mr2q5EGXYO3w0
         7YV1MyHbiK7xCRuJUFzAohaSlZQ9fKVTl7JGWmPhx7wZnhszG4qiBZ22nJpXP9W82GFp
         TvebJcNygAIIhKjcvx39lmAIs4PlbG9lu48BoU3mhuF1XYuMcVfSQUvS+pAs/UdsNL3p
         ZIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N41SvyNkBdhKL7g9tGK0MvDhm++LslhD4MkrcVXylDU=;
        b=aJLRQpgBpAr9QTdVPFI9hBlXBKdfZp9zXdQ9JRXUAhZZhPRFVRNjwUGzY3DJfhtup3
         Q31Pw8HT7CF3GQOU2pt+CwIXAeV9NCIZTNzKgyxkOdz0kvuoSR2OYwiYYkge+1Wwp5Ep
         u2je4o9QYk67xU+YMLcHz8q2Y8zVzk8to3TOIqYvEOTYdTeRT4H8ukJLnQpyJ0tZWgWX
         2VfrvF1RPEJ3TKKXJkQeDVqfkhXLUQzA7FRLivujUixuxQ9svox54lP4hO96g2N0SNIr
         d2IhG/RopoIpMhqq9Jg/J1ppQszi3cihFyfAFkObON4Yjr9xIt2bbNBifPQ+6gqq7Ur1
         HaWA==
X-Gm-Message-State: AIVw110Cvk2dQIB7k7E/kH7gxMeRkQzWzUkiS4HI9dZshecyg0DGHwsf
        H5ZJW0TU2cJ3ZXTt
X-Received: by 10.28.91.140 with SMTP id p134mr4750279wmb.79.1501702867525;
        Wed, 02 Aug 2017 12:41:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id t13sm103576wra.22.2017.08.02.12.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:41:06 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/7] tag: only respect `pager.tag` in list-mode
Date:   Wed,  2 Aug 2017 21:40:48 +0200
Message-Id: <cover.1501701128.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.12.ge2d9c4613
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the third version of my attempt to make `pager tag` useful (v1
at [1], v2 at [2]). Thanks to Junio and Peff for comments on v2.

I've squashed patches 01-03/10 and 07-08/10, respectively. The interdiff
is below. I managed to clean up some tests thanks to a drive-by comment
by Peff which cleared up a misunderstanding I had. Some minor changes,
e.g., I write "built-in" instead of "builtin", since that seemed
preferred, at least locally in builtin.h. I documented why a default
value of "punt" could be useful, but also that it's probably not wanted.

Martin

[1] https://public-inbox.org/git/cover.1499723297.git.martin.agren@gmail.com/T/

[2] https://public-inbox.org/git/cover.1500321657.git.martin.agren@gmail.com/T/#u

Martin Ågren (7):
  builtin.h: take over documentation from api-builtin.txt
  git.c: let builtins opt for handling `pager.foo` themselves
  git.c: provide setup_auto_pager()
  t7006: add tests for how git tag paginates
  tag: respect `pager.tag` in list-mode only
  tag: change default of `pager.tag` to "on"
  git.c: ignore pager.* when launching builtin as dashed external

 Documentation/git-tag.txt               |   3 +
 Documentation/technical/api-builtin.txt |  73 -----------------------
 t/t7006-pager.sh                        |  80 +++++++++++++++++++++++++
 builtin.h                               | 100 ++++++++++++++++++++++++++++++++
 builtin/tag.c                           |   3 +
 git.c                                   |  18 +++++-
 6 files changed, 201 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/technical/api-builtin.txt

Interdiff vs v2:
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 8b2ffb1aa..9128ec5ac 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -162,7 +162,7 @@ test_expect_success TTY 'git tag with no args defaults to paging' '
 test_expect_success TTY 'git tag with no args respects pager.tag' '
 	# no args implies -l so this should page like -l
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag=no tag &&
+	test_terminal git -c pager.tag=false tag &&
 	! test -e paginated.out
 '
 
@@ -202,20 +202,15 @@ test_expect_success TTY 'git tag -a respects --paginate' '
 '
 
 test_expect_success TTY 'git tag as alias ignores pager.tag with -a' '
-	# git-tag will be launched as a dashed external, which
-	# 1) is the source of a potential bug, and
-	# 2) is why we use test_config and not -c.
 	test_when_finished "git tag -d newtag" &&
 	rm -f paginated.out &&
-	test_config pager.tag true &&
-	test_terminal git -c alias.t=tag t -am message newtag &&
+	test_terminal git -c pager.tag -c alias.t=tag t -am message newtag &&
 	! test -e paginated.out
 '
 
 test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
 	rm -f paginated.out &&
-	test_config pager.tag false &&
-	test_terminal git -c alias.t=tag t -l &&
+	test_terminal git -c pager.tag=false -c alias.t=tag t -l &&
 	! test -e paginated.out
 '
 
diff --git a/builtin.h b/builtin.h
index 3ca4a53a8..42378f3aa 100644
--- a/builtin.h
+++ b/builtin.h
@@ -51,15 +51,15 @@
  *	on bare repositories.
  *	This only makes sense when `RUN_SETUP` is also set.
  *
- * `SUPPORT_SUPER_PREFIX`::
+ * `SUPPORT_SUPER_PREFIX`:
  *
- *	The builtin supports `--super-prefix`.
+ *	The built-in supports `--super-prefix`.
  *
- * `DELAY_PAGER_CONFIG`::
+ * `DELAY_PAGER_CONFIG`:
  *
  *	If RUN_SETUP or RUN_SETUP_GENTLY is set, git.c normally handles
  *	the `pager.<cmd>`-configuration. If this flag is used, git.c
- *	will skip that step, instead allowing the builtin to make a
+ *	will skip that step, instead allowing the built-in to make a
  *	more informed decision, e.g., by ignoring `pager.<cmd>` for
  *	certain subcommands.
  *
@@ -114,11 +114,14 @@ extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
 
 /**
- * If a builtin has DELAY_PAGER_CONFIG set, the builtin should call this early
+ * If a built-in has DELAY_PAGER_CONFIG set, the built-in should call this early
  * when it wishes to respect the `pager.foo`-config. The `cmd` is the name of
- * the builtin, e.g., "foo". If a paging-choice has already been setup, this
+ * the built-in, e.g., "foo". If a paging-choice has already been setup, this
  * does nothing. The default in `def` should be 0 for "pager off", 1 for "pager
  * on" or -1 for "punt".
+ *
+ * You should most likely use a default of 0 or 1. "Punt" (-1) could be useful
+ * to be able to fall back to some historical compatibility name.
  */
 extern void setup_auto_pager(const char *cmd, int def);
 
-- 
2.14.0.rc1.12.ge2d9c4613

