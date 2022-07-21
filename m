Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B555C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiGUGwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiGUGv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:51:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB4735B1
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2673559wma.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXEF0/zGnTx4FKulkwLg2SyqpooceB1JYEy/R0Q7Bdg=;
        b=qtT5vxNSoZ3PKQ8x9CYnCTe58UwJvoOARvCLmIotSKWbeg9JgVheFRgVbXaope26OU
         1/OmQzhWwOVNd1HORMjvYXI9A8Di0qBhKIPlv81VAnaj2eWzIIyB7kPeIBOk+B7D3IlZ
         qZvSgcypdeaN4VyJs+UyJAiaizuFYrqV5jJFFuXWCPfku/ktGcNo8qC8DfZboLe6VtWG
         5AFXqjsPX+f+H0lDxBaHsp6CQDIlH/DLmGowIusxea2owT7ns8cfu19tcg86/IS45gzj
         RbBtGAgYV1EgGft1ZVZtCYgqBk8odoA24RC7SCgy7Fh0KT150Hil/hGtd4svwABi4kwF
         elpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXEF0/zGnTx4FKulkwLg2SyqpooceB1JYEy/R0Q7Bdg=;
        b=1KRMpU2h0QL4NyDxUGyQRTDQr6BnevMzm8iDALE4Uwf7NJiRLC0om9X8z+hNPy+QDA
         WQC479cnKxVwftJI9Lzq4OZz05f4ydUCJIoVFZ0hENzBqc4G4TgfzpUpXCDnfIQ70Jmz
         JBnBUp3BpgRc6usWNBZ4/UslH8RwwD5rEE6P9wI9pLYfIUmAzOfTlYMKyRYy+Nr3qOAZ
         4bvXMVz8IpzFHCk6w/PQv1eO3lTL9iYB1S/f2r6NCPK4Nv6Bh/dZz0K13kvBcplQrQLw
         VxSrsF9sxeDE7fAZqNq+fyOePCs95psCfXCeliyrWYx62908Xk2xlhpOC0D7XUGPIPMK
         Ebyg==
X-Gm-Message-State: AJIora9yc5nqOJqxpHso+rxJpj7ieOncPdQxd4wmN8zK+o9UNMCW2WOx
        0gDn7pmkeq4OAB17n/S1a8lvzHVxTsD4CQ==
X-Google-Smtp-Source: AGRyM1tOoCBl8GdVS3XJrqqJm7Oik+M/OeA5dBhJ7JEmJpT/N/oHBKJXzIGudbotrctypsxGAaJSjw==
X-Received: by 2002:a05:600c:1e1e:b0:3a3:b97:91b3 with SMTP id ay30-20020a05600c1e1e00b003a30b9791b3mr6936310wmb.25.1658386314042;
        Wed, 20 Jul 2022 23:51:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n124-20020a1c2782000000b003a2c67aa6c0sm1006746wmn.23.2022.07.20.23.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:51:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] merge tests: don't ignore "rev-parse" exit code in helper
Date:   Thu, 21 Jul 2022 08:51:42 +0200
Message-Id: <patch-5.6-563666f9426-20220721T064349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the verify_mergeheads() helper the check the exit code of "git
rev-parse". The "$rest" variable added in 274a5c06d52 (merge: record
tag objects without peeling in MERGE_HEAD, 2011-11-07) wasn't being
used.

Such a thing is needed to support the .git/MERGE_HEAD format in
general, but in this case we have no such addition to the line. So
let's compare with "test_cmp" instead, we can always add back this
"$rest" parsing if it's needed in the future.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7600-merge.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index f0f6fda150b..3682d6f9d4e 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -102,12 +102,11 @@ verify_parents () {
 }
 
 verify_mergeheads () {
-	test_write_lines "$@" >mergehead.expected &&
-	while read sha1 rest
+	for rev in "$@"
 	do
-		git rev-parse $sha1
-	done <.git/MERGE_HEAD >mergehead.actual &&
-	test_cmp mergehead.expected mergehead.actual
+		git rev-parse $rev || return 1
+	done >mergehead.expected &&
+	test_cmp mergehead.expected .git/MERGE_HEAD
 }
 
 verify_no_mergehead () {
-- 
2.37.1.1095.g64a1e8362fd

