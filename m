From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Wed, 26 Aug 2009 10:03:14 -0700
Message-ID: <20090826170314.GP1033@spearce.org>
References: <alpine.LFD.2.00.0908242001250.6044@xanadu.home> <20090825021223.GE1033@spearce.org> <7vab1osc2m.fsf@alter.siamese.dyndns.org> <20090825061248.GG1033@spearce.org> <7vy6p8pfm1.fsf@alter.siamese.dyndns.org> <20090825151424.GJ1033@spearce.org> <20090826021057.GL1033@spearce.org> <4A94DF84.4050906@viscovery.net> <20090826082256.GO1033@spearce.org> <7vk50reykp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Nicolas Pitre <nico@cam.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 19:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgLuU-0003gI-4q
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 19:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbZHZRDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 13:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZHZRDO
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 13:03:14 -0400
Received: from george.spearce.org ([209.20.77.23]:40971 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbZHZRDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 13:03:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BD031381FD; Wed, 26 Aug 2009 17:03:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vk50reykp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127108>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >> How will this mesh with 'git clone --mirror'?
> >
> > Not well.
> 
> But we at least can assume that the server operator is reasonable and
> wouldn't go overboard, (ab)using this "abbreviated advertisement" feature
> to hide heads and tags from the clients.

Yes.  My patch is hardcoded to show only heads and tags, and nothing else.

But I think we want to make this configurable, and show everything
by default, but if there is a configuration entry, show only what
the configuration entry patterns suggest to advertise.

Thus an admin could hide refs/heads/*, but maybe he wants to, and
show only refs/heads/master, refs/heads/maint, refs/heads/next by
default.  This is actually a rather clear indication to a client
that although there may be individual cooking topics scattered
through the expanded refs/heads/* space, any reasonable default
clone wouldn't take them.

> Think about in what situation you would want to do a mirror clone.
...
> That means the version of git used to prime, update
> and serve the mirror will know the expand extention.

Great point Junio.  The backwards compatibility may be a non-issue
then, especially if this is configurable and we advertise refs/*
by default like we do now, and any reasonable admin who does enable
the hiding still advertises the core namspaces that really matter
to the majority of clients.

> I am hoping that we can finish 1.6.5 by mid September (let's tentatively
> say we will shoot for 16th).  I expect the expand extention to be in
> 'next' by that time, cooking for 1.7.0.  How does that timetable sound?

Oh, if 1.6.5 is mid-September, this is certainly not 1.6.5 material.
I'm not in any rush, this should go in when its ready, but 1.7
might be reasonable.

-- 
Shawn.
