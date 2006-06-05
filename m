From: Alec Warner <antarus@gentoo.org>
Subject: Re: irc usage..
Date: Sun, 04 Jun 2006 22:36:44 -0400
Organization: Gentoo
Message-ID: <448398BC.5090402@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>	 <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>	 <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>	 <447D043D.1020609@gentoo.org>	 <46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>	 <447DA028.3040606@gentoo.org>	 <46a038f90605311503o1526c664qe61b0f3f40929b92@mail.gmail.com>	 <447E4611.7000309@gentoo.org>	 <46a038f90606010047r676840d2nd91ad2361abbe1c8@mail.gmail.com>	 <44837BDB.2090601@gentoo.org> <46a038f90606041906k66d85152v6e402c65151d7ab8@mail.gmail.com>
Reply-To: antarus@gentoo.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Donnie Berkholz <spyderous@gentoo.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 05 04:37:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn4xx-0004Q7-OL
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 04:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWFECg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 22:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWFECg7
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 22:36:59 -0400
Received: from jeeves.egr.msu.edu ([35.9.37.127]:22720 "EHLO egr.msu.edu")
	by vger.kernel.org with ESMTP id S932387AbWFECg6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 22:36:58 -0400
Received: from [69.176.143.70] (69-176-143-70.dov.spartan-net.net [69.176.143.70])
	(authenticated bits=0)
	by egr.msu.edu (8.13.6/8.13.4) with ESMTP id k552aPAN027002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 22:36:26 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060528)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606041906k66d85152v6e402c65151d7ab8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21308>

Martin Langhoff wrote:
> On 6/5/06, Alec Warner <antarus@gentoo.org> wrote:
> 
>> Ok the box this was running on had issues, so I switched to using
>> pearl.amd64.dev.gentoo.org, a dual core amd64 X2 4600+ with 4 gigs of
>> ram and plenty of disk.  The "problem" now is just converstion time...30
>> hours and I'm into 2004-09-17...but it's been in 2004 all day, seems
>> like most of the commits are in the last three years.  Are there
>> architectural issues with doing this in parallel?
> 
> 
> I don't think you can do this in parallel. What I would do is remove
> the -a from the git-repack invocation. It does hurt import times quite
> a bit -- just do a git-repack -a -d when it's done.

Only repack at the end then? disk space isn't an issue here so I'll give 
that a shot.

> 
> And... having said that, there is still a memory leak somehow,
> somewhere. It's been evading me for 2 weeks now, so I feel an idiot
> now. Not too bad in general, but it shows clearly in the gentoo and
> mozilla imports.

30565 antarus   17   0  470m 456m 1640 S   14 11.6 234:23.38
git-cvsimport
30566 antarus   16   0 6753m 147m  752 S    7  3.7 120:27.06 cvs

I'm on cvs-1.11.12 and the git version of git

> You are forced to do it in a sequence because cvsps only tells you
> about the files added/removed/changed in a commit -- you need the
> ancestor to have a view of what the whole tree looked like. The only
> room for parallelism I see is to fork off new processes to work on
> branches in parallel.

Not helpful in the Gentoo case, since we only have one branch; minus an 
accident when a dev branched gentoo-x86 a while back ;)

I'll keep chugging on this one; it won't be the final import as I 
haven't used the complete Authors file, so I will try the repacking 
optimization next time I do an import.

-Alec Warner
