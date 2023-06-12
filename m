Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054D8C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjFLMyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbjFLMxV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8D41982
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30ae141785bso4021920f8f.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574392; x=1689166392;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbrDtTjoEqA3u0q9ubX/UT1d0EZ/dvmiutFWXqSihBI=;
        b=AUrsiIYtikYhb/tuiwRS0HDQstPKlWvWolyjIhM7WKQWFYymAr1P+aSlbU8u41oudz
         DzVPDMRIHblZiC4A0oPoL1lssFccTg4l2YK47lnXeuY1KjqYyKCTO7jNRY3zJHOhxWXn
         hpQswxWkX/sHA2B+C9fpLjLEOq8t6KT7VBwWTBiPgS9owiBNr3cjfhVnRo72NKDXqHRv
         KPuHnkC/CVCVZIuE40py7N84SOx3IJaM398TW3RXhIoUDPz3rZQReDFOfl3higugkH2W
         vGoXkWUVVMoSLT/kzEZw2gfln/uiLJ1XvVIT7f8fwiOnWcg/YLyf2oLjPmDhujWc6G/9
         1j2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574392; x=1689166392;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbrDtTjoEqA3u0q9ubX/UT1d0EZ/dvmiutFWXqSihBI=;
        b=IMUwG93apUTpyhG40o1hayk5qWqifICR7lDE/lhFg5+/8hIrEkFinG2HstRWIPApUa
         9m0RfkqAOPv6ykRfVhQOwMFS8KzTPbBB7+lkGEnp221dRmsjiDpzNyM5QWgrzH8shZIa
         3hUoMJ49gv8zNGX4JN1DoAkzTmHYWMRZfpYSqIogqm11e91mEN/DWSw9UCv1hCaOs/2U
         2QEFFjv9PhjNoXznU/okE716F+D55j1TSJZZYSz0i1mkuyF+eUbnZ00bHzofkTXBH2lV
         fkIuU2Bm3QSzj7o5Iu+Drh/zf2JBBFMN0YQ08F5Y8nkQxdsFCBqWW8buORrySdeuTg95
         qzoQ==
X-Gm-Message-State: AC+VfDxv/r+0+iol8oCsY+e566G0KsUI4B+V1dKukkDgBeiMWrmKS5tx
        8DZW6s8f8sJhjzJFoq4+0oCh0V6y2lQ=
X-Google-Smtp-Source: ACHHUZ7MZtThMbnYncT0OVG4VRIiLPXmBHhbBHuPn6ml0cmgx7Dp+8pDMpnQYYOEBIkOv+IZ5bo6XQ==
X-Received: by 2002:a5d:5084:0:b0:30f:c601:4e0b with SMTP id a4-20020a5d5084000000b0030fc6014e0bmr1161638wrt.42.1686574392614;
        Mon, 12 Jun 2023 05:53:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0030fbf253c82sm3981313wru.104.2023.06.12.05.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:12 -0700 (PDT)
Message-Id: <c78650f215e6f651ac66add302014f145b7dfc3a.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:49 +0000
Subject: [PATCH v2 21/25] completion: complete --ws-error-highlight
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

