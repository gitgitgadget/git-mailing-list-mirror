Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A38C3F68F
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 18:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95E620828
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 18:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS9AqaaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfL0Srz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:47:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33380 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfL0Sry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 13:47:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so26104129edq.0
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 10:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A1ATIBi0aVpSoI1QwnGx5Z+CxlFPO8jqWmQdb86ipig=;
        b=oS9AqaaJTmzHZ7fpuTB4zU3C00SMWp38jfCtMOXdgtbX/ZYs00oB8f3p/oBxngnfIz
         4kAqO+/JBYUnwd71VhqsdJNkSdGrXtUlQkvR9x4bk57eTeJkVGB33o9VSMuYYkkNC+w2
         gtBTGrx02M+T1xO3yZDoOi1dUkAiVXy52HFtmQjC/ZOklEUw+XT9PTgbEMGkjiq+MuE3
         mxv2meTfy2KEAs+II3VgeHl5pHNNBPF+JGV3M5NbGnxPF78WdX2XX+v8LxbGIwZm0QVi
         wGiYQ5/VrK3cgEZPYa62vrR0mRBKRueFe4M65E2HOFCoZKhv+mbioMlsS73cf/wt8der
         jl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A1ATIBi0aVpSoI1QwnGx5Z+CxlFPO8jqWmQdb86ipig=;
        b=Z5pevPz/OrWOfLbmq5IA5KPfKwan+uJUeqz3e4dD87dV+kKtCSyc1Tz9iOJndL6PXp
         //+i3nXj+vXPbkC9FB6phFD3DcX/rlySFjVKA4wIKV8QGDkke7vAqTvswXne6Mq6fgL7
         Fm8IVFAZ1lugaKuYkpME0FLN3sXjfeOpmdURaZtZexe/BlM0Hrc7/b4jDOeOxzGhnd5I
         wCPyhBodnUHV0KqsJdFGOaW6mtxFgCMnqvM45AddRQ+y6qFduSEMrZ7I7+b7Y70Y2JTV
         1fgvKVnqzMSHeV6tuYSIXxWhlA+59oUWBxdKijc9r2xdIMshLop0ZXGyX40YOebtjHKU
         Bggg==
X-Gm-Message-State: APjAAAXdgsxEfikKo1J9HLl9yX3Ci2fln8EWmfxt1pISdjtOFDY8jjhK
        Mnbu9H7HIdxgnsqZQuDiicTgD96B
X-Google-Smtp-Source: APXvYqwTZEjhVNbBb9GGPFG1d7hSpWog2LpGnCz+eZDNGyPlVAHcSOrnyrLqjotAyXW8CYyDj8uKwA==
X-Received: by 2002:aa7:c915:: with SMTP id b21mr57359427edt.174.1577472472445;
        Fri, 27 Dec 2019 10:47:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ck19sm4153752ejb.48.2019.12.27.10.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 10:47:51 -0800 (PST)
Message-Id: <331bb7d6fbec6f2f429feb36cf32e0931307ae0b.1577472469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.500.v2.git.1577472469.gitgitgadget@gmail.com>
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
        <pull.500.v2.git.1577472469.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Dec 2019 18:47:48 +0000
Subject: [PATCH v2 2/2] sparse-checkout: document interactions with submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Junio asked what the behavior is between the sparse-checkout feature
and the submodule feature. The sparse-checkout builtin has not changed
the way these features interact, but we may as well document it in
the builtin docs.

Using 'git submodule (init|deinit)' a user can select a subset of
submodules to populate. This behaves very similar to the sparse-checkout
feature, but those directories contain their own .git directory
including an object database and ref space. To have the sparse-checkout
file also determine if those files should exist would easily cause
problems. Therefore, keeping these features independent in this way
is the best way forward.

Also create a test that demonstrates this behavior to make sure
it doesn't change as the sparse-checkout feature evolves.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 10 ++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 28 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index dcca9ee826..2b7aaa0310 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -164,6 +164,16 @@ case-insensitive check. This corrects for case mismatched filenames in the
 'git sparse-checkout set' command to reflect the expected cone in the working
 directory.
 
+
+SUBMODULES
+----------
+
+If your repository contains one or more submodules, then those submodules will
+appear based on which you initialized with the `git submodule` command. If
+your sparse-checkout patterns exclude an initialized submodule, then that
+submodule will still appear in your working directory.
+
+
 SEE ALSO
 --------
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 37f6d8fa90..5572beeeca 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -340,4 +340,32 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	test_cmp expect dir
 '
 
+test_expect_success 'interaction with submodules' '
+	git clone repo super &&
+	(
+		cd super &&
+		mkdir modules &&
+		git submodule add ../repo modules/child &&
+		git add . &&
+		git commit -m "add submodule" &&
+		git sparse-checkout init --cone &&
+		git sparse-checkout set folder1
+	) &&
+	list_files super >dir &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		modules
+	EOF
+	test_cmp expect dir &&
+	list_files super/modules/child >dir &&
+	cat >expect <<-EOF &&
+		a
+		deep
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget
