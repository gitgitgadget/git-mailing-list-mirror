Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD1720248
	for <e@80x24.org>; Thu, 28 Mar 2019 17:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfC1RRt (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 13:17:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34195 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1RRt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 13:17:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id o10so7752062wmc.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwCkn/HVhD2YhKUCSfTcjbYyFQgaiwYbuGVuEFudRWM=;
        b=ZtHORA7btuxqZbUVqo5Bwj+CDfHiDfZ32VmuylZd8P0VQOojTxAHnz13DNXW2KPj5r
         qISNsvUx8PlHQqKHQ/wrRFPE+whb+EbjCpaQeOQhGZwFnnXN0otAxc9hqea5uoftypmH
         Vknm/sgdgRcRy8Z1hbKCuIdHTYG6/+FqqREJEOibcj2leGbZKs5iFB/KD/hrGUPWqAYJ
         LD4Z7skbgBiL9XdnnsKyfqUBSkK23+Gp2ZFFrf87KpVMKuIkzTZ12leAJgTQKbEiqWpl
         /CbDUWkiq3B1C/G+dx/FQzedEeUyZXov0hh+0fGYw2w4t2wrmuY+L6Adq4X+P2A5QL6l
         IuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwCkn/HVhD2YhKUCSfTcjbYyFQgaiwYbuGVuEFudRWM=;
        b=nIH6tQAo3qUSD+8R72SYwJjFjZxK9PSBwNuE8F8pfBiCVZJtRU9cWc/Mk8mVTFVW3H
         LCupwt0mTkDciEBN7kb+037dEN1bIV3A1BDP5C/ymjXVe8XZdMl7PouO+bpIoXZypATE
         ieZ2YeN7zgxttgFIe4PipaUlspMXfEWtOSzrEFQHawNNDM8fP8Qs0EBgcvhNUO00cGsQ
         w4iDnYuU4n14DbjoRaC19dY/+rD/4LfrBcdG4VJmCE5uW1my0bkS1SqsI+A4HoPAFmZV
         GWzG9LKeUh6qx6wfbi9eDGIWMh7EMAs/17VAIRYjMB6NOv0PVCKYF7oRxYApmrE3sD02
         HRQw==
X-Gm-Message-State: APjAAAXJjIrnzCr2X3Z6Gxu5LBUkoMnDVwLwl093pRk2fgFnVnb383kH
        c9tRDDloca2RewgaB+NQhTU4n2FK
X-Google-Smtp-Source: APXvYqz3CKWXfLvtN2InGWHQJAhXOijOh5WZMn+8KnAHtiVeAoO79z+WPwLWF4rjXR4ihhPB4fXs2A==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr738912wmg.14.1553793466379;
        Thu, 28 Mar 2019 10:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1085:dfe0:49c5:28f4:744c:fa99])
        by smtp.gmail.com with ESMTPSA id d17sm25837369wrw.88.2019.03.28.10.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:17:45 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] t6050: use test_line_count instead of wc -l
Date:   Thu, 28 Mar 2019 18:17:20 +0100
Message-Id: <20190328171722.9753-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.68.gd997bba285.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This modernizes a test and makes it more portable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d638119750..41b177936e 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -393,9 +393,11 @@ test_expect_success 'replace ref cleanup' '
 '
 
 test_expect_success '--graft with and without already replaced object' '
-	test $(git log --oneline | wc -l) = 7 &&
+	git log --oneline >log &&
+	test_line_count = 7 log &&
 	git replace --graft $HASH5 &&
-	test $(git log --oneline | wc -l) = 3 &&
+	git log --oneline >log &&
+	test_line_count = 3 log &&
 	commit_has_parents $HASH5 &&
 	test_must_fail git replace --graft $HASH5 $HASH4 $HASH3 &&
 	git replace --force -g $HASH5 $HASH4 $HASH3 &&
-- 
2.21.0.68.gd997bba285.dirty

