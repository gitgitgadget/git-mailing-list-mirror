From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 2/6] msvc: opendir: allocate enough memory
Date: Tue, 23 Nov 2010 19:38:25 +0100
Message-ID: <1290537509-360-3-git-send-email-kusmabite@gmail.com>
References: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxDQlLDnBBoE2LL3wQ@googlegroups.com Tue Nov 23 19:39:37 2010
Return-path: <msysgit+bncCOPdven-DxDQlLDnBBoE2LL3wQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxDQlLDnBBoE2LL3wQ@googlegroups.com>)
	id 1PKxmC-0007Yx-79
	for gcvm-msysgit@m.gmane.org; Tue, 23 Nov 2010 19:39:36 +0100
Received: by mail-ww0-f58.google.com with SMTP id 40sf3016877wwj.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Nov 2010 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=ybW9pCL1zCuWeBgkaYrNySjBr2rGtThnaH/FKcIRSto=;
        b=jy1cpUv3xqgz4hmX6TpI9V2LKm3tafxGXe1YD85ARFhXexlnO7pE/PgUFD/b8n0lFM
         fSSSNufE3+CBdWobwdeGENDsFwib/PwzDj/0Qqij+INXLVCSgrDMQnjKPc6W18rCyV1y
         m9z6JqQ1jvJhS63iBcIYevcm7Mrt0/VmdUPqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=sOdCg02Gmtdbp3N+b9wyV/TS94N6FsCpWX64NjWnmsHieWX8ni+jS2XeAbvuaQ3wpL
         V9OOU96icIvgW7H17GOZJw8nNz3w93CRqfHWGjbDJfZsMSSCVFrk9UcS1giZ9u5b7QHM
         R76Cr+DkcBUQyYuScvS1Tt6sJ4c8Pl9tNqYmI=
Received: by 10.216.173.84 with SMTP id u62mr284731wel.14.1290537552312;
        Tue, 23 Nov 2010 10:39:12 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.123.10 with SMTP id u10ls1430002eeh.2.p; Tue, 23 Nov 2010
 10:39:10 -0800 (PST)
Received: by 10.14.37.137 with SMTP id y9mr698137eea.29.1290537550663;
        Tue, 23 Nov 2010 10:39:10 -0800 (PST)
Received: by 10.14.37.137 with SMTP id y9mr698136eea.29.1290537550608;
        Tue, 23 Nov 2010 10:39:10 -0800 (PST)
Received: from mail-ey0-f182.google.com (mail-ey0-f182.google.com [209.85.215.182])
        by gmr-mx.google.com with ESMTP id v14si2090353eeh.5.2010.11.23.10.39.09;
        Tue, 23 Nov 2010 10:39:09 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.182 as permitted sender) client-ip=209.85.215.182;
Received: by eyb7 with SMTP id 7so5205407eyb.41
        for <msysgit@googlegroups.com>; Tue, 23 Nov 2010 10:39:09 -0800 (PST)
Received: by 10.213.17.13 with SMTP id q13mr7509370eba.65.1290537549016;
        Tue, 23 Nov 2010 10:39:09 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id b52sm6068618eei.13.2010.11.23.10.39.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 10:39:08 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290537509-360-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.182 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162005>

The defintion of DIR expects the allocating function to extend
dd_name by over-allocating. This is not currently done in our
implementation of opendir. Fix this.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/msvc.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc.c
index d6096e4..c195365 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -5,15 +5,14 @@
 
 DIR *opendir(const char *name)
 {
-	int len;
+	int len = strlen(name);
 	DIR *p;
-	p = malloc(sizeof(DIR));
+	p = malloc(sizeof(DIR) + len + 2);
 	if (!p)
 		return NULL;
 
-	memset(p, 0, sizeof(DIR));
-	strncpy(p->dd_name, name, PATH_MAX);
-	len = strlen(p->dd_name);
+	memset(p, 0, sizeof(DIR) + len + 2);
+	strcpy(p->dd_name, name);
 	p->dd_name[len] = '/';
 	p->dd_name[len+1] = '*';
 
-- 
1.7.3.2.493.gc8738
