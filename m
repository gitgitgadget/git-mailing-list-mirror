From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 18/33] guilt-graph: Handle commas in branch names.
Date: Sun, 18 May 2014 23:59:54 +0200
Message-ID: <1400450409-30998-19-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:08:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9Fp-0008Hx-RV
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbaERWIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:08:22 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:54033 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaERWIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:08:20 -0400
Received: by mail-lb0-f177.google.com with SMTP id s7so3405273lbd.22
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwHk4OwyssY5R4bKiWE04oMx43FyfRkXFRHAzGsMs3Y=;
        b=WU7KSYvDsI0o0CKC7RifKWpXCEMqUUcj1q/yso053jndYDWA875n1ApSELj6HML4z6
         wN94HtPKSlYhcNl7a/h5H3dk5QsjsNNsLQbhwroe4kyYGnu/W5cF56KmTzXEnnWBw9wl
         TTo9aln3nA816OVXoi/Wc9B0aZg93ID4nrvz/8Lqh8wCpeAtpUy+qcXRUnuBLo0+cbL8
         02NRvRRrKYL97fUOWOQd/ZTdIzylpJqlL30vTvcMCz/AxT6A/piD/PXoCRUbbYGv8jZp
         bdWt12X4AUEn/Jf7Hk4YLWorArl7bTxA43FurUH09woTwSLIkFFDYRmaEamFNsGWFrt7
         QEqQ==
X-Gm-Message-State: ALoCoQm6eHHBA7uGVl01R7lJyQeCcK9KKS1Nw1PYf/mLulbR2EhrbC/MhutsgOimlXixQSYxVGx7
X-Received: by 10.152.88.10 with SMTP id bc10mr23372237lab.23.1400450899348;
        Sun, 18 May 2014 15:08:19 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.08.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:08:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249533>

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
