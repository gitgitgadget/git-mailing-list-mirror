Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26931F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfDYJyn (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:54:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38927 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfDYJyn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:54:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so9046066plb.6
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YcPgXoo63y989Xy1wxkwt9NSUu0nrafrafCtZon7K5w=;
        b=bz/uUuo7TAcKPaQOTnXgtngMXU36y2EkvO8Aepq8wqTL9xJq93Aa+YTME+nmAHnml6
         fhYTBXUoQzRzxUbE/LaSKTUPO/auPl3RVO1WYeq0LX7YLM0wD5OWcCaW4QEzz6AIPwJB
         S9Ag3CIEMu6CyO2deVydzCn2BnNv9plTCiXNoH7gk24G3cXVt33FfQK+7ZCeO3HcGBjj
         JKbus+OUlV4Lm0nR8N3wmRsNmtV76XNGob1KhkDquV5ajDAdr3wgub4++mpoemy+O6S3
         XUCoEaP6lFBdRWIfh6H63rUrLlULAyRfoPipCpSh2L7bRoq/4cp8djMl6C7XMuqSacR7
         f7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YcPgXoo63y989Xy1wxkwt9NSUu0nrafrafCtZon7K5w=;
        b=WbQZNbAUTlD4d3hcL2dsIZplQenIA1ceFjeOdwMp1G2WErefH61Jo+CAT+cH4QBrMk
         3EEuHVpic1E5GaNE9HRBCCIRoH3x/GNGiIPSrkivID16sej4+YvtlKwqbBRV/lTsC0a9
         zuTYbE7h+1RivWH8Io0zCEbf4IQK5Ka5s455e+ovZZ26KV92TjerJfh8z5m60N89qEN5
         uk4Cq1pEB6F7fNA0WdCIaFyfisng73rAlhYbryybG0YaMzyDJJawifGYk+2R9yeXDN2V
         0aEEPc9XBgXLedI+iAWjeVK0WlB0pUOnlwAZdiiUswjpPnee4Uach91UP00ZvJorEElh
         SNVw==
X-Gm-Message-State: APjAAAUFOLtAfDY6T5UJfeUox+15YWqFlqopDv8Zpc6zpRqy0GFLgaaj
        ssFzrZB+EjmkFL2UIrx1h/fc0DWx
X-Google-Smtp-Source: APXvYqwSnM0dYbV4F3if1xheIEC8Xxzl6WKyjaJ1xO8zxEUtJjWdF5DKweDb+EcMsqsb7jXPKCrchA==
X-Received: by 2002:a17:902:b602:: with SMTP id b2mr38428539pls.293.1556186081630;
        Thu, 25 Apr 2019 02:54:41 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id o66sm15168688pfb.184.2019.04.25.02.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:54:40 -0700 (PDT)
Date:   Thu, 25 Apr 2019 02:54:39 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/6] mergetool: use get_merge_tool function
Message-ID: <ff83d25ff2d0b9585b52c7e28cd7b93292b5304d.1556185345.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556185345.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-mergetool, the logic for getting which merge tool to use is
duplicated in git-mergetool--lib, except for the fact that it needs to
know whether the tool was guessed or not.

Rewrite `get_merge_tool` to return whether or not the tool was guessed
through the return code and make git-mergetool call this function
instead of duplicating the logic. Note that 1 was chosen to be the
return code of when a tool is guessed because it seems like a slightly
more abnormal condition than getting a tool that's explicitly specified
but this is completely arbitrary.

Also, let `$GIT_MERGETOOL_GUI` be set to determine whether or not the
guitool will be selected.

This change is not completely backwards compatible as there may be
external users of git-mergetool--lib. However, only one user,
git-diffall[1], was found from searching GitHub and Google. It seems
very unlikely that there exists an external caller that would take into
account the return code of `get_merge_tool` as it would always return 0
before this change so this change probably does not affect any external
users.

[1]: https://github.com/thenigan/git-diffall

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-mergetool--lib.txt |  4 +++-
 git-difftool--helper.sh              |  2 +-
 git-mergetool--lib.sh                |  5 ++++-
 git-mergetool.sh                     | 12 ++++--------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 055550b2bc..4da9d24096 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -28,7 +28,9 @@ to define the operation mode for the functions listed below.
 FUNCTIONS
 ---------
 get_merge_tool::
-	returns a merge tool.
+	returns a merge tool. the return code is 1 if we returned a guessed
+	merge tool, else 0. '$GIT_MERGETOOL_GUI' may be set to 'true' to
+	search for the appropriate guitool.
 
 get_merge_tool_cmd::
 	returns the custom command for a merge tool.
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 7bfb6737df..46af3e60b7 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -71,7 +71,7 @@ then
 	then
 		merge_tool="$GIT_DIFF_TOOL"
 	else
-		merge_tool="$(get_merge_tool)" || exit
+		merge_tool="$(get_merge_tool)"
 	fi
 fi
 
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 83bf52494c..68ff26a0f7 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -403,14 +403,17 @@ get_merge_tool_path () {
 }
 
 get_merge_tool () {
+	not_guessed=true
 	# Check if a merge tool has been configured
-	merge_tool=$(get_configured_merge_tool)
+	merge_tool=$(get_configured_merge_tool $GIT_MERGETOOL_GUI)
 	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
 		merge_tool=$(guess_merge_tool) || exit
+		not_guessed=false
 	fi
 	echo "$merge_tool"
+	test "$not_guessed" = true
 }
 
 mergetool_find_win32_cmd () {
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 01b9ad59b2..88fa6a914a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -389,7 +389,7 @@ print_noop_and_exit () {
 
 main () {
 	prompt=$(git config --bool mergetool.prompt)
-	gui_tool=false
+	GIT_MERGETOOL_GUI=false
 	guessed_merge_tool=false
 	orderfile=
 
@@ -416,10 +416,10 @@ main () {
 			esac
 			;;
 		--no-gui)
-			gui_tool=false
+			GIT_MERGETOOL_GUI=false
 			;;
 		-g|--gui)
-			gui_tool=true
+			GIT_MERGETOOL_GUI=true
 			;;
 		-y|--no-prompt)
 			prompt=false
@@ -449,12 +449,8 @@ main () {
 
 	if test -z "$merge_tool"
 	then
-		# Check if a merge tool has been configured
-		merge_tool=$(get_configured_merge_tool $gui_tool)
-		# Try to guess an appropriate merge tool if no tool has been set.
-		if test -z "$merge_tool"
+		if ! merge_tool=$(get_merge_tool)
 		then
-			merge_tool=$(guess_merge_tool) || exit
 			guessed_merge_tool=true
 		fi
 	fi
-- 
2.21.0.1000.g11cd861522

