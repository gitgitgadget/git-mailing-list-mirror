From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] rev-list: make "estimate_bisect_steps" non static
Date: Sun, 19 Apr 2009 11:55:38 +0200
Message-ID: <20090419115538.2c8aae2a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 11:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvTn7-0002Ej-V3
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 11:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbZDSJ4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 05:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472AbZDSJ4z
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 05:56:55 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:59871 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754381AbZDSJ4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 05:56:54 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 4148D4B011B;
	Sun, 19 Apr 2009 11:56:47 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id 36BB04B0137;
	Sun, 19 Apr 2009 11:56:45 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116887>

Because it will be used from "bisect.c" too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.h           |    2 ++
 builtin-rev-list.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/bisect.h b/bisect.h
index fdba913..cb37ddf 100644
--- a/bisect.h
+++ b/bisect.h
@@ -26,4 +26,6 @@ extern int show_bisect_vars(struct rev_list_info *info, int reaches, int all);
 
 extern int bisect_next_vars(const char *prefix);
 
+extern int estimate_bisect_steps(int all);
+
 #endif
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 38a8f23..4c5f5ee 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -211,7 +211,7 @@ static inline int exp2i(int n)
  *
  * and P(2^n + x) < 0.5 means 2^n < 3x
  */
-static int estimate_bisect_steps(int all)
+int estimate_bisect_steps(int all)
 {
 	int n, x, e;
 
-- 
1.6.2.2.537.g3b83b
