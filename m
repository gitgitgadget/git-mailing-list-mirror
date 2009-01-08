From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Thu, 8 Jan 2009 12:23:04 +0300
Organization: St.Petersburg State University
Message-ID: <20090108092304.GA4835@roro3>
References: <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3> <36ca99e90901070624p2c102f3ey392ef813db9f9187@mail.gmail.com> <cover.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3> <200901071324.57222.trast@student.ethz.ch> <20090107220027.GA4946@roro3> <20090108020650.GC7345@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Jan 08 10:23:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKr6d-0007bN-9k
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 10:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbZAHJVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 04:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbZAHJVv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 04:21:51 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1212 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbZAHJVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 04:21:50 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 37B1617B65E; Thu,  8 Jan 2009 12:21:48 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LKr6W-0004kQ-81; Thu, 08 Jan 2009 12:23:04 +0300
Content-Disposition: inline
In-Reply-To: <20090108020650.GC7345@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104905>

On Thu, Jan 08, 2009 at 03:06:50PM +1300, martin f krafft wrote:
> also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.08.1100 +1300]:
> > > So I suppose you could use
> > > 
> > >   ${GIT_PAGER-${PAGER-less}}
> > > 
> > > or similar.
> > 
> > Good eyes, thanks!
> > 
> > I'll rework it.
> 
> I am not 100% on this, but I think nested {}'s are a bashism.

It seems to be ok:

kirr@roro3:~$ dash 
$ unset GIT_PAGER
$ unset PAGER
$ echo ${GIT_PAGER-${PAGER-less}}
less
$ PAGER=more
$ echo ${GIT_PAGER-${PAGER-less}}
more
$ GIT_PAGER=''
$ echo ${GIT_PAGER-${PAGER-less}}

$ GIT_PAGER=/bin/cat
$ echo ${GIT_PAGER-${PAGER-less}}
/bin/cat


> > On Wed, Jan 07, 2009 at 03:24:02PM +0100, Bert Wesarg wrote:
> > > On Wed, Jan 7, 2009 at 12:27, Kirill Smelkov <kirr@landau.phys.spbu.ru> wrote:
> > > > Martin, thanks for your review.
> > > > +       # atexit(close(1); wait pager)
> > > > +       trap "exec >&-; rm "$_pager_fifo"; rmdir "$_pager_fifo_dir"; wait" EXIT
> > > I think you need to escape the double quotes.
> > 
> > Good eyes -- corrected and thanks!
> 
> You could also just use single quotes inside the double quotes.

Thanks for the tip - I'll keep it in mind. Or is it the preferred way?


Thanks,
Kirill
