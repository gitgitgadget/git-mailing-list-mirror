From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 08/15] daemon: use full buffered mode for stderr
Date: Fri, 22 Oct 2010 02:05:37 +0200
Message-ID: <1287705944-5668-8-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCWq4PmBBoEkp5jAA@googlegroups.com Fri Oct 22 02:07:12 2010
Return-path: <msysgit+bncCOPdven-DxCWq4PmBBoEkp5jAA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCWq4PmBBoEkp5jAA@googlegroups.com>)
	id 1P95A6-0004SK-UL
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:07:10 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf128526wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=i77+nTsdud1SkQLNq8aHxZwaH3fjRckaDFR0xQbQ2pg=;
        b=Q1hvi1N4NX8UYax6hKO0zq8c7TSmpoY8GcYvxkR9Rq4aRbWm5kCYgR8IG4dgP2Ktrx
         DZRzU4zazcZ6lL097eMKdnszYNVXfFcyKpwViSTIJ03cKy+QO0UmgUeXu9RuZ5gUFv04
         CgjfKOt9WgysArtCZmVui+NhoVVDpgXcIdMvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=l9aYIKBGBVr9jWbMritTvGxiDPw+nHT0XPS4/jGYJ4WiPlPvuyv6o4w0e/iRaBs/q9
         wW/vfvx8wSj4NZcwLAPt9oJ4klcpKS0a8CKKOTcDCTsloozFut/DXiHu+2aIAN1zo7JX
         X82HDJomw01O+oK5sFLXOuyQK3/HuhQ/IqkbM=
Received: by 10.216.237.231 with SMTP id y81mr288185weq.23.1287706006819;
        Thu, 21 Oct 2010 17:06:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.26.28 with SMTP id b28ls268712eea.5.p; Thu, 21 Oct 2010
 17:06:46 -0700 (PDT)
Received: by 10.14.119.72 with SMTP id m48mr151141eeh.22.1287706005887;
        Thu, 21 Oct 2010 17:06:45 -0700 (PDT)
Received: by 10.14.119.72 with SMTP id m48mr151140eeh.22.1287706005835;
        Thu, 21 Oct 2010 17:06:45 -0700 (PDT)
Received: from mail-ew0-f47.google.com (mail-ew0-f47.google.com [209.85.215.47])
        by gmr-mx.google.com with ESMTP id r57si1424845eeh.5.2010.10.21.17.06.44;
        Thu, 21 Oct 2010 17:06:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.47 as permitted sender) client-ip=209.85.215.47;
Received: by ewy2 with SMTP id 2so240662ewy.20
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:06:44 -0700 (PDT)
Received: by 10.213.14.135 with SMTP id g7mr2821435eba.52.1287706004671;
        Thu, 21 Oct 2010 17:06:44 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm2460470eeh.20.2010.10.21.17.06.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.47 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159597>

Windows doesn't support line buffered mode for file
streams, so let's just use full buffered mode with
a big buffer ("4096 should be enough for everyone")
and add explicit flushing.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 11a5e06..b72c89f 100644
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
