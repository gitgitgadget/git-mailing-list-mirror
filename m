Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B02C25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 11:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjAXLX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 06:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjAXLXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 06:23:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264330B29
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 03:23:24 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so12606941wmb.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 03:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgRiLqjfVWE05Ob4hhY8FHeK/8h4bNIU2GMvmGOMisQ=;
        b=INiFHo8+nORxldOCIg/4XpuM/iTMFpfaD5+bdRFEXmLyUyh2tOalp+4vfP59dD0LEq
         80s9Kt7cxU04FIDa83kf+pZq/hIqtXVlOoKijcS5BXhp/6jPxcAJyvjHzfpEsNTlZymi
         2sMsWQ3AMawvdKJHi9s/Zss9uCrGiv4Y5eztlhUT5YMDKtLWslbzmcx2qAiPk3/B9Ji7
         6yhCeQ5VkWnOkKHZ0jtvruFTRK+XjFWD8oBrDXkQ/5AFsaZV2NLRGkFguGDs3BuC3STw
         JDS0usbK0O3nDDx4PV899cklzEmP6gAPygwKocpPaH5IUpp1p/5dMZHvvUddKZaFfB5d
         d/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgRiLqjfVWE05Ob4hhY8FHeK/8h4bNIU2GMvmGOMisQ=;
        b=z/aRETomP5//shZMhCziGluaaprT+4HKcNYFm+uKD8nLBdAQ6aUkimmlqDZaP98c8m
         BCnARAW1ITgb+fawajVkoVx9QVLo1G7FObwR8GiGukkd26PmeyxuCckZzxZxsoX2mEmf
         YSx0sM3fr8BNmgcPnVut1Dxk3MLo15c/vfHZ3Q69czS+RyJrHB1QbBzzFe3JmvNATj2P
         27apwwNH+he6CYGZzZN5UYUlKTBrlR+XaC0zw6mAkNmxtLV58i1p5UpqziYt8T0XDTdL
         oazlZik/ITiHdxwPxQezy0j8ynQUQmxckTvWxry48Qdp8cOeempXRtU8lLIPB22nr8D0
         M+KQ==
X-Gm-Message-State: AFqh2ko1BUfG5GvRbzsaHO9uGAcKHfZWdy8dCjKLMW4iI4nDmD7mKyv8
        JfYOmeKHj/gmjVQz/e7MYaFIZD0+8MM=
X-Google-Smtp-Source: AMrXdXuLV9h6fcUSzSrpk7cNjJIHewu9wmz3eoxsBK6k3KJwgEF3AmwDIM9wGBSHf4Uj3W3OdwLbmw==
X-Received: by 2002:a05:600c:b8a:b0:3d9:f806:2f89 with SMTP id fl10-20020a05600c0b8a00b003d9f8062f89mr27407241wmb.41.1674559402547;
        Tue, 24 Jan 2023 03:23:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b003d9ed40a512sm18211936wmb.45.2023.01.24.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 03:23:22 -0800 (PST)
Message-Id: <ff22dd238e9ea6c540eb1083d3b56a7bd804580f.1674559397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
References: <pull.1469.git.1674559397.gitgitgadget@gmail.com>
From:   "Nico Rieck via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Jan 2023 11:23:17 +0000
Subject: [PATCH 2/2] gitk: escape file paths before piping to git log
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nico Rieck <nico.rieck@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nico Rieck <nico.rieck@gmail.com>

We just started piping the file paths via `stdin` instead of passing
them via the command-line, to avoid running into command-line
limitations.

However, since we now pipe the file paths, we need to take care of
special characters.

This fixes https://github.com/git-for-windows/git/issues/2293

Signed-off-by: Nico Rieck <nico.rieck@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gitk | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 92375ca6a2a..df3ba2ea99b 100755
--- a/gitk
+++ b/gitk
@@ -353,6 +353,16 @@ proc parseviewrevs {view revs} {
     return $ret
 }
 
+# Escapes a list of filter paths to be passed to git log via stdin. Note that
+# paths must not be quoted.
+proc escape_filter_paths {paths} {
+	set escaped [list]
+	foreach path $paths {
+		lappend escaped [string map {\\ \\\\ "\ " "\\\ "} $path]
+	}
+	return $escaped
+}
+
 # Start off a git log process and arrange to read its output
 proc start_rev_list {view} {
     global startmsecs commitidx viewcomplete curview
@@ -414,7 +424,8 @@ proc start_rev_list {view} {
     if {[catch {
         set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
                         --parents --boundary $args --stdin \
-                        "<<[join [concat $revs "--" $files] "\\n"]"] r]
+                        "<<[join [concat $revs "--" \
+                                [escape_filter_paths $files]] "\\n"]"] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return 0
@@ -568,7 +579,8 @@ proc updatecommits {} {
         set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
                         --parents --boundary $args --stdin \
                         "<<[join [concat $revs "--" \
-                                $vfilelimit($view)] "\\n"]"] r]
+                                [escape_filter_paths \
+                                        $vfilelimit($view)]] "\\n"]"] r]
     } err]} {
         error_popup "[mc "Error executing git log:"] $err"
         return
-- 
gitgitgadget
