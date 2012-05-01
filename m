From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Newbie grief
Date: Mon, 30 Apr 2012 21:37:59 -0400
Message-ID: <201205010137.q411bxaU002449@no.baka.org>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>
        <4F9F28F5.2020403@palm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Tue May 01 03:38:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP238-000608-3B
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 03:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab2EABiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 21:38:04 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:55077 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab2EABiD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 21:38:03 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q411bx9i024295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Apr 2012 21:37:59 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q411bxaU002449;
	Mon, 30 Apr 2012 21:37:59 -0400
In-reply-to: <4F9F28F5.2020403@palm.com>
Comments: In reply to a message from "Rich Pixley <rich.pixley@palm.com>" dated "Mon, 30 Apr 2012 17:06:13 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196643>


In message <4F9F28F5.2020403@palm.com>, Rich Pixley writes:

    On 4/30/12 16:31 , Seth Robertson wrote:
    >      It seems that git is allergic to the dual head branch soluti=
on or
    >      something, which is surprising and disappointing.
    >
    > Git tracks your version of master separately from each other remo=
te's
    > master.  This is exactly dual/multiple heads.
    No, it isn't at all.

    Multiple heads are the idea that a single commit can "branch" in th=
e
    repository and that /both /commits can be HEADS of the same branch =
at
    once in a single repository.  This allows a potential collision to =
exist
    in the repository and to be pushed and pulled through multiple
    repositories.  It also largely eliminates this entire discussion si=
nce
    each of the intermediate repositories between, say, you and I can c=
arry
    the collision.  Either you or I, at will, can merge these heads jus=
t
    like we'd merge any other two commits, push, etc.

    That would seem to be the obvious and intuitive behavior, not
    arbitrarily preventing the transfer.

I still don't see how git isn't providing this to you, with the caveat
that in git, a single commit with a specific SHA1 hash is constant.
You may modify it (making it a new commit), modify its history (making
it a new commit), or add new commits after it.  Git doesn't number
commits the way other VCS do, which may be the source of confusion.

A specific commit with a specific SHA1 can be at the head of multiple
branches.  Those branch may be local to the repository, local tracking
branches, or remote tracking branches.

Contrarywise, the head of the "master" (or any) branch (or ref) may
point to any SHA1.  My master branch may point to one SHA1, yours may
point to another.  You can look at my version of master and I can look
at your version of master (permissions permitting).  After appropriate
network operations, either you, or I, at will, can merge these heads
just like we'd merge any other two commits, push, etc.  With
appropriate naming conventions, we can even continue parallel updates
where I can make updates to your version of master and you can make
updates to my version of master, in addition to our own.

=46or example, in the diagram http://mercurial.selenic.com/wiki/Head
rev2 might be your version of master and rev3 might be my version.
Both might exist in my repository and both might exist in your
repository, and both might have the symbolic name "master" associated
with it, and git would keep it entirely straight.

    >    What git *does* forbid
    > (by default) is:
    >
    > 1: Letting you update someone else's checked out (non-bare) repos=
itory
    > underneath them
    Yeah.  That "underneath them" thing is confusing.  I don't see any
    reason why that should necessarily be so.

    Git knows what commit is checked out.  That's HEAD, yes?  So what's
    wrong with letting it collect other commits from other repositories
    while your working directory sits?

It does!  It can! What is forbidden is for me update what you have
checked out.  Can you conceive of a revision control system where I
commit I would make would change what you have checked out?  (Well, I
can, ClearCase with dynamic views, and it is more horrible than you
can imagine=E2=80=94I've had compile fail because the files changed und=
erneath
my feet between the start of the compile and the end of the compile).
And what happens if the file I changed is also the file you are in the
middle of changing?  Is your change going to overwrite mine?  Is mine
going to overwrite yours?  This way leads to insanity.

    You can always commit your change right on top of what's checked
    out, creating a second head for that branch.

With git, you must always commit your change right on top of what's
checked out, though of course you may decide to change what's checked
out and "float" the changes you made over to the new head (trivial, as
long as there are not conflicts between the two heads and the changes
you made).  However, only the user of the repository is allowed to do
this.  A remote user is not allowed to change what's checked out.

    Yes, I've read that git-diff, etc, are all making assumptions that =
fail
    in this case, but there's nothing significantly different about
    collecting commits to other branches and collecting commits to the
    branch you're currently checked out from.

Yes there is.  Consider this use case.  You can I both spot DIFFERENT
bugs.  You and I both start editing filea.  I fix my problem one way
which involves lines 10, 100, and 500, you fix your problem which
involves line 10, 100, and 200.  I'm typing faster than you so I
commit/push first.  If I can update your HEAD, at that point I've
changed the file you are editing. You save and my change is lost.

Now this is where you say, if git only supported multiple HEADs the
problem would go away.  I could update my version of master and you
could update your version of master and there would be no conflict.
And...of course you can with git.  I don't update your master, what
you have checked out, I update what you know is my master.  Then when
you are done, you get to say "merge my master with your master" or
"instead of committing this change on my branch, let me try this last
change I made on top of the changes you made" or whatever you want to
say.

    > 2: Letting you update someone else's repository if they have more
    > recent changes than you do.
    Again, if they have more recent changes, then my line of changes sh=
ould
    create a fresh HEAD on that branch.  Then the repositories hold all=
 of
    our changes to be merged at our leisure.

And...git does this.  Your changes are made on your HEAD (your
branch).  My changes are made on my HEAD (my branch).  Never the twain
shall meet until someone says "merge" (or "rebase").

The key to all of this is the namespace naming convention.
refs/remotes/<remotename>/<branchname> (or more informally
<remotename>/<branchname>) is a remote tracking branch, or my idea of
what your branches (HEADs) currently are.  These are (kinda/sorta)
read-only reference which are only updated when you specifically ask
them to be updated, or if I decide to update what you believe I have
(kinda rude, but allowed).

So let us consider a specific example.  There is a repository which
everyone call's "Rich" (they don't need to use the same name, but it
reduces confusion), a repository everyone calls "Seth", and a central
repository everyone calls "origin".

Location   Branchname
--------   ----------
origin     foo		(bare)
rodger	   foo
rodger	   origin/foo
rodger	   seth/foo
seth	   foo
seth	   origin/foo
seth	   rodger/foo

I make a change in my foo.  I can push the change into origin's foo,
rodger's seth/foo (and technically origin/foo but that is more than
just rude).  You can take my change and store it in seth/foo.

At any point, after you have the changes (either because I push them
or you fetch them) you can then merge your work with my work.

So...what's not possible?

					-Seth Robertson
