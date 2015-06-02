From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 14/16] t5544: add a test case for the new protocol
Date: Mon,  1 Jun 2015 17:02:16 -0700
Message-ID: <1433203338-27493-15-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfq-0000kR-5a
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbbFBADN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:03:13 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35524 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbbFBACw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:52 -0400
Received: by igbyr2 with SMTP id yr2so74913395igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MQSDit0yZejZpC3NRaMc/EkzBneWHSQI3oCTQIX3LtE=;
        b=FHOlnjOp1vXbTXorDpjrF4erKV5HgM7mVvTcGG+UAvEs+L2YtAFgYbEyF8jMbebZr0
         ZFjKHWQzhQxdxkiWHucHJZ4Empb6yx6ThVLWh+mJ+cn6Kokwyez766GJFrJZfTJaRsoX
         OBBcloAJ/HlJodUZJl2gUkAHH4K9wQaimjrYLqZyk/p+LyoHy1HSNK1RZUw0tW1hfvC5
         XoXjY2HLHxq4lL/fswN0244U74pbcEm7X99RXjDSAcHkhS4Prr8wwEuMVaKwqUyBnJRZ
         x1HPeLR+OXgYIPI6CjocosjHfmcJFP0oyPQWOthYRDhUUK19ijIuyhgdQ3LKFBNpNH3K
         hvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MQSDit0yZejZpC3NRaMc/EkzBneWHSQI3oCTQIX3LtE=;
        b=WEzOOYUTQWlaRpael3qI8njmJahmZWmtY97W6brhLnxrVljyRXVDkUu+sAhVE0VVeK
         jJNAnG3G9j0XMo4eZaoGz6Pj/k2jic0it6xV6uuxuujoGGiy7T2qYKp4gPR0MXnnoauk
         vCYUgW7H0ts/LqFCsYCSvuFureej+FgU7EYjBNlkEB8bIHC9MCqpkcD5O+om3FSzVY6e
         f9i7RmrphWpTrGoHqJE6Je5cYIFJU5BAciqI14f7FVTJmWZd4tjvohdYdLhIx3UauWYq
         SLUOBSo0koNLcsRAoCZXxD8wTLE9+tCUJZcTaLYUM1udYFiNt0AESrFsHQlt1Zx/RTO9
         M67Q==
X-Gm-Message-State: ALoCoQnkZHOawN0CfxURM2J24U7ypgpvyXzbUOrlbH2LDFoRhEamkenrfNVmGqX/0A6OTqU1hMMe
X-Received: by 10.107.133.154 with SMTP id p26mr30025071ioi.7.1433203371637;
        Mon, 01 Jun 2015 17:02:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id h138sm11492289ioe.2.2015.06.01.17.02.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270495>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5544-fetch-2.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 t/t5544-fetch-2.sh

diff --git a/t/t5544-fetch-2.sh b/t/t5544-fetch-2.sh
new file mode 100755
index 0000000..beee46c
--- /dev/null
+++ b/t/t5544-fetch-2.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2015 Stefan Beller
+#
+
+test_description='Testing version 2 of the fetch protocol'
+
+. ./test-lib.sh
+
+mk_repo_pair () {
+	rm -rf client server &&
+	test_create_repo client &&
+	test_create_repo server &&
+	(
+		cd server &&
+		git config receive.denyCurrentBranch warn
+	) &&
+	(
+		cd client &&
+		git remote add origin ../server
+		git config remote.origin.transportversion 2
+	)
+}
+
+test_expect_success 'setup' '
+	mk_repo_pair &&
+	(
+		cd server &&
+		test_commit one
+	) &&
+	(
+		cd client &&
+		git fetch origin master
+	)
+'
+
+# More to come here, similar to t5515 having a sub directory full of expected
+# data going over the wire.
+
+test_done
-- 
2.4.1.345.gab207b6.dirty
