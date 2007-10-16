From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/5] Add a generic tree traversal to fetch SVN properties.
Date: Tue, 16 Oct 2007 02:55:03 -0700
Message-ID: <20071016095503.GB30503@soma>
References: <1192462506-3783-1-git-send-email-tsuna@lrde.epita.fr> <20071016074310.GA32254@soma> <07B09A42-73DD-4565-975F-A4E40BF862AC@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Oct 16 11:55:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihj93-0002C1-RA
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758562AbXJPJzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbXJPJzG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:55:06 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46506 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758562AbXJPJzE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:55:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A36657DC109;
	Tue, 16 Oct 2007 02:55:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <07B09A42-73DD-4565-975F-A4E40BF862AC@lrde.epita.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61131>

Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
> On Oct 16, 2007, at 9:43 AM, Eric Wong wrote:
> 
> >Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> >>	* git-svn.perl (&traverse_ignore): Remove.
> >>	(&prop_walk): New.
> >>	(&cmd_show_ignore): Use prop_walk.
> >>
> >>Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
> >
> >Although I myself have never needed this functionality, this series
> >looks pretty good in general.
> 
> I heavily script Git with my own wrappers and having this sort if  
> functionality does enhance the scriptability of git-svn.

Ah.  I've actually wanted something like `svn info` or `git-svn
rev-parse` myself for a while, but haven't gotten to implementing it
myself, either.  Something that could easily give me the current URL of
a repo, or the URL of any path in a repo

	$ git svn info --remote-url local/path.c
	=> https://example.com/svn/trunk/local/path.c

	$ git svn info --url
	=> https://example.com/svn/trunk

I think there was other functionality that I've wanted in the past
but have forgotten at the moment.  I need to sleep, badly :x

> >Thanks.
> 
> You're welcome :)
> 
> >
> >One comment below about property selection (whitelist vs blacklist).
> >
> >
> >It would be possible to get identical information out of  
> >unhandled.log,
> >but older repositories may not have complete information...  Maybe  
> >some
> >local option would be good for people with complete unhandled.log  
> >files;
> >but it could be really incomplete/insufficient.
> >
> 
> In order to avoid using SVN::Ra and avoid access to the SVN repo?   
> Hmm, clever, I didn't think about this.  Maybe we can provide both,  
> the default would check unhandled.log and an option would enable  
> direct access to the SVN repo?

Yes.  I'm alright with the direct SVN repo code for now, and we can do
unhandled.log later since it's more things to do.

> >Coding style
> >
> >Other than that, I prefer to keep braces on the same line as foreach,
> >if, else statements.  I generally follow the git and Linux coding
> >style for C in my Perl code.
> >
> >One exception that I make for Perl (but not C) is that I keep the "{"
> >for subs on the same line (since subs can be nested and anonymous ones
> >passed as arguments and such); unlike their C counterparts[1]
> 
> Indeed, sorry, I started correctly but then completely forgot to  
> follow the existing Coding Style.  The CS I use daily is totally  
> different, sorry ;)
> Shall I resend the patch series with corrected CS?

Yes, please.  Thanks.

-- 
Eric Wong
