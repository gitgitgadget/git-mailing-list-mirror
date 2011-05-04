From: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: [PATCH] bash: Disable __git_ps1() if NO_GIT_PS1 is set
Date: Thu, 5 May 2011 00:11:53 +0200
Message-ID: <20110504221153.GB15161@linode>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 05 00:19:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHkQE-0003AX-N6
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 00:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab1EDWTt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 18:19:49 -0400
Received: from smtp.domeneshop.no ([194.63.248.54]:53296 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074Ab1EDWTt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 18:19:49 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 May 2011 18:19:49 EDT
Received: from sunbase.org ([178.79.142.16] helo=linode)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <sunny@sunbase.org>)
	id 1QHkIV-0000u6-V3; Thu, 05 May 2011 00:11:56 +0200
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
	git@vger.kernel.org, spearce@spearce.org
Content-Disposition: inline
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172780>

If the user works in a big repository on a slow USB disk or network
drive, __git_ps1() can result in a significant delay before the prompt
reappears. By setting the environment variable NO_GIT_PS1 to a nonempty
value, the use of __git_ps1() is temporarily disabled.

Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
---
 contrib/completion/git-completion.bash |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0df356d..ee8cef5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -60,6 +60,11 @@
 #       per-repository basis by setting the bash.showUpstream config
 #       variable.
 #
+#       When working in a big repository on a slow USB disk or network
+#       drive, __git_ps1 may result in a noticeable delay before the p=
rompt
+#       reappears.  To temporarily disable the use of __git_ps1, set
+#       NO_GIT_PS1 to a nonempty value.
+#
 #
 # To submit patches:
 #
@@ -225,6 +230,7 @@ __git_ps1_show_upstream ()
 # returns text to add to bash PS1 prompt (includes branch name)
 __git_ps1 ()
 {
+	[ -z "$NO_GIT_PS1" ] || return
 	local g=3D"$(__gitdir)"
 	if [ -n "$g" ]; then
 		local r=3D""
--=20
1.7.5.185.g0b9dee
