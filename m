Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5347CC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 00:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiKUA1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiKUA1S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 19:27:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F82CE19
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:27:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r126-20020a1c4484000000b003cffd336e24so6945830wma.4
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmRuTVICk8NlvCbkCdosgMtD0Sefwu6FrJPT1Qm1TwM=;
        b=VkJ4XB1SL+10wMcbB+AxJH7uEgGl6SYum2ey+b111SjFFInYHYS0ID4sdBEcauJhSX
         yi5Zjf/mTSglk213n4xr+FvW4OO20bp2qPIbBzBfRKFrzzocI+5HFCWAML7Q2nYfVv1k
         uxXLFgcKSlCLp9n0/gjzAUYjn8hkmi8QWl9mWOw5KjgxkvnDHpDkdZfZs/2VUX+fSNRm
         uR+ba/IFxgK6DtZfQgnL+IOjOrjkDKJokJnDSYAA1TeunyhVNmNiQIDM+tFR2pPp+Pd3
         dsE6tXRoxKy0c7h0ABNs3ZqAY9ooM4cuTTuXuE9QxupX301pS9lmeyUJP3W8Ok+NG0KW
         DVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmRuTVICk8NlvCbkCdosgMtD0Sefwu6FrJPT1Qm1TwM=;
        b=g/URlSdO6uoFaP1I6mHKLI2IMmhx3fat2cfDrWHQOhCfDonno+127Iqiw2O3DH/I1A
         0zMz4EInleqGsPK/yUhM8JF6SdhssUApSwx/icYOkUvk795fIMOI3CfEbpPgxa5cHxuC
         I2KFI91OPmMeMmR5Ab65O3XPz45/EuGd7PDjKDSY3Je/6EKD+7gC5YNZeid0vvgAVmRQ
         334F8z47iyNkJTX5cjJ7KxnwoRjInRfmVtxKhizYgaU7BRS3UZXGi1OXj1OT0ZhEhqpu
         8ifj6D2WCqoyre7a48wU+ykTK1RIO0F0r/9Jpm83W5NvESrdrv9/xr5TK0XnpT8/LWyJ
         8uHQ==
X-Gm-Message-State: ANoB5plaEhFr19dFA9EmeXXdKRIupsxfZYnE1G3eQYaQiQODa6v7LisG
        xFlULRVYu4UDLzdc/mq46f5bbVZDuyU=
X-Google-Smtp-Source: AA0mqf4qEMLx2MM7C5dUWoEAmZw8cSfAU1L1DNNqrjkUzp5E6n0TEnvafd36c4lQa9UIr2XbsGqwEA==
X-Received: by 2002:a05:600c:35c7:b0:3cf:7dc1:f432 with SMTP id r7-20020a05600c35c700b003cf7dc1f432mr13983453wmq.148.1668990422787;
        Sun, 20 Nov 2022 16:27:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003c6b7f5567csm24767583wms.0.2022.11.20.16.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:27:02 -0800 (PST)
Message-Id: <480f6554c9361781ecee9067b85eb33d7189e5c6.1668990419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1374.v2.git.git.1668990419.gitgitgadget@gmail.com>
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
        <pull.1374.v2.git.git.1668990419.gitgitgadget@gmail.com>
From:   "Alison Winters via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 00:26:59 +0000
Subject: [PATCH v2 2/2] completion: add case-insensitive match of pseudorefs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alison Winters <alisonatwork@outlook.com>,
        Alison Winters <alisonatwork@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alison Winters <alisonatwork@outlook.com>

When GIT_COMPLETION_IGNORE_CASE is set, also allow lowercase completion
text like "head" to match uppercase HEAD and other pseudorefs.

Signed-off-by: Alison Winters <alisonatwork@outlook.com>
---
 contrib/completion/git-completion.bash | 14 +++++++++++---
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7dcf4b63562..dc95c34cc85 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -722,6 +722,7 @@ __git_refs ()
 	local format refs
 	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
 	local match="${4-}"
+	local umatch="${4-}"
 	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
 
 	__git_find_repo_path
@@ -745,12 +746,19 @@ __git_refs ()
 		fi
 	fi
 
+	if test "${GIT_COMPLETION_IGNORE_CASE:+1}" = "1"
+	then
+		# uppercase with tr instead of ${match,^^} for bash 3.2 compatibility
+		umatch=$(echo "$match" | tr a-z A-Z 2>/dev/null || echo "$match")
+	fi
+
 	if [ "$list_refs_from" = path ]; then
 		if [[ "$cur_" == ^* ]]; then
 			pfx="$pfx^"
 			fer_pfx="$fer_pfx^"
 			cur_=${cur_#^}
 			match=${match#^}
+			umatch=${umatch#^}
 		fi
 		case "$cur_" in
 		refs|refs/*)
@@ -761,7 +769,7 @@ __git_refs ()
 		*)
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD; do
 				case "$i" in
-				$match*)
+				$match*|$umatch*)
 					if [ -e "$dir/$i" ]; then
 						echo "$pfx$i$sfx"
 					fi
@@ -795,7 +803,7 @@ __git_refs ()
 	*)
 		if [ "$list_refs_from" = remote ]; then
 			case "HEAD" in
-			$match*)	echo "${pfx}HEAD$sfx" ;;
+			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
 			esac
 			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
 				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
@@ -804,7 +812,7 @@ __git_refs ()
 		else
 			local query_symref
 			case "HEAD" in
-			$match*)	query_symref="HEAD" ;;
+			$match*|$umatch*)	query_symref="HEAD" ;;
 			esac
 			__git ls-remote "$remote" $query_symref \
 				"refs/tags/$match*" "refs/heads/$match*" \
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d89d0a93a2a..d6c0478d98b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2270,6 +2270,21 @@ test_expect_success 'checkout matches case insensitively with GIT_COMPLETION_IGN
 	)
 '
 
+test_expect_success 'checkout completes pseudo refs' '
+	test_completion "git checkout H" <<-\EOF
+	HEAD Z
+	EOF
+'
+
+test_expect_success 'checkout completes pseudo refs case insensitively with GIT_COMPLETION_IGNORE_CASE' '
+	(
+		GIT_COMPLETION_IGNORE_CASE=1 &&
+		test_completion "git checkout h" <<-\EOF
+		HEAD Z
+		EOF
+	)
+'
+
 test_expect_success 'git -C <path> checkout uses the right repo' '
 	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
 	branch-in-other Z
-- 
gitgitgadget
