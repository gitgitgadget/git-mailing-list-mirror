From: David Mansfield <david@cobite.com>
Subject: Re: new cvsps version fixes issues for cvs2git
Date: Thu, 26 May 2005 00:35:07 -0400
Message-ID: <429551FB.60601@cobite.com>
References: <42954A6D.6020503@cobite.com> <Pine.LNX.4.58.0505252111580.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Thu May 26 06:34:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbA3x-0008Dw-Fy
	for gcvg-git@gmane.org; Thu, 26 May 2005 06:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVEZEf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 00:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVEZEf1
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 00:35:27 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:8110 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261198AbVEZEfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 00:35:18 -0400
Received: from [192.168.0.101] (cpe-66-65-159-236.nyc.res.rr.com [66.65.159.236])
	by ms-smtp-03.rdc-nyc.rr.com (8.12.10/8.12.7) with ESMTP id j4Q4ZCGi025306;
	Thu, 26 May 2005 00:35:12 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505252111580.2307@ppc970.osdl.org>
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


> 
> Since the CVS information doesn't contain any timezone, it would be bogus
> to use one, and the only sane git conversion is to always use UTC. Using 
> the timezone of the converter is also bogus, since that just makes 
> different converters get different results.

The cvs log is now properly handled as UTC.  It wasn't before.  That's 
one good thing.  And yes, git conversion better always be UTC, no 
argument here.

> 
> So I'd much rather see you add a flag that just always does the native CVS
> time (ie UTC)?  Quite frankly, it's wrong to do anything else, exactly
> because it makes no sense to print out dates in a timezone that has no
> relevance (what relevance does Pacitic time have for somebody who
> committed something at 8AM Eastern? _None_).

It will always print in the localtime of the user running cvsps, not the 
timezone of the commiter (in fact, we don't know the timezone of the 
committer at all).  I hate committing something, running cvsps and 
having it tell me I'm about to commit in five hours, but I *do* see your 
point.

> 
> The fact is, if we depend on people doign "TZ=UTC", people will forget, 
> and then people will have different conversions.

That's true, that would be terrible.  But I'm arguing that the actual 
conversion program (which actually wants machine readable output) should 
make it happen.  If that means we need a shell-script wrapper than 
so-be-it.  By letting cvsps display in any timezone, including UTC, it 
can work for everyone (keep the policy out of the program).

> (My personal preference would be to _default_ to UTC, and instead have a
> special flag that says "use localtime to print stuff out", since 
> localtime really is the least relevant one most of the time)
> 

The thing you may be missing (and, hey, why not?) is that some people 
will actually still be using cvs, and cvsps to them is a tool that 
produces output for humans.  For you, it is a stone in the path to git's 
domination of the world.

I'll have to think about it.  At the very least a flag requesting UTC, 
or a flag requesting localtime makes sense.  Setting environment 
variables and then running a program always seemed a bit like abuse of 
global variables.

David

