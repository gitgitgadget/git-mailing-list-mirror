From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 24/43] refs.h: document make refname_is_safe and add it to header
Date: Mon, 28 Sep 2015 18:01:59 -0400
Message-ID: <1443477738-32023-25-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXL-0002OE-Ec
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbbI1WEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:32 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34985 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbbI1WDW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:22 -0400
Received: by qgt47 with SMTP id 47so133558953qgt.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lzv0FNo+SNjpeiOKgYn7HdUEV7MumTcN0pXAFTZQQuI=;
        b=XXCjuhXTeGAbkccQ427jUAp+8g1cI4cK1wLrIlLS/xABpuzBFc4xr92zbSaSfQiTy0
         2tbXIbOhyVaRPNGk2lqZ1t1NYMp8Vnt5jGZ61qY4GVhXU7foHqPpBnUziNmb1RvwXT9Q
         eLMbYWKTcW2mLC1TemhgjmArcR8sCyq+PerLFDt6TfkoZxUcsMGAT6vDyVk3j/l0s+v1
         18P8pUmzobeBmB6blIMTd2UopzN2wO2trNNOn1G4hzXiSyzqo/H8yYgBFOVmJ54eMOq6
         A0rst42aaGovhbRzYCZbIPaFqL3pSPlB07vheFKk4QgpLGKEXRfMC1zzFEceIxt6g2RW
         RLMQ==
X-Gm-Message-State: ALoCoQlfCbj/s5Duw21QRiQ0qPY2KE/XLgSs2SuW4HtsrTDgmHUQwqSKN+cP590y0RkOP0a7c8SA
X-Received: by 10.140.145.80 with SMTP id 77mr27672249qhr.36.1443477801356;
        Mon, 28 Sep 2015 15:03:21 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278786>

This function might be used by other refs backends

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/refs.h b/refs.h
index 2bafa55..db60bfe 100644
--- a/refs.h
+++ b/refs.h
@@ -259,6 +259,17 @@ int verify_refname_available(const char *newname, struct string_list *extra,
 			     struct string_list *skip, struct strbuf *err);
 
 /*
+ * Check if a refname is safe.
+ * For refs that start with "refs/" we consider it safe as long they do
+ * not try to resolve to outside of refs/.
+ *
+ * For all other refs we only consider them safe iff they only contain
+ * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
+ * "config").
+ */
+int refname_is_safe(const char *refname);
+
+/*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
-- 
2.4.2.644.g97b850b-twtrsrc
