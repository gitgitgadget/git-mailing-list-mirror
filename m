From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] refs.c: make ref_transaction_create a wrapper for ref_transaction_update
Date: Wed, 19 Nov 2014 13:40:23 -0800
Message-ID: <1416433224-29763-2-git-send-email-sbeller@google.com>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org,
	mhagger@alum.mit.edu, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 19 22:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrCzT-0000Oz-Uq
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 22:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264AbaKSVkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 16:40:35 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35191 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757258AbaKSVkc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 16:40:32 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so1480904ieb.40
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 13:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1jfvd3tx4dqkdhso4xWxKBTfqAcxbwVF4WKuP40R/4=;
        b=IOOK8lU65DZbqfrUEhTKhVqlQAqKUiivNWQSm0wuX+AaFHHlL37LsWAHAjD9Xyy/TR
         oqdE0UUJdxjDdoUoWdtN3LPpUYc/msN2xkmZPQE9Ia6n+D9JkaUtjfx/4zA2ZNU3/+bE
         Q1lGxMicyrDQaJAMgsfYqX15U5WXDNICnX32xRt50LxNJXjFtwdl2UVQtlmRxa8NFDHG
         nvdewEUeu2wIC8jlDzxL2fSdXgMTxa0DGATG1gnY4jBvp05AnvAGfwgCg6bdGPq/FeVR
         B6/1Gg1uAmoD1Aq1YW/PYXYbdrSc9pjeQwiG3KE8kW+67Uf82CTN7PQF5GolK98nrwnZ
         e9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X1jfvd3tx4dqkdhso4xWxKBTfqAcxbwVF4WKuP40R/4=;
        b=ivT7E4MmDrIJhKE6fHuUjjQTvNXfZzHMXqkkyymMGPxyuzq5ENaRPm1VBA9e83fgHb
         lxkYD70PYVEymNv/sWZ03oFwik8xqcmfQnqWhDHMXX+3oKJBK0vfxS0pHxibXwGzXMy4
         FKInsM/tljy7u82gPGeoKB9+ubDqBGOAS5EMpPKf3jPxoLp4T5V6QKpM9m770CbNy04P
         iu6qNRwZu/ttCXw22S6+jg+5TnGP9qNqpW2F6Ah89ePIZpSUQDGi0DWJD+w/5Vs9uSbQ
         LITyGTUV2Gh1tbEI/8mhcbbF5WT7AsivzN/fbnFiSUvNsTWXy1bxnPahORN9hxv9XYQZ
         En1Q==
X-Gm-Message-State: ALoCoQli4NhBY9umkrx45ZATDbOCVVPFIPGkvTuFfinnD+0yRbbTQVtZ2Rjvf4uuGpSrWeltZuT+
X-Received: by 10.50.119.3 with SMTP id kq3mr5712290igb.46.1416433231872;
        Wed, 19 Nov 2014 13:40:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:7876:7c52:1268:8374])
        by mx.google.com with ESMTPSA id kk2sm1478468igb.14.2014.11.19.13.40.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 13:40:31 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.13.g0786cdb
In-Reply-To: <1416433224-29763-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

The ref_transaction_update function can already be used to create refs by
passing null_sha1 as the old_sha1 parameter. Simplify by replacing
transaction_create with a thin wrapper.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 The same as sent 2 days before as part of the ref-transactions-reflog series
 http://thread.gmane.org/gmane.comp.version-control.git/259712
 
 no changes since then.
 
 refs.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..005eb18 100644
--- a/refs.c
+++ b/refs.c
@@ -3623,31 +3623,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: create called for transaction that is not open");
-
-	if (!new_sha1 || is_null_sha1(new_sha1))
-		die("BUG: create ref with null new_sha1");
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "refusing to create ref with bad name %s",
-			    refname);
-		return -1;
-	}
-
-	update = add_update(transaction, refname);
-
-	hashcpy(update->new_sha1, new_sha1);
-	hashclr(update->old_sha1);
-	update->flags = flags;
-	update->have_old = 1;
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, new_sha1,
+				      null_sha1, flags, 1, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
-- 
2.2.0.rc2.13.g0786cdb
