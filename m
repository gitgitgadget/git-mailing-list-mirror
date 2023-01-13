Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498F9C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbjAMQWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjAMQVm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:21:42 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6AB81419
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:15:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bs20so21539665wrb.3
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KRTK8W0kw6oAEOn+R4pq8zv+uO9j2HTDb5JAz2Ojw8=;
        b=b6Jxh1qRJQ/y9A2gJXWGmnnjmxmkB7bWIGOkJ+yrXkoU6Qmn1TajRnxzLdG6/LhC0a
         Uo+41tpwAoFKA8Ms9ngW3YojxiSq/ZQyixnQQCbbjV1W8X8RPGunoCdE/6VOZuaLtSXX
         A1VGNve1JmlIu54F/AFf0EeJdntPKRHsQBlo98h4Ha+W1eLttr5qeQWy+OnxUG6uxMTr
         VFrzol8GXsIx3uPMOZOJRiqNqFoXf76Zq0IBdignZPlwS0HApoVz1lr8NpIWpfRzWZwJ
         7Wff+vvkRk/oyIULMs5xIxXBI3/P4rDELBiXBpEBT5EC3whTp+eWmD8wnspXI5eZlzCf
         B1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KRTK8W0kw6oAEOn+R4pq8zv+uO9j2HTDb5JAz2Ojw8=;
        b=4QEVOYH0huEny9Fj8VqXOSlcJAuOy646SBNwp3slO13Xcdfe/KxkXS2lBsbLDUeWf9
         8GUG4teHVYDrpZMOcITvTL/2hWXQLgVFJ98Oh+vEhElfTFAI6YlP9UXjJGP7v9s9njd1
         M2l7Q8s5I94sKra6l4VmcpVKXz0AAZGNJsA1XD3TuZMH1V39u5yR7UJR/DoW0tmvcbSY
         0V86Vfq+EaQSDZ6EPk22eoO6dMINnVALsbNNBBgGV+ds34qspI8msTsra8Y8VlYl67jO
         vilvS0KoqVGSHhQDPWfQhMFxrX16AzEqBbu8wGUvoLLCqIHf8HVAilbf/nA8Lswj2DSC
         armQ==
X-Gm-Message-State: AFqh2kooYGuhsYWUYalhPFT8VF4Qz6h/6cfDSvSpLHjhbUbk22Oq3imN
        2zGvw5L3hBt0owl76NOCQZpOzoHMD74=
X-Google-Smtp-Source: AMrXdXsTCc1HJSsDSzSjHMz0pXNswxP+8IJrvU6qCKG0qe33+aIeIvA34M7ZyC8UYYlIQj6WNiG+sQ==
X-Received: by 2002:a5d:6787:0:b0:2bc:8149:9b31 with SMTP id v7-20020a5d6787000000b002bc81499b31mr11877834wru.27.1673626525679;
        Fri, 13 Jan 2023 08:15:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020adfeb8e000000b002baa780f0fasm19042651wrn.111.2023.01.13.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:15:25 -0800 (PST)
Message-Id: <pull.1392.v2.git.git.1673626524221.gitgitgadget@gmail.com>
In-Reply-To: <pull.1392.git.git.1670614892380.gitgitgadget@gmail.com>
References: <pull.1392.git.git.1670614892380.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 16:15:24 +0000
Subject: [PATCH v2] docs: link generating patch sections
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Currently, in the git-log documentation, the reference to generating
patches does not match the section title. This can make the section
"Generating patch text with -p" hard to find, since typically readers of
the documentation will copy and paste to search the page.

Let's make this more convenient for readers by linking it directly to
the section.

Since git-log pulls in diff-generate-patch.txt, we can provide a direct
link to the section. Otherwise, change the verbiage to match exactly
what the section title is, to at least make searching for it an easier
task.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    docs: link generating patch sections
    
    Currently, in the git-log documentation, the reference to generating
    patches does not match the section title. This can make the section
    "Generating patch text with -p" hard to find, since typically readers of
    the documentation will copy and paste to search the page.
    
    Let's make this more convenient for readers by linking it directly to
    the section.
    
    Since v1:
    
     * added explicit anchor for generating patch text section
     * adjusted verbiage to include quotations
    
    Signed-off-by: John Cai johncai86@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1392%2Fjohn-cai%2Fjc%2Fdoc-generate-patch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1392/john-cai/jc/doc-generate-patch-v2
Pull-Request: https://github.com/git/git/pull/1392

Range-diff vs v1:

 1:  88e7e52fbc6 ! 1:  087f9b8d63a docs: link generating patch sections
     @@ Commit message
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     + ## Documentation/diff-generate-patch.txt ##
     +@@
     ++[[generate_patch_text_with_p]]
     + Generating patch text with -p
     + -----------------------------
     + 
     +
       ## Documentation/diff-options.txt ##
      @@ Documentation/diff-options.txt: ifndef::git-format-patch[]
       -p::
       -u::
       --patch::
      -	Generate patch (see section on generating patches).
     -+	Generate patch (see section on
     ++	Generate patch (see section titled
      +ifdef::git-log[]
     -+<<_generating_patch_text_with_p, generating patches>>).
     ++<<generate_patch_text_with_p, "Generating patch text with -p">>).
      +endif::git-log[]
      +ifndef::git-log[]
     -+Generate patch text with -p).
     ++"Generating patch text with -p").
      +endif::git-log[]
       ifdef::git-diff[]
       	This is the default.


 Documentation/diff-generate-patch.txt | 1 +
 Documentation/diff-options.txt        | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index c78063d4f74..546adf79e5a 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -1,3 +1,4 @@
+[[generate_patch_text_with_p]]
 Generating patch text with -p
 -----------------------------
 
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3674ac48e92..7d73e976d99 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -22,7 +22,13 @@ ifndef::git-format-patch[]
 -p::
 -u::
 --patch::
-	Generate patch (see section on generating patches).
+	Generate patch (see section titled
+ifdef::git-log[]
+<<generate_patch_text_with_p, "Generating patch text with -p">>).
+endif::git-log[]
+ifndef::git-log[]
+"Generating patch text with -p").
+endif::git-log[]
 ifdef::git-diff[]
 	This is the default.
 endif::git-diff[]

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
