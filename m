From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 27/30] refs.c: make lock_ref_sha1 static
Date: Tue, 29 Apr 2014 15:19:12 -0700
Message-ID: <1398809955-32008-28-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:26:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGTv-0000N3-6e
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbaD2W01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:26:27 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:32994 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbaD2W00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:26:26 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Apr 2014 18:26:26 EDT
Received: by mail-ve0-f202.google.com with SMTP id sa20so24547veb.5
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/4buyMmN6BUehAnPfE8Us1OOg1L26RtdHwElJnml1c0=;
        b=eHriAVhSOMRUF4zlERBa4Tdjy6UoLARbimmSC8DKmdgOg2IOC10Dce4govNMFIUKT2
         0eMv/rP8h+i5ikLgeznWxX4LfYLZkrbs/turzsqRwMgxl/uBbe+1me7qWRDsIYdOw+mr
         E7tiFPEc4u75xJkEeUAmPuFyYKQYvdnV1+l3elXIz9sefMgl4oNXgS9TH1un2ROjZ/G8
         D+sU9eKSM2YPyT42a6XMROz7jZRZu/O8lV8UX4JCQKS30umnWKYF2wWe/jBvMzyz5Zoz
         p/pCKp78UENB+tJypNlm1PjJAuW9PAuG3P2UbBr0dlPkvTOWeeh9joKK/0kHCz3Knmry
         S/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/4buyMmN6BUehAnPfE8Us1OOg1L26RtdHwElJnml1c0=;
        b=G6otLiFoKhamW4b8fInl6R7yAiSIMBsTElKElY312Ok/PhY2i19CiOltB2aBQ4KCFg
         f0j31jpqEP+e6VPQZ7iIIcWO7su6mX0hpq7s1Kp8Z/9mACrSaG9d8W09+mnLPMKebUXd
         G1Ly3sWcVc41cpEzvXCiJs0eJ9NGZ1rTtyNEQCfPXPBRJsqMYVz7hqC09kqOd5cpFD7J
         vQO/A91iDYXXTj3nbDLyPjlkh4/Izq5PVoW3gwrLzq2hDEeFmHb8UCTioIyuB0t/J/KX
         OtMNUzNX2W8Xf/aGPMvhVClzMOWiKU4T4Uc5G5q8AbvEFvA2r2uvgcEHlOef1f7uJ2WL
         J/Sg==
X-Gm-Message-State: ALoCoQl/a8mDUbUeUKqGVBNdBeSTayEZ2LmpIfCK6b3b2rlBmAGzbXp6z+/ay8513yKuKWqg48b7Tb0hqRaf5y5XAY2PaAwPuWUHjCne2k9FV5ZdLnr0IL9Om5VXaws0pcLisM5UKesOQz7qrVD0a2lXwCL4M6Qci1GjGYy7//RqvcCBUjlSNZ+70tDrIV+vvTS3IdhJpYlP
X-Received: by 10.58.127.66 with SMTP id ne2mr268423veb.27.1398809968543;
        Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si2739716yhe.3.2014.04.29.15.19.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 64D1F31C20C;
	Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2931FE0A5B; Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247657>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 020eadf..a82d6ba 100644
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
1.9.1.532.gf8485a6
