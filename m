From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/2] refs.c: make ref_transaction_create a wrapper for ref_transaction_update
Date: Thu, 20 Nov 2014 09:38:10 -0800
Message-ID: <1416505090-1839-1-git-send-email-sbeller@google.com>
References: <20141120160000.GA31738@peff.net>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, sahlberg@google.com, git@vger.kernel.org,
	mhagger@alum.mit.edu, jrnieder@gmail.com, peff@peff.net
X-From: git-owner@vger.kernel.org Thu Nov 20 18:38:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrVgR-0004WH-RS
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 18:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664AbaKTRiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 12:38:16 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:59139 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbaKTRiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 12:38:15 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so5181548igd.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 09:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m7GlEPW5UzYPmQ+qq/2oU9qpd3iqY0exDpBL9sNYwlo=;
        b=PLc4fsL6Vn/uWS5/z4+eFCt90U/f5YBI8LYwuUV3hv8Su/BoDsJTAbZgu5yclU19on
         kYQ27NF83MSjrEj7PoDxL26iB8kw6GH7w25/da7aKj0DQv4KkncGh5rqIHofa0mCmYXA
         ck5rYe5TpivsYGhdUil+AoHlZl6EQnwD9QSV4fOUy2UB0zOQlg3RLLB8gOsCpku08tyQ
         eIdSpOZVwwt1D3kIzNrMTvme4cZx+KSctM5cjJ9OPXU0fXev2if+aNzwaCBATSPSMTDN
         CS93TKiB4zgIsrNelDWeSyJY7kH9mDOQ8ptxr99Pj7uTbIcXB4xaA3aId61BHyiyqLKl
         lwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m7GlEPW5UzYPmQ+qq/2oU9qpd3iqY0exDpBL9sNYwlo=;
        b=gk28aR23X3pS2X0uqan+bnG9ffq7i1nnsjPCHfZNaVJVTyUYsupxrNAAYczq75zcOL
         /TC64jfeWETRQl9ZCfeyZHmcfnbSili0hI9ExuVLEY5b3w4qcxQqpy+hIkceVLmmuB3f
         8Pajzt77jqVm3f0j02c8xq1qW/x20cxGbTYhTCRtGJEDWHppgl3WbfnN4mK9yVQqLoLI
         7TimrjzW43rE9x1gHzIPqzSkpQ1oaoyMW19NKmvXkYOSi/jMiW34QfhqcSBlRBTeE1Yd
         fqkU8B/EHWUZAJhLsJxsP6KtTnAcu0ZVtb0gbv2ljSMI+JK88k6JbX7MEnelsJT9D384
         1lew==
X-Gm-Message-State: ALoCoQnu8zJ775AxSYk7DfMoLh/jFCe8vLefCcYXtngStIYoXxs8eyn8wtoO/wKiZPbBob6JsNMq
X-Received: by 10.42.51.133 with SMTP id e5mr4803496icg.44.1416505094520;
        Thu, 20 Nov 2014 09:38:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:2878:9312:86d2:4f27])
        by mx.google.com with ESMTPSA id c17sm1513459ioc.9.2014.11.20.09.38.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 09:38:14 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.23.gca0107e
In-Reply-To: <20141120160000.GA31738@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

The ref_transaction_update function can already be used to create refs by
passing null_sha1 as the old_sha1 parameter. Simplify by replacing
transaction_create with a thin wrapper.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

no changes in code, just removing Jonathans sign off, adding reviewed-by 
by Michael and Jonathan

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
2.2.0.rc2.23.gca0107e
