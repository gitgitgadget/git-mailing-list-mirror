Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F156FC001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjHJVSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHJVSI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF402738
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so12337765e9.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702285; x=1692307085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5C2RUivRPkhjM3FHZHrxtCNM82473MLJmyqe8BS37I=;
        b=EKIXQ1IKW7oRPMDi7pjDfNjWS7FBElJw0xLdA4b1LiwFkzD3ZcMJVihPe4Byd9384W
         0jBLTqN5C2dnHtppNs6JJvK9g+D0Kpwadw687kGLDE7Q8UaeAJdakbiNKT5XKbTLzMh3
         pV/1WFyJN41aoq39vtM8vAgwX5qj5G8+m0azNiYn6UPDdtqHLHxxGEI2uh4T1WkFSIHp
         FNf6llqLX/DzUgWaC9pehQMeqsYgDeYqbH11SrHe1xVm/TbDdh/LkRKAnXfmfOWfDd8p
         ItzFFEE2U+v63Fl4wQYrAUtAnVi2RkG0XezTGp8JsqsJ+YD7K0xWb+rSudJTjpjJ9ZQH
         xXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702285; x=1692307085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5C2RUivRPkhjM3FHZHrxtCNM82473MLJmyqe8BS37I=;
        b=SZHiHyJ26LADgAwsQd8/jbqxFABz7ggpsE6N5W4CrqgnfJri8yVYmtqQh9q/mZnykT
         RqE+nZOJqp4D7uvG5fjZiYO64XI4GsXV0fwzuiw0dWsfJqcunrKGgmLP13kgGIX+i6dj
         ODJ22nrQpSQKL6jHLKMQLoVt0diZh4R+oSkpvbfVZTuSD79l3hX84tnS5uJc57j75Yya
         k/ereut6nZYCbvewBT+FdvmnXn9jDKEOkTkCB5mfjEvkjDHHyT9lVDrwIL1ELmN/DACz
         Y6j88PM4TF2MZVHs90yiQswb4MevQnN+X7SlT/eZWEgmJ3Rs/uWUvbbGb92zMpHw/3+g
         vO6A==
X-Gm-Message-State: AOJu0Yzj+2g8TZgLgY97eXbn4QrUy+X8KrFOmIKBN+FyU6FZihYHIVXo
        ers3Komgm0KnXsP5q/DoQvD/JERev+I=
X-Google-Smtp-Source: AGHT+IHD58Ob+8TmhEQ5sUAFWYuzyRIrxj6yU6d5q7Um3MzVJtpEOjTuilW755fymIWBFfBQLaeNKQ==
X-Received: by 2002:adf:ec4d:0:b0:317:e68d:f862 with SMTP id w13-20020adfec4d000000b00317e68df862mr2748357wrn.37.1691702285583;
        Thu, 10 Aug 2023 14:18:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b003143c9beeaesm3249453wrr.44.2023.08.10.14.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:05 -0700 (PDT)
Message-ID: <f680e76de847cf88fc4e4d63844829c6b344a697.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:17:52 +0000
Subject: [PATCH v2 02/13] trailer test description: this tests --where=after,
 not --where=before
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/t7513-interpret-trailers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 5b31896070a..ed0fc04bd95 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -792,7 +792,7 @@ test_expect_success 'overriding configuration with "--where after"' '
 	test_cmp expected actual
 '
 
-test_expect_success 'using "where = before" with "--no-where"' '
+test_expect_success 'using "--where after" with "--no-where"' '
 	test_config trailer.ack.key "Acked-by= " &&
 	test_config trailer.ack.where "before" &&
 	test_config trailer.bug.key "Bug #" &&
-- 
gitgitgadget

