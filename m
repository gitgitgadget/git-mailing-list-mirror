From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Re: Question about possible git races
Date: Thu, 23 Mar 2006 02:24:50 +0100
Message-ID: <200603230224.54736.astralstorm@o2.pl>
References: <200603201724.12442.astralstorm@o2.pl> <4421DD9E.7030201@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7848952.8C3Stq8jVI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 02:28:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMEcf-0006Ki-Na
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 02:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWCWB2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 20:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWCWB2Q
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 20:28:16 -0500
Received: from mx.go2.pl ([193.17.41.41]:38038 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932469AbWCWB2P (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 20:28:15 -0500
Received: from zen.localdomain (host-81-190-201-167.gorzow.mm.pl [81.190.201.167])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id 9B6DE13768C;
	Thu, 23 Mar 2006 02:28:10 +0100 (CET)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FMEZW-0002AC-7k; Thu, 23 Mar 2006 02:25:06 +0100
To: Andreas Ericsson <ae@op5.se>
User-Agent: KMail/1.9.1
In-Reply-To: <4421DD9E.7030201@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17840>

--nextPart7848952.8C3Stq8jVI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 23 March 2006 00:28, Andreas Ericsson wrote yet:
> However, feeling  slightly tipsy and in a distinctly good mood, I shall t=
ry=20
to answer your questions anyway.

The golden liquid works for me, great. Thank you.

>
> > so I'd like to see if
> > there are any races:
> >
> > - push vs pull
> > One thread pushes to the repository while another is pulling from it at
> > the same time. I should get the older commit.
>
> You will. Git atomizes (atomicizes? atomicifies?) pushes by updating the
> branch head being pushed to after all the commit-, tree- and
> blob-objects are written.=20

Just as I expected. Good.

> Tags are handled separately but equally=20
> atomically.

Good too.

>
> > - fetch vs fetch
> > I mean that two threads try to fetch from different repositories to a
> > single one. Possibly those two aren't fast-forward of each other.
> > Any good way to merge those fetches?
> > (I have full access to both repos)
>
> git help octopus
>
> You can fetch those two remote branch heads to local branches
> simultaneously and then do the octopus in the master-thread while no
> other updates are happening.

I could slurp the unrelated commits with an octopus of course...
But the others pose a problem.

> Doing several simultanous merges to a=20
> single branch is quite frankly so insane I have to go get myself a drink
> just from thinking about it.

It's a rare situation in the app, but not impossible. (I want to avoid=20
locking) That's why I was asking about it.

>
> > I'm meaning really bare git there, w/o bash+perl scripts.
>
> I don't think you can do it without Python. The default merge strategy
> is written in python, so.

You've hit it, the app is written in Python (as of yet).

The default merge strategy is simply... calling merge and also detecting=20
naming/existence conflicts with a simple scalar merge.

The only bit more complicated thing is detecting the LCA for 3-way merge.


I'd like to build a decentralised collaborative web application, as scalabl=
e=20
as it gets. (I expect a lot of traffic)
I also need to only check out parts of the tree. (many SCMs can't do that)
Git, with its speed, seems well-suited to the task.
Merging will be uncommon in the workload, so can be slow, but shouldn't bre=
ak=20
or present weird conflicts to the users.

Unless the accidental case starts to dominate - then I'll have a problem.

Sorry for spam and cutting out major questions, then answering at the end o=
f=20
the post.


> Btw. I'm assuming you're aware you'll have to GPL this app of yours,
> since git is GPL and you'll be using the git produce in a way that makes
> it vital to your app.

It will be, but not because of git (it's execve()ing it), but rather becaus=
e=20
of the principle.

Intermediate results will probably be:
=2D a good Python object interface to git
=2D another porcelain, portable, coded in Python
=2D maybe a new merge strategy
=2D later yet another porcelain, written in C

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart7848952.8C3Stq8jVI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEIfjmlUMEU9HxC6IRAkO3AJ4zCyQokpz3TBLAqyB18AEJHCe8SACgjkpD
Jy3ml5ZG3WrMpuvO/TYmWGQ=
=IlhA
-----END PGP SIGNATURE-----

--nextPart7848952.8C3Stq8jVI--
