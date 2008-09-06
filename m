From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Alternates and push
Date: Sat, 6 Sep 2008 12:21:06 -0700
Message-ID: <20080906192106.GB18631@spearce.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org> <9e4733910809061124r3759ea79sda98b549df3e6e58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 21:22:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc3MN-0005rM-M9
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 21:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYIFTVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 15:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbYIFTVI
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 15:21:08 -0400
Received: from george.spearce.org ([209.20.77.23]:45073 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbYIFTVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 15:21:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8421D38353; Sat,  6 Sep 2008 19:21:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9e4733910809061124r3759ea79sda98b549df3e6e58@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95094>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/6/08, Junio C Hamano <gitster@pobox.com> wrote:
> > Theodore Tso <tytso@MIT.EDU> writes:
> >
> >  > Long-standing mis-feature in git's logic in deciding what to push.
> >  > It's been reported a few times, but apparently it's hard to fix, or at
> >  > least it never hsa been fixed as far as I know.
> >
> >
> > This comes from an early (mis)design of git.
> 
> What happens if I set a remote in my github digispeaker repo pointing
> to github's linus repo and the set a chron script to fetch it once a
> day? The alternates link is still in place.

github should do what repo.or.cz does:

	ln -s .../linus.git/refs digispeaker.git/refs/forkee

That way the refs available in Linus' tree are also available
in your tree as Git will transparently follow the symlink.

However you have to be careful to make sure `git pack-refs` isn't
run with `--all --prune` as it will delete the refs from linus.git
when executed in digispeaker.git.  Fun times when I did that to my
own repository one day.  ;-)

Though we probably should fix Git to be somewhat smarter.  But
until that stable binary is available, the symlink trick above
is a good work around.

-- 
Shawn.
