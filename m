Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CCBC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 04:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjAWEW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 23:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjAWEW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 23:22:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7503610258
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 20:22:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so9700817wml.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 20:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76Okk4qGZhSSGzAfhnrNO5RIX2Zm0BJreu3Glt+lnLA=;
        b=cb+4JhvrWfpcaDvAciZhei0clOf3rlRFIJVqhAA5qWrF6vGmpAtddRTUd1X51gHW7G
         rtxsGWvHPNHmGfqCFhSLqooWsQpPldelwTvuY8CG8PlQV/KJQ9UqcKLfpNbItni/3Lbn
         zKYbFApT1JbNPnkSuFGS+WyYztxO+fCdGwDq4DgxF92yr+SXXOcE4KIR8k0jvYB4o9dh
         1FdnrUCyoJIXD/lghuauPuTIfW2IG71Ihrdx/4bPXv3zgHe7h8/If1K/pb5GJdUZkrx/
         AeWWbW/f/xkY/jjklGP1CcTpNA3bTbJh8VEn8LPzWpUxk9eGMo8BAAYgMOF3B+eoMrUF
         Kuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76Okk4qGZhSSGzAfhnrNO5RIX2Zm0BJreu3Glt+lnLA=;
        b=FAh0d9CTYisi2r2oY7Q4vsEMeXj4OuzkT+OApCmFn2VchuZ/P5WPNoOBjeIu/FIt2u
         QocERnzXxA67fyiIPr3euBaYjXoeKHzq/fcbL9KHG+vYOCqn8oI/cwk4ViVk+qCHIE3v
         ZC+Z9MQoVrp/ZgKUs23dgn+9H+u0luruUZxAark9U7Dsr0obafuabCT77E71J25BwRRe
         SX8Hs/h17uc2cVzg7EcWR+GLQseeHqtJzjsT+JWlv8PPRLBADlSg9ismDVnKwfaWoJPR
         AbHAJhWAAtV2LPlkFys79kPfk7jojeWyN0uqyNYGQqOwZgsFQfgjbbx4rY/yGrEgGLIq
         WY0w==
X-Gm-Message-State: AFqh2kotes+YaRKprwdgvnsKyYxcB+a5mEcx7Hq2+ghhZ5y/BzkieWmk
        8oUNqBFfur+zVACCbm/5iXg87FOn37A=
X-Google-Smtp-Source: AMrXdXuF66y3If9cv4o5BSH5OrEzFnDGcaXY8csihlFokmjdl/Jy/g6ClQN7eHBcENpKcMt3evi9SQ==
X-Received: by 2002:a05:600c:3d06:b0:3da:f945:2354 with SMTP id bh6-20020a05600c3d0600b003daf9452354mr22609347wmb.41.1674447742890;
        Sun, 22 Jan 2023 20:22:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003db0b0cc2afsm10428189wmq.30.2023.01.22.20.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 20:22:22 -0800 (PST)
Message-Id: <pull.1441.v2.git.git.1674447742078.gitgitgadget@gmail.com>
In-Reply-To: <pull.1441.git.git.1674356774172.gitgitgadget@gmail.com>
References: <pull.1441.git.git.1674356774172.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 04:22:21 +0000
Subject: [PATCH v2] attr: fix instructions on how to check attrs
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

The instructions in attr.h describing what functions to call to check
attributes is missing the index as the first argument to
git_check_attr().

When 7a400a2c (attr: remove an implicit dependency on the_index,
2018-08-13) started passing an index_state instance to git_check_attr(),
it forgot to update the API documentation in
Documentation/technical/api-gitattributes.txt. Later, 3a1b3415
(attr: move doc to attr.h, 2019-11-17) moved the API documentation to
attr.h as a comment, but still left out the index_state as an argument.

Fix this to make the documentation in the comment consistent with the
actual function signature.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    attr: fix instructions on how to check attrs
    
    The instructions in attr.h describing what functions to call to check
    attributes is missing the index as the first argument to git_check_attr.
    
    Fix this to make it consistent with the actual function signature.
    
    Changes since V1:
    
     * updated commit message to include some history
    
    Signed-off-by: John Cai johncai86@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1441%2Fjohn-cai%2Fjc%2Ffix-attr-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1441/john-cai/jc/fix-attr-docs-v2
Pull-Request: https://github.com/git/git/pull/1441

Range-diff vs v1:

 1:  63bb84db487 ! 1:  8cfee55e48f attr: fix instructions on how to check attrs
     @@ Commit message
          attr: fix instructions on how to check attrs
      
          The instructions in attr.h describing what functions to call to check
     -    attributes is missing the index as the first argument to git_check_attr.
     +    attributes is missing the index as the first argument to
     +    git_check_attr().
      
     -    Fix this to make it consistent with the actual function signature.
     +    When 7a400a2c (attr: remove an implicit dependency on the_index,
     +    2018-08-13) started passing an index_state instance to git_check_attr(),
     +    it forgot to update the API documentation in
     +    Documentation/technical/api-gitattributes.txt. Later, 3a1b3415
     +    (attr: move doc to attr.h, 2019-11-17) moved the API documentation to
     +    attr.h as a comment, but still left out the index_state as an argument.
     +
     +    Fix this to make the documentation in the comment consistent with the
     +    actual function signature.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      


 attr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.h b/attr.h
index 2f22dffadb3..47f1111f391 100644
--- a/attr.h
+++ b/attr.h
@@ -45,7 +45,7 @@
  * const char *path;
  *
  * setup_check();
- * git_check_attr(path, check);
+ * git_check_attr(&the_index, path, check);
  * ------------
  *
  * - Act on `.value` member of the result, left in `check->items[]`:

base-commit: 904d404274fef6695c78a6b055edd184b72e2f9b
-- 
gitgitgadget
