From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 0/6] mingw test fixes
Date: Thu, 17 Jul 2014 17:36:59 +0200
Message-ID: <1405611425-10009-1-git-send-email-kasal@ucw.cz>
References: <20140716092959.GA378@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBMO3T6PAKGQEWZFM3IQ@googlegroups.com Thu Jul 17 17:37:28 2014
Return-path: <msysgit+bncBCU63DXMWULRBMO3T6PAKGQEWZFM3IQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBMO3T6PAKGQEWZFM3IQ@googlegroups.com>)
	id 1X7nkJ-00087F-D5
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:37:23 +0200
Received: by mail-we0-f186.google.com with SMTP id u56sf335503wes.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=e1HN8a0moXoqsUH0N9DT08h2Y1wmR+DZHSsemtRQH8E=;
        b=LwvVv3JPqUlyHcSHrGNz9iBToSybc2uuMpBxLjm21xjRJEiOeHdQbaEKkcqX9dySvM
         UeHBpE+Ck421izIFEpIy/lG7a9kWtxK6ql2FA8p3GhFCCcLU1aRV24C41pfN8q2VTK3D
         wJzvnugWZJAvwfq1sZ9U/HJlprSQPGlcB+YW1nMbyWJlwqPMqIsGyg3JAqhmJbZYF/qT
         mvXNnNsCKiBaFWbuvMt1Bf7Yq4dPXCRO8g8r7pYZRvQ5P1Vx508aeIqnw84m3l0eMnhg
         MfSLTiPOLVMyQH33CCSaqanXX3uQy+O9DWURfQR74glIWxrlQ8ke6k7Mv5Ti6uvELkhl
         wUIQ==
X-Received: by 10.181.5.7 with SMTP id ci7mr87795wid.15.1405611442333;
        Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.211.70 with SMTP id na6ls458936wic.7.canary; Thu, 17 Jul
 2014 08:37:21 -0700 (PDT)
X-Received: by 10.194.2.130 with SMTP id 2mr1352018wju.5.1405611441160;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r13si374847wib.0.2014.07.17.08.37.21
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id EC3A61C0195; Thu, 17 Jul 2014 17:37:20 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20140716092959.GA378@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253741>

Hello,
this is a collection of quality test suite fixes, hand picked with care,
following the expert advice by Karsten.  :-)

Most of them just switch off the tests on MinGW, one uses `pwd -W' to get
the reeal windows path.  All of these are time proven, they have been in
msysgit since Dec 2013, at least.   ;-)

The fix for t8001,2 (annotate, blame) was created in Sep 2013 in the
straightforward form: editing all the regexps in the long test file:
https://github.com/msysgit/git/commit/2d52168a

I have replaced it by a more tricky version that changes each -L option on
the fly, just before it is passed to the executable.
This is new code, but I beleive it is better suited for the common git
sources.

Johannes Schindelin (2):
  MinGW: Skip test redirecting to fd 4
  Disable t0110's high-bit test on Windows

Karsten Blees (2):
  MinGW: disable legacy encoding tests
  t800[12]: work around MSys limitation

Pat Thoyts (2):
  t4210: skip command-line encoding tests on mingw
  t9902: mingw-specific fix for gitfile link files

 t/annotate-tests.sh               | 12 ++++++++++++
 t/t0081-line-buffer.sh            |  2 +-
 t/t0110-urlmatch-normalization.sh |  2 +-
 t/t3901-i18n-patch.sh             | 19 +++++++++++--------
 t/t4201-shortlog.sh               |  6 +++---
 t/t4210-log-i18n.sh               |  4 ++--
 t/t8005-blame-i18n.sh             |  8 ++++----
 t/t9902-completion.sh             | 17 +++++++++++++----
 8 files changed, 47 insertions(+), 23 deletions(-)

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
