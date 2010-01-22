From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCHv2] Make difftool.prompt fall back to mergetool.prompt
Date: Fri, 22 Jan 2010 17:36:36 +0100
Message-ID: <4B59D414.4020507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 17:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMW2-0002qi-LE
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab0AVQhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262Ab0AVQhd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:37:33 -0500
Received: from lo.gmane.org ([80.91.229.12]:47663 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927Ab0AVQhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 11:37:22 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NYMVb-0002eV-5c
	for git@vger.kernel.org; Fri, 22 Jan 2010 17:37:19 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 17:37:19 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 17:37:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137764>

The documentation states that "git-difftool falls back to git-mergetool
config variables when the difftool equivalents have not been defined".
Until now, this was not the case for "difftool.prompt".

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-difftool--helper.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 57e8e32..3438aba 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -12,7 +12,8 @@ TOOL_MODE=diff
 # difftool.prompt controls the default prompt/no-prompt behavior
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
 should_prompt () {
-	prompt=$(git config --bool difftool.prompt || echo true)
+	prompt_merge=$(git config --bool mergetool.prompt || echo true)
+	prompt=$(git config --bool difftool.prompt || echo $prompt_merge)
 	if test "$prompt" = true; then
 		test -z "$GIT_DIFFTOOL_NO_PROMPT"
 	else
-- 
1.6.6.265.ga0f40
