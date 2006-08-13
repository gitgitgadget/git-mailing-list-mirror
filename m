From: Junio C Hamano <junkio@cox.net>
Subject: Re: recur status on linux-2.6
Date: Sun, 13 Aug 2006 12:44:57 -0700
Message-ID: <7vveowl8sm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64gwmv2j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608132006510.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 21:45:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCLtP-00076S-BJ
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 21:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWHMTo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 15:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWHMTo7
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 15:44:59 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:3737 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751381AbWHMTo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 15:44:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060813194458.LERY23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 15:44:58 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608132006510.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 13 Aug 2006 20:16:29 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25291>

--=-=-=

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I fail to see how this is worse than -recursive...

These are what I got.  ls-files -u output followed by git diff.


--=-=-=
Content-Disposition: inline; filename*=us-ascii''%3arecur.out
Content-Description: output from recur

100644 255988a47f56bfa9364c6aff54e45de252b376b8 1	Makefile
100644 07c421bd266724b966fdc92cbc24ef77d61c0d48 2	Makefile
100644 a538710ed6b53079f85582c83be11ae414380d15 3	Makefile
100644 fad39ff609f3ea27981e7a9ffdfc29731d1065d0 1	upload-pack.c
100644 bbd6bd60b52d806be0a69324009755f49b070082 2	upload-pack.c
100644 e8f4be373cfd0ce03617c5fa1494bf52d4babc6c 3	upload-pack.c
diff --cc Makefile
index 07c421b,a538710..0000000
--- a/Makefile
+++ b/Makefile
@@@ -253,7 -242,7 +253,11 @@@
  	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
  	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
  	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
++<<<<<<< HEAD/Makefile
 +	alloc.o merge-file.o path-list.o unpack-trees.o help.o $(DIFF_OBJS)
++=======
+ 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS)
++>>>>>>> 937a515a15f776aa84430574f71367292a52b978/Makefile
  
  BUILTIN_OBJS = \
  	builtin-add.o \
diff --cc upload-pack.c
index bbd6bd6,e8f4be3..0000000
--- a/upload-pack.c
+++ b/upload-pack.c
@@@ -327,7 -334,7 +334,11 @@@
  	if (get_sha1_hex(hex, sha1))
  		die("git-upload-pack: expected SHA1 object, got '%s'", hex);
  	if (!has_sha1_file(sha1))
++<<<<<<< HEAD/upload-pack.c
 +		return 0;
++=======
+ 		return -1;
++>>>>>>> 937a515a15f776aa84430574f71367292a52b978/upload-pack.c
  
  	o = lookup_object(sha1);
  	if (!(o && o->parsed))
@@@ -343,8 -354,73 +358,76 @@@
  		     parents;
  		     parents = parents->next)
  			parents->item->object.flags |= THEY_HAVE;
++<<<<<<< HEAD/upload-pack.c
++=======
+ 	}
+ 	if (!we_knew_they_have) {
+ 		add_object_array(o, NULL, &have_obj);
+ 		return 1;
+ 	}
+ 	return 0;
+ }
+ 
+ static int reachable(struct commit *want)
+ {
+ 	struct commit_list *work = NULL;
+ 
+ 	insert_by_date(want, &work);
+ 	while (work) {
+ 		struct commit_list *list = work->next;
+ 		struct commit *commit = work->item;
+ 		free(work);
+ 		work = list;
+ 
+ 		if (commit->object.flags & THEY_HAVE) {
+ 			want->object.flags |= COMMON_KNOWN;
+ 			break;
+ 		}
+ 		if (!commit->object.parsed)
+ 			parse_object(commit->object.sha1);
+ 		if (commit->object.flags & REACHABLE)
+ 			continue;
+ 		commit->object.flags |= REACHABLE;
+ 		if (commit->date < oldest_have)
+ 			continue;
+ 		for (list = commit->parents; list; list = list->next) {
+ 			struct commit *parent = list->item;
+ 			if (!(parent->object.flags & REACHABLE))
+ 				insert_by_date(parent, &work);
+ 		}
+ 	}
+ 	want->object.flags |= REACHABLE;
+ 	clear_commit_marks(want, REACHABLE);
+ 	free_commit_list(work);
+ 	return (want->object.flags & COMMON_KNOWN);
+ }
+ 
+ static int ok_to_give_up(void)
+ {
+ 	int i;
+ 
+ 	if (!have_obj.nr)
+ 		return 0;
+ 
+ 	for (i = 0; i < want_obj.nr; i++) {
+ 		struct object *want = want_obj.objects[i].item;
+ 
+ 		if (want->flags & COMMON_KNOWN)
+ 			continue;
+ 		want = deref_tag(want, "a want line", 0);
+ 		if (!want || want->type != OBJ_COMMIT) {
+ 			/* no way to tell if this is reachable by
+ 			 * looking at the ancestry chain alone, so
+ 			 * leave a note to ourselves not to worry about
+ 			 * this object anymore.
+ 			 */
+ 			want_obj.objects[i].item->flags |= COMMON_KNOWN;
+ 			continue;
+ 		}
+ 		if (!reachable((struct commit *)want))
+ 			return 0;
++>>>>>>> 937a515a15f776aa84430574f71367292a52b978/upload-pack.c
  	}
- 	add_object_array(o, NULL, &have_obj);
  	return 1;
  }
  

--=-=-=
Content-Disposition: inline; filename*=us-ascii''%3arecursive.out
Content-Description: output from recursive

100644 99048d0a128186e70f329208a734cc9e72c1a3e7 1	Makefile
100644 07c421bd266724b966fdc92cbc24ef77d61c0d48 2	Makefile
100644 a538710ed6b53079f85582c83be11ae414380d15 3	Makefile
100644 b6cc43c3c89c68e950c6d86298c928e9aab25e70 1	upload-pack.c
100644 bbd6bd60b52d806be0a69324009755f49b070082 2	upload-pack.c
100644 e8f4be373cfd0ce03617c5fa1494bf52d4babc6c 3	upload-pack.c
diff --cc Makefile
index 07c421b,a538710..0000000
--- a/Makefile
+++ b/Makefile
@@@ -253,7 -242,7 +253,11 @@@
  	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
  	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
  	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
++<<<<<<< HEAD/Makefile
 +	alloc.o merge-file.o path-list.o unpack-trees.o help.o $(DIFF_OBJS)
++=======
+ 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS)
++>>>>>>> 937a515a15f776aa84430574f71367292a52b978/Makefile
  
  BUILTIN_OBJS = \
  	builtin-add.o \
diff --cc upload-pack.c
index bbd6bd6,e8f4be3..0000000
--- a/upload-pack.c
+++ b/upload-pack.c
@@@ -327,7 -334,7 +334,11 @@@
  	if (get_sha1_hex(hex, sha1))
  		die("git-upload-pack: expected SHA1 object, got '%s'", hex);
  	if (!has_sha1_file(sha1))
++<<<<<<< HEAD/upload-pack.c
 +		return 0;
++=======
+ 		return -1;
++>>>>>>> 937a515a15f776aa84430574f71367292a52b978/upload-pack.c
  
  	o = lookup_object(sha1);
  	if (!(o && o->parsed))

--=-=-=--
