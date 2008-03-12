From: Jeff King <peff@peff.net>
Subject: [PATCH 09/16] t6000lib: tr portability fix
Date: Wed, 12 Mar 2008 17:38:31 -0400
Message-ID: <20080312213831.GJ26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYfJ-0001Tf-1p
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbYCLVie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbYCLVie
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:38:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3440 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbYCLVie (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:38:34 -0400
Received: (qmail 3361 invoked by uid 111); 12 Mar 2008 21:38:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:38:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:38:31 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77000>

Some versions of tr complain if the number of characters in
both sets isn't the same. So here we must manually expand
the dashes in set2.

Signed-off-by: Jeff King <peff@peff.net>
---
This almost makes me want to just use sed instead. But quoting that line
noise would probably make it less readable.

 t/t6000lib.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/t/t6000lib.sh b/t/t6000lib.sh
index 180633e..b69f7c4 100755
--- a/t/t6000lib.sh
+++ b/t/t6000lib.sh
@@ -97,7 +97,10 @@ check_output()
 # from front and back.
 name_from_description()
 {
-        tr "'" '-' | tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' '-' | tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
+        tr "'" '-' |
+		tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' \
+		   '------------------------------' |
+		tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
 }
 
 
-- 
1.5.4.4.543.g30fdd.dirty
