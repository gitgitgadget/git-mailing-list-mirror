From: Christian Neukirchen <chneukirchen@gmail.com>
Subject: [PATCH] cvsimport: silence regex warning appearing in Perl 5.22.
Date: Wed, 24 Jun 2015 16:04:20 +0200
Message-ID: <1435154660-17735-1-git-send-email-chneukirchen@gmail.com>
Cc: Christian Neukirchen <chneukirchen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 16:04:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7lIN-0000Yc-8F
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 16:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbbFXOEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 10:04:51 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33728 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbbFXOEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 10:04:49 -0400
Received: by wgck11 with SMTP id k11so37385521wgc.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SQqYj41sMfx34I7s0+p8kLvItEQ+DvRrN/RkxeATdL0=;
        b=yJGjiQo5q2ICFD3IEOVUS5d29Gd+M6dxRnw352f/8PZDy0IHRRo+gz3AxksMIrkQP3
         x+NbUI+y0RKXWFaLFP3P76JNltJkeKnPjvJ3RO3tLEhiCTBNHxhSXQLFMyPIFZQKiEu9
         d6pjr5f5UvRaNKNMHlxny758skzI8gj3EyQbl2C/QmsD84y3XpRoy7t4q3TpuZRGi0e4
         qrFgtEkYnQLbGUlD+QMOl5rEnQad1SNrecX0MFIbZGbUscepIDxW69diP7dgF8gjfxvq
         daOIB2UKOUnxeAKYMQ05+P6kwXnRNitTToh6hkXVLjJSiEcz6DcnLG519CPOwsTHt3KV
         3bVg==
X-Received: by 10.180.86.163 with SMTP id q3mr5219450wiz.75.1435154688016;
        Wed, 24 Jun 2015 07:04:48 -0700 (PDT)
Received: from juno.home.vuxu.org (host57-2.natpool.mwn.de. [138.246.2.57])
        by mx.google.com with ESMTPSA id j7sm40837539wjz.11.2015.06.24.07.04.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2015 07:04:46 -0700 (PDT)
Received: from localhost (juno.home.vuxu.org [local]);
	by juno.home.vuxu.org (OpenSMTPD) with ESMTPA id 7bad8e8c;
	Wed, 24 Jun 2015 14:04:46 +0000 (UTC)
X-Mailer: git-send-email 2.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272550>

Since Perl 5.22, "A literal '{' should now be escaped in a pattern".
Silence the recently added warning by using \{ instead.

Signed-off-by: Christian Neukirchen <chneukirchen@gmail.com>
---
 git-cvsimport.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 73d367c..8a68777 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -921,7 +921,7 @@ sub commit {
 		# (See check_refname_component in refs.c.)
 		1 while $xtag =~ s/
 			(?: \.\.        # Tag cannot contain '..'.
-			|   \@{         # Tag cannot contain '@{'.
+			|   \@\{        # Tag cannot contain '@{'.
 			| ^ -           # Tag cannot begin with '-'.
 			|   \.lock $    # Tag cannot end with '.lock'.
 			| ^ \.          # Tag cannot begin...
-- 
2.4.4
