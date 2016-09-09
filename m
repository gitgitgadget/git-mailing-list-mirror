Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8711F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbcIIRgx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:36:53 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36285 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbcIIRgv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:36:51 -0400
Received: by mail-pf0-f178.google.com with SMTP id 128so31363543pfb.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=VIvlrIP5F/eMMMVGPflttUYqLGF5kxaoPE+kgOe4QM4LU+FmmknFng8134zAwcsysm
         rAUUT3skS4qSWyRSAbHTROIBzWRtw3ep9lUGKkNjnoGiS3GUgg1+E3/f31HTDkHXDdG+
         Y47vs6qbSJIOubblFmBuRtMvzB6AVn6lyNcD6LMEfxFo47Akm8Dlct9ETHkXHQl9VbvV
         6y3CNJOGQ+HGrrzBZCvQZk+5dmhpp42vVbyzKpHjrU51bWXh/rBsmU98FpCNM1fQfbSZ
         48tIESaP52BJJHLb7YcQDnFpf7MvTqZKr85bXZUhX7rz/ww3t/moJu72Y69pf0vTG5ON
         scPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=A59viY0dXUnfZgx5FTD7ZSEFb+7AEgHGgMU2uFwONX8=;
        b=QvH6XOG5oE/MJ034XC6ZFOZDsnx0NhWGdenOxM00GvDtZ+4wP+QMcN/w2uyvRv1KM+
         cRWxAq4hXeQqtPw/g9+84vuZRo1okeNYwQV1W86OHf4BnV7rGzIy8+NHqJ4b/CENz5we
         E/rYBaGYOsti1UTFdJgF+EMJPnXHfhtFEeKSXCykjrqt1/RJ6Wk1jiemZsIekRw+NTUm
         Wa3EBMvq9NR1PS34l+eyZQvZ36kvq1PqrlSwg9tns5d9gE+2v0d/VMRKrzIwRN2zT0L9
         7P8EnaD/El68bdk558aUWs2KKst5fW8ELMzkjVJ/sAcBvbbSPZJwvW88Z6+MrvOA74rj
         L+vA==
X-Gm-Message-State: AE9vXwM+mJc06sl7gUdMTMDq/MmtJemdLoYyX535en1fQDnhUMcpHCLZgo3uYdkVQjUSW5Tu
X-Received: by 10.98.13.215 with SMTP id 84mr8512304pfn.105.1473442610199;
        Fri, 09 Sep 2016 10:36:50 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id d5sm6759803pfc.4.2016.09.09.10.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Sep 2016 10:36:49 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        spearce@spearce.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 1/3] tests: move test_lazy_prereq JGIT to test-lib.sh
Date:   Fri,  9 Sep 2016 10:36:28 -0700
Message-Id: <37c4e775948b88b2d5af1caee3a70e36f00bc88a.1473441620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1473441620.git.jonathantanmy@google.com>
References: <cover.1473441620.git.jonathantanmy@google.com>
In-Reply-To: <cover.1473441620.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com> <cover.1473441620.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This enables JGIT to be used as a prereq in invocations of
test_expect_success (and other functions) in other test scripts.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5310-pack-bitmaps.sh | 4 ----
 t/test-lib.sh           | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 3893afd..1e376ea 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -158,10 +158,6 @@ test_expect_success 'pack with missing parent' '
 	git pack-objects --stdout --revs <revs >/dev/null
 '
 
-test_lazy_prereq JGIT '
-	type jgit
-'
-
 test_expect_success JGIT 'we can read jgit bitmaps' '
 	git clone . compat-jgit &&
 	(
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d731d66..c9c1037 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1072,6 +1072,10 @@ test_lazy_prereq NOT_ROOT '
 	test "$uid" != 0
 '
 
+test_lazy_prereq JGIT '
+	type jgit
+'
+
 # SANITY is about "can you correctly predict what the filesystem would
 # do by only looking at the permission bits of the files and
 # directories?"  A typical example of !SANITY is running the test
-- 
2.8.0.rc3.226.g39d4020

