From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 0/3]
Date: Fri, 17 Feb 2012 11:25:07 +0100
Message-ID: <cover.1329472405.git.trast@student.ethz.ch>
References: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 17 11:25:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyL0E-0003RQ-VC
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 11:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab2BQKZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 05:25:15 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:33856 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab2BQKZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 05:25:14 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 11:25:08 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 17 Feb
 2012 11:25:10 +0100
X-Mailer: git-send-email 1.7.9.1.365.ge223f
In-Reply-To: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190943>

Junio C Hamano wrote:
> > ---
> >  t/test-lib-functions.sh |  835 +++++++++++++++++++++++++++++++++++++++++++++++
> >  t/test-lib.sh           |  552 +-------------------------------
> >  2 files changed, 840 insertions(+), 547 deletions(-)
> >  create mode 100644 t/test-lib-functions.sh
> 
> I would have expected from the log description that the number of deleted
> lines would be about the same as the number of added lines, and the
> difference would primarily come from the addition of "include" aka "dot"
> ". ./test-lib-functions.sh" that becomes necessary in t/test-lib.sh, some
> boilerplate material at the beginning of the new file e.g. "#!/bin/sh",
> and copying (not moving) the same Copyright block to the new file.

There were actually more mistakes lurking :-( so I am resending the
whole series.  I also put in the copyright that you asked for.  I
verified the results by looking at the diff between a reverse git-show
for test-lib.sh and a forward git-show for test-lib-functions.sh,
which looks as follows:

  --- /dev/fd/63	2012-02-17 10:55:32.994197654 +0100
  +++ /dev/fd/62	2012-02-17 10:55:32.994197654 +0100
  @@ -9,17 +9,29 @@
       
       Signed-off-by: Thomas Rast <trast@student.ethz.ch>
   
  -diff --git b/t/test-lib.sh a/t/test-lib.sh
  -index 1da3f40..e28d5fd 100644
  ---- b/t/test-lib.sh
  -+++ a/t/test-lib.sh
  -@@ -223,9 +223,248 @@ die () {
  - GIT_EXIT_OK=
  - trap 'die' EXIT
  - 
  --# The user-facing functions are loaded from a separate file so that
  --# test_perf subshells can have them too
  --. "${TEST_DIRECTORY:-.}"/test-lib-functions.sh
  +diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
  +new file mode 100644
  +index 0000000..7b3b4be
  +--- /dev/null
  ++++ b/t/test-lib-functions.sh
  +@@ -0,0 +1,565 @@
  ++#!/bin/sh
  ++#
  ++# Copyright (c) 2005 Junio C Hamano
  ++#
  ++# This program is free software: you can redistribute it and/or modify
  ++# it under the terms of the GNU General Public License as published by
  ++# the Free Software Foundation, either version 2 of the License, or
  ++# (at your option) any later version.
  ++#
  ++# This program is distributed in the hope that it will be useful,
  ++# but WITHOUT ANY WARRANTY; without even the implied warranty of
  ++# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ++# GNU General Public License for more details.
  ++#
  ++# You should have received a copy of the GNU General Public License
  ++# along with this program.  If not, see http://www.gnu.org/licenses/ .
  ++
   +# The semantics of the editor variables are that of invoking
   +# sh -c "$EDITOR \"$@\"" files ...
   +#
  @@ -192,7 +204,6 @@
   +	git config "$@"
   +}
   +
  -+
   +test_config_global () {
   +	test_when_finished "test_unconfig --global '$1'" &&
   +	git config --global "$@"
  @@ -262,13 +273,7 @@
   +	esac
   +	return 1
   +}
  - 
  - # You are not expected to call test_ok_ and test_failure_ directly, use
  - # the text_expect_* functions instead.
  -@@ -313,6 +552,313 @@ test_skip () {
  - 	esac
  - }
  - 
  ++
   +test_expect_failure () {
   +	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
   +	test "$#" = 2 ||
  @@ -575,7 +580,3 @@
   +		mv .git/hooks .git/hooks-disabled
   +	) || exit
   +}
  -+
  - test_done () {
  - 	GIT_EXIT_OK=t
  - 



Thomas Rast (3):
  Move the user-facing test library to test-lib-functions.sh
  Introduce a performance testing framework
  Add a performance test for git-grep

 Makefile                        |   22 +-
 t/Makefile                      |   43 ++-
 t/perf/.gitignore               |    2 +
 t/perf/Makefile                 |   15 +
 t/perf/README                   |  146 ++++++++++
 t/perf/aggregate.perl           |  166 +++++++++++
 t/perf/min_time.perl            |   21 ++
 t/perf/p0000-perf-lib-sanity.sh |   41 +++
 t/perf/p0001-rev-list.sh        |   17 ++
 t/perf/p7810-grep.sh            |   23 ++
 t/perf/perf-lib.sh              |  198 ++++++++++++++
 t/perf/run                      |   82 ++++++
 t/test-lib-functions.sh         |  565 ++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                   |  574 ++-------------------------------------
 14 files changed, 1363 insertions(+), 552 deletions(-)
 create mode 100644 t/perf/.gitignore
 create mode 100644 t/perf/Makefile
 create mode 100644 t/perf/README
 create mode 100755 t/perf/aggregate.perl
 create mode 100755 t/perf/min_time.perl
 create mode 100755 t/perf/p0000-perf-lib-sanity.sh
 create mode 100755 t/perf/p0001-rev-list.sh
 create mode 100755 t/perf/p7810-grep.sh
 create mode 100644 t/perf/perf-lib.sh
 create mode 100755 t/perf/run
 create mode 100644 t/test-lib-functions.sh

-- 
1.7.9.1.365.ge223f
