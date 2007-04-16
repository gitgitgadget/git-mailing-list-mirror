From: Theodore Tso <tytso@mit.edu>
Subject: Re: Any objectsions to enhancing git-log to show tags/branch heads?
Date: Mon, 16 Apr 2007 16:46:59 -0400
Message-ID: <20070416204659.GI27533@thunk.org>
References: <E1HdQah-0008Q2-7E@candygram.thunk.org> <7vy7kstdom.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:47:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdY6U-0005ib-IU
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 22:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbXDPUrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 16:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbXDPUrL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 16:47:11 -0400
Received: from thunk.org ([69.25.196.29]:40342 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654AbXDPUrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 16:47:10 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HdYCm-0001QV-MS; Mon, 16 Apr 2007 16:53:45 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HdY6F-0004zY-Gc; Mon, 16 Apr 2007 16:46:59 -0400
Content-Disposition: inline
In-Reply-To: <7vy7kstdom.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44697>

On Mon, Apr 16, 2007 at 10:46:33AM -0700, Junio C Hamano wrote:
> I cannot comment on performance impact without knowing exactly
> what semantics is being proposed.
> 
>  (1) If a commit is not directly pointed by any ref, would it
>      get HEAD: or TAG: line, perhaps ala 'git-describe'?

No.

>  (2) If a commit is at the tip of two branches, what happens?
>      Would it get two HEAD: lines?

Yup, I was assuming it would get two Head: lines, one for each head.

>  (3) Same question as (2) when a commit is tagged with two tags,
>      or at the tip of a branch and pointed by a tag.

Two tag: lines, one for each tag.  Mercurial's "hg log" does this
today, by the way, and I've found it to be very handy since it makes
it easier to find various tagged releases when browsing the revision
history.

> As to the impact on people's existing scripts that read git-log,
> I think changing --pretty=anything would cause breakage for
> somebody.  A new --pretty=format: tag would be the least
> destabilizing, but I dunno.

When I write my shell scripts and parse "Foo: " headers I always
explicitly grep out the headers I want, and assumin a blank line after
the headers, because I expect that future versions might add new
headers, and I want my code to be robust; but I can imagine there
might be some less-than-robust scripts out there....

> But the fact that you kill gitk before it stops drawing suggests
> that you are interested in recent commits only?  What is exactly the
> use case?

Well, usually what I'm interested in is near the tip, but not always.
In general, seeing the anchor points is part of the problem, and so
"git log | git -p name-rev --stdin" is useful, although it isn't as
useful as "gitk" when a revision has multiple HEAD or TAG's associated
with it, and git-name-rev doesn't know which one(s) would be of
greatest interest.

						- Ted
