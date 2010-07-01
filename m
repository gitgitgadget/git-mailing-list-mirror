From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 8/8] t/README: Document the do's and don'ts of tests
Date: Thu,  1 Jul 2010 20:17:58 +0000
Message-ID: <1278015478-6920-9-git-send-email-avarab@gmail.com>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 22:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQDu-0003YO-LP
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab0GAUSu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:18:50 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42123 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab0GAUSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:18:46 -0400
Received: by mail-ww0-f44.google.com with SMTP id 24so222125wwb.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=f06vm+cxqI8qCK2Uu4fFzfvgoxYhzRMCPwyN4I0aUoA=;
        b=fcBXRZqzFdQ4/9dsplChTeD2I0RXyhmn9lEWYThAEQ8Znyni8NW2b9oXNTYpDr8vHW
         U/Jiu1s7SJsvbFjVkH7vA1T1GHlJdvNLPjzjFrScpvo7KbdAf1KEYxtD0ckZQ/ZQDAfl
         ZhK86/5cSMXhqnE5jTlKdpAI9IdbqfYPl9Mn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sp2mygziDhp83PrL2x0nfwA/tv0NTzC1RDVMJWHFLkNsZr5rn/b2mu9hHJg8ZPCAIN
         Tt63jgqXb8bGnfg5Qz4olu6mz5KjEsaM+mNb5BZss3OLwOvLV6iT+aawfQY6T0u8sAH3
         mWzsQ0sGwsQN8+z6/yH94Ilh3iDGpkoAawCVg=
Received: by 10.213.31.140 with SMTP id y12mr6062134ebc.87.1278015525424;
        Thu, 01 Jul 2010 13:18:45 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v8sm261986eeh.14.2010.07.01.13.18.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:18:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150077>

Add a "Do's, don'ts & things to keep in mind" subsection to the
"Writing Tests" documentation. Much of this is based on Junio C
Hamano's "Test your stuff" section in
<7vhbkj2kcr.fsf@alter.siamese.dyndns.org>.

I turned it into a list of do's and don'ts to make it easier to skim
it, and integrated my note that a TAP harness will get confused if you
print "ok" or "not ok" at the beginning of a line.

Thad had to be fixed in 335f87871fe5aa6b3fd55b2b4e80f16fe9681483 when
TAP support was introduced.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 5a291e1..4a1cfc9 100644
--- a/t/README
+++ b/t/README
@@ -231,6 +231,84 @@ This test harness library does the following thing=
s:
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
--=20
1.7.1.251.g92a7
