From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git push --mirror" update mirrors
Date: Sun, 27 Apr 2008 23:32:38 -0400
Message-ID: <20080428033237.GN29771@spearce.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 05:33:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqK7e-0006kS-Hj
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 05:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762257AbYD1Dco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 23:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762229AbYD1Dco
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 23:32:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44301 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762197AbYD1Dcn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 23:32:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JqK6O-0008Tl-Cd; Sun, 27 Apr 2008 23:32:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7BC7B20FBAE; Sun, 27 Apr 2008 23:32:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vy76zf449.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80499>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > But then they later wonder why they need `git pull origin branch`
> > to merge in branch, when they usually just say `git pull`.  What is
> > the need for that funny keyword `origin`?  Why do I have to say
> > where to get the branch from sometimes and not others?
> 
> What's the constructive suggestion for improvement we can draw from this
> after all?  Should we deprecate the defaulting of "origin" so that
> everybody now should always say "git pull $where"?

Yes, I think that is what I was thinking.  By making users always say
where they are pulling, fetching or pushing from/to it becomes less
weird when you have to give a refspec too.

But this clearly harms the `git pull` case that relies upon the magic
branch.$name.remote and branch.$name.merge keys, as now git-pull is
expecting the user to supply a remote name, but one was already saved
for this current branch.

It also clearly harms people who have only origin and want to grab
updates from there with just `git fetch` or `git pull`.  Such a
change would be asking these users to enter a longer command line.

On the other hand, I think it would teach those users how to better
make use of git, and may cause less questions when they have to
step slightly outside of their normal use case and specify a refspec.

> In other words, make
> people more aware that what _they_ do is the special case to have only one
> remote to interact with?

My special case is always the other guys' common case.  You can't
please everone.  But here I think that _our_ special case (where we
always give the remote name/URL to fetch/pull/push) helps users to
learn the tool better, because it erases a special case from their
vocabularly of Git commands.

-- 
Shawn.
