From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [Census] So who uses git?
Date: Thu, 2 Feb 2006 10:12:26 +0100
Message-ID: <81b0412b0602020112l26f69728v11139ae84ea9b84f@mail.gmail.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <1138529385.9919.185.camel@evo.keithp.com>
	 <43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
	 <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
	 <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
	 <46a038f90601311852ie8cfac0rbe92779edea4da1b@mail.gmail.com>
	 <81b0412b0602010655i7b538bdck2baa216203279bce@mail.gmail.com>
	 <Pine.LNX.4.64.0602010815480.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Ray Lehtiniemi <rayl@mail.com>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 02 10:12:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4aW6-0004LC-Pl
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 10:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423387AbWBBJMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 04:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423393AbWBBJMc
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 04:12:32 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:16982 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423387AbWBBJMb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 04:12:31 -0500
Received: by uproxy.gmail.com with SMTP id s2so125293uge
        for <git@vger.kernel.org>; Thu, 02 Feb 2006 01:12:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FwPGuRN4WPX2mk6+7NkEHxiOYEIhx1dhy1KEGjQuVJi/x24TO9ZanGB/6sJ5cm8xSRpe5byVnoGc7r2CTIm1h51g1gNtSkkqqZAKPM1PitQRRprjrqPwZo4b4elqTgDXChCY6nt6we0FJ6zFgcGdl5OgodLw1qxGHtVJN863nbw=
Received: by 10.49.95.15 with SMTP id x15mr46726nfl;
        Thu, 02 Feb 2006 01:12:26 -0800 (PST)
Received: by 10.49.23.15 with HTTP; Thu, 2 Feb 2006 01:12:26 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602010815480.21884@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15499>

On 2/1/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > $ time git update-index --refresh
> >
> > real    0m21.500s
> > user    0m0.358s
> > sys     0m1.406s
> >
> > WinNT, NTFS, 13k files, hot cache.
>
> That's 25% less files than the Linux kernel, and I can do that operation
> in 0m0.062s (0.012s user, 0.048s system).

correction. It's 18k files, which is almost the same as 2.6.13-rc6. But these
files got *very* long names (the project poisoned by classical C++ education
and breaks windows' 255 chars limit on filename length from time to time).
Refresh index in 2.6.13 is actualy consistantly faster:

$ cd src/linux-2.6.13-rc6
$ time git update-index --refresh
real    0m1.344s
user    0m0.358s
sys     0m0.984s

> So WinNT/cygwin is about 2.5 _orders_of_maginitude_ slower here, or 340
> times slower.
>
> Now, I'm tempted to say that NT is a piece of sh*t, but the fact is, your
> CPU-times seem to indicate that most of it is IO (and the "real" cost is
> just 1.7 seconds, much of which is system time, which in turn itself is
> probably due to the IO costs too - so even that isn't comparable with
> the ).
>
> Which may mean that you simply don't have enough memory to cache the whole
> thing. Which may be NT sucking, of course ("we don't like to use more than
> 10% of memory for caches"), but it might also be a tunable (which is sucky
> in itself, of course), but finally, it might just be that you just don't
> have a ton of memory. I've got 2GB in my machines, although 1GB is plenty
> to cache the kernel.

I have 2Gb, the "System Cache" is around 1.5Gb, and this is PIV 3.2GHz.
There seem to be no tunables for any kind of system stuff
(savin' on support costs, do they?).
You'd be very hardpressed not to say that windows is a piece of sh*t.

The "benchmark: several times in a row:

$ time git update-index --refresh
real    0m1.766s
user    0m0.498s
sys     0m1.203s

$ time git update-index --refresh
real    0m1.766s
user    0m0.358s
sys     0m1.390s

$ time git update-index --refresh
real    0m1.781s
user    0m0.420s
sys     0m1.311s

$ time git update-index --refresh
real    0m1.875s
user    0m0.374s
sys     0m1.343s

$ time git update-index --refresh
real    0m1.766s
user    0m0.326s
sys     0m1.375s

It is always almost the same time. I don't think it's IO, looks more like
cache accesses. It is just that bad in this cygwin+win2k combination.
Besides, I don't trust "time <command>" on windows much: it returned
sys time 0 for git-update-index in a directory which was read before.
Yes, there was disk activity, I can hear it real good with that barrakuda.
