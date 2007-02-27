From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Tue, 27 Feb 2007 16:46:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271624000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070226121557.GA18114@coredump.intra.peff.net>
 <20070226143142.GA1390@spearce.org> <Pine.LNX.4.63.0702261736570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6scj9qt.fsf@assigned-by-dhcp.cox.net> <20070227081933.GA13021@coredump.intra.peff.net>
 <7virdnhpbt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 16:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4XE-0007cc-RJ
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXB0Pqa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbXB0Pqa
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:46:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:38762 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751650AbXB0Pq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:46:29 -0500
Received: (qmail invoked by alias); 27 Feb 2007 15:46:28 -0000
X-Provags-ID: V01U2FsdGVkX1/swEREQw3s8NWNrJxG2Qg0rxWdCm91YYD1tGBc6x
	BJqQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7virdnhpbt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40750>

Hi,

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Feb 27, 2007 at 12:16:42AM -0800, Junio C Hamano wrote:
> >
> >> But as Shawn pointed out, Octopus makes bisect less (much less)
> >> efficient for the end users, I tend to think the current 16 is
> >> already insanely large.
> >
> > Did you look at my "why I need a huge octopus" description? Is there a 
> > better way to do it? Should I simply do a bunch of pair-wise merges? 
> > I'll almost certainly never bisect it,...
> 
> I hate having to compose this message because I know I will end up 
> saying negative things without offering anything constructive.

IMHO this discussion is anything but not constructive.

> I do not think bundling commits from unrelated multiple projects in one 
> commit (some people seem to have called this Hydra in the past) is a 
> good practice, regardless of size.

Yesterday, I kicked an idea around on IRC with Sam: Darcs does not have 
branches as we do. Sam was nice enough to show me a picture:

	http://utsl.gen.nz/git/hydra-vs-regular.png

For those poor souls stuck with a text terminal, it looks like this:

Right image:

A-B-C-D-E-F-G-H-I-J-K-L-M-N-O-P-Q-R-S-T-U-V-W-X-Y-Z-a-b-c-d-e

Left image:

A-B---------------------------------------------------------e
                                                            |
    C     F-G-H-I------------------------------------------/|
    |\    |                                                 |
    |  ---+-_   --J----------------------------------------/|
     \   /   --/                                            |
      D-E      \----K--------------------------------------/|
         \         \_                                       |
          \          -L------------------------------------/|
           \                                                |
            \           M----------------------------------/|
             \                                              |
              \               P-----_           Y----------/|
               \              |      \         /            |
                --------------+-------T-U-V-W-X---Z---b-c--/|
                             /        |  \           /     /
                          N-O   Q----/|   ----------a     d
                             \        |
                              ----R--/|
                                     /
                                    S

(Puh! Can you believe how much time such a picture takes?)

So, the right image is what it would look like of you just committed 
everything with Git, and the left image how it would look like with Darcs.

Now, I never have worked with Darcs, but I _could_ imagine that it would 
be useful for some workflows to generate the Darcs layout automatically 
from the Git layout. In that case, a _lot_ of parents should be allowed.

Ciao,
Dscho
