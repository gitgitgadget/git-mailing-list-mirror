Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731271F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeCORd4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:33:56 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:46271 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeCORcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:47 -0400
Received: by mail-yw0-f201.google.com with SMTP id y64so7699133ywd.13
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=z1xBkHZ2F75Av9XOyG4XGObSimzJAUw7EvscuiSemQQ=;
        b=PnWc03TuHLhspPS8eWReUKinVttYSXIepKHjFq09oBXsGHd9sOuvtMLx3VzqtQK3Eu
         dImn7GtY77JZFTG9AMmnZugUba03CWKFqzxA+/8KN9l/sGzvX6frdpztUwc526vT11uG
         xROORZ2caIJF0ncO6awWabERDw5WiskJXZuclEFQlDyFlLC/tFYdbiCm6bdwLO39JqfO
         TNLdX04bTlta3MeIooBBp+Ccmp5TEWfA+zdK728mrswpjTIHJa3pe3vJVneq9/5nfcTS
         btxJuzop2TbnLOZwT/VJ82uxVGTy2yCpsRFo0ldpP9yCam104lHaThyzzWrBXju/jRuj
         uLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=z1xBkHZ2F75Av9XOyG4XGObSimzJAUw7EvscuiSemQQ=;
        b=FbX0H/yavaumIepW+Mf3Lx6C5aF3O3MHeMazzH9d0bQtQNhISvCdmKDd4rtt1rg5dQ
         LgI8qYHy27eeqReXXdFmfeIlZPOO6AEmhiSsgFMKDznGCTsqP61iiSUMLa98S3meuNC3
         L46MosJKnqy8t8613rFFHDgAt2HkxT+1EOIvzSxe0tg6x8acFKHHV6Oxt1jBAN2pznE0
         crck1CjAO9w8N/qzLp7ZZZJ/oJyQzhouETIPQRMpdRzbrfZAlSFAlLNiEEP5lR87Lgtd
         EBtLqxc0RjkJ5XkFztsI7iHQwq/d32pWYwhoiIn0OF/pALCz/8ySCXEtTt+VAu1dHYEJ
         RjsQ==
X-Gm-Message-State: AElRT7GIhiduIsVi0s2TDhkgWI73OeIUBDY7kYWLuR8OQfV9DlUVpX7H
        ykKF20cv3uUlITDJ5MbKE7urhnDMPnsyY6v5UqwwlLpk7L4qIStFHet6l+lh0ej/pkHOk4vV0rM
        nlQVWKOL+7U1FAjZjTW8A5FSE49CLNCxH1Sp/m0/Mow/UIbLtZ9yaqmqyGA==
X-Google-Smtp-Source: AG47ELvsCuiCnYx1CZVHnB0LpGlI2SZt1PIUXgeIL++3mePTv4MFHHrlV7W8WM71WnmF0DjVqYJCpRVcfoA=
MIME-Version: 1.0
X-Received: by 2002:a25:83c3:: with SMTP id v3-v6mr3387664ybm.46.1521135167120;
 Thu, 15 Mar 2018 10:32:47 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:32 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-26-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 25/35] transport-helper: remove name parameter
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
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
index 8774ab3013..9677ead426 100644
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
2.16.2.804.g6dcf76e118-goog

