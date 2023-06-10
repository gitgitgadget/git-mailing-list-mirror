Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED95C7EE29
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjFJUWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjFJUVm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AB63A86
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1946175f8f.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428495; x=1689020495;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l05uboNt/LUqosn2wfX53a4vdlSfAxNCZIFmlfGziwE=;
        b=Xl92pVhJFYN5EaDd29m1NdV6udLpwFtB0rMvL7AKcgiKLk+HBtLODUBgd4q2E+pXH3
         o0B7N5+oHbEyy1887o1ob53dgfff2ksbi/u1HFhYmLp/fTinJss93zEpJwcEbrTc8Ptb
         +L+wnHPBkO3aEEe6XZMhx1gmqpEPs7DV7fRg5uF3X+qdoIw8WMYvkBj/wJaM3PgjVxMi
         m2Z/vO4P4ZM0ovLNHWMx35588ER+MVGXBv00P/+SkC12Amt6V5cqCsM1JJrhaC4A5hrt
         GbKqWBP4CfQUrPUGQMD5PZ2lHkvxBqvpSRK7Qbf4VpB6/+oBHyc4Ne8Twkajw1LBwAGV
         HJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428495; x=1689020495;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l05uboNt/LUqosn2wfX53a4vdlSfAxNCZIFmlfGziwE=;
        b=Tz6C5oGMcff6GWWvZnyDVdbb63YiU32mTft3PdOa7UHdhfnwGsS569nEG8IaK1PKgA
         /UMCa/39mba68ap8ZyWsPM9fdkVf5Xz04cnxmAPnrDtI8aUQ6UUerLYXnhM5Emacs4Zk
         hwydzJ58NX/Y/ryvNSEu/Gx8m/tTeWM+IxjWjQfwBTAQVxj248qMlwCLZ8qHu1AXwf+D
         lbEO1oiWO9sIMCbzYvgto+2egNh6HPakxhRDxsjkqRaOPUHrRNQYxxXGvi4gPJo37rPz
         svUuKbJZd1eZf+oFUgqqvJkYI76IfnKysZdBlIjQ3+T3V4GB+a/qRx5bnMrOxGujmD1r
         ChTA==
X-Gm-Message-State: AC+VfDw/+G8KyOv85pFajMMHXTFF52S/LvPNL5nOnX4PkqYb2cEu2Eee
        FbbhRunCLQHv/lA/DJetrIPm+D4cm48=
X-Google-Smtp-Source: ACHHUZ4hXRn/Bj/Vw3MLSx84POJjQ48jzZWcLHx7njKBswcS+GqVRQFv3mq3GsjoW0p84MjYCY2rxA==
X-Received: by 2002:a5d:42cc:0:b0:309:32d1:59d8 with SMTP id t12-20020a5d42cc000000b0030932d159d8mr1481152wrr.64.1686428495010;
        Sat, 10 Jun 2023 13:21:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d4387000000b003064088a94fsm7911250wrq.16.2023.06.10.13.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:34 -0700 (PDT)
Message-Id: <fd94e9ae7830e98397c0f79cd3e0a519dc1fcd5f.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:12 +0000
Subject: [PATCH 13/25] completion: complete --ita-invisible-in-index and
 --ita-visible-in-index
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

The options --ita-invisible-in-index and --ita-visible-in-index are
listed in diff-options.txt and so are included in the documentation of
commands which include this file (diff, diff-*, log, show, format-patch)
but they only make sense for diffs relating to the index. As such, add
them to '__git_diff_difftool_options' instead of
'__git_diff_common_options' since it makes more sense to add them there.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e74636ebe86..7246ced14ad 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1763,6 +1763,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 # Options for diff/difftool
 __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index --relative --merge-base
+			--ita-invisible-in-index --ita-visible-in-index
 			$__git_diff_common_options"
 
 _git_diff ()
-- 
gitgitgadget

