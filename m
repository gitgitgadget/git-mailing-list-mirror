Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3852B207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 04:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S975151AbdDYEpD (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 00:45:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36205 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S974984AbdDYEpB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 00:45:01 -0400
Received: by mail-io0-f193.google.com with SMTP id x86so52491723ioe.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 21:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CDoj8wx3vdUntVlVC1/L9AXlNI+ivBJgr3DnO/LkVmQ=;
        b=IfPoGNB2DLRAFlPbnEjoCUquNrWmARZcaVrPACZ8RnJnzx7hAUF6EFz/GwkoKTWGN7
         wMD4RAtdSLy4Bwn5aDhKRYI48dQ/6myPZn84c7+wlKnH2XYVF+c8MY9Kgb+15ohIh52I
         HzyrNvs/prkOrS+3+NCd45BLSLa0j2UYNeKOJw3AhTc/O5SWE1gFNw4XwoJ5JA1H9DV+
         G07xnwJ7OR5smBVN9hWED/GZwUkJdu7pqt45bEWMQBQSaVon3S7XogbA8OsWK3l0nc+w
         pN/INjuz9KElHHVjhlSCRQKq1NZXD1JtwkuRnwEhZMnl5m9L0agM4Kj0p7Dzo+pHorSy
         AN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CDoj8wx3vdUntVlVC1/L9AXlNI+ivBJgr3DnO/LkVmQ=;
        b=PUj7xRROj6IBgcf4YPRHGQ7vnDLnL4mELbehbY6VnXbF0R4EuP5tJmtMQpZJSZvMle
         +2PEbWk5PJKgg56Sy7HKXdsJLoDbOz6qighLE1KOrjleknc6Dc4pXl3IveMXEe6vaG1Z
         WIMFplTm1lgVS+l3tocn89rz1rleqnkAskpayqxhS3J0Sc1hzK/rs5LsWty0MfueTtqD
         HTwjK+Fp5vYJlBu1NMv2IRuWqIGzuwJKPzUrAeTl/AGl02B2PD89trk+zV4swVgO7ZBd
         sOl/lpUQ1J/QQZgBq+akXGT8TV/6Rj41dozpxFpKRmdctIaZVkUQFl68wsjLmV985QE6
         P9jA==
X-Gm-Message-State: AN3rC/6YCTCoRuvlho8wScKzaDf1xx6EDKWmVv41f0MhRTugXiZoKMIa
        EnSQHNUOovn8BiWo
X-Received: by 10.107.159.74 with SMTP id i71mr11489437ioe.143.1493095500707;
        Mon, 24 Apr 2017 21:45:00 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id y125sm1482868itb.4.2017.04.24.21.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 21:44:59 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2] rebase -i: add config to abbreviate command-names
Date:   Tue, 25 Apr 2017 00:43:20 -0400
Message-Id: <20170425044320.17840-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170424032347.10878-1-liambeguin@gmail.com>
References: <20170424032347.10878-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'rebase.abbrevCmd' boolean config option to allow `git rebase -i`
to abbreviate the command-names in the instruction list.

This means that `git rebase -i` would print:
    p deadbee The oneline of this commit
    ...

instead of:
    pick deadbee The oneline of this commit
    ...

Using a single character command-name allows the lines to remain
aligned, making the whole set more readable.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
Changes since v1:
 - Improve Documentation and commit message

 Documentation/config.txt     | 19 +++++++++++++++++++
 Documentation/git-rebase.txt | 19 +++++++++++++++++++
 git-rebase--interactive.sh   |  8 ++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5155..8b1877f2df91 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2614,6 +2614,25 @@ rebase.instructionFormat::
 	the instruction list during an interactive rebase.  The format will automatically
 	have the long commit hash prepended to the format.
 
+rebase.abbrevCmd::
+	If set to true, `git rebase -i` will abbreviate the command-names in the
+	instruction list. This means that instead of looking like this,
+
+-------------------------------------------
+	pick deadbee The oneline of this commit
+	pick fa1afe1 The oneline of the next commit
+	...
+-------------------------------------------
+
+	the list would use the short version of the command resulting in
+	something like this.
+
+-------------------------------------------
+	p deadbee The oneline of this commit
+	p fa1afe1 The oneline of the next commit
+	...
+-------------------------------------------
+
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
 	capability to its clients. If you don't want to advertise this
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 67d48e688315..7d97c0483241 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -222,6 +222,25 @@ rebase.missingCommitsCheck::
 rebase.instructionFormat::
 	Custom commit list format to use during an `--interactive` rebase.
 
+rebase.abbrevCmd::
+	If set to true, `git rebase -i` will abbreviate the command-names in the
+	instruction list. This means that instead of looking like this,
+
+-------------------------------------------
+	pick deadbee The oneline of this commit
+	pick fa1afe1 The oneline of the next commit
+	...
+-------------------------------------------
+
+	the list would use the short version of the command resulting in
+	something like this.
+
+-------------------------------------------
+	p deadbee The oneline of this commit
+	p fa1afe1 The oneline of the next commit
+	...
+-------------------------------------------
+
 OPTIONS
 -------
 --onto <newbase>::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2c9c0165b5ab..9f3e82b79615 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1210,6 +1210,10 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
+
+rebasecmd=pick
+test "$(git config --bool --get rebase.abbrevCmd)" = true && rebasecmd=p
+
 format=$(git config --get rebase.instructionFormat)
 # the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
 git rev-list $merges_option --format="%m%H ${format:-%s}" \
@@ -1228,7 +1232,7 @@ do
 
 	if test t != "$preserve_merges"
 	then
-		printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
+		printf '%s\n' "${comment_out}${rebasecmd} $sha1 $rest" >>"$todo"
 	else
 		if test -z "$rebase_root"
 		then
@@ -1246,7 +1250,7 @@ do
 		if test f = "$preserve"
 		then
 			touch "$rewritten"/$sha1
-			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
+			printf '%s\n' "${comment_out}${rebasecmd} $sha1 $rest" >>"$todo"
 		fi
 	fi
 done
-- 
2.9.3

