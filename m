From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 03/14] Change regerror() declaration from K&R style
 to ANSI C (C89)
Date: Tue, 15 Sep 2009 15:44:06 +0200
Message-ID: <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:08 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYL9-0007FY-4g
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:03 +0200
Received: by yxe1 with SMTP id 1so7426652yxe.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=8AViAfGLHoejFFdgCuQC/KBOP43MgrlVu/bUDN4ch8I=;
        b=Jxa8U56gnmXq7bRe3zLKZHUhHPH/OcTHqO1ylncFHzw64qNDjVTAj8WfBQ4bjlq5Uf
         RktxxaAt6vUbGpyZMJaIMe86GrYN9h2GEBkC1J4qBfLU2kW003p7gu/pMqZZlLJsiJsA
         +iYQuP4vd+2PTyIu6Sn31sC6RUqYz3UzUufno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=dSIwrIDzwQq9xjeOzB5/tfuln19bRD5MKCdxGjjA1c2YrlAJHYZLmD+zTQ5scs4+jl
         XnJ31zgduD+xxzbYPH/Xn4fFQfym8zkO8ZCsaTCGsdNAd3RMnOyBi2ZRupNSSfoDjyip
         N/Y4gvh07As6Z+cBpd386gWF/puXKcWOAatYI=
Received: by 10.101.127.6 with SMTP id e6mr1747982ann.20.1253022286965;
        Tue, 15 Sep 2009 06:44:46 -0700 (PDT)
Received: by 10.176.145.38 with SMTP id s38gr7010yqd.0;
	Tue, 15 Sep 2009 06:44:43 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.2.19 with SMTP id 19mr129463ebb.14.1253022281319; Tue, 15 Sep 2009 06:44:41 -0700 (PDT)
Received: by 10.210.2.19 with SMTP id 19mr129462ebb.14.1253022281299; Tue, 15 Sep 2009 06:44:41 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.26]) by gmr-mx.google.com with ESMTP id 16si1530991ewy.7.2009.09.15.06.44.40; Tue, 15 Sep 2009 06:44:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.26 as permitted sender) client-ip=74.125.78.26;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.26 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-2122.google.com with SMTP id 4so658440eyf.3 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=18mLT1QDUU+ePY0mPGJoxwpaUzON5OQAOwwAqIG/L5w=; b=VR7bISiCo6PvpmziFTUC/fk4K2jH2ZjYEGhGLfMLZYeJjMHoZntvYk7IEmIDWjos1k W2sHRcHUWluTclqr4vZil/3XvYjqERN/EoodbA6PxQS26qGNl7EUxaKUG6xmVl/fNzy7 xU9/KMvHI39bCWOdqAFgbQ7+byY8NWjP4Ptpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=QC1FFECjaeO4FQDrG0SA5vnuJOOTmvF0MaLywmqRTZuOjJJ7w55uuF9w45qolhgp42 LJeSJR+mRDvp02b23I/r11qaBkcDpsmSz22bPr0/118gnyLD+eSovJjhjcksVfBIVAHd DWgeByL2FyXq++t3jIbZhI5RYdxRWYPuGlt7Y=
Received: by 10.216.20.210 with SMTP id p60mr1454611wep.92.1253022279968; Tue, 15 Sep 2009 06:44:39 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.38 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128548>


From: Frank Li <lznuaa@gmail.com>

The MSVC headers typedef errcode as int, and thus confused the
compiler in the K&R style definition. ANSI style deconfuses it.

Signed-off-by: Frank Li <lznuaa@gmail.com>
Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/regex/regex.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 5ea0075..67d5c37 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -4852,11 +4852,8 @@ regexec (preg, string, nmatch, pmatch, eflags)
    from either regcomp or regexec.   We don't use PREG here.  */
 
 size_t
-regerror (errcode, preg, errbuf, errbuf_size)
-    int errcode;
-    const regex_t *preg;
-    char *errbuf;
-    size_t errbuf_size;
+regerror(int errcode, const regex_t *preg,
+	 char *errbuf, size_t errbuf_size)
 {
   const char *msg;
   size_t msg_size;
-- 
1.6.2.1.418.g33d56.dirty
