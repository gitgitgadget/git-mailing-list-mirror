From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Weirdness with port-update hook and local push
Date: Mon, 5 Dec 2005 20:12:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512051945330.25300@iabervon.org>
References: <Pine.LNX.4.64.0512051530560.25300@iabervon.org>
 <Pine.LNX.4.63.0512052138560.6554@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0512051651050.25300@iabervon.org>
 <Pine.LNX.4.63.0512052318290.3406@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 02:13:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjRMr-0004fN-1c
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 02:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVLFBLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 20:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVLFBLh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 20:11:37 -0500
Received: from iabervon.org ([66.92.72.58]:62737 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964880AbVLFBLh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 20:11:37 -0500
Received: (qmail 439 invoked by uid 1000); 5 Dec 2005 20:12:16 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Dec 2005 20:12:16 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512052318290.3406@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13246>

On Mon, 5 Dec 2005, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 5 Dec 2005, Daniel Barkalow wrote:
> 
> > I think it's an environment thing of some sort, most likely, but it can't 
> > be the user; nothing's setuid and I'm only one user.
> 
> Can you insert "env > /tmp/env.$$.out", execute both without and with ssh, 
> and compare?

Actually, "ls -l /proc/$$/fd" shows that stdin and stdout are sockets with 
ssh, pipes with local, and ttys when just running the script. 

The hooks probably ought to be run with something different for 
stdin/stdout than the connection to the source of the data. /dev/null, 
maybe? Or a log file? Maybe dup stderr, which still seems to be going to 
the pusher's terminal?

	-Daniel
*This .sig left intentionally blank*
