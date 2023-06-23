Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA78C001B0
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 21:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjFWVZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjFWVZO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 17:25:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96861BD2
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:25:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f9b4a71623so12250715e9.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687555506; x=1690147506;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEDFd89anXR3OA5nGr4far3VE3bsSai1fjshzBCkvFg=;
        b=e2mov4sSO5QQ42qkCNZ+u3lhnHC309tP5BFUA7rgleUv8Hm1CIq2V0SodhwrL7eWxc
         4A68LqgrW5lNcvOl19c3HZ7MYdAR8yYhF3XiuHimJG+oKC9W+VP57t2uAczzA5Gj3ebY
         eB347Dq/VCmzPr81vEA3ui3AKOsoDN8yP1VkAVFt52rUeTG4V1Cw1O67ztzMYa5xxtQ2
         utLQELopNV7MRGn3FJ8ZHrSPcmOpR/t24SXZprg4VEdeFBQbCp/i8lpKEGuWkCm+qiXO
         +G5CvVzbIMa2X2R+Qw0BfZkYvvoXQLPho2SXMVhY7R1pQl0X998AYI4H+ZvBUFrV61Kk
         0K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687555506; x=1690147506;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEDFd89anXR3OA5nGr4far3VE3bsSai1fjshzBCkvFg=;
        b=c3pg1IiMwRxjqzCwo4XH3vr73yPMx91o41RxHxAdKX9nvRK9KGuQghyufafahOcigz
         LJDev6w3SVN5YMovOuWI3bt7BhQg2f5XliyhFzpuk0fV5VYPAKgP59a4VOJnywHuYoPg
         Uwz8EopmB4XpqlXu8alfjOdPm85yTgUZN+YhbBkLBwMOrW7WtIby2tkANfmW9hMy84QC
         17nGD+O3vkj+ai0yPRbqZM55obqpHCwgRCpAC4hmMiaTO3SjrMS10k8iXjirk6ImDltc
         Km6w8UpbWKiHuf1I+enyNlBYpJjfmo7JnzJxhYi+NextAds+CI+r+6WX1agn5gJHvAQS
         9ocw==
X-Gm-Message-State: AC+VfDxtAQETgVaE+skUci+WIuNRUMVFZvMUmi9X89TCGFj3gWJ2lcAw
        PKeA8CKeV73QouG9mPcLGAqrTsLKoAE=
X-Google-Smtp-Source: ACHHUZ7gzime+sKAv5Pe0VaqNwpti7ucdH+wqe1XsEFjxe93BeHO/3BrvYAdXnL36TFhxnWZNnC8mg==
X-Received: by 2002:a7b:ce8f:0:b0:3fa:78df:1ca6 with SMTP id q15-20020a7bce8f000000b003fa78df1ca6mr3249121wmj.26.1687555505782;
        Fri, 23 Jun 2023 14:25:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13-20020a7bc00d000000b003f735ba7736sm375123wmb.46.2023.06.23.14.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:25:05 -0700 (PDT)
Message-Id: <pull.1533.v2.git.git.1687555504551.gitgitgadget@gmail.com>
In-Reply-To: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
References: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jun 2023 21:25:04 +0000
Subject: [PATCH v2] docs: add git hash-object -t option's possible values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The verbiage under the NAME section for git hash-object could
lead one to conclude that git hash-object can only be used to create
blobs when in fact the description makes it clear that it can be used to
create objects, not just blobs. Lets clarify this in the NAME text.

Further, the description for the option -t does not list out other types
that can be used. Let's make this explicit by listing out the different
object types.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    docs: add git-hash-object -t option's possible values
    
    For newer users of Git, the possible values of -t in git-hash-object may
    not be apparent. In fact the current verbiage under NAME could lead one
    to conclude that git-hash-object(1) can only be used to create blobs.
    
    Update the verbiage to make it clear the command can be used to write
    objects, not just blobs. Also add the possible values for -t.
    
    Changes since v1:
    
     * updated verbiage of commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1533%2Fjohn-cai%2Fjc%2Fhash-object-documentation-update-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1533/john-cai/jc/hash-object-documentation-update-v2
Pull-Request: https://github.com/git/git/pull/1533

Range-diff vs v1:

 1:  38515c660fb ! 1:  2483375ecb8 docs: add git-hash-object -t option's possible values
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    docs: add git-hash-object -t option's possible values
     +    docs: add git hash-object -t option's possible values
      
     -    For newer users of Git, the possible values of -t in git-hash-object may
     -    not be apparent. In fact the current verbiage under NAME could
     -    lead one to conclude that git-hash-object(1) can only be used to create
     -    blobs.
     +    The verbiage under the NAME section for git hash-object could
     +    lead one to conclude that git hash-object can only be used to create
     +    blobs when in fact the description makes it clear that it can be used to
     +    create objects, not just blobs. Lets clarify this in the NAME text.
      
     -    Update the verbiage to make it clear the command can be used to write
     -    objects, not just blobs. Also add the possible values for -t.
     +    Further, the description for the option -t does not list out other types
     +    that can be used. Let's make this explicit by listing out the different
     +    object types.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      


 Documentation/git-hash-object.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 472b5bb995b..404e339e170 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -3,7 +3,7 @@ git-hash-object(1)
 
 NAME
 ----
-git-hash-object - Compute object ID and optionally creates a blob from a file
+git-hash-object - Compute object ID and optionally creates an object from a file
 
 
 SYNOPSIS
@@ -25,7 +25,8 @@ OPTIONS
 -------
 
 -t <type>::
-	Specify the type (default: "blob").
+	Specify the type (default: "blob"). Possible values are `commit`,
+	`tree`, `blob`, and `tag`.
 
 -w::
 	Actually write the object into the object database.

base-commit: 6640c2d06d112675426cf436f0594f0e8c614848
-- 
gitgitgadget
