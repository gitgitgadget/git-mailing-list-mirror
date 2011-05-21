From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 05/48] i18n: git-am gettext + gettext to stderr message
Date: Sat, 21 May 2011 18:43:46 +0000
Message-ID: <1306003469-22939-6-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrAq-00009h-JF
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab1EUSpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 14:45:14 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab1EUSpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:07 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444607eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=61Q2dOGoLT2VRAtGey/jBAmhpyZHZgmY7LbkuzbPpaU=;
        b=FIJYomRfrttLSv/yArp5NL2QuCiPkCWyZQZGyg55vroo2Cs+qpRlBuAnDDq21rMhLT
         j2LGGHwEdEzHcvlVxKIx9IrHy72ash3cWNWe18sh9sDkvHgC12d1LHUivWZsptJdOPDV
         +0OGZMnb68C27kdQQE7jybMfQoXqWlMIi5rvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FfFopzjK+Q7273pH4DQXpomZJ56evF/cN0F84PiZ/D2eTAbgcFTd4wywFsZn/cpbTE
         MN8SwplAGYD8FzWNoQW4JaFTxmTT5Ohn5dJD5f1qhIVvCj00Y6zvoP8Lf1R22nD773bJ
         hScZvxFdNzyJ82rvnmIoM2NhnwMcb4ZPBRLOc=
Received: by 10.213.108.147 with SMTP id f19mr613307ebp.80.1306003506652;
        Sat, 21 May 2011 11:45:06 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.05
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174121>

---
 git-am.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 7c0273c..d56c7e9 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -89,8 +89,11 @@ safe_to_abort () {
 	then
 		return 0
 	fi
-	echo >&2 "You seem to have moved HEAD since the last 'am' failure."
-	echo >&2 "Not rewinding to ORIG_HEAD"
+	(
+		gettext "You seem to have moved HEAD since the last 'am' failure.
+Not rewinding to ORIG_HEAD" &&
+		echo
+	) >&2
 	return 1
 }
 
-- 
1.7.5.1
