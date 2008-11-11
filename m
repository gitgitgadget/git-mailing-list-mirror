From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 2/2] Document "git log --simplify-by-decoration"
Date: Tue, 11 Nov 2008 18:47:00 +0900
Message-ID: <20081111184700.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 10:48:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzprP-0007QD-9L
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 10:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbYKKJrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2008 04:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755769AbYKKJrX
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 04:47:23 -0500
Received: from karen.lavabit.com ([72.249.41.33]:40776 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755772AbYKKJrW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 04:47:22 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 0EFFCC7B03;
	Tue, 11 Nov 2008 03:47:21 -0600 (CST)
Received: from 4279.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id Y4YZCWUVZNKN; Tue, 11 Nov 2008 03:47:21 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=JakSR00+t9C79miQDt2HLiQV9YfkCjzQ2YaUo3+p0M8glSLF5Wq6Kopu43k39WfjBVxzcNOTYAv6FAO0Kq1P6F+QZQwQSzrg4VmOe2wWFJrgRS2I+pDyDUFuiDjMRG0XZ+jUgrte5akshia9rf2qQsDg/vH7deyLwP/Zt9lW39o=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100633>

Quoting "Santi B=C3=A9jar" <santi@agolina.net>:

>> +The '\--simplify-by-decoration' option can be used to treat commits=
 that
>> +are not referenced by tags as TREESAME, and treat commits that are =
tagged
>> +as !TREESAME (even when they have exactly the same tree as their pa=
rents).
>> +This can be used when you are only interested in the big picture of=
 the
>> +topology of the history.
>> +
>> +
>
> I prefer the other way around, first what it does, and then how it
> does it (but it is a general comment about the help in "History
> Simplification", at least when viewing the help for "git log").

Thank you for your comments.

In the earlier part of the description, TREESAME (or !TREESAME) is expl=
ained as a prerequisite concept for understanding how the history simpl=
ification works.  I think my description first talks about what it does=
 using the concept that was already explained (in other words, "which c=
ommits are marked as TREESAME"), and then talks about what the conseque=
nce of what it does is (in other words, "only shows the big picture").

I can swap them around.  Let's see if you like this better:

	The '\--simplify-by-decoration' option allows you to view only the
	big picture of the topology of the history, by omitting commits
	that are not referenced by tags.  Commits are marked as !TREESAME
	(in other words, kept after history simplification rules described
	above) if (1) they are referenced by tags, or (2) they change the
	contents of the paths given on the command line.  All other
	commits are marked as TREESAME (subject to be simplified away).

> And you should rewrite the line 416:
>
> Finally, there is a fourth simplification mode available
>
> as it is no longer "Finally".

Yes, I thought about it, but describing the new option at the end does =
not change the fact that the fourth simplification mode is the final on=
e.

The new option is not about a "simplification mode".  Given a set of co=
mmits marked as TREESAME and !TREESAME, simplification modes decide how=
 the history is simplified.  The new option does not add any new mode. =
Instead, it affects which commits are marked as TREESAME/!TREESAME.

=46or this reason, I also thought about moving the description of the n=
ew option before the existing text begins to talk about the simplificat=
ion modes, but decided against it.  This new option is rarely useful fo=
r everyday life (useful only once in a release cycle, maybe) and I do n=
ot think it deserves to be in the early part of the section.  The reade=
rs are first taught how the basic concept TREESAME works in the usual c=
ase, and after learning that concept, they are shown how that concept i=
s used in the history simplification mechanism.  It will only complicat=
e and confuse the readers if we talk about this new option that changes=
 the way TREESAME mark is given to commits before showing how the simpl=
ification modes work for basic cases.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
