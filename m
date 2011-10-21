From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/2] submodule::module_clone(): silence die() message from module_name()
Date: Fri, 21 Oct 2011 21:49:36 +0800
Message-ID: <1319204976-5076-3-git-send-email-rctay89@gmail.com>
References: <1317978295-4796-2-git-send-email-rctay89@gmail.com>
 <1319204976-5076-1-git-send-email-rctay89@gmail.com>
 <1319204976-5076-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 15:50:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHFU1-0004wg-JX
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 15:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711Ab1JUNt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 09:49:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35352 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab1JUNt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 09:49:56 -0400
Received: by ggnb1 with SMTP id b1so3864130ggn.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=URAfv6U/RxvDMpmTNzyMTZjMhEXWV3e9j3flOGSPp8Q=;
        b=JtBpDlPnlps0O9AZNboqGyJvMQjFOJxmSl12TqkHgMmt0fMF+2T/jQD8ElFK/8ie2b
         mrvy53tpnYK7TdN2z3Fk+GF5uIIJC1HGD8anV9rpKfFrK+uPg0A3NOXi5x2DpK2sQcyu
         k78A4uvLpZzq9V2YCwO0AgDkDlLIhcLtq0SZ8=
Received: by 10.68.73.103 with SMTP id k7mr18636248pbv.30.1319204995797;
        Fri, 21 Oct 2011 06:49:55 -0700 (PDT)
Received: from localhost (s80216.pc.nus.edu.sg. [137.132.36.216])
        by mx.google.com with ESMTPS id w4sm30771014pbf.6.2011.10.21.06.49.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 06:49:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.msysgit.0.584.g2cbf
In-Reply-To: <1319204976-5076-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184064>

The die() message that may occur in module_name() is not really relevant
to the user when called from module_clone(); the latter handles the
"failure" (no submodule mapping) anyway.

Analysis of other callsites is left to future work.

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8e9e5ea..5d29f82 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -124,7 +124,7 @@ module_clone()
 	reference="$3"
 	gitdir=
 	gitdir_base=
-	name=$(module_name "$path")
+	name=$(module_name "$path" 2>/dev/null)
 	base_path=$(dirname "$path")
 
 	gitdir=$(git rev-parse --git-dir)
-- 
1.7.6.msysgit.0.584.g2cbf
