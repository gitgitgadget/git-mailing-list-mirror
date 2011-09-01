From: Alex Merry <dev@randomguy3.me.uk>
Subject: [PATCH] Fix git-completion.bash for use in zsh
Date: Thu, 01 Sep 2011 14:47:31 +0100
Message-ID: <4E5F8CF3.3060304@randomguy3.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 16:49:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz8aS-0008PZ-Jz
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 16:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757694Ab1IAOtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 10:49:43 -0400
Received: from fallback1.mail.ox.ac.uk ([163.1.2.175]:59568 "EHLO
	fallback1.mail.ox.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757651Ab1IAOtn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 10:49:43 -0400
X-Greylist: delayed 3726 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Sep 2011 10:49:43 EDT
Received: from relay9.mail.ox.ac.uk ([163.1.2.169])
	by fallback1.mail.ox.ac.uk with esmtp (Exim 4.69)
	(envelope-from <dev@randomguy3.me.uk>)
	id 1Qz7de-0006yM-3R
	for git@vger.kernel.org; Thu, 01 Sep 2011 14:49:02 +0100
Received: from mailer.cs.ox.ac.uk ([129.67.151.81])
	by relay9.mail.ox.ac.uk with esmtp (Exim 4.75)
	(envelope-from <dev@randomguy3.me.uk>)
	id 1Qz7cB-00066M-Uv; Thu, 01 Sep 2011 14:47:31 +0100
Received: from clpc343.comlab.ox.ac.uk ([129.67.149.183]:41187)
	by mailer.cs.ox.ac.uk with esmtp (Exim 4.76)
	(envelope-from <dev@randomguy3.me.uk>)
	id 1Qz7cB-0003yU-4i; Thu, 01 Sep 2011 14:47:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180532>

Certain versions (or option combinations) of zsh appear to treat
things like
local some_var=()
as a function declaration.  This makes errors appear when using it in
combination with the GIT_PS1_SHOWUPSTREAM option.

Signed-off-by: Alex Merry <dev@randomguy3.me.uk>
---
 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5a83090..89de45d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -106,8 +106,9 @@ __gitdir ()
 __git_ps1_show_upstream ()
 {
        local key value
-       local svn_remote=() svn_url_pattern count n
+       local svn_remote svn_url_pattern count n
        local upstream=git legacy="" verbose=""
+       svn_remote=()

        # get some config options from git-config
        while read key value; do
-- 
1.7.6
