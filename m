From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Automatically line wrap long commit messages.
Date: Tue, 30 May 2006 22:18:08 -0400
Message-ID: <20060531021808.GC21222@spearce.org>
References: <20060529085738.GB29500@spearce.org> <7virnp8a30.fsf@assigned-by-dhcp.cox.net> <20060529094605.GB27194@spearce.org> <7vhd373o15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 04:18:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlGHv-0008UA-2X
	for gcvg-git@gmane.org; Wed, 31 May 2006 04:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWEaCSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 22:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWEaCSN
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 22:18:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52929 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751534AbWEaCSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 22:18:12 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FlGHX-0007zj-Bw; Tue, 30 May 2006 22:17:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 217B420E445; Tue, 30 May 2006 22:18:08 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd373o15.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21054>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > OK.  Ignore both patches then.  Two negative votes in such a short
> > time suggests they are probably not generally accepted.  ;-)
> >
> >> We probably should allow "commit -F -" to read from the standard
> >> input if we already don't, but that is about as far as I am
> >> willing to go at this moment.
> >
> > We do.  So apparently the solution to my usage issue is:
> >
> > 	$ fmt -w 60 | git commit -F-
> > 	This is my message.
> >
> > 	This is the body.  Etc....
> > 	EOF
> >
> > I'm thinking that's too much work for me.
> 
> If we supported multiple -m (presumably each becomes a single line?)
> with internal fmt, I do not see how it would become less work.
> 
> 	$ git commit -w60 -m "This is my message." \
>         	-m '' \
>         	-m 'This is the body.  Etc....'
> 
> looks more typing to me, even without the second line to force
> the empty line between the summary and the body.

Actually I was thinking each -m would be its own paragraph so blank
lines would split each -m and maybe the -w60 should be a config
option in .git/config or .gitrc so it doesn't always need to be
supplied on the command line.

Personally I want blank lines between each -m and to always run
the message through fmt.  Others may want to run their commit
messages through other filters so maybe the filter itself is just
a config value which gets executed:

	[user]
		commitMessageFilter = fmt -w 60

or someone else might set:

	[user]
		commitMessageFilter = /home/user/bin/my-filter

where the filter accepts the message on STDIN and writes (the maybe
changed) message on STDOUT.

-- 
Shawn.
