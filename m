From: Jeff King <peff@peff.net>
Subject: [PATCH 08/16] t4200: use cut instead of sed
Date: Wed, 12 Mar 2008 17:37:56 -0400
Message-ID: <20080312213756.GI26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:38:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYej-0001Cx-RB
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbYCLVh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYCLVh7
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:37:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3437 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbYCLVh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:37:58 -0400
Received: (qmail 3302 invoked by uid 111); 12 Mar 2008 21:37:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:37:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:37:56 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76999>

Some versions of sed (like the one on Solaris) don't like to
match literal tabs, and simply print nothing. Instead, let's
use cut.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4200-rerere.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 3cbfee7..d3dea2a 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -53,7 +53,7 @@ test_expect_success 'conflicting merge' '
 	! git merge first
 '
 
-sha1=$(sed -e 's/	.*//' .git/rr-cache/MERGE_RR)
+sha1=$(cut -d'	' -f1 .git/rr-cache/MERGE_RR)
 rr=.git/rr-cache/$sha1
 test_expect_success 'recorded preimage' "grep ======= $rr/preimage"
 
-- 
1.5.4.4.543.g30fdd.dirty
