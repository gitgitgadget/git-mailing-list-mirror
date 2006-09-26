From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Clarified documentation of --exclude-per-directory.
Date: Tue, 26 Sep 2006 17:41:50 -0400
Message-ID: <20060926214150.GB8177@spearce.org>
References: <20060925155821.GC26844@spearce.org> <7v3baftdp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 23:42:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSKgg-0000Lf-1w
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 23:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWIZVly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 17:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWIZVly
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 17:41:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60622 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964827AbWIZVly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 17:41:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSKgQ-0002zg-TG; Tue, 26 Sep 2006 17:41:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9A63620FB28; Tue, 26 Sep 2006 17:41:50 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3baftdp0.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27826>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Tommi Virtanen noted on #git today that
> >
> >   git ls-files --exclude-per-directory
> >
> > doesn't appear to work as advertised by the documentation unless
> > --others is also used.  According to the current source code this
> > is the case as the --exclude-per-directory file isn't read unless
> > we are iterating over the working directory, which only happens
> > with --others.
> 
> I am puzzled by this problem description.
> 
> If we _were_ to read --exclude-per-directory file when we are
> not doing --others, what better behaviour would we get out of
> the command?
 
From what I was able to gather on #git Tommi was trying to do:

	mkdir foo ; cd foo ; git init-db
	echo foo >foo
	echo foo >ignore
	git add foo ignore
	git commit -a -m create
	rm *
	git ls-files --exclude-per-directory=ignore \
		| git checkout-index

and not see "foo" come back into the working directory.  I don't
know what circumstances lead him to want to create an exclude file
pattern on a per-directory basis for use with checkout-index but
that seems to be what he was trying to do.


I don't really see a problem with applying --exclude-per-directory
all of time (like we apply --exclude=.git/info/exclude all of
time), its just not what the code does today.  I just personally
don't need that and don't have the time to fix ls-files to do so.
So I took the shorter approach and updated the documentation. :)

-- 
Shawn.
