Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5011FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 18:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbdBFSZz (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 13:25:55 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35629 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbdBFSZy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 13:25:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so23474350wmu.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 10:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o2R5YT13yr5WRQRQJmM3o8aRmGHuIdWAzuAoMsjsYaQ=;
        b=dRYm6kaZkxmUmfSX9aRpX5oIBoVQoSUb5j6C8JbXH5uUbFwQoW20/9lDYi2G8X8113
         no08S7VDS7i3oIGo3ypoBGDw3PKUc4CBZaAX/bTeGAXVsjQH0mfOPR9wDDmjerQQ6azb
         0UCf1YS683e7g/dFjA4xfx0KsXXpqnqTDQmtNuCaTU+WGElhazrBjrSNZTC2J7Sy1fgN
         OW0NhgCnwzow12oJhjR1jcf0JYobvrBRWYKl9o/NLHb31UGBkZepdcsLWzZmFKdaC8dN
         SMNnRFQydWkgNi0WcmTZhUKZrVR8px4ugXONhFLFonIpjgmMCKTsbkLYxm1HlRonHa7l
         JM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o2R5YT13yr5WRQRQJmM3o8aRmGHuIdWAzuAoMsjsYaQ=;
        b=mgljpeyZQdObmPaYzBgiPatbwXpPWMZ2yaJEfZRWOCYwcRv1kY10Mp+8RnASTGmgvN
         R7lOE859wXz8e3Cn4vaZP3sxIpAXsbPhZ14wKQdwWQxm+PslcQTWIfVdDj4RKDLQJJ+Y
         LAHgT+DJatgCnc/qTNkYPNwEnmlv1v5HjgVx06ouw4BaNi1TAlyFWVFysAdNKd7meui5
         LqFUV2XB3R8pO0u3zulr9SvNLqd/cCDTp22tiWwMfxhBA5W6JyY4zlFeTV4v30SX0u2y
         RLa2R07xJCl1eaFMqDDSov7x51F5F95dkQwJIDFYE5i6ShBi+P5PT901/KgM60ibCo9S
         kwZQ==
X-Gm-Message-State: AMke39mrfWVysovTAZU2oZE+7LLeWu4J84LyNo5rEU1l9WzIISfcJ9VWncL7CArYhlxnhQ==
X-Received: by 10.28.125.22 with SMTP id y22mr10085971wmc.112.1486405553297;
        Mon, 06 Feb 2017 10:25:53 -0800 (PST)
Received: from localhost.localdomain (x590cf762.dyn.telefonica.de. [89.12.247.98])
        by smtp.gmail.com with ESMTPSA id a186sm14313308wmh.1.2017.02.06.10.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 10:25:52 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] squash! completion: fill COMPREPLY directly when completing refs
Date:   Mon,  6 Feb 2017 19:15:45 +0100
Message-Id: <20170206181545.12869-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.1.499.ge87add2e7
In-Reply-To: <20170203025405.8242-13-szeder.dev@gmail.com>
References: <20170203025405.8242-13-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Care should be taken, though, because that prefix might contain
'for-each-ref' format specifiers as part of the left hand side of a
'..' range or '...' symmetric difference notation or fetch/push/etc.
refspec, e.g. 'git log "evil-%(refname)..br<TAB>'.  Doubling every '%'
in the prefix will prevent 'git for-each-ref' from interpolating any
of those contained format specifiers.
---

This is really pathological, and I'm sure this has nothing to do with
whatever breakage Jacob experienced.
The shell metacharacters '(' and ')' still cause us trouble in various
ways, but that's nothing new and has been the case for quite a while
(always?).

It's already incorporated into (the rewritten)

  https://github.com/szeder/git completion-refs-speedup

 contrib/completion/git-completion.bash |  8 +++++---
 t/t9902-completion.sh                  | 11 +++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dbbb62f5f..058f1d0ee 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -381,6 +381,7 @@ __git_refs ()
 	local list_refs_from=path remote="${1-}"
 	local format refs
 	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
+	local fer_pfx="${pfx//\%/%%}"
 
 	__git_find_repo_path
 	dir="$__git_repo_path"
@@ -406,6 +407,7 @@ __git_refs ()
 	if [ "$list_refs_from" = path ]; then
 		if [[ "$cur_" == ^* ]]; then
 			pfx="$pfx^"
+			fer_pfx="$fer_pfx^"
 			cur_=${cur_#^}
 		fi
 		case "$cur_" in
@@ -429,13 +431,13 @@ __git_refs ()
 				"refs/remotes/$cur_*" "refs/remotes/$cur_*/**")
 			;;
 		esac
-		__git_dir="$dir" __git for-each-ref --format="$pfx%($format)$sfx" \
+		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
 			"${refs[@]}"
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
-			__git for-each-ref --format="$pfx%(refname:strip=3)$sfx" \
+			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
 				--sort="refname:strip=3" \
 				"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
 			uniq -u
@@ -457,7 +459,7 @@ __git_refs ()
 			case "HEAD" in
 			$cur_*)	echo "${pfx}HEAD$sfx" ;;
 			esac
-			__git for-each-ref --format="$pfx%(refname:strip=3)$sfx" \
+			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
 				"refs/remotes/$remote/$cur_*" \
 				"refs/remotes/$remote/$cur_*/**"
 		else
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1206a38ed..be584c069 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -951,6 +951,17 @@ test_expect_success 'teardown after filtering matching refs' '
 	git update-ref -d refs/remotes/other/matching/branch-in-other
 '
 
+test_expect_success '__git_refs - for-each-ref format specifiers in prefix' '
+	cat >expected <<-EOF &&
+	evil-%%-%42-%(refname)..master
+	EOF
+	(
+		cur="evil-%%-%42-%(refname)..mas" &&
+		__git_refs "" "" "evil-%%-%42-%(refname).." mas >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success '__git_complete_refs - simple' '
 	sed -e "s/Z$//g" >expected <<-EOF &&
 	HEAD Z
-- 
2.11.1.499.gb6fcc8b3a

