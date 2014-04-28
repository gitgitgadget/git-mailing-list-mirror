From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 27/27] refs.c: make lock_ref_sha1 static
Date: Mon, 28 Apr 2014 15:54:42 -0700
Message-ID: <1398725682-30782-28-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuSE-000625-BQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbaD1WzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:55:01 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:58102 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120AbaD1Wy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:58 -0400
Received: by mail-qa0-f74.google.com with SMTP id cm18so123846qab.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u+vVgwjCAZHnF0k/WEADPOg8Iniqr1LIIVMnNwnUIbk=;
        b=lGlPUqOKJC5pUYBGBz3GyEiUKD9AeMW2kBVe53BZ9mX9yAQiHUgK3oEIfpgSeHmOFe
         QVtVYVTGIQ5KrVZJwJYLCnQVZT1cA5mkuVqdfzqfO1kv1U7iPYi4+mKcdOUKrqqq+mhV
         GeadGsiau3xAVK0cuVumksTox6sYdSyb+HLPtJulntbzsrtlLTs4BpcSryGd/j3RDtW5
         Fj28HSrJ36MB0VqLHJwFIVz8USXp8wlllFRvNFGQrm/JoCxeX91rBz8QMhsZQgZtDH/x
         reBqQNEy0qWeSifZgJZlr3fRyQLF8a/CfPwKkKB3FbAEIxuVPWRMaFGR01x4ThofaRzY
         DhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u+vVgwjCAZHnF0k/WEADPOg8Iniqr1LIIVMnNwnUIbk=;
        b=YhdFIVbSXpMVJbef5yjT9GQVPU1zMgWZzi09RP1NFdjvvkBWd6lRtior/IOir5I7+R
         /3mwUb9Yngu4Vb/t4Y1Fg9dOaxq1q+6sqH4cd4Uj9+NneVgOprk4etrTFaRTDiR4mT6p
         6cxfPvRvO6pw+SdUdU+b5ryLLNwfCm5V7w0/SWxGkRzNk6ftZ2MJxkiuVDsmO0oAX7DB
         Ji/IGcz3ScUb95s5LvOm4j4h2TxtKIoSK5czy2NAiMNt74K6LkjXiAP+jCKHG6XMEFyS
         +cP6Qupuee2pvUWXf9hEv/cUm3CUm8/9ews+Qgb0DpSCmIABai78ZD+GAbXPFlSvx9Fa
         p+IA==
X-Gm-Message-State: ALoCoQmUQp9YGnpnlZli20ZKlOjsRtBeE2NA7Z7WfwLLyFHgi2qY/jZpbQpvNzJ9d7PhroKj7Q1WfXBJcTlyhseBQy2l2u2IYR3rKyOg724RLeqamrXkOWqEnOMZiXKzqA3uwmokWjt5I4c7Z6JXhDPlYuzh3E2SqAe2nzIj/EFeTk/syOMhwLtz6wBMj51U1lln/7sv6Oxw
X-Received: by 10.236.126.72 with SMTP id a48mr11428793yhi.49.1398725697748;
        Mon, 28 Apr 2014 15:54:57 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si1011546yhh.0.2014.04.28.15.54.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:57 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9092A31C20B;
	Mon, 28 Apr 2014 15:54:57 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 35A5BE080D; Mon, 28 Apr 2014 15:54:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247470>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index cb7d69f..eebcacb 100644
--- a/refs.c
+++ b/refs.c
@@ -2130,7 +2130,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index bc8a95b..b14fe86 100644
--- a/refs.h
+++ b/refs.h
@@ -132,9 +132,6 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
-extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
-
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
-- 
1.9.1.528.g98b8868.dirty
