Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568A6C433E1
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C7820739
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsMgcEXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGGGFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgGGGFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:05:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEC0C061794
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:05:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q198so37150395qka.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5HXV90BTLysKS2/1O+EbNfR5SQj4JWEsCACgTL/Vcw=;
        b=KsMgcEXhKRMhP2aXh+JBhar/Q3kz6y/kaH4E3njhm7nlZS4FUGpt0jzFqETJ9EXPVZ
         1d+0igs28g3vWh3VTbt3lb1rh8FQTWPjrDuyDC0BBRuaHcmN5fOJnahT3Hv+l1oVCOr2
         H7UpNwlDiHLrt9UD6WOokVNkL48GklnwDktE4ToKhUFl2fCyezcyLupai9gESgd657bN
         YylkN4TE/RnAohGhwDoBgfa9YgwimsPlK+eGjDbwLXuivpAnCUvFNctbdUUWJAHr9Bpq
         BaSv3lNcTlF2DqbX3FRHAc1DI87GqkWHL76Tw7MOwUuaVnBICcDRFQdyOsYAOftx//Q2
         3stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5HXV90BTLysKS2/1O+EbNfR5SQj4JWEsCACgTL/Vcw=;
        b=hSvq1Fm0RuFqJiQI8FqRojnWXjF0yUBWxDGyUlueDvJqgD9W8jbC4EERO2AiA94xve
         1AObE+q1l6aISyBSw0Q1v24p/3x+DWi3jIvL5jRNfz1SsIVKVbeaJeY2SRAcw0bFoSeR
         sozK+SNJmRwAOj6oF5Bm8VFLv0lRNtcSwjQyJj5FYQqYkH/MxlDDPttvej76BGqfVa6c
         WaPRKlvNHqvEU/eL/91PXwWSvXAlcJUoPOiJmh9MBzmdiyD6yscEL9ypdCbmsIC+ZiOY
         VjPUKtmU3RwDe3RH2K272xDtXfbue5cXBV/yCVr+sha+ehxbgZcn7zRU7tQD8D7UDS+P
         KZ/w==
X-Gm-Message-State: AOAM533a0lwbHm3EITvg80UehjuxHnI8DGMPExam7qA+A4rbZir2kiVL
        8OtBVLXHdF+/KV3gwgwxckUMSmu5DxM=
X-Google-Smtp-Source: ABdhPJy/YXbpf2XuBsqaPWv2M7x9YJxifCb1k4z50ucTy2ZqATycVLfRbIGyPirAL8tNU1ztXZ8vTg==
X-Received: by 2002:a37:aa05:: with SMTP id t5mr50178353qke.451.1594101906181;
        Mon, 06 Jul 2020 23:05:06 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id k197sm23446778qke.133.2020.07.06.23.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 23:05:05 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v2 3/5] t7107: don't use test_must_fail()
Date:   Tue,  7 Jul 2020 02:04:36 -0400
Message-Id: <eb2052bf644cc10b5dd8975fd75542916c1749fa.1594101831.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1594101831.git.liu.denton@gmail.com>
References: <cover.1593576601.git.liu.denton@gmail.com> <cover.1594101831.git.liu.denton@gmail.com>
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

