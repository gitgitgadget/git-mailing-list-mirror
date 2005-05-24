From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 16:03:31 -0400
Message-ID: <42938893.9010608@cobite.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240849050.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240911050.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090407020306000900030906"
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:03:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DafbZ-00064g-GQ
	for gcvg-git@gmane.org; Tue, 24 May 2005 22:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVEXUD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 16:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVEXUD5
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 16:03:57 -0400
Received: from iris.cobite.com ([208.222.83.2]:49282 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S261993AbVEXUDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 16:03:32 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 52CDD984E1; Tue, 24 May 2005 16:03:25 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11210-10; Tue, 24 May 2005 16:03:25 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id 129B39888E; Tue, 24 May 2005 16:03:25 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id BB0B1984E1; Tue, 24 May 2005 16:03:24 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505240911050.2307@ppc970.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------090407020306000900030906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Tue, 24 May 2005, Linus Torvalds wrote:
> 
>>Fixing the branch handling shows that cvsps does some really strange
>>things with the newly added "Ancestor grpah". Here's one example:
> 
> 
> Ahh, looking at cvsps source, I think I see what's going on. 
> 
> It's deciding the "previous branch" by looking at what the previous branch 
> for the first individual file in the PatchSet was, which fails because in 
> this case, PatchSet 372 was changing "syslinux.doc", and Patchset 374 was 
> changing "syslinux.c", and thus the previous version of the individual 
> _files_ were both in the HEAD branch.
> 
> So it does look like I should just ignore the "Ancestor branch" 
> information if the new branch already existed.
> 

I've attached what I just committed.  The previous 'show ancestor' patch 
needs to be reversed and this applied.  It works for me on a half-dozen 
repos including syslinux.

You no longer should need to work around multiple reporting of the 
ancestor for a given branch, though it couldn't hurt.

I'm going to finish getting some of Thomas's patches in and make an 
actual release so people won't have to scour the lists.

David

--------------090407020306000900030906
Content-Type: text/x-patch;
 name="show-branch-ancestry-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="show-branch-ancestry-2.patch"

---------------------
PatchSet 176 
Date: 2005/05/24 19:57:37
Author: david
Branch: HEAD
Tag: (none) 
Log:
show branch ancestry

Members: 
	cvsps.c:4.99->4.100 
	cvsps_types.h:4.9->4.10 

Index: cvsps/cvsps.c
diff -u cvsps/cvsps.c:4.99 cvsps/cvsps.c:4.100
--- cvsps/cvsps.c:4.99	Wed Jan 26 14:46:41 2005
+++ cvsps/cvsps.c	Tue May 24 15:57:37 2005
@@ -26,7 +26,7 @@
 #include "cap.h"
 #include "cvs_direct.h"
 
-RCSID("$Id: cvsps.c,v 4.99 2005/01/26 19:46:41 david Exp $");
+RCSID("$Id: cvsps.c,v 4.100 2005/05/24 19:57:37 david Exp $");
 
 #define CVS_LOG_BOUNDARY "----------------------------\n"
 #define CVS_FILE_BOUNDARY "=============================================================================\n"
@@ -75,6 +75,7 @@
 static int do_write_cache;
 static int statistics;
 static const char * test_log_file;
+static struct hash_table * branch_heads;
 
 /* settable via options */
 static int timestamp_fuzz_factor = 300;
@@ -101,6 +102,7 @@
 static int cvs_direct;
 static int compress;
 static char compress_arg[8];
+static int track_branch_ancestry;
 
 static void check_norc(int, char *[]);
 static int parse_args(int, char *[]);
@@ -112,7 +114,7 @@
 static void assign_pre_revision(PatchSetMember *, CvsFileRevision * rev);
 static void check_print_patch_set(PatchSet *);
 static void print_patch_set(PatchSet *);
-static void set_ps_id(const void *, const VISIT, const int);
+static void walk_all_ps(const void *, const VISIT, const int);
 static void show_ps_tree_node(const void *, const VISIT, const int);
 static int compare_patch_sets_bk(const void *, const void *);
 static int compare_patch_sets(const void *, const void *);
@@ -131,6 +133,7 @@
 static int check_rev_funk(PatchSet *, CvsFileRevision *);
 static CvsFileRevision * rev_follow_branch(CvsFileRevision *, const char *);
 static int before_tag(CvsFileRevision * rev, const char * tag);
+static void determine_branch_ancestor(PatchSet * ps, PatchSet * head_ps);
 
 int main(int argc, char *argv[])
 {
@@ -164,6 +167,7 @@
 
     file_hash = create_hash_table(1023);
     global_symbols = create_hash_table(111);
+    branch_heads = create_hash_table(1023);
 
     /* this parses some of the CVS/ files, and initializes
      * the repository_path and other variables 
@@ -197,7 +201,7 @@
     }
 
     ps_counter = 0;
-    twalk(ps_tree_bytime, set_ps_id);
+    twalk(ps_tree_bytime, walk_all_ps);
 
     resolve_global_symbols();
 
@@ -536,7 +540,7 @@
     debug(DEBUG_APPERROR, "             [--test-log <captured cvs log file>] [--bkcvs]");
     debug(DEBUG_APPERROR, "             [--no-rlog] [--diff-opts <option string>] [--cvs-direct]");
     debug(DEBUG_APPERROR, "             [--debuglvl <bitmask>] [-Z <compression>] [--root <cvsroot>]");
-    debug(DEBUG_APPERROR, "             [<repository>] [-q]");
+    debug(DEBUG_APPERROR, "             [-q] [-A] [<repository>]");
     debug(DEBUG_APPERROR, "");
     debug(DEBUG_APPERROR, "Where:");
     debug(DEBUG_APPERROR, "  -h display this informative message");
@@ -569,6 +573,7 @@
     debug(DEBUG_APPERROR, "  -Z <compression> A value 1-9 which specifies amount of compression");
     debug(DEBUG_APPERROR, "  --root <cvsroot> specify cvsroot.  overrides env. and working directory");
     debug(DEBUG_APPERROR, "  -q be quiet about warnings");
+    debug(DEBUG_APPERROR, "  -A track and report branch ancestry");
     debug(DEBUG_APPERROR, "  <repository> apply cvsps to repository.  overrides working directory");
     debug(DEBUG_APPERROR, "\ncvsps version %s\n", VERSION);
 
@@ -867,6 +872,13 @@
 	    continue;
 	}
 
+	if (strcmp(argv[i], "-A") == 0)
+	{
+	    track_branch_ancestry = 1;
+	    i++;
+	    continue;
+	}
+
 	if (argv[i][0] == '-')
 	    return usage("invalid argument", argv[i]);
 	
@@ -1398,6 +1410,8 @@
 	   tm->tm_hour, tm->tm_min, tm->tm_sec);
     printf("Author: %s\n", ps->author);
     printf("Branch: %s\n", ps->branch);
+    if (ps->ancestor_branch)
+	printf("Ancestor branch: %s\n", ps->ancestor_branch);
     printf("Tag: %s %s\n", ps->tag ? ps->tag : "(none)", tag_flag_descr[ps->tag_flags]);
     printf("Log:\n%s\n", ps->descr);
     printf("Members: \n");
@@ -1425,7 +1439,10 @@
     printf("\n");
 }
 
-static void set_ps_id(const void * nodep, const VISIT which, const int depth)
+/* walk all the patchsets to assign monotonic psid, 
+ * and to establish  branch ancestry
+ */
+static void walk_all_ps(const void * nodep, const VISIT which, const int depth)
 {
     PatchSet * ps;
 
@@ -1442,6 +1459,18 @@
 	{
 	    ps_counter++;
 	    ps->psid = ps_counter;
+
+	    if (track_branch_ancestry && strcmp(ps->branch, "HEAD") != 0)
+	    {
+		PatchSet * head_ps = (PatchSet*)get_hash_object(branch_heads, ps->branch);
+		if (!head_ps) 
+		{
+		    head_ps = ps;
+		    put_hash_object(branch_heads, ps->branch, head_ps);
+		}
+
+		determine_branch_ancestor(ps, head_ps);
+	    }
 	}
 	else
 	{
@@ -1912,6 +1941,7 @@
 	ps->tag_flags = 0;
 	ps->branch_add = 0;
 	ps->funk_factor = 0;
+	ps->ancestor_branch = NULL;
     }
 
     return ps;
@@ -2235,21 +2265,25 @@
     return 0;
 }
 
-/*
- * When importing vendor sources, (apparently people do this)
- * the code is added on a 'vendor' branch, which, for some reason
- * doesn't use the magic-branch-tag format.  Try to detect that now
- */
-static int is_vendor_branch(const char * rev)
+static int count_dots(const char * p)
 {
     int dots = 0;
-    const char *p = rev;
 
     while (*p)
 	if (*p++ == '.')
 	    dots++;
 
-    return !(dots&1);
+    return dots;
+}
+
+/*
+ * When importing vendor sources, (apparently people do this)
+ * the code is added on a 'vendor' branch, which, for some reason
+ * doesn't use the magic-branch-tag format.  Try to detect that now
+ */
+static int is_vendor_branch(const char * rev)
+{
+    return !(count_dots(rev)&1);
 }
 
 void patch_set_add_member(PatchSet * ps, PatchSetMember * psm)
@@ -2395,5 +2429,69 @@
 	    break;
 	}
 	i++;
+    }
+}
+
+static void determine_branch_ancestor(PatchSet * ps, PatchSet * head_ps)
+{
+    struct list_head * next;
+    CvsFileRevision * rev;
+
+    /* PatchSet 1 has no ancestor */
+    if (ps->psid == 1)
+	return;
+
+    /* HEAD branch patchsets have no ancestry, but callers should know that */
+    if (strcmp(ps->branch, "HEAD") == 0)
+    {
+	debug(DEBUG_APPMSG1, "WARNING: no branch ancestry for HEAD");
+	return;
+    }
+
+    for (next = ps->members.next; next != &ps->members; next = next->next) 
+    {
+	PatchSetMember * psm = list_entry(next, PatchSetMember, link);
+	rev = psm->pre_rev;
+	int d1, d2;
+
+	/* the reason this is at all complicated has to do with a 
+	 * branch off of a branch.  it is possible (and indeed 
+	 * likely) that some file would not have been modified 
+	 * from the initial branch point to the branch-off-branch 
+	 * point, and therefore the branch-off-branch point is 
+	 * really branch-off-HEAD for that specific member (file).  
+	 * in that case, rev->branch will say HEAD but we want 
+	 * to know the symbolic name of the first branch
+	 * so we continue to look member after member until we find
+	 * the 'deepest' branching.  deepest can actually be determined
+	 * by considering the revision currently indicated by 
+	 * ps->ancestor_branch (by symbolic lookup) and rev->rev. the 
+	 * one with more dots wins
+	 *
+	 * also, the first commit in which a branch-off-branch is 
+	 * mentioned may ONLY modify files never committed since
+	 * original branch-off-HEAD was created, so we have to keep
+	 * checking, ps after ps to be sure to get the deepest ancestor
+	 *
+	 * note: rev is the pre-commit revision, not the post-commit
+	 */
+	if (!head_ps->ancestor_branch)
+	    d1 = 0;
+	else if (strcmp(ps->branch, rev->branch) == 0)
+	    continue;
+	else if (strcmp(head_ps->ancestor_branch, "HEAD") == 0)
+	    d1 = 1;
+	else {
+	    /* branch_rev may not exist if the file was added on this branch for example */
+	    const char * branch_rev = (char *)get_hash_object(rev->file->branches_sym, head_ps->ancestor_branch);
+	    d1 = branch_rev ? count_dots(branch_rev) : 1;
+	}
+
+	d2 = count_dots(rev->rev);
+	
+	if (d2 > d1)
+	    head_ps->ancestor_branch = rev->branch;
+
+ 	//printf("-----> %d ancestry %s %s %s\n", ps->psid, ps->branch, head_ps->ancestor_branch, rev->file->filename);
     }
 }
Index: cvsps/cvsps_types.h
diff -u cvsps/cvsps_types.h:4.9 cvsps/cvsps_types.h:4.10
--- cvsps/cvsps_types.h:4.9	Mon Mar 31 18:06:18 2003
+++ cvsps/cvsps_types.h	Tue May 24 15:57:37 2005
@@ -110,6 +110,7 @@
     char *tag;
     int tag_flags;
     char *branch;
+    char *ancestor_branch;
     struct list_head members;
     /*
      * A 'branch add' patch set is a bogus patch set created automatically

--------------090407020306000900030906--
