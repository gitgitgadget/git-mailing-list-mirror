From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 12:34:23 -0700
Message-ID: <20080811193423.GM26363@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <20080811192208.GK26363@spearce.org> <a6b6acf60808111229u72ffad66kb7a253f2fef44654@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andi Kleen <andi@firstfloor.org>, git@vger.kernel.org
To: Ken Pratt <ken@kenpratt.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSdAv-0006Q5-Ls
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbYHKTeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbYHKTeY
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:34:24 -0400
Received: from george.spearce.org ([209.20.77.23]:39320 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbYHKTeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:34:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1C2AA38375; Mon, 11 Aug 2008 19:34:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <a6b6acf60808111229u72ffad66kb7a253f2fef44654@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91986>

Ken Pratt <ken@kenpratt.net> wrote:
> > Looking at /proc/meminfo only works on Linux, and maybe some other
> > OSes which support a /proc like design.  But even then we don't
> > really know how much we are competing with other active processes
> > and how much memory we can use.
> 
> Could we create a git config variable to specify the maximumum amoung
> memory to mmap? Any if that variable wasn't explicitly set, it would
> fall back on looking at /proc/meminfo?

Well, core.packedGitLimit is supposed to be related to this limit
you are asking for.  But it doesn't cover all memory usage as we
malloc other things.  core.deltaBaseCacheLimit covers part of the
malloc'd area.  pack.windowLimit I think covers another part of
the malloc'd area.  Etc...

There really isn't a global "malloc/mmap at most X bytes".

-- 
Shawn.
