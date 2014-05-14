From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 27/42] refs.c: make lock_ref_sha1 static
Date: Wed, 14 May 2014 14:17:01 -0700
Message-ID: <1400102236-30082-28-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgbV-0008MQ-Vh
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbaENVTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:19:51 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:59393 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbaENVR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:29 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so33656veb.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MfTlkLhgpDu2wUnHzqwSe4MCIg/Pf2Mc3qGob5W50xE=;
        b=bzJ8/pABqrk0dhgeD+U/PQzvCao6Q5vJ+RaVA6sItYFW0wWPXBnx/pSmKvZAlV5Nim
         VhFbldxPNl7cceZ4IT0MTVIBbKn4i42pWtQg2XIi2eGDhU0Y2LeMzIxGGaKhup4N+N0f
         Wtn2UYLTIzhWXufFWLeVSEDHHJPxZxNcwufhAduAB5xfX08nmM8y+WMWY/moSerLBKSR
         1j8pTn7itmZyh7iuS99IGAhPTcyh7xYMXDdzt8p2VMNDbh9O/56faSe5v213TT3eulyy
         IBVwMAoAWAGvNkblxGUBhFHo+czf/u9vFxL7dMvOd+zfsr1mXe1kW3LyIvfLdW122TJF
         UEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MfTlkLhgpDu2wUnHzqwSe4MCIg/Pf2Mc3qGob5W50xE=;
        b=kstOf7qYdR2nryLCc2vsxBjRXGoZuzuU4ZOUFoazAO3KITuPjaFdPt+CsLL5QvH4fS
         GOB+hvOjkGT4b0pKsC0UudvRK/dQSH5s7+xMD1Z1frFQ+3UFsO8ImvKIICDjcJ7d4vIB
         DP3aWLgRTogNGjafgBOyVAK1RgSXZWXecuzJV7lRoCvXSP7h45x+7DXmMctREwSh4+F0
         8y/FgeP7GvLuHUYY2AcaOHXTNm853g0jF+TvovjIUjKRyq5Af3HYBG0AYLU6ArzDTPeV
         G3IjHcrGf/WSqlTemYowgEckSQxNgd1Ks1J4PgiZRP4RNNtppb16QEgNXjPdW5JxtyTD
         5KOg==
X-Gm-Message-State: ALoCoQkvYknU47fQKe56lrPntb36tr0CpKz552VxgijB7nDdyaEVin4cH/Oi7si8rHWu4XFUvCL8
X-Received: by 10.236.128.195 with SMTP id f43mr2493238yhi.45.1400102249121;
        Wed, 14 May 2014 14:17:29 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si145202yhk.4.2014.05.14.14.17.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:29 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F23955A42DA;
	Wed, 14 May 2014 14:17:28 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B747AE0973; Wed, 14 May 2014 14:17:28 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248981>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 0e88197..b7fa79b 100644
--- a/refs.c
+++ b/refs.c
@@ -2126,7 +2126,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index 9e7a1ca..cdea911 100644
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
2.0.0.rc3.471.g2055d11.dirty
