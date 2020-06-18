Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946CAC433E1
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA552186A
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOs7MxNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgFRItZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgFRItU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 04:49:20 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5056CC0613ED
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:49:20 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id y9so2405233qvs.4
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03T/1SBccsrL8MxzlNoP+D0VvWFvUBc8YCfO8LcdObA=;
        b=WOs7MxNdGRP7EAlcJWIU3K1As7APfH8lFCc0SNBvEHsLdY9BVVQERi5oRr+Vl5OfOG
         /fYmfyz1volc/Pe6vSycqCBQUDI8xntfQaZpfCYw4brD2Rk2PSaK4Rq8zMOz+NiTxpZv
         /5nvis8LKbWDeecjmR41vUXnxyqYnrqfqs8kTB/Vk4ASDMwbYtdsSZ8wIdUd6OJzGQkl
         YjtIE2ePf8VmYZuNXW9O1WzW0aSnfigj3mh+S44N43YlVeR3brxZQtcAxDvQPv8hP4kC
         EFyTBUWAwHmrQZyh67Qlz9Rp8CxfXbxBDVCLZicACGGqw+WabJLw/MeBfo7nhFAuMbSU
         +8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03T/1SBccsrL8MxzlNoP+D0VvWFvUBc8YCfO8LcdObA=;
        b=e8f0iKnLTFIAp6aPQuXPAE2UXaXIV+cez8e9olIBkNbnGMWJu/Gq6MdhUxjhQvxZWW
         l/yUH/jBZMCPeqJpyv/+7nJgmVvawmXDbvIUwtxwLRZLpv/us/8e2c2Q9sAvlvcHvXnh
         KTXXxjb5hK9d72XbQrk4Oo8Qm5aS9quoQYCWpoFhlBo16jwx7hfVK9SIeUh0Bj5IzcwH
         K1dpCnIpfoBuqszRo73/pAm9mBQxBL7fgVjUCfLGfPCk0eQA1xw+z+CCw/SIBSLGCcYQ
         QWTAzUjpyRv6+KZh3te30pd0rDwcVN7PiohjkpJKu6i0DYZl13SH3Cku6UQQimejRFUP
         r66Q==
X-Gm-Message-State: AOAM532ZtSrABN4smBC9MFYQp+LKSyqCs1syrGQrFv5e3ui0GRNYK3kY
        FloCJCYZnkhHvhN05dhMyhS8Q2x3z5w=
X-Google-Smtp-Source: ABdhPJzW2PcvVisOFV1k45LJGvamKyUt+coUEUnhjrqzo1IARdTt/jQ/PlA8yEzCqonvEFUtCdz0pQ==
X-Received: by 2002:ad4:5485:: with SMTP id q5mr2697639qvy.62.1592470159298;
        Thu, 18 Jun 2020 01:49:19 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id p11sm2733082qtb.4.2020.06.18.01.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:49:18 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v4 1/4] lib-submodule-update: add space after function name
Date:   Thu, 18 Jun 2020 04:49:11 -0400
Message-Id: <ba2f642e0f505730d5d740207128036448787c8c.1592470068.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592470068.git.liu.denton@gmail.com>
References: <cover.1591897173.git.liu.denton@gmail.com> <cover.1592470068.git.liu.denton@gmail.com>
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

