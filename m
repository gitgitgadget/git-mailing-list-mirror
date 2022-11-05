Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DCFC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKER2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKER2k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:28:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0113D08
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:28:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so4889724wmb.3
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH2PAwK8M9JEfWgeaBtlLnvPPZ/0bB4yokcJtkLCFZE=;
        b=f/KXJlzgICLndMgoFCwRhWYEHqw8FIPE8LFLJchP4e/Au+NFO4FxlFO9POemZmZH+Z
         Vlay9nS1G4u1KHxsEOqh0GzgX9ENgQuXgaXIyA1/uS0thhyQ/MiGML+4p01hZ5bWLpk9
         3Niur+7dIniNfay+4NAgjD04hTuAxak6LhmFiLLtc1U7dpH1zzw25fTD0okRAqTBEOCn
         xdvnOIzkCFpqrJLr0X9A8zuW4wj3T8EtEixEeDTpZ6UUDGSE4cHnXZwLumvcUx2kIDJa
         EX4NLt5bR+P74JBNaxyoVPkfyOPEj42Kur00Nmag/zQB3bp97xyQ/EtfdxAyVe9iKO9F
         WfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bH2PAwK8M9JEfWgeaBtlLnvPPZ/0bB4yokcJtkLCFZE=;
        b=e8TVLfeSs2TiJg6Xlv4aRseDsRw4wn9BhKfRZYndQHbTt0aLoZBWPAGFX+nfIfqfU7
         PHWEpNoERdAApFiJEcapeCbS8BewotlnqwdV8mkU0YrgGn/yysalxEdDnn02Vvk+SQq6
         RXo5SbcNedoaRB6VEfBdLnmN7cTF1wYxLZ2XXoAHmmoyGL90Wi3c0k16yN5BaZlmp77H
         GBYKN3XDOPEok1UjxcmuBdIKeQeXvMBtbyYH1LjzaPBCbDDkyVwGuxJZqM/knFlijv3E
         jwEQmoIO05wb1UaN2ouJFvyfp91MivlAuSKERQgQuuEmIfGnj9Mhs9ToC0HJHcUIdLmJ
         djkg==
X-Gm-Message-State: ACrzQf18QYpLQ3idFvCF+TVBWh4hRNvOhzbsqTULRp80BAEze6b2XXi+
        BIQhJqx9cTpGso2Xh7+41XC4hOOdwZQ=
X-Google-Smtp-Source: AMsMyM7LdRPyaPuRhV9Bkl7eQqGVNRSMMmp/9tIo5N3gCqqfl4NvKaBKQfrYb6Gfx3kP6z+jL+1J9w==
X-Received: by 2002:a05:600c:4252:b0:3cf:678a:d189 with SMTP id r18-20020a05600c425200b003cf678ad189mr26939511wmm.51.1667669318143;
        Sat, 05 Nov 2022 10:28:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q188-20020a1c43c5000000b003cf894c05e4sm6323366wma.22.2022.11.05.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:28:37 -0700 (PDT)
Message-Id: <cef9a12b5752fc62151296e1b679fbe973556998.1667669315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
From:   "Alison Winters via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Nov 2022 17:28:34 +0000
Subject: [PATCH 1/2] completion: add optional ignore-case when matching refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alison Winters <alisonatwork@outlook.com>,
        Alison Winters <alisonatwork@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alison Winters <alisonatwork@outlook.com>

If GIT_COMPLETION_IGNORE_CASE=1 is set, --ignore-case will be added to
git for-each-ref calls so that branches and tags can be matched case
insensitively.

Signed-off-by: Alison Winters <alisonatwork@outlook.com>
---
 contrib/completion/git-completion.bash | 41 ++++++++++++++++++++++++++
 t/t9902-completion.sh                  | 16 ++++++++++
 2 files changed, 57 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba5c395d2d8..8ed96a5b8b6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -58,6 +58,11 @@
 #
 #     When set to "1" suggest all options, including options which are
 #     typically hidden (e.g. '--allow-empty' for 'git commit').
+#
+#   GIT_COMPLETION_IGNORE_CASE
+#
+#     When set to "1", suggest refs that match case insensitively (e.g.,
+#     completing "FOO" on "git checkout f<TAB>").
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -644,8 +649,15 @@ __git_complete_index_file ()
 __git_heads ()
 {
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
+	local ignore_case=""
+
+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
+	then
+		ignore_case="--ignore-case"
+	fi
 
 	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			$ignore_case \
 			"refs/heads/$cur_*" "refs/heads/$cur_*/**"
 }
 
@@ -657,8 +669,15 @@ __git_heads ()
 __git_remote_heads ()
 {
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
+	local ignore_case=""
+
+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
+	then
+		ignore_case="--ignore-case"
+	fi
 
 	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			$ignore_case \
 			"refs/remotes/$cur_*" "refs/remotes/$cur_*/**"
 }
 
@@ -667,8 +686,15 @@ __git_remote_heads ()
 __git_tags ()
 {
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
+	local ignore_case=""
+
+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
+	then
+		ignore_case="--ignore-case"
+	fi
 
 	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
+			$ignore_case \
 			"refs/tags/$cur_*" "refs/tags/$cur_*/**"
 }
 
@@ -682,12 +708,19 @@ __git_dwim_remote_heads ()
 {
 	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
 	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
+	local ignore_case=""
+
+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
+	then
+		ignore_case="--ignore-case"
+	fi
 
 	# employ the heuristic used by git checkout and git switch
 	# Try to find a remote branch that cur_es the completion word
 	# but only output if the branch name is unique
 	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
 		--sort="refname:strip=3" \
+		$ignore_case \
 		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
 	uniq -u
 }
@@ -713,6 +746,7 @@ __git_refs ()
 	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
 	local match="${4-}"
 	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
+	local ignore_case=""
 
 	__git_find_repo_path
 	dir="$__git_repo_path"
@@ -735,6 +769,11 @@ __git_refs ()
 		fi
 	fi
 
+	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
+	then
+		ignore_case="--ignore-case"
+	fi
+
 	if [ "$list_refs_from" = path ]; then
 		if [[ "$cur_" == ^* ]]; then
 			pfx="$pfx^"
@@ -765,6 +804,7 @@ __git_refs ()
 			;;
 		esac
 		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
+			$ignore_case \
 			"${refs[@]}"
 		if [ -n "$track" ]; then
 			__git_dwim_remote_heads "$pfx" "$match" "$sfx"
@@ -787,6 +827,7 @@ __git_refs ()
 			$match*)	echo "${pfx}HEAD$sfx" ;;
 			esac
 			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
+				$ignore_case \
 				"refs/remotes/$remote/$match*" \
 				"refs/remotes/$remote/$match*/**"
 		else
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 43de868b800..f62a395d827 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2255,6 +2255,22 @@ test_expect_success 'checkout completes ref names' '
 	EOF
 '
 
+test_expect_success 'checkout does not match ref names of a different case' '
+	test_completion "git checkout M" ""
+'
+
+test_expect_success 'checkout matches case insensitively with GIT_COMPLETION_IGNORE_CASE' '
+	(
+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		GIT_COMPLETION_IGNORE_CASE=1 && export GIT_COMPLETION_IGNORE_CASE &&
+		test_completion "git checkout M" <<-\EOF
+		main Z
+		mybranch Z
+		mytag Z
+		EOF
+	)
+'
+
 test_expect_success 'git -C <path> checkout uses the right repo' '
 	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
 	branch-in-other Z
-- 
gitgitgadget

