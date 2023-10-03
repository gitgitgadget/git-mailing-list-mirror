Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EBCE7AD78
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 16:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbjJCQdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbjJCQda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 12:33:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B6C6
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 09:33:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40566f8a093so11156385e9.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696350804; x=1696955604; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmCFfUx8/KKT6gl7JSh7Kkgcne7xjtvOpnCULvmu74I=;
        b=fsYsaB+XQyhERAgXUx139kn7u4cnakghZkppYHLkX3MhgrVfoZeU+j7I9mRBJL8akd
         Ia9g4XMt+SFws1C8kWUWBKC4bgUDiPZYWIVKxNIZZWyJ53xSWVfXxuOOEOSBBNyi0XYX
         aJSrWn0z4bP7xHsjRHz504NamzJY9L410+m9aGDpjXQn5E33OUIpktlnEElfX2pp8BtG
         DsqGYgt+WU10GLxsxkQu5qYyPLFSBh9ZZVnxtvzYt/myqsv4PvhO8ZTxLTATTZgnZ9fM
         fgui6xpJ4DMQ+vObaM3AeJOi0Hz6SI+vRlrBXec+ofTxUYL9WfqM/O+9d/Juk4LgR/Hs
         7l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350804; x=1696955604;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmCFfUx8/KKT6gl7JSh7Kkgcne7xjtvOpnCULvmu74I=;
        b=mNgNVKioJFywGia8aPtSz2vRD4IdW3IPaS+EpBszFnKlAYluh18oFTy8dCc2ZwixZ9
         3JY68d1gqFDkg20/leMiyhiXxwUaifbJ3HCevVCMp7Vms27zWggNG8vG0nQTimBuQSYg
         YzOOjEqR2o4CVl731oW9REfWOUpxm1jYdGS4vvP4zWpN+/P2pRdtvsvvkGNxpLPJLVxQ
         Ufy1c7NQOxon4aHeNHH3NG99N3ObGXQUR2BStmWEnLMQZygGCZ3yBkZfwh/hRBxVxlEy
         9+vRBdMgoKpOGOyXQORYPEnBFE6dpGc9aWjysS6S5gOiLBtdNCgTQYlkW/zzqhuMw6RW
         u75w==
X-Gm-Message-State: AOJu0YxCWTbcMlBojqwMxOwVSuSyaeUrtzhHgPbAsbRFFZYiIEmeujn5
        3XtkUDU1Y0rFdLsOjzkgvjdPMr7ijqE=
X-Google-Smtp-Source: AGHT+IHBKShKb38Y63MjDXtEIDveDQqf4SF+uB1ewWrMI9AwZli9/x5PKD9ThGEvhCV0VHH7GgCs5w==
X-Received: by 2002:a05:600c:2146:b0:405:458d:d54 with SMTP id v6-20020a05600c214600b00405458d0d54mr14134401wml.33.1696350804006;
        Tue, 03 Oct 2023 09:33:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b00405ee9dc69esm9800726wmr.18.2023.10.03.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:33:23 -0700 (PDT)
Message-ID: <pull.1591.v2.git.1696350802820.gitgitgadget@gmail.com>
In-Reply-To: <pull.1591.git.1696193527923.gitgitgadget@gmail.com>
References: <pull.1591.git.1696193527923.gitgitgadget@gmail.com>
From:   "cousteau via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Oct 2023 16:33:22 +0000
Subject: [PATCH v2] git-status.txt: fix minor asciidoc format issue
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

The paragraph below the list of short option combinations
isn't correctly formatted, making the result hard to read.

Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
---
    git-status.txt: minor asciidoc format correction
    
    The paragraph below the list of short option combinations was hard to
    read; turns out it wasn't correctly formatted in asciidoc.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1591%2Fcousteaulecommandant%2Fman-git-status-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1591/cousteaulecommandant/man-git-status-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1591

Range-diff vs v1:

 1:  b3c97ca9e0f ! 1:  811885a275f git-status.txt: fix minor asciidoc format issue
     @@ Commit message
      
       ## Documentation/git-status.txt ##
      @@ Documentation/git-status.txt: U           U    unmerged, both modified
     - ....
       
       Submodules have more state and instead report
     + 
      -		M    the submodule has a different HEAD than
      -		     recorded in the index
      -		m    the submodule has modified content
      -		?    the submodule has untracked files
     -+
      +* 'M' = the submodule has a different HEAD than recorded in the index
      +* 'm' = the submodule has modified content
      +* '?' = the submodule has untracked files
     -+
     + 
       since modified content or untracked files in a submodule cannot be added
       via `git add` in the superproject to prepare a commit.
     - 


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
