From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] test-lib.sh: unset XDG_CONFIG_HOME
Date: Tue, 24 Jul 2012 07:53:05 -0400
Message-ID: <20120724115305.GA7328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:53:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StdgG-0008Hz-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 13:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab2GXLxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 07:53:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60132 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab2GXLxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 07:53:08 -0400
Received: (qmail 15876 invoked by uid 107); 24 Jul 2012 11:53:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jul 2012 07:53:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2012 07:53:05 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202027>

Now that git respects XDG_CONFIG_HOME for some lookups, we
must be sure to cleanse the test environment. Otherwise, the
user's XDG_CONFIG_HOME could influence the test results.

Signed-off-by: Jeff King <peff@peff.net>
---
[oops, re-sending because I forgot to cc git@vger]

You can test this trivially with:

  XDG_CONFIG_HOME=/whatever ./t1306-xdg-files.sh

 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index acda33d..5e7f435 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -61,6 +61,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $(perl -e '
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
 ')
+unset XDG_CONFIG_HOME
 GIT_AUTHOR_EMAIL=author@example.com
 GIT_AUTHOR_NAME='A U Thor'
 GIT_COMMITTER_EMAIL=committer@example.com
-- 
1.7.11.3.4.g9f70dbb
