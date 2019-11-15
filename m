Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6196C1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKOBBE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38210 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKOBBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so5475796pfp.5
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PFEvRltT5TmyfiZy9WFNgCopChrgcKm/AZMM3ekUtiY=;
        b=EgdiXd4iYkDjEjlkCIhsKWrkN6OEb3gjk7NoG0SApMHkQr+JiRZYcCsqyNSYnaS7YD
         6sxnJrGPGdmZfqC7zl/V/zZuOYTp/ou+yl+k9vNHH3aMYKWe8/vPDwLe9KbR6Cr8JpuO
         n/hgXxCI7hpdcUgWSl19yHIYtkPQC8wE2z2GHzbkCe0+v2eub7WE65PZ+S6suS69Ij/0
         AYS6sIIywGCctRt0V5+W0pLiuN7Z2fYfmEv5U7vW3jr5CzPf6unYNy4wu5cu2D2CnOv2
         e6gcPlAUdKGWiItmFy9OwO5Hb1YCkP0XCd4BMGKtfBcIo056FjUvot5M/O/hDIy/PBQn
         OXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PFEvRltT5TmyfiZy9WFNgCopChrgcKm/AZMM3ekUtiY=;
        b=svs0t/20L5lq1ftGiulHLhIskszR3h8vKA8y+61VlqyvMhthGmUcCuHZTysXiCKP+X
         /N5WmqH4SL7xJpj5uPt0bTevLRnN+Pywd10eBmsZwwB9A1EMfUVBmZJwP642jyHbKH69
         O97FsRKQIAw5ysGJ7dFcfdTvgeRTvC2In7SQffws2pMbexahaXiXZ+nsUbqWGo+s23Zt
         42/aFO1zWI149svHai4K+2LYrac/qJvyDyULceBj/EB7mwrcs7gWdbmezj/zRd3RLSLP
         eJB2PM+L8dxS+2CuRJdPvltrvESYrHwbxGxOflmHqsZ5k1xJRCMz7DqgKShrh6sXN+84
         qVPg==
X-Gm-Message-State: APjAAAXBcAfTnheloGoErcsxZ520oh5Cgyb+QXellrCTm8IoTrBXRGc8
        supLf9rdLbvA2PhjJYRfIUvyxuI7
X-Google-Smtp-Source: APXvYqxePoWvjclwPN6Hn0HEwXtpncVCcAWbLLdwfpnWky34Rkr1EzxEpFIMIBKf2LgsUKnWFBPpbg==
X-Received: by 2002:a17:90a:9dca:: with SMTP id x10mr15812605pjv.139.1573779661480;
        Thu, 14 Nov 2019 17:01:01 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id g3sm7521995pfo.82.2019.11.14.17.01.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:01 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:59 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 12/27] t5317: use ! grep to check for no matching lines
Message-ID: <52836aa59a84bf61781cd3501679011a36ac41e7.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several times in t5317, we would use `wc -l` to ensure that a grep
result is empty. However, grep already has a way to do that... Its
return code! Use ! grep in the cases where we are ensuring that there
are no matching lines.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5317-pack-objects-filter-objects.sh | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index a8bbad74e2..dc0446574b 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -45,12 +45,7 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 	git -C r1 index-pack ../filter.pack &&
 
 	git -C r1 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
@@ -149,12 +144,7 @@ test_expect_success 'verify blob:limit=500 omits all blobs' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1000' '
@@ -164,12 +154,7 @@ test_expect_success 'verify blob:limit=1000' '
 	git -C r2 index-pack ../filter.pack &&
 
 	git -C r2 verify-pack -v ../filter.pack >verify_result &&
-	grep blob verify_result |
-	awk -f print_1.awk |
-	sort >observed &&
-
-	nr=$(wc -l <observed) &&
-	test 0 -eq $nr
+	! grep blob verify_result
 '
 
 test_expect_success 'verify blob:limit=1001' '
-- 
2.24.0.399.gf8350c9437

