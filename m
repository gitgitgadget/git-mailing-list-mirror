Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F2C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C42A60231
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhHJS3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhHJS3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:29:25 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B2C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:29:03 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q72-20020a17090a1b4eb0290177884285a6so19277109pjq.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5clB5IdAobX2tXTwZtbKpFVYZyKYjRCpEsEhjhCZ/hQ=;
        b=dnnKD/x7lp+c78TxxHSdbVsbEFCD1NXc/YjVYsgrcCEUsyzoNkaofYVQ60Au3frbHj
         VuC0W8e07v50ArVgwYJQyx9pK3j2g5/i4moUxoOzvQimXrzS5sOI9n5DDvIKgfuVnlqE
         vl7S+qbZXXtG6VONHt/alFoM2POjDLBrHZ2C7rNdpuoW/vUg1vycKt6ezVTEUZEsabjd
         PEGV5qdGNLO2rjmgls9WdEIEKgJtDAM5zv89rG81ZWgEjKCs2PxDz1Z0HJjvAu01QYaF
         DRT5sIcVwtoXxqdcx9T7c1XK0vSCFxW9YTTBs9Im304MY05vvPHA5/4xyN424EifI8sE
         3AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5clB5IdAobX2tXTwZtbKpFVYZyKYjRCpEsEhjhCZ/hQ=;
        b=lYE6HgHEfMpgHwv6MDzW8j6pu6CIvca59WP7euAMrwOTTx16gRXPeOICPwQwWWlQzb
         ujfhCTzreRTHHEUpa/f3oQOg5y4HmrNDVpViWbeGI6hX9aP3abYvAuTkQ//2vRwUjez5
         hL18qpk0AkV70XgfJg7xEmaUo5rlYtimVVh1kNUxiBtXywgIW2Ia2JqB7KzUCRfSVlyX
         KH9nAlAs365xEl8R0Mie37qobRm93vQjXBCLyB9BAPP5iFAzsAKqNpPJoq+LG7dbe5hi
         HMjf/xGhpixTZ8McEkH2Zmq7MansEHO3qvzkITxJGcji4T0tvHlAV5FxrMyHqPUu4qhK
         VQ/A==
X-Gm-Message-State: AOAM532+/lchdRlaen+7XaEaO5xZ1uy+6sEC4Kq1uPonhJ8NSvcCtO7P
        8PK2vvFeHNyO1Mjev9a5REQw5TVcSF92fcZ2elK8hjvwZxIuoMbg5LtJdy/AOwkHelMiHFEEstR
        Ngc9UQ8vBAFAHWn7sLP0zfIhk9rXU5VQ4lru1YyKFjPop1iVlm2eG9ubMiDzBXB+JGARHijkKMb
        u5
X-Google-Smtp-Source: ABdhPJyU4bXopWsMTFw4sQGwwdwbDpq9ZAXYaqI4Mhcmby0sdwwdQ/MY8CyFYNkI7GQbk9zbYeki/8sxEBqYFD8WRrLs
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7294:b029:12d:f2:e8d5 with
 SMTP id d20-20020a1709027294b029012d00f2e8d5mr846921pll.5.1628620143088; Tue,
 10 Aug 2021 11:29:03 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:28:45 -0700
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Message-Id: <f1fc89894b8832ab0f64f301b1621ae15654e08c.1628618950.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 7/7] t7814: show lack of alternate ODB-adding
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patches have made "git grep" no longer need to add
submodule ODBs as alternates, at least for the code paths tested in
t7814. Demonstrate this by making adding a submodule ODB as an alternate
fatal in this test.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t7814-grep-recurse-submodules.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 828cb3ba58..3172f5b936 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -8,6 +8,9 @@ submodules.
 
 . ./test-lib.sh
 
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
+export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
+
 test_expect_success 'setup directory structure and submodule' '
 	echo "(1|2)d(3|4)" >a &&
 	mkdir b &&
-- 
2.33.0.rc1.237.g0d66db33f3-goog

