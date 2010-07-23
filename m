From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] t4150 (am): style tweaks
Date: Fri, 23 Jul 2010 12:03:07 -0500
Message-ID: <20100723170307.GB2507@burratino>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
 <20100722075133.GA9292@burratino>
 <681325.9577.qm@web30002.mail.mud.yahoo.com>
 <20100723170103.GA2507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 19:26:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcM0y-00007C-74
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025Ab0GWR0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 13:26:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64172 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab0GWR0V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:26:21 -0400
Received: by gyg10 with SMTP id 10so213448gyg.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=e+DLTN9h1y9EgGig5q/fsSNE8+ZNqezzNV5Y95LjDAQ=;
        b=tM1vqkqIjdTG9iNRh+MeLAiguIj6z+VtqS38Cs137K3JqC6dh/bJgtVm7ZiYzrPD9l
         qzSOReGuSjbyXnYbwf7maPllcl1u0Njenu7kmpCmqNlxQdNChUKDiSxvoVLeUk49b37s
         CC/trffQMmmovJDVUvXortEuJk8ExEBxoKzME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sNm2889m2ABqxjjNOAlokWkxY0mI3znpas1KD/Ba00Cpwg+IhJI0NYZzBl6UmhAUI9
         DC7bfsG8utZXwkEVLpBq46VWM4dE81V1v/DrrARxqHIdm1qsUftj7vocb20ScDDiUbw/
         azGJnK2aWG1cS71NqQr5I3ToNr3Ek8Ig13ojY=
Received: by 10.90.50.14 with SMTP id x14mr3948920agx.53.1279904647411;
        Fri, 23 Jul 2010 10:04:07 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h20sm455618qcm.45.2010.07.23.10.04.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 10:04:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100723170103.GA2507@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151556>

Place setup commands in test_expect_success blocks.  This makes the
rare event of the setup commands breaking on some platform easier to
diagnose, and more importantly, it visually distinguishes where
each test begins and ends.

Instead of running test -z against the result of "git diff" command
substitution, use "git diff --exit-code", to improve output when
running with the "-v" option.

Use test_cmp in place of "test $(foo) = $(bar)" for similar reasons.

Remove whitespace after the > and < redirection operators for
consistency with other tests.

The order of arguments to test_cmp is "test_cmp expected actual".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4150-am.sh |  240 +++++++++++++++++++++++++++++++--------------------------
 t/test-lib.sh |    4 +
 2 files changed, 136 insertions(+), 108 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 810b04b..b50aad3 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -4,66 +4,71 @@ test_description='git am running'
 
 . ./test-lib.sh
 
-cat >msg <<EOF
-second
-
-Lorem ipsum dolor sit amet, consectetuer sadipscing elitr, sed diam nonumy
-eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam
-voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita
-kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem
-ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
-tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
-vero eos et accusam et justo duo dolores et ea rebum.
-
-	Duis autem vel eum iriure dolor in hendrerit in vulputate velit
-	esse molestie consequat, vel illum dolore eu feugiat nulla facilisis
-	at vero eros et accumsan et iusto odio dignissim qui blandit
-	praesent luptatum zzril delenit augue duis dolore te feugait nulla
-	facilisi.
-
-
-Lorem ipsum dolor sit amet,
-consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut
-laoreet dolore magna aliquam erat volutpat.
-
-  git
-  ---
-  +++
-
-Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit
-lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure
-dolor in hendrerit in vulputate velit esse molestie consequat, vel illum
-dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio
-dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te
-feugait nulla facilisi.
-EOF
-
-cat >failmail <<EOF
-From foo@example.com Fri May 23 10:43:49 2008
-From:	foo@example.com
-To:	bar@example.com
-Subject: Re: [RFC/PATCH] git-foo.sh
-Date:	Fri, 23 May 2008 05:23:42 +0200
-
-Sometimes we have to find out that there's nothing left.
-
-EOF
-
-cat >pine <<EOF
-From MAILER-DAEMON Fri May 23 10:43:49 2008
-Date: 23 May 2008 05:23:42 +0200
-From: Mail System Internal Data <MAILER-DAEMON@example.com>
-Subject: DON'T DELETE THIS MESSAGE -- FOLDER INTERNAL DATA
-Message-ID: <foo-0001@example.com>
-
-This text is part of the internal format of your mail folder, and is not
-a real message.  It is created automatically by the mail system software.
-If deleted, important folder data will be lost, and it will be re-created
-with the data reset to initial values.
-
-EOF
-
-echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected
+test_expect_success 'setup: messages' '
+	cat >msg <<-\EOF &&
+	second
+
+	Lorem ipsum dolor sit amet, consectetuer sadipscing elitr, sed diam nonumy
+	eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam
+	voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita
+	kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem
+	ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
+	tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
+	vero eos et accusam et justo duo dolores et ea rebum.
+
+	EOF
+	q_to_tab <<-\EOF >>msg &&
+	QDuis autem vel eum iriure dolor in hendrerit in vulputate velit
+	Qesse molestie consequat, vel illum dolore eu feugiat nulla facilisis
+	Qat vero eros et accumsan et iusto odio dignissim qui blandit
+	Qpraesent luptatum zzril delenit augue duis dolore te feugait nulla
+	Qfacilisi.
+	EOF
+	cat >>msg <<-\EOF &&
+
+	Lorem ipsum dolor sit amet,
+	consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut
+	laoreet dolore magna aliquam erat volutpat.
+
+	  git
+	  ---
+	  +++
+
+	Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit
+	lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure
+	dolor in hendrerit in vulputate velit esse molestie consequat, vel illum
+	dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio
+	dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te
+	feugait nulla facilisi.
+	EOF
+
+	cat >failmail <<-\EOF &&
+	From foo@example.com Fri May 23 10:43:49 2008
+	From:	foo@example.com
+	To:	bar@example.com
+	Subject: Re: [RFC/PATCH] git-foo.sh
+	Date:	Fri, 23 May 2008 05:23:42 +0200
+
+	Sometimes we have to find out that there'\''s nothing left.
+
+	EOF
+
+	cat >pine <<-\EOF &&
+	From MAILER-DAEMON Fri May 23 10:43:49 2008
+	Date: 23 May 2008 05:23:42 +0200
+	From: Mail System Internal Data <MAILER-DAEMON@example.com>
+	Subject: DON'\''T DELETE THIS MESSAGE -- FOLDER INTERNAL DATA
+	Message-ID: <foo-0001@example.com>
+
+	This text is part of the internal format of your mail folder, and is not
+	a real message.  It is created automatically by the mail system software.
+	If deleted, important folder data will be lost, and it will be re-created
+	with the data reset to initial values.
+
+	EOF
+
+	signoff="Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+'
 
 test_expect_success setup '
 	echo hello >file &&
@@ -71,11 +76,13 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m first &&
 	git tag first &&
+
 	echo world >>file &&
 	git add file &&
 	test_tick &&
 	git commit -s -F msg &&
 	git tag second &&
+
 	git format-patch --stdout first >patch1 &&
 	{
 		echo "X-Fake-Field: Line One" &&
@@ -89,33 +96,37 @@ test_expect_success setup '
 		echo "X-Fake-Field: Line Three" &&
 		git format-patch --stdout first | sed -e "1d"
 	} | append_cr >patch1-crlf.eml &&
+
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
 	test_tick &&
 	git commit -m third &&
+
 	git format-patch --stdout first >patch2	&&
+
 	git checkout -b lorem &&
 	sed -n -e "11,\$p" msg >file &&
 	head -n 9 msg >>file &&
 	test_tick &&
 	git commit -a -m "moved stuff" &&
+
 	echo goodbye >another &&
 	git add another &&
 	test_tick &&
 	git commit -m "added another file" &&
-	git format-patch --stdout master >lorem-move.patch
-'
 
-# reset time
-unset test_tick
-test_tick
+	git format-patch --stdout master >lorem-move.patch &&
+	# reset time
+	unset test_tick &&
+	test_tick
+'
 
 test_expect_success 'am applies patch correctly' '
 	git checkout first &&
 	test_tick &&
 	git am <patch1 &&
 	! test -d .git/rebase-apply &&
-	test -z "$(git diff second)" &&
+	git diff --exit-code second &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
@@ -124,7 +135,7 @@ test_expect_success 'am applies patch e-mail not in a mbox' '
 	git checkout first &&
 	git am patch1.eml &&
 	! test -d .git/rebase-apply &&
-	test -z "$(git diff second)" &&
+	git diff --exit-code second &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
@@ -133,20 +144,23 @@ test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
 	git checkout first &&
 	git am patch1-crlf.eml &&
 	! test -d .git/rebase-apply &&
-	test -z "$(git diff second)" &&
+	git diff --exit-code second &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
-GIT_AUTHOR_NAME="Another Thor"
-GIT_AUTHOR_EMAIL="a.thor@example.com"
-GIT_COMMITTER_NAME="Co M Miter"
-GIT_COMMITTER_EMAIL="c.miter@example.com"
-export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
+test_expect_success 'setup: new author and committer' '
+	GIT_AUTHOR_NAME="Another Thor" &&
+	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
+	GIT_COMMITTER_NAME="Co M Miter" &&
+	GIT_COMMITTER_EMAIL="c.miter@example.com" &&
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
+'
 
 compare () {
-	test "$(git cat-file commit "$2" | grep "^$1 ")" = \
-	     "$(git cat-file commit "$3" | grep "^$1 ")"
+	a=$(git cat-file commit "$2" | grep "^$1 ") &&
+	b=$(git cat-file commit "$3" | grep "^$1 ") &&
+	test "$a" = "$b"
 }
 
 test_expect_success 'am changes committer and keeps author' '
@@ -155,8 +169,8 @@ test_expect_success 'am changes committer and keeps author' '
 	git am patch2 &&
 	! test -d .git/rebase-apply &&
 	test "$(git rev-parse master^^)" = "$(git rev-parse HEAD^^)" &&
-	test -z "$(git diff master..HEAD)" &&
-	test -z "$(git diff master^..HEAD^)" &&
+	git diff --exit-code master..HEAD &&
+	git diff --exit-code master^..HEAD^ &&
 	compare author master HEAD &&
 	compare author master^ HEAD^ &&
 	test "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" = \
@@ -166,16 +180,19 @@ test_expect_success 'am changes committer and keeps author' '
 test_expect_success 'am --signoff adds Signed-off-by: line' '
 	git checkout -b master2 first &&
 	git am --signoff <patch2 &&
+	printf "%s\n" "$signoff" >expected &&
 	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >>expected &&
 	git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
-	test_cmp actual expected &&
+	test_cmp expected actual &&
 	echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected &&
 	git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
-	test_cmp actual expected
+	test_cmp expected actual
 '
 
 test_expect_success 'am stays in branch' '
-	test "refs/heads/master2" = "$(git symbolic-ref HEAD)"
+	echo refs/heads/master2 >expected &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expected actual
 '
 
 test_expect_success 'am --signoff does not add Signed-off-by: line if already there' '
@@ -183,19 +200,22 @@ test_expect_success 'am --signoff does not add Signed-off-by: line if already th
 	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2," patch3 >patch4
 	git checkout HEAD^ &&
 	git am --signoff patch4 &&
-	test "$(git cat-file commit HEAD | grep -c "^Signed-off-by:")" -eq 1
+	git cat-file commit HEAD >actual &&
+	test $(grep -c "^Signed-off-by:" actual) -eq 1
 '
 
 test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
-	test "$(git rev-parse HEAD)" = "$(git rev-parse master2)"
+	git rev-parse HEAD >expected &&
+	git rev-parse master2 >actual &&
+	test_cmp expected actual
 '
 
 test_expect_success 'am --keep really keeps the subject' '
 	git checkout HEAD^ &&
 	git am --keep patch4 &&
 	! test -d .git/rebase-apply &&
-	git cat-file commit HEAD |
-		fgrep "Re: Re: Re: [PATCH 1/5 v2] third"
+	git cat-file commit HEAD >actual &&
+	grep "Re: Re: Re: \[PATCH 1/5 v2\] third" actual
 '
 
 test_expect_success 'am -3 falls back to 3-way merge' '
@@ -207,7 +227,7 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 	git commit -m "copied stuff" &&
 	git am -3 lorem-move.patch &&
 	! test -d .git/rebase-apply &&
-	test -z "$(git diff lorem)"
+	git diff --exit-code lorem
 '
 
 test_expect_success 'am -3 -q is quiet' '
@@ -217,7 +237,7 @@ test_expect_success 'am -3 -q is quiet' '
 	git add file &&
 	test_tick &&
 	git commit -m "copied stuff" &&
-	git am -3 -q lorem-move.patch > output.out 2>&1 &&
+	git am -3 -q lorem-move.patch >output.out 2>&1 &&
 	! test -s output.out
 '
 
@@ -228,13 +248,15 @@ test_expect_success 'am pauses on conflict' '
 '
 
 test_expect_success 'am --skip works' '
+	echo goodbye >expected &&
 	git am --skip &&
 	! test -d .git/rebase-apply &&
-	test -z "$(git diff lorem2^^ -- file)" &&
-	test goodbye = "$(cat another)"
+	git diff --exit-code lorem2^^ -- file &&
+	test_cmp expected another
 '
 
 test_expect_success 'am --resolved works' '
+	echo goodbye >expected &&
 	git checkout lorem2^^ &&
 	test_must_fail git am lorem-move.patch &&
 	test -d .git/rebase-apply &&
@@ -242,14 +264,14 @@ test_expect_success 'am --resolved works' '
 	git add file &&
 	git am --resolved &&
 	! test -d .git/rebase-apply &&
-	test goodbye = "$(cat another)"
+	test_cmp expected another
 '
 
 test_expect_success 'am takes patches from a Pine mailbox' '
 	git checkout first &&
 	cat pine patch1 | git am &&
 	! test -d .git/rebase-apply &&
-	test -z "$(git diff master^..HEAD)"
+	git diff --exit-code master^..HEAD
 '
 
 test_expect_success 'am fails on mail without patch' '
@@ -272,7 +294,7 @@ test_expect_success 'am works from stdin in subdirectory' '
 		cd subdir &&
 		git am <../patch1
 	) &&
-	test -z "$(git diff second)"
+	git diff --exit-code second
 '
 
 test_expect_success 'am works from file (relative path given) in subdirectory' '
@@ -283,7 +305,7 @@ test_expect_success 'am works from file (relative path given) in subdirectory' '
 		cd subdir &&
 		git am ../patch1
 	) &&
-	test -z "$(git diff second)"
+	git diff --exit-code second
 '
 
 test_expect_success 'am works from file (absolute path given) in subdirectory' '
@@ -295,7 +317,7 @@ test_expect_success 'am works from file (absolute path given) in subdirectory' '
 		cd subdir &&
 		git am "$P/patch1"
 	) &&
-	test -z "$(git diff second)"
+	git diff --exit-code second
 '
 
 test_expect_success 'am --committer-date-is-author-date' '
@@ -303,9 +325,9 @@ test_expect_success 'am --committer-date-is-author-date' '
 	test_tick &&
 	git am --committer-date-is-author-date patch1 &&
 	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
-	at=$(sed -ne "/^author /s/.*> //p" head1) &&
-	ct=$(sed -ne "/^committer /s/.*> //p" head1) &&
-	test "$at" = "$ct"
+	sed -ne "/^author /s/.*> //p" head1 >at &&
+	sed -ne "/^committer /s/.*> //p" head1 >ct &&
+	test_cmp at ct
 '
 
 test_expect_success 'am without --committer-date-is-author-date' '
@@ -313,9 +335,9 @@ test_expect_success 'am without --committer-date-is-author-date' '
 	test_tick &&
 	git am patch1 &&
 	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
-	at=$(sed -ne "/^author /s/.*> //p" head1) &&
-	ct=$(sed -ne "/^committer /s/.*> //p" head1) &&
-	test "$at" != "$ct"
+	sed -ne "/^author /s/.*> //p" head1 >at &&
+	sed -ne "/^committer /s/.*> //p" head1 >ct &&
+	! test_cmp at ct
 '
 
 # This checks for +0000 because TZ is set to UTC and that should
@@ -327,37 +349,39 @@ test_expect_success 'am --ignore-date' '
 	test_tick &&
 	git am --ignore-date patch1 &&
 	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
-	at=$(sed -ne "/^author /s/.*> //p" head1) &&
-	echo "$at" | grep "+0000"
+	sed -ne "/^author /s/.*> //p" head1 >at &&
+	grep "+0000" at
 '
 
 test_expect_success 'am into an unborn branch' '
+	git rev-parse first^{tree} >expected &&
 	rm -fr subdir &&
-	mkdir -p subdir &&
+	mkdir subdir &&
 	git format-patch --numbered-files -o subdir -1 first &&
 	(
 		cd subdir &&
 		git init &&
 		git am 1
 	) &&
-	result=$(
-		cd subdir && git rev-parse HEAD^{tree}
+	(
+		cd subdir &&
+		git rev-parse HEAD^{tree} >../actual
 	) &&
-	test "z$result" = "z$(git rev-parse first^{tree})"
+	test_cmp expected actual
 '
 
 test_expect_success 'am newline in subject' '
 	git checkout first &&
 	test_tick &&
-	sed -e "s/second/second \\\n foo/" patch1 > patchnl &&
-	git am < patchnl > output.out 2>&1 &&
+	sed -e "s/second/second \\\n foo/" patch1 >patchnl &&
+	git am <patchnl >output.out 2>&1 &&
 	grep "^Applying: second \\\n foo$" output.out
 '
 
 test_expect_success 'am -q is quiet' '
 	git checkout first &&
 	test_tick &&
-	git am -q < patch1 > output.out 2>&1 &&
+	git am -q <patch1 >output.out 2>&1 &&
 	! test -s output.out
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index e5523dd..cb15798 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -257,6 +257,10 @@ q_to_cr () {
 	tr Q '\015'
 }
 
+q_to_tab () {
+	tr Q '\011'
+}
+
 append_cr () {
 	sed -e 's/$/Q/' | tr Q '\015'
 }
-- 
1.7.2.rc3
