From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-filter-branch
Date: Thu, 9 Aug 2007 10:19:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708091018340.21857@racer.site>
References: <20070809063453.GA12602@glandium.org> <Pine.LNX.4.64.0708090954550.21857@racer.site>
 <20070809091550.GB20321@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 11:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ4Bz-0003Z4-Jq
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 11:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbXHIJUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 05:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934202AbXHIJUG
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 05:20:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:58228 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934770AbXHIJUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 05:20:04 -0400
Received: (qmail invoked by alias); 09 Aug 2007 09:20:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 09 Aug 2007 11:20:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ehhh/1J2e7uaQoG5vOVp/c497u/wxIbNw0ymyvK
	0M9Jz5zD7/HIaw
X-X-Sender: gene099@racer.site
In-Reply-To: <20070809091550.GB20321@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55437>

Hi,

On Thu, 9 Aug 2007, Mike Hommey wrote:

> On Thu, Aug 09, 2007 at 09:58:27AM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > On Thu, 9 Aug 2007, Mike Hommey wrote:
> > 
> > > What is supposed to be the usage() of git-fetch-branch ?
> > > 
> > > git-filter-branch itself says:
> > > git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]
> > 
> > This is an unfortunate left-over.  The syntax described in the 
> > documentation should be right.
> > 
> > > while the documentation doesn't explicitely talk about DESTBRANCH,
> > > expect in the form of an hypothetical /newbranch/, that you obviously
> > > don't give to the command line.
> > 
> > Hmm.  I don't have time to look into this now, but the syntax is this:
> > 
> > 	git filter-branch [<options>] [--] [<rev-options>]
> > 
> > Those refs that you give in the <rev-options> are rewritten.  AFAIR the 
> > old values of the refs (if different) are written to refs/original/*.
> 
> In the description in the manpage:
>    Lets you rewrite git revision history by creating a new branch from
>    your current branch, applying custom filters on each revision.
>    (...)
>    The command takes the new branch name as a mandatory argument and the
>    filters as optional arguments
> 
> And in example:
>    Now, you will get the rewritten history saved in the branch newbranch
>    (your current branch is left untouched).
> 
> I must say this is a feature that would actually be nice to have...

To compare with the old one?  Use reflogs:

	git filter-branch --some-option master
	git diff master@{1}..master

> > > And whereas git-filter-branch itself says there is such an argument,
> > > it actually doesn't take it, and doesn't seem to be hardwired to create
> > > a new branch instead of overwriting the current one.
> > > 
> > > So what is git-filter-branch supposed to be doing ?
> > 
> > To rewrite refs.
> > 
> > > As a side note, if it ever happens that git-filter-branch can create a
> > > new branch, it might be nice to have each commit on the branch to have
> > > the original commit as parent, as well as its branch parent, so that
> > > they are seen as merges.
> > 
> > No, this will not happen.  Filter-branch is meant to clean up branches, so 
> > it will rewrite the commits.  However, you might be able to hack something 
> > in a parent filter.
> 
> That would need the commit id for the original commit being treated at the
> time, which I don't think is available in parent filters...

IIRC the "map" function will handle that.

Ciao,
Dscho
