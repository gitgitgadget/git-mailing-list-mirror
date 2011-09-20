From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Worktree vs. working copy
Date: Tue, 20 Sep 2011 22:25:57 +0200
Message-ID: <1316550362.8701.32.camel@centaur.lab.cmartin.tk>
References: <1316505022.13996.12.camel@bee.lab.cmartin.tk>
	 <CALkWK0mHQZEPKk3Dy3RSp70thcsw3x6RSvUxTuPVzzRjgsM8-A@mail.gmail.com>
	 <7vhb476ned.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-OEPQZ3wGp2u+0LUvS0as"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 22:26:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R66tR-0003KL-97
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 22:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab1ITU0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 16:26:06 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:40508 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab1ITU0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 16:26:03 -0400
Received: from [192.168.1.17] (brln-4dbc6822.pool.mediaWays.net [77.188.104.34])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 2D4F54617B;
	Tue, 20 Sep 2011 22:25:41 +0200 (CEST)
In-Reply-To: <7vhb476ned.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181793>


--=-OEPQZ3wGp2u+0LUvS0as
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-09-20 at 12:10 -0700, Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>=20
> > Hi Carlos,
> >
> > Carlos Mart=C3=ADn Nieto writes:
> >> [...]
> >>    $ git grep 'worktree' | wc -l
> >>    412
> >>    $ git grep 'working copy' | grep -v ^git-cvsserver |  wc -l
> >>    32
> >> [...]
> >
> > You might like to refer to a related discussion [1].
> >
> > [1]: http://thread.gmane.org/gmane.comp.version-control.git/159287/focu=
s=3D160083
>=20
> Sorry, I do not see "working tree" discussion there. The discussion on
> that quoted thread was about remote-tracking branches, no?
>=20
> Historically, we used to say "working tree" and "worktree" more or less
> interchangeably, and over time we tried to update the documentation to us=
e
> "working tree" consistently, even though the latter is still seen in
> places like "GIT_WORK_TREE" environment variable (which will _not_
> change).
>=20
> But as far as I recall, we have never referred to the working tree
> controlled by a git repository as "working copy".

The config man page has three mentions, diff-lib.c has one,
merge-recursive.c three and perl/Git.pm nine.

This patch covers the documentation and C code. I'll move the perl code
over if you want, but I'm not sure how well maintained or relevant that
part of the codebase is.

--- 8< ---

Subject: [PATCH] Remove 'working copy' from the documentation and C code

The git term is 'working tree', so replace the most public references
to 'working copy'.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 Documentation/config.txt  |    6 +++---
 Documentation/git-svn.txt |    2 +-
 diff-lib.c                |    2 +-
 merge-recursive.c         |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b93777..c3f22f3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -147,7 +147,7 @@ advice.*::
=20
 core.fileMode::
 	If false, the executable bit differences between the index and
-	the working copy are ignored; useful on broken filesystems like FAT.
+	the working tree are ignored; useful on broken filesystems like FAT.
 	See linkgit:git-update-index[1].
 +
 The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
@@ -179,7 +179,7 @@ is created.
=20
 core.trustctime::
 	If false, the ctime differences between the index and the
-	working copy are ignored; useful when the inode change time
+	working tree are ignored; useful when the inode change time
 	is regularly modified by something outside Git (file system
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
@@ -292,7 +292,7 @@ core.ignoreStat::
 	If true, commands which modify both the working tree and the index
 	will mark the updated paths with the "assume unchanged" bit in the
 	index. These marked files are then assumed to stay unchanged in the
-	working copy, until you	mark them otherwise manually - Git will not
+	working tree, until you mark them otherwise manually - Git will not
 	detect the file changes	by lstat() calls. This is useful on systems
 	where those are very slow, such as Microsoft Windows.
 	See linkgit:git-update-index[1].
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 713e523..4ba6f61 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -297,7 +297,7 @@ Any other arguments are passed directly to 'git log'
        Show what revision and author last modified each line of a file. Th=
e
        output of this mode is format-compatible with the output of
        `svn blame' by default. Like the SVN blame command,
-       local uncommitted changes in the working copy are ignored;
+       local uncommitted changes in the working tree are ignored;
        the version of the file in the HEAD revision is annotated. Unknown
        arguments are passed directly to 'git blame'.
 +
diff --git a/diff-lib.c b/diff-lib.c
index 9c29293..c7d33d7 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -289,7 +289,7 @@ static void show_new_file(struct rev_info *revs,
=20
 	/*
 	 * New file in the index: it might actually be different in
-	 * the working copy.
+	 * the working tree.
 	 */
 	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
 	    &dirty_submodule, &revs->diffopt) < 0)
diff --git a/merge-recursive.c b/merge-recursive.c
index db9ba19..0c9f77e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -337,7 +337,7 @@ static void make_room_for_directories_of_df_conflicts(s=
truct merge_options *o,
 						      struct string_list *entries)
 {
 	/* If there are D/F conflicts, and the paths currently exist
-	 * in the working copy as a file, we want to remove them to
+	 * in the working tree as a file, we want to remove them to
 	 * make room for the corresponding directory.  Such paths will
 	 * later be processed in process_df_entry() at the end.  If
 	 * the corresponding directory ends up being removed by the
--=20
1.7.5.2.354.g349bf



--=-OEPQZ3wGp2u+0LUvS0as
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOePbVAAoJEHKRP1jG7ZzTKcUH/ieSIz5PgTDa5WmUm8APOG1j
DarUFmhJR1vJrMerr/IjCPNhL4abp2Q8FB/9RikJWx6RKoafn4zxYH4pBEZ1H2e5
7HdAzM6jrvcK2zWcMKu4SelWKDjpmEn53sviUBajxq/7bLy9mf5KUNCNh68yO6wK
9g2szchrzOMggG/jP6QtBKqf5iR1BYi+3lCyeZKbs5PdVSeFPhW481UTiOTE/vpj
ab5q2U3eCWSf4+V+UJ9Uczzrgc/TFxMun2nzV3oNPMiIgm0ZwovJ7avJ58NQLFQi
l8jZ3XhA3v0xYBDY9krWeTiUuUgm5GiWWZMjWaIF5Q325a2klGplLtjdqvEL2ZU=
=VP2e
-----END PGP SIGNATURE-----

--=-OEPQZ3wGp2u+0LUvS0as--
