From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 2/6] Disable t0110's high-bit test on Windows
Date: Thu, 17 Jul 2014 17:37:01 +0200
Message-ID: <1405611425-10009-3-git-send-email-kasal@ucw.cz>
References: <20140716092959.GA378@ucw.cz>
 <1405611425-10009-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBM63T6PAKGQE57YX2YI@googlegroups.com Thu Jul 17 17:37:30 2014
Return-path: <msysgit+bncBCU63DXMWULRBM63T6PAKGQE57YX2YI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBM63T6PAKGQE57YX2YI@googlegroups.com>)
	id 1X7nkK-00087Y-9H
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:37:24 +0200
Received: by mail-la0-f64.google.com with SMTP id el20sf331407lab.19
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=vNvS4rvc6Yi20N9hTJIwRxSdSaTmwuOHKfq73gGoQU0=;
        b=j6c4PjGIjfjIaal/GnEFwbAymIyttigtu3uRHThP0xLlfgxn7EoDILJnaUE67Fp/AA
         2VzThfj37lt/ZqKv12+wHvtuI71tQwsdHMkDNR/2FFBumrEAOuzOKBtwvlPUFQkZ3J2x
         FAimKBohwqqHjrd57Mk25KpjYzRe+IHSz3KeJ++QlZJAo9xsFdWKakmKDpWvmpYffzXQ
         9SFx8FXRAZ5KCuhlSIpzfzqlCfwxziIerNlAJaJqKqzoXZV9chf0jSX/oI2nF9vcJiHD
         ZGEo9Zia+5NyVfSmE3mXHMEmSyB8n+Ck1oATkpkUXJQi1JLLeRNX2RxheM5RCS9An5Xo
         q72g==
X-Received: by 10.152.27.41 with SMTP id q9mr9446lag.30.1405611444127;
        Thu, 17 Jul 2014 08:37:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.185.103 with SMTP id fb7ls233309lac.20.gmail; Thu, 17 Jul
 2014 08:37:23 -0700 (PDT)
X-Received: by 10.112.142.106 with SMTP id rv10mr3722729lbb.5.1405611442997;
        Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id x7si374477wiw.1.2014.07.17.08.37.22
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 014391C0197; Thu, 17 Jul 2014 17:37:21 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405611425-10009-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253743>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The bash Git for Windows uses (i.e. the MSys bash) cannot pass
command-line arguments with high bits set verbatim to non-MSys programs,
but instead converts those characters with high bits set to their hex
representation.

For example, when running

	strings "$(echo -e '\x80')"

(where strings.exe is a MinGW program, not an MSys one) it will complain
about not finding the file called "80".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 t/t0110-urlmatch-normalization.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0110-urlmatch-normalization.sh b/t/t0110-urlmatch-normalization.sh
index 8d6096d..bcbb825 100755
--- a/t/t0110-urlmatch-normalization.sh
+++ b/t/t0110-urlmatch-normalization.sh
@@ -117,7 +117,7 @@ test_expect_success 'url general escapes' '
 	test "$(test-urlmatch-normalization -p "X://W?'\!'")" = "x://w/?'\!'"
 '
 
-test_expect_success 'url high-bit escapes' '
+test_expect_success !MINGW 'url high-bit escapes' '
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-1")")" = "x://q/%01%02%03%04%05%06%07%08%0E%0F%10%11%12" &&
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-2")")" = "x://q/%13%14%15%16%17%18%19%1B%1C%1D%1E%1F%7F" &&
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-3")")" = "x://q/%80%81%82%83%84%85%86%87%88%89%8A%8B%8C%8D%8E%8F" &&
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
