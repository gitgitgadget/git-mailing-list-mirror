From: Florian Mickler <florian@mickler.org>
Subject: nomad workflow -- dont pull ... more like...   snatch ...or.. tear!
Date: Tue, 31 Mar 2009 02:59:44 +0200
Message-ID: <20090331025944.51be8509@schatten>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AhQjhXnpEhP6haRluUlC6NY";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:01:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoSMB-0001qO-Gm
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 03:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897AbZCaBAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 21:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757714AbZCaBAB
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 21:00:01 -0400
Received: from ist.d-labs.de ([213.239.218.44]:36558 "EHLO mx01.d-labs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757639AbZCaBAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 21:00:00 -0400
Received: from schatten (f053213010.adsl.alicedsl.de [78.53.213.10])
	by mx01.d-labs.de (Postfix) with ESMTP id 28CDB83E2B
	for <git@vger.kernel.org>; Tue, 31 Mar 2009 02:59:55 +0200 (CEST)
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115204>

--Sig_/AhQjhXnpEhP6haRluUlC6NY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi!

I'm working on many different work stations during the week and have
one central repo, where i interface with an svn upstream.=20

because of (but not only because of) git svn's metadata-changes i have
the following workflow, which is currently not well supported with git.

<summary>  (for the busy reader)
    i want to be able to drop my local tracking branches in favor of
    the remote ones, but keep backup-refs and have the opportunity to
    abort if something looks funny.
  =20
i have a script which does this, which i could submit for starters...

</summary>

my workflow:

i have a remote git repository following an svn upstream. (via git svn)=20

there are 2 svn branches i do work on and some topic-branches in
which i prepare features to integrate into the svn branches.=20

When i come to work (to any random workstation), i do basically the
following:

firsy i run git-svn-rebase on my central git repo.

then i run my script, which does:

a) run git-fetch origin in my workstations git-repo.

b) for all the branches i currently work on: (eg
origin/svnStableBranch)=20

	1. git cherry origin/svnStableBranch svnStableBranch

	2. if everything is contained it skips the next 2 steps

	3. else it shows the not contained commits and waits for
	userinput (strg-c, f for full commit descriptions, or anykey to
	continue)=20

	4. it creates backup branch (named tmp_[unixtimestamp]) =20

	5. it drops local branch and creates a new tracking branch with
	the same name

at the end of my workday, i run svn rebase on origin and run my script
again.

if smth got committed before i could push my changes to the svn, i
decide if i create a new branch on origin for my work, so i can
integrate it next time, or just merge / rebase my commits now.
(recovering them from the backup-branch)

whatever i do i somehow sync my repo onto origin and dcommit
there ...maybe...

the next day i go to any workstation (probably with a working state
from a week ago), run my script to drop the local refs, and continue
working.=20

if i have rebased one of my working branches during the week,
i see the refactored log vs the old log and can happily drop the backup
branches. if i see some piece of work which i forgot to push to origin,
and which is worth saving i can do it now.

if not ... good.

Do you see my point? Is smth like this deemed useful? is this
an acceptable workflow? (dropping local refs in favor of remote ones)=20

it saves me the hazle of doublecheking the state of my
current workstation every time i change it and if i forgot to push
something a week ago or yesterday, nothing is lost.

is there any possibility that if i submitted a cleaned up version for
this called ''git snatch'' or something like this, it would be
integrated into mainline?

(because of its disruptive nature, maybe git tear would be a better
name?)


Sincerely,
Florian

--Sig_/AhQjhXnpEhP6haRluUlC6NY
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAknRawYACgkQPjqCkyL3Kv1bpACcCZuQ03GjinN7yfS7XeZ8JV4i
kh0Anjp8sDcp8uyAVfOC8NkSGPmsFT1m
=U215
-----END PGP SIGNATURE-----

--Sig_/AhQjhXnpEhP6haRluUlC6NY--
