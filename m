From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 15:23:59 +0200
Message-ID: <200610221524.00408.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <200610221105.26421.jnareb@gmail.com> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jan Hudec" <bulb@ucw.cz>, bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Carl Worth" <cworth@cworth.org>, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:23:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbdIv-0004Hs-0n
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWJVNXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 09:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWJVNXs
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:23:48 -0400
Received: from hu-out-0506.google.com ([72.14.214.233]:923 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750878AbWJVNXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:23:47 -0400
Received: by hu-out-0506.google.com with SMTP id 28so797052hub
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 06:23:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TjZykctOaJstgI+9kyoXG7G0pMmS50AK4+JXHAUMnbwDjXOoeQ25DSHW7gqkjsUFEySixPZVAKv8lJvU+f431TAoFBHXka1aDuBLm32VC989HgqzkaGVSodF5thPhZnX1H0LvUdF+VlfsnywqZB68QrVU6lXEnk43+8+DuFHoms=
Received: by 10.66.216.6 with SMTP id o6mr5422944ugg;
        Sun, 22 Oct 2006 06:23:45 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id j2sm2538500ugf.2006.10.22.06.23.44;
        Sun, 22 Oct 2006 06:23:45 -0700 (PDT)
To: "Erik =?utf-8?q?B=C3=A5gfors?=" <zindar@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29741>

Erik B=C3=A5gfors wrote:
> Jakub Nar=C4=99bski wrote:

>> For example git encourages using many short and longer-lived feature
>> branches; I don't see bzr encouraging this workflow.
>=20
> Why not? I think it really does.  And due to the fact that merges are
> merges and will show up as such, I think it's very suitable for
> feature branches.

I think I haven't properly explained what "feature branch" means.
"Feature branch" is short (or medium) lived branch, created for
development of one isolated feature. When feature is in stable
stage, we merge feature branch and forget about it. We are not
interested in the fact that given feature was developed on given
branch. BTW. for example in published git.git repository are
only available in the form of "digest" 'pu' (proposed updates)
branch.

I guess what you are talking about are long lived "development
branches" (like git.git 'maint', 'master', 'next' and 'pu' branches),
or perhaps long lived another user's clone of given git repository.

Git considers having clones of given repository totally equivalent,
and having fast-forward property more important than remembering
"which branch (which clone) has this commit came from" or at least
"this commit is from this (current) branch-clone".

You have graphical history viewers (bzr has it's own: bzr-gtk),
committer and author info, and reflog if enabled if you really,
really need this kind of information.=20
=20
> In fact, in the bzr development of bzr itself.  All commits are done
> in feature branches and then merged into bzr.dev (the main "trunk" of
> bzr) when they are considered stable.
>=20
> Consider the following
> bzr branch mainline featureA
Which if I remember correctly (at least by default) needs and generates
new working tree.

> cd featureA
> hack hack; bzr commit -m 'f1'; hack hack bzr commit -m f2; etc
> No I want to merge in mainline again
> bzr merge ../mainline; bzr commit -m merge
> hack hack; bzr commit -m f3; hack hack bzr commit -m f4; etc

As it clarified during this long discussion, bzr "branches" are
something between git branches and one-branch [local] clones.
Can you for example create branch starting from an arbitrary revision,
not only tip of branch?

The above sequence of operations can be done in (at least) two differen=
t
ways in git.

Less used:
 $ cd /somewhere/else
 $ git clone -l -s <mainrepo>/.git featureA
 $ cd featureA
 $ hack; hack; git commit -a -m "f1"; hack; hack; git commit -a -m "f2"=
; etc  =20
 $ cd <mainrepo>
 $ git pull /somewhere/else/featureA/.git
 (this does commit and merge)

But more common used is:
 $ git branch featureA mainline
 $ git checkout featureA
 $ hack; hack; git commit -a -m "f1"; hack; hack; git commit -a -m "f2"=
; etc
 $ git checkout mainline
 $ git pull . featureA
 (although this would fast-forward in this example)

> right now, I would have something line this in the branch log
> -----------------------------------------------------------------
> committer: Erik B=C3=A5gfors <erik@bagfors.nu>
> branch nick: featureA
> message:
>    f4
> -----------------------------------------------------------------
> committer: Erik B=C3=A5gfors <erik@bagfors.nu>
> branch nick: featureA
> message:
>    f3
> ----------------------------------------------------------------
> committer: Erik B=C3=A5gfors <erik@bagfors.nu>
> branch nick: featureA
> message:
>    merge
>       ---------------------------------------------------------------=
--
>       committer: Foo Bar <foo@bar.com>
>       branch nick: mainline
>       message:
>          something done in mainline
>       ---------------------------------------------------------------=
--
>       committer: Foo Bar <foo@bar.com>
>       branch nick: mainline
>       message:
>          something else done in mainline
The automatic merge message takes care of this, if we enable
merge.summary config option. For example:

commit 2c8a02263c13c6e1891e9e338eb40a4286b613e5
Merge: 2492932... 87b787a...
Author: Jakub Narebski <jnareb@gmail.com>
Date:   Sat Oct 21 13:23:19 2006 +0200

    Merge branch 'master' of git://git.kernel.org/pub/scm/git/git
   =20
    * 'master' of git://git.kernel.org/pub/scm/git/git:
      git-clone: define die() and use it.
      Fix typo in show-index.c
      pager: default to LESS=3DFRS


Another example, this time of "octopus" merge.

commit ff49fae6a547e5c70117970e01c53b64d983cd10
Merge: 7ad4ee7... 75f9007... 14eab2b... 0b35995... eee4609...
Author: Junio C Hamano <junkio@cox.net>
Date:   Fri Oct 20 18:56:14 2006 -0700

    Merge branches 'jc/diff', 'jc/diff-apply-patch', 'jc/read-tree' and=
 'pb/web' into pu
   =20
    * jc/diff:
      para walk wip
      para-walk: walk n trees, index and working tree in parallel
   =20
    * jc/diff-apply-patch:
      git-diff/git-apply: make diff output a bit friendlier to GNU patc=
h (part 2)
   =20
    * jc/read-tree:
      merge: loosen overcautious "working file will be lost" check.
   =20
    * pb/web:
      gitweb: Show project README if available

That said we couldn't do that in abovementioned example
as it is simple case of fast-forward. We have above messages
for "true merges" of two _diverging_ lines of development,
and we could use similar format for "git log". In practice
we rather use history viewers: gitk, qgit, tig, git-show-branch.

=46or example:
$ git show-branch origin next
! [origin] git-clone: define die() and use it.
 ! [next] Merge branch 'master' into next
--
 - [next] Merge branch 'master' into next
++ [origin] git-clone: define die() and use it.

> If I understand it correctly, in git, you don't really know what has
> been committed as part of this branch/repo, and what has been
> committed in another branch/repo (this is my understanding from
> reading this thread, I might be wrong, feel free to correct me again
> :) )

You can browse reflog to get to know which changes were commited
as part of this repo, and which came from other repo (other clone
of this repo).
--=20
Jakub Narebski
Poland
