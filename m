Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4360EC3F2CD
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138E621556
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 20:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKy1q5FP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCBUCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:02:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44682 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgCBUCG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 15:02:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id n7so1347489wrt.11
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 12:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lolcPEH9dhf4EWrJllSyFaba3lqKmwgtdjkj9k8UdV0=;
        b=HKy1q5FPa3qt/CpygzI1WGjERtKp0nGDfOEWboCk6uwydMqeI/QakgHjo1uzmm+qf/
         prO2LSl6TMZAeJ5eryOAbJXQqyAGNN4gIS262TvvPqPZ0cO22VfBuz7s9FEKS6eU1TMI
         HXDFv9Nyox/CL3t8m3XGFRO0PXxXVXKdSrhueDHL5HChkvv059avcS2OvzCOoLpIEdOJ
         F2hD3y9Ny6413ZLIi93Y+jZFil0Fq9jNIC6i2hlRD4wKSuEMuj69Hc03As3zLCEjx18/
         q6gAjs47z7miFV2W+3IVKbHut/6cPxH/VXeCXDX8xajfyezF0iUOpE2OixECz3lxiJNg
         UwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lolcPEH9dhf4EWrJllSyFaba3lqKmwgtdjkj9k8UdV0=;
        b=MScTYzocn685XvvCTBocT39W9XxJL5lCmra1LgBjiDQACR7O+qUxiwAOHNDD6uF4nL
         R8KnK8HoltiCl4dTUO2CgY/ZEjZtJUpDFqnVAVAuGH1Zbp4SnDv7yJcULnfbci65nfiQ
         yz9PXaMbKJ2Txfk1H54d6l+oyIFTXwBuOPPDct4Kis9Ycp/ndns/9sZA0Q58cCPi6D9K
         ziE2YEdTSad5KPPsCJ8+IWuXd4uR9Yb5il2ZbZsSwATTmDOW+EJJaRg2+rIOVjJhIu/d
         xTwjsrzJHX+uSMC3ERrl4T4SN5PaV1kH8u3ZqnCqxvwBBwLVjNOVll6PHfGwhOg5H3js
         9s9A==
X-Gm-Message-State: ANhLgQ2IPgIxgUH7PK2u4z+Zjph3NYIljuVWHP0yH/sQ4sDBQ1G5JbnB
        qW6t1RJIPmvIbpRyyJmntpE3QCk9
X-Google-Smtp-Source: ADFU+vs7KaM2dtljyRkhhpAvZ/GDB41Ef56qgmhuRq6yyCQPZ1xW9FxrWgIZmStMABQ33jSwbL+X7Q==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr1249075wre.164.1583179323039;
        Mon, 02 Mar 2020 12:02:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm56690wmg.22.2020.03.02.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:02:02 -0800 (PST)
Message-Id: <f668d9b7ca04da1d8adf0a146b48a46559471501.1583179320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
References: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
        <pull.548.v7.git.1583179320.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Mar 2020 20:01:57 +0000
Subject: [PATCH v7 1/4] advice: extract vadvise() from advise()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

In preparation for a new advice method, extract a version of advise()
that uses an explict 'va_list' parameter. Call it from advise() for a
functionally equivalent version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 249c60dcf32..fd836332dad 100644
--- a/advice.c
+++ b/advice.c
@@ -96,15 +96,12 @@ static struct {
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
-void advise(const char *advice, ...)
+static void vadvise(const char *advice, va_list params)
 {
 	struct strbuf buf = STRBUF_INIT;
-	va_list params;
 	const char *cp, *np;
 
-	va_start(params, advice);
 	strbuf_vaddf(&buf, advice, params);
-	va_end(params);
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
@@ -118,6 +115,14 @@ void advise(const char *advice, ...)
 	strbuf_release(&buf);
 }
 
+void advise(const char *advice, ...)
+{
+	va_list params;
+	va_start(params, advice);
+	vadvise(advice, params);
+	va_end(params);
+}
+
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
-- 
gitgitgadget

