From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 26/27] refs.c: make write_ref_sha1 static
Date: Mon, 28 Apr 2014 15:54:41 -0700
Message-ID: <1398725682-30782-27-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuS5-0005nE-3G
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157AbaD1WzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:55:03 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:40760 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbaD1Wy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:58 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so991820qcv.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yTkoH1yu4SBmUsvtImfsMdDqQpFseYboF3UXJHMbR1A=;
        b=Aa8jEVHBrQZKW4R3/CFjYp3mUHKOpX9IDChgAmQ/40c88hCHR71SdnOhXzUNvQH0+S
         QX4crQYmqNWU4poMmPqn8a+v4xklNHscHwvQJwvUQLWwWC63m3uFF4eZcUMevTrexC5y
         KNiycVcZfpVpRT238ph2Epgm4oiPt9pKorpcnvjADEVCFH7TmlTXa+iGohHdp6jkPP6v
         WcAbZAdK8+sfKZU5FBmG7yaMOVZEl/1B/bAMgobH6P7F4dyGyunXTvn+PXTMDKk2FoXn
         9hWeMfrG+HFFkvBXNPQaoDhlzycvt2anitSXD1HD30gVaRbth2rc5+8IeA5eHDeFaVm5
         dsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yTkoH1yu4SBmUsvtImfsMdDqQpFseYboF3UXJHMbR1A=;
        b=UiDpqtx3hKFDe4ZRSvn3dTlkMFDuqplbVx11/XhlStuc8qMNRxrdCIDxOZskwzWcFq
         L5+OnCIZXpGJL2oRSmAdKPFHqq8tkCLzgDMJUJLtHpWTlwm8QUmxCGljO+EzKuih11yx
         r5YQljRvRJ0kqQ25pkPiqJt2dSCUMa6e3PtxaP12m/bLGEpgc7SKdHSq1+jHm8pW+2o4
         rLcSdfxPrvHkPf7NqjvQr/HhTaam9K1ANBsV/64vOPVYucM6/hXYgGMKf9GqC4f+130I
         m7OPmAcvatSPoLImqnSrejm7UZPyuJACI25umH2IlGMq4NL5Qf/Vmn8DYJAEb9gHlfaK
         0odA==
X-Gm-Message-State: ALoCoQnXwdeyqxXJzM8BGjShRAYNGy59C3Av+9719Fnbb29JY8lDzTHFHWaxnrHh7nxsbqXFlIxHec5Zv4eoXYAZ1Qe11assDs6IbJBjDUf2kAGVwDiaQJQwpfIpl4AlVqE9IdTJz6oYciKPH9XKIJhi4jLx9Wa1wYLKWBwBp1cG42fFPEaeG2K0uSqMgor3v18NlLxzNE2f
X-Received: by 10.236.180.2 with SMTP id i2mr11954309yhm.4.1398725697190;
        Mon, 28 Apr 2014 15:54:57 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x22si2350187yhd.5.2014.04.28.15.54.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:57 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 048815A41EE;
	Mon, 28 Apr 2014 15:54:57 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7E962E08C1; Mon, 28 Apr 2014 15:54:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247468>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 refs.h | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index add95ba..cb7d69f 100644
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
1.9.1.528.g98b8868.dirty
