Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBACC7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjFLMyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjFLMxV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1241C7
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so3136301f8f.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574394; x=1689166394;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTV/QGooK/Fs8DIMFzZgdolL5AI/0j0Y2a2G2WOtxQw=;
        b=SR4X5Wd+r5c7DISfBhofHK/PTieCBBbcCRvaT2/O1hWeagq6wrKqnv3BvdTCSaTSKQ
         +YM2jB8Ev3RSbAHGi77IhEqLqXWfy8HTHVxXRPLS+wvVnPsIU+dfazpptJruSFfdJRpG
         VMBQm1/O95awK5sczYhJpag8WX6QZ2buWZmaw9bYFoqg56wZcjaxrLnCFNnH4JIGsOMX
         FN1PrDUkci86mgGid51nE/hr6pyFBsIEpO8Lh5GpNlmTpi3hzgQj2lwDO7qWRHjR6Uk8
         M/Xlk8dybIN0yhU3cpIbHOQ1JfYM0BSB1WLz31lS1+8KAJcIhD0KA9HGGCW7aHOEQtoT
         X3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574394; x=1689166394;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTV/QGooK/Fs8DIMFzZgdolL5AI/0j0Y2a2G2WOtxQw=;
        b=iQuynNsKD5ijnmiOWDtrI3mvyy8g42CTqaquaWRhsftwUJDDf/Y96bsSqerM2CNe5z
         HEG7efFqyKOCCVJKpkWBlY8g653AT/05VyGtt+09EW9rKQoZ2WOajbZLwyAE2QbQKi08
         I9NjocBjxRjXi9oKwM3fnKLsDKchW0NfcCpAnVh1VaXI9Cm1HQV38oRFMGF6eoNS9LJ+
         ulSY69bwg+j8pT88XQjSTLi7Gb+oJ1Iu23/FGxQVo1OcRswpDdsFv9oz4leVuJhLPjUB
         jm2A5YSUJXrTsm33JRPUgXo6vXLqr8eox+wiTqNS+VDJ20jQdGfsRn/R9YTbROSubxfs
         C2oQ==
X-Gm-Message-State: AC+VfDzBJrPccRt97HRmAdy7JgIPq1rdwaidPIKKIJmg1c8dVaCD6SU6
        BqQbHA7834pTFF3X5FyBexvG+7qDhW4=
X-Google-Smtp-Source: ACHHUZ6sf/N3hjH1ravuy4NaYokhw3f9PQcZ3FIP0iQbq6ZyQiT1x1YtW9fAXWyuacFV3Okjc/2L1w==
X-Received: by 2002:a5d:68c1:0:b0:30f:b950:4a5f with SMTP id p1-20020a5d68c1000000b0030fb9504a5fmr4131605wrw.13.1686574394086;
        Mon, 12 Jun 2023 05:53:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17-20020adfee11000000b0030af05fce4dsm12494649wrn.77.2023.06.12.05.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:13 -0700 (PDT)
Message-Id: <808e7db20cf92991ac4c61355bd4b22bcdeefd3f.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:51 +0000
Subject: [PATCH v2 23/25] completion: complete --diff-merges, its options and
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

