From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 03:10:28 -0500
Message-ID: <20080225081028.GN8410@spearce.org>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at> <7vr6f1pwaw.fsf@gitster.siamese.dyndns.org> <20080225074611.GC15761@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:11:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYQf-0003xU-Ov
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbYBYIKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYBYIKl
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:10:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51889 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbYBYIKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:10:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTYPs-0006TE-3B; Mon, 25 Feb 2008 03:10:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4AA0E20FBAE; Mon, 25 Feb 2008 03:10:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080225074611.GC15761@auto.tuwien.ac.at>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75008>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> On Sun, Feb 24, 2008 at 07:08:39PM -0800, Junio C Hamano wrote:
> > 
> > I'd rather see a series does not depend on things in next that
> > you do not have to depend on, pretty please?
> 
> I usually develop my patch on next. I can offer you two things:
> * base my patches on something different (master?)
> * add fsck.h/o some lines above
> 
> What do you prefer?

Don't build patch series against "next" unless they will trivially
apply *and function correctly* also on "master".  E.g. a trivially
obvious one liner may be OK to develop on "next", but everything
else should be done against "master", or if you must the tip of the
topic in "next" that you desire to build upon.

E.g. when I was working on the builtin-fetch debugging and I was
building on top of that topic in next, not all of next itself.
 
> > For example, I do not think you can use this to mark reachable
> > objects.  Even if you find error walking the first parent
> > history, you would want to still mark a healthy second parent
> > history reachable.
> 
> How should I define the return value of fsck_walk in the presence of
> multiple errors?
> 
> It would not be necessary for all my users:
> 
> * in unpack-object and index-pack (I'll send an updated patch in the
>   next days), any error means that we can abort. Further checking would
>   mean wasting of resources.
> 
> * in fsck (patch 2) the error is signaled by the errors_found variable, so
>   all callbacks can return 0, even in the case of an error. Checking the
>   return value of fsck_walk would mean duplicate error messages.

So the return value is more about "keep walking" than it is about an
error (or lack there of)?

-- 
Shawn.
