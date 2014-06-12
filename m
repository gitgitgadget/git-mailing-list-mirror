From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 37/48] refs.c: remove the update_ref_write function
Date: Thu, 12 Jun 2014 10:21:28 -0700
Message-ID: <1402593699-13983-38-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hw-0007Uf-IL
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933499AbaFLRWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:30 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:64568 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so232455yha.2
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sFoJdxZZDlPpLBChwJKGFhRGkzYKGYsFvLrOZGVj1AA=;
        b=Yrl+9PqthAlr64feWjOty8j+W0h8V4N/ETwQEP25+NSMqGaFZf7Qe/kE8XfqcdgWWn
         YPTdoJMH0MtqFFhDwTL5+25nwcTKKqccBKiNBIwIbCrpcO4XGQg458udZ++r4SUtsmbi
         Zw+sPQEGmjkhUov5+BdYd1crQ9kzSzjXzwHn/4qEVQYUmAUHgdecGjHtDxUCbVmIybgc
         SUIr3IyU+mUlDyG2/EXgyY87hRxAKBaBMV5NIYz1l49IrrvQ+fuQG6xJJKfCEVVKJhjT
         5X5PhM2+CPiYpo2CV5nMQd9OTJ3xoefS44eTjAQJf2t8D7fOFkIPGP0kGsANln22s+0x
         B/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sFoJdxZZDlPpLBChwJKGFhRGkzYKGYsFvLrOZGVj1AA=;
        b=QEzp5cuMh8GZuOEsVOgqFSsJnWdQ1x5lSGRHeDUBLK0A3jQh0+lNVSr0BLcJuj7kr2
         FLeLE+eeHmZ+q60rHg8dPoB7nVZCpmo5wk9Fl2kJw/jjhoao5w7e5unDDl0OWBFQlA6U
         uiTewz24hiCLsyWBPT28D9yjgPAPSA1jHl2QYc1fLgGf2qhxK1N8n2hT7mQYSvR6fIuS
         4DMq0dHTpDu7G+rA2hsCAbIcSdAiMh0C7vEc/mptSftBEhr+/3Bf6QONjyHlOZbaROGK
         guAN2c0+y+1DxW+xkcboKQke1eo/2vW9+XdLB2mXZCIJxzfOjqcP7u9mEOHIu0LoU++F
         ZFpw==
X-Gm-Message-State: ALoCoQn33FmdmdUoFMQmHKDh4dl/nE6PvLp/biI8/vGnJ8C4wzRxijTFC63dPNscK6oW/AOzpA3X
X-Received: by 10.58.227.10 with SMTP id rw10mr33873vec.39.1402593704637;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si112265yhj.5.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7B15B5A4743;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 51040E0A87; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251430>

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
index bad7245..11084a1 100644
--- a/refs.c
+++ b/refs.c
@@ -3330,25 +3330,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3599,14 +3580,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.599.g83ced0e
