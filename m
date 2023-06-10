Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BADEC7EE29
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjFJUW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjFJUVy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCACD3AB9
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30af56f5f52so1940683f8f.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428502; x=1689020502;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpNh/zH78AgbjFvEF91/NI+i0cWull5Zhd51l90hePk=;
        b=oTUssyMfzD+ks0zZswJoWg1lZhO2PtXKSlrs8hOlwkiGoWhteIs1zq4WMQxaO1uQoB
         2ETZ6L+8j3cd+uoE6WqmxdhAx0nUEETcH/qM26s72L4EuSp14jQLDZLd1rlpTjacL8Ln
         zAq480GQM/jfQYJiFrFuhSwomfrrGiVDBZjgDrjTX9JZDq5r55kc2ANBc8fxcfctYdKI
         i5vQq6O3uxb+KuWd+QxqVaeoIH84owzHyxgEXYnntOKvcdKlE9AR7C313LHw7NEH+uO3
         qZJNgi/++hVJHg72zcJ+4epVOCnZ4av+R1+V4so3ewt0S8Zr8l714k8KEfc+SsWcuHuI
         QzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428502; x=1689020502;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpNh/zH78AgbjFvEF91/NI+i0cWull5Zhd51l90hePk=;
        b=WSInfJ3/PTUIscbjHNLo0gilhDDu8syThxlc2yBzdC9/yGj6jlqws3E8wWsmJQBL1+
         JhqFLNEWg1lG+hMB6E8cuAZsK04OVFLLihunsnLLees+OkWWQI3Kh795v68G5fh9u7CR
         TSHg/NzLaZzi8cjWxqztMv7504LaTt2IDIx5v9CyCajf10jVIZOUX237BXBNIQg+ztpz
         MO0xeuTxuKS7F/NBgstkgaXxfAM7sfpsMnRNhPILEDmqjkPjkdZDV8G2NKrreLWsmRSg
         fzHK2itPiAs+Ju2Dql55ZNlNAvRKDteoGmA6MB8vksT3I2QIn5OmhUaA3iN3xyw7cKbx
         CFeA==
X-Gm-Message-State: AC+VfDypRT/6PETdpGeIliF05GWn9hp4jqPIYw1Jh4Dd21YAEPnkuJIY
        ZAOJB0pRUTHhshzI/gq+Efj+eXMLANE=
X-Google-Smtp-Source: ACHHUZ76Y2HpqaKBZfLPxCgKXXZrNuBBf43sy/zE7CsAX7AtAPmX6C4Ct2VXq/RXSVvV1N4497qJIQ==
X-Received: by 2002:a5d:42cc:0:b0:309:32d1:59d8 with SMTP id t12-20020a5d42cc000000b0030932d159d8mr1481291wrr.64.1686428502075;
        Sat, 10 Jun 2023 13:21:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0030aee3da084sm7869719wrr.49.2023.06.10.13.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:41 -0700 (PDT)
Message-Id: <5dc1e541d1606807e188015ce51da4f2c7f8ff5b.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:22 +0000
Subject: [PATCH 23/25] completion: complete --diff-merges, its options and
 --no-diff-merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The flgs --[no-]diff-merges only make sense for 'git log' and 'git
show', so add a new variable __git_log_show_options for options only
relevant to these two commands, and add them there. Also add
__git_diff_merges_opts and list the accepted values for --diff-merges,
and use it in _git_log and _git_show.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8dd54fd3ae0..7b7f3f838e0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2040,6 +2040,12 @@ __git_log_shortlog_options="
 	--author= --committer= --grep=
 	--all-match --invert-grep
 "
+# Options accepted by log and show
+__git_log_show_options="
+	--diff-merges --diff-merges= --no-diff-merges
+"
+
+__git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
 
 __git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
@@ -2096,11 +2102,16 @@ _git_log ()
 		__gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
 		return
 		;;
+	--diff-merges=*)
+                __gitcomp "$__git_diff_merges_opts" "" "${cur##--diff-merges=}"
+                return
+                ;;
 	--*)
 		__gitcomp "
 			$__git_log_common_options
 			$__git_log_shortlog_options
 			$__git_log_gitk_options
+			$__git_log_show_options
 			--root --topo-order --date-order --reverse
 			--follow --full-diff
 			--abbrev-commit --no-abbrev-commit --abbrev=
@@ -3015,10 +3026,15 @@ _git_show ()
 		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highlight=}"
 		return
 		;;
+	--diff-merges=*)
+                __gitcomp "$__git_diff_merges_opts" "" "${cur##--diff-merges=}"
+                return
+                ;;
 	--*)
 		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
 			--oneline --show-signature
 			--expand-tabs --expand-tabs= --no-expand-tabs
+			$__git_log_show_options
 			$__git_diff_common_options
 			"
 		return
-- 
gitgitgadget

