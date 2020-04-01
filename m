Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704BDC2D0F1
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E342080C
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MejrJbs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbgDAL3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:29:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40973 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732353AbgDAL3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:29:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so29162407edq.8
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=MejrJbs+XA0my8Vtye9lNQYHbGWCn+TIE83PzOxekRuF7zXNuUnZP5h52cD1VuEVEM
         WPzREsaC1AjoCU+q2AaFVt8Gj7cI6IdJikvZI6AO0Sy+SLdz5lQ/mKifphqMWrVb2Cps
         8wnShWU/eIgb9QrKfZsHpMz7IYOit8c/paNfxaADoyuTfDs/roTbVh3cbUm/LwAMKebW
         1FnkSqk7JWGitl1SAZ3o9BGqo5qceaI2gLRmM4i1GneeN+cHjQFDNTfvFArQ/rtyPxj/
         B5FUfXMpFvM3xvrG9pv+lTvLE6Er/ZgTQXZkAo38ykmXM3XVxGR4LaiigP/gOmUjtU1h
         n6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gP2mKurovl5RI1/nfB8JPBDqHhvSxbSjyPMBXIBnAvA=;
        b=Z34zkYY5HQ9V8sjkfZ6bmj8dCL09qaD/t6/Shc2ziLVApyLJjtivG7VGDj9W5Wi0BP
         71r2U+fALLOvboEZEhNGfs8zFLjuK/U5pvNhby8/Uh6ZIs0v1iqI51WRF6llOG1X4rM0
         AD0a8ToCLYs3Uk+1bwsr5vpQq7TR5OFTj8MHzLhfkGE0Zblj59sHAAwIH4hGDERI7pN0
         R483iyvLK0ftUVU5SjlLKq+4EW059uuHqkzaHhqsrX9NtwyjjFt/OahCz94O5KPDotU2
         7qANqq1VOF2o68lDFvRD3xZacYTpFaGh2hUX+fPuPE0N6imD45ei5xlrwhQPGCSZ/57n
         uQ5w==
X-Gm-Message-State: ANhLgQ0PYa7OjIHLxORUyXjjmDJBU7nBCvZThRE3CJTTfIq+xqESEtSE
        gbU+eNlPfXjM6ynAGHqp9mQ3oV0R
X-Google-Smtp-Source: ADFU+vsGJcqAyLbvS/1oltV8VhoVfwEm6QgA5m8oncL60y2E08zQmnAWmFMHM1SYs8FbNnZIKZPo3Q==
X-Received: by 2002:aa7:c48f:: with SMTP id m15mr18195308edq.164.1585740546522;
        Wed, 01 Apr 2020 04:29:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4sm468026eje.45.2020.04.01.04.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:29:06 -0700 (PDT)
Message-Id: <67ee5962e857a82a7dabd45755b1e4bb07ddb70e.1585740538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
References: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 11:28:56 +0000
Subject: [PATCH v8 7/9] reftable: clarify how empty tables should be written
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The format allows for some ambiguity, as a lone footer also starts
with a valid file header. However, the current JGit code will barf on
this. This commit codifies this behavior into the standard.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/reftable.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index ee3f36ea851..df5cb5f11b8 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -731,6 +731,13 @@ version)
 
 Once verified, the other fields of the footer can be accessed.
 
+Empty tables
+++++++++++++
+
+A reftable may be empty. In this case, the file starts with a header
+and is immediately followed by a footer.
+
+
 Varint encoding
 ^^^^^^^^^^^^^^^
 
-- 
gitgitgadget

