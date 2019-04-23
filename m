Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FB811F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 08:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfDWIyF (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 04:54:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39537 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 04:54:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id l18so7127837pgj.6
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ePwyvtQ/RMMAbauV9MluWrhq+B6KA/MOgosWmhMQUDI=;
        b=F1qBCH/5Yr+BCxe/pWzttq6EUc+WmIoxBlWx83ztVsQ8sEqvynSE8vv7L3KNbFasRv
         dSTKBco1EA49M+5g43/pD/6mYbDi6N3NnsKcqRJRWrnBXWK7MigCIPZ5LeUjpnXKSyc3
         c2aT9qOSVkjgw/dqqRXh4vT1L4vP4CfWXcPQnhwk9hvwR8QIY+pTbXEg8XYL/HzA5LSm
         H7EBxmixvU3C7SrWfCrDZApuCdOOmVQ2QiK3QehSsxrK5AJGSRzPXkUt4xahgbhIqgTR
         BizDMZ870edrQH4E5sX6alRmcjfY1dr4UXweMpo9vvbNJLPyEcOrdGPXbPR3aX2QShEL
         BUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ePwyvtQ/RMMAbauV9MluWrhq+B6KA/MOgosWmhMQUDI=;
        b=cbD9CgqVU16wwqmtB7kW/aXAJ7Omr7Zem64YZ61zDftuqkr/omwt4/P1eghPknFHbb
         P/cJDpuwHjqQ6GgZCJckFcH5R7J1A2sTmrmuZbygRYs/WvpD1k4Z4mpDJWtLTe3eykbD
         QCzjD0/9l7m84JJTUFiv1byuWiNVeo15+i/wkupNFIosx3TwxdDfaezLRbh1yhLhQN7t
         6ry2yWU04aFgX6+PCS1I/IhjLETb6t9/uifs6DnA0zFnDL+Wm7lfBQDAy1s4hwwssac6
         BO9qy9weH6pzJBb7hDbL6VWjc7k4clZ4J9rj8/HZr6Ha5JY1IT/GlKyFUU9FU6C7wpJm
         uwaA==
X-Gm-Message-State: APjAAAXGO5wJl0sOxPLHn0MEUWF/oJCplRH96b2dCkd7o4k8bAe6Zdi0
        iYwW8skRGWZxDNnXUnUH1URQL5O3
X-Google-Smtp-Source: APXvYqwkqMb/x6MYDVCAEOQfhvaYNTuUtRcAngwUKjKT1rw8J/PV1nmW3th7pgvr7nork1T+0bd9WA==
X-Received: by 2002:a65:5049:: with SMTP id k9mr22762123pgo.229.1556009643788;
        Tue, 23 Apr 2019 01:54:03 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 1sm8305809pgm.10.2019.04.23.01.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 01:54:03 -0700 (PDT)
Date:   Tue, 23 Apr 2019 01:54:01 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] mergetool: use get_merge_tool_guessed function
Message-ID: <e928db892e35bcb68fcdb52c9bf7158dbbb46616.1556009181.git.liu.denton@gmail.com>
References: <cover.1555880168.git.liu.denton@gmail.com>
 <cover.1556009181.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556009181.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-mergetool, the logic for getting which merge tool to use is
duplicated in git-mergetool--lib, except for the fact that it needs to
know whether the tool was guessed or not.

Write `get_merge_tool_guessed` to return whether or not the tool was
guessed in addition to the actual tool and make git-mergetool call this
function instead of duplicating the logic. Also, let
`$GIT_MERGETOOL_GUI` be set to determine whether or not the guitool will
be selected.

Make `get_merge_tool` use this function internally so that code
duplication is reduced.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

After thinking about it for a while, I realised that if it was easy to
find one (albeit old) public project using our code, there should be
many others who we don't know about that will also be using our code.

Let's save them the trouble and just introduce a new function instead of
changing the behaviour of the old one.

---
 Documentation/git-mergetool--lib.txt |  9 ++++++++-
 git-mergetool--lib.sh                | 12 +++++++++---
 git-mergetool.sh                     | 11 +++--------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 055550b2bc..343268d885 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -27,8 +27,15 @@ to define the operation mode for the functions listed below.
 
 FUNCTIONS
 ---------
+get_merge_tool_guessed::
+	returns '$is_guessed:$merge_tool'. '$is_guessed' is 'true' if
+	the tool was guessed, else 'false'. '$merge_tool' is the merge
+	tool to use. '$GIT_MERGETOOL_GUI' may be set to 'true' to search
+	for the appropriate guitool.
+
 get_merge_tool::
-	returns a merge tool.
+	returns a merge tool. '$GIT_MERGETOOL_GUI' may be set to 'true'
+	to search for the appropriate guitool.
 
 get_merge_tool_cmd::
 	returns the custom command for a merge tool.
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 83bf52494c..5eedb1a08a 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -402,15 +402,21 @@ get_merge_tool_path () {
 	echo "$merge_tool_path"
 }
 
-get_merge_tool () {
+get_merge_tool_guessed () {
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
+}
+
+get_merge_tool () {
+	get_merge_tool_guessed | sed -e 's/^[a-z]*://'
 }
 
 mergetool_find_win32_cmd () {
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 01b9ad59b2..63e4da1b2f 100755
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
+		$(GIT_MERGETOOL_GUI=$gui_tool get_merge_tool_guessed)
+		EOF
 	fi
 	merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 	merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
-- 
2.21.0.1000.g11cd861522

