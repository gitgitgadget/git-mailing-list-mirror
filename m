From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 19:03:26 +0200
Message-ID: <4852A85E.6020406@free.fr>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net> <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:04:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Cgx-0004oI-MQ
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 19:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbYFMRDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 13:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbYFMRDF
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 13:03:05 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:34223 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516AbYFMRDD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 13:03:03 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 69F0312B721;
	Fri, 13 Jun 2008 19:03:01 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id B41B912B705;
	Fri, 13 Jun 2008 19:03:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84902>

Junio C Hamano a =E9crit :
>=20
>  * We _did not have to_ make stashes into refs/stash@{$N}.  We could =
have
>    implemented them as individual refs under "refs/stash/$N" hierarch=
y.
>    E.g. refs/stashes/1, refs/stash/2, etc.

I don't really see what is the need for "global" stashes but why not?

>    As a side note, we also could have implemented per-branch stash as
>    refs/stashes/master@{$N} or refs/stashes/$branch/$N (and we still =
can.
>    Perhaps we can have "git stash save -B" option that tells the comm=
and
>    to send the resulting stash to the per-branch namespace).

I really like your refs/stashes/$branch/$N idea because it seems easier=
 to
list and clean with git stash list/drop/clear.
But I think stash should stay a per-branch thing by default. What about=
 a
-g (--global) option instead?

>  * We later introduced "drop" because even as a volatile and short-li=
ved
>    collection of local modifications, you can tell that some stashes =
are
>    utter crap immediately while deciding that some are worth keeping,=
 even
>    for a short term.

"drop" is nice, but I think the real improvement was "pop".

>  * We could add "keep" which is a complementary operation to "drop". =
 This
>    would mark a stash as a gem in a more direct way, excempt even fro=
m the
>    usual auto pruning.

I don't like it at all. Why not just have "keep" by default? The users =
can
already use "pop", "drop" and "clear" if they want to trash their stash=
=2E

Olivier.
