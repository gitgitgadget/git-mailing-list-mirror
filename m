Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFF31F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeCNSd6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:58 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:48854 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeCNSdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:16 -0400
Received: by mail-qk0-f201.google.com with SMTP id w140so2696419qkb.15
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=z1xBkHZ2F75Av9XOyG4XGObSimzJAUw7EvscuiSemQQ=;
        b=hH91/eSRbDeY1xEFXsWYv7ly4vEjS5tJUynrOu70szLMqBhBtNkUalMDxM9DWq/tLL
         Tz6ecYWHIQnZ+ucWHo0O7V+ZKrUuVMKfMJdGD33SVxNi9RizluydKDJ1FfQ4+1RV5AT9
         41l9PiAISiAq9SesqLXwPmGurTU7j3iPh35nvpDCSBWFXwimt4Y2gIXJ1KgSKVHO4OvE
         8LHGdsmpFsjpK5w4y75IPK83L5SV/0K34R+xse0noJudMEI2LBqicBV/epiHZu2Smngc
         TBEA3BzoUJmJNz29khxoJQ0zesh1rlHNHGo8jGKV56CedxchsetB/u4MgaOkh38Qz5xA
         Hfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=z1xBkHZ2F75Av9XOyG4XGObSimzJAUw7EvscuiSemQQ=;
        b=Zer/A7SRJ4XUtjoKJkyWJhDOLw36Cfgu5A3tZr8PIfKUHnPSthP71ezz+vy3yZGOKf
         1TvsDPpaQ7hSbe6SArmy7y26kVDzPoE/0NvUUhLAZTHsWsqRQDINeb3w+WiZSWX2gmRd
         zZG8qusTsUVXRmZC4dm6W73qCyb3aEErV+XIX9JJCEzvzKg+/g4DiEtUelzE6RDF+cux
         G/VgM0A/fKGVcN6ixLcbyRGq3snLoV79lyG2i6hZbIMDjkrVIPMOhSe0xHd/Av6M2kDX
         UrEWQjZzOtnALZq+JHwYJTRKyhWnN96tqEnZEcPiOE7zk74Ac0o8ggApSOW7rT35FPyJ
         6LTA==
X-Gm-Message-State: AElRT7FnyFfMCNSbMPa0O/IiK/1YB2I+DqkZ35IOR5mVg04RG82kKf+I
        Nr2tB/NF7nkrTGHJHUZtcnvIjC83dHpATX7rgyJe+Rn/LktEOMXoZ88BVOAGkJbLXc7tUw/Oir0
        HGqcCxP/0LRr4MWw6t6VR3PXTYhfTkKsDx2tpBxHcZidr655veMjCt72hnw==
X-Google-Smtp-Source: AG47ELtrhXDx4ncTd62ZuzIe2cLt7LnXlVC3I13vA3lj0yk0LZLkHRuWPxN5/oxQhtXyZc7i4WmtfX5Jc0k=
MIME-Version: 1.0
X-Received: by 10.237.34.208 with SMTP id q16mr3687714qtc.54.1521052395480;
 Wed, 14 Mar 2018 11:33:15 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:02 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-26-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 25/35] transport-helper: remove name parameter
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

