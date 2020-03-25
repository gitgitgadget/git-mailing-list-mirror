Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAEDC2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D2620740
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSKKLvbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCYTcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:32:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42739 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYTcC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 15:32:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id cw6so3349373edb.9
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p9Pr9vcHIBAGv0RtCZmYZyBzvmoQaEM7VyyaJVVCmuc=;
        b=uSKKLvbMxc+hNkGhaDYLD8Q8XPVvHfQipX0M4AXg9thZcV700awP5G9QFLACPCKg68
         te92MQrCrUt4007x6xzNA0kQkZ1JRwSg9uKAT8Y/v09ENTfEUhxW0TuLggUOlGEalWqw
         MeA7B2XOe0dgGqvK0pfrjPbQOMP4axRYngKRIypNJv4Co3U7jRZwD+Q8rv796nCUvWoT
         8roKz5WFfQnbVy0oO6+xN5dOT8y9d7B/Axt5N8B+BMk1an5V9bo8Gj6dVUy4gDevfoxG
         Y9C9lOcm9ps6zHGacz75Rpk95NQEdHnLI2KpC9i4T1dE7EHtTeap/7LzLc7RJAZqOQwY
         SAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p9Pr9vcHIBAGv0RtCZmYZyBzvmoQaEM7VyyaJVVCmuc=;
        b=g+10NL4e/KfnaA0soFghN/g1ZfiGxaL9LJkdkXXhqJYVpG1wsDQW6jRi2SYnohwmij
         yEKuJ/oehY8IJFi9ANoEJVE1PQaoxgPGh7UPalTmx52wz57pzX31xtrpoSTWZ5lDA+aZ
         mX/PMriMl+L7VQs0FN2jng30TVqMCBA2Ur0l0tmK0lZ07rztFcWqe5auVWdaKwoGwVnM
         Do4Fomffh4trabpVwfGz+SyRU55LxP5MwpgEO+RZ100SO9/uemg15RRoxIj7EveLCTz+
         0qzLnhflV+eb3SrntMcg/UoIk/U/HutK1HguMwOrwg0j+d8RMbxc3fC9P9G5EN0GcOKZ
         x1FA==
X-Gm-Message-State: ANhLgQ1mX0bc2s8BleQ+Pw0tr+lApYR6Ul1HguFfmvHEophCRSE71XJv
        Q4yXNcN61zz9aQgc5H1uPOhX0Yy1
X-Google-Smtp-Source: ADFU+vvrcBZmbOU4FIXXQUjl/bSUA0lPEyWx1YYAVOwK0kkOvTU5LeSfRF0ZBuEskmPQTGZyaYIRNQ==
X-Received: by 2002:a50:998b:: with SMTP id m11mr4807326edb.36.1585164720832;
        Wed, 25 Mar 2020 12:32:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm1185772eda.14.2020.03.25.12.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:32:00 -0700 (PDT)
Message-Id: <b20bc3b9afdc23ad758801f8cfa1e1d997334b60.1585164718.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
References: <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
        <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 19:31:52 +0000
Subject: [PATCH v3 2/7] dir: fix simple typo in comment
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

