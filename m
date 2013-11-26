From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/9 v2] test: replace shebangs with descriptions in shell
 libraries
Date: Tue, 26 Nov 2013 13:39:51 -0800
Message-ID: <20131126213951.GE4212@google.com>
References: <20131125205119.GQ4212@google.com>
 <20131125210306.GY4212@google.com>
 <CAPig+cQizcuPjastanvyKkuo2=p9BPhBE-PhBC2J2EKwXvLekg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 22:40:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlQMk-0000Qf-BF
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 22:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328Ab3KZVj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 16:39:56 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:36373 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756446Ab3KZVjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 16:39:55 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so2921811yho.38
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 13:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9arRKbEzxN5MDHWhNUipdYrZjTPh7DZ/DWKy0WfakJc=;
        b=iTVAXMO6YpLl73cAbOOnqq408KzZNI5xBLR/RUHfdKLvb626cNzmsfgy8RTx0PxKOV
         doCr0o/2n9P8PrLoSFcdhtEqhr000l5kGY/zCJpsHVpfm5kHNaVd2DHqfF/JzTkYR3dK
         ftOr0BEaqqf9tcVihmHaS1kzFIwrXWEiJDyccoa8KGG30Vm35wCDfQBm4jA7We3jynZZ
         2RIrVi4Ht9IEZDUHz4kxVdctxm2zN1pwcRvMmoZK8N59CtrGRtW3aU1z9cthm4DAR5yM
         J3hD1xBiZu1bT2zLr676uonL7E3qaVv04XetmpBrsP7ZXkBjS8R/BtG1+RfMcs69np00
         94FA==
X-Received: by 10.236.89.51 with SMTP id b39mr2726041yhf.105.1385501994587;
        Tue, 26 Nov 2013 13:39:54 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e39sm85461912yhq.15.2013.11.26.13.39.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 Nov 2013 13:39:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPig+cQizcuPjastanvyKkuo2=p9BPhBE-PhBC2J2EKwXvLekg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238394>

A #! line in these files is misleading, since these scriptlets are
meant to be sourced with '.' (using whatever shell sources them)
instead of run directly using the interpreter named on the #! line.

Removing the #! line shouldn't hurt syntax highlighting since
these files have filenames ending with '.sh'.  For documentation,
add a brief description of how the files are meant to be used in
place of the shebang line.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Eric Sunshine wrote:
> On Mon, Nov 25, 2013 at 4:03 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> +++ b/t/lib-bash.sh
>> @@ -1,7 +1,6 @@
>> -#!/bin/sh
>> -#
>> -# Ensures that tests are run under Bash; primarily intended for run=
ning tests
>> -# of the completion script.
>> +# Shell library sourced instead of ./test-lib.sh by tests that need
>> +# to run under Bash; primary intended for tests of the completion
>
> s/primary/primarily/

Good eyes.  Here's an updated version of the patch with that change.

Thanks,
Jonathan

 t/gitweb-lib.sh           |  3 ++-
 t/lib-bash.sh             |  7 +++----
 t/lib-cvs.sh              |  2 +-
 t/lib-diff-alternative.sh |  3 ++-
 t/lib-gettext.sh          |  3 ++-
 t/lib-git-daemon.sh       | 18 +++++++++++++++++-
 t/lib-httpd.sh            | 29 ++++++++++++++++++++++++++++-
 t/lib-pack.sh             |  2 --
 t/lib-pager.sh            |  2 +-
 t/lib-read-tree.sh        |  2 --
 t/lib-rebase.sh           |  2 +-
 t/lib-terminal.sh         |  2 +-
 t/perf/perf-lib.sh        |  4 +++-
 t/test-lib-functions.sh   |  3 ++-
 t/test-lib.sh             |  2 +-
 15 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 8cf909a..d5dab5a 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -1,4 +1,5 @@
-#!/bin/sh
+# Initialization and helpers for Gitweb tests, which source this
+# shell library instead of test-lib.sh.
 #
 # Copyright (c) 2007 Jakub Narebski
 #
diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index 11397f7..2be955f 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -1,7 +1,6 @@
-#!/bin/sh
-#
-# Ensures that tests are run under Bash; primarily intended for runnin=
g tests
-# of the completion script.
+# Shell library sourced instead of ./test-lib.sh by tests that need
+# to run under Bash; primarily intended for tests of the completion
+# script.
=20
 if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
 	# we are in full-on bash mode
diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 44263ad..5076718 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+# Shell library sourced instead of ./test-lib.sh by cvsimport tests.
=20
 . ./test-lib.sh
=20
diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index 75ffd91..8b4dbf2 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -1,4 +1,5 @@
-#!/bin/sh
+# Helpers shared by the test scripts for diff algorithms (patience,
+# histogram, etc).
=20
 test_diff_frobnitz() {
 	cat >file1 <<\EOF
diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index ae8883a..eec757f 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -1,4 +1,5 @@
-#!/bin/sh
+# Initialization and Icelandic locale for basic git i18n tests,
+# which source this scriptlet instead of ./test-lib.sh.
 #
 # Copyright (c) 2010 =C6var Arnfj=F6r=F0 Bjarmason
 #
diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 87f0ad8..394b06b 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -1,4 +1,20 @@
-#!/bin/sh
+# Shell library to run git-daemon in tests.  Ends the test early if
+# GIT_TEST_GIT_DAEMON is not set.
+#
+# Usage:
+#
+#	. ./test-lib.sh
+#	. "$TEST_DIRECTORY"/lib-git-daemon.sh
+#	start_git_daemon
+#
+#	test_expect_success '...' '
+#		...
+#	'
+#
+#	test_expect_success ...
+#
+#	stop_git_daemon
+#	test_done
=20
 if test -z "$GIT_TEST_GIT_DAEMON"
 then
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index ad8f1ef..c470784 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -1,4 +1,31 @@
-#!/bin/sh
+# Shell library to run an HTTP server for use in tests.
+# Ends the test early if httpd tests should not be run,
+# for example because the user has not enabled them.
+#
+# Usage:
+#
+#	. ./test-lib.sh
+#	. "$TEST_DIRECTORY"/lib-httpd.sh
+#	start_httpd
+#
+#	test_expect_success '...' '
+#		...
+#	'
+#
+#	test_expect_success ...
+#
+#	stop_httpd
+#	test_done
+#
+# Can be configured using the following variables.
+#
+#    GIT_TEST_HTTPD              enable HTTPD tests
+#    LIB_HTTPD_PATH              web server path
+#    LIB_HTTPD_MODULE_PATH       web server modules path
+#    LIB_HTTPD_PORT              listening port
+#    LIB_HTTPD_DAV               enable DAV
+#    LIB_HTTPD_SVN               enable SVN
+#    LIB_HTTPD_SSL               enable SSL
 #
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index b96e125..7509846 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -1,5 +1,3 @@
-#!/bin/sh
-#
 # Support routines for hand-crafting weird or malicious packs.
 #
 # You can make a complete pack like:
diff --git a/t/lib-pager.sh b/t/lib-pager.sh
index ba03eab..3aa7a3f 100644
--- a/t/lib-pager.sh
+++ b/t/lib-pager.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+# Helpers for tests of git's choice of pager.
=20
 test_expect_success 'determine default pager' '
 	test_might_fail git config --unset core.pager &&
diff --git a/t/lib-read-tree.sh b/t/lib-read-tree.sh
index abc2c6f..6442ae3 100644
--- a/t/lib-read-tree.sh
+++ b/t/lib-read-tree.sh
@@ -1,5 +1,3 @@
-#!/bin/sh
-#
 # Helper functions to check if read-tree would succeed/fail as expecte=
d with
 # and without the dry-run option. They also test that the dry-run does=
 not
 # write the index and that together with -u it doesn't touch the work =
tree.
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 8ff87fb..6bd2522 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+# Helper functions used by interactive rebase tests.
=20
 # After setting the fake editor with this function, you can
 #
diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 737df28..9a2dca5 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+# Helpers for terminal output tests.
=20
 test_expect_success PERL 'set up terminal for tests' '
 	# Reading from the pty master seems to get stuck _sometimes_
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index f4eecaa..a8c9574 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -1,4 +1,6 @@
-#!/bin/sh
+# Performance testing framework.  Each perf script starts much like
+# a normal test script, except it sources this library instead of
+# test-lib.sh.  See t/perf/README for documentation.
 #
 # Copyright (c) 2011 Thomas Rast
 #
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f79146..aeae3ca 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1,4 +1,5 @@
-#!/bin/sh
+# Library of functions shared by all tests scripts, included by
+# test-lib.sh.
 #
 # Copyright (c) 2005 Junio C Hamano
 #
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5968157..c306bd0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+# Test framework for git.  See t/README for usage.
 #
 # Copyright (c) 2005 Junio C Hamano
 #
--=20
1.8.4.1
