Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21601F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeAYX7h (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:37 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:41930 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeAYX7f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:35 -0500
Received: by mail-yb0-f201.google.com with SMTP id b2so5823690ybk.8
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pOAdlPSaD2Zjmn5KFM1V9PRL2J+C0QDS4kHQkxusbfM=;
        b=siPi27jTjRcNxCfWXrPutDw98NfVK2SH6GgMiZwvtNAF0OJoOjmSoaOAM7s8Zx4eTi
         t4i6qZnHSTIBW2KPnOsYb/Dz07TfwgaGNk8dxnV/j3ykpAT0tupH8Rflaekkf6AnDvgB
         UcKOw4wfIAuVvZ54YRkG4wxQrv5VJWshBbZPUh8Ai1+a0LXnYDggWDz0SR4q/bOGn7hy
         C76IA0c6H1GYynv+Jj8ELWGkKetdz2qOpdyi+TTUX+CCo2sztpEvR6tUAMP57RV/SzHO
         PWDfLc7OQcqxDiQqabjRG/VJww2WdBs0ZiiA0hqGUdDb5UwRsVNCi08DyNl3bxEmYBOs
         hl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pOAdlPSaD2Zjmn5KFM1V9PRL2J+C0QDS4kHQkxusbfM=;
        b=qZgItHLVcpDalI0PaicqQdMwFmih5LNBdkqDomXhM0lGMAX1Ypu8VfmMuw87hj6Y2i
         mOgjTaI/nojY2/Si+kSRGw6Oq88Y4RFOeoFzEu9Vl3VTWHK9We+YlchXo7GQElkycVL4
         pYGcIW1uI9NuPC+vjwzWlU091TOM7AkPj4uSyVw3hFjSsdWr7PZHiRlLlIAtvZDiqaSU
         SyV/rp2W4UsWfmb6m086Ir8Xnoj11RQFCr+v1LF+uwXDVAWIOYnwnAJh8AOyn55p5eKb
         7dwTmAF+iVpc5zpMSwKKwWHlSISjT40v54MvvbP/B5w6uh3GO4W9SdEBE+lOI3WpyoL1
         sG+Q==
X-Gm-Message-State: AKwxytdwJx5ZFNIcKD2ndj1Heyrg6Bzf51xFgu7ufeAciMJ89XAraKNQ
        6hhycLpfO/FFyBrLQML2kgF82po+4w4HWeGaHy59yP2JtgS6Ls+gTKSPxWxEkTfLGyKVAA2MXLD
        l2JcyBKXRnVZCNEPFteIThe3EwmfL1m3HmF7p14bpsKjzoJHW6qrQHeutbg==
X-Google-Smtp-Source: AH8x224fEVr8j0YBG0MNboivemvPrz8A8o0wHCB1DS0/9UZiM56nnOVeJAuREYhwxFX6HsvcwCWn76Iv52g=
MIME-Version: 1.0
X-Received: by 10.129.236.19 with SMTP id j19mr5810569ywm.136.1516924774759;
 Thu, 25 Jan 2018 15:59:34 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:33 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-23-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 22/27] transport-helper: remove name parameter
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 266f1fdfa (transport-helper: be quiet on read errors from
helpers, 2013-06-21) removed a call to 'die()' which printed the name of
the remote helper passed in to the 'recvline_fh()' function using the
'name' parameter.  Once the call to 'die()' was removed the parameter
was no longer necessary but wasn't removed.  Clean up 'recvline_fh()'
parameter list by removing the 'name' parameter.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4c334b5ee..d72155768 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -49,7 +49,7 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 		die_errno("Full write to remote helper failed");
 }
 
-static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
+static int recvline_fh(FILE *helper, struct strbuf *buffer)
 {
 	strbuf_reset(buffer);
 	if (debug)
@@ -67,7 +67,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 
 static int recvline(struct helper_data *helper, struct strbuf *buffer)
 {
-	return recvline_fh(helper->out, buffer, helper->name);
+	return recvline_fh(helper->out, buffer);
 }
 
 static void write_constant(int fd, const char *str)
@@ -586,7 +586,7 @@ static int process_connect_service(struct transport *transport,
 		goto exit;
 
 	sendline(data, &cmdbuf);
-	if (recvline_fh(input, &cmdbuf, name))
+	if (recvline_fh(input, &cmdbuf))
 		exit(128);
 
 	if (!strcmp(cmdbuf.buf, "")) {
-- 
2.16.0.rc1.238.g530d649a79-goog

