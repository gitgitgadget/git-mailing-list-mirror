From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 5/6] t9902: mingw-specific fix for gitfile link files
Date: Thu, 17 Jul 2014 17:37:04 +0200
Message-ID: <1405611425-10009-6-git-send-email-kasal@ucw.cz>
References: <20140716092959.GA378@ucw.cz>
 <1405611425-10009-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBMW3T6PAKGQE3LBL4ZY@googlegroups.com Thu Jul 17 17:37:24 2014
Return-path: <msysgit+bncBCU63DXMWULRBMW3T6PAKGQE3LBL4ZY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBMW3T6PAKGQE3LBL4ZY@googlegroups.com>)
	id 1X7nkI-00087A-Lo
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:37:22 +0200
Received: by mail-lb0-f184.google.com with SMTP id c11sf329305lbj.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=EqaeQNwxtMXh1gmXEc92Bi2w237NF5ysJ2NQJbWz4QM=;
        b=nFldZMjOXiJdsZ0ld+O4rAns1OW80R7HreHssGc4+gAbI+9bZIi5dUbnGPigTiTE9c
         sEjzvkpUtSpYdBxqxjhWYn5osZE3HHU/DH7R9qB3pTdltRH3NAHytIYn05AB3lsnr61q
         246AfK/qJSarerluh2dS16NLziTvEaavjcn78yyWtFY1X0829q1oaCUfML40euyAo6ra
         QJbjgmgLpG4SLbTEzYM6euhTGDySAbtdk7kFXp7n384PLXetezx6DffQDyQ4IhEk+BWc
         rthuTxqM+iuJexyNU+gVRru0JkZi74KbO6AnZQTqHTX5hK1BTtiPQGNTyU7CyNclqKT1
         rvnA==
X-Received: by 10.152.10.35 with SMTP id f3mr31194lab.6.1405611442509;
        Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.185.70 with SMTP id fa6ls232553lac.53.gmail; Thu, 17 Jul
 2014 08:37:21 -0700 (PDT)
X-Received: by 10.112.142.106 with SMTP id rv10mr3722715lbb.5.1405611441382;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id o6si608125wij.1.2014.07.17.08.37.21
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 1257D1C01A4; Thu, 17 Jul 2014 17:37:21 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253739>

From: Pat Thoyts <patthoyts@users.sourceforge.net>

The path in a .git platform independent link file needs to be absolute
and under mingw we need it to be a windows type path, not a unix style
path so it should start with a drive letter and not a /.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 t/t9902-completion.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1d1c106..f10a752 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -212,9 +212,18 @@ test_expect_success '__gitdir - non-existing $GIT_DIR' '
 	)
 '
 
+function pwd_P_W () {
+	if test_have_prereq MINGW
+	then
+		pwd -W
+	else
+		pwd -P
+	fi
+}
+
 test_expect_success '__gitdir - gitfile in cwd' '
-	echo "$(pwd -P)/otherrepo/.git" >expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
+	echo "$(pwd_P_W)/otherrepo/.git" >expected &&
+	echo "gitdir: $(pwd_P_W)/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir &&
@@ -224,8 +233,8 @@ test_expect_success '__gitdir - gitfile in cwd' '
 '
 
 test_expect_success '__gitdir - gitfile in parent' '
-	echo "$(pwd -P)/otherrepo/.git" >expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
+	echo "$(pwd_P_W)/otherrepo/.git" >expected &&
+	echo "gitdir: $(pwd_P_W)/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir/subsubdir &&
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
