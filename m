From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Automatically line wrap long commit messages.
Date: Mon, 29 May 2006 05:46:05 -0400
Message-ID: <20060529094605.GB27194@spearce.org>
References: <20060529085738.GB29500@spearce.org> <7virnp8a30.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 11:46:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkeKD-0001UF-FD
	for gcvg-git@gmane.org; Mon, 29 May 2006 11:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWE2JqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 05:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWE2JqK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 05:46:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8862 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750778AbWE2JqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 05:46:09 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FkeK4-0001NL-Pb; Mon, 29 May 2006 05:46:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 66C1E20E445; Mon, 29 May 2006 05:46:05 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virnp8a30.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20941>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > When using -m on the command line with git-commit it is not uncommon
> > for a long commit message to be entered without line terminators.
> > This creates commit objects whose messages are not readable in
> > 'git log' as the line runs off the screen.
> >
> > So instead reformat log messages if they are supplied on the
> > command line.
> >
> > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> > ---
> >  This one might cause some problems for people.
> 
> I am already moderately negative on multiple -m so in the light
> of it this one looks totally unneeded.  You could do a number of
> things:
[snip]

OK.  Ignore both patches then.  Two negative votes in such a short
time suggests they are probably not generally accepted.  ;-)

> We probably should allow "commit -F -" to read from the standard
> input if we already don't, but that is about as far as I am
> willing to go at this moment.

We do.  So apparently the solution to my usage issue is:

	$ fmt -w 60 | git commit -F-
	This is my message.

	This is the body.  Etc....
	EOF

I'm thinking that's too much work for me.  Which means either I
learn to format my messages better in a single -m switch (as was
already suggested) or I just deal with git-commit popping open
$EDITOR anytime I want to commit something.  In which case then I
might as well also get a diff of what I am about to commit as part
of the temp file buffer.

Or I create my own little wrapper shell script which calls fmt.
Hmm, maybe that would be useful with alias and a promise to not
use ci as a core GIT command name:

	[alias "ci"]
		command=shawns-commit-wrapper

-- 
Shawn.
