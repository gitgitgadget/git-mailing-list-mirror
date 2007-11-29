From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 09:09:42 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711290905510.9605@xanadu.home>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site>
 <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 15:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixk5u-0003qq-Kt
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 15:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759918AbXK2OKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 09:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757326AbXK2OKA
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 09:10:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8895 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801AbXK2OJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 09:09:59 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS900KPUU06ULB0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 09:09:42 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66533>

On Thu, 29 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> On Nov 29, 2007 6:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
> >
> > > On Nov 28, 2007 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > >> In case somebody is thinking about 36e5e70e0f40 (Start deprecating
> > >> "git-command" in favor of "git command"), that is a somewhat different
> > >> issue.  What Linus suggested is not installing git-foo link for built-in
> > >> commands _anywhere_ on the filesystem.  Not just "out of user's PATH".
> > >> That is not deprecating dash form but removing the support for it.  We
> > >> need to give ample time for users to adjust to such a change.
> > >
> > > A little note on this one. I've been using git without builtin links
> > > for a while with my git-box port. There are still some builtin fixups
> > > needed. And because execv_git_cmd() always uses dash form, so it's
> > > impossible to use vanilla git without builtin links.
> >
> > Thanks for a heads up.
> >
> > Would people agree with a rough roadmap like this?
> >
> >  - v1.5.4 will ship with gitexecdir=$(bindir) in Makefile.  But the
> >    release notes for the version will warn users that:
> >
> >    (1) using git-foo from the command line, and
> >
> >    (2) using git-foo from your scripts without first prepending the
> >        return value of "git --exec-path" to the PATH
> >
> >    is now officially deprecated (it has been deprecated for a long time
> >    since January 2006, v1.2.0~149) and upcoming v1.5.5 will ship with
> >    the default configuration that does not install git-foo form in
> >    user's PATH.
> >
> >  - Post v1.5.4, start cooking gitexecdir=$(libexecdir)/git-core, aiming
> >    for inclusion in v1.5.5, perhaps in Mar-Feb 2008 timeframe.
> >
> >  - The release notes for v1.5.5 will warn users that git-foo will be
> >    removed in v1.6.0 for many commands and it will be merely an accident
> >    if some of them still work.
> >
> >  - Post v1.5.5, start cooking the change that does not install hardlinks
> >    for built-in commands, aiming for inclusion in v1.6.0, by the end of
> >    2008.
> 
> There won't be a stage when only porcelain git-foos are in $(bindir)?
> I could stop working on the relevant patch then.

Well, I personally found your effort really nice.  I think Junio is 
overly cautious in this case, and I would prefer to see the number of 
git commands in the default path drop rather sooner than later.


Nicolas
