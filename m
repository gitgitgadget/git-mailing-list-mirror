From: Petr Baudis <pasky@suse.cz>
Subject: Re: Alternates and push
Date: Tue, 9 Sep 2008 10:35:51 +0200
Message-ID: <20080909083551.GA10544@machine.or.cz>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org> <9e4733910809061124r3759ea79sda98b549df3e6e58@mail.gmail.com> <20080906192106.GB18631@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 10:37:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcyii-0007lI-NX
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbYIIIf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbYIIIf4
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:35:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60112 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753775AbYIIIf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:35:56 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3A433393B308; Tue,  9 Sep 2008 10:35:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080906192106.GB18631@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95357>

On Sat, Sep 06, 2008 at 12:21:06PM -0700, Shawn O. Pearce wrote:
> github should do what repo.or.cz does:
> 
> 	ln -s .../linus.git/refs digispeaker.git/refs/forkee
> 
> That way the refs available in Linus' tree are also available
> in your tree as Git will transparently follow the symlink.
> 
> However you have to be careful to make sure `git pack-refs` isn't
> run with `--all --prune` as it will delete the refs from linus.git
> when executed in digispeaker.git.  Fun times when I did that to my
> own repository one day.  ;-)
> 
> Though we probably should fix Git to be somewhat smarter.  But
> until that stable binary is available, the symlink trick above
> is a good work around.

But it should be used only in controlled environment. If you happen to
have permissions to write to the forkee, you can wipe out its refs with
git fetch --mirror (and if you don't happen to have permissions, it will
just fail, so currently you cannot use this on repo.or.cz forks,
unfortunately). If you don't make sure refs are never packed (I do on
repo.or.cz, historically because of dumb transports - do they support
packed refs by now?), this won't work either. Maybe there are other
considerations too.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
