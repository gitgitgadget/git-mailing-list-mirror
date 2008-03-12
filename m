From: Jeff King <peff@peff.net>
Subject: [PATCH 02/16] t0050: perl portability fix
Date: Wed, 12 Mar 2008 17:30:10 -0400
Message-ID: <20080312213010.GC26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYXH-0006KO-1g
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbYCLVaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbYCLVaO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:30:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4848 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbYCLVaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:30:13 -0400
Received: (qmail 2656 invoked by uid 111); 12 Mar 2008 21:30:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:30:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:30:10 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76992>

Older versions of perl (such as 5.005) don't understand -CO, nor
do they understand the "U" pack specifier. Instead of using perl,
let's just printf the binary bytes we are interested in.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0050-filesystem.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index cd088b3..3fbad77 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -4,8 +4,8 @@ test_description='Various filesystem issues'
 
 . ./test-lib.sh
 
-auml=`perl -CO -e 'print pack("U",0x00E4)'`
-aumlcdiar=`perl -CO -e 'print pack("U",0x0061).pack("U",0x0308)'`
+auml=`printf '\xc3\xa4'`
+aumlcdiar=`printf '\x61\xcc\x88'`
 
 test_expect_success 'see if we expect ' '
 
-- 
1.5.4.4.543.g30fdd.dirty
