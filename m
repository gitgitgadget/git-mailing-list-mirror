Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9078BC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A2F2076A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1jbr288"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgCZV1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:27:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36577 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCZV1q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:27:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id i7so3754372edq.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p9Pr9vcHIBAGv0RtCZmYZyBzvmoQaEM7VyyaJVVCmuc=;
        b=b1jbr288R/0i3UfHj6WdAgxQlS3E4H9RLCCoJjxF72Yq0Lo99IPCRzW4eBqarXPXc2
         aKYCp9HC1cJKzVMK4do6s9knroJ5lU8Za6MJ18VTH1iUFD7mSpNcxBkJF3ZoViJCKdJC
         eNW5unzXn2ibtUx470re00xyJpuOfSkYKQJAAD1ul06ZW7/wpKpb8D0DwgfTFD1Ry0hN
         HVHp22hwS7H8oML6Z2sQ3Q099jeFAikTacDCRZwQ+VKkSojsoIPjMibglB8JzCsH70uG
         kU4gFsEwok0sEE7K3Dq8U1bo3stFWwvAHfgBHZHygPYEe5hBvYKIR7g82pNkGT2k3w7J
         wmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p9Pr9vcHIBAGv0RtCZmYZyBzvmoQaEM7VyyaJVVCmuc=;
        b=Oi8Iy6K8QV+n3WpelcnyxPmZF7QpEWDzsxmV8hFHWiOIi7EOyq8UXBqbW1CqTl8uIz
         E7oKOgWRRghZNQEj5c74xmChGFbz8DuKQS6Zv4+Mp0uHgJAzidCpGRHIj6Y7NbL5SuCt
         A9TH2ocTtrpC45MtaUAdWLKkrg5aHarFY0NF0RuLwyYOOZL3IVQvQBqwjuywVWi9fazu
         TpZr+BIjKb5OTaT4Q1rUlaj/taAkBgFAOD0QVRnFuY6mew0PiJlK9IKAQbNmIWjGP0T1
         okMoSCSG/S9ndl2BvixD4S/FxpTPvRm0LWR2WA0s74ma9tYES8Nsp+MZv4KS+FMlIQvR
         eEuQ==
X-Gm-Message-State: ANhLgQ0exzgA+WuQigX5dh1FWgph4oyh8wNExwbKIdFUO8DT3VdPZh/y
        VHy71TsobBu5izUvsyuys3ZjeVZF
X-Google-Smtp-Source: ADFU+vvceTpCa/BffDAED4NPxAPLoxG9KCpFT+nG4JK1ii/zEW0MgIUZVMeFNW/GT5Pg2Ndfens3dg==
X-Received: by 2002:a17:906:694d:: with SMTP id c13mr7911807ejs.268.1585258064114;
        Thu, 26 Mar 2020 14:27:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm548423edw.19.2020.03.26.14.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:27:43 -0700 (PDT)
Message-Id: <a4287d690be27eb80313337b02437441ad046a33.1585258061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
        <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 21:27:35 +0000
Subject: [PATCH v4 2/7] dir: fix simple typo in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index b460211e614..b505ba747bb 100644
--- a/dir.c
+++ b/dir.c
@@ -2174,7 +2174,7 @@ static void add_path_to_appropriate_result_list(struct dir_struct *dir,
  * If 'stop_at_first_file' is specified, 'path_excluded' is returned
  * to signal that a file was found. This is the least significant value that
  * indicates that a file was encountered that does not depend on the order of
- * whether an untracked or exluded path was encountered first.
+ * whether an untracked or excluded path was encountered first.
  *
  * Returns the most significant path_treatment value encountered in the scan.
  * If 'stop_at_first_file' is specified, `path_excluded` is the most
-- 
gitgitgadget

