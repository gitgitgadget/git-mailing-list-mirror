From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Mon, 10 Jul 2006 20:15:05 -0400
Message-ID: <20060711001504.GA10700@spearce.org>
References: <20060710065751.22902.43316.stgit@dv.roinet.com> <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net> <20060710094653.GA52962@dspnet.fr.eu.org> <Pine.LNX.4.63.0607101306030.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060710114117.GA62514@dspnet.fr.eu.org> <44B2A709.8020500@serice.net> <20060710202412.GA8189@dspnet.fr.eu.org> <Pine.LNX.4.63.0607110049470.29667@wbgn013.biozentrum.uni-wuerzburg.de> <f36b08ee0607101625y6eaec83ck22dd20b4f27a1846@mail.gmail.com> <20060710235122.GB26528@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 02:17:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G05w3-0007i5-BJ
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 02:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWGKARB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 20:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWGKARB
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 20:17:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:31903 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751320AbWGKARA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 20:17:00 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G05uK-0005nl-LL; Mon, 10 Jul 2006 20:16:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8A66B20E43C; Mon, 10 Jul 2006 20:15:05 -0400 (EDT)
To: Olivier Galibert <galibert@pobox.com>
Content-Disposition: inline
In-Reply-To: <20060710235122.GB26528@dspnet.fr.eu.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23672>

Olivier Galibert <galibert@pobox.com> wrote:
> On Tue, Jul 11, 2006 at 02:25:44AM +0300, Yakov Lerner wrote:
> > I am writing in order to ask, whether there maybe
> > some c99-to-c89 source convertor that can be
> > automatically applied to the .c before compiling with
> > pre-c99 compiler ?
> 
> Comments are easy.  Moving declarations without breaking initializers
> is harder.  Rewriting the struct initializers is pretty much
> impossible without the tool turning into a full-blown C parser.
> 
> Maybe git can be perfectly happy with c89.  I don't know.  I know the
> linux kernel requires c99, mostly for the struct initializers.  My
> point was that staying at the c89 level has a maintainance cost, and a
> cost/benefit analysis should be done to decide whether it is a good
> idea.  Answering "get a C compiler", as is being done for some years
> now for people not wanting prototypes, is an option not to neglect.

GIT 1.2.3 had a lot more struct initializers than GIT 1.4.1 has.  So
apparently it was cleaner to remove a few of them in some cases then
it was to keep them in.  But that's besides the point.

I can understand the core maintainers not wanting to apply my patch
and lose the benefits of c99, and if I have to I'll carry a private
branch with that patch and hand-edit future versions as necessary
to get the same result...  but I'd hate to see another user have
to do the same work for the same reason.

I'm not a big contributor to GIT (I certainly don't contribute
nearly as much code as most others) and I'm also not a big user of
GIT (I don't develop for the Linux kernel) so I not expecting the
core to drop to c89 just for me and this old compiler.  :-)

After reading this thread I'm thinking that this probably shouldn't
get merged in and that I should carry the tweaks locally to get
GIT to build on the only compiler I have available on that system.
Now that GIT 1.4.1 is installed on there I'm unlikely to upgrade it
for at least 6 months, as I'm using only the very low level plumbing
(git-read-tree, git-write-tree, git-update-index, git-repack).
Remerging these c99 downgrades at that time shouldn't be a huge
issue for me since its probably going to be done so infrequently.

-- 
Shawn.
