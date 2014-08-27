From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/20] refs.c: make lock_ref_sha1 static
Date: Tue, 26 Aug 2014 17:34:41 -0700
Message-ID: <20140827003441.GP20185@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:34:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMRCL-0007Jb-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 02:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467AbaH0Aep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 20:34:45 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:42430 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbaH0Aeo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 20:34:44 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so23975436pab.26
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dxcpsXwaiA2z39nA6IgcMuI1TIA8G0xgwQEEr/Jo9zw=;
        b=c08qPzNyFUc7ag/2EB0UA+r+W1G29UVcyeARIFBGFb7bDFVj7lI8lSVqVDZDWH/DfI
         2GKR4dVEShmlvernnz8laas4fJY/D9BKbqjETKEafDTlsWSomy/qTXGU9HwlxYwnbJ/b
         wDzT1RMLNIAF3NM/ouNjahCN3aFLlTMYmaDFQdazA73b+RCHu+ZA/U+zpCb7t1pT12bc
         ICMqzeZ9WlHRatdC2rouODciimdQncXnYf9zg/oDB7aKKxY5aN4Cp2+0NmoNC2E2G+jc
         DgLdpGH6DYTyQ3rCSpueeziSauDGSQl9uMSV5Tk/RkAX0PCon3En+Ot2gr52x4yeTtnx
         4nZQ==
X-Received: by 10.68.105.197 with SMTP id go5mr41020794pbb.73.1409099684516;
        Tue, 26 Aug 2014 17:34:44 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:4ba:9bd4:148:77e4])
        by mx.google.com with ESMTPSA id x1sm4488926pbt.65.2014.08.26.17.34.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 17:34:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827002804.GA20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255971>

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
index dcc877b..0dc093c 100644
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
