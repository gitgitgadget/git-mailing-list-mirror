Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2855B1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeBGBOv (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:51 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:44195 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932253AbeBGBOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:16 -0500
Received: by mail-oi0-f73.google.com with SMTP id w135so1852601oie.11
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pOAdlPSaD2Zjmn5KFM1V9PRL2J+C0QDS4kHQkxusbfM=;
        b=PlLBiK+kEczwXBhZNmJ194kOI2gLAs5nWmDFifTAtMPfqfnQ340g0ThsQUPA49VnLq
         1ztKd+ermgGi64V0bNNfghxakrWL33xKfCEL/LknTUNwgRPZc+0WZNCbg921iNx8f/lW
         9TZMN7SNybj6d4jq5Xsp8BhUk3UG1nhM9/u7iPSKtYkfQBjEwNjyEkuZjU7b6XUskySM
         JdCdq07yZG4Q9/zE1rnqADQm+ZzDhDx9GFNAMpPfYia9au1LTJAbEuwKr4ZrcsbBvhgU
         w+aPjaeOkielAmusVk1QdvBnPJ50Bddc4sIBFkLmdZTPoZzX9xLvcqj/WR44gFj8byJ5
         I/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pOAdlPSaD2Zjmn5KFM1V9PRL2J+C0QDS4kHQkxusbfM=;
        b=T3hdIxQps25NAlJttrQ4RaUoyMkzqR0ult33uOjDY+/oIZbE8AcofrB03jiKsha+BI
         ia5To8geKgWZsLb6wUBBVP99TekxRjDaHH7dYyvrGMvuEYb1t0hVmJJMiA69Sd5SGP0h
         ZY2Yw1Ea6EesITiczySj0K86NAcB5D9Libt2i/iEct6uWxVSnaVa5PUnOA80Ss/g6vC8
         AwvVQ3QNMQo6ur7PZsqplmI4o0rjISCFL8uxRf9Jw3ukPJSgqhA2rlUOVJVl7aQ+ltCB
         w6M2Ud5ylyIarzAt3Slb2faX79eDuzbhfhhkOoV45UuXQEM6YzgGohEoBxKM3qrrwdLh
         8GRg==
X-Gm-Message-State: APf1xPBa4HyRw+6C9vdzmJZvLXMdO/qQ1tYfzPH0iBCjyS5OS5ftCXcU
        kCDEm9jEyiiZzM77PxxYpdS/JV0QVkaeah3aolHa96Cgc3lABIl3GIB+7MKJzdS0eMvjT3UHQfw
        8S174rLxOylRNvOrZ/6fXBOIKz+k6Avb+9rvluQUOFnOE3u2Z90v2zjwlsg==
X-Google-Smtp-Source: AH8x2259EzhXVeEBeYQ/QnhLYVTXy0jDaOlgbKXmNdQfugXWJZUzujYqrpZnCMTN796fQKBpCuVcMU1GuJs=
MIME-Version: 1.0
X-Received: by 10.202.81.130 with SMTP id f124mr2118046oib.9.1517966056111;
 Tue, 06 Feb 2018 17:14:16 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:03 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-27-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 26/35] transport-helper: remove name parameter
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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

