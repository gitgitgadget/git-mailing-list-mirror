Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F728C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjFLMx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbjFLMxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD56D170A
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30aebe2602fso2807826f8f.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574388; x=1689166388;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt8z2AJxzEwQlYNmo0GCQyhARur9AC9HnVyQAJFP+Ho=;
        b=AN+8sqldy8RBfmonsKEp2PSeByLcqlOjP/keD/gwvn996FPm+Pxj96llkqnHJ03GXe
         1xYVCMHcX+N3HoEIhhGqjCGhBxGJrBu+ZIs0kpMBzG7m3aa+oayMiipueKBR//5j0Xtr
         PDZMNoOba8fIX8v2xOdGK7fd0CgENR1dFcL9U/SblB/gbh6A9pUXMCZHfwbKvTAkjzrh
         vkEszJZVPU5b1Eo/KJEaBVfGJOMTdxq/1ntl8vkmvce2s4oN5F/Y4aGZnrD/VjVIxifH
         ypYPtvOXmmudngJdDo6iZ3dK8j1k66cAj87x7QBy5GLZMDSFYVMhCaQDYm089YuGgbJv
         OfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574388; x=1689166388;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vt8z2AJxzEwQlYNmo0GCQyhARur9AC9HnVyQAJFP+Ho=;
        b=gtUs0RzdS6YVGVedTnojMZxlsw64W7lWtuLP9o76vv5lVghaFLv9U25JNe+cEKnkhr
         U7RRlj/inYlwH59lvxYZhI9+lUrswgYD7Hs/jbrfQPZhusHYjysz2OIFaLUmVj6lN6vx
         kIO3R8gHOr6GFT8pbbEwkkD7d/5csSv2D1myZYkzaZ7qoHleKMNtWGtL6P7LdzgY7FYs
         IcIefDXAvXynK9UdrdpsFWiGfmeRaLK+dAg1OczWDKqGeEoOTIfjge842/3C9Bv7OzQI
         5+Q8bkAl5SK1sc3OsMhzvI/aZWLFVdbE+UVntSmH3zJ85e9GWEfThbbXCNURTlX1GjTB
         ++OA==
X-Gm-Message-State: AC+VfDx5z8ilNowvubzYSfuU8ymqvecSx5T1WgDIO2nbdWuDDwaelKm7
        DbkPIeVKaEa6794ASv+y4kJSs6Y2UlQ=
X-Google-Smtp-Source: ACHHUZ420+pc7gyFixXX72G5VbkiB11WfBjfVlc5KC/Lf4ThVmpH2JWSD05qQllUVjjUw13yFqcuWQ==
X-Received: by 2002:adf:cd05:0:b0:30a:e9a9:a4e4 with SMTP id w5-20020adfcd05000000b0030ae9a9a4e4mr3713804wrm.51.1686574387935;
        Mon, 12 Jun 2023 05:53:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb51000000b00307bc4e39e5sm12375846wrs.117.2023.06.12.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:07 -0700 (PDT)
Message-Id: <d3242e1f949815e6c2c036146da2f5faff92d94f.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:43 +0000
Subject: [PATCH v2 15/25] completion: complete --no-relative
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

Add --no-relative to __git_diff_common_options in the completion script,
and move --relative from __git_diff_difftool_options to
__git_diff_common_options since it applies to more than just diff and
difftool.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 13d6730f33d..f4e773cb997 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1741,6 +1741,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
 			--find-copies --find-object --find-renames
+			--no-relative --relative
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
@@ -1762,7 +1763,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 
 # Options for diff/difftool
 __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
-			--base --ours --theirs --no-index --relative --merge-base
+			--base --ours --theirs --no-index --merge-base
 			--ita-invisible-in-index --ita-visible-in-index
 			$__git_diff_common_options"
 
-- 
gitgitgadget

