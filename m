From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect view: check for MinGW32 and MacOSX in addition
 to X11
Date: Mon, 10 Mar 2008 19:20:10 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803101919060.3975@racer.site>
References: <alpine.LSU.1.00.0802141228300.30505@racer.site> <Pine.LNX.4.64.0802151038520.18292@ds9.cixit.se> <alpine.LSU.1.00.0802151050340.30505@racer.site> <Pine.LNX.4.64.0802151346000.18292@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Mar 10 19:21:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYmcK-0003RJ-D1
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 19:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbYCJSUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 14:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbYCJSUH
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 14:20:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:43459 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855AbYCJSUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 14:20:06 -0400
Received: (qmail invoked by alias); 10 Mar 2008 18:20:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 10 Mar 2008 19:20:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oRow5w2Rorst3hnDCGB7blXN1sfhT/dnkaO0PX3
	DoliHxLwCU5aPI
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0802151346000.18292@ds9.cixit.se>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76749>

Hi,

On Fri, 15 Feb 2008, Peter Karlsson wrote:

> Johannes Schindelin:
> 
> > Can you please test?  The we could at least add a "Tested-by:" to the 
> > commit message.
> 
> When starting from the "Git bash" shell, it works.
> 
> When starting from a Cygwin prompt, it does not work ($MSYSTEM is not 
> set).

Can you please test this patch (both from interactive and ssh'ed 
sessions)?

-- snipsnap --
[PATCH] bisect view: call gitk if Cygwin's SESSIONNAME variable is set

It seems that Cygwin sets the variable SESSIONNAME when an interactive
session is running, and does not set it when you log in via ssh.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 2c32d0b..af8f9e3 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -333,7 +333,7 @@ bisect_visualize() {
 
 	if test $# = 0
 	then
-		case "${DISPLAY+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" in
+		case "${DISPLAY+set}${SESSIONNAME+set}${MSYSTEM+set}${SECURITYSESSIONID+set}" in
 		'')	set git log ;;
 		set*)	set gitk ;;
 		esac
-- 
1.5.4.4.643.g7cb9b.dirty
