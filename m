From: Zapped <zapped@mail.ru>
Subject: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect diff.ignoreSubmodules config variable
Date: Sat, 25 Dec 2010 04:20:49 +0300
Message-ID: <1293240049-7744-3-git-send-email-zapped@mail.ru>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 25 02:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWIov-0003mU-8s
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 02:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab0LYBVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 20:21:01 -0500
Received: from smtp8.mail.ru ([94.100.176.53]:35545 "EHLO smtp8.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790Ab0LYBVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 20:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=References:In-Reply-To:Message-Id:Date:Subject:To:From; bh=xnOYM9hUmF6NBGoXq6bYCFtxEFDT4uXOp+AmL4jy0Fo=;
	b=Lvrer4RZfG74XQjRatWLdolNzLzxMOXOLHQ9MlG43fOkIAOekkg0lPX60n6Ooa2X1FJBZ0RnE2iW80/XpXh7mFrERbU2zyshYXotwefFU1ElGLV5H6Uoi6ZxQe+N6zRG;
Received: from [85.140.52.43] (port=41177 helo=localhost.localdomain)
	by smtp8.mail.ru with asmtp 
	id 1PWIoY-0001Kk-00
	for git@vger.kernel.org; Sat, 25 Dec 2010 04:20:54 +0300
X-Mailer: git-send-email 1.7.3.4.3.g3f811
In-Reply-To: <1293240049-7744-1-git-send-email-zapped@mail.ru>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164167>

Signed-off-by: Zapped <zapped@mail.ru>
---
 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d3037fc..50fc385 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -280,7 +280,8 @@ __git_ps1 ()
 		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
 			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
 				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
-					git diff --no-ext-diff --quiet --exit-code || w="*"
+					is=$(git config diff.ignoreSubmodules)
+					git diff --no-ext-diff --quiet --exit-code --ignore-submodules=$is || w="*"
 					if git rev-parse --quiet --verify HEAD >/dev/null; then
 						git diff-index --cached --quiet HEAD -- || i="+"
 					else
-- 
1.7.3.4.3.g3f811
