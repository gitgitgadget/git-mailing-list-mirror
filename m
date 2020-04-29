Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540D0C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3081D21BE5
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGNgTgHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgD2MWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgD2MWv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 08:22:51 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20FFC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 05:22:51 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id 59so973723qva.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YLdFmCiGZYvXv563riSjnp1kJer1Pdqf9RxzWAdABHA=;
        b=NGNgTgHjZQsWerijivAee+TZ0E6/JMELOo02DHf+855EudQxa6SfjVC1AKLy2+TZIA
         mdiiXhhq9AZFtLKMf/y5nBP6snHLmdDgc/9PBDyVE9qwMqlhu/1T3nUYLm2rWlHUhEEC
         cGsi2GgEc22CmIP0VRQCMjxMOiHZB4kmqx5qSmDtuH3ow0X1o4gguqGUF9z31si4MP1h
         77vHKXiW/Wg3zotJW5fP6FU6vuz7b6HfRREjKGhLEBX8kguCecjKXuFtOIwtSRyrOaQJ
         +H+iZMK/UTE4s1C63SP1RT+2BBE/xh2yK7TG/T+am9RBe7Fod/eyqLCk4C0vszoQwNZq
         NPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLdFmCiGZYvXv563riSjnp1kJer1Pdqf9RxzWAdABHA=;
        b=Jv9XsLiwQXH8fP+ZUQvfHJzoHereDRAroSYQ5eMH3U3pnnx1CB0EsZ458CE6gQyRbX
         kOEwELFXFs0b1uJ7YhfCte0X38e/QyCjal0rKUz6bqjFhX23gG/4kn3ktFIaqc73Oodq
         H1Heb1I7+P4c2UfBO6JgoY4zLFkEGiAoZzNYxT9ZWG5M7Z3oPCUqj4GT5fLqUqunRYK4
         9Am4SjFF4xmWfBzDcBoLxV3HNIetoppAm4MWrUjp2dFd8pr1ZKMB6KsMINRSndQ6se7B
         hRGJ2UFL6MmOB2YdZ+0voug6wlAh2P/CxKzdUm+jCgO21aAzdaTy3wgSC8kbJjY1pcNp
         beWQ==
X-Gm-Message-State: AGi0PuZ3b8y0EiCSTG6b7arUuSdHe1Smz3lNA7OUrqSUSv2U1o/9XJzt
        WYWywuyA8LwTuLoXZkd3P7UpOYL2
X-Google-Smtp-Source: APiQypKXU0ylFJvMF9ZMGPtnQMKH5js0gML/t4kMvtCItJxrSwneax5NTgCe0aOh2MbJ7zhXWRi1Qg==
X-Received: by 2002:ad4:4c92:: with SMTP id bs18mr25072121qvb.67.1588162970668;
        Wed, 29 Apr 2020 05:22:50 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id t27sm15389383qkg.4.2020.04.29.05.22.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:22:50 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/4] lib-submodule-update: add space after function name
Date:   Wed, 29 Apr 2020 08:22:23 -0400
Message-Id: <ea7a5ca7a97b31e123ed6062702cc1c6f6b33623.1588162842.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.548.gbb00c8a0a9
In-Reply-To: <cover.1588162842.git.liu.denton@gmail.com>
References: <cover.1588162842.git.liu.denton@gmail.com>
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
index 64fc6487dd..a3732d3f6c 100644
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
@@ -631,7 +631,7 @@ test_submodule_forced_switch () {
 
 # Internal function; use test_submodule_switch_recursing_with_args() or
 # test_submodule_forced_switch_recursing_with_args() instead.
-test_submodule_recursing_with_args_common() {
+test_submodule_recursing_with_args_common () {
 	command="$1"
 
 	######################### Appearing submodule #########################
-- 
2.26.2.548.gbb00c8a0a9

