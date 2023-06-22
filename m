Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80135EB64DC
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 00:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFVAqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 20:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFVAqi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 20:46:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8D61992
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 17:46:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3113306a595so5479192f8f.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 17:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687394796; x=1689986796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/pXwb3AE2GaGmHxpdFWL3gxzWEXGHvHSE03yXKFBPYM=;
        b=DzRNqSiCUk0/RNQi9Gbk0V9YCtIspR7BEvFNHof4/lmZSFF5UwBbHD+5BA84r7aHN3
         fkCSO1i2nF6zZpU5JwIe9K9HO0JzI7MoODKVGKUCD5sZlqghXX3BSX9oQB7tSQURKGRc
         d1FkNW0CgGiI2EAqTXKMJvFeY/D2VKoOAlH3ulKzu4WFfkFsMzdY5hQ9XYF3E6k96A9d
         9yCaAFzDak5FUmYWxpAPKozEGfqje069ZMrbyduHwJDM8AVHIqQhqYoNtkUcBJ5jclTz
         lgF/ovqy6RDTNx28h7gypmXLdChlsPeAEQgZvOp5GBqBqkwN20svAP/2s+VvF9mzvfu8
         J7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687394796; x=1689986796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pXwb3AE2GaGmHxpdFWL3gxzWEXGHvHSE03yXKFBPYM=;
        b=MPTpI/gYJdgX1IoqRecdjZKdjQb0HmFBz69dmdkTtFKQPCpduTFqq3h2JbXOUq1A/E
         HyXhz6VnjkjRoODE7Q6WhSqSq1dmN7OtS8PxzfgnhuOkP2cPpk8KPWmCnZR1Qdc76neQ
         FgKRLlmJezQMKBRpu5NVC7eSWsa2cM2S0i+uNofiWU+fQ/j83zmObucmbflG0MtWAh1B
         ZCDG3hCu6n5Bt6NknBUAlZhtO7rgNGWvLO3ixz6uHFSnHnlDx7J+SSzgnZ9OfEIjLQz7
         EV4bVA2mpj6Ul+CciC7Qc2o2uCSDNL7K1RspA8lMqyUGjvzmBjFg0xCRYitYP/MCl0v9
         9wQw==
X-Gm-Message-State: AC+VfDyHINoKzvcwW2CfryvhSL6pt/FP7llgKGDP0UeKUifzm3Oheety
        P5KbkHHWzwuyEjqjAg5SIgXDlveqmkU=
X-Google-Smtp-Source: ACHHUZ70q6VeDHAFtO+OUesCZqTkjq+wbknULxtRag2Yt6uovftqjWHRAYTi0b1mm8Eoie8Y/cb/1g==
X-Received: by 2002:adf:f00f:0:b0:311:108f:16d0 with SMTP id j15-20020adff00f000000b00311108f16d0mr17927682wro.4.1687394795880;
        Wed, 21 Jun 2023 17:46:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d65ca000000b002f28de9f73bsm5645796wrw.55.2023.06.21.17.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 17:46:35 -0700 (PDT)
Message-Id: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jun 2023 00:46:34 +0000
Subject: [PATCH] docs: add git-hash-object -t option's possible values
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

For newer users of Git, the possible values of -t in git-hash-object may
not be apparent. In fact the current verbiage under NAME could
lead one to conclude that git-hash-object(1) can only be used to create
blobs.

Update the verbiage to make it clear the command can be used to write
objects, not just blobs. Also add the possible values for -t.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    docs: add git-hash-object -t option's possible values
    
    For newer users of Git, the possible values of -t in git-hash-object may
    not be apparent. In fact the current verbiage under NAME could lead one
    to conclude that git-hash-object(1) can only be used to create blobs.
    
    Update the verbiage to make it clear the command can be used to write
    objects, not just blobs. Also add the possible values for -t.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1533%2Fjohn-cai%2Fjc%2Fhash-object-documentation-update-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1533/john-cai/jc/hash-object-documentation-update-v1
Pull-Request: https://github.com/git/git/pull/1533

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
