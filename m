From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Darcs-Git: upgrading to Git 0.99
Date: Sun, 17 Jul 2005 06:40:42 -0400
Message-ID: <20050717104035.GA8315@abridgegame.org>
References: <7islyev5s4.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@darcs.net, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jul 17 12:47:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du6fm-0004Ch-SG
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 12:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVGQKqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 06:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVGQKqp
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 06:46:45 -0400
Received: from user-10bj72p.cable.mindspring.com ([64.185.156.89]:29029 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261238AbVGQKqp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2005 06:46:45 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1Du6Ze-0002hy-4L; Sun, 17 Jul 2005 06:40:42 -0400
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Mail-Followup-To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <7islyev5s4.fsf@lanthane.pps.jussieu.fr>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 16, 2005 at 10:45:47PM +0200, Juliusz Chroboczek wrote:
> 
> I'd like to upgrade the Git code used in Darcs to 0.99 (we're
> currently using 0.6). [...]

Great!

> Now I'm wondering how to do that.  Currently, I'm using a nasty hack
> using the C preprocessor to include just the sources we need in
> Darcs.  As 0.99 builds a ``libgit.a'', I'd like to use that instead.
> 
> There are three ways to do that:
> 
>   (1) require that the users put a suitable libgit.a in /usr/local/lib
>       before building Darcs, and distribute a tarball of Git from
>       darcs.net;
> 
>   (2) include just the sources needed for libgit.a in Darcs, and have
>       the Darcs build build a local libgit
> 
>   (3) as (2), but include all of Git, including their
>       ``user-friendly'' scripts.
> 
> Solution (2) will include 33 files totalling 167KB, while (3) is about
> a megabyte of source.

I'd really prefer option (1), *if* the git folks can confirm that the API
is at least intended to be stable.  As an subtly different option, we could
include a script that would download and untar the git sources and then
build them.  But it'd be great to allow users to upgrade their libgit
without our intervention if a protocol or repository format change occurs
that doesn't affect the API.

I guess the real question is whether the API is more or less stable than
the protocols and disk formats.  If the API is more stable, we'd rather
link with an external libgit and be robust with respect to on-disk format
changes (such as pack files).  If the on-disk format is more stable, we'd
rather include a copy of the source code and be robust with respect to API
changes of libgit.

A fourth option would be to include git sources, but also include a
configure flag that could be used to link with an external libgit.  This is
probably the most robust solution, but also the most complex solution (and
thus probably not the best).
-- 
David Roundy
http://www.darcs.net
