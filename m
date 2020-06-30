Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAFFC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F1F20759
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlYFB/8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgF3PDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbgF3PDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:03:33 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1230BC03E979
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:33 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m8so5193876qvk.7
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S5HXV90BTLysKS2/1O+EbNfR5SQj4JWEsCACgTL/Vcw=;
        b=RlYFB/8V9LHiiQfL8l8nOSt2i7H9SbvG3zLa33FfatP5iIeBbt0LI+spNyCW7b4rsE
         2HpQkz/cKshqb3b8FLqISxj8x2UsnYW38CoM4r30F2vavk/+Thw3VomjbkovUxIpsl/A
         njo4fWdwC0mnbZku0oIOoV8NRrHb/Ozg4uoi9dr4LjTStBGsRuF6EfRMM8YsNRaO5eZS
         sBRz2z1yJjnNxjdkyCPKvRtK1IiYKCG4che581tL7jESBrlGQGNZvcUMoLG4xFWYSj9U
         kdERAD6xFjjJJThc4R8MSkGSuwD7MAOsqrccuE9EQ+GbAnIrwcVHtpNpLyAydphEhaIe
         eeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5HXV90BTLysKS2/1O+EbNfR5SQj4JWEsCACgTL/Vcw=;
        b=sls3/w1xnOYoFuSGy0vdIcDzaohwyJaYwyibfK4jgKWnMHzQBbvvODcLapjsHyF0Ik
         N6y9PWl3dTj0BImjuVeQcf7BcyXF5DicCuZCPXTxid9kvh8KEpw6VGXyTvKxIzIT6Z1D
         Mj3fsYSj654TsnizO+zpB9VcdlrDAVxHSY6NAIU+24WU/gEHg8bvIE+in5vIsk3labyw
         PJ1qMtKaqlWOkunAaHSxG4/MqKLf+5fpq5NKpB8YS7fZ3BimI05OACKyyj6MgAY5WvYN
         Bklr3nezfSml7tdyTZgGkSGFYCDnxKgojzFulRIITiuW0pbiqgdtRGLW79iP6bwnKhZB
         ffoQ==
X-Gm-Message-State: AOAM530iADheXiWvSOOh8+2KLdcJz/XkxbuC4KUm+ihae2vh1u1pmnp/
        FeeX0fk8jovp6kWWLlIZ4277RnOUWAw=
X-Google-Smtp-Source: ABdhPJz1bpPufOvD40lJlVIQgkKkO2bXkrnsN/P6ZWZt3uMThH8yxkMWeeOE5CII0oML9YDodgcGTw==
X-Received: by 2002:a0c:e6e3:: with SMTP id m3mr15438300qvn.162.1593529412007;
        Tue, 30 Jun 2020 08:03:32 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id p66sm3209626qkf.58.2020.06.30.08.03.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:03:31 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/5] t7107: don't use test_must_fail()
Date:   Tue, 30 Jun 2020 11:03:17 -0400
Message-Id: <74bc29b18b2dd2352843e675431e7685c0495359.1593529394.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593529394.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had a `test_must_fail verify_expect`. However, the git command in
verify_expect() was not expected to fail; the test_cmp() was the failing
command. Be more precise about testing failure by accepting an optional
first argument of '!' which causes the result of the file comparison to
be negated.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7107-reset-pathspec-file.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index cad3a9de9e..15ccb14f7e 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -22,7 +22,12 @@ restore_checkpoint () {
 
 verify_expect () {
 	git status --porcelain -- fileA.t fileB.t fileC.t fileD.t >actual &&
-	test_cmp expect actual
+	if test "x$1" = 'x!'
+	then
+		! test_cmp expect actual
+	else
+		test_cmp expect actual
+	fi
 }
 
 test_expect_success '--pathspec-from-file from stdin' '
@@ -131,7 +136,7 @@ test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	cat >expect <<-\EOF &&
 	 D fileA.t
 	EOF
-	test_must_fail verify_expect
+	verify_expect !
 '
 
 test_expect_success 'only touches what was listed' '
-- 
2.27.0.383.g050319c2ae

