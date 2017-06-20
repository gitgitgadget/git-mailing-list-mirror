Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14CD20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbdFTH5E (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34530 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbdFTH5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:57:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id f134so3649075wme.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=at9C7YIrOQT+xgPZ/kq93XHwqHhJ7n2seWGbawSN8a4=;
        b=N5zKMoRJSIEDa8EOnzPDENaoPyXhbcIIEDFPkog6Wrk4YaYzflBzeDWnocVg0PdMgn
         zY/i9SJjB82bUIr4KRiSh2dzZZ7ltTdzXJIjk7VTZcXM7X7QD7CB2aXuHuyOZLXLt7WH
         CyIT2/MpWKxVXPXASi3Mn0HbYPGSWTC7bzwKgdcRxMXou/B/O7Ygrrw2WugIMU+AQpGo
         hyZTI4o3AOv/iLWHze3sueNlVi2dNdmLhLypjXtRf9PSwcoOwdjhK5xHfHYPCjFN8fTl
         LRf/LHWcmUqPyadeyuZyFbsY+8ClKcg5h+UKzfgyE1HQKz5DSuxpQZymvF/cwoDNbeCk
         yaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=at9C7YIrOQT+xgPZ/kq93XHwqHhJ7n2seWGbawSN8a4=;
        b=iWyped7WTAXKMdazwN4W49VGvppl/Eik39yUoXX8KECUCxTRAcd/z8bidSOHR3XKjZ
         S/vdNh3xr8TKNyy+Zyp9ZGk/UHKbVQYzOoMQtEdHUUpW+nUjKSkgHUWb3FHQNnKJUL77
         BYnBEu8HbiVxrkeNHlwjp2E3I9Msf5rpEzRsgdNY5FjMkalx3EAy2qs4+LnxBpkuJgW/
         eOyMWbu6bPtkWR9CVbWaWVgwhS0utDFxDtrE9eIa7JMS+idVrWh3Tpzl1Jf3JosY4RUg
         vHu7nrG8kjMiRt3NvMOBbPExta0z6sOinUEBKcdpBPXCtLKfdu2p2G61WFE7FosONwuL
         NUYA==
X-Gm-Message-State: AKS2vOyZwdhs/GFZSiV0wQ+CpGwUEwss8VHUllNIprcDQMlu0aP5Z3tj
        0rNrB8lfF1Yreu1H
X-Received: by 10.28.13.211 with SMTP id 202mr1683577wmn.23.1497945414537;
        Tue, 20 Jun 2017 00:56:54 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:54 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 48/49] Add test for 'clone --initial-refspec'
Date:   Tue, 20 Jun 2017 09:55:22 +0200
Message-Id: <20170620075523.26961-49-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t5616-clone-initial-refspec.sh | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 t/t5616-clone-initial-refspec.sh

diff --git a/t/t5616-clone-initial-refspec.sh b/t/t5616-clone-initial-refspec.sh
new file mode 100755
index 0000000000..ccbc27f83f
--- /dev/null
+++ b/t/t5616-clone-initial-refspec.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='test clone with --initial-refspec option'
+. ./test-lib.sh
+
+
+test_expect_success 'setup regular repo' '
+	# Make two branches, "master" and "side"
+	echo one >file &&
+	git add file &&
+	git commit -m one &&
+	echo two >file &&
+	git commit -a -m two &&
+	git tag two &&
+	echo three >file &&
+	git commit -a -m three &&
+	git checkout -b side &&
+	echo four >file &&
+	git commit -a -m four &&
+	git checkout master
+'
+
+test_expect_success 'add a special ref pointing to a blob' '
+	hash=$(echo "Hello world!" | git hash-object -w -t blob --stdin) &&
+	git update-ref refs/special/hello "$hash"
+'
+
+test_expect_success 'no-local clone from the first repo' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone --no-local .. . &&
+	 test_must_fail git cat-file blob "$hash") &&
+	rm -rf my-clone
+'
+
+test_expect_success 'no-local clone with --initial-refspec' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone --no-local --initial-refspec "refs/special/*:refs/special/*" .. . &&
+	 git cat-file blob "$hash" &&
+	 git rev-parse refs/special/hello >actual &&
+	 echo "$hash" >expected &&
+	 test_cmp expected actual) &&
+	rm -rf my-clone
+'
+
+test_done
+
-- 
2.13.1.565.gbfcd7a9048

