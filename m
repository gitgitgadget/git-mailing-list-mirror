From: =?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
Subject: [PATCH] Added a test for fetching remote tags when there is not tags.
Date: Tue, 09 Oct 2007 11:51:07 +0300
Message-ID: <1191919868-4963-1-git-send-email-v@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 11:31:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfBQV-0000TK-GJ
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 11:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbXJIJa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 05:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbXJIJa1
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 05:30:27 -0400
Received: from astana.suomi.net ([82.128.152.18]:54367 "EHLO astana.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbXJIJaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 05:30:23 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2007 05:30:21 EDT
Received: from tiku.suomi.net ([82.128.154.67])
 by astana.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JPM005KRZ9BNU40@astana.suomi.net> for
 git@vger.kernel.org; Tue, 09 Oct 2007 11:51:11 +0300 (EEST)
Received: from spam2.suomi.net (spam2.suomi.net [212.50.131.166])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JPM0093MZBEREC0@mailstore.suomi.net> for git@vger.kernel.org;
 Tue, 09 Oct 2007 11:52:26 +0300 (EEST)
Received: from localhost.localdomain
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam2.suomi.net (Postfix) with ESMTP id 48FFD1A666B; Tue,
 09 Oct 2007 11:51:37 +0300 (EEST)
X-Mailer: git-send-email 1.5.3.4.1156.g5407-dirty
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,	score=-0.762,
 required 5, autolearn=not spam, AWL 0.10,	BAYES_00 -1.00,
 FORGED_RCVD_HELO 0.14)
X-OPOY-MailScanner-From: v@pp.inet.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60375>

When a user runs "git fetch -t", git crashes when it doesn't find any
tags on the remote repository.

Signed-off-by: V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 <v@pp.inet.fi>
---
 t/t5510-fetch.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 73a4e3c..40ebf2e 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -67,6 +67,18 @@ test_expect_success "fetch test for-merge" '
 	cut -f -2 .git/FETCH_HEAD >actual &&
 	diff expected actual'
=20
+test_expect_success 'fetch tags when there is no tags' '
+
+    cd "$D" &&
+
+    mkdir notags &&
+    cd notags &&
+    git init &&
+
+    git fetch -t ..
+
+'
+
 test_expect_success 'fetch following tags' '
=20
 	cd "$D" &&
--=20
1.5.3.4.1156.g5407-dirty
