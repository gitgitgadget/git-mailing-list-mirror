Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2492203E0
	for <e@80x24.org>; Thu, 21 Jul 2016 20:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbcGUU7N (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 16:59:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33975 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbcGUU7L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 16:59:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so3732631wma.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2016 13:59:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6heSC/Lw+0uPsL/tjZecMv1FOQ1OqxisnRB35cew4Xc=;
        b=qCcdH8wUDIYu9jSNVTpcjfHWJ350aseEmz7WfJjizgJ0P7WAdaVvmfMOv9r0xCI7no
         25Zlb9V+fKnk8G7TTjKDDG07FBO5hF8DQa1r4J7g0PQCZnK0ByteD32A0pBNBC2R5kEm
         efgZ5Z6zSsGUSKOGb9GhUr9wc6ue4H0k3dLcJPMuAIbuD0QAjmSdrrZJXVLathWPrSYa
         s7BdfBo6E3idtIbgMY1aQgkXbhvWEp+c1YEg2gnsnjx6VylyhO5cvMN21z+mv+jglCmU
         0HXAMZ8toxiiqqqdO52DuJ9kdJTZDAkb4uC3aqgYwNBWb8PyV6EbyvfonH6UvG2PJMUE
         uJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6heSC/Lw+0uPsL/tjZecMv1FOQ1OqxisnRB35cew4Xc=;
        b=EeQE2ewNUO+E3CasnDrI3Cix+/mZdLeSbp3l5fEgeLKJM/IngKDPqAV9mvEzi9tmOE
         fqzRJrvCoEHn6VXyNbXBvPVrktrETn38Z0B6Qe5EHv81zjO9sbC8n5AOWTv5g2LVpnuS
         tWkIllssmKGSNgVQBqg2fqLB2isj5bXwkT0W3R3PqzvV+HtFC/02/wZiGX4qYn0nLx1Q
         fR9C9IceuSpLqyvq9MavuwOnJShxI+eoujs5HTXZGTji84AbCl6lkFocWPxSrjgIA5X+
         OfOmJKfgRQKuvCO87OICQiZHdv+eB5T6+jLZdAe9CuNF8N7jY2yc/v3NzkwTk/QC72ik
         8AtA==
X-Gm-Message-State: AEkoouumWBtsckstZX+KVLw4Gwi2hBB6fwEY4f0pUf9Qfh5oOneY0GLce2FFGEH5mMrzzQ==
X-Received: by 10.28.208.140 with SMTP id h134mr395896wmg.101.1469134749398;
        Thu, 21 Jul 2016 13:59:09 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB7915.dip0.t-ipconnect.de. [93.219.121.21])
        by smtp.gmail.com with ESMTPSA id n131sm4118733wmd.3.2016.07.21.13.59.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jul 2016 13:59:08 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] convert: add test to demonstrate clean invocations
Date:	Thu, 21 Jul 2016 22:59:07 +0200
Message-Id: <1469134747-26785-1-git-send-email-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.5.1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If three files processed by a filter are added and committed to a
repository then I expect three clean invocations per Git operation.
Apparently Git invokes the clean process 12 times.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

It's pretty late here and I hope do not miss something obvious... but
can anyone explain to me why the clean operation is executed 12 times
for 3 files?

Thanks,
Lars


 t/t0021-conversion.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 7bac2bc..ab3d299 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -12,6 +12,12 @@ tr \
 EOF
 chmod +x rot13.sh

+cat <<EOF >run.sh
+#!$SHELL_PATH
+	echo "." >> run.count
+EOF
+chmod +x run.sh
+
 test_expect_success setup '
 	git config filter.rot13.smudge ./rot13.sh &&
 	git config filter.rot13.clean ./rot13.sh &&
@@ -268,4 +274,28 @@ test_expect_success 'disable filter with empty override' '
 	test_must_be_empty err
 '

+test_expect_failure 'required clean filter count' '
+	test_config_global filter.run_count.clean ./../run.sh &&
+	test_config_global filter.run_count.required true &&
+	rm -rf repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+
+		echo "*.r filter=run_count" >.gitattributes &&
+
+		cat ../test.o >test.r &&
+		echo "test22" >test2.r &&
+		echo "test333" >test3.r &&
+
+		rm -f run.count &&
+		git add . &&
+		test_line_count = 3 run.count
+
+		rm -f run.count &&
+		git commit . -m "test commit" &&
+		test_line_count = 3 run.count
+	)
+'
 test_done
--
2.5.1

