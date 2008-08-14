From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: does anything like cvs export exist in git?
Date: Thu, 14 Aug 2008 15:12:21 -0700
Message-ID: <20080814221221.GT3782@spearce.org>
References: <20080814212654.GS3782@spearce.org> <52593.49180.qm@web27802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:13:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTl4Z-0007iD-9R
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbYHNWMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbYHNWMX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:12:23 -0400
Received: from george.spearce.org ([209.20.77.23]:38211 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYHNWMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:12:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 72F0038375; Thu, 14 Aug 2008 22:12:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <52593.49180.qm@web27802.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92416>

Mark Struberg <struberg@yahoo.de> wrote:
> Since maven-scm should run under various OS (including Windoof)
> the tar thingy will not work out.

OK.  Maven could also consider using JGit, since its pure Java
and thus just as portable as the JRE is.

> The second approach is close to my original attempt to simply
> clone + checkout + rm -rf .git, isn't?.

Yes, but relies on a few plumbing level tricks to avoid the time
consuming aspects of a clone.

> At least I now know that it's really unlikely that this
> functionality does exist yet.

Its not implemented for a reason; we suggest to users to use
git-archive when they need to export a tree outside of Git.
 
> --- Shawn O. Pearce <spearce@spearce.org> schrieb am Do, 14.8.2008:
> > Von: Shawn O. Pearce <spearce@spearce.org>
> > Betreff: Re: does anything like cvs export exist in git?
> > An: "Mark Struberg" <struberg@yahoo.de>
> > CC: git@vger.kernel.org
> > Datum: Donnerstag, 14. August 2008, 23:26
> > Mark Struberg <struberg@yahoo.de> wrote:
> > > I'm the initial author of the Apache
> > maven-scm-providers-git and
> > > I need to update our SCM-Matrix.
> > > 
> > > This is just for making sure I did not oversee
> > anything.
> > > 
> > > I didn't came across anything like 'cvs
> > export' and I do not
> > > think git really needs this, since it doesn't
> > pollute the working
> > > directories with lots of waste like CVS and SVN does.
> > > 
> > > But I just want to make sure to not build workarounds
> > in our
> > > scm-provider (checkout + afterwards blasting the
> > GIT_DIR) for things
> > > that do exist natively in git.
> > 
> > You can use:
> > 
> >   git archive --tar HEAD | (mkdir ../dest;cd ../dest;tar xf
> > -)
> > 
> > Or you can do something even more bizzare like:
> > 
> >   export GIT_INDEX_FILE=/tmp/$$.index;
> >   export GIT_WORK_TREE=../dest;
> >   export GIT_DIR=.git;
> >   git read-tree HEAD &&
> >   git checkout-index --force --all &&
> >   rm $GIT_INDEX_FILE

-- 
Shawn.
