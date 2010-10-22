From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 09/16] daemon: use full buffered mode for stderr
Date: Fri, 22 Oct 2010 02:35:20 +0200
Message-ID: <1287707727-5780-10-git-send-email-kusmabite@gmail.com>
References: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCUuYPmBBoEdVYZ6A@googlegroups.com Fri Oct 22 02:37:01 2010
Return-path: <msysgit+bncCOPdven-DxCUuYPmBBoEdVYZ6A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCUuYPmBBoEdVYZ6A@googlegroups.com>)
	id 1P95cy-0002V4-Vz
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:37:01 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf139996wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=ak+oYKK7qqVNAb9KzKlE+yU/49w+bvJ0N2EECavpstE=;
        b=OgH22SvlwV015E/ZUX0vNiCfPA0t9ruAZJdQ/L6wgKPTOn/BKc7T9Z27tHDyVQ2Ed6
         Gn10I6rDsLPoHBCl6Vp4VDcmIbAfefNL+jf/0OAU4K9cMc53aXnXRV/c12t4epjC5dN+
         1rOWSzsvOiMKv/XrEOYRvgcxjrpJRUkDpjBMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=oZ2zPv5HLQm6kJkBgpGj9mOZC9crRfWSZaQ1DqVOnpkukuLMrc8nA6OIaXi3NzFOAp
         dz5lRVda8w9nmjHgRbsYyOpZcWR9rzCFpwLHSBGd7Tv4faV9YrAIuYWtMtaxDbackEHD
         Za5eKX4PZreUKBXy4LDLVMNgIMFVBvzf0Ci+4=
Received: by 10.216.173.84 with SMTP id u62mr237461wel.14.1287707796823;
        Thu, 21 Oct 2010 17:36:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.24.73 with SMTP id w49ls269150eew.4.p; Thu, 21 Oct 2010
 17:36:36 -0700 (PDT)
Received: by 10.14.2.211 with SMTP id 59mr174383eef.28.1287707795873;
        Thu, 21 Oct 2010 17:36:35 -0700 (PDT)
Received: by 10.14.2.211 with SMTP id 59mr174382eef.28.1287707795843;
        Thu, 21 Oct 2010 17:36:35 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
        by gmr-mx.google.com with ESMTP id z6si1451009eeh.6.2010.10.21.17.36.34;
        Thu, 21 Oct 2010 17:36:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.46 as permitted sender) client-ip=209.85.215.46;
Received: by ewy7 with SMTP id 7so377851ewy.19
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:36:34 -0700 (PDT)
Received: by 10.14.119.72 with SMTP id m48mr1480126eeh.44.1287707794738;
        Thu, 21 Oct 2010 17:36:34 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm2479534eeh.9.2010.10.21.17.36.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.46 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159620>

Windows doesn't support line buffered mode for file
streams, so let's just use full buffered mode with
a big buffer ("4096 should be enough for everyone")
and add explicit flushing.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index c7b7976..ca85e25 100644
--- a/daemon.c
+++ b/daemon.c
@@ -67,12 +67,14 @@ static void logreport(int priority, const char *err, va_list params)
 		syslog(priority, "%s", buf);
 	} else {
 		/*
-		 * Since stderr is set to linebuffered mode, the
+		 * Since stderr is set to buffered mode, the
 		 * logging of different processes will not overlap
+		 * unless they overflow the (rather big) buffers.
 		 */
 		fprintf(stderr, "[%"PRIuMAX"] ", (uintmax_t)getpid());
 		vfprintf(stderr, err, params);
 		fputc('\n', stderr);
+		fflush(stderr);
 	}
 }
 
@@ -1117,7 +1119,7 @@ int main(int argc, char **argv)
 		set_die_routine(daemon_die);
 	} else
 		/* avoid splitting a message in the middle */
-		setvbuf(stderr, NULL, _IOLBF, 0);
+		setvbuf(stderr, NULL, _IOFBF, 4096);
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
-- 
1.7.3.1.199.g72340
