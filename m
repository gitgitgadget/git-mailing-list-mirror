From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Sun, 4 Feb 2007 01:24:39 +0100
Message-ID: <20070204002439.GH4266@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth> <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com> <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net> <20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com> <b0943d9e0702021525o2379883aqaf27f874134668c5@mail.gmail.com> <20070203214619.GM5362@nan92-1-81-57-214-146.fbx.proxad.net> <7v8xfe3kwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 01:25:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDVCN-0003c8-EV
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 01:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXBDAZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 19:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXBDAZh
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 19:25:37 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:39313 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbXBDAZg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 19:25:36 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id E94C27CD1;
	Sun,  4 Feb 2007 01:25:34 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 9AA8B2015; Sun,  4 Feb 2007 01:24:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8xfe3kwo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38622>

On Sat, Feb 03, 2007 at 03:01:59PM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > On Fri, Feb 02, 2007 at 11:25:28PM +0000, Catalin Marinas wrote:
> >> OK, tried again and 'stg pull' doesn't update the base with the last
> >> patch in the series ('stg rebase origin' updates it). I don't have
> >> anything set up in my gitconfig in this area.
> >
> > So now that this particular problem has a fix, let's fix everything
> > related.
> >
> > Since branch.*.merge accept local ref names, there is probably far
> > more to change that what I initially feared.
> 
> If that is the case maybe we should fix branch.*.merge not to
> match the local tracking branch name.  Matching it with local
> tracking branch name when the remote name does not match was
> werely a fallback to help broken configurations confused people
> might create by hand, and has never been the part of sane
> practice at all.

Oh, sorry, I indeed meant "less to change" :>

Since git-fetch alone makes the decisions (so no algorithm has to get
duplicated into stgit), and since the only remote refs possibly
confused for local ones are the old non-separate ones, and since in
that case usually the remote branches are mapped to the same name, the
odds for a problem are low, and will get lower.

Making branch.*.merge not understand local refs, OTOH, would require
stgit to resolve a local branch to its remote name.  Note that I
already had to do the job to guess which remote a branch was pulled
from (and thus, to decide whether a branch was local or remote).

Fortunately, all of this is going to be unnecessary on newer repos
since git-clone now fills all the fields - we only have to deal with
the upgrade of older repos.

Best regards,
-- 
Yann.
