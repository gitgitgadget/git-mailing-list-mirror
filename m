From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Fri, 23 Nov 2007 01:01:28 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711230050270.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <fi5743$32p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Nov 23 02:01:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvMvX-0001Kx-0t
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 02:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbXKWBBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 20:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbXKWBBd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 20:01:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:54083 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751780AbXKWBBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 20:01:32 -0500
Received: (qmail invoked by alias); 23 Nov 2007 01:01:31 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp053) with SMTP; 23 Nov 2007 02:01:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18S0lElhuUS0hc2ke9uiZbWGVYXkx+YGY34F+BTXP
	Iwe1DSTjSvzWnr
X-X-Sender: gene099@racer.site
In-Reply-To: <fi5743$32p$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65865>

Hi,

[please Cc me when you reply to my message]

On Thu, 22 Nov 2007, Han-Wen Nienhuys wrote:

> This one seems to setup a dump of a single branch from the command line, 
> which then follows the commit structure.  Am I missing something?

Yes.  It should work with "--all", too.  In fact, with every rev-list 
parameters, even a..b (which would cut off the history up to -- and 
including -- a).

> The cool thing about git-fast-import is that it reads from stdin, has a 
> very easy to use programmatic interface, and does not impose any order 
> on how you enter the information.
> 
> This doesn't seem to be mirrored by this script? 

Umm.  What exactly do you want to reorder?  I mean, this program is meant 
to dump the complete contents to stdout (whether you redirect it to a file 
or edit it with sed does not concern this program).  It does that.

Maybe you want to specify if all blobs should be output first, and then 
the commits?  Or files should be used?  But all of these things seem to be 
useless to me.

So I am puzzled what you ask for.

> I am working on a script for [company] which uses git.  Git is a pain to 
> script for: for every query I need to invoke another git process, with 
> another command (log, show-ref, cat-file, show, etc.), parse another 
> output format and/or specify another --pretty=format:%blah format.

Now I am really puzzled.  Git is one of the most easily scriptable 
programs I ever saw.

It does not even force you to use certain combinations of scripting 
languages, such as Python, Scheme, C++ and PostScript, separated by which 
part of the program you want to script.

> Besides being a nuisance, I actually run git on NFS, and every git 
> process has to go to NFS a couple times to retrieve the same 
> information. This has a noticeable performance impact.

Why don't you just work on a local clone?  If it is really performance 
critical, and I/O is an issue, you are better off working in a tmpfs.

Once you're done, you push back to the NFS repository (which is 
lock-challenged AFAIR, but I guess you know that).

> It would make my life a lot easier if I could simply open a pipe to a 
> single process for the duration of the script, and do all my queries to 
> this one process.  Of course, if the repository is changed by another 
> process, I would have to restart it, but that's manageable.  I could 
> even write a nice Python class that runs both fast-import and 
> fast-export. I could then have an efficient Python interface to a 
> git-repository, without needing any library wrapping.

There is a minimal python wrapper to libgit-thin, which was one of our 
GSoC projects.  You might want to look at this if you are really that 
unhappy with the existing framework.

As to the niceness of Python classes; this lies definitely in the eyes of 
the beholder.  For example, I have given up on understanding any part of 
your GUB framework.

Ciao,
Dscho
