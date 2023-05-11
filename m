Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C8FC77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbjEKVTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbjEKVTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16792D62
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f423521b10so40440255e9.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839980; x=1686431980;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzwX/7LRE0ikv3RBydDvvvCjp0wBMjNjtlRHqkAo8cM=;
        b=eNz3ztpR3GvQqBIWaTGerWEh7ktnwKzJH/hnVToR5/DBNIr4Q6s3O3OWvXogx4RCed
         4zjufws9Mr380EVLyrhaBw8vvWxq4jp8UZPZVGWt/RLZFYL0JjqqhngTGJTrZBHMDGWj
         RGHINcTrx3kAwmdCWBIWvMRnR6V45zTayHK3tv0MCbs/FHsBzhywwiOXFZN312UKLafY
         vyzW3ASHJfCVAoU1HfdVvFGatGNLdj0gCluGA9KTX4WvnlF07E274YyfciDiqP/ynfDv
         ZrEoNzD88r32sBebWtZoXTdvfa0v+q62kqMJFtWQ68Uqwgzib6e2aFFVqfvoGQnpiKkf
         UXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839980; x=1686431980;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzwX/7LRE0ikv3RBydDvvvCjp0wBMjNjtlRHqkAo8cM=;
        b=PAvR5BUk7QcY2J5x7TxNm1FzUgJZgwm65iQc5era16kMr/roSboiu7/nc02IPPIxRh
         QzmPhVAJV8v7IPMlrSOAJEaiVgCkXtc+/empR1U3f8eYQ0iwJC1lKZ36E0t99XoLFKJy
         a4QiNmco2OWL09SmnyIHdPvwewZCtjjMq44ocm+8OVFDR5qSjGGVXaVKFIC69KNonIvn
         Zxt/fJXqr4DfqLRROYup063dx+bH9d84MYv52KXsPP8VcdfK5Vh3zxWi1hsA6RB/acAF
         WvbZkw5eVqmr9NG2nNsGIDdnBzYQ3fIoHSk2lClwQfVSp1TTqcoNIJt5U7Z+mKbfHB+Q
         7S3A==
X-Gm-Message-State: AC+VfDynU/Gjmgy5VJD37vlb8fLInBO0LGhvwj121dKJBm3Vz52pbVZn
        lgF3J/PXlQ0cnn2OQbj6YPBSGO6Q8+k=
X-Google-Smtp-Source: ACHHUZ5BIZfumVEwHiNclRMNtAN4PMbAV+IxFllB0kDh5bBEuiS6BeFV9So+k/gY/nkM6ty5B44H9g==
X-Received: by 2002:a1c:f402:0:b0:3f3:3a81:32b with SMTP id z2-20020a1cf402000000b003f33a81032bmr15890649wma.15.1683839979781;
        Thu, 11 May 2023 14:19:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bc8cc000000b003f4e4b5713esm4100221wml.37.2023.05.11.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:39 -0700 (PDT)
Message-Id: <dd7e29fcc214ee9cdb9737f5378bfde14465609f.1683839975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:31 +0000
Subject: [PATCH v2 5/9] doc: trailer: remove redundant phrasing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The phrase "many rules" gets essentially repeated again with "many other
rules", so remove this repetition.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 8766edbf4dc..495d5c9bcf1 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -71,9 +71,8 @@ inside or after the value. The value may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
 the "folding" in RFC 822.
 
-Note that 'trailers' do not follow and are not intended to follow many
-rules for RFC 822 headers. For example they do not follow
-the encoding rules and probably many other rules.
+Note that trailers do not follow (nor are they intended to follow) many of the
+rules for RFC 822 headers. For example they do not follow the encoding rule.
 
 OPTIONS
 -------
-- 
gitgitgadget

