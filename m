Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E6E2047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbdHCJVH (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:21:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36749 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbdHCJU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:28 -0400
Received: by mail-wr0-f194.google.com with SMTP id y67so573953wrb.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zig4fLZVkAb9l40Buc8PPDuhLueChkNl/mu1sb3iQv0=;
        b=DVcbUmgmC2ggmEO9SNrwcrazFcT17+0rntA7nDWjXJoB0ALX5mxERzxqSIMAvnjNx2
         sW6v7uR5ASJAenpE1x6OFqrC2jV+uxiST6xmT3RfbYxB5XTRJg+NQp1YPvFj12XK/5Yv
         UzXgEkxAuWAHuOna4N9oc/25PQWBcf37rT8mHQDu2vOH6atakEqRmQdzf0yutYPNuKTo
         5kLzseK7jmxtyOKP15SyUSqK91OpqJlU8xyeuJojo4wYuaulSadFIF/am8ZMu9XRNgsn
         MdEazJk5YU7OP22t5Y5wfcoZnM52uIQjiT6hF6WJDnzmOKgUC3sjtawh8+9ZF49VLxny
         ocVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zig4fLZVkAb9l40Buc8PPDuhLueChkNl/mu1sb3iQv0=;
        b=MIpLkckAwYIIhh1Krc/z+KInn2LD+WUniE7kuOT7sKZottnWW4wES2uMdP5HsKVFie
         ZAQYuc70ofU5fC0Lz/OXFGZNUjZURRWfV41PbuUGHbgiV/x9WHhdzbdeZnGF/omgUQHO
         BmCFiELSspxexELhlHojjBDNUfVvnf8ruHMgkLDmlH6pJtUb84PRHXCa38VlViQM2dcm
         QbFLo5oDRRJpcSsWupePoLMdc5FyrlBMLHTP3a48uwJzyLxmsLUP0cvOGTaDQB8bG3VF
         YUaPtw/3DGXUqPbNDW0x8pgnf8KEWqmS/KljKeoFpE1UHrF4hrDbTYkyMg9XipwBuFZC
         UPCg==
X-Gm-Message-State: AIVw112gOtuCWT6GPykj7LKfEM9o9Kc0Ln4ATJ4JQz4TYw/wyXRZgok9
        tn31bfclSrTYxL6H
X-Received: by 10.223.130.69 with SMTP id 63mr951528wrb.42.1501752026476;
        Thu, 03 Aug 2017 02:20:26 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:26 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 39/40] Add tests for 'clone --initial-refspec'
Date:   Thu,  3 Aug 2017 11:19:25 +0200
Message-Id: <20170803091926.1755-40-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0420-transfer-http-e-odb.sh         |  7 +++++
 t/t0470-read-object-http-e-odb.sh      |  7 +++++
 t/t0480-read-object-have-http-e-odb.sh |  7 +++++
 t/t5616-clone-initial-refspec.sh       | 48 ++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100755 t/t5616-clone-initial-refspec.sh

diff --git a/t/t0420-transfer-http-e-odb.sh b/t/t0420-transfer-http-e-odb.sh
index d307af0457..ed833850c3 100755
--- a/t/t0420-transfer-http-e-odb.sh
+++ b/t/t0420-transfer-http-e-odb.sh
@@ -140,6 +140,13 @@ test_expect_success 'no-local clone from the first repo with helper succeeds' '
 	rm -rf my-other-clone
 '
 
+test_expect_success 'no-local initial-refspec clone succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git -c odb.magic.scriptCommand="$HELPER" \
+		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
 stop_httpd
 
 test_done
diff --git a/t/t0470-read-object-http-e-odb.sh b/t/t0470-read-object-http-e-odb.sh
index d814a43d59..7355ca4d51 100755
--- a/t/t0470-read-object-http-e-odb.sh
+++ b/t/t0470-read-object-http-e-odb.sh
@@ -107,6 +107,13 @@ test_expect_success 'no-local clone from the first repo with helper succeeds' '
 	rm -rf my-other-clone
 '
 
+test_expect_success 'no-local initial-refspec clone succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git -c odb.magic.subprocessCommand="$HELPER" \
+		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
 stop_httpd
 
 test_done
diff --git a/t/t0480-read-object-have-http-e-odb.sh b/t/t0480-read-object-have-http-e-odb.sh
index fe1fac5ef3..c451d269a7 100755
--- a/t/t0480-read-object-have-http-e-odb.sh
+++ b/t/t0480-read-object-have-http-e-odb.sh
@@ -107,6 +107,13 @@ test_expect_success 'no-local clone from the first repo with helper succeeds' '
 	rm -rf my-other-clone
 '
 
+test_expect_success 'no-local initial-refspec clone succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git -c odb.magic.subprocessCommand="$HELPER" \
+		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
 stop_httpd
 
 test_done
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
2.14.0.rc1.52.gf02fb0ddac.dirty

