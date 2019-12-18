Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F739C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA284206A5
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8eH2Rd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfLRT3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:29:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37700 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfLRT3w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:29:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so3555183wru.4
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H1rfc3Xakcj/y7/qH6kpuw834RYNToBjdWGDvsRGWdg=;
        b=H8eH2Rd8eIkjZ03b4g+SLET4Dfy7r9o4BOwRHA5q7+pEG/3CAGgI2BB6qczT1Qhm8i
         yLGGHq4u4ZxKQCfV4QryFah5hIEenJBXNw8tZ0SoIUaFTVsl+RHYGxdOBIxE/pmQURah
         DEYl2hF6ZvX4Oj8U/2C2jSdECB5pFxmUqO+UHrpdfHphmwM8NnZYjfDUajthD7yypgBJ
         G8fYWCZfoCM/O4mXdPyQ6LkDCQP1D4w+bxd2t1FVGG8laqgHg0mDTf2u4frP1+CCTSvr
         8iXWkxiAcyH94YInsQ2c1H3HYe5NIG37aJPfw8HBTojOdz/9o21CBqMIfyWEG6EzU09h
         d+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H1rfc3Xakcj/y7/qH6kpuw834RYNToBjdWGDvsRGWdg=;
        b=OySNqsL4NF+V6D5xXxATtyyncrsZQzn5TDEKeTs1aEf7zvy4O1d8a5ExHdcLfFz0Ou
         MycHx3vB3WtksENIQYNTyyTmEk72FagREsr2OI3nMqDcmh+jj3Wnn/GLXDRPjvginAEH
         mYlmNo1sb1q+wjxOv8Atwvo31i2vDSb3tR7pCrGwhs2gx3nRZufoOvCDjnMKxumDxzBY
         X8H2H/vZadb/V7EizbzjfYBQ4fE6PKe2MPnOFkHixAjzf22knwEvN+lh709ea3ypEniY
         qtCsGqmx59VS5UPCOxqu4ipNvi7F5zxTGhdmYAOGcLiDy+n4lw73KkyW0P5ZF9CNq2VE
         WUrg==
X-Gm-Message-State: APjAAAV9sRdqkH6A1iRyj7DnWYpXdT7Lf7OHkPLkKh1KPVIy3WK1tm/Q
        klsfGsDgPrWVMnWgQgkmH9V15p1+
X-Google-Smtp-Source: APXvYqxfkaVuTg35V3LpDXIzU3wZXnG81plXHv0geJniwIdKl7+knghmZyVol/UJ5fgU7sfSbDuBvw==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr4714356wrt.366.1576697390785;
        Wed, 18 Dec 2019 11:29:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y22sm3465214wma.35.2019.12.18.11.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:29:50 -0800 (PST)
Message-Id: <d6f858cab122869425f5801d98713bcbb6d00334.1576697386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
        <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Dec 2019 19:29:41 +0000
Subject: [PATCH v4 3/8] dir: remove stray quote character in comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
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
index 0dd5266629..5dacacd469 100644
--- a/dir.c
+++ b/dir.c
@@ -373,7 +373,7 @@ static int match_pathspec_item(const struct index_state *istate,
 		    !ps_strncmp(item, match, name, namelen))
 			return MATCHED_RECURSIVELY_LEADING_PATHSPEC;
 
-		/* name" doesn't match up to the first wild character */
+		/* name doesn't match up to the first wild character */
 		if (item->nowildcard_len < item->len &&
 		    ps_strncmp(item, match, name,
 			       item->nowildcard_len - prefix))
-- 
gitgitgadget

