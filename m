From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 36/48] refs.c: remove the update_ref_write function
Date: Thu, 19 Jun 2014 08:53:18 -0700
Message-ID: <1403193210-6028-37-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeg8-0007mr-Ee
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933362AbaFSPyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:55 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:48260 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758068AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so693068oag.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k/hIKfRg0oNUMOdCugBYGWnOqeLdTLEeI7wSvRQiX9o=;
        b=StQP+jjXnL4o7oUpBMfwX1l3PDnBYj5cY6yO0UWxQ7ybFmkEKOBhzgajbu/VJjcWa7
         QiOnYAYoUf5Njh1AB/oJBzRzdk3wvmiBVGI9+ZJGoD/mE9KPuAhoW88lp+jKdSdkfcd+
         wxGOB8w0Z75r4Hjhma1FY5DRjEYGpqN0WhvgxTzMPJ3/zGfk/NBS6LZ8X2LNBFsMWIbK
         oTfkPO24zliYWWcx/xKE3hf4mh53JRtrZjIF/oVBI+mrkKy5diw4UOzWF6iJqyCdl+on
         HrCpfsNN5Mq4k01g3w9O2ZEi2+4XI3+hhH7RfysrnpT3vcl43CtWQxliBmK5kcUx3rr9
         4jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k/hIKfRg0oNUMOdCugBYGWnOqeLdTLEeI7wSvRQiX9o=;
        b=EsYMAqRMgEafzrQozGmCHKe+35iJArDGHCd0pe98uBWSZUqjeiz03kY5NfaRc3E1vA
         Wjk55+5X0z70lKKm2F7yMV+3OyTAYu4MKAppNbtSSxD0m6lh+Z7JpRq3zmoJNDk7KkUB
         +mhxprYaYXbENdqxaIe1oosGfLBwsOx2G/E6JJVRIeaXUxCoHTL76W5yM07l+QAESwiv
         Oq0OXrwIYWCYTolBnOX6dGzKk1usmPOzXMTtub47lNAZMnZpVU67MOUfFUgGpGWx4cOg
         N5svEihxClNrL77+i+q+RZLLpzKsvWVnFE6sU07+vkq/u9mSLCFhV2ckRc4QbsHxaTvV
         R8bw==
X-Gm-Message-State: ALoCoQmCo4TC/MA3iC75ORTxiI32wrZODNil1AQoxHy3HwQUSS9PzwB2v+HALd/89WCl+sQFRvqE
X-Received: by 10.182.123.196 with SMTP id mc4mr2566062obb.41.1403193214193;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si420408yhi.1.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0FC0131C3F5;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E0425E094D; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252134>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly. This changes the return status for _commit from
1 to -1 on failures when writing to the ref. Eventually we will want
_commit to start returning more detailed error conditions than the current
simple success/failure. For example if the commit failed due to name
conflicts etc.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index b063baa..6792938 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,25 +3333,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static int update_ref_write(const char *action, const char *refname,
-			    const unsigned char *sha1, struct ref_lock *lock,
-			    struct strbuf *err, enum action_on_err onerr)
-{
-	if (write_ref_sha1(lock, sha1, action) < 0) {
-		const char *str = "Cannot update the ref '%s'.";
-		if (err)
-			strbuf_addf(err, str, refname);
-
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-		return 1;
-	}
-	return 0;
-}
-
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3602,14 +3583,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			ret = update_ref_write(msg,
-					       update->refname,
-					       update->new_sha1,
-					       update->lock, err,
-					       UPDATE_REFS_QUIET_ON_ERR);
-			update->lock = NULL; /* freed by update_ref_write */
-			if (ret)
+			ret = write_ref_sha1(update->lock, update->new_sha1,
+					     msg);
+			update->lock = NULL; /* freed by write_ref_sha1 */
+			if (ret) {
+				const char *str = "Cannot update the ref '%s'.";
+
+				if (err)
+					strbuf_addf(err, str, update->refname);
 				goto cleanup;
+			}
 		}
 	}
 
-- 
2.0.0.438.g337c581
