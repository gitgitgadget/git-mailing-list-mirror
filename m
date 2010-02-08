From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Revert
 "pack-objects: fix pack generation when using pack_size_limit"
Date: Mon, 08 Feb 2010 13:11:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002081306420.1681@xanadu.home>
References: <alpine.LFD.2.00.1002081032530.1681@xanadu.home>
 <7v3a1bpqqq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 19:11:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeY4t-0002Mo-E3
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 19:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab0BHSLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 13:11:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38230 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab0BHSLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 13:11:14 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXJ00BDYBUO1I61@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 08 Feb 2010 13:11:12 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v3a1bpqqq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139303>

On Mon, 8 Feb 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > This reverts most of commit a2430dde8ceaaaabf05937438249397b883ca77a.
> >
> > That commit made the situation better for repositories with relatively
> > small number of objects.  However with many objects and a small pack size
> > limit, the time required to complete the repack tends towards O(n^2),
> > or even much worse with long delta chains.
> >
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > ---
> >
> > Fixing this doesn't appear to be as trivial as I initially thought.
> > Although I do have some ideas, they're not appropriate so late in 
> > the -rc period.
> 
> Ok, so the idea is what a2430dd tried is an issue worth addressing but the
> particular execution wasn't good?  We revert it for now, but we will try
> again after the release, perhaps doing it differently?

Exact.  I did try a few things in the hope that the "fix" would have 
been trivial enough to merge now but none of that worked satisfactorily.

> I agree with it if that is your intention, but "Most of" bugs me a bit.

It's not a straight revert in the sense that I left in some cleanups and 
left out the redundant self consistency check.  Only the significant 
parts were reverted.


Nicolas
