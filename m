Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E7C20958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbdCWNNt (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:13:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32782 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdCWNNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:13:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so3113197wrx.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JxTO3+vCQfxfodGM5hl/SBHI1vpkytkSadue8KVWhkc=;
        b=NenQkfnXgj40YnMdwlX7MPe2XqvgPioT5SsZMPr9T0mCK8C/nQ1dlC0eZy4BnETK5R
         vlbCntQ4KVzVUaBTy7rWy7g9r1zmzzDKhmCJvoMP1H5pdmSG/1F2KbsYN0ylu/Cvnsbq
         gPCLRFCh5FrNrUFwu1xTLnQ4wCA6tPu5NYTlcWBOEMVwBqJu0AFYSei0DbGLwaEEAUA3
         xE4IjFDrku9KW3xDIcBQW8JjFhdvpfXH29a6Ql0TbvVPn/E7GaDt0EjACvVvLDtMcQUW
         eMDBMQOKVtdr/+i8oJQ47GmVIzbdEaxb09XgbQ+EVPNsqy47d+inWIsJVmriUtxpHl2E
         hmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JxTO3+vCQfxfodGM5hl/SBHI1vpkytkSadue8KVWhkc=;
        b=LvL2y8JNok67qfhrG2XtJC1HIe4sZRaQCrbre2cnSthhfT2uWipofgxeo0gq1nNkhz
         sDvp6UF7KPgYhiemxFsEhiUfhCq99P4lA+8C9/d4B4jiAsi0mQ8OILMZ6C229zBrFOWh
         sK0cjQ9vikwzLJvMR7jIGcmJ6g2so9S7vNDp/1agAT+lUmttJd1aUgq1f/PJXpZHO3WH
         6VASAWima6eS7eB/eCvCWAksv5cvvIEvixogbV/Syq0NgJ6O6duye2UmZ5PHjKtpGEB2
         bbcREyEfliSKSYZ8NzkYzlDXtEKLuKIyRJuVOdKqGBzseW1c1SDgBaZxnaMUPrzUfEXF
         0d9A==
X-Gm-Message-State: AFeK/H08i8wKh9jhRJQEtKQwaRgJXhFpD7KhQkzfD3xwhRMrrsofkr4T7c9DYIVM5z9yqw==
X-Received: by 10.223.133.215 with SMTP id 23mr2570268wru.31.1490274402245;
        Thu, 23 Mar 2017 06:06:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/16] tag: add more incompatibles mode tests
Date:   Thu, 23 Mar 2017 13:05:22 +0000
Message-Id: <20170323130529.11361-10-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the test suite to test for more invalid uses like "-l -a"
etc. This change tests this code path in builtin/tag.c:

    `(argc == 0 && !cmdmode)`
    ->
    `((create_tag_object || force) && (cmdmode != 0))`

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 63ee2cf727..92af8bb7e6 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1455,8 +1455,24 @@ test_expect_success 'checking that initial commit is in all tags' "
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -a &&
+	test_must_fail git tag -a -l &&
+	test_must_fail git tag -s &&
+	test_must_fail git tag -s -l &&
+	test_must_fail git tag -m &&
+	test_must_fail git tag -m -l &&
+	test_must_fail git tag -m "hlagh" &&
+	test_must_fail git tag -m "hlagh" -l &&
+	test_must_fail git tag -F &&
+	test_must_fail git tag -F -l &&
+	test_must_fail git tag -f &&
+	test_must_fail git tag -f -l &&
+	test_must_fail git tag -a -s -m -F &&
+	test_must_fail git tag -a -s -m -F -l &&
 	test_must_fail git tag -l -v &&
+	test_must_fail git tag -l -d &&
+	test_must_fail git tag -l -v -d &&
 	test_must_fail git tag -n 100 &&
+	test_must_fail git tag -n 100 -v &&
 	test_must_fail git tag -l -m msg &&
 	test_must_fail git tag -l -F some file &&
 	test_must_fail git tag -v -s &&
-- 
2.11.0

