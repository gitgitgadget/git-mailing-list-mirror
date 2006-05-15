From: Tommi Virtanen <tv@inoi.fi>
Subject: Re: The git newbie experience
Date: Mon, 15 May 2006 08:06:28 +0300
Organization: Inoi Oy
Message-ID: <44680C54.8040206@inoi.fi>
References: <446778B8.7080201@inoi.fi> <7vfyjcntro.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 07:06:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfVIC-00030v-Q1
	for gcvg-git@gmane.org; Mon, 15 May 2006 07:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWEOFGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 15 May 2006 01:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWEOFGd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 01:06:33 -0400
Received: from i1.inoi.fi ([194.100.97.46]:20383 "EHLO mail.inoi.fi")
	by vger.kernel.org with ESMTP id S1751312AbWEOFGd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 01:06:33 -0400
Received: from mail.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.inoi.fi (Postfix) with ESMTP id 8F33810C012;
	Mon, 15 May 2006 08:07:03 +0300 (EEST)
Received: from [10.116.0.191] (GMMDXXVII.dsl.saunalahti.fi [85.76.242.28])
	by mail.inoi.fi (Postfix) with ESMTP id 3639F10C00E;
	Mon, 15 May 2006 08:07:03 +0300 (EEST)
User-Agent: Mail/News 1.5 (X11/20060309)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyjcntro.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20016>

Junio C Hamano wrote:
> Anyway, I think the time to commit is too late to save somebody
> who does not understand the index.  How would you explain why
> you sometimes need to use -A and sometimes -a?=20

I guess what I really want is "a smarter -a".

> That is why I
> suggested to make "git pull" and "git merge" refuse to work if
> there are local changes for novice users, where the definition
> of novice is "git commit -a" is the only way to make a commit.
> We can have [core] novice =3D yes in .git/config for that.
>=20
> If somebody does not understand the index, if the merge is
> prevented because the local change does conflict with it, how
> would you explain why sometimes you can merge and sometimes you
> cannot?

By the same logic that is already implemented. "pull refuses to pull
changes to files that are modified but not committed".

>> For example, we had a case where we absolutely _had_ to keep
>> an ugly workaround in the tree, in a file not otherwise
>> edited, but we definitely did not want to commit the kludge,
> Your example is a very ill-thought out one.
>
> If you are leaving the uncommitable kludge around, you cannot be
> using "commit -a" with the normal non-merge workflow.  Why
> would you worry about not being able to do "commit -a" on a
> merge then?

The indexless working mode means you know two kinds of commits.
"git commit -a" or "git commit FILE..". The uncommitted kludge hanging
around means people listed file names. The case where the merge differs
is that it's not just a few files, and they didn't even really
know what files to list. And "git status" showed them something
they were not used to seeing.

> For the beginning user without index, I would rewrite your
> scenario like this.
>=20
=2E..
> - Jack stashes away what he has been working on and cleans up
>   his mess.
>=20
>   git diff >P.diff
>   git checkout HEAD A B C
=2E..
> - Jack then reapplies what he stashed away with "git apply P.diff"
>   and keeps working.
>=20
> Maybe "git stash" command that does "git diff --full-index" with
> some frills, and "git unstash" command which does an equivalent
> of "git am -3" would help this workflow (bare "git apply" does
> not do the three-way merge like am does).

Oh, I'd love to have a quick stash, that's what we actually ended up
doing a lot. Although I'd rather see a real implementation use a branch
and not just a diff file, but.. yes please.

Although, "git stash" and "git unstash" are yet another command to add
to the newbie set, and I just complained about the size of the set ;)

--=20
Inoi Oy, Tykist=F6katu 4 D (4. krs), FI-20520 Turku, Finland
http://www.inoi.fi/
Mobile +358 40 762 5656
