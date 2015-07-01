From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 4/7] pack-protocol.txt: Elaborate on pusher identity
Date: Wed,  1 Jul 2015 11:08:16 -0700
Message-ID: <1435774099-21260-5-git-send-email-dborowitz@google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 20:09:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMRj-0004tU-9V
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbbGASJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:09:13 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37237 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbbGASIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:08:51 -0400
Received: by igblr2 with SMTP id lr2so40439433igb.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y71cI9ViDpMy5hW9ckzMpfeeLC7hrSsGSg+LO9jYtEc=;
        b=NbfyEW0c1suorWSG2hxhA7ovGBRhNIbqIwc1AnqXTTopewRgX03X+O10Hm8xDjAjG/
         I6hYXCYB07bmruZcExaU8VGjseVFed2p/Ve5RWj1PMXL1oszYJ278Ttn9zNAIuDB7s95
         Kb7VLemTWl6ksQ2U8Av/cCGrBTVOKyvZdagJbeq0/dQctfDwg2ogutPveYQ/S5VkXBkl
         KMQktqIMuOvbDreygqz88VONDaZD72sOAgRjRtXGl4Mg40letcHTKUXMzXJFHcVovw4p
         996n56t9thODGFTTtOJLHx/WSqDbBGCI+h7HNwLH3YMEe1rRbR05ZVk4XL5422hcudag
         3SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y71cI9ViDpMy5hW9ckzMpfeeLC7hrSsGSg+LO9jYtEc=;
        b=b34l1fIP5Zf+W+OFj0da6BsnrQ0bgi42FrfJlH9e56+Y5LypsKcxM53WQnEbNDY4Yo
         0MUaZG5hPsu8dm4+K8cWVd+Ar7E90Vhgz6GpSqSZqsJc8Krc3OeCU7fH+TbbY7hr92qJ
         xCuDL1Ln7vhFO7jk6h+iVmekThBnWStrTg6kJpnWrjbSzFirX3zFkvjHnz1c+m4YpT2C
         pbo6vwd91Ig1AKnasQS1DwnuLd8zU0IjcNGqjSKgOf3sALbg0CQ3IleBh5IawdzeYhRr
         Kl+MSt/REiHuJtsQ8dI63GBNk3zPcBFf8oVUHu+44YybDlqEyxIJESRWTzPvjoryK8Q2
         1IZg==
X-Gm-Message-State: ALoCoQl3T+EXAJA3yjcHVsjd/eGsDfBrGGHsS9r/TVLcHIHKep1K1kgjV7r4vUgHdQdE4vTJAsZO
X-Received: by 10.107.3.227 with SMTP id e96mr39870306ioi.50.1435774130241;
        Wed, 01 Jul 2015 11:08:50 -0700 (PDT)
Received: from serval.mtv.corp.google.com ([172.27.69.27])
        by smtp.gmail.com with ESMTPSA id k2sm2782076ige.1.2015.07.01.11.08.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 11:08:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.573.g4eafbef
In-Reply-To: <1435774099-21260-1-git-send-email-dborowitz@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273169>

This is sort of like a standard identity, except that RFC 4880 section
4.11 allows any UTF-8 text in the User ID packet. It is trivial to get
gpg to pass arbitrary text when generating a push cert by setting
user.signingKey to that arbitrary value (assuming it is an actual user
ID associated with that key).

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Documentation/technical/pack-protocol.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 2d8b1a1..de3c72c 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -494,7 +494,7 @@ references.
 
   push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
 		      PKT-LINE("certificate version 0.1" LF)
-		      PKT-LINE("pusher" SP ident LF)
+		      PKT-LINE("pusher" SP push-cert-ident LF)
 		      PKT-LINE("pushee" SP url LF)
 		      PKT-LINE("nonce" SP nonce LF)
 		      PKT-LINE(LF)
@@ -502,6 +502,8 @@ references.
 		      *PKT-LINE(gpg-signature-lines LF)
 		      PKT-LINE("push-cert-end" LF)
 
+  push-cert-ident   = 1*(UTF8) SP ["-"] 1*(DIGIT) SP ["-"|"+"] 1*(DIGIT)
+
   packfile          = "PACK" 28*(OCTET)
 ----
 
@@ -540,8 +542,14 @@ Note that (unlike other portions of the protocol), all LFs in the
 Currently, the following header fields are defined:
 
 `pusher` ident::
-	Identify the GPG key in "Human Readable Name <email@address>"
-	format.
+	Identity of the GPG key. This is similar to the identify found
+	elsewhere, such as the author/committer field in commit headers,
+	in that it consists of a name portion, a timestamp, and a
+	timezone offset. However, unlike normal git identities, the name
+	field may be any valid OpenPGP User ID, which is any valid UTF-8
+	string. (By convention this matches the form:
+	"Human Readable Name (optional comment) <email@address>"
+	but this is only a convention.)
 
 `pushee` url::
 	The repository URL (anonymized, if the URL contains
-- 
2.4.3.573.g4eafbef
