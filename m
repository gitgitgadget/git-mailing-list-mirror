From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 27/41] refs.c: make lock_ref_sha1 static
Date: Tue, 27 May 2014 13:25:46 -0700
Message-ID: <1401222360-21175-28-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxu-0003Vl-N5
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbaE0U1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:11 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:63136 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1645978yhl.5
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MHCTad4pN6d+bjXcnfo2NWNokx36wIj/jmqQRyG4xtw=;
        b=VBmkfJYKd5Ej/dYnVGnlr4vOJGQJQF4MeeyE0HRhm+a8P2G3jedpBlpUoTtXMZ2fMG
         JRlTT8YzEWvvJH4CGRWKl27T6D2+Wa+NEuXbT/DOg6XGoWRhVPTlPU5CzjCLvf/LsT6G
         cH4q3CnKREfzJ8j2GvEFZ2/wAisUOlkJ/y19NKZ4l/G9xNkg8HUytcgQa85UzmQqq8uc
         NlO3AwiF4lfs9NfRv6DFnOv3se1RlXekYKYlXfJngIUheWgv9D7FosqpGkNG64L/ZysN
         7Y4zB7Cqh9eP+icKwiTRcPtklWAV9YjalX3TJ3ThdeGB5YD6W1OEWRdzmgnOoGD7qg5E
         Gx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MHCTad4pN6d+bjXcnfo2NWNokx36wIj/jmqQRyG4xtw=;
        b=SiRFzUj8nJSH1SAEQZZJNdL8pI4gPdXJVKsEEK49GiAnOXY6fL19WH92dTpf/Kp1AC
         bdJZ7M4F7b08uvIXlCuXWWXNc1BSXVXRyjD4x1jX6+MZD+QzSUFjU2k+9/rM4qFWd/ZE
         O1AisZQcFa/hj3K1ESTYdhFdymf9a8o0awF6W4bpQusceYJpdCIipr0tKZazP99PUTzr
         3EOZsU31PFsKlNC0d/pIiMwiCCeuf9HLaE4bKc+1jJmKT+8IAYcx/4lLNkZs7qKO5WmR
         HR0+buXIBK2eIDSeUn/DtGxyqLW9kyISiEMrmM+SCKumAGdCSn6VV+TCcsdh+9E88mrO
         ZWjA==
X-Gm-Message-State: ALoCoQkgQyjszO8W/IQ6OJKgv9n1UkZ1g/cGxR5R2xXU3GEi7HW2QGLjJJOW7/aMfz6mjU0vaSnU
X-Received: by 10.52.170.145 with SMTP id am17mr12465567vdc.2.1401222365026;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1573753yhl.7.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DA6E537053C;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B6A77E0BB8; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250216>

No external callers reference lock_ref_sha1 any more so lets declare it static.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 refs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index fd8f3cf..01d8ac4 100644
--- a/refs.c
+++ b/refs.c
@@ -2124,7 +2124,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index 6c830f2..1e25e1c 100644
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
2.0.0.rc3.474.g0203784
