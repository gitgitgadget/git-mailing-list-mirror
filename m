Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2599DC7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjFJUWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjFJUVo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA72E3A9E
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6e1394060so21173245e9.3
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428498; x=1689020498;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE7FKCR7Q34boOA4FM3Fk6A0qBBnNg8uNK4v55FkdHs=;
        b=OQbBRigwULovguDHbA5kgvGFK4vDvaUJFm3IGk/0eQjV8C8hHuvS25GedQEcQvMXU7
         sozkchqVqnqEFpIOHxQZgxEud5YOkbr5jxFbLYL15guIF/OhBU1iJFo7ykBNdUwvnUJn
         vXxUHi2fkt0x9wKMeqUkxXToEiF0GqYWVJmw2lEEpxHD9sQkRfYg6HKQcTH4ucL52B6a
         cY3ud4w+YORwlv5TF7IMzTlrzM8aCMozI79VdgwgJT7HdcdkDn3W1ZkxteimKq1HIH46
         LwyJ0WZdK7hkWn8oBaNcd92yziwDdRhnxKtvS2d+f+BUya+hFM/mfygXwMpO/haJUOVO
         d72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428498; x=1689020498;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE7FKCR7Q34boOA4FM3Fk6A0qBBnNg8uNK4v55FkdHs=;
        b=FtFG50nQujRVXNjddyU2NrT1AMOjUQeAQ1O0bC3X8XjCfvUGlZFrwRFHl54tXmhY7V
         gAS8R7WbXfkP+70MxVPfwGT8FEDd6fgOYjYzIjjcDWzTpXXRt9Iy9Ip8W8eyhnBo3Sc0
         qL4jwcv0+RxE1hwLyJcfYsgeBRPk1l+3VjyMDvWxjYj+YkJEApcnE5ctOpHxF1k6do3r
         nIjCLSuQyqe3qi/6d5L1/lC2rRM8tDa0BKRt78E7c6/Uv7+ocT74RM9Cb8DySWVsR9M4
         nQBjtvfYuTzTnj2ZxYi5QC4iO52XqAqZnp8KNYMxFXkBiXF8KPu3BHREYJyoFvD4YNV9
         Ze3g==
X-Gm-Message-State: AC+VfDx5nHbCacqD0EMRhnV27odQOgPsRulq48yRs1+BqJcNIZm5MxYM
        joGJZZsaxB/iBAY+cJZgcqSZ1PX2Dsw=
X-Google-Smtp-Source: ACHHUZ5KWXoqasNLLGKTyGe54XdJsT9yIqJmBfK/3Ad1uad61grVmGfN4k8DB3kR41kiEBLPhqn7QA==
X-Received: by 2002:a1c:4c15:0:b0:3f1:70a2:ceb5 with SMTP id z21-20020a1c4c15000000b003f170a2ceb5mr2990301wmf.13.1686428497853;
        Sat, 10 Jun 2023 13:21:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c290c00b003f7e653c3e3sm6564396wmd.21.2023.06.10.13.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:37 -0700 (PDT)
Message-Id: <761c75d4aec988609a105db0f039ad9f15d2337e.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:16 +0000
Subject: [PATCH 17/25] completion: complete --output
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

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ec2e4c9e711..a34432796bf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1759,6 +1759,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
 			--irreversible-delete --line-prefix --no-stat
+			--output=
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

