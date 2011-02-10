From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v4 1/5] t5526: Fix wrong argument order in "git config"
Date: Thu, 10 Feb 2011 18:40:02 -0500
Message-ID: <1297381209-6377-3-git-send-email-jaredhance@gmail.com>
References: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 00:42:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Png9j-0006eN-Uc
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485Ab1BJXk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:40:58 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50690 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163Ab1BJXkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:40:31 -0500
Received: by mail-vx0-f174.google.com with SMTP id 37so1028081vxb.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 15:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=5efVBK8zrMv3HAbaZqigAbb8AFp55U85CZuvu3vZSd0=;
        b=Pa+ZXrTujV6nO0pNUswJM3sC1fBOU7HUj8bbh+uuDJuFe/gpDUy6GCmO9vd5yOTTzy
         Gr8bp0sosouRQQRBY7bvgcDO12DOMZGh3yo6bumobW/vAMOLcdWuBaAJJH7R8qMMrc39
         ETU/lIseUDOz43ectD4OdRgW4/+3hMHKOl13A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KkDTmZ8GGEzP52gsIE9kaVE718Pu/tUIdnaHUmbsQaF0p2rgLrszOYZAl3ga3zP92U
         JmVMAN+FkIXYUSha7PMNhpEv0agSBIplRXpwp/UFXzNieoqNzmg8GDPXoLPAzK1CRKBb
         92y60QdBjWJoYTTLvv95qdtE8dL5F21SlYIUc=
Received: by 10.220.183.71 with SMTP id cf7mr5859830vcb.35.1297381223446;
        Thu, 10 Feb 2011 15:40:23 -0800 (PST)
Received: from localhost.localdomain (cpe-75-186-7-248.cinci.res.rr.com [75.186.7.248])
        by mx.google.com with ESMTPS id r7sm126736vbx.19.2011.02.10.15.40.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 15:40:22 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297381209-6377-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166524>

From: Jens Lehmann <Jens.Lehmann@web.de>

This fixes a typo where the "git config" arguments "-f" and "--unset" were
swapped leading to the creation of a "--unset" file.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 t/t5526-fetch-submodules.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 884a5e5..a5f4585 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -124,7 +124,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
-		git config -f --unset .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
+		git config --unset -f .gitmodules submodule.submodule.fetchRecurseSubmodules &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_cmp expect.out actual.out &&
-- 
1.7.4
