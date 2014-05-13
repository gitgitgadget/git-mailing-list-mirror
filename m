From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 18/29] guilt-graph: Handle commas in branch names.
Date: Tue, 13 May 2014 22:30:54 +0200
Message-ID: <1400013065-27919-19-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:37:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJRh-0006uz-HA
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbaEMUhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:37:01 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38344 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbaEMUhA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:37:00 -0400
Received: by mail-lb0-f171.google.com with SMTP id 10so705215lbg.16
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwHk4OwyssY5R4bKiWE04oMx43FyfRkXFRHAzGsMs3Y=;
        b=UMUr0lnHZgAvrjdULI8pqL4GDnn4l5LwILJEIKPfssNItcF4j4adqJIEeOHRXwBuEH
         r1woF7/o3+sUbDiBhLnlc7lGNNCXMZO09jeAs1aJ040omATERMrNLp9WZj94W83EaSS0
         RPZDBuwol8jRQSU98LCOGoxnPT5DADyPT4prMrhJwToN4JKs6N57NKigW+oNye5N/wzL
         Woo0z5BpIuOy95U4/4gEuAOX88bGJPEm6j76/7QRu97VatMvy+kteiCMOtZle3lp/9Fn
         dPduaecp2kNjnJb9157hfbdp2fi8MFvoyCVOHMOIozeJyPDmolJOSxf7PV4NavCbAz8C
         9q/Q==
X-Gm-Message-State: ALoCoQmyAIhZe7uvufNxNqU0vS6Vh6GuOJi8mfsSWWzxCKBWIj9R+mCWuiz+YC3VcNpnoaxW2tvb
X-Received: by 10.112.160.105 with SMTP id xj9mr7396104lbb.2.1400013418847;
        Tue, 13 May 2014 13:36:58 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.36.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:36:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248835>

This fix relies on the fact that git branch names can not contain ":".

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-graph | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-graph b/guilt-graph
index 56d0e77..924a63e 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -51,7 +51,7 @@ safebranch=`echo "$branch"|sed 's%/%\\\\/%g'`
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
