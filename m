From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] request-pull: avoid mentioning that the start point is a
 single commit
Date: Fri, 29 Jan 2010 02:18:17 +0100
Message-ID: <20100129011817.GT12429@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 02:18:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NafVB-00062Y-3U
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 02:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab0A2BSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 20:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756561Ab0A2BST
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 20:18:19 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35535 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756470Ab0A2BST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 20:18:19 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9B971580A1;
	Fri, 29 Jan 2010 02:18:17 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8B97A44967;
	Fri, 29 Jan 2010 02:18:17 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 74A191240002; Fri, 29 Jan 2010 02:18:17 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138289>

Previously we ran shortlog on the start commit which always printed
"(1)" after the start commit, which gives no information, but makes the
output less easy to read. Avoid doing so.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

So for example the 'git request-pull master~2 . master' output diff is
the following here:

	 The following changes since commit 68186857a9bb0a71e9456155623e02d398a5b817:
	-  Junio C Hamano (1):
	-        Merge branch 'il/maint-colon-address'
	+  Junio C Hamano: Merge branch 'il/maint-colon-address'

	 are available in the git repository at:

 git-request-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 630cedd..8475919 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -66,7 +66,7 @@ if [ -z "$branch" ]; then
 fi
 
 echo "The following changes since commit $baserev:"
-git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
+git log --max-count=1 --pretty=format:"  %an: %s%n%n" $baserev
 
 echo "are available in the git repository at:"
 echo
-- 
1.6.6.1
