From: Ariel Faigon <github.2009@yendor.com>
Subject: [PATCH] git-completion.tcsh: fix redirect with noclobber
Date: Tue, 9 Jun 2015 10:25:15 -0700
Message-ID: <20150609172515.GA20638@yendor.com>
Reply-To: github.2009@yendor.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 19:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2NH8-0002Eo-3k
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 19:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbbFIRZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 13:25:18 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:42268 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752355AbbFIRZQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 13:25:16 -0400
Received: from homiemail-a61.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a61.g.dreamhost.com (Postfix) with ESMTP id EA17557807E
	for <git@vger.kernel.org>; Tue,  9 Jun 2015 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=yendor.com; h=date:from:to
	:subject:message-id:reply-to:mime-version:content-type; s=
	yendor.com; bh=3qKWUCHa7/dR9tywZvz3avqDjvA=; b=cKWVy/gLTYZsyywvP
	4n5e16Y4wyFrPZ+0uwzM1ehQ2HPbl5O1Mp1DlIRluN3b6z3BOAAwk4RqqAAVgdN2
	+ZExjUtCLJ3Uc4pF3vIpuj0itm79l25SzeNrOVR7vwhK1qE3GhTdTqOH52xic7Er
	MHeQhSauuxycfYmaCFmuS6TujQ=
Received: from go (c-67-188-70-105.hsd1.ca.comcast.net [67.188.70.105])
	(Authenticated sender: catch-all@yendor.com)
	by homiemail-a61.g.dreamhost.com (Postfix) with ESMTPA id E08EA57806E
	for <git@vger.kernel.org>; Tue,  9 Jun 2015 10:25:15 -0700 (PDT)
Received: by go (Postfix, from userid 1000)
	id 5FD401C0BE15; Tue,  9 Jun 2015 10:25:15 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271205>

tcsh users who happen to have 'set noclobber' elsewhere in their
~/.tcshrc or ~/.cshrc startup files get a 'File exist' error, and
the tcsh completion file doesn't get generated/updated.

Adding a `!` in the redirect works correctly for both clobber (default)
and 'set noclobber' users.

Helped-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Ariel Faigon <github.2009@yendor.com>
---

 contrib/completion/git-completion.tcsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.tcsh b/contrib/completion/git-completion.tcsh
index 6104a42..4a790d8 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -41,7 +41,7 @@ if ( ! -e ${__git_tcsh_completion_original_script} ) then
 	exit
 endif
 
-cat << EOF > ${__git_tcsh_completion_script}
+cat << EOF >! ${__git_tcsh_completion_script}
 #!bash
 #
 # This script is GENERATED and will be overwritten automatically.
