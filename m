Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266B3C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 23:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D459820658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 23:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nNl3dVZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgEEXNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 19:13:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37932 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727089AbgEEXNF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 19:13:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E3546044D;
        Tue,  5 May 2020 23:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588720354;
        bh=frjq5QxnwxK63fqr9gJiqE3ZfaUKHyBq2kEW5hhy6xg=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nNl3dVZoTFt5Qgn8y9kGvcjw6iuYYF07ucU0wE86tyftIHo1TZEoHcFnvzkIP9DfF
         wA0p2s/zNXQtB9JJqYk3NtSIFEb76jg37Jq8PFCIdo34HSKFYnCvYlzi5Ykd2Sj1UQ
         EP5j4A/zJ6q6CC8LL8PypsXeTB2Ar6vAkh6WZht0gyM8XjiQIu7Cbm7C19Gc3kdto+
         u0QcwMsYyz0i79eU1QWnmloAiEhjCyN2jGThWRkhPEPPj+584W1DhM8IUtkn5Nv8lw
         ZJR2zTJNZfxvuLaCVWUwKR6GtU2F4yB/uaiwF4PB9CAev8nMsNLN/SmNwDWruwEyz5
         tmvorZu2PaWpy3roh3AZ0Q8WMspRaaNwcnurJUjOJaw6uaEhd49OWkpP46gqGFuZ4K
         ZG9PqArQloVTdVDKoao1RN5zf6kD5F8g+/OzCw+jATwFSOITxEJfkAHERpgxFl6/Vn
         IRo/Biag5IAAMFQ2b7D+ODRXZnXB2NQNkqvk9FCrRwXqgm9ungH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] docs: document credential.helper allowed values
Date:   Tue,  5 May 2020 23:12:26 +0000
Message-Id: <20200505231226.1280264-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitcredentials(7) already mentions several possible invocations that one
can use as the value for credential.helper.  However, many people are
not aware that there are other options than a simple credential helper
name, so let's place some explanatory text in the documentation for
credential.helper as well.

We still refer the user to gitcredential(7) for additional explanations
and helpful examples.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/credential.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/credential.txt b/Documentation/config/credential.txt
index 60fb3189e1..9d01641c28 100644
--- a/Documentation/config/credential.txt
+++ b/Documentation/config/credential.txt
@@ -1,9 +1,13 @@
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
-	storage to avoid prompting the user for the credentials. Note
-	that multiple helpers may be defined. See linkgit:gitcredentials[7]
-	for details.
+	storage to avoid prompting the user for the credentials. This is
+	normally the name of a credential helper with possible
+	arguments, but may also be an absolute path with arguments or, if
+	preceded by `!`, shell commands.
++
+Note that multiple helpers may be defined. See linkgit:gitcredentials[7]
+for details and examples.
 
 credential.useHttpPath::
 	When acquiring credentials, consider the "path" component of an http
