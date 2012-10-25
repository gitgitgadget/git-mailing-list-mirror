From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Use character class for sed expression instead of \s
Date: Thu, 25 Oct 2012 16:58:19 +0100
Message-ID: <1351180699-24695-1-git-send-email-bdwalton@gmail.com>
References: <508935CB.9020408@web.de>
Cc: Ben Walton <bdwalton@gmail.com>
To: tboegi@web.de, peff@peff.net, bosch@adacore.com,
	brian@gernhardtsoftware.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 17:58:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRPpW-0005Ul-Nz
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 17:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933622Ab2JYP6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 11:58:34 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34413 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932678Ab2JYP6d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 11:58:33 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1441618wgb.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+pKQwXmm0bTt8KcYeBOA0d6tLRfVAM8GRBZGg3lloCI=;
        b=DiRWpPTZHDhMSm6b5iy0n26Mut3FmUG/HVOkcgn5wNrSQj5mw0cTeb3FX3gCcnzH7P
         DAUc7grTc72jw60NZ2u4Gi17gxyP/zRf6pVSajTGoUCtnEwJ2alDGa1A0o9or3QfoVYj
         pqrs03TyREpHw9IJxms/H3iSokCCg7Qkx9e8ILx5Atbn8AHyOFGywCwsx1OAWd38htre
         01+Z+GBw25cKgl9FAaD5EDVxhZRB6xORRvsr2XpHhbD1lgqGWCPTa28u4oxVBWB51Rac
         uOOEoNK/vQyaR26O0MZaFafw7hSwHgahQgWnQX68hiTdN3HzstyCjL/+rulXsf32vXvB
         Phqg==
Received: by 10.216.131.132 with SMTP id m4mr12781229wei.23.1351180712548;
        Thu, 25 Oct 2012 08:58:32 -0700 (PDT)
Received: from gilmour.chass.utoronto.ca ([89.100.144.153])
        by mx.google.com with ESMTPS id fp6sm10527322wib.0.2012.10.25.08.58.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 08:58:31 -0700 (PDT)
Received: from bwalton by gilmour.chass.utoronto.ca with local (Exim 4.76)
	(envelope-from <bdwalton@gmail.com>)
	id 1TRPpC-0006Qs-Tf; Thu, 25 Oct 2012 16:58:26 +0100
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <508935CB.9020408@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208403>

Sed on Mac OS X doesn't handle \s in a sed expressions so use a more
portable character set expression instead.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---

Hi Torsten,

I think this would be a nicer fix for the issue although your solution
should work as well.

Thanks
-Ben

 t/t9401-git-cvsserver-crlf.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index cdb8360..1c5bc84 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -46,7 +46,7 @@ check_status_options() {
 	echo "Error from cvs status: $1 $2" >> "${WORKDIR}/marked.log"
 	return 1;
     fi
-    got="$(sed -n -e 's/^\s*Sticky Options:\s*//p' "${WORKDIR}/status.out")"
+    got="$(sed -n -e 's/^[ 	]*Sticky Options:[ 	]*//p' "${WORKDIR}/status.out")"
     expect="$3"
     if [ x"$expect" = x"" ] ; then
 	expect="(none)"
-- 
1.7.9.5
