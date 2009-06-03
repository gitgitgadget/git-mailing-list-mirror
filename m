From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 07:17:19 -0700
Message-ID: <20090603141718.GC3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906022339.08639.jnareb@gmail.com> <20090602232724.GN30527@spearce.org> <200906030250.01413.jnareb@gmail.com> <20090603021840.GE3042@orbis-terrarum.net> <m3r5y1a91m.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 16:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBrIk-0006nw-Gu
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 16:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757014AbZFCORT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 10:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758237AbZFCORS
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 10:17:18 -0400
Received: from george.spearce.org ([209.20.77.23]:40973 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758228AbZFCORR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 10:17:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1979E381D1; Wed,  3 Jun 2009 14:17:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3r5y1a91m.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120609>

Jakub Narebski <jnareb@gmail.com> wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> 
> > Relatedly with the "done" message, I'm in the process of writing a hook
> > that allows the server to deny the client at this point, instead of
> > building and sending a pack.
> 
> I am not sure if it would be possible to fit a hook there, but perhaps
> it would be possible to add such `pre-upload` hook... Note that it
> would have to somehow work for both git:// and ssh:// protocols, and
> perhaps also for "dumb" protocols such as http:// (and other
> curl-based) and deprecated rsync://

Uh, that hook can't be used on HTTP or rsync.  How do you expect the
HTTP or rsync client to execute a process on the server?  It can't,
the server isn't git aware.  Its only valid on smart protocols.
 
> > My intended use is to block initial clones while still allowing updates
> > (as long as you've got a tree at least commit X recent, I'll talk to
> > you). Initial and too-old clients get a message to go and download a
> > bundle instead.
> 
> Wouldn't it be better to make use of mirror-sync (which sadly is in
> planning stages only; see SoC2009Ideas page on git wiki) to redirect
> to some other repository to be used for cloning requests?

Yes.  But mirror-sync isn't here yet, and is a lot more work to
create than hacking upload-pack.c to invoke a hook.

-- 
Shawn.
