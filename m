From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 15:41:42 +0100
Message-ID: <20090121144142.GA18093@chistera.yi.org>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com> <49773240.7090605@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 15:43:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPeIV-00060a-VZ
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 15:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbZAUOlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 09:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbZAUOlt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 09:41:49 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1986
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbZAUOlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 09:41:49 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 724618027909;
	Wed, 21 Jan 2009 15:41:46 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LPeH0-0004mw-54; Wed, 21 Jan 2009 15:41:42 +0100
Content-Disposition: inline
In-Reply-To: <49773240.7090605@drmicha.warpmail.net>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106612>

* Michael J Gruber [Wed, 21 Jan 2009 15:33:36 +0100]:

> Marc-Andr=C3=A9 Lureau venit, vidit, dixit 21.01.2009 14:02:
> > Hi

> > I deleted a remote branch which was pointed by HEAD, this way: "git
> > push origin :master"

> > Then for almost every git command, I get this error: "error:
> > refs/remotes/origin/HEAD points nowhere!".

> You're talking about about the remote git repo, aren't you?

> > I found this situation non-friendly. Fortunately, I could understan=
d
> > what's going on. But a new user might be confused.

> > Shouldn't the remote HEAD branch be updated or "protected" in some
> > ways? Or should the "error" be considered as a "warning" (silently?=
)

> > What do you think?

> I think that git said
> "warning: updating the currently checked out branch; this may cause
> confusion,
> as the index and working tree do not reflect changes that are now in =
HEAD."
> after your push and that this may have rung some bells. I also think
> that pushing to a non-bare remote repo (one with a worktree checked o=
ut)
> is strongly advised against in multiple places, unless you know what
> you're doing - which you seem to do since you were able to restore yo=
ur
> HEAD ;)

I don't think Marc-Andr=C3=A9 was pushing to a non-bare repo, but it do=
esn't
really matter, because his issue also shows up with bare repos: if you
delete the branch to which HEAD points in a remote repo, you get no
warning, and then cloning that bare repo does not fully work, because
its HEAD points to a non-existent ref.

    % g clone ssh://.../foo.git
    % cd foo
    % g push origin :master
    % cd ..
    % g clone ssh://.../foo.git foo2
    ...
    warning: remote HEAD refers to nonexistent ref, unable to checkout.

What would git usefully do in this situation, I don't know. But I
thought I'd clear up the above confusion.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Truth is the most valuable thing we have, so let's economize it.
                -- Mark Twain
