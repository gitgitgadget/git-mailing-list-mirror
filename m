From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 25/44] refs.h: document make refname_is_safe and add it to header
Date: Mon, 12 Oct 2015 17:51:46 -0400
Message-ID: <1444686725-27660-27-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll1W-0004fc-LU
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbbJLVwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:46 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33028 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbbJLVwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:41 -0400
Received: by qgeb31 with SMTP id b31so28261023qge.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sPn9PIai3OMU4/ZpNZJfkTBuyCRFBp1flQbz+RSu+IY=;
        b=W9ZKB/aCxQM6PAgM3dfqJov9JOHlqNzni4E45db28rMXcPj3yK+egn+vajDccf4Zo3
         y8deWF/uERjxUmJczpKCMP71k+Guk1J8KhHQ+3ALj6C6xf7oX2NiHLs239VU/+NjJOf9
         Nf1dV9huC1ZzYzq7d7YAZH33lgv0dKgFWCDXKWC8ef44wK9TEiMi1D6gngdrhSFfM7WS
         7/Z9LfssHcxMngsWzTcI+lKbfM9/ZmJQoEham1OfWWXe9vpFwxC1r+yuCGyWRYfXRRHf
         zTJcvoeIhs/iNIzVAX/IHrTcP3OdtOOdVHdAxvM56QQEA9Ngjd1zsdf0AnUMTnJ7Cy3O
         kIvA==
X-Gm-Message-State: ALoCoQlxSZXwtyrVt5KLvDGUhTH0bYRLOMtuAR7bZ1cKEWOE+PtszkLmcHz/6mQqMdgWoNbKPjSq
X-Received: by 10.140.150.131 with SMTP id 125mr36846271qhw.88.1444686761237;
        Mon, 12 Oct 2015 14:52:41 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279433>

This function might be used by other refs backends

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/refs.h b/refs.h
index fc8a748..7a936e2 100644
--- a/refs.h
+++ b/refs.h
@@ -348,6 +348,17 @@ int verify_refname_available(const char *newname, struct string_list *extra,
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
