From: benoit.person@ensimag.fr
Subject: [PATCH v7 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Wed,  3 Jul 2013 00:39:44 +0200
Message-ID: <1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 00:52:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu9QS-0000tX-9v
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 00:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424Ab3GBWlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 18:41:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37427 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315Ab3GBWle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 18:41:34 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r62MfN0O032594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jul 2013 00:41:23 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r62MfQLX021151;
	Wed, 3 Jul 2013 00:41:26 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r62MfMNc024530;
	Wed, 3 Jul 2013 00:41:26 +0200
X-Mailer: git-send-email 1.8.3.1.590.gc07d91b
In-Reply-To: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jul 2013 00:41:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r62MfN0O032594
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: benoit.person@ensimag.fr
MailScanner-NULL-Check: 1373409688.09759@eBOrke2RKvqw0Y22Ws8AnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229438>

From: Benoit Person <benoit.person@ensimag.fr>

For now, bin-wrappers (based on wrap-for-bin.sh) redefine some
environnement variables (like $GITPERLLIB). If we want to chain to
those scripts and define one of those variables before, our changes
will be overwritten.

This patch simply makes the bin-wrappers prepend their modifications
rather than redefine the vars.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 wrap-for-bin.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 53a8dd0..dbebe49 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -14,7 +14,7 @@ else
 	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
 	export GIT_TEMPLATE_DIR
 fi
-GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
+GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib:'"$GITPERLLIB"
 GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
 PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
-- 
1.8.3.1.590.gc07d91b
