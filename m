From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/3] git-instaweb: Fix custom apache log placement
Date: Tue, 29 Jun 2010 21:44:58 -0500
Message-ID: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>, Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 04:45:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTnIh-0007Hn-U4
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 04:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab0F3CpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 22:45:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60666 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab0F3CpO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 22:45:14 -0400
Received: by iwn7 with SMTP id 7so365968iwn.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 19:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=EC/JtzxLjtdTTX051G0+3kCtE7ztR+6/oft9+wzhKYk=;
        b=BAcW/pRO4J3JMexVtxFZsuYffnJRwk90qmkx7O+2nCtNb2w+RsZOjYLd5ivlGXtTLN
         BxV0yuVTbOwdPBOO1C8ScIsgP+WjJWWfTRsP2CynZ79UFIcbnKtgerIwgqpF1UoUuuih
         +1sW/agVnIQDTtobOcftBvwhmsAR1xVTX9Sj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=jNAejA28MBg+sj+6fCE1mih4/humZLwxtbCQd2XP/mpPPmO6vR5TGbf/TyBUbrN3yD
         +9eRs76jkaIt7a4Zn+r4hoarUVQf+0rqxPB8qrNwlq9Lnb5Z1awO/iWKFtYoNVw7El8R
         zfXG/Iuo29Ve+7BqlwIwzJHFLjcskBEjdshWg=
Received: by 10.231.120.210 with SMTP id e18mr8025644ibr.84.1277865911541;
        Tue, 29 Jun 2010 19:45:11 -0700 (PDT)
Received: from localhost (adsl-76-193-181-63.dsl.chcgil.sbcglobal.net [76.193.181.63])
        by mx.google.com with ESMTPS id g8sm17491967ibb.11.2010.06.29.19.45.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 19:45:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149939>

'CustomLog' is provided by mod_log_config so we need to include the module
in our generated config. This was added in d94775e1f9a.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 git-instaweb.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6635fbe..a01476a 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -314,7 +314,7 @@ PidFile "$fqgitdir/pid"
 Listen $bind$port
 EOF
 
-	for mod in mime dir; do
+	for mod in mime dir log_config; do
 		if test -e $module_path/mod_${mod}.so; then
 			echo "LoadModule ${mod}_module " \
 			     "$module_path/mod_${mod}.so" >> "$conf"
-- 
1.7.1
