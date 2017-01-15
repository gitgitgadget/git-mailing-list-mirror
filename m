Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F1F2079E
	for <e@80x24.org>; Sun, 15 Jan 2017 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdAOSrg (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 13:47:36 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36014 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbdAOSra (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 13:47:30 -0500
Received: by mail-qk0-f196.google.com with SMTP id a20so13916594qkc.3
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IjImo4A8vb4wgLYtjOLAL6mvFvVkVCha3t9BRUxq1PA=;
        b=FeDY4xiUASD8QCZksygkg7iujDHZ076IGbCoww5pCzwfuT1DgIQRctCplseH/i32DG
         FP+ZwQL7Eiw0cesBD7NkQIMX+TfKG6LNkymzeQaEXhF29/y5OhzCZo4Vt40Q6K06qAUe
         xXjBWzT+gMVmJOKH0cQ8PKsBAkGCNhd2UUev5in/TE9bYlJVpc8LO0Hl3b5Oo7hn/N8e
         XqJ4Lfl0IZ+QuVNHrABlQSc2qrqOiFTr3/u59jbqRTDCKCLXuwWIlKD6H5xpbZ9mXb6L
         E/hRvbyuyITn1PapX5V7f9AyMFdnd/QQEZZ7/msbqdIIFPLnoFQZAvjTcnva8wlz4cql
         FYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IjImo4A8vb4wgLYtjOLAL6mvFvVkVCha3t9BRUxq1PA=;
        b=JWrOeyMKcrlDg22Q1Ko6QZBqVXBkdG64n4zgiWk2Fiu0HOYIHj9m8vnyVKIhCJw194
         l3RIhNMLPMBsAhI3D641ozY/6liAdZHhSkNkOqS0OeQktWg4dfVz7s6sAyUW6ZTe94ob
         sIlV9hT0+rZJdH1rIe+CFjjnTjrVMaCR34QfQMR5O4MzNaFVmhTSndX6EooRlD5okl2J
         3bpCW1nb+hvUhR+AYOWakoCbFY5cq+jctlswzb5mE4yvzoe+DYsJ4zuxEGdI/wth0F+k
         TKLsltGwsfQWXAbJLHbLWIL0LdTJ+Q+EwYirr2W9FTsGtyd8YC1SPhejWXWek5x+jldd
         5/Vg==
X-Gm-Message-State: AIkVDXLhaRRdYm71+lG6D32kB8GTfB4t76JZ7xVbQsqJOH4BrmwgnaCXstRAtxg7TV3JYDNL
X-Received: by 10.55.189.135 with SMTP id n129mr11451134qkf.214.1484506049463;
        Sun, 15 Jan 2017 10:47:29 -0800 (PST)
Received: from localhost.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id x40sm14362243qtx.12.2017.01.15.10.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2017 10:47:29 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v5 6/7] t/t7030-verify-tag: Add --format specifier tests
Date:   Sun, 15 Jan 2017 13:47:04 -0500
Message-Id: <20170115184705.10376-7-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170115184705.10376-1-santiago@nyu.edu>
References: <20170115184705.10376-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

Verify-tag now provides --format specifiers to inspect and ensure the
contents of the tag are proper. We add two tests to ensure this
functionality works as expected: the return value should indicate if
verification passed, and the format specifiers must be respected.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/t7030-verify-tag.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 07079a41c..d62ccbb98 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -125,4 +125,20 @@ test_expect_success GPG 'verify multiple tags' '
 	test_cmp expect.stderr actual.stderr
 '
 
+test_expect_success 'verifying tag with --format' '
+	cat >expect <<-\EOF
+	tagname : fourth-signed
+	EOF &&
+	git verify-tag --format="tagname : %(tag)" "fourth-signed" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
+	cat >expect <<-\EOF
+	tagname : 7th forged-signed
+	EOF &&
+	test_must_fail git verify-tag --format="tagname : %(tag)" $(cat forged1.tag) >actual-forged &&
+	test_cmp expect actual-forged
+'
+
 test_done
-- 
2.11.0

