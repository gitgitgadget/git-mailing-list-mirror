From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Secure central repositories by UNIX socket
 authentication
Date: Sun, 27 Jan 2008 14:04:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801271402330.23907@racer.site>
References: <20080127103934.GA2735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 15:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ88K-0000TW-1D
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 15:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYA0OEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 09:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbYA0OEn
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 09:04:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:55983 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753198AbYA0OEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 09:04:43 -0500
Received: (qmail invoked by alias); 27 Jan 2008 14:04:41 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 27 Jan 2008 15:04:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nzGcfbHQn0CGpOb0v02xkNxeP1/mAm+GFe9JXSC
	Q63WjCDDQptNMz
X-X-Sender: gene099@racer.site
In-Reply-To: <20080127103934.GA2735@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71814>

Hi,

On Sun, 27 Jan 2008, Shawn O. Pearce wrote:

>     ## Owner (not jdoe)
>     ##
>   cat >foo.git/hooks/update <<'EOF'
>   #!/bin/sh
>   test -z "$GIT_REMOTE_USER" || exit
>   case "$GIT_REMOTE_USER" in
>   jdoe)     exit 0;;
>   spearce)  exit 0;;
>   *)        exit 1
>   esac
>   EOF
>   chmod u+x foo.git/hooks/update
>   chmod 700 foo.git
> 
>   git daemon \
>       --export-all \
>       --enable=receive-pack \
>       --base=`pwd` \
>       --listen=/tmp/shawn-git
> 
>     ## Other User
>     ##
>   git push jdoe@server:/tmp/shawn-git/foo.git master

I probably miss something, but if you already go through SSH, the $USER is 
set appropriately, no?

So you could do without git-daemon entirely, and replace the 
GIT_REMOTE_USER variable in the hook by USER.

Ciao,
Dscho
