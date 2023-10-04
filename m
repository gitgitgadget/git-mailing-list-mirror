Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7687E8FDC7
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 02:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbjJDCWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 22:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjJDCWy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 22:22:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045EAF
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 19:22:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso14964735e9.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 19:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696386167; x=1696990967; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoZQyk+xhHrz0UhCGEZnwBxrguy1gRsjRtDWfJmJ+iE=;
        b=Crqpfxt4ifqjMCY5Z+NTY1FRIHLE9IHuc41PZcDvSYGFnKrciHrj/R5Qbeiaad0jeZ
         hoj1QrEwIrVYfNE1FwzXtNCwuBtjJT4Db1C40duMQ7VqUmlX3jZMNSkYg6vPfgO7hjOu
         ZmnTb9AQ7Ll61xtHqyDjP/dzAgQWRueMDoVOTrgbWFM3ZKmtdBWd7pVPpvOn73bNBUkq
         upqOiFiymdM0QCGMcinyMq/sNrezhr//1mo0J7/yTWqCkvKkZHAP5jpYJL8jtN3cCuDy
         FnXtON69d2btqs8h3DHq2IzmtpI2rPaUdbFvdyc+ou1eYam5L1gc84rBCfpheGjmjxNH
         eogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696386167; x=1696990967;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoZQyk+xhHrz0UhCGEZnwBxrguy1gRsjRtDWfJmJ+iE=;
        b=grszcPeVR+2x7vU+H1nMCRbFWkC1Ff4k5lwuB3QbE7QGgL8t9mseapFdBRBhf7LiLm
         +1r8ys6FcwMKBkjmrCFBm8xG1GAhPfKuLWmrUKn/S21Dslf1jE4+ZTZ3imTwRKsicomN
         AKyqJnJet86d3TLD0J3pvIjxeRcYFceJ0O/HHT3ALkkxtQOQAGsPqs/mNqbRu3Kg3btC
         /4aQSb4XQExe2e+MqkdQExLjBzkCs3ILBvpxCmX2RUenHMXzv6eZxeW2PvgMt7FIDpFg
         EgtaefH8X0WDUoJ3dDxs0sPkAVI60d0MOjsgMxPJHryUJqQ0iBNCyJb1qTEoZMuuryYv
         +lCQ==
X-Gm-Message-State: AOJu0YyEzl2rlNMPrizR3eHGs6PBzJ4Y0IayHf0zFiKZoszLd4rf3hTS
        q+945WIqZK3bSjzb+zEtRCaSzxBkz1s=
X-Google-Smtp-Source: AGHT+IEfMjeZXN0iI6P0zXEbFa0uTU3liVma0miBarZ7K+jAKic44EhbRdYMFjaCvuzk4EgdoeS2CA==
X-Received: by 2002:a1c:f70e:0:b0:403:787:e878 with SMTP id v14-20020a1cf70e000000b004030787e878mr976798wmh.21.1696386166733;
        Tue, 03 Oct 2023 19:22:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b00403b63e87f2sm403434wmg.32.2023.10.03.19.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 19:22:46 -0700 (PDT)
Message-ID: <pull.1591.v3.git.1696386165616.gitgitgadget@gmail.com>
In-Reply-To: <pull.1591.v2.git.1696350802820.gitgitgadget@gmail.com>
References: <pull.1591.v2.git.1696350802820.gitgitgadget@gmail.com>
From:   "cousteau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Oct 2023 02:22:45 +0000
Subject: [PATCH v3] git-status.txt: fix minor asciidoc format issue
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Javier Mora <cousteaulecommandant@gmail.com>,
        cousteau <cousteaulecommandant@gmail.com>,
        Javier Mora <cousteaulecommandant@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Javier Mora <cousteaulecommandant@gmail.com>

The list of additional XY values for submodules in short format
isn't formatted consistently with the rest of the document.
Format as list for consistency.

Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
---
    git-status.txt: minor asciidoc format correction
    
    The paragraph below the list of short option combinations was hard to
    read; turns out it wasn't correctly formatted in asciidoc.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1591%2Fcousteaulecommandant%2Fman-git-status-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1591/cousteaulecommandant/man-git-status-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1591

Range-diff vs v2:

 1:  811885a275f ! 1:  819499eb4c8 git-status.txt: fix minor asciidoc format issue
     @@ Metadata
       ## Commit message ##
          git-status.txt: fix minor asciidoc format issue
      
     -    The paragraph below the list of short option combinations
     -    isn't correctly formatted, making the result hard to read.
     +    The list of additional XY values for submodules in short format
     +    isn't formatted consistently with the rest of the document.
     +    Format as list for consistency.
      
          Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
      


 Documentation/git-status.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index b27d127b5e2..48f46eb2047 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -246,10 +246,9 @@ U           U    unmerged, both modified
 
 Submodules have more state and instead report
 
-		M    the submodule has a different HEAD than
-		     recorded in the index
-		m    the submodule has modified content
-		?    the submodule has untracked files
+* 'M' = the submodule has a different HEAD than recorded in the index
+* 'm' = the submodule has modified content
+* '?' = the submodule has untracked files
 
 since modified content or untracked files in a submodule cannot be added
 via `git add` in the superproject to prepare a commit.

base-commit: d0e8084c65cbf949038ae4cc344ac2c2efd77415
-- 
gitgitgadget
