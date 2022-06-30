Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4722C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiF3VUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiF3VT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B3545787
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n185so96389wmn.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=VFNypiPxjcXEoUFC0YC83wnkx7VDqrMjOqNrl9aVH3c=;
        b=BRM1vh9VoznPXgLReSQGalVHR3szo+DQ1SrXAwq5RkdeE7TnRIMdWWW59Mib7m6Vd/
         BKtoABHi0Qf3ph8vBgWtCHQV2lQ7Q3Vy3c5ofat+FAln2+YOt07yAeuho+sA8IaSBa0/
         FTRUvcS99Aj6Ce0g5SzOnXPdzJn82+3PjVTL/TJX14j9XsYSxRrzXb54P+cc3E6aGkag
         v+F+sbwtOPTqQUjrISRopIa7Kai8NgQt+G1Mfv+ycb7K7sDZ2WpAKLUFJ5LVrBJ4HGs9
         vN8Kde9+SPBruZVAUimTig+PmdyfG/RYT0NdbyGmDfJ96paevRR/hAeCLIigfUe5bA0y
         Yn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=VFNypiPxjcXEoUFC0YC83wnkx7VDqrMjOqNrl9aVH3c=;
        b=lHElEYaSUvsMDImo7w/S6mleUNJwlkQSd2/xm0UvFky3NPc367nyn2r5x2i3TbTYPq
         LsuDxVlyjAJ2e9CxUMs0J3iyP6vdBb2KxPLVXzSn2IGj1P5DpKSgSKX1r4YNJWGdT+Wp
         H9yfb5UvDIDhnl7gg1jRqRX8FtG9ROm7UF6sMU8gsk9UDWUWvRGy1g/hAm/DI8o4cEoP
         OVHKFOr+PHTma1Djmo7NvJruVY01XkluiaQEHDhoJch5EacwkuWxt0ZN0xqDZJJsBOCn
         M2iraeqw2uw+IwqBeWu0c6y9rPz+dr8KYaKvZvDX0xTS0ZkBIQ5VOECfT0IF4aLs7FtJ
         A20Q==
X-Gm-Message-State: AJIora8i7G/9XSGAnVuGEJhg3ctEX79HvUPxe6Ke6O+jWxHCUWPJoggv
        hCz7qXZnaz2bpOU5m1+IjUbKvzErRhE=
X-Google-Smtp-Source: AGRyM1siKVCa3qMskfTp2ftQuMk/+yFYUub2u20bFnGt59OpsKAG/csM/PVlU7UuiiJm6tOOYOXcQg==
X-Received: by 2002:a05:600c:34c4:b0:39c:9236:4e9e with SMTP id d4-20020a05600c34c400b0039c92364e9emr14146198wmq.67.1656623993888;
        Thu, 30 Jun 2022 14:19:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1-20020a1c7c01000000b003a02b135747sm8016823wmc.46.2022.06.30.14.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:53 -0700 (PDT)
Message-Id: <5b893f7d81eb7feb43662ed8663e2af76a76b4c8.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:32 +0000
Subject: [PATCH v2 12/18] git-sh-setup.sh: remove "say" function, change last
 users
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Remove the "say" function, with various rewrites of the remaining
git-*.sh code to C and the preceding change to have git-submodule.sh
stop using the GIT_QUIET variable there were only four uses in
git-subtree.sh. Let's have it use an "arg_quiet" variable instead, and
move the "say" function over to it.

The only other use was a trivial message in git-instaweb.sh, since it
has never supported the --quiet option (or similar) that code added in
0b624b4ceee (instaweb: restart server if already running, 2009-11-22)
can simply use "echo" instead.

The remaining in-tree hits from "say" are all for the sibling function
defined in t/test-lib.sh. It's safe to remove this function since it
has never been documented in Documentation/git-sh-setup.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/subtree/git-subtree.sh | 15 ++++++++++++---
 git-instaweb.sh                |  2 +-
 git-sh-setup.sh                |  9 ---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 1af1d9653e9..7562a395c24 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -50,6 +50,14 @@ m,message=    use the given message as the commit message for the merge commit
 
 indent=0
 
+# Usage: say [MSG...]
+say () {
+	if test -z "$arg_quiet"
+	then
+		printf '%s\n' "$*"
+	fi
+}
+
 # Usage: debug [MSG...]
 debug () {
 	if test -n "$arg_debug"
@@ -60,7 +68,7 @@ debug () {
 
 # Usage: progress [MSG...]
 progress () {
-	if test -z "$GIT_QUIET"
+	if test -z "$arg_quiet"
 	then
 		if test -z "$arg_debug"
 		then
@@ -146,6 +154,7 @@ main () {
 	eval "$set_args"
 
 	# Begin "real" flag parsing.
+	arg_quiet=
 	arg_debug=
 	arg_prefix=
 	arg_split_branch=
@@ -161,7 +170,7 @@ main () {
 
 		case "$opt" in
 		-q)
-			GIT_QUIET=1
+			arg_quiet=1
 			;;
 		-d)
 			arg_debug=1
@@ -252,7 +261,7 @@ main () {
 	dir="$(dirname "$arg_prefix/.")"
 
 	debug "command: {$arg_command}"
-	debug "quiet: {$GIT_QUIET}"
+	debug "quiet: {$arg_quiet}"
 	debug "dir: {$dir}"
 	debug "opts: {$*}"
 	debug
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 4349566c891..c68f49454cd 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -102,7 +102,7 @@ resolve_full_httpd () {
 
 start_httpd () {
 	if test -f "$fqgitdir/pid"; then
-		say "Instance already running. Restarting..."
+		echo "Instance already running. Restarting..."
 		stop_httpd
 	fi
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ecb60d9e3cb..ce273fe0e48 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -57,15 +57,6 @@ die_with_status () {
 	exit "$status"
 }
 
-GIT_QUIET=
-
-say () {
-	if test -z "$GIT_QUIET"
-	then
-		printf '%s\n' "$*"
-	fi
-}
-
 if test -n "$OPTIONS_SPEC"; then
 	usage() {
 		"$0" -h
-- 
gitgitgadget

