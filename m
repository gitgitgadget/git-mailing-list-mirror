Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F9C7EE24
	for <git@archiver.kernel.org>; Tue,  9 May 2023 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjEITTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEITS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 15:18:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA21422B
        for <git@vger.kernel.org>; Tue,  9 May 2023 12:18:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso4103163f8f.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683659934; x=1686251934;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZhFDGmqjC6o6CL26mgnGBnxyvAceRWz2SgtOUWsswA=;
        b=WdAXpugOfPf5oPuTIlw+8mlMChg7sLnouJ9aboMMg4q3bEhBpNZ4hqDLgl6hLorYj5
         1gIL0j5qjLcheZ5d5gskt5m/XJM07PjzKFTKIGBLr3RBpMfX5CP2v+MYKYc0ByB0pifi
         U6amvaS6tFYlbkKqxzqrzt/cQgdI2D6UdojnhLoM8Gojf8o3L4EVOSYVYfJiBo1552VZ
         3iU4NLXlzQLcEuVJwTOXAwz+Cb0lnly5/mpCZ85uV5fTY5k9+tGY1VGAiqJWzb7icteD
         PWAs1hkfQHQM3k5Q8gELFuEzEyRAUwGbJjXK2pmTHl6lPfwyNEjWT5aiQzIBiyYtJVE8
         vBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683659934; x=1686251934;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZhFDGmqjC6o6CL26mgnGBnxyvAceRWz2SgtOUWsswA=;
        b=LZpfiPcAqR0i56mNxmYkn1c6CuoSnt61uHSQ40rZLe9xDZAJIxC3cDzeMWlWLWg1EM
         nZtFnR4dfIA/dtrokOwXwMajx1tIN1ejLDrAo9y3FQE+M6zkT5fvO6saVOvNUyj65S23
         ichRQAEiH2czSug/67HuIXM5HlUjfzjAIviCFrGLFYIoEvUznR6ThdFTiFUxWER5phEE
         8MfOMfwkirMJzvfePRx9Yo7yhpCcxZl+ozeIaC9y3Id+lPUZVkZn5QnnzmyiPyolu0+7
         yRQw8xWn+gcEN89Bu62TS1zFzbsAUG9sCfuOvjAkvTEvF5PMdT44oyROA566N6bTtWLL
         PsOA==
X-Gm-Message-State: AC+VfDwlC/oWE0sITfru8NZjRY2Z/11nvbnLiErlvZR5QPABuAaZm41B
        +EqKlxsUAeQV1gO1UjPcXQLHL/7WHjE=
X-Google-Smtp-Source: ACHHUZ7FX69/0XElxpr4Ug5Kk4oWn9NH2ZVKVQ+LtNZgljgRT4AoKEGCa1RVzWL3n/ViFgHNTs/AOw==
X-Received: by 2002:adf:ee84:0:b0:306:3261:809 with SMTP id b4-20020adfee84000000b0030632610809mr10495146wro.50.1683659933905;
        Tue, 09 May 2023 12:18:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4843000000b003047d5b8817sm15192939wrs.80.2023.05.09.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:18:53 -0700 (PDT)
Message-Id: <0b40b24b95d81cbc956eb4c7761e043c16a00be0.1683659931.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
References: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
        <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 May 2023 19:18:49 +0000
Subject: [PATCH v2 1/3] docs: clarify git-pack-refs --all will pack all refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

--all packs not just branch tips but anything under refs/ with the
exception of hidden refs and broken refs. Clarify this in the
documentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-pack-refs.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 154081f2de2..e011e5fead3 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -49,10 +49,11 @@ OPTIONS
 
 The command by default packs all tags and refs that are already
 packed, and leaves other refs
-alone.  This is because branches are expected to be actively
+alone. This is because branches are expected to be actively
 developed and packing their tips does not help performance.
-This option causes branch tips to be packed as well.  Useful for
-a repository with many branches of historical interests.
+This option causes all refs to be packed as well, with the exception of hidden
+and broken refs. Useful for a repository with many branches of historical
+interests.
 
 --no-prune::
 
-- 
gitgitgadget

