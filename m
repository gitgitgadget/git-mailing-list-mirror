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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A52C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E8D207ED
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR7DvJrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgFKRmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKRmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A109C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y1so5166577qtv.12
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03T/1SBccsrL8MxzlNoP+D0VvWFvUBc8YCfO8LcdObA=;
        b=lR7DvJrtbmJHQidCDyXz/9f8DxwSzU8a7YDf0MqnQ01V2SuDIbl/fmwp5yfXKnhnC2
         yzElKKPpLSQr5rm+rFoNS6ZGv3NomhL1BKev/3FP4Vh9xBHumZApR1La6bgNO8E3e0qT
         cGAm/y7tEDtYBwfpzGT8daAQOe7XtqGj//7E/CMcPOuRKxcgexxZiPHQ5vYWKLDFHKVu
         Pvh7Lfeqgs8r4/Rqcy8pXonpTEEKrMiqhZuu42IBdpRovbbjk4EZxG096eyUwuZiTmYc
         OvcfUm0MFZWkmyt7cKRMipsUnoMiSCDyTsm2t6yh2dlIAvJOsVypt29Au6JTkXJ90fAZ
         2R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03T/1SBccsrL8MxzlNoP+D0VvWFvUBc8YCfO8LcdObA=;
        b=s6PAb0V1fsbBsb72F228Z2908VNFBdoMF06k14GYthmfhegRlzqL9jTz5fsih+2/b6
         Bkp8y0R2L3urbuLA+CSahxOYSkYvugYWPwxlYj8ymfSrR4pBbRPVMv62OqMym/98Qgpf
         Vx3g+ga0ItclPAdQ/oO46mqAFd0ZvjkYD3ACyA44AzXZOSuXoONcTy64NhW1c9n8b+z4
         x2NgkMOcZKFYKOg9peRejKnAzFRH2r6gf5z68KsxoQdaTrquT4G5ikmsS750dEYlQqql
         q7Yv4v/k/sRLFZ4mTz5VH2v6Llh+SNkRWmQzJttXkiYFGulLBIjVuV3YZgyF3xT3vGZL
         vPnw==
X-Gm-Message-State: AOAM533oYT6UDdvYDIslMxIze5uBMsyf5HHaj2mvcJyBMGTMS0CdKVIh
        kI2uvtFgJ735baORLGBvvK2mUWJJiZ0=
X-Google-Smtp-Source: ABdhPJw3D9Cea3oQdNZXqolgpCQxBYEZJux8udrg8S2MCBoCtHSdn1bEZYiaGOvQ46wk6cS0PMnXcQ==
X-Received: by 2002:ac8:4c9b:: with SMTP id j27mr9695197qtv.132.1591897322351;
        Thu, 11 Jun 2020 10:42:02 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f9sm3050703qtk.68.2020.06.11.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:42:01 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 1/4] lib-submodule-update: add space after function name
Date:   Thu, 11 Jun 2020 13:41:47 -0400
Message-Id: <ba2f642e0f505730d5d740207128036448787c8c.1591897173.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1591897173.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com> <cover.1591897173.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the shell scripts in this codebase, the usual style is to include a
space between the function name and the (). Add these missing spaces to
conform to the usual style of the code.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-submodule-update.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 1dd17fc03e..122554acd6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -183,7 +183,7 @@ test_git_directory_is_unchanged () {
 	)
 }
 
-test_git_directory_exists() {
+test_git_directory_exists () {
 	test -e ".git/modules/$1" &&
 	if test -f sub1/.git
 	then
@@ -309,7 +309,7 @@ test_submodule_content () {
 
 # Internal function; use test_submodule_switch() or
 # test_submodule_forced_switch() instead.
-test_submodule_switch_common() {
+test_submodule_switch_common () {
 	command="$1"
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
@@ -629,7 +629,7 @@ test_submodule_forced_switch () {
 
 # Internal function; use test_submodule_switch_recursing_with_args() or
 # test_submodule_forced_switch_recursing_with_args() instead.
-test_submodule_recursing_with_args_common() {
+test_submodule_recursing_with_args_common () {
 	command="$1"
 
 	######################### Appearing submodule #########################
-- 
2.27.0.132.g321788e831

