Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD24EB64D7
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 02:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjF2CIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 22:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF2CH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 22:07:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951B910FF
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 19:07:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313f1085ac2so174125f8f.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 19:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688004475; x=1690596475;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aec/zOFggZv4Z22vpLvv/kVW6egzsnva4bNBDnHY38I=;
        b=XMAtDjvjWowYINkUgvkl0IudSqWojCwxclawgwI8iVXHkzOY9kS8Dve6BZ3aqzQfsj
         VMEUEzjI7hf0Pzt4z2DftDGWGI1WcT7u5nefLdUhIAEqEWBLSjgbpHXk+aBoZj8Suw2O
         17XNS8K3sxW6L+liOa8KvLjJnSMV0MA1Eh1yHXI0OwLI8D5xGeLue17DExGB75dzpvpw
         ApK/H6X7nvmdn43W2Px41qiVDryGKa1m7vNGd6KtB8zEMrBg9TB9ZFbh1dzzrkOQ030O
         VbN84c7bcRi1CBe7MAxFAhuij6QWs01g1M4YV44GvNmGQSR33EwYKocu+ZAclXp1/qbD
         5Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688004475; x=1690596475;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aec/zOFggZv4Z22vpLvv/kVW6egzsnva4bNBDnHY38I=;
        b=QmosyFWGJjT9/tay63Z0PTD6ZTdIZGzrWD/NUICbphMEHRCEinEVMeljd8/evyBtgd
         LVyV69sAdK9RR4154dauXN5ai2TsNXopCt/Kq5dwvX4keyU/+hiI49LiD3LH2ZaupI73
         K5/lrBtqHls1EV/EsxDHWGZPnSu+HCt9p7CMuMd3/27aygH54rpJpCELqLeNXVdWxy/C
         4VaZbRc0uBf6qNQyzQrtgfrNuzVVkTPp1n07RRDlf/oGB59V3lJBsfbXiZGXMG0gqfgO
         Djtsi1fQ35PcwSwBpcyksMqCb1rozHWzMWdKy53Km948N2K7aCsc6t6lxGMjDnIfjqdT
         RlMA==
X-Gm-Message-State: ABy/qLaU1VNRs2da5VvmyUF0Xkc1J4eY5fiYMw1fNdYKh3f6VqdeyzW8
        FLJuGs1cxcSwwzKGOTBiqXT0/S0VCvg=
X-Google-Smtp-Source: APBJJlF4ga12gBePc+OpqLZsRelVR2Sx2SiH69SvgJkfE99LL8KQWAjZcA1aDxx2nvORa+ou1EcUYA==
X-Received: by 2002:a5d:4605:0:b0:314:15b7:1fb4 with SMTP id t5-20020a5d4605000000b0031415b71fb4mr538516wrq.52.1688004474972;
        Wed, 28 Jun 2023 19:07:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm348816wrn.108.2023.06.28.19.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 19:07:54 -0700 (PDT)
Message-Id: <pull.1533.v3.git.git.1688004473941.gitgitgadget@gmail.com>
In-Reply-To: <pull.1533.v2.git.git.1687555504551.gitgitgadget@gmail.com>
References: <pull.1533.v2.git.git.1687555504551.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jun 2023 02:07:53 +0000
Subject: [PATCH v3] docs: add git hash-object -t option's possible values
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

The summary under the NAME section for git hash-object can mislead
readers to conclude that the command can only be used to create blobs,
whereas the description makes it clear that it can be used to create
objects, not just blobs. Let's clarify the one-line summary.

Further, the description for the option -t does not list out other types
that can be used when creating objects. Let's make this explicit by
listing out the different object types.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    docs: add git-hash-object -t option's possible values
    
    For newer users of Git, the possible values of -t in git-hash-object may
    not be apparent. In fact the current verbiage under NAME could lead one
    to conclude that git-hash-object(1) can only be used to create blobs.
    
    Update the verbiage to make it clear the command can be used to write
    objects, not just blobs. Also add the possible values for -t.
    
    Changes since v2:
    
     * grammatical corrections in command documentation.
     * clarify -t text by specifying what "type" is.
    
    Changes since v1:
    
     * updated verbiage of commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1533%2Fjohn-cai%2Fjc%2Fhash-object-documentation-update-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1533/john-cai/jc/hash-object-documentation-update-v3
Pull-Request: https://github.com/git/git/pull/1533

Range-diff vs v2:

 1:  2483375ecb8 ! 1:  9e0bec41285 docs: add git hash-object -t option's possible values
     @@ Metadata
       ## Commit message ##
          docs: add git hash-object -t option's possible values
      
     -    The verbiage under the NAME section for git hash-object could
     -    lead one to conclude that git hash-object can only be used to create
     -    blobs when in fact the description makes it clear that it can be used to
     -    create objects, not just blobs. Lets clarify this in the NAME text.
     +    The summary under the NAME section for git hash-object can mislead
     +    readers to conclude that the command can only be used to create blobs,
     +    whereas the description makes it clear that it can be used to create
     +    objects, not just blobs. Let's clarify the one-line summary.
      
          Further, the description for the option -t does not list out other types
     -    that can be used. Let's make this explicit by listing out the different
     -    object types.
     +    that can be used when creating objects. Let's make this explicit by
     +    listing out the different object types.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     @@ Documentation/git-hash-object.txt: git-hash-object(1)
       NAME
       ----
      -git-hash-object - Compute object ID and optionally creates a blob from a file
     -+git-hash-object - Compute object ID and optionally creates an object from a file
     ++git-hash-object - Compute object ID and optionally create an object from a file
       
       
       SYNOPSIS
     @@ Documentation/git-hash-object.txt: OPTIONS
       
       -t <type>::
      -	Specify the type (default: "blob").
     -+	Specify the type (default: "blob"). Possible values are `commit`,
     -+	`tree`, `blob`, and `tag`.
     ++	Specify the type of object to be created (default: "blob"). Possible
     ++	values are `commit`, `tree`, `blob`, and `tag`.
       
       -w::
       	Actually write the object into the object database.


 Documentation/git-hash-object.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 472b5bb995b..8577f7a7d40 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -3,7 +3,7 @@ git-hash-object(1)
 
 NAME
 ----
-git-hash-object - Compute object ID and optionally creates a blob from a file
+git-hash-object - Compute object ID and optionally create an object from a file
 
 
 SYNOPSIS
@@ -25,7 +25,8 @@ OPTIONS
 -------
 
 -t <type>::
-	Specify the type (default: "blob").
+	Specify the type of object to be created (default: "blob"). Possible
+	values are `commit`, `tree`, `blob`, and `tag`.
 
 -w::
 	Actually write the object into the object database.

base-commit: 6640c2d06d112675426cf436f0594f0e8c614848
-- 
gitgitgadget
