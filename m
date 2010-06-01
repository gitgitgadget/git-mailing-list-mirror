From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH] Makefile: Use $(sharedir)/gitweb for target 'install-gitweb'
Date: Tue,  1 Jun 2010 20:41:20 +0530
Message-ID: <1275405080-17326-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 01 17:11:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJT7y-0002Qq-3Z
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255Ab0FAPLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 11:11:33 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:48781 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab0FAPLd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 11:11:33 -0400
Received: by pzk15 with SMTP id 15so1501694pzk.15
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7IXkyQgH76bVeaN9GRy4gcjw+oPi035w16LFkzHyU8w=;
        b=RKPlsT1AebE7PHUMPzp5wWVNBDC6XrZlbHNVQ1fK0S1jWPzCySyGqTIrIVliFZl0uE
         aMqVO4a3V3isH5r4TmSBuNrA2BOXSpNjDZLPCauK42N5kHxW9B/99Wr4zbdaRy9Q2B1P
         w4IZ4Vyq00ckCsRXil012A/pAS5UthliS7428=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qSKjgq/3Oi1MCncaiKWqJIsWdbMdY6S92u+jC2yk8yQhJpr/LOZJNXDdk/5vzCXbZ5
         iYNiH5Kp4o7+FEVFxNdpI4YNDMVbD13BHB868C44/g1tYMi2SE3IVHSk4tsWQG87GRdK
         5MlI8+xN0QBoB2hmxCyHzBJlaQGaaoyPznBCA=
Received: by 10.141.88.12 with SMTP id q12mr4638065rvl.188.1275405092511;
        Tue, 01 Jun 2010 08:11:32 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id l29sm5307472rvb.16.2010.06.01.08.11.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 08:11:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.447.g40f7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148124>

Export gitwebdir variable so that when user types the command
'make install-gitweb', gitweb is installed in $(sharedir)/gitweb
rather than /var/www/cgi-bin. Now, $(sharedir)/gitweb is default
for both 'install' and 'install-gitweb' targets.

Remove 'gitwebdir=$(gitwebdir_SQ)' from gitweb part of 'install'
target which is unneccessary now.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8f011a5..32e3146 100644
--- a/Makefile
+++ b/Makefile
@@ -294,7 +294,7 @@ lib = lib
 # DESTDIR=
 pathsep = :
 
-export prefix bindir sharedir sysconfdir
+export prefix bindir sharedir gitwebdir sysconfdir
 
 CC = gcc
 AR = ar
@@ -2049,7 +2049,7 @@ install: all
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
-	$(MAKE) -C gitweb gitwebdir=$(gitwebdir_SQ) install
+	$(MAKE) -C gitweb install
 endif
 ifndef NO_PYTHON
 	$(MAKE) -C git_remote_helpers prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
-- 
1.7.1.447.g40f7.dirty
