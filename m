From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: git rev-list ordering
Date: Sun, 16 Nov 2008 20:21:40 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811162001550.28544@sys-0.hiltweb.site>
References: <alpine.LFD.2.00.0811151922310.2935@sys-0.hiltweb.site> <bd6139dc0811151727k605a3575hf409fed32a3a4baf@mail.gmail.com> <alpine.LFD.2.00.0811152040570.2935@sys-0.hiltweb.site> <alpine.DEB.1.00.0811162215370.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 17 02:23:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1spc-0002hq-SX
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 02:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYKQBV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 20:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbYKQBV4
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 20:21:56 -0500
Received: from mail.gmx.com ([74.208.5.67]:49214 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754085AbYKQBV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 20:21:56 -0500
Received: (qmail invoked by alias); 17 Nov 2008 01:21:53 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us002) with SMTP; 16 Nov 2008 20:21:53 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX19ljLQIhPllMDNSrMQvJlCYoulM3L81YxtTezU/sx
	2ri7xkOHoqNTJp
In-Reply-To: <alpine.DEB.1.00.0811162215370.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101189>

On Sun, 16 Nov 2008, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 15 Nov 2008, Ian Hilt wrote:
> 
> > On Sat, 15 Nov 2008, Sverre Rabbelier wrote:
> > > The --reverse is applied after the --max-count, so you are seeing the 
> > > reverse of one commit ;). For comparison, have a look at:
> > > 
> > > $ git rev-list --reverse --max-count=2
> > 
> > Ah, I see.  So if you didn't want the sorting to take a long time for 
> > many commits, you would limit the output to n commits, then sort the 
> > output.  Is this the logic behind this design?
> 
> Yes.  It is by design, since the guy who wrote the initial --reverse 
> support cannot think of an interesting situation where you need to list 
> the oldest n commits.

I see.  Well, the situation in which I found this to be needed was while 
trying to figure out how to find the next commit on branch X while on a 
detached head from that branch without counting how many commits back I 
was.  In other words,

$ git checkout X~4
$ # now I want X~3 without using a number or carets
$ git checkout $(git rev-list --reverse ..X | head -1)
 -- or --
$ git checkout $(git rev-list ..X | tail -1)

So maybe there's a better way to do this.  I don't know.  If the commits
were reversed _then_ limited I wouldn't need to use the pipe to
head/tail.  Not that that is a problem, it just seemed like it should
work with reverse and max-count.
