From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree Ready #2
Date: Thu, 23 Feb 2012 20:19:25 -0500
Message-ID: <CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com>
References: <877gztmfwy.fsf@smith.obbligato.org> <8739acra5j.fsf@smith.obbligato.org>
 <20120215050855.GB29902@sigill.intra.peff.net> <87sjicpsr1.fsf@smith.obbligato.org>
 <87ty2ro1zf.fsf@smith.obbligato.org> <20120220205346.GA6335@sigill.intra.peff.net>
 <7vd399jdwc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"David A. Greene" <greened@obbligato.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 02:19:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0jp9-0002uH-UW
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 02:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845Ab2BXBTr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 20:19:47 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40048 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab2BXBTp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 20:19:45 -0500
Received: by yenm8 with SMTP id m8so935009yen.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 17:19:45 -0800 (PST)
Received-SPF: pass (google.com: domain of apenwarr@gmail.com designates 10.101.93.2 as permitted sender) client-ip=10.101.93.2;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of apenwarr@gmail.com designates 10.101.93.2 as permitted sender) smtp.mail=apenwarr@gmail.com; dkim=pass header.i=apenwarr@gmail.com
Received: from mr.google.com ([10.101.93.2])
        by 10.101.93.2 with SMTP id v2mr100588anl.5.1330046385329 (num_hops = 1);
        Thu, 23 Feb 2012 17:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QMNE0F83jOY+QCEKW3/KXtV2uk/M6BX7NRbuSHZWO5c=;
        b=F3GdYiCZNEQ/MLinHKMk6IJZ5q0IbSON+QWlSzTDf1d1xM4XUH3wyw/HJ4bJihgQ98
         F4se7J7i0kGI0kvkAKj6xGZm2p5LyFIPLXpFTiiHOmo2CJPannWZqIdL/SRT2B4nqhOM
         ufop9Qvhe887K0B87DA+dLW6HZwpox9889V6A=
Received: by 10.101.93.2 with SMTP id v2mr77693anl.5.1330046385213; Thu, 23
 Feb 2012 17:19:45 -0800 (PST)
Received: by 10.146.112.6 with HTTP; Thu, 23 Feb 2012 17:19:25 -0800 (PST)
In-Reply-To: <7vd399jdwc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191409>

On Mon, Feb 20, 2012 at 6:14 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> It sounds like the simplest and cleanest would be to treat it as if i=
ts
> current version came as a patch submission, cook it just like any oth=
er
> topic in 'pu' down to 'next' down to eventually 'master', with the us=
ual
> review cycle of pointing out what is wrong and needs fixing followed =
by a
> series of re-rolls.

Yeah, my original intent with git-subtree was to one day submit it as
basically a single patch against git.  That's why I have some slightly
suspicious commit messages in there (though in my defense, I think
*most* of the commit messages are quite sensible :)).

> After looking at the history of subtree branch there, however, I agre=
e
> that it would not help anybody to have its history in my tree with lo=
g
> messages like these (excerpt from shortlog output):
> [...]
> =A0 =A0 =A0Docs: when pushing to github, the repo path needs to end i=
n .git
> [...]

That commit message in particular I thought was perfectly fine; it's
specifically a fix to the git-subtree docs to clarify a question from
an actual user.

Overall I agree that there's little benefit in preserving the history,
at least as far as I can see, *except* that some code changes were
submitted by people other than me and squashing those changes might
conceivably cause licensing confusion down the road.  It's probably a
fairly quick exercise with git-filter-branch to get rid of the more
egregious commit message problems, if that's what we want to do.  (In
particular, just expurgating the entire 'todo' file from the history
probably makes plenty of sense.)

There's no value I can see in being able to do future merges from
outside the tree, so a filter-branch or rebase before merging should
be pretty harmless.

> The total amount of change does not look too bad, either:
>
> =A0 =A0$ git diff --stat master...origin/subtree
> =A0 =A0 contrib/subtree/.gitignore =A0 =A0 =A0 =A0 | =A0 =A05 +
> =A0 =A0 contrib/subtree/COPYING =A0 =A0 =A0 =A0 =A0 =A0| =A0339 +++++=
++++++++++++
> =A0 =A0 contrib/subtree/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 45 +++
> =A0 =A0 contrib/subtree/README =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +
> =A0 =A0 contrib/subtree/git-subtree.sh =A0 =A0 | =A0712 +++++++++++++=
+++++++++++++++++++++++
> =A0 =A0 contrib/subtree/git-subtree.txt =A0 =A0| =A0366 +++++++++++++=
+++++
> =A0 =A0 contrib/subtree/t/Makefile =A0 =A0 =A0 =A0 | =A0 71 ++++
> =A0 =A0 contrib/subtree/t/t7900-subtree.sh | =A0508 +++++++++++++++++=
++++++++
> =A0 =A0 contrib/subtree/todo =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 50 +++
> =A0 =A0 t/test-lib.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 11 +-
> =A0 =A0 10 files changed, 2114 insertions(+), 1 deletion(-)

Note that COPYING, .gitignore, Makefile, t/Makefile, todo, and README
should probably be ditched if it weren't going into contrib.  The
interesting files are git-subtree.{sh,txt} and t7900-subtree.sh.

> I haven't looked at the script fully, but it has an issue
> from its first line, which is marked with "#!/bin/bash". =A0It is unc=
lear if
> it is infested by bash-isms beyond repair (in which case "#!/bin/bash=
" is
> fine), or it was written portably but was marked with "#!/bin/bash" j=
ust
> by inertia.

I'm generally pretty careful to avoid bashisms, but since my /bin/sh
is bash, I usually mark scripts with /bin/bash just to be safe until
someone has actually verified them with a non-bash shell.  I expect
few if any problems with that part.

>=A0A patch that corresponds to the above diffstat immediately
> shows many style issues including trailing eye-sore whitespaces.
>
> It seems that it is even capable of installing from contrib/subtree, =
so
> keeping it in contrib/ while many issues it may have gets fixed would=
 not
> hurt the original goal of giving the script more visibility.

Personally, I would prefer to just iterate the patch a few times to
correct the coding style problems you see, rather than merging into
contrib where it might be forgotten rather than fixed.  As Peff
alluded, people who want to install it separately from git already
can; if we're going to merge it into git, let's do it right.

Have fun,

AVery
