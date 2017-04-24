Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108C3207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 03:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164458AbdDXDYi (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 23:24:38 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33656 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164436AbdDXDYc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 23:24:32 -0400
Received: by mail-io0-f195.google.com with SMTP id k87so44663691ioi.0
        for <git@vger.kernel.org>; Sun, 23 Apr 2017 20:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NzD48/XAATVpbQ63l4OyIUvb5iV7LL9u+zwsjFVeVzU=;
        b=b1qBMDkhAoNyU0aYiESqkV2OFeWtyFai2pS5qAb6+Fyc7YwcTwGIR6AUbTnjNUW4UW
         MFLZYXbQqyEti5qrhomrctFf4hXJRTRYzHTGtMc0nqatufEZznABM4253PKWxYhPME/t
         a7tlcvoZRetnyUvA9WpU1ef+nly4RrAzdG8Aun8tw+umbk2ULIjvtlp899SceEalIez3
         TyVrUXDQcLhG85Rg8+zY/nKRKv9s4MyBdiUqZa1Qkb2A4qvQadei01ocWURTnxMEjkTB
         fpU1mnPECWfSBmET1aaRdwPxtkJVzEE6UiXznzbiGdhRd8x3Rg9Iup9WVDM1vIuWdEB9
         IPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NzD48/XAATVpbQ63l4OyIUvb5iV7LL9u+zwsjFVeVzU=;
        b=LZ02tz3OCYl43kh47X1BzXG5UYuScadkcq5wlFbzrahQSZWZdA2x9P7A2j2eleT97/
         HguFdgBNFsZAPcI06W93pvdsNUGEd9J2Ixi5vEdJGuRhZ9T5oyD/PsWcZ5icM8kxt8oQ
         7O8BwO3HwWwJ810t7rMwPHnTC/hx90+AxKFaaOYTiXi+oc/dx7XfxRUbrw66jqPOHwv7
         jBCGAGE/6dD/faH63YjB/La0TPwsteK+RhpfvbShufInWJV0378i5UCX/TEsxqXYDRNT
         kLZ1u9YALvpbz6R4no1J/bovF4HWYTl68JVCPumG4N/BN9rmrTVegD+XEv4h58o5uMhm
         oMqA==
X-Gm-Message-State: AN3rC/7gHG7eV3FQILDLcqgjhTA/jErGX+tbhQrWYkJ0UXdA4V4+PFva
        /FtBnwrINHN5GA==
X-Received: by 10.107.140.197 with SMTP id o188mr5354680iod.180.1493004271766;
        Sun, 23 Apr 2017 20:24:31 -0700 (PDT)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id 66sm7361847ior.34.2017.04.23.20.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Apr 2017 20:24:31 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     liambeguin@gmail.com, martin.von.zweigbergk@gmail.com
Subject: [PATCH] rebase -i: add config to abbreviate command name
Date:   Sun, 23 Apr 2017 23:23:47 -0400
Message-Id: <20170424032347.10878-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'rebase.abbrevCmd' boolean config option to allow
the user to abbreviate the default command name while editing
the 'git-rebase-todo' file.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
Notes:

 *  This allows the lines to remain aligned when using single
    letter commands.

 Documentation/config.txt     | 3 +++
 Documentation/git-rebase.txt | 3 +++
 git-rebase--interactive.sh   | 8 ++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5155..59b64832aeb4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2614,6 +2614,9 @@ rebase.instructionFormat::
 	the instruction list during an interactive rebase.  The format will automatically
 	have the long commit hash prepended to the format.
 
+rebase.abbrevCmd::
+	If set to true, abbreviate command name in interactive mode.
+
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
 	capability to its clients. If you don't want to advertise this
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 67d48e688315..0c423d903625 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -222,6 +222,9 @@ rebase.missingCommitsCheck::
 rebase.instructionFormat::
 	Custom commit list format to use during an `--interactive` rebase.
 
+rebase.abbrevCmd::
+	If set to true, abbreviate command name in interactive mode.
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

