Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB16C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E3A20738
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5N94Vsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbgFWK2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732182AbgFWK2U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 06:28:20 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCCC061755
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:28:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f18so18305143qkh.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2y7mFB0gE9guERvhw+Ck90cqDpvNTnrJ078+V80sl4=;
        b=s5N94VsbMsy0TBqM7bjIR7Cfg34G2FsCEb3Rntb3KCVPidWrDKBWDBiZTPLSggTDcr
         ITsc4P06WP1c9nGycdrrb0TtZSI/Nm5U8BE/K9gqdCQcWhDJsFx1MoJOiUSfHbRyDpNA
         igweOMFfpF2Pba+R+jvOZsHsofUgf4gR1Eyvz41YOUL2giIl/bg6Ve8zQGRU5a00DN7Z
         KMXaUJpTFcI0aarnXqBSTiRmOEWjN7SYLe0iG9gES/guBFMDvbdw+rg9UvxXM5+IlMwr
         Rcq0lMlrDiji/sriTnXtxG3hTFZsqGIQo7yDw0AG79DkERcvUN9t+xiutqQS+BvqxDWI
         AytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2y7mFB0gE9guERvhw+Ck90cqDpvNTnrJ078+V80sl4=;
        b=XUpiEyJIw4dh+GOmokFasI1rFBks+blpdKHR/tW+kt3icrJVxO7G5a12nz59EAmrbJ
         En8MLS/FE7R3ii9W4szLDNmyZ2EdLAGtCvE6BYi1chUGx2n3cF+lmK8scsNjRgn6h55Q
         xKeY2RFZsRHwS/xKKyphP019wZIpbuHGBV/Sq+3pXDQs5TA/sWJi0MC1DYvuKVsL2xlc
         CBq0+Tw+9oAsqz2AH7Gcm2E5pVywt0/hzVNVH1hFBRrT25vP2qFFq6dUAs8wtSPE7uwW
         DobIzNEySsDtCPORabHh/xzSYhQTILQ8m+JYMZ8xiRJx03fHX68knZZoH8ohBkhR5AMd
         WYVA==
X-Gm-Message-State: AOAM532Bd+QEV2Rt5QfdxetbHDVrrAW0iAkt0g35H8JuMvDrYdHePIJj
        11RJHbofhQNz5KK1IEOTHMxY5KoNrd8=
X-Google-Smtp-Source: ABdhPJxyry16u67Hh/bgw55u6EkeY6CdYQzI9/fvs9EsZLNLT8KlvZop9PrQffOAFbZ7cQLLqKfTcQ==
X-Received: by 2002:a37:c87:: with SMTP id 129mr6096338qkm.319.1592908099589;
        Tue, 23 Jun 2020 03:28:19 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id a126sm153795qkc.82.2020.06.23.03.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:28:19 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5 2/4] lib-submodule-update: consolidate --recurse-submodules
Date:   Tue, 23 Jun 2020 06:28:03 -0400
Message-Id: <16d0a3eb9ac8dcda701433a9e67cde5103949432.1592907663.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592907663.git.liu.denton@gmail.com>
References: <cover.1592470068.git.liu.denton@gmail.com> <cover.1592907663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both test_submodule_switch_recursing_with_args() and
test_submodule_forced_switch_recursing_with_args() call the internal
function test_submodule_recursing_with_args_common() with the final
argument of `--recurse-submodules`. Consolidate this duplication by
appending the argument in test_submodule_recursing_with_args_common().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 122554acd6..bb36287803 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -630,7 +630,7 @@ test_submodule_forced_switch () {
 # Internal function; use test_submodule_switch_recursing_with_args() or
 # test_submodule_forced_switch_recursing_with_args() instead.
 test_submodule_recursing_with_args_common () {
-	command="$1"
+	command="$1 --recurse-submodules"
 
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
@@ -809,7 +809,7 @@ test_submodule_recursing_with_args_common () {
 # test_submodule_switch_recursing_with_args "$GIT_COMMAND"
 test_submodule_switch_recursing_with_args () {
 	cmd_args="$1"
-	command="git $cmd_args --recurse-submodules"
+	command="git $cmd_args"
 	test_submodule_recursing_with_args_common "$command"
 
 	RESULTDS=success
@@ -927,7 +927,7 @@ test_submodule_switch_recursing_with_args () {
 # away local changes in the superproject is allowed.
 test_submodule_forced_switch_recursing_with_args () {
 	cmd_args="$1"
-	command="git $cmd_args --recurse-submodules"
+	command="git $cmd_args"
 	test_submodule_recursing_with_args_common "$command"
 
 	RESULT=success
-- 
2.27.0.132.g321788e831

