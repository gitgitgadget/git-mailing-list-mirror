From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 0/8] Improvements for t/README
Date: Thu,  1 Jul 2010 20:17:50 +0000
Message-ID: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 22:18:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQDK-0003Dc-AJ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab0GAUSU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:18:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56807 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab0GAUST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:18:19 -0400
Received: by wyf23 with SMTP id 23so986337wyf.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=gMazKYH/5HWVfgVeuTmkHcSKEpsdr058AntY0XN1XQ0=;
        b=dy6biLupsbGsv2DLPAbgdZeeQOBLcAzNnb8mDzYivX0egCegh9N+r8wLNfAAl6xCAK
         MlYre94iJyC6115tftCvranULxhCQ87vToanEv+yBc68K9SlfdMCJ22mbUVCqaKzHyEv
         wMIDs55UnK27pMBrzm98nHSFGlYcipLGPzvvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=BMsXrCHUk3xD5A+a6T9KCqbOvLRbh+8OBOeE3fiRDTTOQIZO91Xl5B/m9sQhZLbEHL
         FsXPjXAodlovphwsJnTw0dp+lcz9Lq7IejtORW4Z007e9sI6My/8FH3wJ9dF0rm87hnB
         QqjTOPjGsbeQWzqocyzS6hpR06kenxEQhYzsA=
Received: by 10.213.112.193 with SMTP id x1mr6053729ebp.84.1278015497261;
        Thu, 01 Jul 2010 13:18:17 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v8sm261986eeh.14.2010.07.01.13.18.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:18:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150071>

This is v2 of the t/README series. It should address the concerns
Junio and Jeff had about it.

Jeff:

  - Keep the ./ way of running tests, but elaborate a bit in the
    commit message

  - Mention --root's effects on the trash directory location

Junio:

  - The bit about ok/not ok moved out of the section on running
    tests.

  - Integrate a section that covers all the points in Junio's "Test
    your stuff" section, but does so as an itemized list, so it's
    easier to maintain it.

Other:

  - Made it diff --check friendly.

There's a diff against v1 of the series after this diffstat:

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
  t/README: Tests are all +x, ./test, not sh ./test
  t/README: The trash is in 't/trash directory.$name'
  t/README: Typo: paralell -> parallel
  t/README: Document the prereq functions, and 3-arg test_*
  t/README: Document test_external*
  t/README: Document test_expect_code
  t/README: Add a section about skipping tests
  t/README: Document the do's and don'ts of tests

---

 t/README |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 files changed, 164 insertions(+), 8 deletions(-)

diff --git a/t/README b/t/README
index 29f795e..4a1cfc9 100644
--- a/t/README
+++ b/t/README
@@ -50,12 +50,6 @@ prove and other harnesses come with a lot of useful =
options. The
     # Repeat until no more failures
     $ prove -j 15 --state=3Dfailed,save ./t[0-9]*.sh
=20
-The TAP support is completely incidental. A TAP harness is just a
-program that interprets the "ok"/"not ok" (and some other strings) in
-a special way. The only limitation this imposes is that you shouldn't
-echo "ok" or "not ok" by yourself at the beginning of a line, that'll
-confuse the TAP harness.
-
 You can also run each test individually from command line, like this:
=20
     $ ./t3010-ls-files-killed-modified.sh
@@ -229,14 +223,92 @@ This test harness library does the following thin=
gs:
=20
  - Creates an empty test directory with an empty .git/objects database
    and chdir(2) into it.  This directory is 't/trash
-   directory.$test_name_without_dotsh' if you must know, but I do not
-   think you care.
+   directory.$test_name_without_dotsh', with t/ subject to change by
+   the --root option documented above.
=20
  - Defines standard test helper functions for your scripts to
    use.  These functions are designed to make all scripts behave
    consistently when command line arguments --verbose (or -v),
    --debug (or -d), and --immediate (or -i) is given.
=20
+Do's, don'ts & things to keep in mind
+-------------------------------------
+
+Here's a few examples of things you probably should and shouldn't do
+when writing tests.
+
+Do:
+
+ - Put as much code as possible inside test_expect_success and other
+   assertions.
+
+   Even code that isn't a test per se, but merely some setup code
+   should be inside a test assertion if at all possible. Test scripts
+   should only have trivial code outside of their assertions.
+
+ - Chain your test assertions
+
+   Write test code like this:
+
+	git merge foo &&
+	git push bar &&
+	test ...
+
+   Instead of:
+
+	git merge hla
+	git push gh
+	test ...
+
+   That way all of the commands in your tests will succeed or fail. If
+   you must ignore the return value of something (e.g. the return
+   value of export is unportable) it's best to indicate so explicitly
+   with a semicolon:
+
+	export HLAGH;
+	git merge hla &&
+	git push gh &&
+	test ...
+
+Don't:
+
+ - exit() within a <script> part.
+
+   The harness will catch this as a programming error of the test.
+   Use test_done instead if you need to stop the tests early (see
+   "Skipping tests" below).
+
+ - Break the TAP output
+
+   The raw output from your test might be interpreted by a TAP
+   harness. You usually don't have to worry about that. TAP harnesses
+   will ignore everything they don't know about, but don't step on
+   their toes in these areas:
+
+   - Don't print lines like "$x..$y" where $x and $y are integers.
+
+   - Don't print lines that begin with "ok" or "not ok".
+
+   A TAP harness expect a line that begins with either "ok" and "not
+   ok" to signal a test passed or failed (and our harness already
+   produces such lines), so your script shouldn't emit such lines to
+   their output.
+
+   You can gleam some further possible issues from the TAP grammar
+   (see http://search.cpan.org/perldoc?TAP::Parser::Grammar#TAP_Gramma=
r)
+   but the best indication is to just run the tests with prove(1),
+   it'll complain if anything is amiss.
+
+Keep in mind:
+
+ - That what you print to stderr and stdout is usually ignored
+
+   Inside <script> part, the standard output and standard error
+   streams are discarded, and the test harness only reports "ok" or
+   "not ok" to the end user running the tests. Under --verbose, they
+   are shown to help debugging the tests.
+
+
 Skipping tests
 --------------
=20
