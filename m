From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/22] refs.c: make lock_ref_sha1 static
Date: Tue, 2 Sep 2014 14:08:00 -0700
Message-ID: <20140902210800.GP18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
 <20140902205841.GA18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:08:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvJJ-0005VJ-FH
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092AbaIBVIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:08:06 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:61338 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbaIBVID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:08:03 -0400
Received: by mail-pa0-f48.google.com with SMTP id ey11so15565144pad.7
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dhIzc+YctAPOQAj3sN8yVAOEyrTxmyEYxx4ll88rDSo=;
        b=Bpy9Uzuz8mPTKCUsJnhEUSjNZdan77oolT83ZwUuF4W9g9JU3ZtnE/459QUyGuIZVN
         x6D6tzbxsxDpGaPSWt+3jgWF1aRGHbOVFB/5sHbeWEdVl4y4lrT1KipJFanR4K1sz2qW
         ZEJOxz33imzQZFvmENuVSl4Wcw4tSdOUsY14+k6vfPvBB2Oao+hybkItq02KS9W91ymL
         c5DqGV7JkMsTwtPVyDjOMpR6hei8cqZwlH9gCZpyggJsuluI1dZJKEOnJcq7fAp8Tm+E
         lBf6Xyedctr+YB88YWI1pX1QiqlFhL+s6MrxyosBOtS4CzO7TmrhgBD2etVKDwkK27jx
         rMkg==
X-Received: by 10.66.245.34 with SMTP id xl2mr50680572pac.90.1409692082994;
        Tue, 02 Sep 2014 14:08:02 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id y9sm14193660pas.23.2014.09.02.14.08.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:08:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256361>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Mon, 28 Apr 2014 15:38:47 -0700

No external callers reference lock_ref_sha1 any more so let's declare it
static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 7 +++++--
 refs.h | 6 ------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index a3532ab..d4cd44b 100644
--- a/refs.c
+++ b/refs.c
@@ -2069,7 +2069,10 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
-/* This function should make sure errno is meaningful on error */
+/*
+ * Locks a "refs/" ref returning the lock on success and NULL on failure.
+ * On failure errno is set to something meaningful.
+ */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
@@ -2170,7 +2173,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
+static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
 	if (check_refname_format(refname, 0))
diff --git a/refs.h b/refs.h
index 3f37c65..65dd593 100644
--- a/refs.h
+++ b/refs.h
@@ -170,12 +170,6 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/*
- * Locks a "refs/" ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningful.
- */
-extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
-
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
 /* errno is set to something meaningful on failure */
-- 
2.1.0.rc2.206.gedb03e5
