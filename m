From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 19:20:09 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0602011909330.6498@beast.quantumfyre.co.uk>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <1138529385.9919.185.camel@evo.keithp.com> <43DCA495.9040301@gorzow.mm.pl>
 <20060130225107.GA3857@limbo.home> <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
 <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
 <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Ray Lehtiniemi <rayl@mail.com>, Alex Riesen <raa.lkml@gmail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 20:19:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4NVj-0003HQ-8X
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 20:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbWBATTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 14:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422887AbWBATTS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 14:19:18 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:27568 "EHLO
	neutron.quantumfyre.co.uk") by vger.kernel.org with ESMTP
	id S1422686AbWBATTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 14:19:17 -0500
Received: (qmail 7807 invoked by uid 103); 1 Feb 2006 19:19:03 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88/1263. spamassassin: 3.1.0. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.030848 secs); 01 Feb 2006 19:19:03 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 1 Feb 2006 19:19:03 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15432>

On Tue, 31 Jan 2006, Linus Torvalds wrote:

> Sounds like every single stat() will go out the wire. I forget what the
> Linux NFS client does, but I _think_ it has a metadata timeout that avoids
> this. But it might be as bad under NFS.
>
> Has anybody used git over NFS? If it's this bad (or even close to), I
> guess the "mark files as up-to-date in the index" approach is a really
> good idea..

As it happens, yes ... I can't say that I've noticed git being 
particularly slow, but then - I've not tried running git with a local 
repos ... ;)

using a recentish 2.6 kernel repos, directly on the server I get:

server: linux-2.6>time git update-index --refresh

real    0m0.067s
user    0m0.015s
sys     0m0.052s

then against the same repos over NFS, I get:

client: linux-2.6>time git update-index --refresh

real    0m1.578s
user    0m0.018s
sys     0m0.366s

and if I do it from the client again soon afterward I get:

client: linux-2.6>time git update-index --refresh

real    0m0.145s
user    0m0.012s
sys     0m0.118s

>
> Of course, the whole point of git is that you should keep your repository
> close, but sometimes NFS - or similar - is enforced upon you by other
> issues, like the fact that the powers-that-be want anonymous workstations
> and everybody should work with a home-directory automounted over NFS..
>

-- 
Julian

  ---
You know it's going to be a bad day when you want to put on the clothes
you wore home from the party and there aren't any.
