From: Jeff King <peff@peff.net>
Subject: Re: change symlink
Date: Wed, 31 Oct 2012 08:05:05 -0400
Message-ID: <20121031120505.GD30879@sigill.intra.peff.net>
References: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
 <m2mwz3odys.fsf@igel.home>
 <CAH_OBidWxkhG3o4C4OPP4OxyQQfw_fF_h4C9KR9AnoOZ27=9TQ@mail.gmail.com>
 <m2fw4vod81.fsf@igel.home>
 <CAH_OBifch3uuXYHQ1R9vS6xFu8LuY3mUfiPsHcs3F=HMvnBzyg@mail.gmail.com>
 <m27gq7ochp.fsf@igel.home>
 <CAH_OBif=Zr-3GO3CE4D6O3wJJZysB6=vvmA37K6ujTHTr-un7w@mail.gmail.com>
 <m2390vobnh.fsf@igel.home>
 <CAH_OBidmrJsmw1QQ2WONieA1EQmS_Y4WJ8Mu2Mh90tEPU0uWgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:05:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTX2w-00015N-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 13:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556Ab2JaMFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 08:05:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45018 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab2JaMFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 08:05:08 -0400
Received: (qmail 13349 invoked by uid 107); 31 Oct 2012 12:05:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Oct 2012 08:05:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2012 08:05:05 -0400
Content-Disposition: inline
In-Reply-To: <CAH_OBidmrJsmw1QQ2WONieA1EQmS_Y4WJ8Mu2Mh90tEPU0uWgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208811>

On Tue, Oct 30, 2012 at 10:22:04PM +0000, shawn wilson wrote:

> On Tue, Oct 30, 2012 at 10:09 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> > shawn wilson <ag4ve.us@gmail.com> writes:
> >
> >> and once it's added, status says:
> >> #       renamed:    t2 -> t2/one/test
> >>
> >> that's not exactly true, but...
> >
> > What's wrong with it?  Both files have the same contents, which is the
> > link target for symlinks.
> >
> 
> ok, you're right about that (another test where i changed where the
> symlink pointed):
> #       deleted:    test
> #       new file:   test/one/t3
> 
> 
> however (what got me started wondering about this and a point i forgot
> about) - t2/one/test doesn't show up under 'untracked files' in in
> status that scenario. shouldn't it?

Yes, I think that is a bug.

My guess is that the presence of "test" in the index fools us from
descending into the directory. And indeed, if you try "git status
-uall", you will see the untracked file. So it is something with the
directory traversal cutoff in the regular "-unormal" mode.

-Peff
