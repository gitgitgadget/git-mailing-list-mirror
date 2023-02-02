Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3365EC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 17:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBBRUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjBBRUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 12:20:06 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC2744B9
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 09:20:05 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id g16so1043639ilr.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOr8w4SCStRdqlAtVkpJqNIxVXmiY4aH6ze0CsLRyG0=;
        b=drowOzTLR9c25ilwV9cMjRLwc0DAPri9o+0T9rklnpRkc3pBO66Gqs1oKF2+QivHA3
         VGFViIr+KSKjxFHuVuXM08cwc/8h5WASMJJ3L2NKOo++NgrlhfAjvUfzofBNCHaeAvXb
         hmpiOJjUIerFlop5XHBsyHsIfrN3Te8gLVNYLRbcFcS5aJPgycFtWGJIM1vm0W5/OzIq
         1o6E4ypVWcqyjKphoYnaPt+iUejDSMQOuDh5PqVEv/8+LB4AJA66JXuFEbQs0xPXJtcl
         v1VZPZQSFDZw3fncMrD4csFgkOd7OuMc7LiDkQmQmifF6y8DLEsbsp6IbIajDscuX2iP
         07tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOr8w4SCStRdqlAtVkpJqNIxVXmiY4aH6ze0CsLRyG0=;
        b=p9zs23eBKVLjGB6J/8vDZiJJJ4DlGCgjjWktdpL9uYLVeBorp8GmYTSQTOH6Ke9dgD
         iKRh1o+6sSi5JyMnFbEb2mGQ8ba73HdGiijWHcugABYXoCFqba1KctV3x7YModBdLnok
         eOpQqooY0ONtI5pFZW5aZBNphdHdPXhEy0lNrVlzeOVI+R5VZG/BWMryyr/gGWkCR+qK
         gyYpGtOSr1ii5RTNJPTiAgFLx0Z1VAlRclnzc6vy8yfnle7hNs2CMCfzKGepY5/6Iu0T
         XLpQAXQzgbbPQ1xD6wwnx0fF/fmbM3+eOS1CVN0EjW6UIfYJntjqF5CjPda3irDt0Vuq
         3swQ==
X-Gm-Message-State: AO0yUKV1qzry9O4AOw95rVCaoprXp60xfvuu+AwY0H49xTfqPRYDV8Ka
        jIARtpMBaIwhIWjnhcwj3c0jrF0KcgjkOw==
X-Google-Smtp-Source: AK7set9pfNfyw0PMyqb5/pgUpcJw9fffPWNNx6ZLzWjPPcFYCtBMrf5yOvarfQqE8q7DmBvNAIWoVA==
X-Received: by 2002:a05:6e02:1d03:b0:310:c411:125d with SMTP id i3-20020a056e021d0300b00310c411125dmr5446837ila.12.1675358404697;
        Thu, 02 Feb 2023 09:20:04 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a3-20020a92d343000000b0030bfdb6ef60sm55887ilh.58.2023.02.02.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:20:04 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v2 3/4] t4113: use "<<-" instead of "<<"
Date:   Thu,  2 Feb 2023 12:18:20 -0500
Message-Id: <20230202171821.10508-4-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202171821.10508-1-cheskaqiqi@gmail.com>
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
 <20230202171821.10508-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

use "<<-" instead of "<<"

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index d84f632bc3..d5b15e97d3 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -8,7 +8,7 @@ test_description='git apply trying to add an ending line.
 '
 . ./test-lib.sh
 
-cat >test-patch <<\EOF
+cat >test-patch <<-\EOF
 diff --git a/file b/file
 --- a/file
 +++ b/file
@@ -31,7 +31,7 @@ test_expect_success 'apply at the end' '
 '
 
 test_expect_success 'setup for apply at the beginning' '
-	cat >test-patch <<\EOF
+	cat >test-patch <<-\EOF
 	diff a/file b/file
 	--- a/file
 	+++ b/file
-- 
2.39.0

