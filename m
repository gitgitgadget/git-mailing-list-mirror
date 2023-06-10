Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690BDC7EE29
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjFJUWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjFJUVr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0F3AA8
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30af86a966eso1965212f8f.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428501; x=1689020501;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no+EASTPSN3Pq0YxPdiIJzmY/HwfxJjHV5gqh+mmDmY=;
        b=PXwa+nsre9mPmSCCzSnxj1dKf8OMAIyvXVBaS0UaB0AZroW9WDXn1nlEHSWjmeMFEQ
         pdn+kXpR1vqeGXCHwOW9PnJLQPY5rUiqo8c026QCpCnQhr7uz1zep4q8t5fOm2OWI4KL
         uJ/NrfhHt0LpRpFsvG8xQbA6jGO3mkPSKluFKaggLGDsc5jYxIAJkoMJCf/tm9k08CaV
         En20dI+Nbb+Z3bVTF2QURSbVfZkvG4nz2Bolj3/OnxyILBkQVDsxdM1cA1K3wMnsStLG
         8uHoBXZPfuLuxcCWwO9hts17a3GnaTS7FriQbOIVSSblIoqN7N5ful6LKtlbtmM/4YJO
         65Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428501; x=1689020501;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no+EASTPSN3Pq0YxPdiIJzmY/HwfxJjHV5gqh+mmDmY=;
        b=IQWB82daswVQraf56vf8faAADw5Fu19E9LGZfhiNsavveZRSG9rZ4OTX3CiB+IsFHW
         BcM8Xu0eexjN01AlLGrWzQLyH6AHFmBLuIg5DxkId8liEHczGNVIRUsDvumQ7iox1XlC
         gIlA6wa4RvULh7VfIsCZf1PIf8/Y6PK0st1aeF2dhKGQl7uKl4RZ2na/tGVK/pAThN2Q
         E306ykdENy0vUu4RQmZTIGzi1ZL7RDK2vSXBo5+UDOJEXsZD7yVltK8jrr+u7QBD/YL3
         9Rq7wVv8UqOAilyM70hlTzhLUNNU3LD5w1u09+A6GTh1oDo09gVpoT+q1dp2jSJm6SIB
         QyiA==
X-Gm-Message-State: AC+VfDwwEYSNcSQvObwqSQPHwW9iQQ6CueMoZE2uBMbSOtGDrEoaHWI+
        k4Oe1KdEmmdxSyX90/ongrZ/IlJPBkA=
X-Google-Smtp-Source: ACHHUZ5a5gV0fK4mtsmn140igmOM3hQngCQIVT8o+sP0iKBCHdGIv0aPoaMp04Q1NjZOj/S6wAMlkg==
X-Received: by 2002:adf:f549:0:b0:30d:981d:a03f with SMTP id j9-20020adff549000000b0030d981da03fmr1201975wrp.6.1686428500806;
        Sat, 10 Jun 2023 13:21:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020a056000136b00b002f9e04459desm7793212wrz.109.2023.06.10.13.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:40 -0700 (PDT)
Message-Id: <f8246a2a581f3bb1e424da6f2cf6d8f5b377f2c6.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:20 +0000
Subject: [PATCH 21/25] completion: complete --ws-error-highlight
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <philippe.blain@canada.ca>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <philippe.blain@canada.ca>

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
index 230d5807860..93522558a98 100644
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

