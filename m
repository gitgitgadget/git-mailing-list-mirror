From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: use __gitdir when completing 'git rebase' options
Date: Thu,  6 Mar 2008 22:37:36 +0100
Message-ID: <1204839456-23566-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Mar 06 22:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXNoL-00005o-EO
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 22:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936007AbYCFViV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935988AbYCFViU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 16:38:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:53667 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935940AbYCFViS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 16:38:18 -0500
Received: from elysium (p5B13314E.dip0.t-ipconnect.de [91.19.49.78])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1JXNmT1SpE-0006Mn; Thu, 06 Mar 2008 22:37:39 +0100
Received: from fzi.de (neumann.wired [192.168.1.2])
	by elysium (Postfix) with SMTP id D97F8123A8D;
	Thu,  6 Mar 2008 22:37:36 +0100 (CET)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-Provags-ID: V01U2FsdGVkX19m70ddLsNCrBtnTtbolWdkMyp6BBwB8JcIati
 u57d48b55aOngDzNFL2bWxUkd/kcVCfM8eezrEBxYvGrcC1TaR
 u1PDvp9XgHoItANX3Decw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76425>

When doing completion of rebase options in a subdirectory of the work
tree during an ongoing rebase, wrong options were offered because of th=
e
hardcoded .git/.dotest-merge path.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 49e6df0..aee9125 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -828,8 +828,8 @@ _git_push ()
=20
 _git_rebase ()
 {
-	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
-	if [ -d .dotest ] || [ -d .git/.dotest-merge ]; then
+	local cur=3D"${COMP_WORDS[COMP_CWORD]}" dir=3D"$(__gitdir)"
+	if [ -d .dotest ] || [ -d "$dir"/.dotest-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
--=20
1.5.4.3

