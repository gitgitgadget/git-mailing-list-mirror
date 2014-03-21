From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 18/28] guilt-graph: Handle commas in branch names.
Date: Fri, 21 Mar 2014 08:31:56 +0100
Message-ID: <1395387126-13681-19-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxb-0002XC-DM
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759854AbaCUHde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:34 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37590 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbaCUHd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:28 -0400
Received: by mail-lb0-f174.google.com with SMTP id u14so1374591lbd.19
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QHjVpjrMkNtUM+PBjmk6rME1fkGau+7tZLY7nQxDU8o=;
        b=UEFrwT+TZW+IZ0Ss5OtZvOo+OgBMamvj9ek8k1VLMqvr6yawfhHOKX3P1nQ93CCd7c
         j5XhKtPNQsSHYl6XBx+8RTwiukWa6rlGD0MRfwnn1o3CY+pjALUXy1S3zZdm4BMxmmU9
         jPawoXlFj/g074zvhH8/g4kda5+ugnfkhy4uk3zWjTvX6I9snvTV9g8gBVUOv0wgmQxU
         wfKnHry3ypzHWBj5AblgtUvbJJ1sEfGLZNeu7tBpEAwJdnUQVyT84xWVRxufprMrawQV
         hti/SrV7eapfcWxbA1Ck/NVeAzshz325JYzljM7Yp2+n4LcjWlLrPfV9Zy4bbZN3c/8T
         +tpQ==
X-Gm-Message-State: ALoCoQlJeIajlUFihtjpEyzhw5q1oXSddIVfgxS73DheOgyH9XsPnjuLg0BTi53mf9mCzGmq8bHf
X-Received: by 10.112.61.199 with SMTP id s7mr2731480lbr.25.1395387206836;
        Fri, 21 Mar 2014 00:33:26 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244650>

This fix relies on the fact that git branch names can not contain ":".

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-graph | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-graph b/guilt-graph
index 00301d5..575f03b 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -52,7 +52,7 @@ safebranch=`echo "$branch"|sed 's%/%\\\\/%g'`
 while [ "$current" != "$base" ]; do
 	pname=`git show-ref | sed -n -e "
 /^$current refs\/patches\/$safebranch/ {
-	s,^$current refs/patches/$branch/,,
+	s:^$current refs/patches/$branch/::
 	p
 	q
 }"`
-- 
1.8.3.1
