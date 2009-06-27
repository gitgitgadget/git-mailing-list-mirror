From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Could this be done simpler?
Date: Fri, 26 Jun 2009 17:26:33 -0700
Message-ID: <7vtz22o72e.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>
	<7veit9m8cs.fsf@alter.siamese.dyndns.org>
	<863a9oz8lh.fsf@blue.stonehenge.com> <4A43A6B3.5020407@gmx.de>
	<7v3a9ogr8f.fsf@alter.siamese.dyndns.org>
	<op.uv3ogqin1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Matthias Andree" <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 27 02:26:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKLkg-0001VY-3N
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 02:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbZF0A0d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 20:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbZF0A0c
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 20:26:32 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62952 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbZF0A0b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 20:26:31 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090627002634.BUDM18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Fri, 26 Jun 2009 20:26:34 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 8oSa1c0014aMwMQ04oSaRt; Fri, 26 Jun 2009 20:26:34 -0400
X-VR-Score: -130.00
X-Authority-Analysis: v=1.0 c=1 a=YjxVEfEYJ9cA:10 a=Gug_5fj00tGTSgTR2DoA:9
 a=e3FHnsml7I8FUjA8GbgA:7 a=Ofv2b2wr-NBsH7nbEdyjs-HaKRQA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <op.uv3ogqin1e62zd@merlin.emma.line.org> (Matthias Andree's message of "Thu\, 25 Jun 2009 23\:54\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122342>

"Matthias Andree" <matthias.andree@gmx.de> writes:

> Neither am I a native writer, why bother=E2=80=A6 it's more important=
 to write
> things clearly than to polish things,...

Hey, calm down.

The current documentation was written back when everybody knew what git
fetch internally did (e.g. left state in .git/FETCH_HEAD) and describin=
g
things from the perspective of what is done internally was "accepted" b=
ack
when the alternative was not describing anything in any form ;-)

I took your two questions literally as they were.  That is,=20

 * You, like other people, realize that times have changed since then, =
and
   noticed that even with the correct rendition (it appears the problem
   Merlyn saw was primarily caused by Asciidoc toolchain), the bottom-u=
p
   description based on what is done internally is not sufficient.

 * You are volunteering to make things better, but you first need input=
 to
   make sure the result is not just readable but technically correct.

 * And I was among the few people who were around when .git/FETCH_HEAD =
and
   "git fetch --append" were invented to give precise answers to these
   questions.

No way I meant that these two answers should replace the current
documentation.

> Let's change roles (or perspective) for a moment, for the sake of
> clarity  and usability: I am just a Git user. I don't want to hack
> Git. I couldn't  care less about implementation details such as
> FETCH_HEAD, I only need to  know how I can tell Git to merge branches
> foo, bar, baz into master in one  single merge.

Yes, that is the good starting point.

> "git pull" (at bird eye's view) is just a short-cut for "git fetch
> something" and "git merge with somehow configured branch" (somehow =3D
> implicitly through setting up tracking branches, or clone)

Actually the latter is "with information somehow left by git-fetch".

> FETCH_HEAD(5)
> -------------------------------------------------
> This file in the git directory records which heads have been
> downloaded,  from where, and for what purpose. Each line in this file
> is one  TAB-delimited record with three fields. From left to right,
> these fields  contain:
>
> 1 - the commit of the remote head
> 2 - "not-for-merge" if the branch is not meant to be merged,
> otherwise,  this field remains empty
> 3 - branch 'xxx' of UUU, where xxx and UUU are the remote repository'=
s
> refname and base URL, respectively.
>
> This file is written by git-fetch and used by git-merge.
> -------------------------------------------------

It is true that git-merge does use it, but not under its normal mode of
operation.  Unless the reader of this paragraph is hacking git, I do no=
t
think s/he needs to (nor wants to) know about it.  IIRC, it only trigge=
rs
if you do

	$ git merge FETCH_HEAD

The more prominent user is git-pull.  git-fetch leaves the instructions=
 to
git-pull so that the latter knows what to use when it drives git-merge =
in
this file.

> git-fetch(1)
> -------------------------------------------------
> ...
>      -a::
>      --append::
> 	This option allows you to fetch and accumulate multiple remote
> refs for  future merging.  Normally, git-fetch records the latest
> fetch for a later  merge, by writing them to .git/FETCH_HEAD (there
> can be multiple recorded  heads in FETCH_HEAD although the name
> suggests there were just one).

I personally find the parenthesized comment at the end just distracting
and confusing.  You are explicitly saying "by writing THEM" so it is cl=
ear
that the file can and does record more than one when the user instructs
the command to.

> ....  The  --append option lets git-fetch
> keep, rather than delete, prior contents of  the file.  This can be
> ueful when consolidating multiple topic branches in  one single merge
> (a so-called octopus merge, see git-merge(1)). Example:

The description lacks one important point.  It can be useful only when
consolidating multiple topic branches _that come from more than one rem=
ote
repositories_

Other than that, the above paragraph is perfect.

> NOTE: git-fetch accepts command lines without refspec. These mark
> fetched  heads as "not-for-merge". IOW, a refspec is needed that head=
s
> are marked  as for-merge. I haven't found this documented in
> git-fetch.

Sorry, I have no idea what you are talking about in these four lines.

Perhaps "DEFAULT BEHAVIOUR" section in Documentation/git-pull.txt, the
paragraph that begins with "The rule to determine which remote branch t=
o
merge ..." may be what you are looking for?
