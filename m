From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] Update documentation of fetch-pack, push and send-pack
Date: Fri, 19 Jan 2007 13:43:00 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070119124300.GA2995@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 19 13:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7t5Y-0001Vp-05
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 13:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbXASMnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 07:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbXASMnU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 07:43:20 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:34934 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965108AbXASMnT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 07:43:19 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H7t5S-00016V-9U; Fri, 19 Jan 2007 13:43:18 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0JChFEZ012593;
	Fri, 19 Jan 2007 13:43:15 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0JCh0SM012592;
	Fri, 19 Jan 2007 13:43:00 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37177>

add all supported options to Documentation/git-....txt and the usage st=
rings.

Signed-off-by: Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.de>
---

This patch is included in this series to have the later patches only
updating the documentation to follow the code changes.

@Junio:  If you take this (or one of the following) patch(es), could yo=
u
please give me feedback on how my '=F6' got to you?

 Documentation/git-fetch-pack.txt |   21 +++++++++++++++++----
 Documentation/git-push.txt       |    2 +-
 Documentation/git-send-pack.txt  |   15 +++++++++++----
 builtin-push.c                   |    2 +-
 fetch-pack.c                     |    2 +-
 send-pack.c                      |    4 ++--
 6 files changed, 33 insertions(+), 13 deletions(-)


diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 90ef127..bd8ebac 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -8,7 +8,7 @@ git-fetch-pack - Receive missing objects from another r=
epository
=20
 SYNOPSIS
 --------
-'git-fetch-pack' [-q] [-k] [--exec=3D<git-upload-pack>] [<host>:]<dire=
ctory> [<refs>...]
+'git-fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--exec=3D<=
git-upload-pack>] [--depth=3D<n>] [-v] [<host>:]<directory> [<refs>...]
=20
 DESCRIPTION
 -----------
@@ -28,17 +28,24 @@ have a common ancestor commit.
=20
 OPTIONS
 -------
--q::
+\--all::
+	Fetch all remote refs.
+
+\--quiet, \-q::
 	Pass '-q' flag to 'git-unpack-objects'; this makes the
 	cloning process less verbose.
=20
--k::
+\--keep, \-k::
 	Do not invoke 'git-unpack-objects' on received data, but
 	create a single packfile out of it instead, and store it
 	in the object database. If provided twice then the pack is
 	locked against repacking.
=20
---exec=3D<git-upload-pack>::
+\--thin::
+	Spend extra cycles to minimize the number of objects to be sent.
+	Use it on slower connection.
+
+\--exec=3D<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
 	remote side, if is not found on your $PATH.
 	Installations of sshd ignores the user's environment
@@ -50,6 +57,12 @@ OPTIONS
 	shells by having a lean .bashrc file (they set most of
 	the things up in .bash_profile).
=20
+\--depth=3D<n>::
+	Limit fetching to ancestor-chains not longer than n.
+
+\-v::
+	Run verbosely.
+
 <host>::
 	A remote host that houses the repository.  When this
 	part is specified, 'git-upload-pack' is invoked via
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3e8dbcf..7a2e503 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -8,7 +8,7 @@ git-push - Update remote refs along with associated obj=
ects
=20
 SYNOPSIS
 --------
-'git-push' [--all] [--tags] [--exec=3D<receive-pack>] [--repo=3Dall] [=
-f | --force] [-v] [<repository> <refspec>...]
+'git-push' [--all] [--tags] [--exec=3D<git-receive-pack>] [--repo=3Dal=
l] [-f | --force] [-v] [<repository> <refspec>...]
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-p=
ack.txt
index eea8fe8..dee43a9 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -8,7 +8,7 @@ git-send-pack - Push objects over git protocol to anoth=
er reposiotory
=20
 SYNOPSIS
 --------
-'git-send-pack' [--all] [--force] [--exec=3D<git-receive-pack>] [<host=
>:]<directory> [<ref>...]
+'git-send-pack' [--all] [--force] [--exec=3D<git-receive-pack>] [--ver=
bose] [--thin] [<host>:]<directory> [<ref>...]
=20
 DESCRIPTION
 -----------
@@ -21,23 +21,30 @@ updates it from the current repository, sending nam=
ed refs.
=20
 OPTIONS
 -------
---exec=3D<git-receive-pack>::
+\--exec=3D<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
=20
---all::
+\--all::
 	Instead of explicitly specifying which refs to update,
 	update all refs that locally exist.
=20
---force::
+\--force::
 	Usually, the command refuses to update a remote ref that
 	is not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  What this means is that
 	the remote repository can lose commits; use it with
 	care.
=20
+\--verbose::
+	Run verbosely.
+
+\--thin::
+	Spend extra cycles to minimize the number of objects to be sent.
+	Use it on slower connection.
+
 <host>::
 	A remote host to house the repository.  When this
 	part is specified, 'git-receive-pack' is invoked via
diff --git a/builtin-push.c b/builtin-push.c
index 7a3d2bb..ba7981f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -8,7 +8,7 @@
=20
 #define MAX_URI (16)
=20
-static const char push_usage[] =3D "git-push [--all] [--tags] [-f | --=
force] <repository> [<refspec>...]";
+static const char push_usage[] =3D "git-push [--all] [--tags] [--exec=3D=
<git-receive-pack>] [--repo=3Dall] [-f | --force] [-v] [<repository> <r=
efspec>...]";
=20
 static int all, tags, force, thin =3D 1, verbose;
 static const char *execute;
diff --git a/fetch-pack.c b/fetch-pack.c
index 1530a94..726140a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -12,7 +12,7 @@ static int verbose;
 static int fetch_all;
 static int depth;
 static const char fetch_pack_usage[] =3D
-"git-fetch-pack [--all] [-q] [-v] [-k] [--thin] [--exec=3Dupload-pack]=
 [--depth=3D<n>] [host:]directory <refs>...";
+"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--exec=3D<g=
it-upload-pack>] [--depth=3D<n>] [-v] [<host>:]<directory> [<refs>...]"=
;
 static const char *exec =3D "git-upload-pack";
=20
 #define COMPLETE	(1U << 0)
diff --git a/send-pack.c b/send-pack.c
index 6756264..ec2c108 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -6,8 +6,8 @@
 #include "exec_cmd.h"
=20
 static const char send_pack_usage[] =3D
-"git-send-pack [--all] [--exec=3Dgit-receive-pack] <remote> [<head>...=
]\n"
-"  --all and explicit <head> specification are mutually exclusive.";
+"git-send-pack [--all] [--force] [--exec=3D<git-receive-pack>] [--verb=
ose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"  --all and explicit <ref> specification are mutually exclusive.";
 static const char *exec =3D "git-receive-pack";
 static int verbose;
 static int send_all;
--=20
1.5.0.rc1.g581a


--=20
Uwe Kleine-K=F6nig

primes where sieve (p:xs) =3D [ x | x<-xs, x `rem` p /=3D 0 ]; \
primes =3D map head (iterate sieve [2..])
