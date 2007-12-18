From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-filter-branch.sh: more portable tr usage: use \012, not \n.
Date: Tue, 18 Dec 2007 11:03:23 +0100
Message-ID: <87y7bs2uc4.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 11:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ZIj-0001NW-V0
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 11:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbXLRKDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 05:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbXLRKDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 05:03:25 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:34655 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbXLRKDY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 05:03:24 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6FD1817B56C
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 11:03:23 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5A60A17B546
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 11:03:23 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 405122887F; Tue, 18 Dec 2007 11:03:23 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68723>


I hesitate to suggest this, since GNU tr has accepted \n for 15 years,
but there are supposedly a few crufty vendor-supplied versions of tr still
in use.  Also, all of the other uses of tr-with-newline in git use \012.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 git-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3bb2f67..ee9e1b3 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -290,7 +290,7 @@ while read commit parents; do
 		eval "$filter_tree" < /dev/null ||
 			die "tree filter failed: $filter_tree"

-		git diff-index -r $commit | cut -f 2- | tr '\n' '\000' | \
+		git diff-index -r $commit | cut -f 2- | tr '\012' '\000' | \
 			xargs -0 git update-index --add --replace --remove
 		git ls-files -z --others | \
 			xargs -0 git update-index --add --replace --remove
--
1.5.4.rc0.53.gdfcd
