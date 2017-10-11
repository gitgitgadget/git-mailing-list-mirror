Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD021FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 13:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757309AbdJKNf3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 09:35:29 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33334 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbdJKNfY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 09:35:24 -0400
Received: by mail-qt0-f194.google.com with SMTP id x54so2447641qth.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICHiwzGo0k5gnaRGqYsFgWSer6IaDfzSuJSbLL3K1Ew=;
        b=gyRpcGsneZLQYdKkbsrYLMv3lnPTn1nRB1Xbyc4eBh1BZ+e/dG9XdxXmgTNsZtzkdG
         iJ6xCmCsf6ONpMbOHewtlnEN6G+p1BMtM7txIBH1YiS7zSSkdLayXnAm5oZdhRXwGrTl
         kA/VClfWPJo/voUPP+r+fvMPU9YP89HXjQeSgntEqUF0REzUFrScGuHIRxzoJTj/DPs4
         j3piFvcn6KsEnRcUvhYnNjEO772OLHa5gCGQgbrnFDyVRf3lgiZSxLypGmHY5iLCSpRP
         YC1fizIsXw4ghHU5PxYtPzHXkl8S2JE6oE2gX6J0GSUSKJAwxzqAtE7BtHBsS1vXixq6
         Zrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICHiwzGo0k5gnaRGqYsFgWSer6IaDfzSuJSbLL3K1Ew=;
        b=o1LJ66Nv0q96o1BAxSdt6bYMythtfxhZ4PkihZnnQ0WSeQm4i0UzQLhtwvKA0DD4Y0
         wHuzoDRl6eErOj+p0CkoW1cYvjSCffwF0OBp3rUHNDhUDfWn33m2zOLlTSxUQpmoescE
         726n0FqCkSZ/AAwHXEJdI5iLEIHI2KV1DqT/2TYGX/gtyYdaKmCNwss9SMct+zfBpIWy
         jAFZSg3fOLPdBndEZxItWYMABlxgiI9t6dF1GPHhXEPNfE1uWJBX+ivlPECbvqVBSRm6
         WQ8nbh96aiohBhKkYX98VpilkPH6CBFji/WBx0MBV0MeDtJbA5PYIp2W5olUNBb2N2BC
         Vmbg==
X-Gm-Message-State: AMCzsaUz69ZFQT6pVbHFmutwUMNSSpbMSjLsAdx7wNfkTIv+DDL22gvc
        z12OMad6Y4+iRgsqDwjQlMI=
X-Google-Smtp-Source: AOwi7QC0OSAVRyA3/cQ83/ZA4qtAUbkWLoffHrVNKBWjxPoByScIGo9LIBW5lTPW+OxdU9/VenHZHw==
X-Received: by 10.233.237.195 with SMTP id c186mr20175353qkg.69.1507728923550;
        Wed, 11 Oct 2017 06:35:23 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id i1sm8192685qta.19.2017.10.11.06.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 06:35:23 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v2 5/5] Add tests around status handling of ignored arguments
Date:   Wed, 11 Oct 2017 09:35:04 -0400
Message-Id: <20171011133504.15049-6-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171011133504.15049-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171011133504.15049-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for status handling of '--ignored=matching` and
`--untracked-files=normal`.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 t/t7519-ignored-mode.sh | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/t/t7519-ignored-mode.sh b/t/t7519-ignored-mode.sh
index 76e91427b0..6be7701d79 100755
--- a/t/t7519-ignored-mode.sh
+++ b/t/t7519-ignored-mode.sh
@@ -116,10 +116,68 @@ test_expect_success 'Verify status behavior on ignored folder containing tracked
 		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
 		ignored_dir/tracked &&
 	git add -f ignored_dir/tracked &&
-	test_tick &&
 	git commit -m "Force add file in ignored directory" &&
 	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
 	test_i18ncmp expect output
 '
 
+test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	? untracked_dir/
+	! ignored_dir/
+	! ignored_files/ignored_1.ign
+	! ignored_files/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir ignored_files untracked_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
+		untracked_dir/untracked &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	? untracked_dir/
+	! ignored_dir/
+	! ignored_files/ignored_1.ign
+	! ignored_files/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir ignored_files untracked_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
+		untracked_dir/untracked &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify status behavior on ignored folder containing tracked file' '
+	test_when_finished "git clean -fdx && git reset HEAD~1 --hard" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	! ignored_dir/ignored_1
+	! ignored_dir/ignored_1.ign
+	! ignored_dir/ignored_2
+	! ignored_dir/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
+		ignored_dir/tracked &&
+	git add -f ignored_dir/tracked &&
+	git commit -m "Force add file in ignored directory" &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
 test_done
-- 
2.13.6

