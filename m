From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 0/2] Revert --valgrind-parallel test option
Date: Sat, 19 Oct 2013 23:06:06 +0200
Message-ID: <cover.1382215973.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 23:06:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXdjH-0005BM-2Y
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 23:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab3JSVGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 17:06:31 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:36711 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436Ab3JSVGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 17:06:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 335AA4D650A;
	Sat, 19 Oct 2013 23:06:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Av7t_1FxIhnf; Sat, 19 Oct 2013 23:06:09 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 247D04D64C1;
	Sat, 19 Oct 2013 23:06:09 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.1.810.g312044e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236409>

These patches remove the --valgrind-parallel=N option that was broken
from the outset (shame on me).  Peff's judgement at the time that its
usefulness would approximately be "meh" turns out to be correct.

What's not in the commit message, but drives part of my reasoning in
doing a revert instead of a fix: I did fix it up locally only to
notice that it was too slow in this case for what I actually wanted to
use it for.  The only valgrind-test workflow that I find bearable is
to run all the tests in the background under prove (takes hours), and
then use the prove output (which says exactly which subtests fail) in
--valgrind-only=<subtest>.  So the latter is -- again Peff was right
-- the really useful thing.

The only consolation is that I apparently didn't break any other use
of the test suite -- otherwise it would presumably have been fixed
very quickly.

Thomas Rast (2):
  Revert "test-lib: support running tests under valgrind in parallel"
  Revert "test-lib: allow prefixing a custom string before "ok N" etc."

 t/test-lib.sh | 133 +++++++++++++++-------------------------------------------
 1 file changed, 34 insertions(+), 99 deletions(-)

-- 
1.8.4.1.810.g312044e
