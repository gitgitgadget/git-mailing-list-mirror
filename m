Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2472BEB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjFZQ0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjFZQZL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACB619A1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9b0f139feso49481665e9.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796706; x=1690388706;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwgY2AGteHZG2EkyiDUfvLjblf5wid0dLJwBnM5AEzs=;
        b=LnQRAdMLyy1QXouvE+Plz09ZWeV+s/UIg9Th+e5MiTyJvokGXHulX52VZ+DmpBvbek
         Ot4v5ZkX4j6epuPQd3Tpl7JtOPGCkFdVBNhpAGuM/EOvHrY8FFXg72RJJx4VESiQKRyG
         QbHJ53kD0OG26jPdtFJPPMJXYRq2frf1Ssb1NuQBl3ZJMl8QZlcq66NTraZkNOLhGtQE
         2AtocpgAfZbrfl5d/b0rwPv0fpT/fn2s4EhyfykRugcwEa7kvzD+0QXZsoYFOw+G+dIi
         +JWG5+TNXlGKP8T8lD0HJHwAbrdBlt3pzhQOjvO06dfeLNxh2UX3b6DBvuMM1dIzjIOE
         XCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796706; x=1690388706;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwgY2AGteHZG2EkyiDUfvLjblf5wid0dLJwBnM5AEzs=;
        b=A7sTPU3+g+stic5gPheyeVJ6eLT2wbxAWoCIG79zj+xUUHxgIgAJx8mJZJvx9EEWFy
         SxqL05PvGF4t0ghlWvKca3l5mwQbFLah8Wdo+9D8XArm+3c2tF4Lq6SIoYRuKJeckIqs
         K8rSsfpruCcrkUpBp61GB9jbRs1EktDNZzAb5JpZ1OaZxM7P1K/QCiVYirs7f9sK/y43
         +9CkMNF+o/q8rgD0PbttExpra89LHubDB+PuvvjfLKAp/87U9c0c1z6OMoLgOpY3CC8l
         VgixMleTh65ePi+1gMzFjAWaQ2wrw8jh1OtK1wiwGS+aegWViJEkEMqwp+iPqWAjjT/7
         7EaA==
X-Gm-Message-State: AC+VfDykhPbJ/jL44cDMRZi1HXuRSy3WEX2qWD0pY7CDSX9AlNFzYI2R
        SLEdOpBKnhHoIJwWMqaOpcnt5jIuA7w=
X-Google-Smtp-Source: ACHHUZ5jYovs5lXgbR50PJfFeYUp18Ml7LsBZj3pL8eG10aj8AtlTnUOTTytOiFwY65cFH4dx44Xtg==
X-Received: by 2002:adf:e684:0:b0:30e:412a:841b with SMTP id r4-20020adfe684000000b0030e412a841bmr23574728wrm.37.1687796706136;
        Mon, 26 Jun 2023 09:25:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c024e00b003f8d770e935sm11213666wmj.0.2023.06.26.09.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:05 -0700 (PDT)
Message-Id: <4750951f1209b6c8fb1e84e00dcf4072b051a418.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:44 +0000
Subject: [PATCH v3 20/24] completion: complete --ws-error-highlight
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

Add --ws-error-highlight= to the list in __git_diff_common_options, and
add the accepted values in a new list __git_ws_error_highlight_opts.

Use __git_ws_error_highlight_opts in _git_diff, _git_log and _git_show
to offer the accepted values.

As noted in fd0bc17557 (completion: add diff --color-moved[-ws],
2020-02-21), there is no easy way to offer completion for several
comma-separated values, so this is limited to completing a single
value.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7babd95d844..9de33ed05da 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1733,6 +1733,8 @@ __git_color_moved_opts="no default plain blocks zebra dimmed-zebra"
 __git_color_moved_ws_opts="no ignore-space-at-eol ignore-space-change
 			ignore-all-space allow-indentation-change"
 
+__git_ws_error_highlight_opts="context old new all default"
+
 # Options for the diff machinery (diff, log, show, stash, range-diff, ...)
 __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
@@ -1790,6 +1792,10 @@ _git_diff ()
 		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
 		return
 		;;
+	--ws-error-highlight=*)
+		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highlight=}"
+		return
+		;;
 	--*)
 		__gitcomp "$__git_diff_difftool_options"
 		return
@@ -2080,6 +2086,10 @@ _git_log ()
 		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
 		return
 		;;
+	--ws-error-highlight=*)
+		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highlight=}"
+		return
+		;;
 	--no-walk=*)
 		__gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
 		return
@@ -3000,6 +3010,10 @@ _git_show ()
 		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
 		return
 		;;
+	--ws-error-highlight=*)
+		__gitcomp "$__git_ws_error_highlight_opts" "" "${cur##--ws-error-highlight=}"
+		return
+		;;
 	--*)
 		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
 			--oneline --show-signature
-- 
gitgitgadget

