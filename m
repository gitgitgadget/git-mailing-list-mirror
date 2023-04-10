Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0715BC77B70
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 17:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDJRBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjDJRBw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 13:01:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD661BF5
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:01:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s8so3165809wmo.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681146109;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ktnigil0zLkzS2PVEwp9McW7H+78e1D6Qrq1gi+KCYQ=;
        b=L1nqqtLCK4OY2qRUstrLvjqR6mnEnSs3bTm1iK/XNVmAfZXSpKPBorad+iAHyluCDl
         xpyXliv3tg8SqU8PPqLsvyrwOP3gQHWsEdpx7W8SPiPaXw2dn8whPZrCYRJEqdPp3DU2
         KYbceMiXCoOkw+0q2g1LM/9eWtxrZpUvswS5/H4kNUyl5UKZv0kyD5sogqeZg4x1qHn8
         aqlQWOk4wu94cxRNahRMCTI6vAmyAcmEQvqwWYRyIQJ2deTHnhKkj71TYAFwvJeoKknn
         D0Qqcolls8T/dYJEgA6J76wzD5M7kPmz+1UFfj/pXBGEj12Gr2DI01+HiRWMH6y3Yjfj
         9f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146109;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ktnigil0zLkzS2PVEwp9McW7H+78e1D6Qrq1gi+KCYQ=;
        b=jIjXEPCfMA80UvsNMRdP25+WcKReL+fUVo9H4yqcTd5uYfXe9WY/IfEqKn65A3n634
         1ajhVkTercgO3eGwy92lFngunZEcHxC7FkZcv5o6iwCgOkWgsVjfEbWqfKMYV4hLD9ME
         trmGkMext2pSrzbuQtwZyNVHINJ4nrf2fBCX7bACsHTIZ31ZJS/KTv0chCkj+98KWdzp
         uYfvWlLMtT1bN8pg6wkjdL+yGwr9wDy2JgIB7AoioNlx5oilDXV/Pocg3BW92YRPY8+q
         blVtC7DkF0eGvthSpc40w4MoOUIbNMnSbzTTMKj5L4DzgzEuD42tQ/+JjQIh2TVZrMgi
         AZFA==
X-Gm-Message-State: AAQBX9c98aOCvbQK2sgel2bBkP+U1ViimXEfpcN8nywSJ8iHKJKpbkGH
        WahYCQV5w/N51yrHjcHP+mTN11WlQ7A=
X-Google-Smtp-Source: AKy350YNHRg/1GapKNOQHaDiCVjaJXcce0Y1vXcNCD4yvSo9doSADdpVVwD5zYjrc8X2wmqRCWHUcg==
X-Received: by 2002:a7b:c386:0:b0:3ed:8780:f265 with SMTP id s6-20020a7bc386000000b003ed8780f265mr8294716wmj.21.1681146109426;
        Mon, 10 Apr 2023 10:01:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c44c800b003ef4cd057f5sm17990213wmo.4.2023.04.10.10.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:01:49 -0700 (PDT)
Message-Id: <ffbdcf9db686cdd786e21add6ca194c2dbdafa3b.1681146107.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1490.git.git.1681146107.gitgitgadget@gmail.com>
References: <pull.1490.git.git.1681146107.gitgitgadget@gmail.com>
From:   "Jacques Vidrine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Apr 2023 17:01:46 +0000
Subject: [PATCH 1/2] subtree: support GPG commit signing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Allen Reese <java.allen@apple.com>, Jacques Vidrine <t@fboundp.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacques Vidrine <t@fboundp.com>

Add support for -S/--gpg-sign/--no-gpg-sign command line options
and commit.gpgsign configuration. These are passed to invocations
of `git commit-tree`.

Signed-off-by: Allen Reese <java.allen@apple.com>
Signed-off-by: Jacques Vidrine <t@fboundp.com>
---
 contrib/subtree/git-subtree.sh  | 24 +++++++++++++++++++-----
 contrib/subtree/git-subtree.txt |  9 +++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 10c9c87839a..553b4391deb 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -46,6 +46,8 @@ rejoin        merge the new branch back into HEAD
  options for 'add' and 'merge' (also: 'pull', 'split --rejoin', and 'push --rejoin')
 squash        merge subtree changes as a single commit
 m,message=    use the given message as the commit message for the merge commit
+S,gpg-sign?   GPG-sign commits, optionally specifying keyid.
+no-gpg-sign   Disable GPG commit signing.
 "
 
 indent=0
@@ -165,6 +167,7 @@ main () {
 	arg_quiet=
 	arg_debug=
 	arg_prefix=
+	arg_gpgsign=
 	arg_split_branch=
 	arg_split_onto=
 	arg_split_ignore_joins=
@@ -240,6 +243,9 @@ main () {
 			test -n "$allow_addmerge" || die_incompatible_opt "$opt" "$arg_command"
 			arg_addmerge_squash=
 			;;
+		-S*|--gpg-sign=*|--no-gpg-sign)
+			arg_gpgsign="${opt}"
+			;;
 		--)
 			break
 			;;
@@ -268,6 +274,12 @@ main () {
 
 	dir="$(dirname "$arg_prefix/.")"
 
+	if test -z "$arg_gpgsign" &&
+		git config --bool commit.gpgsign >/dev/null
+	then
+		arg_gpgsign="-S"
+	fi
+
 	debug "command: {$arg_command}"
 	debug "quiet: {$arg_quiet}"
 	debug "dir: {$dir}"
@@ -534,7 +546,7 @@ copy_commit () {
 			printf "%s" "$arg_split_annotate"
 			cat
 		) |
-		git commit-tree "$2" $3  # reads the rest of stdin
+		git commit-tree $arg_gpgsign "$2" $3  # reads the rest of stdin
 	) || die "fatal: can't copy commit $1"
 }
 
@@ -674,10 +686,10 @@ new_squash_commit () {
 	if test -n "$old"
 	then
 		squash_msg "$dir" "$oldsub" "$newsub" |
-		git commit-tree "$tree" -p "$old" || exit $?
+		git commit-tree $arg_gpgsign "$tree" -p "$old" || exit $?
 	else
 		squash_msg "$dir" "" "$newsub" |
-		git commit-tree "$tree" || exit $?
+		git commit-tree $arg_gpgsign "$tree" || exit $?
 	fi
 }
 
@@ -900,11 +912,13 @@ cmd_add_commit () {
 	then
 		rev=$(new_squash_commit "" "" "$rev") || exit $?
 		commit=$(add_squashed_msg "$rev" "$dir" |
-			git commit-tree "$tree" $headp -p "$rev") || exit $?
+			git commit-tree $arg_gpgsign "$tree" \
+			$headp -p "$rev") || exit $?
 	else
 		revp=$(peel_committish "$rev") || exit $?
 		commit=$(add_msg "$dir" $headrev "$rev" |
-			git commit-tree "$tree" $headp -p "$revp") || exit $?
+			git commit-tree $arg_gpgsign "$tree" \
+			$headp -p "$revp") || exit $?
 	fi
 	git reset "$commit" || exit $?
 
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 004abf415b8..fa54541b288 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -185,6 +185,15 @@ subproject.
 --message=<message>::
 	Specify <message> as the commit message for the merge commit.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+--no-gpg-sign::
+	GPG-sign commits. The `keyid` argument is optional and
+	defaults to the committer identity; if specified, it must be
+	stuck to the option without a space. `--no-gpg-sign` is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier `--gpg-sign`.
+
 OPTIONS FOR 'split' (ALSO: 'push')
 ----------------------------------
 These options for 'split' may also be given to 'push' (which wraps
-- 
gitgitgadget

