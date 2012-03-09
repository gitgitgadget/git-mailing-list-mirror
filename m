From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: teach ls command to accept empty path
Date: Fri, 9 Mar 2012 03:29:40 -0600
Message-ID: <20120309092940.GB2229@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308202721.GA8992@burratino>
 <20120308203330.GC8992@burratino>
 <CAFfmPPNnQ21qwKb_w1FCRL7Vx7CSQKYurM2zqziTw01kkRoMog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:30:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5w9G-0003PZ-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab2CIJ3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 04:29:49 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:50441 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751151Ab2CIJ3q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 04:29:46 -0500
Received: by obbuo6 with SMTP id uo6so1892730obb.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 01:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iveb66UVM/gPunRLYb2xES+AQd6xJYaISud3Hi1XmdI=;
        b=SYrzDJxKpwnjFyIa9vqz0b5VdWjjmHO531erfiGVlUYf+us6fkpboiC23zxhsZhiGM
         FFTuNy/bs3wSc7aDYNz48Jlixjr4JLHFnDR+e5ItI5L96LQ6cmA4P59dXPqPEaKnOPRl
         7cB3CXPcoFGAAFH+EZeU1tEEV1NLwmvlsSaTSUlHW9tNSZSpYS5pdnu7eAk19Y38HTBK
         iUuN9WACN2eV9LwfV9CebPDBTh6qBRy26Oqn3TBEhArqCZcF9Hy3n3u+jr6sEnLFnbyY
         pUcVLv4NqI5LMt9gVbYkIjiSVfbrBPb5oxKavP2G6K9PAEI19FtW0jKbyOwbYx17QEes
         41/w==
Received: by 10.182.231.100 with SMTP id tf4mr574499obc.56.1331285386079;
        Fri, 09 Mar 2012 01:29:46 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n1sm6641106obm.11.2012.03.09.01.29.44
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 01:29:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFfmPPNnQ21qwKb_w1FCRL7Vx7CSQKYurM2zqziTw01kkRoMog@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192699>

David Barr wrote:
> On Fri, Mar 9, 2012 at 7:33 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* store_tre=
e scribbles over version[0] in leaf.tree's
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* entries, =
so we need a deep copy.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (root->tree &&=
 is_null_sha1(root->versions[1].sha1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 leaf.tree =3D dup_tree_content(root->tree);
>
> Is it ok to call store_tree(root)?

Yes.

>                                     If so, could we not introduce a
> pointer rather than a deep copy?

If using 'ls' with an empty path after dirtying the root tree is
common, then that would work as an optimization.  The fussy bit is
making sure the call to

	release_tree_content_recursive(leaf.tree);

is skipped in this case and not skipped when tree_content_get() made a
copy.  That is, something like this (patch against fast-import-pu on
repo.or.cz/git/jrn.git):

-- >8 --
=46rom: David Barr <davidbarr@google.com>
Subject: fast-import: optimize 'ls' command with empty path to avoid a =
copy

fast-import's "ls" command normally copies a tree (implicitly, by
calling tree_content_get) before passing it to store_tree.  Otherwise:

 - after versions[0] is overwritten by versions[1] in child
   directories, it would be impossible to rebuild the tree object for
   version 0 of the current tree, so parse_ls would need to

	hashcpy(leaf.versions[0].sha1, leaf.versions[1].sha1)

   so version 0 points to a tree that can be rebuilt.

 - in turn, that would make it impossible to rebuild the tree object
   for version 0 of the parent tree.  And so on.

The above considerations do not apply when the tree we are examining
with 'ls' has no parent.  Avoid a copy in that case.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 1e5d59b4..28fe4c35 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3002,7 +3002,8 @@ static void parse_ls(struct branch *b)
 {
 	const char *p;
 	struct tree_entry *root =3D NULL;
-	struct tree_entry leaf =3D {NULL};
+	struct tree_entry leaf_storage =3D {NULL};
+	struct tree_entry *leaf =3D &leaf_storage;
=20
 	/* ls SP (<treeish> SP)? <path> */
 	p =3D command_buf.buf + strlen("ls ");
@@ -3029,17 +3030,24 @@ static void parse_ls(struct branch *b)
 			die("Garbage after path in: %s", command_buf.buf);
 		p =3D uq.buf;
 	}
-	tree_content_get(root, p, &leaf);
+	if (*p)
+		tree_content_get(root, p, leaf);
+	else
+		leaf =3D root;
+
 	/*
 	 * A directory in preparation would have a sha1 of zero
 	 * until it is saved.  Save, for simplicity.
 	 */
-	if (S_ISDIR(leaf.versions[1].mode))
-		store_tree(&leaf);
+	if (S_ISDIR(leaf->versions[1].mode)
+	    && is_null_sha1(leaf->versions[1].sha1)) {
+		store_tree(leaf);
+		hashcpy(leaf->versions[0].sha1, leaf->versions[1].sha1);
+	}
=20
-	print_ls(leaf.versions[1].mode, leaf.versions[1].sha1, p);
-	if (leaf.tree)
-		release_tree_content_recursive(leaf.tree);
+	print_ls(leaf->versions[1].mode, leaf->versions[1].sha1, p);
+	if (*p && leaf->tree)
+		release_tree_content_recursive(leaf->tree);
 	if (!b || root !=3D &b->branch_tree)
 		release_tree_entry(root);
 }
--=20
1.7.9.2
