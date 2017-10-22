Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0465202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 17:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdJVRDJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 13:03:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:52997 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdJVRDI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 13:03:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id k62so15157458wrc.9
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dEu4IJNW6unm8kdr/eOjmP75S90ZPBJEpOTdY8EGl/c=;
        b=qFYvqMtnVXHpEVi9Iu6+3jThEUnpYLdJDxftbumk2fCCaNkNanHYXMZt+vY8DcIee+
         /sWL3l3pubWRpyiU/C3dzNGEnQjYAuuyi8vzqvo+Yf125XCEzWZJeyqyb7qtJXsd1YMS
         cnyVgIuTkdW3d8y65/ibVxVD4we8etJhN/T9Ohcu0OvO1ajQsBDZ5n1XD/rznSLoQ1He
         3FDujfFEGtcmUuMdKag/3xU1yXa1GlVutjHsfBw28jYRDbQAvtaaDr/M5nnx54yRledU
         5mWuQDfAqOA5hbVz/f8rNVC0exajgLorByqNajCa8iWdGndZFNmofuTBaWk5qbiQOPqs
         mmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dEu4IJNW6unm8kdr/eOjmP75S90ZPBJEpOTdY8EGl/c=;
        b=cxrrSZLuC5gZQcOWKo4od67zF9+4UYnFjRyToL+BOM//W3M5PKXuoCUUKdtb1QgxpG
         /HS3uZt5yaz/5jD6CmqKGB47w3T5rpaGMCa7Ls5f5Ck7dm/2x9FLd2JSiLqHAkIBn/sg
         4GH+xKnrlyiHGIL6xZrnVtrFj26miFQ/dXJ57SpSINfu2aGhnf0iGnjfFUUpbPM0t51q
         XWOwQjVvhTHhHAnuXLtI4UKFbZscstwaMNBQGBgCDOrCAL9eZZY6aYJytXahQjA/i5bd
         flbz2bywc3DkB6cuFEB896Z1JVYGgmTgppG30546+Lm3ebmYpkRWjsPp57+kAqfnKvBj
         X9FQ==
X-Gm-Message-State: AMCzsaVvPXyYpPoYzDOsTfwKTYq6758zl2OkgNBqgaaXdrLa8wP+Ij6A
        5GDeOw5dCPOJ/X404x8LnsWyjf+i
X-Google-Smtp-Source: ABhQp+Sr+dAsfbwezrDMhWasiwq+G4Go9BdyZA1gD2TcUWHtsf9vW5GqH+siSb+zyu/Y8fNlSjvwIQ==
X-Received: by 10.223.187.131 with SMTP id q3mr6314478wrg.83.1508691787385;
        Sun, 22 Oct 2017 10:03:07 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id n30sm2985684wra.39.2017.10.22.10.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Oct 2017 10:03:06 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/3] deprecate git stash save
Date:   Sun, 22 Oct 2017 18:04:06 +0100
Message-Id: <20171022170409.8565-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.2.g8fac3e73c8.dirty
In-Reply-To: <20171019183304.26748-2-t.gummerer@gmail.com>
References: <20171019183304.26748-2-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Peff for the review of the previous rounds.

In addition to addressing the review comments, this round adds another
patch getting rid of the extra help with an unknown option to git
stash push.

Interdiff below:

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 89b6a0e672..8be661007d 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -86,7 +86,9 @@ The `--patch` option implies `--keep-index`.  You can use
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
-	This option is deprecated in favour of 'git stash push'.
+	This option is deprecated in favour of 'git stash push'.  It
+	differs from "stash push" in that it cannot take pathspecs,
+	and any non-option arguments form the message.
 
 list [<options>]::
 
diff --git a/git-stash.sh b/git-stash.sh
index 16919277ba..4b74951440 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -260,18 +260,7 @@ push_stash () {
 			;;
 		-*)
 			option="$1"
-			# TRANSLATORS: $option is an invalid option, like
-			# `--blah-blah'. The 7 spaces at the beginning of the
-			# second line correspond to "error: ". So you should line
-			# up the second line with however many characters the
-			# translation of "error: " takes in your language. E.g. in
-			# English this is:
-			#
-			#    $ git stash push --blah-blah 2>&1 | head -n 2
-			#    error: unknown option for 'stash push': --blah-blah
-			#           To provide a message, use git stash push -- '--blah-blah'
-			eval_gettextln "error: unknown option for 'stash push': \$option
-       To provide a message, use git stash push -m '\$option'"
+			eval_gettextln "error: unknown option for 'stash push': \$option"
 			usage
 			;;
 		*)


Thomas Gummerer (3):
  replace git stash save with git stash push in the documentation
  mark git stash push deprecated in the man page
  stash: remove now superfluos help for "stash push"

 Documentation/git-stash.txt    | 21 ++++++++++++---------
 Documentation/gitworkflows.txt |  2 +-
 Documentation/user-manual.txt  |  2 +-
 git-stash.sh                   | 13 +------------
 4 files changed, 15 insertions(+), 23 deletions(-)

-- 
2.15.0.rc0.2.g8fac3e73c8.dirty

