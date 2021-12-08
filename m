Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbhLHVxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbhLHVxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C40AC061D76
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t18so6412509wrg.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GWnJo8DsA3QyYjaZ609A0ySo06L+a0P9CK9sPytuqy8=;
        b=J+/e2RpwNbxg4jXYqrrr/b8U4fZxasc6Qmmm4bpPyXEFiHBq04wtAQd/bJJuQNtpQW
         8wdgLst48waYdwQLjq+iRf1AoXhOZdFtL455fyoHTqpzXop7bixzznIdmME5TZf+PH6T
         DvofWfCSYtoG+CevIjPgjN4U2EFa5C7HipACGzoURqMzW06AkTs5hdyUTMAxo3c1ha/f
         3vwW92GYfjzASDogspKk59KCNtTLp86M+pjovEjsZWQ4Iww2fTo5g2wWqhH57dweYUw/
         webb4TEdYjw2OWPXfhpeLwpWtJrWpjShfnS/6Ej9zF4vnmK17fBVjlwkny1K1sgBb00H
         Cs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GWnJo8DsA3QyYjaZ609A0ySo06L+a0P9CK9sPytuqy8=;
        b=AnM3J5kYIjnUyoIy4OQqEWKE/yhBdb6yVBeZ6NBZMjOP3HQiBsImLYLkRjxwtkNwtW
         yALHqaJI9WwOdRrzAulDNdxIKhO9ShU2o9VDh4ofRNt5xx5WjRmgt33/iWb6DYDtr7Ym
         gy2Vf4pNciMKeE1lJiTxkBXJAUvGK0cJWZ0Uh4WaB8VULBKe1wOjFvMhJWJoHq1G3k98
         Mhe4zI00XIYb6kLFoOR0dZzHXBXUROzwxdFmo5NzVLqhbqkgoWn6uAJTbCmC9eOttGFP
         mhjVI/sZwLTwmvev0GLAGbt6P51qfxRVxZslovwd/0q2DpQYE23arZCyR/m+XJkQXOe1
         EJIg==
X-Gm-Message-State: AOAM532DxNniFSDnmMi0ryfk1wpA15Xu5ZS4eV1DMls9FDznJBhwexAQ
        0dSwS8AA67es4OYVojEZi0w8SFvBTp4=
X-Google-Smtp-Source: ABdhPJxo0ddzZZdyeM3mAu6aW/7x82HeVFBpNZmMHN688svVYYtUY2s+z4OUUyFihpMApWNjUbTwdg==
X-Received: by 2002:adf:b355:: with SMTP id k21mr1435731wrd.451.1639000195593;
        Wed, 08 Dec 2021 13:49:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm4062315wrh.32.2021.12.08.13.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:55 -0800 (PST)
Message-Id: <cb601b51a47efa7df019e386c2ea050b72071604.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:44 +0000
Subject: [PATCH v2 09/11] reftable: drop stray printf in readwrite_test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 5f6bcc2f775..7c40b9b77f3 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -597,7 +597,6 @@ static void test_write_key_order(void)
 	err = reftable_writer_add_ref(w, &refs[0]);
 	EXPECT_ERR(err);
 	err = reftable_writer_add_ref(w, &refs[1]);
-	printf("%d\n", err);
 	EXPECT(err == REFTABLE_API_ERROR);
 	reftable_writer_close(w);
 	reftable_writer_free(w);
-- 
gitgitgadget

