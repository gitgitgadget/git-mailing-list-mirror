Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4C0EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjFZQZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjFZQZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5110FA
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3113da5260dso3017260f8f.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796702; x=1690388702;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt8z2AJxzEwQlYNmo0GCQyhARur9AC9HnVyQAJFP+Ho=;
        b=JRFhAZOdfMrlI9TUErATDbSPYL/rwg77i+hhNRyD2tHmyme/+LgrchjvXAH8hwm8n1
         1q6mJBz4AdX+Hf0hsPcpAAaV3ty+JhbqgvYmBV6FYYiFsAYIp4UV00rz3BBqmznufIgM
         DzPOhN2NaJUppxc0slSp94d+iSpec8Et7/j+tCBatwBARWCvGdzIuQ27PxoHaY9OojYj
         uOmdZk02Fp6KIK5oBmVobI6YBm+4rRFaTyodD0cyu5pYsaW/mkMNsoKrY4aXhXcvzdwm
         2riWx8/Bc8RFR0tcEHwm1jDhdGyoJWpGz9VOP8dYgL52dD7hkB4PSyXs4QBAR8eP5Hxk
         7VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796702; x=1690388702;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vt8z2AJxzEwQlYNmo0GCQyhARur9AC9HnVyQAJFP+Ho=;
        b=OwmkPYUqDaKzbx/VVchDvORS9VQ5oJpE2pBJ4v1A/lBW5LSq8gFCFbQAPj3wSnjQOE
         Dz+PcerPJfJ0MhQrHm9R5ahRvs+aV6YVoN8O11Q4AyVlXqI+PvCDWx2ck5XDAk6W1Ec7
         rBbvvPhZ3heMnFkLEBjwpQiGTU45ph9mP+Je5mj3/AoXXk9ePp1G5EYrlDqQJA3oI1rB
         ZZjTk04IOaW0BYKEFPzfJhWZ5KgMJp8tXdNPUSavzb8RnremC96G0l2k4V+xBdMEB8yj
         3wfppTnjmcjDu+zH+rHq7XW4Ai9Gk1vgTcD0q5HwgVtFDqXotYmEiBHjFevaJ9RKvsux
         H03A==
X-Gm-Message-State: AC+VfDwniGf79aO1oguUlFvcR78aXiAa8od8fg7c2U+7Y7qJH7lbmfl4
        jZHLNIGmYvb1w0AUJN1iAzLK8pjiBkc=
X-Google-Smtp-Source: ACHHUZ7eBTfH4dV7RVs4WC+T8+ZR3SOllOnRqvIB6h8NsFM8M92E/QFu3dYGD5cudxv8BoM0A1JJWQ==
X-Received: by 2002:a5d:5707:0:b0:30f:bafb:2468 with SMTP id a7-20020a5d5707000000b0030fbafb2468mr9062146wrv.40.1687796702297;
        Mon, 26 Jun 2023 09:25:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3-20020adfe303000000b0030fd03e3d25sm7854671wrj.75.2023.06.26.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:01 -0700 (PDT)
Message-Id: <d3242e1f949815e6c2c036146da2f5faff92d94f.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:39 +0000
Subject: [PATCH v3 15/24] completion: complete --no-relative
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

