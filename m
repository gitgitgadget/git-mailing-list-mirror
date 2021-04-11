Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BB4C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A080610CB
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 12:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhDKMzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 08:55:01 -0400
Received: from out0.migadu.com ([94.23.1.103]:44480 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232223AbhDKMzB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 08:55:01 -0400
X-Greylist: delayed 134145 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 08:55:01 EDT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618145683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DRVAGNMsaL4OHKUwB7vLZlnFr3uJU3/tY9trQMGoF10=;
        b=e4yR63W4BkyeliST26aG6auGdtEEfjAfbOv/Y6LMr2/G/FxyTQKbJZ3A04o3+IXr6lUFO6
        pWYvSLOZaLBAavOLfzWxDyCjLLZw7eopSQG2o2rS7pQV0/koPeTACy6P3O0Tw31NAw3tFb
        CXR5rPJH9iRxOHjEXZOX1FmKT1lduA7okjIyaJELIsBq0qfKCRvVscugj+RDfQVbYl/HzU
        2FsXePKfOeMBff0euwBe1Cj5+qY4vHDiVUKPuBdlCc+mwQ44Tj8UI6TWur/cEt/PT88aLo
        qTzN2OPgC/zaix1PTy1I4JUm7DurBl03oVlDmluKR4FZbIkBNyLKZkFCc6IcCw==
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH v2 1/3] git-send-email(1): improve smtp-encryption docs
Date:   Sun, 11 Apr 2021 08:54:29 -0400
Message-Id: <20210411125431.28971-2-sir@cmpwn.com>
In-Reply-To: <20210411125431.28971-1-sir@cmpwn.com>
References: <20210411125431.28971-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This clarifies the meaning of the 'ssl' and 'tls' values for this
option, which respectively enable SSL/TLS, i.e. a standard "modern" SSL
approach; and STARTTLS, i.e. opportunistic in-band TLS.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
 Documentation/git-send-email.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 93708aefea..c17c3b400a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -168,8 +168,11 @@ Sending
 	unspecified, choosing the envelope sender is left to your MTA.
 
 --smtp-encryption=<encryption>::
-	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
-	value reverts to plain SMTP.  Default is the value of
+	Specify the encryption to use, either 'ssl' or 'tls'. 'ssl' enables
+	generic SSL/TLS support and is typically used on port 465.  'tls'
+	enables in-band STARTTLS support and is typically used on port 25 or
+	587.  Use whichever option is recommended by your mail provider.  Any
+	other value reverts to plain SMTP.  Default is the value of
 	`sendemail.smtpEncryption`.
 
 --smtp-domain=<FQDN>::
-- 
2.31.1

