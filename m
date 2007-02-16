From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT 1.5.0 binary installer available.
Date: Fri, 16 Feb 2007 05:23:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702160517390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45D44FD5.72299A3A@eudaptics.com> <45D48FF5.2060800@xs4all.nl>
 <Pine.LNX.4.63.0702151954480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070215201249.GA27526@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 05:23:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHudI-0001vV-Mt
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 05:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423133AbXBPEXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 23:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423136AbXBPEXh
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 23:23:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:41156 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423133AbXBPEXh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 23:23:37 -0500
Received: (qmail invoked by alias); 16 Feb 2007 04:23:35 -0000
X-Provags-ID: V01U2FsdGVkX195tbh9kn15ZeHkyodpWpT8YQRWbQUUq4NTLP3Vu0
	o6Fw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070215201249.GA27526@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39884>

Hi,

On Thu, 15 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I already made a minimal change to git-gui so you can choose the directory 
> > to start from.
> 
> Do post, when ready.  ;-)

ATM it looks like this:

-- snip --
 git-gui/git-gui.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index f5010dd..ed5cd82 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -291,6 +291,11 @@ proc ask_popup {msg} {
 ##
 ## repository setup
 
+if { [is_Windows] && ![is_Cygwin] } {
+	set repo_dir [tk_chooseDirectory -title "Choose a Git repository" -mustexist 1]
+	cd $repo_dir
+}
+
 if {   [catch {set _gitdir $env(GIT_DIR)}]
 	&& [catch {set _gitdir [exec git rev-parse --git-dir]} err]} {
 	catch {wm withdraw .}
-- snap --

However, I am still wondering what to make of the silly behaviour I 
observed earlier: the PATH was forgotten either by "sh" being called from 
"cmd", or by "wish84" being called from "sh".

But the strangest part about it: if I replaced the program names with 
their absolute path, then the command line options would _not_ be ignored. 
Strange.

If I get that fsck up fixed, I'd like to work with Han-Wen on enhancing 
his installer (which is nice!) with wish, bash, perl, and a shortcut to 
git-gui in Start Menu/Git/Git GUI.

BTW any news on the integration of gitk in git-gui?

Ciao,
Dscho
