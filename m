From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 03/15] Change regerror() declaration from K&R style
 to ANSI C (C89)
Date: Wed, 16 Sep 2009 10:20:19 +0200
Message-ID: <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:18 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f142.google.com ([209.85.221.142])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplH-0004o5-M2
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:11 +0200
Received: by qyk6 with SMTP id 6so241665qyk.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=8AViAfGLHoejFFdgCuQC/KBOP43MgrlVu/bUDN4ch8I=;
        b=LdZZBInrA3FYz8+MVxmHEgqWAx9rJC9b+dhLk50e+WnemQTivrAbKepJqX2INZ+f1G
         u+Y25+rMrvQSJHDZZu0lvukCv6I7F1GEXSEfFxRrZateiPXWG9yh/dtqNUmi46d64MIY
         WaZi01s5FyqQ5ZXiRq6wYKvHr/BOO2Mfme3BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=iQbYu3/moTS7I3RkWpqnQFZ6frt0RH4h0MajDbDqH2/9N/b4HNAMcYYQCrd4aaS3HI
         CGYpKjk5d1UgganZiAppYLkhSXW0Ezmt6VYDVbNpqI1o7i79RjLjjCljmoAMEUptBUVa
         oNx28Ih4mwTMDYchDcoktCcNmF6csdLI1vCPk=
Received: by 10.150.106.5 with SMTP id e5mr2416805ybc.13.1253089264941;
        Wed, 16 Sep 2009 01:21:04 -0700 (PDT)
Received: by 10.177.112.39 with SMTP id p39gr7038yqm.0;
	Wed, 16 Sep 2009 01:20:55 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.253.11 with SMTP id a11mr1157778ebi.23.1253089254728; Wed, 16 Sep 2009 01:20:54 -0700 (PDT)
Received: by 10.210.253.11 with SMTP id a11mr1157777ebi.23.1253089254700; Wed, 16 Sep 2009 01:20:54 -0700 (PDT)
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com [209.85.219.225]) by gmr-mx.google.com with ESMTP id 14si1703123ewy.1.2009.09.16.01.20.53; Wed, 16 Sep 2009 01:20:53 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.225 as permitted sender) client-ip=209.85.219.225;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.225 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f225.google.com with SMTP id 25so2682839ewy.33 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=18mLT1QDUU+ePY0mPGJoxwpaUzON5OQAOwwAqIG/L5w=; b=ajei05BtRr6ybDSYlNCmm2hT4AJ0ZUS5Lh6y887QW0J0B4tzZd6imGLUyO/spafmXk 00jXF9pVW/10neilJpmyPFgN652z454aF57pvEcYe2ZOv2KAA6/tti2OlKk24LSIwKUN nml6T91lYZ750oC9+vT7hEOnOfx5MbPgBa+Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=CIfkvihBMzV34/yvP2t8XETqxj8RRW9nlcD2UWzd+c4jZprx9U07Y7ndV/YEoHY9v7 R+GpF5IqCvEE2K9HnZSpnILJUPfozqM2bls58rOQMoXwTjkLmj9cffREtbVa2cVNwaNk Kcv9WXMKiigYH3DWE4jYC4jx1Snme6AeWrGFU=
Received: by 10.210.96.24 with SMTP id t24mr1977249ebb.7.1253089253606; Wed, 16 Sep 2009 01:20:53 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.20.52 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:20:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128621>


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
