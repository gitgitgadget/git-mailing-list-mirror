Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB9B1FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbdBCCtW (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:22 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33276 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbdBCCtT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so1189273wmv.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQD/wxB96/vi1aTBvCSZoYinFiBsPuIVl/fsHpJVLJw=;
        b=jRYAyCMf5zQ0WYdGvAoJCxt7qOmNLGCkjgqfZjU4A/dQiGRzATsDIlIuWlpptIEdX0
         JbrJ1rvHRQjRDPUdsQ5nNAJzMlrV1UP45PwdT2tSGqDVbfHP8YGSvDhvHLEQGpNBF5Hj
         Ddcek6PvPAb1IC6O2pqLXt/7tLEMP54hhxwmrRPWT5GUA0WEG603d02q/+ULxmpdxb01
         denwnfo8YnccrOa/zvSUVi680/zUxwBeETxAKrmIDY3Fm5gxGgYxOwLr0GfjJV242Hxw
         DgMdwaL2vQSozFHc2MsQ5GeFGKUaRCnvYW+oQljdXuBtJm6WB4SvVrJS6q1gkuKtUwBw
         6Erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQD/wxB96/vi1aTBvCSZoYinFiBsPuIVl/fsHpJVLJw=;
        b=i5wDZP320DDS5zTHgSm/KP4Un11LLOR7w8Nhw/WE3Zwpz8JeSnGj0fyQTRkJkGsPxG
         s8uPdY/V6EwPAdvV7Pg9P80Bc/p2w7Zu/H/UiPFAhrRUHZ3SGViJwUcF9mI+lhKbuOD7
         yySVeH7jdVuIIj+EWtoM5NhG1RLI0tW+V7zGHUPObXG++UdCSOW/m7UgLV1/nbnLSWRc
         z7Qq1di75Fac+lbwQCcSsjcBHgZkvqUS5l4LJVzDrjvnTJnvLnEECsWgu+fxRkuiVI83
         n67+pjPC6rcrrmRM033Y8ThkDxI4A+I0xYENBYcEaUv9mLmSlU5hv2awUSCBjZGBN+Nz
         Nfrg==
X-Gm-Message-State: AIkVDXLdiyF6bOrcfVphvBYXIUwfLwpgnLVtFCBXaYGLAJJ5i7RNiPVvaBiWnOhwAz2How==
X-Received: by 10.223.171.149 with SMTP id s21mr10044094wrc.64.1486090158197;
        Thu, 02 Feb 2017 18:49:18 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:17 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 05/21] completion tests: check __gitdir()'s output in the error cases
Date:   Fri,  3 Feb 2017 03:48:13 +0100
Message-Id: <20170203024829.8071-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The __gitdir() helper function shouldn't output anything if not in a
git repository.  The relevant tests only checked its error code, so
extend them to ensure that there's no output.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 030a16e77..f7f7d49fb 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -215,8 +215,9 @@ test_expect_success '__gitdir - non-existing $GIT_DIR' '
 	(
 		GIT_DIR="$ROOT/non-existing" &&
 		export GIT_DIR &&
-		test_must_fail __gitdir
-	)
+		test_must_fail __gitdir >"$actual"
+	) &&
+	test_must_be_empty "$actual"
 '
 
 test_expect_success '__gitdir - gitfile in cwd' '
@@ -255,7 +256,8 @@ test_expect_success SYMLINKS '__gitdir - resulting path avoids symlinks' '
 '
 
 test_expect_success '__gitdir - not a git repository' '
-	nongit test_must_fail __gitdir
+	nongit test_must_fail __gitdir >"$actual" &&
+	test_must_be_empty "$actual"
 '
 
 test_expect_success '__gitcomp - trailing space - options' '
-- 
2.11.0.555.g967c1bcb3

