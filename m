From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 02/14] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Mon, 17 Nov 2014 17:35:38 -0800
Message-ID: <1416274550-2827-3-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXi9-0000BI-2R
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbaKRBf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:35:58 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37512 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbaKRBf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:35:56 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so2430260igi.12
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bE7sRN618wWSYS8dkoQ1hjn257ZmDvZbgGaw8bOT49A=;
        b=LzJ74EL1noQSzL4l2M7raZFWNgo9KfboXkiwNRPtMxcS4xUCXAimb9uLSNX2nqHUJB
         IUS9Z2EFMAPHwFlq5Ql1y82hytnA0Re1LAthBEy4XymitLwGP57jzyO4DQ5eowMzO/du
         F3tXwP/xYMaqmpdbbg5Y1A5YrsM+Qc+zMrQnbWuLgIkNMSbQEJHAkEyAlLPTX1teau7n
         Y07BvnMOhOT+EV+eQR81N5ZeGbQ6hoUJhoy+kvJUA07vpEc5XsyX1mTDkJGABNiiSuqS
         2/s0rZ+YXpGSm7FlC6NRtHKpaY4GIKmrSAtaC9DWdxQ9K+5V8oto8I8lpfgQOTnInSPx
         ruhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bE7sRN618wWSYS8dkoQ1hjn257ZmDvZbgGaw8bOT49A=;
        b=PlwVLh6JvJ0i8xQsg4VOZ+VqMeVw45MaCkiAGiwYzJ+//hvZARTiS+dXqFwAH5EvHf
         ByRn+6TixPGvb5mHbNj2RL2RtKsA5FnGXfrAjO+jiA9zZXq05A7r6ywpUVsbTKk1n5bC
         dZGxMYeXEypUOShwlnc0O2E5+PeUwsnFT7CCYyEfrHQ6o/bz62c/otwsu/PhLKQzeObD
         pV5j1Whf/QFDUam0PltIx77Y6zYY3tUKZ+9Yz9+izvAmnK3qBDBe0mH93alIRpvV3fzC
         R+/CiZzsA4w+S4F/F++nn6idxovEgPJ+n9ecpe+LY3U4zcLnpCWBUtzyOidUX4OK+TV+
         YVXg==
X-Gm-Message-State: ALoCoQmLRgsKp0pP20ANYsk0a6zW0/2zoZFIiE5rm4qv/E4ZZFoWFZujwUXRqi2V37aiR+O24tW0
X-Received: by 10.107.47.89 with SMTP id j86mr33309243ioo.32.1416274556215;
        Mon, 17 Nov 2014 17:35:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id i11sm6854750igf.21.2014.11.17.17.35.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:35:55 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
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
2.2.0.rc2.5.gf7b9fb2
