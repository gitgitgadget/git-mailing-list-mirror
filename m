From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 04/14] Set _O_BINARY as default fmode for both MinGW
 and MSVC
Date: Tue, 15 Sep 2009 15:44:07 +0200
Message-ID: <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Sep 15 15:45:09 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYLD-0007G5-Tx
	for gcvm-msysgit@m.gmane.org; Tue, 15 Sep 2009 15:45:08 +0200
Received: by yxe1 with SMTP id 1so7426751yxe.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Sep 2009 06:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=5edY3dlZGvZW2jtVs+MRAVPxUKLHfSsG8c8msE4xh5w=;
        b=OQmJ6CwMEFrAKuGS3bEOrkAoLtMGcYZk4RRfEmWhFL2hY+ijTSMZ2DHjvSkpT1ALBV
         pYYoe7Ox/OQ1dbje8nNS/lhv8UJ8OfU0/07UEpdgSIpTk3WzkRqCSboIw/qXOc+Y5j50
         Xr7TRG8r7b38zvmRyYmv6orbvXM5bYs4VouiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=dXUEj5C+RAPqDx6CzbYoIG/MvEQXbxiXWhoAEx6b188oWpN22nGKONrluyBQk4XXFI
         KjlAV1Gjw3eEg/SZbOeGges2uFyivltRv0b24oRFCeKtYdIERJAfpS5g3IeVTcF5GA9j
         r/nnjjWbgPQG+PbI6vluEiptpLz7I21N0AWv0=
Received: by 10.150.87.2 with SMTP id k2mr444180ybb.26.1253022293237;
        Tue, 15 Sep 2009 06:44:53 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr7011yqi.0;
	Tue, 15 Sep 2009 06:44:44 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.94.11 with SMTP id r11mr1361781ebb.24.1253022283189; Tue, 15 Sep 2009 06:44:43 -0700 (PDT)
Received: by 10.210.94.11 with SMTP id r11mr1361780ebb.24.1253022283167; Tue, 15 Sep 2009 06:44:43 -0700 (PDT)
Received: from mail-ew0-f227.google.com (mail-ew0-f227.google.com [209.85.219.227]) by gmr-mx.google.com with ESMTP id 13si1529501ewy.6.2009.09.15.06.44.42; Tue, 15 Sep 2009 06:44:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.227 as permitted sender) client-ip=209.85.219.227;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.227 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f227.google.com with SMTP id 27so3752620ewy.16 for <msysgit@googlegroups.com>; Tue, 15 Sep 2009 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=fLIwoNvY9FIWy16PN3FVfccDCs/s6Naa0ltvYpqoxy8=; b=Z1mDo8vcioLhh0W5v7vivuUCxhArYe9loDLYK6IEbzK6RJSZoOOK4nIFx8Y+SU5t+Q O8T4PPYysCbD72shSL2tn/Rpwy8rBZq1mpsl0R1HVElnbBz/mkkXr4gJhl74+ap3wAVR zTRm1eK+CAQ76wKXVypjh/WZF2A3AWm8RHw/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=rCpHAmaOWVFAzxW3kLzBHW6G4p1zqF8oQmDKt360ZtTbgSlkyQIEAIvlbCnFTc1YNw 6JCBMzAgs7XTAVEWRkhm/gV4n94VoVxbqN5pmSkQECWjlIYW4Q1oZD5xyuHBrruPyck+ D+mvh8d9PqY1oUeHJ0odGR0fJAnI/N+HJtoYI=
Received: by 10.216.53.65 with SMTP id f43mr1618489wec.145.1253022281905; Tue, 15 Sep 2009 06:44:41 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.40 (version=SSLv3 cipher=RC4-MD5); Tue, 15 Sep 2009 06:44:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128550>


MinGW set the _CRT_fmode to set both the default fmode and
_O_BINARY on stdin/stdout/stderr. Rather use the main()
define in mingw.h to set this for both MinGW and MSVC.

This will ensure that a MinGW and MSVC build will handle
input and output identically.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |    2 --
 compat/mingw.h |    8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5478b74..5a8fae8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,8 +3,6 @@
 #include <conio.h>
 #include "../strbuf.h"
 
-unsigned int _CRT_fmode = _O_BINARY;
-
 static int err_win_to_posix(DWORD winerr)
 {
 	int error = ENOSYS;
diff --git a/compat/mingw.h b/compat/mingw.h
index c43917c..384b667 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -229,10 +229,18 @@ void free_environ(char **env);
  * A replacement of main() that ensures that argv[0] has a path
  */
 
+extern int _fmode;
 #define main(c,v) dummy_decl_mingw_main(); \
 static int mingw_main(); \
 int main(int argc, const char **argv) \
 { \
+	_fmode = _O_BINARY; \
+	if (stdin) \
+		_setmode(_fileno(stdin), _O_BINARY); \
+	if (stdout) \
+		_setmode(_fileno(stdout), _O_BINARY); \
+	if (stderr) \
+		_setmode(_fileno(stderr), _O_BINARY); \
 	argv[0] = xstrdup(_pgmptr); \
 	return mingw_main(argc, argv); \
 } \
-- 
1.6.2.1.418.g33d56.dirty
