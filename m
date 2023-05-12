Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F38C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbjELHFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjELHEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5139A65B9
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f415a90215so72918695e9.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875087; x=1686467087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST0fwY7y3AT9WtPSXWaBBn71IAShr0kXfKKXOHLsZdE=;
        b=G9wRq+J/MyKtboI7jWvvoDCbCTcaP96h/2a44SX2epMCGGERSqPp7C32HPQ1Lf3r44
         DT29mL8h59NUll0zl36PnBCOu8IJiJo6loL8U5OXb6ZeGPPIcIL489HQDxw41/ruvK15
         sumblDNYVdSzo2yCtN6NbAiIke5dTO5kRS1Dryqsz161HhbKPjNPSkKQEeR0gFkGAvws
         nqAFXa+TLxMelPdnCPU719hgNlqTiRjTbGZ8/A5Q9xZqwQy4/UgGLTMBv+DCYYFwDlpm
         67HudYPNCGVc4iv3q0umDbEiXOFhszVy0lx8plq3/2evyieO8W+Afx0PUjmge5wW1e3D
         mdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875087; x=1686467087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST0fwY7y3AT9WtPSXWaBBn71IAShr0kXfKKXOHLsZdE=;
        b=M6fMIU6ZcWG4KMa9BC20M+lUD5sVPqmNbHNsh/Lug+9OtjfCmE4e17Erar9MHwEYs9
         Cw8Hoqg/VYhMANO2NbbhhLvMxF/xyPzeN2rk8vP20vrjEpVlrtYViLKfv1SHpjaJEy+C
         1vJ4eq73chJaqnEg9iYGqaggK7i7CZoJt5KCmXM7Uep+dcnygv7t+WAcgc8QLXWbkfEZ
         ll6Z9OWHXychEdDnS5fAtltVfEEP+uBdH22preDf7Xc/pxmnhY05uV2B5QIKo+PCaCOE
         O2EcEpCLxoJw7kIWQP91rJJvcWtBVpePQf9bmYy/9ANH+8ARVjwaPfsdOHrNqpM4VOSu
         yMlg==
X-Gm-Message-State: AC+VfDzkDfAfGsLlwdzcr53CWtlspJ0J3ECv1Y3m4gUGEqzMKW0LsZZy
        KaSL4FDlVw9AaW0y//CeEBPSVzaF/No=
X-Google-Smtp-Source: ACHHUZ5OeU+8IV1xyTKy+u7SR/EZJSw927ArzTA2OWlGo9sY8UXtrYNVGJ6ak0t7FgyLfK4VRJTTfQ==
X-Received: by 2002:adf:ea02:0:b0:306:2d81:3432 with SMTP id q2-20020adfea02000000b003062d813432mr15073674wrm.34.1683875087636;
        Fri, 12 May 2023 00:04:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4003000000b003063176ef0dsm22533821wrp.97.2023.05.12.00.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:47 -0700 (PDT)
Message-Id: <c8f873d71f55485b0f19d5f7d23193693cf1e996.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:14 +0000
Subject: [PATCH v2 13/27] diff.h: move declaration for global in diff.c from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h | 3 ---
 diff.h  | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index b79802a4639..08f6fbd801d 100644
--- a/cache.h
+++ b/cache.h
@@ -523,9 +523,6 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, int include_sparse,
 		       int flags);
 
-/* diff.c */
-extern int diff_auto_refresh_index;
-
 /* ls-files */
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/diff.h b/diff.h
index 3a7a9e8b888..29a9cd217c2 100644
--- a/diff.h
+++ b/diff.h
@@ -694,4 +694,6 @@ void print_stat_summary(FILE *fp, int files,
 			int insertions, int deletions);
 void setup_diff_pager(struct diff_options *);
 
+extern int diff_auto_refresh_index;
+
 #endif /* DIFF_H */
-- 
gitgitgadget

