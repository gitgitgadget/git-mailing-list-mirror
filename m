From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW
 and MSVC
Date: Wed, 16 Sep 2009 10:20:20 +0200
Message-ID: <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com> <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <marius.storm-olsen@nokia.com>, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:13 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplI-0004m7-OG
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:12 +0200
Received: by mail-yx0-f137.google.com with SMTP id 1so8796964yxe.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=9kVqyYoOLtvNtMsyODJFnGZgIupg26hg/VVK1bBw5BI=;
        b=b6G/EaUAaXjhtI9JAKCjKnY2tHQYpKj5LIEEn4+2i/PowQMfnCVYaEyMoUKWgS3aSW
         cEdI9eIVBb1zf12/zzHOUJ3t19++yI2k3Qp1C3CCCZF82b66+wkRwKl0HyomZr7Tu5Qd
         ELhFBwsepy7ce+IGIuDlBL1t8toDx7Lqrmkk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=38IrCiBXy1AIkKRQiXpcOg9A5LFdZcKFP4inroqj8vbIHStfKMAW0SHmma83R1eIKW
         vKQB8tyxtGIfiJylRmazQSUy/Mr+IbpludxmKG68cfvu92BeimCq5rDoA6m3FzdXegwV
         otyrp+ZEfHXDEKEZeox0jMxEqGppTWgEnV5Fg=
Received: by 10.150.117.26 with SMTP id p26mr2445707ybc.10.1253089266504;
        Wed, 16 Sep 2009 01:21:06 -0700 (PDT)
Received: by 10.177.128.16 with SMTP id f16gr7039yqn.0;
	Wed, 16 Sep 2009 01:20:57 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.147.7 with SMTP id z7mr1659347ebn.7.1253089256542; Wed, 16 Sep 2009 01:20:56 -0700 (PDT)
Received: by 10.211.147.7 with SMTP id z7mr1659346ebn.7.1253089256521; Wed, 16 Sep 2009 01:20:56 -0700 (PDT)
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com [209.85.219.213]) by gmr-mx.google.com with ESMTP id 14si1701228ewy.5.2009.09.16.01.20.55; Wed, 16 Sep 2009 01:20:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.213 as permitted sender) client-ip=209.85.219.213;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.213 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f213.google.com with SMTP id 9so3903438ewy.25 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=ozdrcPnPepPwOAia/dL+0B9tieY/AqO37uSz0FF8kd4=; b=P8Tn1Penn97XrPNCP92BQtejczczhWpqhddQciUWcWXe1LxiuwqluRyHtHpclTdNfr VT6ZpEizSWNQvRGCqkebRI7vi7hirV+4gYfmeCNfVGdpJ125g59kjb+1Ts4JnxK+dIv/ drLgSw3s5qXoIshOFbR4vlFvGEu3xyb8L9r1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=MPVxF7O3LkhLYVVF45MdcevhI6dUgnIKgg7Ns4/lhqFcr0PinKtc3f1ZVEoOqjqHI7 KH8qmspKndP9Hv0wYPBt0MajJhZpO/yjL/PAucbgy+vZKNMPkSa/wVhqD3Eny/Y8g+v9 a1N39VBJNRLHpGcmRh8ru7XC2RjRHsMBsSFNA=
Received: by 10.211.184.14 with SMTP id l14mr1968801ebp.18.1253089255032; Wed, 16 Sep 2009 01:20:55 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.20.53 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:20:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128618>


From: Marius Storm-Olsen <marius.storm-olsen@nokia.com>

MinGW set the _CRT_fmode to set both the default fmode and
_O_BINARY on stdin/stdout/stderr. Rather use the main()
define in mingw.h to set this for both MinGW and MSVC.

This will ensure that a MinGW and MSVC build will handle
input and output identically.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c |    2 --
 compat/mingw.h |    5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index c43917c..bcd23b0 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -227,12 +227,17 @@ void free_environ(char **env);
 
 /*
  * A replacement of main() that ensures that argv[0] has a path
+ * and that default fmode and std(in|out|err) are in binary mode
  */
 
 #define main(c,v) dummy_decl_mingw_main(); \
 static int mingw_main(); \
 int main(int argc, const char **argv) \
 { \
+	_fmode = _O_BINARY; \
+	_setmode(_fileno(stdin), _O_BINARY); \
+	_setmode(_fileno(stdout), _O_BINARY); \
+	_setmode(_fileno(stderr), _O_BINARY); \
 	argv[0] = xstrdup(_pgmptr); \
 	return mingw_main(argc, argv); \
 } \
-- 
1.6.2.1.418.g33d56.dirty
