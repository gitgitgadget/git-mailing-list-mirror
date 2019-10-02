Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA1A1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 21:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfJBV0U (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 17:26:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38794 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfJBV0T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 17:26:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id l21so519539edr.5
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UthzjWFI1Ez/R4sB5IxsWyxOxlbglfqfyZ/1LE53l7A=;
        b=ZyPgzo0xaGwQWM3hWz8TGWIiLROCqjeGazB2T/TEqWob4w4QI0RV/693AxdZLiTeY/
         yXiQYTUYQg+Z51/BRvInYaCrGccdJlCQh4r0bcJ7X8g4h6dPoyhCTgFuuElmgC4IJL/p
         5NOfaURmbzAVsJld/e1J0bpcCGZXiAeJvBAqBoA/zUH4Dr8pOL1Q7kPsXXZ8zMUCmRvC
         GJeMOxdua4V5JgHR76G/1ISewFQlrVFsQ3cD787TiZfMoprCtqzpj+kBIVgsF6efNr8R
         Hyt3NcVCDA443rnNtWFLQ0x6uDbBVMsOtmLr3+DNyCOrf3l2NfhlW7S+u2M1ocwSHQLv
         mHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UthzjWFI1Ez/R4sB5IxsWyxOxlbglfqfyZ/1LE53l7A=;
        b=iMF5fJV6BC5oExmGLnzDeZ6h9yz/S6TjXj8RePVgpH5UqWnIbCNIEwjjKzpcFcwcQh
         u1VB+mNTnokgwcIwANIRQbkmSLDQAKQjQhAKq0LNpGac736QKclmZl/R8Gy9LzMZELam
         zBndYXIcPeBlUZAMXWFZIK5qm6FJiMoKdSYJbG2cPVk7MbQnuPnOyeWKgEOvX6evrbDI
         UxtW+ieYaQtQQCXQibYKCeRMHuNqucUY6wG4eBPVdCnWlQG1gfJis1qXh1AnDs2VllUV
         8vDVyJ0Ac06/KdUxl2mqSj2JxO+o8EGArRopF4FxnCNSaVE+qA6P/7HPWc+Uz1Qlmk7V
         Ix9Q==
X-Gm-Message-State: APjAAAVDl+/qudbD1KVpnCuK9sdh3bqGVS1M10fRZiFa6yWvJgvfrBps
        8DPxis+7Z+qq8Lwr/7Q=
X-Google-Smtp-Source: APXvYqzuBWg5wyPfP1YGsVkC7KWnVOxVl0Qrl9h0sj/L12RI/y0r/aAd2UDQulv1iHnlroGyma8Rmw==
X-Received: by 2002:aa7:c749:: with SMTP id c9mr6207374eds.232.1570051575765;
        Wed, 02 Oct 2019 14:26:15 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id c6sm27949ejz.79.2019.10.02.14.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 14:26:15 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/3] format-patch: create output directory including leading components
Date:   Wed,  2 Oct 2019 23:26:12 +0200
Message-Id: <d959e78af1cb7ef49bca970643b2136c436cd57d.1570051490.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.11.g242cf7f110
In-Reply-To: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
References: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 Documentation/config/format.txt    | 3 +--
 Documentation/git-format-patch.txt | 5 ++---
 builtin/log.c                      | 8 ++++++++
 t/t4014-format-patch.sh            | 5 +++--
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index e17c5d6b0f..b6c96ece04 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -80,8 +80,7 @@ format.coverLetter::
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
-	current working directory. Only the trailing directory will be created
-	though.
+	current working directory. All directory components will be created.
 
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index fe7492353e..f418f490aa 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -66,9 +66,8 @@ they are created in the current working directory. The default path
 can be set with the `format.outputDirectory` configuration option.
 The `-o` option takes precedence over `format.outputDirectory`.
 To store patches in the current working directory even when
-`format.outputDirectory` points elsewhere, use `-o .`. Note that only
-the trailing directory will be created by Git, leading directories must
-already exists.
+`format.outputDirectory` points elsewhere, use `-o .`. All directory
+components will be created.
 
 By default, the subject of a single patch is "[PATCH] " followed by
 the concatenation of lines from the commit message up to the first blank
diff --git a/builtin/log.c b/builtin/log.c
index 44b10b3415..1ab9eb6b78 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1769,6 +1769,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.diffopt.use_color = GIT_COLOR_NEVER;
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
+		switch (safe_create_leading_directories_const(output_directory)) {
+		case SCLD_OK:
+		case SCLD_EXISTS:
+			break;
+		default:
+			die(_("could not create leading directories "
+			      "of '%s'"), output_directory);
+		}
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
 			die_errno(_("could not create directory '%s'"),
 				  output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index bf2715a503..43d608aa94 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1643,9 +1643,10 @@ test_expect_success 'format-patch -o with leading existing directories' '
 	test $(git rev-list master..side | wc -l) -eq $(ls patches/side | wc -l)
 '
 
-test_expect_failure 'format-patch -o with leading non-existing directories' '
+test_expect_success 'format-patch -o with leading non-existing directories' '
 	rm -fr patches &&
-	git format-patch -o patches/side master..side
+	git format-patch -o patches/side master..side &&
+	test $(git rev-list master..side | wc -l) -eq $(ls patches/side | wc -l)
 '
 
 test_expect_success 'format-patch format.outputDirectory option' '
-- 
2.23.0.11.g242cf7f110

