From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] refs.c: add a new update_type field to ref_update
Date: Wed, 26 Nov 2014 21:34:43 -0800
Message-ID: <1417066485-24921-3-git-send-email-sbeller@google.com>
References: <20141120181701.GB15945@google.com>
 <1417066485-24921-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, gitster@pobox.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 06:35:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtrjI-0005DC-8k
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 06:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbaK0Fey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 00:34:54 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:64603 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbaK0Fev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 00:34:51 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so3797915igb.5
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 21:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KpQ8GG1ASKzv5XnY7SuYk6Ef3nCuHBTxgrcQVUq2fj0=;
        b=ZaYvx4DpCEtzEiRbateCEyITVdlcp6noLfcu4fVS+ICzErnKpZY1zMTEOy29hJUDjq
         n9QaQYHQnNmaKIVodTRR33GGWp83LmxmvpsPNf9q9EY285yOGBvrygRLM8VUUUBbE6HG
         wEHXJP4pPbyte2bCLkXfqNAN7gKGiG6ZkCQ+t035s+jor4OFc2kWk5Sw4Jmd2rG0WaEA
         XzGe+iw6bSyq/MTBJFt7PRtycqAurOA+ODG8LMAId8zAb4+3wjR8vh4p7mrh74Xu6wNU
         TgPLPQwCXcCUSRZKIAWfyMzEdsocG/+Nl36j6S7HSIYD9bBctqF6M4PsO9DOjm/vf1Mh
         r06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KpQ8GG1ASKzv5XnY7SuYk6Ef3nCuHBTxgrcQVUq2fj0=;
        b=DunTD6eIyRV+GDOrvWERT9u/gt76dwrQGCH1HvmVt782IAIKVBg53fQ0t2KOF5fFhs
         nbouEIdQc5T3yMnrkYUsz8ImmCchSlpyAu0i/3O6vvMhWRPgBPNm89SGsay7iHshpwFB
         MnpyNSihZTtRBEPJo5Q9f8zpDcYEWMtgiSRmsc9bYAFQiDi7nHe7/aXNiZpEQLDI7HLN
         bwNneVkaVuZrvhlECPDIW/u+mBCCumk+t6b2rVgOSt4NPgAgnZKUE5DI++diHooiKvQ6
         vzTekrIONY6cj9R7w+bFipsqHcs2MNK0f25Ub0XdbBFLP0gGyK2DAP0nKmbnOas2haCJ
         TbFA==
X-Gm-Message-State: ALoCoQnxUNWBnOKIYbtVKlbrsPjcilzO+uiPwvKmHAOCbnuabCw5xqnIqAXVMRhLkTNYjpMx3BZV
X-Received: by 10.50.79.193 with SMTP id l1mr26509885igx.30.1417066490743;
        Wed, 26 Nov 2014 21:34:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:3190:a053:325e:48b2])
        by mx.google.com with ESMTPSA id b123sm3121380iob.4.2014.11.26.21.34.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 21:34:50 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1417066485-24921-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260336>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a field that describes what type of update this refers to. For now
the only type is UPDATE_SHA1 but we will soon add more types.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index f0f0d23..84e086f 100644
--- a/refs.c
+++ b/refs.c
@@ -3516,6 +3516,10 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
+enum transaction_update_type {
+	UPDATE_SHA1 = 0
+};
+
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3523,6 +3527,7 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
  * value or to zero to ensure the ref does not exist before update.
  */
 struct ref_update {
+	enum transaction_update_type update_type;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int flags; /* REF_NODEREF? */
@@ -3583,12 +3588,14 @@ void transaction_free(struct transaction *transaction)
 }
 
 static struct ref_update *add_update(struct transaction *transaction,
-				     const char *refname)
+				     const char *refname,
+				     enum transaction_update_type update_type)
 {
 	size_t len = strlen(refname);
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
 	strcpy((char *)update->refname, refname);
+	update->update_type = update_type;
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
 	return update;
@@ -3618,7 +3625,7 @@ int transaction_update_ref(struct transaction *transaction,
 		return -1;
 	}
 
-	update = add_update(transaction, refname);
+	update = add_update(transaction, refname, UPDATE_SHA1);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
@@ -3696,13 +3703,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 
 	assert(err);
 
-	for (i = 1; i < n; i++)
+	for (i = 1; i < n; i++) {
+		if (updates[i - 1]->update_type != UPDATE_SHA1 ||
+		    updates[i]->update_type != UPDATE_SHA1)
+			continue;
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			strbuf_addf(err,
 				    "Multiple updates for ref '%s' not allowed.",
 				    updates[i]->refname);
 			return 1;
 		}
+	}
 	return 0;
 }
 
@@ -3734,13 +3745,17 @@ int transaction_commit(struct transaction *transaction,
 		goto cleanup;
 	}
 
-	/* Acquire all locks while verifying old values */
+	/* Acquire all ref locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 		int flags = update->flags;
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
+
 		if (is_null_sha1(update->new_sha1))
 			flags |= REF_DELETING;
+
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
@@ -3762,6 +3777,8 @@ int transaction_commit(struct transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (!is_null_sha1(update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
@@ -3779,6 +3796,8 @@ int transaction_commit(struct transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
+		if (update->update_type != UPDATE_SHA1)
+			continue;
 		if (update->lock) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
-- 
2.2.0.rc3
