From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 25/31] refs.c: make close_ref static
Date: Wed, 14 May 2014 15:13:24 -0700
Message-ID: <1400105610-21194-26-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhS8-0000IL-W4
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbaENWOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:04 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:33202 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbaENWNl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:41 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so51666pbc.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NJGXNnwKeHYah5nqY2V1NQAmMXeG8/NEfV7lRfpesFo=;
        b=OZDeRIvg6Gv/1ejBE2R4uH/sP8mUGfQjQNdsk/bB1vKLXr/qM3PELRVVSc/FeulBSp
         00DBfu1SOwA9BH5BkAngSFTJB11rAYvLXSln/YUAXXb8gDNbQjaCTqg6hDZAO4lO1S0r
         0WV2zafASvpJ3vVzqib96nik5t/gyTqBZaX1gYP9JSI2nSr63+iqffB+Hm0XTq/vyoTV
         0iXHG6fRjOZ6MZPh8Vp/rt3PfTPz51H2kVhZXyhoLK9zALbmD5ncXjXt5xgXeGJBzNai
         6l+iwICM/E6LFwa+oOR8tEioDtAOew9AmL3f575i+nKZ8mLO8/gBU7MCb+V98MeBV6P6
         BXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NJGXNnwKeHYah5nqY2V1NQAmMXeG8/NEfV7lRfpesFo=;
        b=LGR+7Tsm37vrNeiJYgI5NfxvUOPO/rxLpEdL17kHdwu+YcVmJw8qUqoC/R6XvUaP8S
         kbvzbAaUNsVpRn4R6J/nNOB5Z2O1jq+wg4yoPx/X3hwT/ni6Jzwlgbb3lcnyKlcjG7jh
         JlfUfEB2FP77nCurkvGMV9SVQo6iTO5wHK/exbwyJQeB7GZB63uGKAJcCjd0uiKWkVv5
         9O5HUEekW6+9rGvSjRPVbhlxy1i65cqbaii18JK9NC4IfHJrVzZUaFLPeoAgKT2GsfIG
         KoNtbTdV4E8oq+BuxUFL7yXthPsIHGc4QEt4CoNuYf7q9oF5beK+A/Ig/VI5yTppS465
         YYFg==
X-Gm-Message-State: ALoCoQm0yP4C1/EIoNfgA2+mR/BRCBsQY8spUVmkUAJF0c5s+D6dKWlIRUFqREsVc9LrqsfS58b9
X-Received: by 10.66.122.70 with SMTP id lq6mr498196pab.47.1400105621029;
        Wed, 14 May 2014 15:13:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si152505yhj.2.2014.05.14.15.13.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D4F3E5A41E5;
	Wed, 14 May 2014 15:13:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 98263E038E; Wed, 14 May 2014 15:13:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249028>

We no longer need to export close_ref. Make the function static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 6933036..a430b22 100644
--- a/refs.c
+++ b/refs.c
@@ -2668,7 +2668,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
+static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
diff --git a/refs.h b/refs.h
index 47982ca..f211e13 100644
--- a/refs.h
+++ b/refs.h
@@ -139,9 +139,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
 
-/** Close the file descriptor owned by a lock and return the status */
-extern int close_ref(struct ref_lock *lock);
-
 /** Close and commit the ref locked by the lock */
 extern int commit_ref(struct ref_lock *lock);
 
-- 
2.0.0.rc3.506.g3739a35
