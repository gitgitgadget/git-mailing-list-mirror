From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Fri, 5 Jan 2007 16:22:35 -0800 (PST)
Message-ID: <594263.16987.qm@web31811.mail.mud.yahoo.com>
References: <7vvejlcb6z.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 01:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2zKp-0004V1-So
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 01:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbXAFAWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 19:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbXAFAWh
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 19:22:37 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:39209 "HELO
	web31811.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751008AbXAFAWg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 19:22:36 -0500
Received: (qmail 17195 invoked by uid 60001); 6 Jan 2007 00:22:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=tDfDXg9leTnkquV/5yf/SlYAdkmJX53NLCsSJAVERk9YRBRQ1UkCfjsNPXUwobPPu0HkqMHQ2A/3Ig5eplRIx4fieZ1vsOb+1ge3Mm30lHkN9mRpfM39O7gLQeZujtwPkTdxJFo4yiSGxyjaOrrl806HhXx1bLabSASnwcCd1Wg=;
X-YMail-OSG: p6g9YxkVM1mVXmahcO77GETsUBBfeh4pksO8zv9fsRW4w7RJ037g44EWflSeeRus4yYE5vQ0ERd4EJrQNudTb3ZgwqAZ9lwd0t8g8g7i5F9a6LuqB2xQgdxyvvTE6U1JOsnLwO3xqGRQo3D1MYn4oj1xbN.M2DntWJGHLU0xW2n8kCfevHicyh0Z
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Fri, 05 Jan 2007 16:22:35 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvejlcb6z.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36058>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > --- Junio C Hamano <junkio@cox.net> wrote:
> >> 
> >> Because [remote] is NOT about mapping.  It asks the fetch
> >> mechanism to fetch from that remote, so the primary thing you
> >> should look at is .url, not RHS of colon on .fetch lines.  Use
> >> of tracking branches is strictly optional.
> >
> > Remote
> > ------
> >
> > Please help me understand.  Here is a sample remote from
> > an actual repo (actual names changed):
> >
> > [remote "origin"]
> >         url = http://blah/bleah.git
> >         fetch = +refs/heads/*:refs/remotes/origin/*
> >
> > This basically says: "Get it" from such and such url, where
> > on the repo at that url, i.e. the remote side, you will
> > find stuff in "refs/heads/", and when you get it here, locally,
> > put it in refs/remotes/origin/.
> 
>         [remote "origin"]
>                 url = http://blah/blah.git
>                 fetch = refs/heads/master
> 
> is also fine.  The point is that you do not have to use tracking
> branches.  ", and when you get it here, ..." part is optional.

Ok. So then in this case "fetch = refs/heads/master" describes
.git/refs/heads/master or something else?

If it does, then this is a local map.

I guess this is the case where one wants to automate
"git-pull . OtherBranch", but shouldn't this be handled
by [branch], i.e. the "merge" part of [branch].

> > Branch
> > ------
> >
> > Here is an actual example:
> >
> > [branch "branchA"]
> >         remote = origin
> >         merge = refs/heads/branchA
> >
> > Yeah, but by default "refs/heads/branchA" doesn't exist (see
> > my previous email).  It doesn't have to, since it specifies
> > the "remote part", but that has already been handled by
> > "[remote]".
> 
> Obviously fetch needs to handle the remote part because that is
> the only name it exists at the remote.  branch.*.merge is used
> by pull, not fetch, and fetch communicates with pull by using
> the remote name, because use of local tracking branches is
> optional.

Does this mean that "fetch = <remote>:" is legal?  Shouldn't the
RHS always exist?  Is the RHS of "fetch = :" what you mean
by local tracking branches?

    Luben
