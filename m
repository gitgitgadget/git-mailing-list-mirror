From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sat, 29 Sep 2007 01:49:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709290144310.28395@racer.site>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 02:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbQY7-0003cx-8q
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 02:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755795AbXI2AvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 20:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbXI2AvG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 20:51:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:38484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755795AbXI2AvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 20:51:05 -0400
Received: (qmail invoked by alias); 29 Sep 2007 00:51:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 29 Sep 2007 02:51:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HwTYHTfiH8a629r2MLX5dNhxB7VM3KPAkOmMbxG
	xc+EljWwuSavkk
X-X-Sender: gene099@racer.site
In-Reply-To: <20070929000056.GZ3099@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59436>

Hi,

On Fri, 28 Sep 2007, Shawn O. Pearce wrote:

> On Cygwin we have man, so `git help init` (or `git init --help`) work 
> just fine to display the manual entry.  No idea about the MSYS port.

We open the html pages.  That is, we don't yet, since we do not generate 
the html pages just yet; asciidoc is a Python program, and Python is not 
available as an MSys program as far as I know (and asciidoc insists on 
finding files in a Unix-like file structure, so we _do_ need an MSys 
Python).

... but all this would be easier if we succeeded in having a minimal 
asciidoc lookalike in git.git...

> >   * The output from a git-clone operating locally is really confusing:
> > 
> > 	$ git clone hello hello-clone
> > 	Initialized empty Git repository in /tmp/hello-clone/.git/
> > 	0 blocks
> > 
> >     Empty? Didn't I just clone it? What does "0 blocks" mean?
> 
> Yea.  That's because we realized its on the local disk and used
> `cpio` with hardlinks to copy the files.  So cpio says it copied
> 0 blocks as it actually just hardlinked everything for you.  No
> data was actually copied.
> 
> git-gui's new clone UI uses fancy progress meters here and tries
> to shield the user from "plumbing and UNIX tools" spitting out
> seemingly nonsense messages.  We probably should try harder in
> git-clone to do the same here.

AFAICT git-clone is a prime candidate for builtinification, after which 
issues like this should be easy to address.

> >   * git-log by default displays "Date" that is the author date, but
> >     also only uses committer date for options such as --since. This is
> >     confusing.
> 
> I've never thought about that.  But when you say it I think its very 
> obvious that it could be confusing to a new user.  Maybe we should show 
> the committer line and its date if it doesn't match the author 
> name/date.  Usually I don't care who committed a change in git.git (its 
> a very small handful of people that Junio pulls from directly) but at 
> day-job committer name is usually just as interesting as the author name 
> *when they aren't the same*.

--pretty=fuller

Ciao,
Dscho
