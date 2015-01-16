From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Fri, 16 Jan 2015 11:02:37 -0800
Message-ID: <xmqqzj9i1rci.fsf@gitster.dls.corp.google.com>
References: <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>
	<20150115235752.GB25120@peff.net>
	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
	<20150116013256.GA25894@peff.net>
	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>
	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,  msysgit@googlegroups.com,  Torsten
 =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Git Mailing List
 <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCG77UMM3EJRBUOA4WSQKGQEF74ABPA@googlegroups.com Fri Jan 16 20:02:44 2015
Return-path: <msysgit+bncBCG77UMM3EJRBUOA4WSQKGQEF74ABPA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f188.google.com ([209.85.192.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBUOA4WSQKGQEF74ABPA@googlegroups.com>)
	id 1YCCAN-0000VG-IR
	for gcvm-msysgit@m.gmane.org; Fri, 16 Jan 2015 20:02:43 +0100
Received: by mail-pd0-f188.google.com with SMTP id fp1sf390858pdb.5
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 Jan 2015 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=Ci6gWbQd1q2jRQujK9u86YJ+YLC9cMCDXc2/IptLOBg=;
        b=AGcffvyCgmaQ1+l270Oy2aeijjorbq/HJCBkpofeLIdRkamdESEvMIMzxz6h6l0HeI
         LuVsMnBbL+zt7r3jjXGlRgo3pn6QONagpAf9ur62AGluOPK3DMNPnEqsfzKVjixt2lz4
         iPDHMPmZYBR/lUCIkP2yjos6UWZ56sPkPOfg2df4flXIlQzr7qKha4+Y/Or7jZJjiElZ
         1GrqU4hzMmCYLiNLgC1WHPXlkLrA30DUkaThhrbymdppUnVvcelIZPYNtAXs9wb+hIYZ
         vFGMduFZTBPESfwxi+Kkzjo+PH3V2L191g/P0IHp/KOPm53eRlkxg/RhSuYkM/NUTNYF
         xTvg==
X-Received: by 10.140.23.208 with SMTP id 74mr28351qgp.23.1421434962165;
        Fri, 16 Jan 2015 11:02:42 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.34.107 with SMTP id k98ls1560038qgk.58.gmail; Fri, 16 Jan
 2015 11:02:40 -0800 (PST)
X-Received: by 10.52.246.135 with SMTP id xw7mr12908242vdc.8.1421434960326;
        Fri, 16 Jan 2015 11:02:40 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id e4si640214qcq.3.2015.01.16.11.02.40
        for <msysgit@googlegroups.com>;
        Fri, 16 Jan 2015 11:02:40 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1B4330FB9;
	Fri, 16 Jan 2015 14:02:39 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6A1A30FB8;
	Fri, 16 Jan 2015 14:02:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CE9130FB6;
	Fri, 16 Jan 2015 14:02:39 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3DAFAB04-9DB2-11E4-A833-42529F42C9D4-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262560>

Junio C Hamano <gitster@pobox.com> writes:

> I think we will later make SANITY to require NOT_ROOT and POSIXPERM,
> at which point many existing tests that require POSIXPERM,SANITY can
> be simplified to require only SANITY, but that will be a follow-up
> change to this fix.

And here is such a follow-up.

-- >8 --
Subject: [PATCH] tests: SANITY requires POSIXPERM

SANITY requires that a file or a directory is indeed accessible (or
inaccessible) when its permission bits would say it ought to be
accessible (or inaccessible).  Running tests as root would lose this
prerequisite for obvious reasons, and a test that requires SANITY
implies it needs POSIXPERM working.

Redefine SANITY in terms of POSIXPERM and NOT_ROOT and simplify
tests that require both to only require SANITY.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0001-init.sh          |  2 +-
 t/t0004-unwritable.sh    |  8 ++++----
 t/t0061-run-command.sh   |  2 +-
 t/t0070-fundamental.sh   |  2 +-
 t/t3700-add.sh           | 10 +++++-----
 t/t4056-diff-order.sh    |  2 +-
 t/t5537-fetch-shallow.sh |  2 +-
 t/t7508-status.sh        |  2 +-
 t/test-lib.sh            |  4 +++-
 9 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e62c0ff..4aa8660 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -261,7 +261,7 @@ test_expect_success 'init notices EEXIST (2)' '
 	test_path_is_file newdir/a
 '
 
-test_expect_success POSIXPERM,SANITY 'init notices EPERM' '
+test_expect_success SANITY 'init notices EPERM' '
 	rm -fr newdir &&
 	mkdir newdir &&
 	chmod -w newdir &&
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index e3137d6..d5729d4 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -15,26 +15,26 @@ test_expect_success setup '
 
 '
 
-test_expect_success POSIXPERM,SANITY 'write-tree should notice unwritable repository' '
+test_expect_success SANITY 'write-tree should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	chmod a-w .git/objects .git/objects/?? &&
 	test_must_fail git write-tree
 '
 
-test_expect_success POSIXPERM,SANITY 'commit should notice unwritable repository' '
+test_expect_success SANITY 'commit should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	chmod a-w .git/objects .git/objects/?? &&
 	test_must_fail git commit -m second
 '
 
-test_expect_success POSIXPERM,SANITY 'update-index should notice unwritable repository' '
+test_expect_success SANITY 'update-index should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	echo 6O >file &&
 	chmod a-w .git/objects .git/objects/?? &&
 	test_must_fail git update-index file
 '
 
-test_expect_success POSIXPERM,SANITY 'add should notice unwritable repository' '
+test_expect_success SANITY 'add should notice unwritable repository' '
 	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
 	echo b >file &&
 	chmod a-w .git/objects .git/objects/?? &&
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 9acf628..52722ee 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -34,7 +34,7 @@ test_expect_success POSIXPERM 'run_command reports EACCES' '
 	grep "fatal: cannot exec.*hello.sh" err
 '
 
-test_expect_success POSIXPERM,SANITY 'unreadable directory in PATH' '
+test_expect_success SANITY 'unreadable directory in PATH' '
 	mkdir local-command &&
 	test_when_finished "chmod u+rwx local-command && rm -fr local-command" &&
 	git config alias.nitfol "!echo frotz" &&
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 5ed69a6..ccd88e2 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -17,7 +17,7 @@ test_expect_success 'mktemp to nonexistent directory prints filename' '
 	grep "doesnotexist/test" err
 '
 
-test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints filename' '
+test_expect_success SANITY 'mktemp to unwritable directory prints filename' '
 	mkdir cannotwrite &&
 	chmod -w cannotwrite &&
 	test_when_finished "chmod +w cannotwrite" &&
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index fe274e2..2bc2bcc 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -191,7 +191,7 @@ test_expect_success 'git add --refresh with pathspec' '
 	grep baz actual
 '
 
-test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unreadable file' '
+test_expect_success SANITY 'git add should fail atomically upon an unreadable file' '
 	git reset --hard &&
 	date >foo1 &&
 	date >foo2 &&
@@ -202,7 +202,7 @@ test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unr
 
 rm -f foo2
 
-test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
+test_expect_success SANITY 'git add --ignore-errors' '
 	git reset --hard &&
 	date >foo1 &&
 	date >foo2 &&
@@ -213,7 +213,7 @@ test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
 
 rm -f foo2
 
-test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors)' '
+test_expect_success SANITY 'git add (add.ignore-errors)' '
 	git config add.ignore-errors 1 &&
 	git reset --hard &&
 	date >foo1 &&
@@ -224,7 +224,7 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors)' '
 '
 rm -f foo2
 
-test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors = false)' '
+test_expect_success SANITY 'git add (add.ignore-errors = false)' '
 	git config add.ignore-errors 0 &&
 	git reset --hard &&
 	date >foo1 &&
@@ -235,7 +235,7 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors = false)' '
 '
 rm -f foo2
 
-test_expect_success POSIXPERM,SANITY '--no-ignore-errors overrides config' '
+test_expect_success SANITY '--no-ignore-errors overrides config' '
        git config add.ignore-errors 1 &&
        git reset --hard &&
        date >foo1 &&
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index c0460bb..b7abfb2 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -62,7 +62,7 @@ test_expect_success 'missing orderfile' '
 	test_must_fail git diff -Obogus_file --name-only HEAD^..HEAD
 '
 
-test_expect_success POSIXPERM,SANITY 'unreadable orderfile' '
+test_expect_success SANITY 'unreadable orderfile' '
 	>unreadable_file &&
 	chmod -r unreadable_file &&
 	test_must_fail git diff -Ounreadable_file --name-only HEAD^..HEAD
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index a980574..56bead1 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -173,7 +173,7 @@ EOF
 	)
 '
 
-test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only repo' '
+test_expect_success SANITY 'shallow fetch from a read-only repo' '
 	cp -R .git read-only.git &&
 	find read-only.git -print | xargs chmod -w &&
 	test_when_finished "find read-only.git -type d -print | xargs chmod +w" &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 8ed5788..6037415 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1035,7 +1035,7 @@ EOF
 	test_i18ncmp expect output
 '
 
-test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only repository' '
+test_expect_success SANITY 'status succeeds in a read-only repository' '
 	(
 		chmod a-w .git &&
 		# make dir1/tracked stat-dirty
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b2b2ec7..37d1b0e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -999,7 +999,9 @@ test_lazy_prereq NOT_ROOT '
 
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
-test -w / || test_set_prereq SANITY
+test_lazy_prereq SANITY '
+	test_have_prereq POSIXPERM,NOT_ROOT
+'
 
 GIT_UNZIP=${GIT_UNZIP:-unzip}
 test_lazy_prereq UNZIP '
-- 
2.3.0-rc0-149-g0286818

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
