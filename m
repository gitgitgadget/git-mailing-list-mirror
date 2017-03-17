Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54C5420951
	for <e@80x24.org>; Fri, 17 Mar 2017 14:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdCQOs4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 10:48:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33618 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdCQOrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 10:47:47 -0400
Received: by mail-wr0-f193.google.com with SMTP id g10so9871574wrg.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiO3BY1NtFoO45qPr0jGeanpgh+sY9qOQTKjNh07My8=;
        b=UMLcx8Pc7NENxQQ402hUCjrXnWMAB6i/5k421jx7ZiWzw0HoDOtSnxBdvnDJVxK28d
         jxfvjDQIBpQ7AgYKvw4RvchJQGGgdIsCryTzK53qo0uDKwtvZGTtac7Z1sgcrPfa701/
         J+BC+kPGITFm+IK41aOuvNWe6eNpv7fmSqGvpd0DB/LvlPTrXml4CNNrelvmPhG7EErA
         oGcbYaxh5NpkSLzjVRYQ/q7WuF2jIvp3PHYhpLDXgbiVhP/RkUqBHShoFBONdt19bZ+U
         id9za5Qn64igEIP2mG8k2qvhjOC9TNrIt5wLnQj/GhAH/7MBe73ZYBDniAfIuz71WPVO
         4oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiO3BY1NtFoO45qPr0jGeanpgh+sY9qOQTKjNh07My8=;
        b=DfaZWHEFg9hXxihjp2VPAXxSMQVGNuBQjwxac2cs4AJttVqOiCzTHnLzX75aWqtSDE
         GkGh700ZK1K+HXDRTvGmviZabJfIxsXBiwAYtl5/8hvr/+lYBeU6hUKVU/AcsgwrIEYX
         8+wv4Zn9lYWq8fgRpkzxiEj+xlkAlsszQ5xGsic67LsCx1IQEeA9lxsTwnLf7eGRBJJ2
         +CYIEfbeZ1R0MFUr/D765HCINeyp4UHNaNWqvGoaVlzHlahY16SyD7ZxTrdtGxYoE1u8
         WLR6skNJJL4uMrZ8DW5/eEdBLGpRhd5VO75eUexS8bcpDPUcBFoQxWWHpg1JBRp+AN8k
         DHDg==
X-Gm-Message-State: AFeK/H2WU0v2g540KLoOI4QcvQSJvUm6hcRsxAF9yMGDc2ZrIFFbjsIcfZ3TW3GnwsLnvw==
X-Received: by 10.223.162.18 with SMTP id p18mr13406283wra.7.1489762020420;
        Fri, 17 Mar 2017 07:47:00 -0700 (PDT)
Received: from localhost.localdomain (x4db271c7.dyn.telefonica.de. [77.178.113.199])
        by smtp.gmail.com with ESMTPSA id n11sm2894406wmi.32.2017.03.17.07.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 07:46:59 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] tests: create an interactive gdb session with the 'debug' helper
Date:   Fri, 17 Mar 2017 15:46:46 +0100
Message-Id: <20170317144646.9349-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.0.375.g7a2ebd56b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'debug' test helper is supposed to facilitate debugging by running
a command of the test suite under gdb.  Unfortunately, its usefulness
is severely limited, because that gdb session is not interactive,
since the test's, and thus gdb's standard input is attached to
/dev/null (for a good reason, see 781f76b15 (test-lib: redirect stdin
of tests, 2011-12-15)).

Re-attach the original standard input in the debug helper, thus
creating an interactive gdb session, which is much much more useful.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index bd357704c..9567dc986 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -154,7 +154,7 @@ test_pause () {
 #
 # Example: "debug git checkout master".
 debug () {
-	 GIT_TEST_GDB=1 "$@"
+	 GIT_TEST_GDB=1 "$@" <&6
 }
 
 # Call test_commit with the arguments
-- 
2.12.0.375.g7a2ebd56b

