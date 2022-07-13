Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC6C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 19:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiGMTCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGMTCV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 15:02:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9192B619
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 12:02:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l42so7005134wms.5
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=83A2383NVNWM5W8Dj2r+dwWeKgHvXyCz5DIa72ryfQg=;
        b=cZlME1cOwdYtTK9FC5r6M491R5u1ZEZLEvy8QbyzdhY2d4KCxhXQ0tHWlaoelgWOE/
         z1nrLPgt4zuCf8JZXClPcNdsM8TFFTU2AV5ZAloQ2oxVW8wH7DeXFqivx3IWl8MoS+IH
         WgzE+PKLsxdPzh8ELLNq8Lj/JNLeZEXNJvoStnEVXpS7BEu5bpL8FsgyyiGmfQLLpfKY
         Mkf+0zm/1b+48JmHiEgLRpMIXdruzedJDXZVkcsFBJRy82sJ9avgnvLy/Nnr6Eih1QLC
         3eOfulB9vTJtgxd503oIcAZ3psRvLDKFl6GAq8FVdEfazReRCD3klQLaUCq9WoA6eF4r
         OKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=83A2383NVNWM5W8Dj2r+dwWeKgHvXyCz5DIa72ryfQg=;
        b=58jhaKclxcfo1EWTbDN00fKSPjdgC+z6VRzQ7l83YW7oyIPDfN9huyRBs8lQ1hcJog
         jBPRb61oaruk8oz1qCjbcKiwV9/eVs7MEVxXWyXce4QcyJ1PfpZXTCSxBKhP4JQrbKQF
         nw5ZobGq6qnkuK1cVFJFIeAnKZJNXXamrz2qJdeqohqOim6/Ma2TSLBxbi9c1qTqXP8R
         0lOYApzGDlHdNVu7TB3StaKUIjcYaQbeeuLvcxDFHvpwkVU2TvouWM5KsjJeiLSziZQy
         wNJT7RWuwAOe3wd1DzfCuZKstUntmEWynDsadhF1ngCoCnJ8PgJxvY4sW1AhNxkxPD4b
         3VkA==
X-Gm-Message-State: AJIora/X4/72YaWADFkva9DiJq9zdWnQapqz0lG2ydCrphpPxJCtfciw
        6jbsOPZZjygMqFX/aB9heCA77pQTMJQ=
X-Google-Smtp-Source: AGRyM1s0BA6+pGVes+AHDkTPft6f+gqJZYNKRGJCwY1m+bXj7KqeJKMqBWYZoO0kc1IkdDG0Nt82rw==
X-Received: by 2002:a05:600c:3d8b:b0:3a0:466c:b08d with SMTP id bi11-20020a05600c3d8b00b003a0466cb08dmr5087869wmb.125.1657738938245;
        Wed, 13 Jul 2022 12:02:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0021d64a11727sm11612857wrr.49.2022.07.13.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 12:02:17 -0700 (PDT)
Message-Id: <pull.1285.git.1657738937049.gitgitgadget@gmail.com>
From:   "Manuel Boni via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 19:02:16 +0000
Subject: [PATCH] config.txt: add completion for include, includeIf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Manuel Boni <ziosombrero@gmail.com>,
        Manuel Boni <ziosombrero@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manuel Boni <ziosombrero@gmail.com>

Git config's tab completion does not yet know about the "include"
and "includeIf" sections, nor the related "path" variable.

Add tab completion support for the aforementioned items,
along with two new tests, based on the existing ones,
specifically for this completion. Variable completion only works
for "include" for now.

Credit for the ideas behind this patch goes to
Ævar Arnfjörð Bjarmason.

Signed-off-by: Manuel Boni <ziosombrero@gmail.com>
Based-on-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
    config.txt: add completion for include, includeIf

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1285%2Fziosombrero%2Fcomp-config-include-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1285/ziosombrero/comp-config-include-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1285

 Documentation/config/includeif.txt |  6 ++++++
 t/t9902-completion.sh              | 13 +++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/config/includeif.txt

diff --git a/Documentation/config/includeif.txt b/Documentation/config/includeif.txt
new file mode 100644
index 00000000000..18248cf462e
--- /dev/null
+++ b/Documentation/config/includeif.txt
@@ -0,0 +1,6 @@
+include.path::
+
+includeIf.<condition>.path::
+	Special variables to include other configuration files. See
+	the "CONFIGURATION FILE" section in the main
+	linkgit:git-config[1] documentation.
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 31526e6b641..43de868b800 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2485,6 +2485,13 @@ test_expect_success 'git config - section' '
 	EOF
 '
 
+test_expect_success 'git config - section include, includeIf' '
+	test_completion "git config inclu" <<-\EOF
+	include.Z
+	includeIf.Z
+	EOF
+'
+
 test_expect_success 'git config - variable name' '
 	test_completion "git config log.d" <<-\EOF
 	log.date Z
@@ -2493,6 +2500,12 @@ test_expect_success 'git config - variable name' '
 	EOF
 '
 
+test_expect_success 'git config - variable name include' '
+	test_completion "git config include.p" <<-\EOF
+	include.path Z
+	EOF
+'
+
 test_expect_success 'git config - value' '
 	test_completion "git config color.pager " <<-\EOF
 	false Z

base-commit: 30cc8d0f147546d4dd77bf497f4dec51e7265bd8
-- 
gitgitgadget
