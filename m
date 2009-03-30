From: Andreas Ericsson <ae@op5.se>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 11:33:59 +0200
Message-ID: <49D09207.9080407@op5.se>
References: <200903301024.08848.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 11:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDu0-0002jB-IZ
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbZC3JeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 05:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752429AbZC3JeA
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:34:00 -0400
Received: from mail.op5.se ([193.201.96.20]:46473 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002AbZC3Jd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 05:33:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8060D1B80074;
	Mon, 30 Mar 2009 11:11:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dCrn+9gxgkAR; Mon, 30 Mar 2009 11:11:13 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 0D8AE1B80049;
	Mon, 30 Mar 2009 11:11:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200903301024.08848.brian.foster@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115119>

Brian Foster wrote:
>   Whilst this question involves linux(-mips) kernel tree,
>  it's a git(-related?) question, not a kernel question ....
>=20
>   We are currently in the process of upgrading our embedded
>  system from kernel 2.6.21(-ish) to at least 2.6.26.8;  and
>  later, at some time in the future on to 2.6.3x or something.
>  Going from 2.6.21 to .22 to .23 and so on to .26, then to
>  .26.1 and so on to .26.8 is =E2=80=9Ceasy=E2=80=9D in the sense ther=
e are
>  very few conflicts with our existing baseline (e.g., just
>  2 or 3 in 2 or 3 files).
>=20
>   .21 --> me --> .22 --> .23 ... --> .26 --> .27 --> master
>      \              \       \           \      \
>      .21-stable  .22-stable .23-stable   \     .27-stable
>                                         .26.8
>                                            \
>                                            .26-stable
>=20
>   But (using 2.6.21-stable and 2.6.22-stable as proxies),
>  tests indicate that going from .26.8 to .27 or anything
>  later will have numerous conflicts (100s? in more than
>  30 files).  Thinking about it, this isn't too surprising
>  since the -stable branches cherry-pick important/benign
>  fixes from later revisions.
>=20
>   What's frustrating is that in essentially all =E2=80=9Cconflict=E2=80=
=9D
>  cases, the resolution is simple:  Use the later version.

The trouble is "essentially all", as opposed to "all". Git
can never know which of the conflicts are which, so it will
leave it all up to you.

A possibly better approach for you is to "git format-patch"
your own changes and apply them to a clean 2.6.26.8 tree
instead of trying to merge 2.6.26.8 into 2.6.21. That's
how we do such things where I work (although not with the
kernel), and it's working wonderfully (we had that multi-
conflict problem earlier too). Note that this will cause
you to either get a new branch-name for your release-
branch, or your current release-branch to get rebuilt.

Neither is actually horrible in this case, since you could
easily justify taking a flag-day when doing a kernel upgrade.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
