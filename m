From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Split sample update hook into post-receive hook
Date: Thu, 8 Mar 2007 04:13:13 -0500
Message-ID: <20070308091313.GC30289@spearce.org>
References: <20070308041618.GA29744@spearce.org> <81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com> <20070308083317.GB30289@spearce.org> <7vy7m8aytt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 10:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPEgm-0001Ru-OB
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbXCHJN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbXCHJN0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:13:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41182 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030370AbXCHJNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:13:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPEgW-0005JU-TG; Thu, 08 Mar 2007 04:13:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1DD5020FBAE; Thu,  8 Mar 2007 04:13:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vy7m8aytt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41722>

Junio C Hamano <junkio@cox.net> wrote:
> I suspect that it is deeper than that.  Think about why having
> "everything at once" is better than "one at a time".
> 
> Potentially you could have a rule that says "these should be
> updated together" (or the other way around).  If you split the
> set of refs at arbitrary limit, like xargs does, you would lose
> that advantage.

Yes, I think the documentation says something about that... ;-)

> We could take stdin to solve that and shell
> scripts should be able to handle that as refnames do not contain
> shell metacharacters.

Never even occurred to me, because I was trying to keep the hook
interface "simple".

> But this is only true if you want to make it really nice.  I
> personally feel that nobody would scream if pushing 1300 refs at
> once (4K pages and MAX_ARG_PAGES at 32 would give 128K for
> **argv and its strings, and one ref's worth of data is two
> 40-digit hex plus refname, roughly 100-byte per ref) is not
> supported and always failed.

Agree completely.  I'm not too worried about it.  1300 ref push is
just not going to really occur in practice; that is just insane.
30 refs, maybe.

-- 
Shawn.
