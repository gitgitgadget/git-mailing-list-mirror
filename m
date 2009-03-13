From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] test-lib: write test results to
 test-results/<basename>-<pid>
Date: Fri, 13 Mar 2009 17:26:36 +0100 (CET)
Message-ID: <3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <alturin@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 13 17:28:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiAF7-000345-78
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 17:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653AbZCMQ0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755818AbZCMQ0o
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 12:26:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:32798 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754879AbZCMQ0n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 12:26:43 -0400
Received: (qmail invoked by alias); 13 Mar 2009 16:26:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp020) with SMTP; 13 Mar 2009 17:26:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yuOkbHzLyyBBGnUjnIta8eCMvxokYIUgqpoDBTV
	UfGGsjedpExxHS
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1236961524u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113206>

The earlier code meant to attempt to strip everything except the test
number, but only stripped the part starting with the last dash.

However, there is no reason why we should not use the whole basename.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Even if this is not strictly necessary after Hannes' test cleanup, 
	it would still be nice.

	The alternative fix would be to use two percent signs instead of 
	just one.

 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 75b5a89..ccb5d0a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -477,7 +477,7 @@ test_done () {
 	trap - EXIT
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
-	test_results_path="$test_results_dir/${0%-*}-$$"
+	test_results_path="$test_results_dir/${0%.sh}-$$"
 
 	echo "total $test_count" >> $test_results_path
 	echo "success $test_success" >> $test_results_path
-- 
1.6.2.240.g23c7
