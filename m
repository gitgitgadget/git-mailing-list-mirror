From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 3/6] msvc: opendir: do not start the search
Date: Tue, 23 Nov 2010 19:38:26 +0100
Message-ID: <1290537509-360-4-git-send-email-kusmabite@gmail.com>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxDUlLDnBBoEkVQsWQ@googlegroups.com Tue Nov 23 19:39:40 2010
Return-path: <msysgit+bncCOPdven-DxDUlLDnBBoEkVQsWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDUlLDnBBoEkVQsWQ@googlegroups.com>)
	id 1PKxmG-0007Yx-HU
	for gcvm-msysgit@m.gmane.org; Tue, 23 Nov 2010 19:39:40 +0100
Received: by mail-ww0-f58.google.com with SMTP id 40sf3016877wwj.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Nov 2010 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=d7nk8NbI6JhY45zD9sQpHomMzFg/iESC2Ch3mVqaIKs=;
        b=GjYSbAaL2whDd2E5GuBQT9I3kUtXhWpeEDu8bLe3Tqpz2GxltIFCsM0kIiW1wY1Whv
         1cfGrJqD3jqkI1KgtwvSZPhavmrMuIbD7wA19CwoCgQFRHkOnJXtbQQLdzOvuK58p5XJ
         E/2550/abR4VRl01lRpX4EC3BvNPw4pB5u7vY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=7JoSfG0RfkCvncdpCG0snUyOMUT7D+ZLg3A+TrsJMTIqZ6HDKKI8J69Jj2+OGM3imU
         yRWA57MoZyP9Z9jQDaqQTu7bwueTqXz32elMujLh6ORGp0F9k9Qrvr9M+aITnEGw1Wqa
         i9Cy8OG36w8PusQ5VbazQxwEVLDe1Vn13agv0=
Received: by 10.216.175.70 with SMTP id y48mr269534wel.29.1290537556276;
        Tue, 23 Nov 2010 10:39:16 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.25.20 with SMTP id y20ls1436832eey.1.p; Tue, 23 Nov 2010
 10:39:14 -0800 (PST)
Received: by 10.14.14.162 with SMTP id d34mr1073871eed.2.1290537554545;
        Tue, 23 Nov 2010 10:39:14 -0800 (PST)
Received: by 10.14.14.162 with SMTP id d34mr1073870eed.2.1290537554524;
        Tue, 23 Nov 2010 10:39:14 -0800 (PST)
Received: from mail-ew0-f43.google.com (mail-ew0-f43.google.com [209.85.215.43])
        by gmr-mx.google.com with ESMTP id t6si2091594eeh.0.2010.11.23.10.39.13;
        Tue, 23 Nov 2010 10:39:13 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.43 as permitted sender) client-ip=209.85.215.43;
Received: by mail-ew0-f43.google.com with SMTP id 22so124148ewy.30
        for <msysgit@googlegroups.com>; Tue, 23 Nov 2010 10:39:13 -0800 (PST)
Received: by 10.213.10.72 with SMTP id o8mr2045945ebo.79.1290537551340;
        Tue, 23 Nov 2010 10:39:11 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm6069478eeh.12.2010.11.23.10.39.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 10:39:10 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.43 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162006>

compat/mingw.c's readdir expects to be the one that starts the search,
and if it isn't, then the first entry will be missing or incorrect.

Fix this by removing the call to _findfirst, and initializing dd_handle
to INVALID_HANDLE_VALUE.

At the same time, make sure we use FindClose instead of _findclose,
which is symmetric to readdir's FindFirstFile. Take into account that
the find-handle might already be closed by readdir.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/msvc.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc.c
index c195365..88c6093 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -16,17 +16,13 @@ DIR *opendir(const char *name)
 	p->dd_name[len] = '/';
 	p->dd_name[len+1] = '*';
 
-	p->dd_handle = _findfirst(p->dd_name, &p->dd_dta);
-
-	if (p->dd_handle == -1) {
-		free(p);
-		return NULL;
-	}
+	p->dd_handle = (long)INVALID_HANDLE_VALUE;
 	return p;
 }
 int closedir(DIR *dir)
 {
-	_findclose(dir->dd_handle);
+	if (dir->dd_handle != (long)INVALID_HANDLE_VALUE)
+		FindClose((HANDLE)dir->dd_handle);
 	free(dir);
 	return 0;
 }
-- 
1.7.3.2.493.gc8738
