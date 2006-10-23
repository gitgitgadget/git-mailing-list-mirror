From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] prune-packed: Fix uninitialized variable.
Date: Mon, 23 Oct 2006 18:26:39 +0200
Message-ID: <87ejszvw00.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 23 18:28:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc2db-00087s-Hy
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 18:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWJWQ0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 12:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbWJWQ0w
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 12:26:52 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:5785 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751990AbWJWQ0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 12:26:52 -0400
Received: from adsl-84-227-176-76.adslplus.ch ([84.227.176.76] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Gc2dU-0002Kf-5Q
	for git@vger.kernel.org; Mon, 23 Oct 2006 11:26:49 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id B83704F8CB; Mon, 23 Oct 2006 18:26:39 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29844>

The dryrun variable was made local instead of static by the previous
commit, and local variables aren't initialized to zero.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 builtin-prune-packed.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index e12b6cf..24e3b0a 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -56,7 +56,7 @@ void prune_packed_objects(int dryrun)
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int dryrun;
+	int dryrun = 0;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-- 
1.4.3.1.g7d714

-- 
Alexandre Julliard
julliard@winehq.org
