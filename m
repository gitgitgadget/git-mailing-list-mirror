From: Elijah Newren <newren@gmail.com>
Subject: Re: request for documentation about branch surgery
Date: Mon, 6 Jul 2009 20:30:56 -0600
Message-ID: <51419b2c0907061930k71e20b42rb347b9ab8923e437@mail.gmail.com>
References: <200907070105.12821.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 04:31:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO0SX-0006Ne-L6
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 04:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbZGGCa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2009 22:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbZGGCaz
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 22:30:55 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:15220 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbZGGCay convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2009 22:30:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so11474474and.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lQqsdBiGx5UVNYT7bzmi1adAy+UEfPSzJwOOiHtcrZc=;
        b=JThJ0yevGe/WEI5mOjHPaLIeAY+jgTCELgRm9NRII+rYkErrCUSkr47SKA4WdB68zz
         hCX4UO7Htl+3RPU3jn76vRtS5RuhKvQie3lO6FiN53XB05ZpR8eXOm/al2/J3HKQZiHF
         MWF2BXjP4NsPCkOex5J7PPVfD3phOQTTwljKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oaJhCozHM7yP7z/Glqr+QNHgqhzPX9DM7MbCuL7R3/wHvuv/q0nlCI4/UyZsxJt0Sd
         X4QkJrwWf7LUBlvWlIlnJUiq1miXh2Y75f1YYFFhC/4vc3IA1IyFi6jqNhvvYguW9pGe
         zXtaDpYwKrl9Qa7+OjdHVAY1NtAyTEvjMZVVg=
Received: by 10.100.215.12 with SMTP id n12mr9709829ang.133.1246933856918; 
	Mon, 06 Jul 2009 19:30:56 -0700 (PDT)
In-Reply-To: <200907070105.12821.bruno@clisp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122818>

Hi,

It's been a long time since I read the user manual, so I'm only
comment to point out a few shortcuts (whether or not they're more
logical to present to new users) and clarifications on the usecases
you presented.

On Mon, Jul 6, 2009 at 5:05 PM, Bruno Haible<bruno@clisp.org> wrote:
> 1) After the section "Rewriting a single commit", it may be useful to
> have a section "Inserting one or more new commits". This is something=
 that
> cannot be done with the "detached head" technique. I found this seque=
nce
> of commands useful:
>
> =C2=A0If you want to add a commit in the middle of a branch:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A---C---...---Z =C2=A0 =C2=A0=
master
>
> =C2=A0=3D>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A---B---C---...---Z =C2=A0 =C2=
=A0master
>
> =C2=A0it is achieved by
>
> =C2=A0 =C2=A0$ git checkout A
> =C2=A0 =C2=A0$ git branch temp
> =C2=A0 =C2=A0$ git checkout temp
> =C2=A0 =C2=A0[make changes for B]
> =C2=A0 =C2=A0$ git commit -a
>
> =C2=A0now:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A---C---...---Z =C2=A0 =C2=A0=
master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--B =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp
>
> =C2=A0 =C2=A0$ git checkout master
> =C2=A0 =C2=A0$ git rebase temp
> =C2=A0 =C2=A0$ git branch -d temp

Or compress those 8 steps down to 4 using a detached HEAD and
multi-argument rebase:
  $ git checkout A
  [make changes for B]
  $ git commit -a
  $ git rebase HEAD master

The last command above means "rebase master against HEAD".  I think
the rebase command would be much easier to understand for new users if
it used an "--against" before the first reference(*).  For example,
"git rebase --against temp" for rebasing the current branch against
temp (instead of "git rebase temp") or "git rebase --against HEAD
master" (rather than "git rebase HEAD master"); the real git rebase
commands don't parse so well for new users and take a long time to
wrap ones' head around, whereas this simple change seems to make it
much easier.

(*) Except when --onto is specified.  Then --since may make more sense
than --against.  Also, I'm not yet suggesting we make this change
(since I have no patch handy), but note that if anyone wants to try
this then the "--against" should be optional for backwards
compatibility.  It's mostly a documentation change.

<snip case 2>
> 3) When do I need "git merge", and when do I need "git rebase", in th=
e
> =C2=A0 context of branch surgery?
>
> =C2=A0 The simple answer, that I would find worth mentioning, is:
> =C2=A0 =C2=A0 - "git merge" copies commits from one branch to another=
=2E

git merge does not copy commits at all; unlike cvs/svn, a commit may
(and often is) part of more than one branch in git.  A merge simply
creates a new commit which has more than one parent: the previous tip
of the current branch, and the tip of the other branch you are
merging.

> =C2=A0 =C2=A0 - "git rebase" only moves commits around to make histor=
y more linear.

git rebase actually doesn't move around commits; the old commits still
exist with no modifications (which is useful for undoing rebases if
you later decide you don't like them).  Instead, git rebase just
re-applies commits, effectively making an extra "copy" of each commit
(I put "copy" in quotes because the "copied" commits will have
different parents, different commit times, and potentially different
contents especially when conflict resolution is necessary, so they're
not quite copies).

> 4) It would be good to have a section "Cutting branches"
>
> =C2=A0 How do I remove the N most recent commits from a branch?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 D---E---F---G---H---=
=2E........---Y---Z master
>
> =C2=A0=3D>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 D---E master
>
> =C2=A0 It goes like this:
>
> =C2=A0 =C2=A0 $ git checkout master
> =C2=A0 =C2=A0 $ git reset --hard E

If master is the active branch, you only need the latter command.  If
master is not the active branch, then you can achieve the same with
much less cost by
  $ git branch -f master E

> 5) Then, it would be good to have a section "Replacing branches"
>
> =C2=A0 How do I copy the contents of a branch over to another branch,=
 replacing
> =C2=A0 the recent development on that branch?
>
> =C2=A0If you want to copy a branch into another, while throwing away =
commits:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 F1---F2---F3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 released
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 D---E---F---G---H---=
=2E........---Y---Z master
>
> =C2=A0=3D>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 F1---F2---F3 =C2=A0 released
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 D---E---F1---F2---F3=
 master
>
> =C2=A0This is achieved by
>
> =C2=A0 =C2=A0$ git checkout master
> =C2=A0 =C2=A0$ git reset --hard E =C2=A0 =C2=A0 =C2=A0# Cut the branc=
h "master"
> =C2=A0 =C2=A0$ git merge released =C2=A0 =C2=A0 =C2=A0# Copy commits =
from branch "released" to "master"

I'm assuming master isn't checked out.  If so, the following is faster:
  $ git branch -f master E

(If master is checked out, just 'git reset ---hard released')

> 6) Also, it would be good to have a section "Reconnecting branches af=
ter rebase".
> =C2=A0 If you want to reconnect a branch to a rebased master, here's =
how to do it:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /--C'-=
-...---P'--Q'--...---Z' =C2=A0new rebased master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A---B---C---...---P--=
-Q---...---Z =C2=A0 old master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--BA---...---BZ =C2=A0=
release-branch
>
> =C2=A0=3D>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A---B---C'--...---P'-=
-Q'--...---Z' =C2=A0new rebased master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--BA---...---BZ =C2=A0=
release-branch
>
> =C2=A0This is achieved by
>
> =C2=A0 =C2=A0$ git checkout release-branch
> =C2=A0 =C2=A0$ git rebase --onto P' P

or,
  $ git rebase --onto P' P release-branch

> This might seem exotic, but these use cases all came up while rewriti=
ng the
> history after a "git cvsimport".

They may seem exotic at first to cvs/svn refugees, but it isn't very
long before lots of users end up doing these kinds of things
routinely.

Amusing story: I spent several months at $dayjob attempting to
convince our group to switch from cvs to git instead of from cvs to
svn.  I often mentioned cool features like pulling directly from other
developers, but was often ignored and laughed off for mentioning
exotic cases that nearly no one would care about.  And our surveys
showed that most developers didn't care about anything other than
"checkout, update, and commit".  I succeeded in the end anyway, and we
found out that developers only cared about simple stuff because cvs
made anything else painful.  The very first week after switching to
git, we had multiple requests from people about how to pull changes
directly from other developers (including from people that previously
only cared about "checkout, update, and commit").

When the cost of certain activities changes dramatically (which git
does by making lots new things possible and fast), formerly "exotic"
usecases can become natural and common -- and really helpful.


Anyway, I hope some of my ramblings are useful to you.

Elijah
