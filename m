From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Avoid a lisp error when there's no current branch (detached HEAD).
Date: Wed, 22 Aug 2007 12:21:38 +0200
Message-ID: <87r6lvna31.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 12:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INnLN-0008J8-6a
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 12:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbXHVKVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 06:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534AbXHVKVm
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 06:21:42 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:53773 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbXHVKVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 06:21:41 -0400
Received: from adsl-84-227-22-252.adslplus.ch ([84.227.22.252] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1INnLI-000281-Pi
	for git@vger.kernel.org; Wed, 22 Aug 2007 05:21:41 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 61221429EA1; Wed, 22 Aug 2007 12:21:38 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56367>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index be44e06..abc799a 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -664,9 +664,11 @@ Return the list of files that haven't been handled."
     (ewoc-set-hf status
                  (format "Directory:  %s\nBranch:     %s\nHead:       %s%s\n"
                          default-directory
-                         (if (string-match "^refs/heads/" branch)
-                             (substring branch (match-end 0))
-                           branch)
+                         (if branch
+                             (if (string-match "^refs/heads/" branch)
+                                 (substring branch (match-end 0))
+                               branch)
+                           "none (detached HEAD)")
                          head
                          (if merge-heads
                              (concat "\nMerging:    "
-- 
1.5.3.rc6.12.g7c176

-- 
Alexandre Julliard
julliard@winehq.org
