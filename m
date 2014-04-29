From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 26/30] refs.c: make write_ref_sha1 static
Date: Tue, 29 Apr 2014 15:19:11 -0700
Message-ID: <1398809955-32008-27-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGO2-0002eG-17
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbaD2WUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:06 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:45579 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965289AbaD2WT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:28 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so205227obb.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yZbB34dZgWLPl6pTQ0tvrafrWUGPfoYWCnl1dZ6TfMo=;
        b=mu8rV4F8YRdcOubTe2lPhKcdXfLNT5Q29bTX/w3i59F0jTmfZElNg6mcEC1S0kHfF4
         TXPxanCcPY2zie2+aOny+rcJYDT6B0+RLT7ektavoYq5irqNgk09N2dWseou2mav4Y92
         cfa+L6L4am5e5iLttqc45T/sPJ/KrtY+2ot9xkzgHLRdYZW8WHuu4bsjvEffgqFkr7gT
         eV1QjspGFTDpFGSSfEK6FRYEIB/SChIGYkGMEqPRTGiVpiVOlMeFBvIeM2OdlOHUTvl7
         ndmc6Tm87cvYxg2TjCO9ni7/hGOByxEvgfVMq7XtGSWtPTDgZkTjv/3fZPIUJhQkOadT
         D1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yZbB34dZgWLPl6pTQ0tvrafrWUGPfoYWCnl1dZ6TfMo=;
        b=ZvsdQ9qGI7XBVCrb/cb0bMKgxG1rOQ//mugSNCuHwqMQF1K+oBHfSt6KY6WeKmEsqc
         Myojm+cjJOFQYoIJfXQZKWk92W5ZdILM4VXpyqSJF0N70XvOEWsz9xzs/JDtszjJymzx
         hMHbOzRdisegBvTdyPMpWKN2LAUliPnFJEh9Vs86KBuuBi5oo73GscSri99Hhmxe02SU
         q9h2H0RbcKZCCXFSKWeXbhUkLqhRs2DqmJaFRY3QIVr6ygeaW+d6/XOtKTXCyqyIGSKJ
         AZhvmVxYntw1rqJxjPYezW7peUg0MV9e5tCdF2z+hveYM/wX/c1zP4Dw6GGbzAnNEYzA
         jICw==
X-Gm-Message-State: ALoCoQm/Dus/cZFV6h8nppg0SBx35gJvl4O9Infe+RNv9/pjh1eFArY2aZq9BzTD2UwtakVWA47B+9pp0SjfwFxgdpKS2et/gduyUXNMUn33ZbhnO8epTfgKMpPiq/a+TnVtTASkNQU1/Ts7o34vi4qkzyZjXSvVFAiiDpagb2j038t20PowCcK85bC3FCpIulhsnOjpAnub
X-Received: by 10.42.107.146 with SMTP id d18mr289831icp.8.1398809968306;
        Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si2306155yhj.2.2014.04.29.15.19.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 15ECA5A4121;
	Tue, 29 Apr 2014 15:19:28 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B50DEE0B2F; Tue, 29 Apr 2014 15:19:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247639>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 refs.h | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index fcbdf9b..020eadf 100644
--- a/refs.c
+++ b/refs.c
@@ -251,6 +251,8 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
+static int write_ref_sha1(struct ref_lock *lock,
+			  const unsigned char *sha1, const char *logmsg);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -2798,7 +2800,7 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-int write_ref_sha1(struct ref_lock *lock,
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index fcde43e..bc8a95b 100644
--- a/refs.h
+++ b/refs.h
@@ -150,9 +150,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
-- 
1.9.1.532.gf8485a6
