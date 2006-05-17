From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC 5/5] Support 'master@2 hours ago' syntax
Date: Wed, 17 May 2006 17:39:08 -0400
Message-ID: <20060517213908.GB30313@spearce.org>
References: <20060517095609.GF28529@spearce.org> <7vbqtwhpum.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605170745270.10823@g5.osdl.org> <7v7j4kec3h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 23:39:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgTjk-0006QM-Mi
	for gcvg-git@gmane.org; Wed, 17 May 2006 23:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWEQVjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 17:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWEQVjS
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 17:39:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:4571 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751137AbWEQVjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 17:39:17 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgTjU-0005Sk-Ao; Wed, 17 May 2006 17:39:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 020CA212667; Wed, 17 May 2006 17:39:08 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7j4kec3h.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20244>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Wed, 17 May 2006, Junio C Hamano wrote:
> >> 
> >> This does not allow '2006-05-17 00:00:00' as the timespec, and
> >> the documentation carefully avoids giving that example, but I
> >> think it is better to spell that limitation out.
> >
> > It doesn't? The "approxidate()" function should handle any reasonable date 
> > specifier, and the above is certainly more than reasonable.
> >
> > Why doesn't approxidate handle it?
> 
> The way I read the code is that get_sha1() would first do its
> magic at the first colon and feeds get_sha1_1() with prefix up
> to the first colon.  This gets passed down to get_sha1_basic()
> and what approxidate() is fed is the suffix of that prefix. It
> ends up seeing stuff between '@' and ':'.  I.e.
> 
> 	"master@2006-05-17 00:00:00:cache.h"
> 
> would ask for "00:00:cache.h" file in the "master" branch as of
> timestamp "2006-05-17 00".

Good catch.  I'll see if I can deal with it later; probably early
tomorrow morning before work.  It may just come down to documenting
this particular case as ambiguous and sure to parse the way you
did not mean it to.  :-)

I tested a bunch of other date formats but not the basic ISO.  Argh.
I'll send a test case soon for the expression parsing here, to be
sure we pull stuff from the log as expected as well as parse the
expression in a consistent way between releases.  :-)

-- 
Shawn.
