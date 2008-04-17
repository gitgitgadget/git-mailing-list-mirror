From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Reporting bugs and bisection
Date: Thu, 17 Apr 2008 09:50:13 -0400
Message-ID: <20080417135013.GA2017@fieldses.org>
References: <20080414043939.GA6862@1wt.eu> <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au> <4804765B.2070300@davidnewall.com> <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com> <20080416132634.GA545@cs181133002.pp.htv.fi> <20080416120247.c665859c.akpm@linux-foundation.org> <20080416195503.GR1677@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, sverre@rabbelier.nl,
	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	jmorris@namei.org, viro@zeniv.linux.org.uk, w@1wt.eu,
	david@lang.hm, sclark46@earthlink.net, johnpol@2ka.mipt.ru,
	rjw@sisk.pl, tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	davem@davemloft.net, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org,
	davidn@davidnewall.com
To: Adrian Bunk <bunk@kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760119AbYDQNwt@vger.kernel.org Thu Apr 17 16:06:50 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760119AbYDQNwt@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmUYe-00060F-8j
	for glk-linux-kernel-3@gmane.org; Thu, 17 Apr 2008 15:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760119AbYDQNwt (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 17 Apr 2008 09:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbYDQNwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2008 09:52:33 -0400
Received: from mail.fieldses.org ([66.93.2.214]:50334 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbYDQNwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2008 09:52:31 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JmUVB-0000k4-5u; Thu, 17 Apr 2008 09:50:13 -0400
Content-Disposition: inline
In-Reply-To: <20080416195503.GR1677@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79791>

On Wed, Apr 16, 2008 at 10:55:03PM +0300, Adrian Bunk wrote:
> On Wed, Apr 16, 2008 at 12:02:47PM -0700, Andrew Morton wrote:
> > On Wed, 16 Apr 2008 16:26:34 +0300
> > Adrian Bunk <bunk@kernel.org> wrote:
> > 
> > > On Wed, Apr 16, 2008 at 02:15:22PM +0200, Sverre Rabbelier wrote:
> > > > I'm not subscribed to the kernel mailing list, so please include me in
> > > > the cc if you don't reply to the git list (which I am subscribed to).
> > > > 
> > > > Git is participating in Google Summer of Code this year and I've
> > > > proposed to write a 'git statistics' command. This command would allow
> > > > the user to gather data about a repository, ranging from "how active
> > > > is dev x" to "what did x work on in the last 3 weeks". It's main
> > > > feature however, would be an algorithm that ranks commits as being
> > > > either 'buggy', 'bugfix' or 'enhancement'. (There are several clues
> > > > that can aid in determining this, a commit msg along the lines of
> > > > "fixes ..." being the most obvious.)
> > > >...
> > 
> > Sounds like an interesting project.
> > 
> > > At least with the data we have currently in git it's impossible to 
> > > figure that out automatically.
> > > 
> > > E.g. if you look at commit f743d04dcfbeda7439b78802d35305781999aa11 
> > > (ide/legacy/q40ide.c: add MODULE_LICENSE), how could you determine 
> > > automatically that it is a bugfix, and the commit that introduced
> > > the bug?
> > > 
> > > You can always get some data, but if you want to get usable statistics 
> > > you need explicit tags in the commits, not some algorithm that tries 
> > > to guess.
> > 
> > Well yes.  One outcome of the project would be to tell us what changes we'd
> > need to make to our processes to make such data gathering more effective.
> > 
> > Of course, we may not actually implement such changes.  That would depend
> > upon how useful the output is to us.
> 
> That you can add this information through tags is clear, but according
> to his SoC application that's not what he wants to do.
> 
> According to his application he wants to determine automatically whether 
> a commit was a fix or whether a commit introduced a bug by doing stuff 
> like tracking whether a changed line was modified again shortly after a 
> commit.
> 
> This plan of him will simply not result in accurate numbers.

They won't be completely accurate, but who knows, maybe they'd turn out
to have a higher rate of accuracy than we'd expect.  (I assume you could
do a closer manual study of a small random sample of the results to
estimate the accuracy.)  Seems worth a try.

> Sure, you will get some numbers, but if anyone would e.g. wrongly accuse 
> me that 2% of my commits last year introduced bugs I would get 
> ***really*** angry.

It's just an experiment; reasonable people won't take it as the final
word.

--b.
