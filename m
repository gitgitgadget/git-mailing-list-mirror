Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83281C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 11:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbiBYLox (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 06:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiBYLoo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 06:44:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7861E14A8
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:10 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c192so1484251wma.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 03:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8WuEm8Tjtk+1I6YCswRn6XBkkxWwrEwlejq3nNlQ0iA=;
        b=aJpe+Ht0sliOn0B0hIYBP6Xyt+4byVfVnOA0Zlo49qx2qHZyjE9CnMirZnVwJ4FyHd
         u8yhgJkym8s83O0GAzOTZFuAspeX/yyD3VFitL0Gbyi2tXquU/DcV62sYOc7O9Cy1dZk
         qbr/qkd1fW+TIvgIvX93BnINa5zDmcAAFpsSTY6iECST05nOgmvhj5EAh+YkK5IpdXkP
         Pb6gRtRhXzksbZpkSTIqT8w6iESXWUjqeo9jhLuukvDvE++xfBMG6a2KH4Ni7s+UkrAg
         BlIdEkgbhCjnJNPEfcabt9NMqdgEIwIq5HTNdkUaiiswyYU5fiDJbU8DqdFgArtXcerY
         sR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8WuEm8Tjtk+1I6YCswRn6XBkkxWwrEwlejq3nNlQ0iA=;
        b=syfdUDiTdUkxgBGbn3H33SUW3RDMZ4u54awsp/o0hSJA+Vj+nMTT/mdsYK745/6c8p
         OS1Z329noEVyuhGw4Gzok8Hw/z+f4T6hbnXH3g5mdSVOOIjyT4kcL1DtIgkStunrO2P3
         +OTgtv3oE77dKoQy6ewGuIUKDJN+7W/zK6Ige2HLWSckx7VdVowotIGS7KFFBS4dSS9f
         95Z2AuHKRksaWSEnOwvx2Uqp1VdXqgZSsN/BnTe7shapYJlvBA1ER5IV+lnwA4SlY5Qe
         18h9SP8FJRrShOZTCG7eh9M/S7ovOcdIX3uRLzrNoMjhtZ5TgVItV3vJ+DoR/IKo4VrP
         KiXg==
X-Gm-Message-State: AOAM531xtBd3GUJTVy/J4MK4fn1yZ005GJXwCWzusFctAvUdBB9ntPXj
        Anf8tn3f8xwtAurJizHbUTF88hTdo8U=
X-Google-Smtp-Source: ABdhPJyv0bmMegNeAasJM1VbvI+q7z2Q3u8U2cj76GrlQHnIlVSUKWvFRV0k4DvhPsbC9V1p/3x6Zw==
X-Received: by 2002:a05:600c:2e47:b0:37d:62d7:24bb with SMTP id q7-20020a05600c2e4700b0037d62d724bbmr2376134wmf.71.1645789449099;
        Fri, 25 Feb 2022 03:44:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5250080wmv.31.2022.02.25.03.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:44:08 -0800 (PST)
Message-Id: <b503cac5ae3e89aa7b6f996567a5d7b4d2a05d29.1645789446.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 11:44:04 +0000
Subject: [PATCH 2/4] git-prompt: make upstream state indicator location
 consistent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Justin Donnelly <justinrdonnelly@gmail.com>

Make upstream state indicator location more consistent with similar
state indicators (e.g. sparse). Group the short state indicator (`=`,
`<`, `>`, or `<>`) with other short state indicators immediately after
the branch name. Group the long state indicator (e.g. `u+2-1
origin/main`) with other long state indicators after the short state
indicators. Previously short and long upstream state indicators appeared
after all other state indicators.

Use a separator (`SP` or `GIT_PS1_STATESEPARATOR`) between branch name
and short upstream state indicator. Previously the short upstream state
indicator would sometimes appear directly adjacent to the branch name
(e.g. `(main=)`) instead of being separated (e.g. `(main =)`).

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
 contrib/completion/git-prompt.sh | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 3997e099aa7..613389a53bc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -109,7 +109,7 @@
 __git_printf_supports_v=
 printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 
-# stores the divergence from upstream in $p
+# stores the divergence from upstream in $p (for short status) or $upstream (for verbose status)
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
 {
@@ -214,26 +214,26 @@ __git_ps1_show_upstream ()
 		*)	    # diverged from upstream
 			p="<>" ;;
 		esac
-	else
+	else # verbose, set upstream instead of p
 		case "$count" in
 		"") # no upstream
-			p="" ;;
+			upstream="" ;;
 		"0	0") # equal to upstream
-			p=" u=" ;;
+			upstream=" u=" ;;
 		"0	"*) # ahead of upstream
-			p=" u+${count#0	}" ;;
+			upstream=" u+${count#0	}" ;;
 		*"	0") # behind upstream
-			p=" u-${count%	0}" ;;
+			upstream=" u-${count%	0}" ;;
 		*)	    # diverged from upstream
-			p=" u+${count#*	}-${count%	*}" ;;
+			upstream=" u+${count#*	}-${count%	*}" ;;
 		esac
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream_type" 2>/dev/null)
 			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
-				p="$p \${__git_ps1_upstream_name}"
+				upstream="$upstream \${__git_ps1_upstream_name}"
 			else
-				p="$p ${__git_ps1_upstream_name}"
+				upstream="$upstream ${__git_ps1_upstream_name}"
 				# not needed anymore; keep user's
 				# environment clean
 				unset __git_ps1_upstream_name
@@ -512,7 +512,8 @@ __git_ps1 ()
 	local u=""
 	local h=""
 	local c=""
-	local p=""
+	local p="" # short version of upstream state indicator
+	local upstream="" # verbose version of upstream state indicator
 
 	if [ "true" = "$inside_gitdir" ]; then
 		if [ "true" = "$bare_repo" ]; then
@@ -568,8 +569,8 @@ __git_ps1 ()
 		b="\${__git_ps1_branch_name}"
 	fi
 
-	local f="$h$w$i$s$u"
-	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
+	local f="$h$w$i$s$u$p"
+	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
-- 
gitgitgadget

