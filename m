Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7E4C433E4
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9454E20760
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFTMGG+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgGAE1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGAE1a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 00:27:30 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3092C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:29 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so17450730qtq.11
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5HXV90BTLysKS2/1O+EbNfR5SQj4JWEsCACgTL/Vcw=;
        b=AFTMGG+A1XPl70dj1RWMO1DLiDq8G4OTsf9gP6LvBR9f1b9uxFc4bTMtyJeEl5a4Sh
         O/yZpr/9kPTjzN/K3UW7DY2KlnudTm3Unv8ljU6gctTDtpnEfQ9Pg10McABmmn//4GN+
         uhfQa0Xi6gOsU4eNqbCk+yxjBC/B1RFSB3WHupVUFis/hIqRBFRw5JlAr3rSoTBZuncP
         wjYMxgpZXF2u0zQ14wFhQiFVwI1tUx4F7xkmy1V6REhZupokhXAeIYTEhLrrCM+4ICow
         gLO6ZgKKqGrijC0e9K+2OXfSiNb4NPHhZkYYZFsGwmUGYqZ8NUcv2eoq0p7Agk/v3bKS
         Obnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5HXV90BTLysKS2/1O+EbNfR5SQj4JWEsCACgTL/Vcw=;
        b=MEQNJ5cBM0GXwYgGEFSfuuMX25ornxOorECXtl5X5AMU+SkZ5cISpDAOMQyZqq9a3P
         RILrE/kKp+/FvSxD1j+Qx5sRbzYycEvINmvoREQGH0HZnmDOx5C3/TaMyWEHs0PbFmUF
         0bNJMcJs6wn1ntB+qxL1dIyvgyUjQlkP7uMi4XU+3NEaYYtKHaIWjYCFpYAaBRkBw+H2
         4BY+avtBq+d+WItxbb9ulxmNBDX7WIA11KddjtPCjVkt6KqEllHXlRT9EKrUzc0Mzk/w
         USR9CZX9qleuKEf0zHEQvqkIt2GQzQM7KvYz7Xbw8R1NjtWbz+XHFZJoV1YnN2r6bq+P
         Uajw==
X-Gm-Message-State: AOAM533QYKY6WQWNAPvE0LxlZz3xvyg6nnnls/9w55grpm9iWT9jbEbg
        UMQsXU2ePT12QQOhNyS1fmflJUatWrE=
X-Google-Smtp-Source: ABdhPJxZf/4VO1B8H21EeWTcO6UWyCfToExkTB0I5aO/w4pDs0LHy3t+v1ruWuaGzqc0y4HqxEDAJw==
X-Received: by 2002:ac8:172e:: with SMTP id w43mr13242932qtj.8.1593577649104;
        Tue, 30 Jun 2020 21:27:29 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id x13sm4418813qts.57.2020.06.30.21.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 21:27:28 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] t7107: don't use test_must_fail()
Date:   Wed,  1 Jul 2020 00:27:11 -0400
Message-Id: <eb2052bf644cc10b5dd8975fd75542916c1749fa.1593576602.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593576601.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com> <cover.1593576601.git.liu.denton@gmail.com>
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

