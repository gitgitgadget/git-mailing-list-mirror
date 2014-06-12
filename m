From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 42/48] refs.c: pass NULL as *flags to read_ref_full
Date: Thu, 12 Jun 2014 10:21:33 -0700
Message-ID: <1402593699-13983-43-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hx-0007Uf-42
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933494AbaFLRW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:28 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:48662 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so185493pab.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sae1gjBGS1VXO7ooRXcIiVP0PPMHJiIfqwlJh4VyZrY=;
        b=UcnG3Bs7tyn/BnWVQ2YjGkfNzHWtaJzyvPN/A9Sbj0Mp06eeOz+esVz+YoHGO+Ob2K
         VK8/vJcTXhK/pRMd4l1oiyg6Kpt2/9gj4DAWTnU+6UzoVSQw0hecofMnE6xY+yZy6Yxz
         Hd/BLNQB6MVuIwjib6cy/9v1yQiUSirfJKaEP+TdYYCdDnC2l/wt9xVd9zHZ5LIHUQ3L
         simF5VnQ16JAaJnM3eJrDZHkVMC7Azjk3CgAH9bHbjx70RZOEJTP82VVH2s9f7NQAVzj
         nmiUAaxCMOOwSFwXmWRPDvUlL49VQtE/Aq12ntmVgxhHVtf+Y5C8pOMIRqKcJsetn4/w
         f/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sae1gjBGS1VXO7ooRXcIiVP0PPMHJiIfqwlJh4VyZrY=;
        b=XUEOeFJ6wCtENUOXTTcIQL1UOagU8nL1E0gtuQoMSlE2J4vZf5KWg1eI/foZVBG4lF
         1n+UXX8G0oUvvL1yegRL1cvWWv2QUaC/7Ex52fZurUIB84Iaz4URJg0SiO1nSHGwZQRX
         ZM79ULzoYtSD9EUU2Y7QcF9wu4/g846V4CHJdsFcJsEZB/Dn59RHe1w+ZmUVDenojq3p
         nUTjzenIlgcjcpfql+Lyw/fAb8dSo81OCTJnWQKOs6wmjt5S+k8XSE9zSdWApm+STRlI
         BBZbZG23Nt2GJuiBtWZyfsTzkuwhq6J9BrznnH4pfbsSzzDLpFA0qnksIbnzXDEzpy7J
         0Iqg==
X-Gm-Message-State: ALoCoQl2H2FzgVgZwgX2STe8L0N7z/Lq0dALDpR34xJZDGcfArrMvyCqWk2r5pB5F8BcKmlz23YA
X-Received: by 10.66.236.136 with SMTP id uu8mr3243132pac.13.1402593704821;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si113424yhe.1.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A04DA31C673;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7C95BE0D39; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251429>

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index ba8cbaa..4b32924 100644
--- a/refs.c
+++ b/refs.c
@@ -2662,7 +2662,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.0.0.599.g83ced0e
