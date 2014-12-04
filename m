From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/13] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Thu,  4 Dec 2014 00:29:12 -0800
Message-ID: <1417681763-32334-3-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:29:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRnF-0005fc-0S
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbaLDI3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:38 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:44437 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaLDI3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:35 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so18270062igb.5
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=INumo/0idkr0bq3ek+jz9bKMmWZXUkdOXFY7x0vztGw=;
        b=RlMJJaROThFNpzZ+CzxEctv86gQSXMMlOuAkC5k9ySDlsPXOH622ryDX6iiUFggXRq
         zStOQy6xS4trx9vfqHXiYUPQ9j4RFKAEmjNpy0E5he0kiZmo190HfHR//ozLb8EORpuT
         9bmttT91QAGGDPeJXPD2YKG6dC6PjX57+jnr5Cf1P/ObW+DIndYVgKlzv9WQ86IhJ0gu
         3OTt0S3zwBqhBkW+uhLpD7tY+SHg25g0PMXAgLnXxsIg1Cfjg3F05qO5XpNwYKqvO8+T
         UFLz+nVo1giR0c8zZC5a3GoSA+l2gEj1Or4zpEU2X30GOBRBzifR9+DYdEtfe78s3NoM
         QNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=INumo/0idkr0bq3ek+jz9bKMmWZXUkdOXFY7x0vztGw=;
        b=lva3JjSuMZkZjHJno/9bCicLCePQDclTUEc3RsYxDYMJAPnSEzmz452YwlWZYUnol+
         Pmw3A3J/diVXGYxqjvBSGlCbl5ieLhmem10wJfIizgUntvgW7hJQ/AaTTgI0jJY7OUnG
         aBBNXaYC2897FXtFJ0xTQpUm9weKB2wImf6qT6MkuiaE1RvBzosPPZRn0P33vsgTW9Ay
         7ztH6SsdlWFmv8DO73+NDjnTqcbXw8y7IR3WTDvVZBHx1l+Dw+n344qZdzSnpBT0i5cJ
         rejv2z+VReAK27Xasg2VtyKUV8M7MDsQXj/Jgs8ZopOg9G1lcNhZDYYQlONZ+NIFnBXA
         z32Q==
X-Gm-Message-State: ALoCoQkPHJ3UAwT+5tZWgqP8wdzWEfkdHKFPddZQkP3R05FU6+HpVrl0P9EIHUxdmZC9olFHQKxy
X-Received: by 10.50.124.133 with SMTP id mi5mr604705igb.13.1417681774787;
        Thu, 04 Dec 2014 00:29:34 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id mx10sm19968508igb.21.2014.12.04.00.29.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:34 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260733>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

Notes:
    origin/sb/ref-transaction-unify-to-update
    as well as
    origin/sb/ref-transaction-reflog
    
    no changes since sending last time.

 refs.c | 22 ++--------------------
 refs.h |  2 +-
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 005eb18..05cb299 100644
--- a/refs.c
+++ b/refs.c
@@ -3633,26 +3633,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: delete called for transaction that is not open");
-
-	if (have_old && !old_sha1)
-		die("BUG: have_old is true but old_sha1 is NULL");
-
-	update = add_update(transaction, refname);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old) {
-		assert(!is_null_sha1(old_sha1));
-		hashcpy(update->old_sha1, old_sha1);
-	}
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, null_sha1,
+				      old_sha1, flags, have_old, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 2bc3556..7d675b7 100644
--- a/refs.h
+++ b/refs.h
@@ -283,7 +283,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
-- 
2.2.0
