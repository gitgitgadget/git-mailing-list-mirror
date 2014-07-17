From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 3/6] MinGW: disable legacy encoding tests
Date: Thu, 17 Jul 2014 17:37:02 +0200
Message-ID: <1405611425-10009-4-git-send-email-kasal@ucw.cz>
References: <20140716092959.GA378@ucw.cz>
 <1405611425-10009-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBMO3T6PAKGQEWZFM3IQ@googlegroups.com Thu Jul 17 17:37:24 2014
Return-path: <msysgit+bncBCU63DXMWULRBMO3T6PAKGQEWZFM3IQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f191.google.com ([209.85.217.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBMO3T6PAKGQEWZFM3IQ@googlegroups.com>)
	id 1X7nkI-000879-HN
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:37:22 +0200
Received: by mail-lb0-f191.google.com with SMTP id z11sf314606lbi.18
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=I/YYsWcGa35U8rs/8PNdnZlTiEAXA70DI6klnZvDD2c=;
        b=bc+/OT4mn8wURkUKWSl23epFNHdlP02/hfpxc6RmRZpz56Fbud/PkavEXvlL0S03yF
         IuXrZPL4IHIwv2Jewcz0nIrghFRBrKVny8Z3jxWxQT3QJRnk6VwQCLuK6wT1roV3YpDO
         fe6fyPF1m8MG11fw2kEM3YV0nsLho5JJqWjweyCDB0veLnLWVRb6rctZrqYKqd1njnxS
         QKRFPWh2KQqcRVlZb2ZzjFMTvy5DAm5BlnxV7sm5P8ZvufReE2O2sSh/0xzvAL/oFlzc
         bXT6P6fSznkxLSfBO72AQnv7p0xNUBhCzk3vpSWbD7kXV0smiQWEcZ+b4ezTRkFnVp6m
         lBDQ==
X-Received: by 10.152.204.97 with SMTP id kx1mr5659lac.41.1405611442362;
        Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.4.2 with SMTP id ca2ls197370lad.94.gmail; Thu, 17 Jul 2014
 08:37:21 -0700 (PDT)
X-Received: by 10.112.126.196 with SMTP id na4mr515113lbb.17.1405611441297;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id b9si373426wic.2.2014.07.17.08.37.21
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 066521C0198; Thu, 17 Jul 2014 17:37:21 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253738>

From: Karsten Blees <blees@dcon.de>

On Windows, all native APIs are Unicode-based. It is impossible to pass
legacy encoded byte arrays to a process via command line or environment
variables. Disable the tests that try to do so.

In t3901, most tests still work if we don't mess up the repository encoding
in setup, so don't switch to ISO-8859-1 on MinGW.

Note that i18n tests that do their encoding tricks via encoded files (such
as t3900) are not affected by this.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 t/t3901-i18n-patch.sh | 19 +++++++++++--------
 t/t4201-shortlog.sh   |  6 +++---
 t/t8005-blame-i18n.sh |  8 ++++----
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 31a5770..55c8a2f 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -54,10 +54,13 @@ test_expect_success setup '
 	git add yours &&
 	git commit -s -m "Second on side" &&
 
-	# the second one on the side branch is ISO-8859-1
-	git config i18n.commitencoding ISO8859-1 &&
-	# use author and committer name in ISO-8859-1 to match it.
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	if test_have_prereq NOT_MINGW
+	then
+		# the second one on the side branch is ISO-8859-1
+		git config i18n.commitencoding ISO8859-1 &&
+		# use author and committer name in ISO-8859-1 to match it.
+		. "$TEST_DIRECTORY"/t3901-8859-1.txt
+	fi &&
 	test_tick &&
 	echo Yet another >theirs &&
 	git add theirs &&
@@ -119,7 +122,7 @@ test_expect_success 'rebase (U/L)' '
 	check_encoding 2
 '
 
-test_expect_success 'rebase (L/L)' '
+test_expect_success NOT_MINGW 'rebase (L/L)' '
 	# In this test we want ISO-8859-1 encoded commits as the result
 	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding ISO8859-1 &&
@@ -131,7 +134,7 @@ test_expect_success 'rebase (L/L)' '
 	check_encoding 2 8859
 '
 
-test_expect_success 'rebase (L/U)' '
+test_expect_success NOT_MINGW 'rebase (L/U)' '
 	# This is pathological -- use UTF-8 as intermediate form
 	# to get ISO-8859-1 results.
 	git config i18n.commitencoding ISO8859-1 &&
@@ -159,7 +162,7 @@ test_expect_success 'cherry-pick(U/U)' '
 	check_encoding 3
 '
 
-test_expect_success 'cherry-pick(L/L)' '
+test_expect_success NOT_MINGW 'cherry-pick(L/L)' '
 	# Both the commitencoding and logoutputencoding is set to ISO-8859-1
 
 	git config i18n.commitencoding ISO8859-1 &&
@@ -189,7 +192,7 @@ test_expect_success 'cherry-pick(U/L)' '
 	check_encoding 3
 '
 
-test_expect_success 'cherry-pick(L/U)' '
+test_expect_success NOT_MINGW 'cherry-pick(L/U)' '
 	# Again, the commitencoding is set to ISO-8859-1 but
 	# logoutputencoding is set to UTF-8.
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 97fcb31..565c020 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -93,7 +93,7 @@ test_expect_success 'output from user-defined format is re-wrapped' '
 	test_cmp expect log.predictable
 '
 
-test_expect_success 'shortlog wrapping' '
+test_expect_success NOT_MINGW 'shortlog wrapping' '
 	cat >expect <<\EOF &&
 A U Thor (5):
       Test
@@ -114,7 +114,7 @@ EOF
 	test_cmp expect out
 '
 
-test_expect_success 'shortlog from non-git directory' '
+test_expect_success NOT_MINGW 'shortlog from non-git directory' '
 	git log HEAD >log &&
 	GIT_DIR=non-existing git shortlog -w <log >out &&
 	test_cmp expect out
@@ -159,7 +159,7 @@ $DSCHO (2):
 
 EOF
 
-test_expect_success 'shortlog encoding' '
+test_expect_success NOT_MINGW 'shortlog encoding' '
 	git reset --hard "$commit" &&
 	git config --unset i18n.commitencoding &&
 	echo 2 > a1 &&
diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index cb39055..a6e73d0 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -33,7 +33,7 @@ author $SJIS_NAME
 summary $SJIS_MSG
 EOF
 
-test_expect_success \
+test_expect_success NOT_MINGW \
 	'blame respects i18n.commitencoding' '
 	git blame --incremental file | \
 		egrep "^(author|summary) " > actual &&
@@ -49,7 +49,7 @@ author $EUC_JAPAN_NAME
 summary $EUC_JAPAN_MSG
 EOF
 
-test_expect_success \
+test_expect_success NOT_MINGW \
 	'blame respects i18n.logoutputencoding' '
 	git config i18n.logoutputencoding eucJP &&
 	git blame --incremental file | \
@@ -66,7 +66,7 @@ author $UTF8_NAME
 summary $UTF8_MSG
 EOF
 
-test_expect_success \
+test_expect_success NOT_MINGW \
 	'blame respects --encoding=UTF-8' '
 	git blame --incremental --encoding=UTF-8 file | \
 		egrep "^(author|summary) " > actual &&
@@ -82,7 +82,7 @@ author $UTF8_NAME
 summary $UTF8_MSG
 EOF
 
-test_expect_success \
+test_expect_success NOT_MINGW \
 	'blame respects --encoding=none' '
 	git blame --incremental --encoding=none file | \
 		egrep "^(author|summary) " > actual &&
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
