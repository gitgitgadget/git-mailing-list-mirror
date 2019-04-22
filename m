Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41ACF1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 05:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDVFHr (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 01:07:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45353 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfDVFHq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 01:07:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so5287993pgk.12
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 22:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ff4P7+zKzV5dG7tIQ7SPdHsi9J/DXd84upfnCcVFo8M=;
        b=i8iLPy7fvnt9Qzkafo6pDjLybu6A42peHKHLUYtElxVjmf32EY90N5Y8zmHcHRVVG/
         4VZeFeKNBHeQP3JvyB781JmJQAAtpGnBgLDMbR3yTJpn483s5vI5aEPHX/W5Gv83Yf1m
         t8As2s5ri4wSvtxBSmt0AbzxvD8e8zXYZx/et78+fLnqCuobFrWWLrw/ozkFwAxX7QQg
         YyNJ5PsbRjtX4VT7vB+0GvjcG3Ddsd3OTaE/bf76/VASHrEKT7zIzurG9bRAk7pCRjXd
         YVkv4aJ/d3ynFxlo0+kTyoBPS14a0XSjn6pU6aJf6lVXo7ZPIFF1bULt9e95+i4s/Ffv
         HGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ff4P7+zKzV5dG7tIQ7SPdHsi9J/DXd84upfnCcVFo8M=;
        b=M7esjVAyvTpWUR9x8ARTtBYWzlYq5nd+7+cGgatYkXlDuazZp/npvurMeCfuNrJ2OF
         fXRwLPZLki4SeWmc5iz5EPLsWexYpOcFT9bf8Q84KiUpjS/dqcSmvpzYxALwjsqwO0Jy
         63sdfSp4wdg+wHtMeIeYZt/ccYXgJXHrXzb626zQ0aOC9PYdK1ovtVXc7LxoFQFmkWHL
         DvFzKmONo7IQchr/plSvdWZf4jXYSDgwX7XtCQwPL4ah+0yPeeHHmT3QgfVjGXrDN/3h
         HddohOs/obes0LhewIyGNwPBjwEZ/otYDI7jCgG+On0M/nsQGhG5S9DC9SY1qQr3lDYN
         TU3Q==
X-Gm-Message-State: APjAAAU5M+sj4wvkNA3V+eikQyST+3D7MbM0EXmp/vTLQZ/DCSqthMW7
        3Si93Fod8yxvO4kp9bWHPOsY08dB
X-Google-Smtp-Source: APXvYqydIxY3hM2bRboVMwQcPJybf8FOL2iyY17yytLQ21D3euSlfX9bdbXVEpRbdKU1gE6gsmoARA==
X-Received: by 2002:a63:2943:: with SMTP id p64mr14264232pgp.151.1555909665652;
        Sun, 21 Apr 2019 22:07:45 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id v19sm22362032pfa.138.2019.04.21.22.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 22:07:45 -0700 (PDT)
Date:   Sun, 21 Apr 2019 22:07:43 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/5] mergetool: use get_merge_tool function
Message-ID: <692875cf4baaeee8b47fd7e95d0b787d1a08f64e.1555880168.git.liu.denton@gmail.com>
References: <cover.1555880168.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555880168.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-mergetool, the logic for getting which merge tool to use is
duplicated in git-mergetool--lib, except for the fact that it needs to
know whether the tool was guessed or not.

Rewrite `get_merge_tool` to return whether or not the tool was guessed
and make git-mergetool call this function instead of duplicating the
logic. Also, let `$GIT_MERGETOOL_GUI` be set to determine whether or not
the guitool will be selected.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-mergetool--lib.txt |  5 ++++-
 git-difftool--helper.sh              |  2 +-
 git-mergetool--lib.sh                |  6 ++++--
 git-mergetool.sh                     | 11 +++--------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 055550b2bc..c4f10209e0 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -28,7 +28,10 @@ to define the operation mode for the functions listed below.
 FUNCTIONS
 ---------
 get_merge_tool::
-	returns a merge tool.
+	returns '$is_guessed:$merge_tool'. '$is_guessed' is 'true' if
+	the tool was guessed, else 'false'. '$merge_tool' is the merge
+	tool to use. '$GIT_MERGETOOL_GUI' may be set to 'true' to search
+	for the appropriate guitool.
 
 get_merge_tool_cmd::
 	returns the custom command for a merge tool.
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 7bfb6737df..78a0446668 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -71,7 +71,7 @@ then
 	then
 		merge_tool="$GIT_DIFF_TOOL"
 	else
-		merge_tool="$(get_merge_tool)" || exit
+		merge_tool="$(get_merge_tool | sed -e 's/^[a-z]*://')" || exit
 	fi
 fi
 
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 83bf52494c..d5e2c6c5c6 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -403,14 +403,16 @@ get_merge_tool_path () {
 }
 
 get_merge_tool () {
+	is_guessed=false
 	# Check if a merge tool has been configured
-	merge_tool=$(get_configured_merge_tool)
+	merge_tool=$(get_configured_merge_tool $GIT_MERGETOOL_GUI)
 	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
 		merge_tool=$(guess_merge_tool) || exit
+		is_guessed=true
 	fi
-	echo "$merge_tool"
+	echo "$is_guessed:$merge_tool"
 }
 
 mergetool_find_win32_cmd () {
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 01b9ad59b2..6ad8024e46 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -449,14 +449,9 @@ main () {
 
 	if test -z "$merge_tool"
 	then
-		# Check if a merge tool has been configured
-		merge_tool=$(get_configured_merge_tool $gui_tool)
-		# Try to guess an appropriate merge tool if no tool has been set.
-		if test -z "$merge_tool"
-		then
-			merge_tool=$(guess_merge_tool) || exit
-			guessed_merge_tool=true
-		fi
+		IFS=':' read guessed_merge_tool merge_tool <<-EOF
+		$(GIT_MERGETOOL_GUI=$gui_tool get_merge_tool)
+		EOF
 	fi
 	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
-- 
2.21.0.967.gf85e14fd49

