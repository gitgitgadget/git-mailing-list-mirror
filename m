From: Remi Vanicat <vanicat@debian.org>
Subject: [PATCH] Make GIT_INDEX_FILE apply to git-commit
Date: Sat, 10 Nov 2007 11:00:50 +0100
Organization: none
Message-ID: <87abpml8rx.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 11:03:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqnB8-0007nj-Ij
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 11:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbXKJKCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2007 05:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXKJKCk
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 05:02:40 -0500
Received: from main.gmane.org ([80.91.229.2]:57110 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbXKJKCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 05:02:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iqn9i-0005qj-Up
	for git@vger.kernel.org; Sat, 10 Nov 2007 10:01:34 +0000
Received: from 77.193.67.174 ([77.193.67.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 10:01:34 +0000
Received: from vanicat by 77.193.67.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 10:01:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 77.193.67.174
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:nyyhCBAyIe3THZqE/ffz/QWX+p0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64324>

Currently, when committing, git-commit ignore the value of
GIT_INDEX_FILE, and always use $GIT_DIR/index. This patch
fix it.

Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
---
 git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index fcb8443..6490045 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -26,7 +26,7 @@ refuse_partial () {
 }

 TMP_INDEX=3D
-THIS_INDEX=3D"$GIT_DIR/index"
+THIS_INDEX=3D"${GIT_INDEX_FILE:-$GIT_DIR/index}"
 NEXT_INDEX=3D"$GIT_DIR/next-index$$"
 rm -f "$NEXT_INDEX"
 save_index () {
--
1.5.3.5
