From: Uwe Storbeck <uwe@ibr.ch>
Subject: [PATCH v2] test-lib.sh: use printf instead of echo
Date: Mon, 17 Mar 2014 19:39:17 +0100
Message-ID: <20140317183917.GA28675@ibr.ch>
References: <20140314235735.GA6959@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 19:39:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPcRY-0007YO-V8
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 19:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbaCQSjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 14:39:20 -0400
Received: from gate.ibr.ch ([83.150.36.130]:56116 "EHLO gate.ibr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214AbaCQSjT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 14:39:19 -0400
Received: from bacardi.ibr.ch (bacardi.ibr.ch [172.16.1.1])
	by gate.ibr.ch (Postfix) with ESMTP id E267517F5F
	for <git@vger.kernel.org>; Mon, 17 Mar 2014 19:39:17 +0100 (CET)
Received: from grappa.ibr.ch (grappa [172.16.8.20])
	by bacardi.ibr.ch (Postfix) with ESMTP id 2BA1D153F5
	for <git@vger.kernel.org>; Mon, 17 Mar 2014 19:39:17 +0100 (CET)
Received: by grappa.ibr.ch (Postfix, from userid 1111)
	id B513ED0C98; Mon, 17 Mar 2014 19:39:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140314235735.GA6959@ibr.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244263>

when variables may contain backslash sequences.

Backslash sequences are interpreted as control characters
by the echo command of some shells (e.g. dash).

Signed-off-by: Uwe Storbeck <uwe@ibr.ch>
---

Changed $@ to $* in printf.
Thanks to Johannes Sixt to point that out.

 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1531c24..3c7cb1d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -277,7 +277,7 @@ error "Test script did not set test_description."
 
 if test "$help" = "t"
 then
-	echo "$test_description"
+	printf '%s\n' "$test_description"
 	exit 0
 fi
 
@@ -328,7 +328,7 @@ test_failure_ () {
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
-	echo "$@" | sed -e 's/^/#	/'
+	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
 }
 
-- 
1.9.0
