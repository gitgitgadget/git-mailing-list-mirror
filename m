From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Thu, 22 Nov 2007 22:27:46 -0200
Message-ID: <fi5743$32p$1@ger.gmane.org>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 01:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvMXL-0002il-Jn
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 01:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbXKWAgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 19:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXKWAgc
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 19:36:32 -0500
Received: from main.gmane.org ([80.91.229.2]:47229 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbXKWAgb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 19:36:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IvMUp-0007pV-HV
	for git@vger.kernel.org; Fri, 23 Nov 2007 00:34:15 +0000
Received: from c911de8c.bhz.virtua.com.br ([201.17.222.140])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 00:34:15 +0000
Received: from hanwen by c911de8c.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 00:34:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c911de8c.bhz.virtua.com.br
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <Pine.LNX.4.64.0711210336210.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65863>

Johannes Schindelin escreveu:
> [WIP: this does not handle tags yet, and it lacks a test script
>  as well as documentation.]
> 
> This program dumps (parts of) a git repository in the format that
> fast-import understands.
> 
> For clarity's sake, it does not use the 'inline' method of specifying
> blobs in the commits, but builds the blobs before building the commits.B
> 
> ---
> 	I am way too tired now to continue, but maybe someone else wants
> 	to pick up the ball.
> 
> 	Oh, and it relies on "int" being castable to void * and vice 
> 	versa.  Is anybody aware of a platform where this can lead to
> 	problems?
> 
> 	And yes, I will add a copyright when I woke up again.

This one seems to setup a dump of a single branch from the command
line, which then follows the commit structure.  Am I missing
something?

The cool thing about git-fast-import is that it reads from stdin, has
a very easy to use programmatic interface, and does not impose any
order on how you enter the information.

This doesn't seem to be mirrored by this script? 

I am working on a script for [company] which uses git.  Git is a pain
to script for: for every query I need to invoke another git process,
with another command (log, show-ref, cat-file, show, etc.), parse
another output format and/or specify another --pretty=format:%blah
format.

Besides being a nuisance, I actually run git on NFS, and every git
process has to go to NFS a couple times to retrieve the same
information. This has a noticeable performance impact.

It would make my life a lot easier if I could simply open a pipe to a
single process for the duration of the script, and do all my queries
to this one process.  Of course, if the repository is changed by
another process, I would have to restart it, but that's manageable.  I
could even write a nice Python class that runs both fast-import and
fast-export. I could then have an efficient Python interface to a
git-repository, without needing any library wrapping.

--
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
