From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 28 Jan 2007 23:41:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701282321390.3021@xanadu.home>
References: <7vps90lvoh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701271415280.3021@xanadu.home>
 <7vhcuci0z0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701272049480.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 05:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBOKU-000827-Jv
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 05:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbXA2ElJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 23:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbXA2ElJ
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 23:41:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56780 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173AbXA2ElI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 23:41:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCM004BU50HOOD0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 28 Jan 2007 23:41:05 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0701272049480.3021@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38062>

On Sat, 27 Jan 2007, Nicolas Pitre wrote:

> On Sat, 27 Jan 2007, Junio C Hamano wrote:
> 
> > My understanding of the situation after your patch (disregarding
> > the problem that prune and friends may happily break the logs
> > for detached HEAD), is that if you say "git show HEAD@{...}",
> > while on a branch, it looks at the log of the current branch but
> > while on a detached HEAD it shows the log from .git/logs/HEAD.
> > I have a feeling that this would be confusing.  
> 
> It would indeed.  But that's not exactly what's happening.

Well... It is a mess.  That's not what's happening for git-log 
obviously, but what you describe is indeed the case for git-rev-parse.

There needs to be a dwim_reflog() function that looks for a matching 
reflog file by itself instead of using dwim_ref() and simply prefixing 
the resolved ref with "logs/".  Unfortunately this tackling of reflog 
path built on top of resolve_ref() seems to be a popular assumption and 
chasing and fixing all those cases properly would require more time than 
I can spare right now.


Nicolas
