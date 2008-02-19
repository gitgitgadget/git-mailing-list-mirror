From: Nicolas Pitre <nico@cam.org>
Subject: Re: rebase --onto might "loose" commits
Date: Tue, 19 Feb 2008 09:43:15 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802190939240.2732@xanadu.home>
References: <20080219072359.GA752@atjola.homenet>
 <alpine.LSU.1.00.0802191102440.30505@racer.site>
 <20080219125216.GA10444@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_qHgYaUAtUrNCgtYVq8z9TA)"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 15:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRThI-0007L4-HC
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 15:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbYBSOnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 09:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbYBSOnS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 09:43:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15426 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330AbYBSOnR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 09:43:17 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWH00KJWQ84SN20@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 19 Feb 2008 09:43:16 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080219125216.GA10444@atjola.homenet>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74412>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_qHgYaUAtUrNCgtYVq8z9TA)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Tue, 19 Feb 2008, Björn Steinbrink wrote:

> Hi,
> 
> On 2008.02.19 11:05:40 +0000, Johannes Schindelin wrote:
> > On Tue, 19 Feb 2008, Björn Steinbrink wrote:
> > 
> > > when there's nothing to rebase (ie. upstream..branch is empty), rebase 
> > > fails to find any commits to rebase and correctly says "Nothing to do", 
> > > but when --onto is given, we already did a "reset --hard" to newbase, so 
> > > it already _did_ something.
> > 
> > Yes, it did something.  But if you had that:
> > 
> > A - B - C - D - E
> >   \
> >     F
> > 
> > your HEAD was E, and you said "git rebase --onto F E" what exactly do you
> > want it to do?  There is no commit between E and E, so it rebases
> > _nothing_ onto F.  Which means that F should be your new state.
> 
> Strictly, it's correct, but the "Nothing to do" message is a bit
> misleading (IMHO) and the error message made me think, that it actually
> didn't want to do anything.

Yes, the message should probably be changed in that case.

> I'm a bit unsure about rebase being degraded to a "reset --hard" in this
> case is a good idea. Might be a nice user-protection to make rebase
> abort when there's nothing to rebase and --onto is given. But I don't
> care that much.

The "reset --hard" in that case is really the correct behavior.  Rebase 
might be used like 'git pull --rebase', and if your local branch 
contains no commits of your own then the 'git reset --hard' is really 
what needs to happen.

The "user protection" lives in the reflog.


Nicolas

--Boundary_(ID_qHgYaUAtUrNCgtYVq8z9TA)--
