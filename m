From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/3] t9700/test.pl: avoid bareword 'STDERR' in 3-argument
 open()
Date: Mon, 15 Sep 2008 11:23:24 -0500
Message-ID: <uWiPWIPu6IKkVafz9wdZ-sRK84QZuJQNOZM80bkfw24NxsVT-Z3J9g@cipher.nrlssc.navy.mil>
References: <T5Id5zYBlKyKEhZkMsE3QTI2aU3XMiwpfpsPq89cvXrakbyGShLtQw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 18:24:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfGsY-00058t-Kn
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 18:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbYIOQXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 12:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbYIOQXh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 12:23:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56933 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408AbYIOQXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 12:23:36 -0400
Received: by mail.nrlssc.navy.mil id m8FGNOJb008174; Mon, 15 Sep 2008 11:23:24 -0500
In-Reply-To: <T5Id5zYBlKyKEhZkMsE3QTI2aU3XMiwpfpsPq89cvXrakbyGShLtQw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 15 Sep 2008 16:23:24.0689 (UTC) FILETIME=[60934810:01C9174F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95917>

Some versions of perl complain when 'STDERR' is used as the third argument
in the 3-argument form of open(). Convert to the 2-argument form which is
described for duping STDERR in my second edition camel book.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9700/test.pl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 732133e..f777b08 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -34,7 +34,7 @@ is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
 # Failure cases for config:
 # Save and restore STDERR; we will probably extract this into a
 # "dies_ok" method and possibly move the STDERR handling to Git.pm.
-open our $tmpstderr, ">&", STDERR or die "cannot save STDERR"; close STDERR;
+open our $tmpstderr, ">&STDERR" or die "cannot save STDERR"; close STDERR;
 eval { $r->config("test.dupstring") };
 ok($@, "config: duplicate entry in scalar context fails");
 eval { $r->config_bool("test.boolother") };
-- 
1.6.0.1.244.gdc19
