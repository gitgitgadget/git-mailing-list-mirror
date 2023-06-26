Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEBDEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFZQZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjFZQZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A90A10E7
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3113dabc549so5127260f8f.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796697; x=1690388697;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztzLL4KgmrtUPgRMDMXzL1umxszvJ1+RIMd9x/Qs+L8=;
        b=Sq2/VhV7PjiQKkH5xnekbFImO5CRdc2zhwsGTAeNs1k2DKOfhlu7p4x38greEd0mV7
         ZJwp08U3agydX917++mgK6JLSCAHZe9njLER49lie9LMHkEOguFiP334DBmp0YbZuJAL
         lxWTthao2Pu7fCslphctW6SSxxMtOCp8Ledq9Re0miYpgjJdoMoPWrdDX9edQc1/gTIm
         Y1w14rOIg1rAODYuaxUfVAZy4ji5zJLeBJiYGQC8DJinbZFVA4EXFRPBHAQumDIEDK3f
         1EXmd762ww5UgggjqEbF5W3YHC0CVjXqtjQ7pHpzdO9Jy4Rv4CMXW9KXBOIok2UnZRPu
         3X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796697; x=1690388697;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztzLL4KgmrtUPgRMDMXzL1umxszvJ1+RIMd9x/Qs+L8=;
        b=QiuBjXUvCFKWqpqgCiwtkCSnbXavS9Q6mZndmiEJN+Xi+DTPuzor7VLZdC17ZxKvcO
         VKMeDVe3EyxN+3ITjqHIQ56pbCpjNvdR5aVGdjzXkAcVKRseAuvMyAynqAqQ2b6n2gwD
         0z7BweHihcBQTFy1kwPW7k44GXzTfpXUYkSdUyxmksLAzorU+N3EbiMPklyl3u7q8XzF
         183wzk4LYFu1Jd/Ju8kTvXY7lFAlJ7H+B2ewwZwW9Gf8h8P4MouWdnNaeGVj6lEzkpUW
         dGnyZqQKHxpwv26qDgrnTiUJ5igkhIV/7YS834elETj5Qa1UJvoaK/bXttSRfA+YLyWA
         DSng==
X-Gm-Message-State: AC+VfDxep/T4yv24140GRxANdIXHO0jpjqnNFul9ne00ycHqJBen4MM7
        AE8YRfjKVNqSC4NGKPw5hB9tU9c1wwk=
X-Google-Smtp-Source: ACHHUZ4ugUVVMqL4GQwjU3Yj0c20VrsOWjItEioxgcWkCjJgULVhL7+T9Om/+lCUn5MWsRls14xNCA==
X-Received: by 2002:a5d:4410:0:b0:313:f592:254c with SMTP id z16-20020a5d4410000000b00313f592254cmr1921456wrq.34.1687796697258;
        Mon, 26 Jun 2023 09:24:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d610b000000b00313e2abfb8dsm7276631wrt.92.2023.06.26.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:56 -0700 (PDT)
Message-Id: <53b1c348f822ca32228cdb0f40b03c9ae9ec59c8.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:32 +0000
Subject: [PATCH v3 08/24] completion: complete --find-object
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dd6e12ad8f6..392fdbedd9f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,7 +1740,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved --color-moved= --no-color-moved
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
-			--find-copies
+			--find-copies --find-object
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget

