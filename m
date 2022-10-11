Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD6C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 16:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJKQuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKQuU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 12:50:20 -0400
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7FA4B4A9
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 09:50:15 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 068162E62;
        Tue, 11 Oct 2022 18:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665507014;
        s=20220911-jt8y; d=wired4ever.net; i=sndanailov@wired4ever.net;
        h=From:Cc:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        l=1939; bh=sq8OfKyZzK7W6tQyYZyDnpfGU08ut6MkXk/NYYeV/NM=;
        b=Qxt9k687KytDYppboaQ9XYvHqJDLmqV2InkF2y+Zl8Y5B/4mCUDhmn9lDh7/+0Df
        sXC7sXxLvqYLQOHXKMSKQapoMBnxP6iaXVneSZWFZg+5eKmDa89LEbTYxEdFF8Aedkh
        OgCwlZkzLXNaKVOUmGjZ0VxQEIPVnDZd9qqNpb2NnYFbbx+MEPNYELZ6jkex967kjS2
        5DZoHhfiRyvuLmWd8ZCg4vp+ifNZEUlJ3BGjYJ8u0c0AIFRF8Em/LXee+zq0H9culxJ
        KKoy+P2EgqDvXdB8KRojzvtobkz915+cvLk/GTDunIAasyzHirsrtnft1LPoHXXUlDK
        CEKSfNOxYQ==
Received: by smtp.mailfence.com with ESMTPSA ; Tue, 11 Oct 2022 18:50:08 +0200 (CEST)
From:   sndanailov@wired4ever.net
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, aaron@schrab.com,
        philipoakley@iee.email, Sotir Danailov <sndanailov@wired4ever.net>
Subject: [PATCH v2] docs: git-send-email: difference between ssl and tls smtp-encryption
Date:   Tue, 11 Oct 2022 18:49:27 +0200
Message-Id: <20221011164927.1516-1-sndanailov@wired4ever.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:378009619
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sotir Danailov <sndanailov@wired4ever.net>

New explanation for the difference between these values.
It's hard to understand what they do based only on the names.
New description of used default ports.

Signed-off-by: Sotir Danailov <sndanailov@wired4ever.net>
---
Changes since v1: Expanded explanation, covering more terms.
Link to v1: https://public-inbox.org/git/20221010172859.13832-1-sndanailov@wired4ever.net/

 Documentation/git-send-email.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3290043053..d64a46fa87 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -178,9 +178,18 @@ Sending
 	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
 
 --smtp-encryption=<encryption>::
-	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
-	value reverts to plain SMTP.  Default is the value of
-	`sendemail.smtpEncryption`.
+	Valid values are 'ssl' and 'tls'. Any other value reverts to plain
+	(unencrypted) SMTP, which defaults to port 25.
+	Despite the names, both values will use the same newer version of TLS,
+	but for historic reasons have these names. The difference between the
+	two values for Git is the following. 'ssl' refers to "implicit"
+	encryption (sometimes called SMTPS), that uses port 465 by default.
+	'tls' refers to "explicit" encryption (often known as STARTTLS),
+	that uses port 25 by default. Other ports might be used by the SMTP
+	server, which are not the default. Commonly found alternative port for
+	'tls' and unencrypted is 587. You need to check your provider's
+	documentation or your server configuration to make sure
+	for your own case. Default is the value of `sendemail.smtpEncryption`.
 
 --smtp-domain=<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
-- 
2.37.3

