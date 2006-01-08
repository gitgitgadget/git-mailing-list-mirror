From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 7/7] Add an optional limit to git-rebase
Date: Sun, 8 Jan 2006 11:06:54 +0100
Message-ID: <20060108100654.GF32585@nowhere.earth>
References: <20060108004120.GO1113@nowhere.earth> <7vk6db12z7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 11:04:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvXPQ-0001XA-Pl
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 11:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030631AbWAHKEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 05:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030632AbWAHKEQ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 05:04:16 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:42461 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030631AbWAHKEP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 05:04:15 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 0BD558B1F;
	Sun,  8 Jan 2006 11:04:14 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvXRu-0001D3-O9; Sun, 08 Jan 2006 11:06:54 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6db12z7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14315>

On Sun, Jan 08, 2006 at 01:30:20AM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > This patch adds a limit to restrict the list of patches to rebase.
> >
> > This is useful when a set of patches were done against a given head,
> > but needs to be ported to a different head, as opposed to being ported
> > to a descendant of the original head.  In such a case we only want to
> > port our own patches, not those that make the two branches different
> > upstream.
> 
> This usage makes sense, independent from your git-format-patch
> "limit" patch.  The patched argument to git-format-patch does
> not match your git-format-patch changes AFAICT ;-).

D'oh, I knew I should always written a testsuite when changing the
implementation of a feature at such a late time in night.


> > -git-format-patch -k --stdout --full-index "$other" ORIG_HEAD |
> > +git-format-patch -k --stdout --full-index "$other" ORIG_HEAD $limit |
> 
> If all you want to do is to move the cut-off point more recent
> than the merge base is, how about (without your git-format-patch
> changes) doing something stupid like this instead?
> 
>   git-format-patch -k --stdout --full-index ${limit:-"$other"} ORIG_HEAD

Right, that would even be closer to the version that had indeed been
tested - it does have the advantage of passing t3401, though :)

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
