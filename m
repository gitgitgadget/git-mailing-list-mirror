Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3088CEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjFZQ0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjFZQZM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05C10FD
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313f18f5295so1447799f8f.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796708; x=1690388708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JTdQ2NWPSp258UEl3diI/yXo+Xjk81rWq6f7dFM7kY=;
        b=IaB9nljE7EmWGJ5JQmSMlX6Dl3Ot8VCnlbZRzHTCfaaVWOyPtk6Jd6eYquTFNGZePC
         CvNTaMP5VAeBaaWSkybyJxFDxfADb6m3r0Sr2c8Djzh0qOhGcypp3VWKPKjKtlFN9yAU
         joe6efAIzy7e+5zCW6ZoE97uNnF2WwH5Tg6yH7N0kf9WStg9jbEz7FhdH9TdFbxXghyq
         DJC0hfcq/NnEuZ9v/xVY5WVn8LoG5AWNs3QG383LIZYdgH4Klv2apfuXvE8YJzaYucUm
         l1lrJdy7YcD5DswmPNcS722JSDBV9sSaQfMcfgo2wEiLP1AE6GFLXdd5SE/dGYxtf1I0
         JPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796708; x=1690388708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JTdQ2NWPSp258UEl3diI/yXo+Xjk81rWq6f7dFM7kY=;
        b=P4QkZs1ra+G7Z+i4r7EzGAPTplfoVLBniOA12WiQSabhmsjLQiqxsnPeV7jq5Um8Am
         iTh0Nr4FX3SqYnN+dki35dvobNqGvk3cNontTauZCxcJuDAbM4/JHpelU4HM4CvRZZch
         ZwUyWU2N4BcJfE7WRCmfI+ZL556gRN5xOJ3ceIXRVX+xB3eJ6DGU4Ys7FqZRvsq2Ef0q
         ps6fG4wT6hQ6u/p+fiiISz3wVlFGDOnrWmhNXB/rs2VeGu/TRfWD7ybTPPeA+FUNg/Ua
         +ArHyN9ORVKf1X6mNNoZakWNAlW2djQrOnTqommmx3sUVJKzwLhjuOM7Lw50PSWfp9RR
         5xhA==
X-Gm-Message-State: AC+VfDyCINPfkUx3/i3+bqnp5PuijSELrdCorOGd4AyioG0tHh4Z7d7b
        xH8a3IieksG9cOqNVn4Nrru97/jXQVY=
X-Google-Smtp-Source: ACHHUZ59TTfTCRvTvyEicEq/ea4hX3i5Z3/dHCG92+QHGnHOn3OV58oafOY7aN3oUIILnwjeBjh+1w==
X-Received: by 2002:adf:d088:0:b0:313:eec6:77a1 with SMTP id y8-20020adfd088000000b00313eec677a1mr3737842wrh.71.1687796707794;
        Mon, 26 Jun 2023 09:25:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003fa82210e7asm8282543wmr.14.2023.06.26.09.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:07 -0700 (PDT)
Message-Id: <fb23869dfbb6d7846322bd69a78ab4118b5af3a7.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:46 +0000
Subject: [PATCH v3 22/24] completion: complete --diff-merges, its options and
 --no-diff-merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The flags --[no-]diff-merges only make sense for 'git log' and 'git
show', so add a new variable __git_log_show_options for options only
relevant to these two commands, and add them there. Also add
__git_diff_merges_opts and list the accepted values for --diff-merges,
and use it in _git_log and _git_show.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5b8e7b810c8..8688f7c433c 100644
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

