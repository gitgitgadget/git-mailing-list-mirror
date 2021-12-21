Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657D1C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 12:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbhLUMeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 07:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhLUMeC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 07:34:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F8BC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 04:34:01 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c4so26628269wrd.9
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 04:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=58ea8xZ1vuskPghyb6KL65sa87qjV0FY0c3NKqo0Nho=;
        b=l2B1ryoVgYp663Qtk9J3enctZoFVU9Brjfb3nGgdsup1tQYZ1V1OPl1iPKj6mmKm2M
         g/K5LO2ed289BnrIOa1O4eB4+VFQx+eKQfZk9DCGH9yWzeiFu/HY5p30pTZaxOC5nB11
         TWIjCAci/Qx7ojCFR2BBCVCaKKayXkXvNO0Gh7PQaaQAOtkZXhKTz80/cQeDaiYFRj5j
         /nGcQca9UUZTXHMYsJ+DazCiqpOdxbQuhEXrkrHxqkvvVDm4H2GqQea2euPkrPMg1yGS
         QQJ9DezXrkRxysSnpvhjaxqNJFWHtVHTiHRE5BQFgEp06wuT5jfZ+R3zs2Zp9v9jtaYr
         IjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=58ea8xZ1vuskPghyb6KL65sa87qjV0FY0c3NKqo0Nho=;
        b=j30hz+rkfu8bYyEs9k3cLIVHsEPHwpRrcWX/tnxniHcEnKvRAYv3BlHz1M6VrBhWBd
         SVpbkOqp0C9M9EsyRiEcUEOHvtm3dJI390ILIqeti3q/v8kXXDqYMUsn37ezF6B/61et
         v5pA/PcmoaKTkZ0SQSRm2DvQBHackWALfbJcFatSEHeAGk1C7Y39NwepauXDRy5SH0/v
         jzFHRn51eOmEtNReIOPcZkJZ+FLTBJbuPfTKxa4pSZSzKFuNSNF9YVu74EXB6uKkkNFc
         Hhww4BWv0vxxtTwFPsHGiSnkMql2i8LHzcpKTqzoFsX1af8o4z10iru1ZB3EqZhplSQ6
         gSLg==
X-Gm-Message-State: AOAM531Fj5lMeQOs2bF0hwPye4qZCKP2uBxTH4JBibF6/Y1ng2AoVA8y
        Kt8lReXo4bqscqBOc+l+IcvvXkwMM6s=
X-Google-Smtp-Source: ABdhPJwuRcF8OfxkCX0eJTb1jjnUnVhj2EVl/+p02yS13l52jdm8msYkWCUTq/gU/MzSnIVom1iFjA==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr2503540wru.257.1640090040113;
        Tue, 21 Dec 2021 04:34:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8sm6199709wrx.59.2021.12.21.04.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:33:59 -0800 (PST)
Message-Id: <177d84f8563341c688db8a5b14c043277cfc1106.1640090038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
References: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 12:33:57 +0000
Subject: [PATCH 1/2] refs: print error message in debug output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs/debug.c b/refs/debug.c
index 756d07c7247..cf6ad36fbb0 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -47,7 +47,8 @@ static int debug_transaction_prepare(struct ref_store *refs,
 	transaction->ref_store = drefs->refs;
 	res = drefs->refs->be->transaction_prepare(drefs->refs, transaction,
 						   err);
-	trace_printf_key(&trace_refs, "transaction_prepare: %d\n", res);
+	trace_printf_key(&trace_refs, "transaction_prepare: %d \"%s\"\n", res,
+			 err->buf);
 	return res;
 }
 
-- 
gitgitgadget

