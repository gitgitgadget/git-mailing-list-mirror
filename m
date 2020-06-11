Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250BBC433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0916220838
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3gyNcj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgFKRmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFKRmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77234C03E96F
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w3so6392538qkb.6
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2y7mFB0gE9guERvhw+Ck90cqDpvNTnrJ078+V80sl4=;
        b=S3gyNcj6T9Cm8KLDzjorIrANRsrZqddo563QBE6+OBhkqDae9iX3x9a3fWvljGCvfj
         +dJwb1FGKPpwgFUXZVnrdQq+LWPkE2fBPh2UT5p+pkcMiGlrUurdpiNtBTN6fLlB2/P8
         IO+SJWS5UI24P9TIADG9Z+WbWy2VzhfVD1YeCqB+yo78DJ06aZxUBq16rDzpjTFs5TZ8
         43fJceM/4r2wp+yR42HB6l0tGt/3aril5n1tlV/btm8OaNIAISEHPnCxZ00r/qInJebR
         ZaBMmydu7L3idV9ROSWFs6AWQb2tC9Lsha3eq6uKuwUThkRJnpT6onqQFwPLs2iGnsET
         ja3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2y7mFB0gE9guERvhw+Ck90cqDpvNTnrJ078+V80sl4=;
        b=kVz9cmRe9NLox1zbZbT94QjTR+Z2LVN2+47QT1oHBFwy3ZhOc2rgjSsSWyy/PYWOcE
         oX+pxDlgl1YD3/JGL3J5r9KbEZPi0c34RW1RVp/T3j6vf8ICVKl2SyMvyquKE/dpqXp8
         B/psCdfCNaBNQ60gZssBlcA6ZewCRr0C2eDAL4JQO5ijSGd8kpD4q4soEN491RwdJcKE
         adpPD5LAdW0elYRZOT1wiULhFLcTdA+LpLRQtUsMJi+9+hcclVR90xa3Bcy/bgk4SKMs
         ZVDz65rfjXmbI0EYMqJXpgaaEXm8j78dUQdp7D9jUqauB6xZ+cGcIYwdoSW0Mnf25wZO
         ujmA==
X-Gm-Message-State: AOAM533D49ZynNzBWKptdbANW5JYg9XJUsk28dM9WKFCrP3jbNNrNJDH
        +CBq6D5YTBDRkh/ILh1EfOxW8XTMCD4=
X-Google-Smtp-Source: ABdhPJzTP0Y3mSyxcf3VcTdwg8mJmi9VMJfuTggXDQodcGgNp7TLk1wqwvQ2VE20LI4m3WCFKttWkQ==
X-Received: by 2002:a37:a8c1:: with SMTP id r184mr9176579qke.402.1591897323465;
        Thu, 11 Jun 2020 10:42:03 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f9sm3050703qtk.68.2020.06.11.10.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:42:03 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] lib-submodule-update: consolidate --recurse-submodules
Date:   Thu, 11 Jun 2020 13:41:48 -0400
Message-Id: <16d0a3eb9ac8dcda701433a9e67cde5103949432.1591897173.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1591897173.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com> <cover.1591897173.git.liu.denton@gmail.com>
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

