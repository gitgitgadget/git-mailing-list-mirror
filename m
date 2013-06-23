From: John Keeping <john@keeping.me.uk>
Subject: Re: fast-import bug?
Date: Sun, 23 Jun 2013 12:09:33 +0100
Message-ID: <20130623110933.GG4676@serenity.lan>
References: <m2zjuj2504.fsf@cube.gateway.2wire.net>
 <20130622102157.GE4676@serenity.lan>
 <m2txkp1shb.fsf@cube.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 13:10:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqiBG-0006So-Km
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 13:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334Ab3FWLJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Jun 2013 07:09:45 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:32936 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab3FWLJn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 07:09:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 2D5EC198002;
	Sun, 23 Jun 2013 12:09:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id je2C1EBsY7D3; Sun, 23 Jun 2013 12:09:42 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 202BB6064E3;
	Sun, 23 Jun 2013 12:09:42 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 023DC161E481;
	Sun, 23 Jun 2013 12:09:42 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ouAon+FSqhNq; Sun, 23 Jun 2013 12:09:39 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 668FC161E509;
	Sun, 23 Jun 2013 12:09:34 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <m2txkp1shb.fsf@cube.gateway.2wire.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228736>

On Sat, Jun 22, 2013 at 07:16:48PM -0700, Dave Abrahams wrote:
>=20
> on Sat Jun 22 2013, John Keeping <john-AT-keeping.me.uk> wrote:
>=20
> > On Fri, Jun 21, 2013 at 02:21:47AM -0700, Dave Abrahams wrote:
> >> The docs for fast-import seem to imply that I can use "ls" to get =
the
> >> SHA1 of a commit for which I have a mark:
> >>=20
> >>        Reading from a named tree
> >>            The <dataref> can be a mark reference (:<idnum>) or the=
 full 40-byte
> >
> >>            SHA-1 of a Git tag, commit, or tree object, preexisting=
 or waiting to
> >>            be written. The path is relative to the top level of th=
e tree named by
> >>            <dataref>.
> >>=20
> >>                        'ls' SP <dataref> SP <path> LF
> >>=20
> >>        See filemodify above for a detailed description of <path>.
> >>=20
> >>        Output uses the same format as git ls-tree <tree> -- <path>=
:
> >>=20
> >>            <mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT =
<path> LF
> >>=20
> >>        The <dataref> represents the blob, tree, or commit object a=
t <path> and
> >>                                                    ^^^^^^
> >>        can be used in later cat-blob, filemodify, or ls commands.
> >>=20
> >> but I can't get it to work.  It's not entirely clear it's supposed=
 to
> >> work.  What path would I pass?  Passing an empty path simply cause=
s git
> >> to report "missing ".
> >
> > Which version of Git are you using? =20
>=20
> ,----[ git --version ]
> | git version 1.8.3.1
> `----
>=20
> > I just tried this and get the error
> > "fatal: Empty path component found in input",=20
>=20
> I get that too.
>=20
> > which seems to be from commit 178e1de (fast-import: don't allow 'ls=
'
> > of path with empty components, 2012-03-09), which is included in Gi=
t
> > 1.7.9.5.
>=20
> Yes, that's at least part of the issue.  I notice git-fast-import
> rejects the root path "" for other commands, e.g. when used as the
> source of a filecopy we get the same issue.  I also note that the doc=
s
> don't make it clear that quoting the path is mandatory if it might tu=
rn
> out to be empty.

Interesting.  There are two places that can produce this error message,
tree_content_get and tree_content_set, but I wonder if this means that
tree_content_get should not be doing this check.  The two places that
call it are:

1) "parse_ls" as discussed here
2) "file_change_cr" which deals with file copy and rename.

My patch in the previous message only changes the behaviour for the
parse_ls case, but it seems that you have a valid use case for removing
this check in the file_change_cr case as well.

>                                              I also note that the doc=
s
> don't make it clear that quoting the path is mandatory if it might tu=
rn
> out to be empty.

That's not quite the case.  It looks to me like quoting the path is
mandatory if no "<dataref>" is given, and indeed the documentation says=
:

   Reading from the active commit
       This form can only be used in the middle of a commit. The path
       names a directory entry within fast-import=E2=80=99s active comm=
it. The
       path must be quoted in this case.

               'ls' SP <path> LF

> > It seems to be slightly more complicated than that though, because =
after
> > allowing empty trees I get the "missing" message for the root tree.
>=20
> Yeah, I've tried to patch Git to solve this but ran into that problem
> and gave up.
>=20
> > This seems to be because its mode is 0 and not S_IFDIR.
>=20
> Aha.
>=20
> > With the patch below, things are working as I expect=20
>=20
> Awesome; works for me, too!
>=20
> > but I don't understand why the mode of the root is not set correctl=
y
> > at this point.  Perhaps someone more familiar with fast-import will
> > have some insight...
>=20
> Yeah... there's no bug tracker for Git, right?  So if nobody pays
> attention to this thread, the problem will persist?

Yes, but I don't see that happening particularly often.  In the worst
case issues are normally documented by a failing test case.

In this case, I think I do now understand why the mode is 0: in parse_l=
s
a new tree object is created and the SHA1 of the original is copied in
but the mode is left blank; clearly this should be set to S_IFDIR when
the SHA1 is non-null.

I think the patch I now have is correct (and addresses the "copy from
root" scenario), but I need to spend some time understanding t9300 so
that I can add suitable test cases.

-- >8 --
diff --git a/fast-import.c b/fast-import.c
index 23f625f..e2c9d50 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1629,7 +1629,8 @@ del_entry:
 static int tree_content_get(
 	struct tree_entry *root,
 	const char *p,
-	struct tree_entry *leaf)
+	struct tree_entry *leaf,
+	int allow_root)
 {
 	struct tree_content *t;
 	const char *slash1;
@@ -1641,31 +1642,39 @@ static int tree_content_get(
 		n =3D slash1 - p;
 	else
 		n =3D strlen(p);
-	if (!n)
+	if (!n && !allow_root)
 		die("Empty path component found in input");
=20
 	if (!root->tree)
 		load_tree(root);
+
+	if (!n) {
+		e =3D root;
+		goto found_entry;
+	}
+
 	t =3D root->tree;
 	for (i =3D 0; i < t->entry_count; i++) {
 		e =3D t->entries[i];
 		if (e->name->str_len =3D=3D n && !strncmp_icase(p, e->name->str_dat,=
 n)) {
-			if (!slash1) {
-				memcpy(leaf, e, sizeof(*leaf));
-				if (e->tree && is_null_sha1(e->versions[1].sha1))
-					leaf->tree =3D dup_tree_content(e->tree);
-				else
-					leaf->tree =3D NULL;
-				return 1;
-			}
+			if (!slash1)
+				goto found_entry;
 			if (!S_ISDIR(e->versions[1].mode))
 				return 0;
 			if (!e->tree)
 				load_tree(e);
-			return tree_content_get(e, slash1 + 1, leaf);
+			return tree_content_get(e, slash1 + 1, leaf, 0);
 		}
 	}
 	return 0;
+
+found_entry:
+	memcpy(leaf, e, sizeof(*leaf));
+	if (e->tree && is_null_sha1(e->versions[1].sha1))
+		leaf->tree =3D dup_tree_content(e->tree);
+	else
+		leaf->tree =3D NULL;
+	return 1;
 }
=20
 static int update_branch(struct branch *b)
@@ -2415,7 +2424,7 @@ static void file_change_cr(struct branch *b, int =
rename)
 	if (rename)
 		tree_content_remove(&b->branch_tree, s, &leaf);
 	else
-		tree_content_get(&b->branch_tree, s, &leaf);
+		tree_content_get(&b->branch_tree, s, &leaf, 1);
 	if (!leaf.versions[1].mode)
 		die("Path %s not in branch", s);
 	if (!*d) {	/* C "path/to/subdir" "" */
@@ -3051,6 +3060,8 @@ static void parse_ls(struct branch *b)
 		struct object_entry *e =3D parse_treeish_dataref(&p);
 		root =3D new_tree_entry();
 		hashcpy(root->versions[1].sha1, e->idx.sha1);
+		if (!is_null_sha1(root->versions[1].sha1))
+			root->versions[1].mode =3D S_IFDIR;
 		load_tree(root);
 		if (*p++ !=3D ' ')
 			die("Missing space after tree-ish: %s", command_buf.buf);
@@ -3065,7 +3076,7 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p =3D uq.buf;
 	}
-	tree_content_get(root, p, &leaf);
+	tree_content_get(root, p, &leaf, 1);
 	/*
 	 * A directory in preparation would have a sha1 of zero
 	 * until it is saved.  Save, for simplicity.
