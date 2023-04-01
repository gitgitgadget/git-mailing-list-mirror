Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECBCC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDAItA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjDAIrz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:55 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFD1D85C
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:13 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id ca2-20020a056830610200b006a11ab58c3fso12467296otb.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkAmfMDU8Qe90ICH0GTdtFE0TPrhBa7Yz3X5N8UNz3Q=;
        b=MH8m08y5RaQd98R/ETbnzScdq9DLFLREqmVVmi5J4bgLX78cK96hmMx0Pp1zAzWT6E
         sELdYVQ8Jpe1u5K8gRyH0fGlEgo6/wofat49nKUdB4ENnzlW+4nrFwo97UmxluHnYrzc
         9F7za5IGn6daDf6J2CqJhnmc00WcfnyNo+NjNFkrF+H/TiucZ+wBqAnVbOwAsok35nz3
         /v3l7fgS88lnCJCw5jCF27ZN3DEfQmRIH3qMBRI+u/Da68k355JDzg9nAW9iGsVwvcjk
         2hEPx4PtneROFsgiIVQMPGkPKSqmxxItfcOa5jfN6SyHKOexfXjlgaHmNFRhtZk5KjGO
         WClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkAmfMDU8Qe90ICH0GTdtFE0TPrhBa7Yz3X5N8UNz3Q=;
        b=CgIDHlsQ8/F2BXs7dmdyFEJtJ/GkiD8IpVZsRrZEIMzMWvNDMUas0usGfq3F5jzAzH
         utCWiBreDJOT7mIYPnHkgxr5xst3oRW+6bRUqK9sW6MXrV9WwGlH6zIbf9EICHpO1P68
         c5ClxKsb/4usxoNhYvCnBF7sgDDs0Hd+0mPmZWnKHXtdhrsG1P4wbzfhEGmkErMKFOPr
         tWeYi7BSY3Hj+0UfjhbgBK1qhmG4GsIUxBRh9RUj1ewCJf868tW+G8/jQiFxUwEbrypz
         EtmDBpmgXAeL5SwI11jxQMl40dP4lqXx1XJ+0ILDQQC5HitNI48a6IcqyAct8BOjNhsU
         pKdA==
X-Gm-Message-State: AO0yUKWTwWR59+oJ7BzZiBdY8truV3dGkFsXZAwAa54/xrPUo+J2qKpS
        gNyDT8DqCqIhYcsuoc6k8Ie7N9e58WU=
X-Google-Smtp-Source: AK7set9ee5eKIe1v4uHUazIiy2RDLRYwDI1zu98Hs3o2RUOac96l4ickmNWucfkmwLdVNhivB2E8cQ==
X-Received: by 2002:a05:6830:12d6:b0:68b:dd8b:6cd with SMTP id a22-20020a05683012d600b0068bdd8b06cdmr14403311otq.7.1680338833009;
        Sat, 01 Apr 2023 01:47:13 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b22-20020a9d7556000000b006a305c68617sm733378otl.53.2023.04.01.01.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 33/49] test: completion: add missing test
Date:   Sat,  1 Apr 2023 02:46:10 -0600
Message-Id: <20230401084626.304356-34-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once the correct suffix in __git_complete_config_variable_name() is set,
we can add the test again.

Now it should work even in bash < 4.0.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh     | 7 +++++++
 t/t9904-completion-zsh.sh | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a2f2f9dc09..c33543191f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2533,6 +2533,13 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git config - direct completions' '
+	test_completion "git config branch.autoSetup" <<-\EOF
+	branch.autoSetupMerge Z
+	branch.autoSetupRebase Z
+	EOF
+'
+
 test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index c0be5573ee..1c694bec0d 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -1090,6 +1090,13 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git config - direct completions' '
+	test_completion "git config branch.autoSetup" <<-\EOF
+	branch.autoSetupMerge Z
+	branch.autoSetupRebase Z
+	EOF
+'
+
 test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
-- 
2.33.0

