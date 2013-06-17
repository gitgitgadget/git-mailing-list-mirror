From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2 0/6] --valgrind improvements
Date: Mon, 17 Jun 2013 11:18:45 +0200
Message-ID: <cover.1371460265.git.trast@inf.ethz.ch>
References: <cover.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 17 11:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoVaW-0004Gv-9v
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 11:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094Ab3FQJS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 05:18:56 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:40405 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694Ab3FQJSz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 05:18:55 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 17 Jun
 2013 11:18:49 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 17 Jun
 2013 11:18:51 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1368736093.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228052>

Here's the promised reroll.  It integrates everyone's suggestions (I
hope I didn't miss any), most notably the two by Peff:

* --valgrind-parallel only does the valgrind wrapper setup in the
  children, avoiding lock contention and confusion because it tries to
  wrap the wrappers.

* more careful --verbose-only toggling (with some extra care about the
  blank lines in between)



Thomas Rast (6):
  test-lib: enable MALLOC_* for the actual tests
  test-lib: refactor $GIT_SKIP_TESTS matching
  test-lib: verbose mode for only tests matching a pattern
  test-lib: valgrind for only tests matching a pattern
  test-lib: allow prefixing a custom string before "ok N" etc.
  test-lib: support running tests under valgrind in parallel

 t/README                |  10 ++
 t/test-lib-functions.sh |   2 +
 t/test-lib.sh           | 248 ++++++++++++++++++++++++++++++++++++++----------
 t/valgrind/valgrind.sh  |   3 +
 4 files changed, 213 insertions(+), 50 deletions(-)

-- 
1.8.3.1.530.g6f90e57
