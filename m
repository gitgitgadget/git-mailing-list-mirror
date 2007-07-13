From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git fetch inside a bare repo does nothing
Date: Fri, 13 Jul 2007 13:54:26 +0200
Message-ID: <20070713115426.GA4608@xp.machine.xx>
References: <20070713103303.GD18199@xp.machine.xx> <20070713113209.GA9046@prefect.vdbonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: CJ van den Berg <cj@vdbonline.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 13:53:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Ji1-0005mp-Ra
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 13:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbXGMLxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 07:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755830AbXGMLxN
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 07:53:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:53281 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755009AbXGMLxM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 07:53:12 -0400
Received: (qmail invoked by alias); 13 Jul 2007 11:53:10 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp046) with SMTP; 13 Jul 2007 13:53:10 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX188bP0GPVg8XGVN59HDK4+5bzKeV8hcgolWsbaGHT
	8kjShq4Mm7mWd0
Mail-Followup-To: CJ van den Berg <cj@vdbonline.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070713113209.GA9046@prefect.vdbonline.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52386>

On Fri, Jul 13, 2007 at 01:32:10PM +0200, CJ van den Berg wrote:
> On Fri, Jul 13, 2007 at 12:33:03PM +0200, Peter Baumann wrote:
> > kblin on IRC wanted to know how to update a bare repo with fetching.
> > He wants to have a bare repo of samba as a mirror and clone from this
> > mirror to avoid network traffic and to have several git repos which
> > could all have a different branch checked out. For a better description
> > see [1].
> > 
> > I suggested to use "git fetch --bare" inside the bare repo, but this
> > doesn't work. So what I'm asking now if this is intenional behaviour or
> > a bug, so please could someone  shed some light on it?  Or how is the
> > prefered method to update a bare repo *without* pushing to it?
> 
> "git fetch" works fine in a bare repo. The issue you're probably having is
> that "git clone --bare" does not add a [remote "origin"] section to the
> config file like regular "git clone" does, so "git fetch" has nothing to
> do. Just add a remote section (either with "git remote add" or manually) and
> regular "git fetch" will work fine.
> 
> Just for reference, this is the remote section that is equivalent to the
> original "git clone --bare your_uri_here":
> 
> [remote "origin"]
>         url = your_uri_here
>         fetch = +refs/heads/*:refs/heads/*
> 
> 
Thx. This wasn't exactly my problem but it lead me to the real problem:
I used
	git fetch /path/to/repo master

and had forgotten that I had to specify the local ref, too.

	git fetch /path/to/repo master:master

worked as expected. Sorry for the noise.

-Peter
