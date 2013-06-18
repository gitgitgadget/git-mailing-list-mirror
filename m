From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v3 0/8] --valgrind improvements
Date: Tue, 18 Jun 2013 14:25:56 +0200
Message-ID: <cover.1371557431.git.trast@inf.ethz.ch>
References: <cover.1371460265.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:26:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouzJ-0007Mo-7v
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700Ab3FRM0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:26:13 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:19091 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208Ab3FRM0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:26:12 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:08 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.157) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:09 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371460265.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228212>

Changes from v2:

- $pat renamed to $pattern_ to avoid collisions (thanks j6t)

- New patch 3 that tests --verbose operation, and additions to patch
  (now) 4 that test --verbose-only.  (Adding similar tests for
  --valgrind[-only] and associated options would be nice, but is much
  harder because the user may not have valgrind.)

- Rearranged the hooking in (now) 4, 6 and 8 to make it more obvious
  what is going on, as per Peff's comments

- Fixed a misspelled variable that prevented the "valgrind setup only
  once" logic from working

Thomas Rast (8):
  test-lib: enable MALLOC_* for the actual tests
  test-lib: refactor $GIT_SKIP_TESTS matching
  test-lib: rearrange start/end of test_expect_* and test_skip
  test-lib: self-test that --verbose works
  test-lib: verbose mode for only tests matching a pattern
  test-lib: valgrind for only tests matching a pattern
  test-lib: allow prefixing a custom string before "ok N" etc.
  test-lib: support running tests under valgrind in parallel

 t/README                |  10 ++
 t/t0000-basic.sh        |  54 ++++++++++-
 t/test-lib-functions.sh |   6 +-
 t/test-lib.sh           | 244 ++++++++++++++++++++++++++++++++++++++----------
 t/valgrind/valgrind.sh  |   3 +
 5 files changed, 265 insertions(+), 52 deletions(-)

-- 
1.8.3.1.530.g6f90e57
