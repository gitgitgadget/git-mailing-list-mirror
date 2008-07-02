From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 11/12] verify_path(): do not allow absolute paths
Date: Wed,  2 Jul 2008 10:32:11 +0200
Message-ID: <1214987532-23640-11-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de> <1214987532-23640-10-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:34 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmI-0001Gp-50
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:26 +0200
Received: by yw-out-2122.google.com with SMTP id 8so2058159yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=tjVqA0EqiMrK8dBKoFKkyqZsiFmJZkxitI6X/xqBgvg=;
        b=BoIZVYb6tTHPYRP5y20kVIKYrSpPotEfinuu5QNWPR7TfUCMbCbpTdzfbof/RYbMZn
         BVCZ/WAj9Hrs1tRnL6bC5tYuhUKba6B+i3fysVDwmyrhH3yNxHNyKudF4o0flqCyiKzY
         WKU0tX6BXV/Nzmrc73cqknGl0oXDPx1VZ9MGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=URg/NJgYPZ/OElZqK1F5LiWvqUZbDLIQBWTGKDOUys9TKS+gQ8oA1s27CayKp6LwVZ
         LMMymIeUKeYUQZgGwYFBNzTpBuO1DJkp/hcOGPW+/rItpf/j7ozsFFpHN3i9fNpn8ydZ
         0GXXmQCTb7saC5tGCRwLLnnnQ+vPC3pzU8JPE=
Received: by 10.115.107.5 with SMTP id j5mr541537wam.20.1214987541630;
        Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: by 10.106.193.17 with SMTP id q17gr2547prf.0;
	Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.86.9 with SMTP id j9mr8825118agb.23.1214987541097; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 7si7856905yxg.1.2008.07.02.01.32.20; Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WEvt019121; Wed, 2 Jul 2008 10:32:19 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0S017527; Wed, 2 Jul 2008 10:32:14 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-10-git-send-email-prohaska@zib.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87112>


From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 read-cache.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f83de8c..cb130ef 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -650,6 +650,11 @@ int verify_path(const char *path)
 {
 	char c;
 
+#ifdef __MINGW32__
+	if (is_absolute_path(path))
+		return error("Cannot handle absolute path: %s", path);
+#endif
+
 	goto inside;
 	for (;;) {
 		if (!c)
-- 
1.5.6.1.255.g32571
