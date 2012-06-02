From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] fix many comment typos
Date: Sat, 02 Jun 2012 10:03:31 +0200
Message-ID: <8762baf8do.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 10:03:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SajJP-0000r3-La
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 10:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966483Ab2FBIDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 04:03:46 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:40287 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966465Ab2FBIDk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 04:03:40 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 1F5A1D4800D
	for <git@vger.kernel.org>; Sat,  2 Jun 2012 10:03:32 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id AE32B63F18
	for <git@vger.kernel.org>; Sat,  2 Jun 2012 10:03:31 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199033>


Use http://github.com/lyda/misspell-check to identify many typos.
Culprits identified and fixed automatically using these commands,
converting diagnostics to single-quote-safe sed -i commands:

git ls-files|misspellings -f -|perl -nl \
  -e '/^(.*?)\[(\d+)\]: (\w+) -> "(.*?)"$/ or next;' \
  -e '($file,$n,$l,$r)=($1,$2,$3,$4); $q="'\''"; $r=~s/$q/$q\\$q$q/g;'\
  -e 'print "sed -i $q${n}s!$l!$r!$q $file"' \
 | grep -vE '\.po$|pt_BR' > k

Filter out s/seeked/sought/ false positives (they relate to cg-seek):
  grep -vE 'seeked' k > j && mv j k

Manually resolve the few cases in which there are two or more
alternative spellings, then apply the fixes with "bash k"

make this quoting change to accommodate preceding s/doesnt/doesn't/
  -test_expect_success $PREREQ 'confirm doesn't loop forever' '
  +test_expect_success $PREREQ "confirm doesn't loop forever" '

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/RelNotes/1.5.4.4.txt            |  2 +-
 Documentation/RelNotes/1.7.5.4.txt            |  2 +-
 Documentation/RelNotes/1.7.8.txt              |  2 +-
 Documentation/git-remote-ext.txt              |  2 +-
 Documentation/git-svn.txt                     |  2 +-
 Documentation/technical/api-ref-iteration.txt |  2 +-
 Documentation/user-manual.txt                 |  2 +-
 builtin/apply.c                               |  4 ++--
 compat/nedmalloc/Readme.txt                   |  2 +-
 compat/nedmalloc/malloc.c.h                   |  6 +++---
 compat/obstack.h                              |  2 +-
 compat/regex/regcomp.c                        | 10 +++++-----
 compat/regex/regex.c                          |  2 +-
 compat/regex/regexec.c                        |  4 ++--
 contrib/mw-to-git/git-remote-mediawiki        |  2 +-
 contrib/subtree/t/t7900-subtree.sh            |  2 +-
 diff.c                                        |  4 ++--
 dir.c                                         |  2 +-
 git-add--interactive.perl                     |  2 +-
 git-bisect.sh                                 |  2 +-
 git-gui/lib/blame.tcl                         |  2 +-
 git-gui/lib/index.tcl                         |  2 +-
 git-gui/lib/spellcheck.tcl                    |  4 ++--
 git-pull.sh                                   |  2 +-
 git-quiltimport.sh                            |  2 +-
 gitweb/INSTALL                                |  2 +-
 gitweb/gitweb.perl                            |  6 +++---
 kwset.c                                       |  4 ++--
 perl/Git.pm                                   |  2 +-
 perl/private-Error.pm                         |  2 +-
 po/git.pot                                    |  2 +-
 sequencer.c                                   |  2 +-
 sha1-lookup.c                                 |  2 +-
 t/t3701-add-interactive.sh                    |  2 +-
 t/t4014-format-patch.sh                       |  6 +++---
 t/t4124-apply-ws-rule.sh                      |  2 +-
 t/t6030-bisect-porcelain.sh                   |  2 +-
 t/t9001-send-email.sh                         |  4 ++--
 transport.h                                   |  2 +-
 xdiff/xdiffi.c                                |  2 +-
 xdiff/xhistogram.c                            |  2 +-
 41 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/Documentation/RelNotes/1.5.4.4.txt b/Documentation/RelNotes/1.5.4.4.txt
index 323c1a8..83453db 100644
--- a/Documentation/RelNotes/1.5.4.4.txt
+++ b/Documentation/RelNotes/1.5.4.4.txt
@@ -21,7 +21,7 @@ Fixes since v1.5.4.3

  * "git send-email" in 1.5.4.3 issued a bogus empty In-Reply-To: header.

- * "git bisect" showed mysterious "won't bisect on seeked tree" error message.
+ * "git bisect" showed mysterious "won't bisect on sought tree" error message.
    This was leftover from Cogito days to prevent "bisect" starting from a
    cg-seeked state.  We still keep the Cogito safety, but running "git bisect
    start" when another bisect was in effect will clean up and start over.
diff --git a/Documentation/RelNotes/1.7.5.4.txt b/Documentation/RelNotes/1.7.5.4.txt
index cf3f455..7796df3 100644
--- a/Documentation/RelNotes/1.7.5.4.txt
+++ b/Documentation/RelNotes/1.7.5.4.txt
@@ -5,7 +5,7 @@ Fixes since v1.7.5.3
 --------------------

  * The single-key mode of "git add -p" was easily fooled into thinking
-   that it was told to add everthing ('a') when up-arrow was pressed by
+   that it was told to add everything ('a') when up-arrow was pressed by
    mistake.

  * Setting a git command that uses custom configuration via "-c var=val"
diff --git a/Documentation/RelNotes/1.7.8.txt b/Documentation/RelNotes/1.7.8.txt
index b4d90bb..7012329 100644
--- a/Documentation/RelNotes/1.7.8.txt
+++ b/Documentation/RelNotes/1.7.8.txt
@@ -9,7 +9,7 @@ Updates since v1.7.7
  * Updates to bash completion scripts.

  * The build procedure has been taught to take advantage of computed
-   dependency automatically when the complier supports it.
+   dependency automatically when the compiler supports it.

  * The date parser now accepts timezone designators that lack minutes
    part and also has a colon between "hh:mm".
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 8a8e1d7..e224513 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -86,7 +86,7 @@ begins with `ext::`.  Examples:
 	edit .ssh/config.

 "ext::socat -t3600 - ABSTRACT-CONNECT:/git-server %G/somerepo"::
-	Represents repository with path /somerepo accessable over
+	Represents repository with path /somerepo accessible over
 	git protocol at abstract namespace address /git-server.

 "ext::git-server-alias foo %G/repo"::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index cfe8d2b..98b941b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -238,7 +238,7 @@ first have already been pushed into SVN.
 	patch), "all" (accept all patches), or "quit".
 	+
 	'git svn dcommit' returns immediately if answer if "no" or "quit", without
-	commiting anything to SVN.
+	committing anything to SVN.

 'branch'::
 	Create a branch in the SVN repository.
diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
index dbbea95..aa1c50f 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -35,7 +35,7 @@ Iteration functions
 * `head_ref_submodule()`, `for_each_ref_submodule()`,
   `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
   `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()`
-  do the same as the functions descibed above but for a specified
+  do the same as the functions described above but for a specified
   submodule.

 * `for_each_rawref()` can be used to learn about broken ref and symref.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1b94207..02ed566 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1600,7 +1600,7 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
 You will see informational messages on dangling objects. They are objects
 that still exist in the repository but are no longer referenced by any of
 your branches, and can (and will) be removed after a while with "gc".
-You can run `git fsck --no-dangling` to supress these messages, and still
+You can run `git fsck --no-dangling` to suppress these messages, and still
 view real errors.

 [[recovering-lost-changes]]
diff --git a/builtin/apply.c b/builtin/apply.c
index b4428ea..7b2c3d4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1893,7 +1893,7 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 }

 /*
- * Read the patch text in "buffer" taht extends for "size" bytes; stop
+ * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file).
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
  * Return the number of bytes consumed, so that the caller can call us
@@ -3424,7 +3424,7 @@ static void show_rename_copy(struct patch *p)
 		old = slash_old + 1;
 		new = slash_new + 1;
 	}
-	/* p->old_name thru old is the common prefix, and old and new
+	/* p->old_name through old is the common prefix, and old and new
 	 * through the end of names are renames
 	 */
 	if (old != p->old_name)
diff --git a/compat/nedmalloc/Readme.txt b/compat/nedmalloc/Readme.txt
index 8763656..c4e9bcf 100644
--- a/compat/nedmalloc/Readme.txt
+++ b/compat/nedmalloc/Readme.txt
@@ -97,7 +97,7 @@ Chew for reporting this.

 v1.04alpha_svn915 7th October 2006:
  * Fixed failure to unlock thread cache list if allocating a new list failed.
-Thanks to Dmitry Chichkov for reporting this. Futher thanks to Aleksey Sanin.
+Thanks to Dmitry Chichkov for reporting this. Further thanks to Aleksey Sanin.
  * Fixed realloc(0, <size>) segfaulting. Thanks to Dmitry Chichkov for
 reporting this.
  * Made config defines #ifndef so they can be overriden by the build system.
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index ff7c2c4..1401a67 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -4778,7 +4778,7 @@ void* dlmalloc(size_t bytes) {

 void dlfree(void* mem) {
   /*
-     Consolidate freed chunks with preceeding or succeeding bordering
+     Consolidate freed chunks with preceding or succeeding bordering
      free chunks, if they exist, and then place in a bin.  Intermixed
      with special cases for top, dv, mmapped chunks, and usage errors.
   */
@@ -5680,10 +5680,10 @@ History:
 	Wolfram Gloger (Gloger@lrz.uni-muenchen.de).
       * Use last_remainder in more cases.
       * Pack bins using idea from  colin@nyx10.cs.du.edu
-      * Use ordered bins instead of best-fit threshhold
+      * Use ordered bins instead of best-fit threshold
       * Eliminate block-local decls to simplify tracing and debugging.
       * Support another case of realloc via move into top
-      * Fix error occuring when initial sbrk_base not word-aligned.
+      * Fix error occurring when initial sbrk_base not word-aligned.
       * Rely on page size for units instead of SBRK_UNIT to
 	avoid surprises about sbrk alignment conventions.
       * Add mallinfo, mallopt. Thanks to Raymond Nijssen
diff --git a/compat/obstack.h b/compat/obstack.h
index d178bd6..ceb4bdb 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -128,7 +128,7 @@ extern "C" {

 #define __BPTR_ALIGN(B, P, A) ((B) + (((P) - (B) + (A)) & ~(A)))

-/* Similiar to _BPTR_ALIGN (B, P, A), except optimize the common case
+/* Similar to _BPTR_ALIGN (B, P, A), except optimize the common case
    where pointers can be converted to integers, aligned as integers,
    and converted back again.  If PTR_INT_TYPE is narrower than a
    pointer (e.g., the AS/400), play it safe and compute the alignment
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index 8c96ed9..079d8ac 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2617,7 +2617,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
      Build the range expression which starts from START_ELEM, and ends
      at END_ELEM.  The result are written to MBCSET and SBCSET.
      RANGE_ALLOC is the allocated size of mbcset->range_starts, and
-     mbcset->range_ends, is a pointer argument sinse we may
+     mbcset->range_ends, is a pointer argument since we may
      update it.  */

 static reg_errcode_t
@@ -2896,7 +2896,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
      Build the range expression which starts from START_ELEM, and ends
      at END_ELEM.  The result are written to MBCSET and SBCSET.
      RANGE_ALLOC is the allocated size of mbcset->range_starts, and
-     mbcset->range_ends, is a pointer argument sinse we may
+     mbcset->range_ends, is a pointer argument since we may
      update it.  */

   auto inline reg_errcode_t
@@ -2980,7 +2980,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
      Build the collating element which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      COLL_SYM_ALLOC is the allocated size of mbcset->coll_sym, is a
-     pointer argument sinse we may update it.  */
+     pointer argument since we may update it.  */

   auto inline reg_errcode_t
   __attribute ((always_inline))
@@ -3419,7 +3419,7 @@ parse_bracket_symbol (bracket_elem_t *elem, re_string_t *regexp,
      Build the equivalence class which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      EQUIV_CLASS_ALLOC is the allocated size of mbcset->equiv_classes,
-     is a pointer argument sinse we may update it.  */
+     is a pointer argument since we may update it.  */

 static reg_errcode_t
 #ifdef RE_ENABLE_I18N
@@ -3515,7 +3515,7 @@ build_equiv_class (bitset_t sbcset, const unsigned char *name)
      Build the character class which is represented by NAME.
      The result are written to MBCSET and SBCSET.
      CHAR_CLASS_ALLOC is the allocated size of mbcset->char_classes,
-     is a pointer argument sinse we may update it.  */
+     is a pointer argument since we may update it.  */

 static reg_errcode_t
 #ifdef RE_ENABLE_I18N
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 3dd8dfa..6aaae00 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -22,7 +22,7 @@
 #include "config.h"
 #endif

-/* Make sure noone compiles this code with a C++ compiler.  */
+/* Make sure no one compiles this code with a C++ compiler.  */
 #ifdef __cplusplus
 # error "This is C code, use a C compiler"
 #endif
diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 0194965..048fc85 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -455,7 +455,7 @@ re_search_stub (struct re_pattern_buffer *bufp,

   rval = 0;

-  /* I hope we needn't fill ther regs with -1's when no match was found.  */
+  /* I hope we needn't fill their regs with -1's when no match was found.  */
   if (result != REG_NOERROR)
     rval = -1;
   else if (regs != NULL)
@@ -1071,7 +1071,7 @@ acquire_init_state_context (reg_errcode_t *err, const re_match_context_t *mctx,
    FL_LONGEST_MATCH means we want the POSIX longest matching.
    If P_MATCH_FIRST is not NULL, and the match fails, it is set to the
    next place where we may want to try matching.
-   Note that the matcher assume that the maching starts from the current
+   Note that the matcher assume that the matching starts from the current
    index of the buffer.  */

 static int
diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..5e46116 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -604,7 +604,7 @@ sub mw_import_ref {
 	if ($fetch_from == 1 && $n == 0) {
 		print STDERR "You appear to have cloned an empty MediaWiki.\n";
 		# Something has to be done remote-helper side. If nothing is done, an error is
-		# thrown saying that HEAD is refering to unknown object 0000000000000000000
+		# thrown saying that HEAD is referring to unknown object 0000000000000000000
 		# and the clone fails.
 	}
 }
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index bc2eeb0..67a0cc5 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -458,7 +458,7 @@ test_expect_success 'add main-sub5' '
 test_expect_success 'split for main-sub5 without --onto' '
         # also test that we still can split out an entirely new subtree
         # if the parent of the first commit in the tree is not empty,
-        # then the new subtree has accidently been attached to something
+        # then the new subtree has accidentally been attached to something
         git subtree split --prefix subdir2 --branch mainsub5 &&
         check_equal ''"$(git log --pretty=format:%P -1 mainsub5)"'' ""
 '
diff --git a/diff.c b/diff.c
index 77edd50..cf5d7d1 100644
--- a/diff.c
+++ b/diff.c
@@ -1523,7 +1523,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * Binary files are displayed with "Bin XXX -> YYY bytes"
 	 * instead of the change count and graph. This part is treated
 	 * similarly to the graph part, except that it is not
-	 * "scaled". If total width is too small to accomodate the
+	 * "scaled". If total width is too small to accommodate the
 	 * guaranteed minimum width of the filename part and the
 	 * separators and this message, this message will "overflow"
 	 * making the line longer than the maximum width.
@@ -2013,7 +2013,7 @@ static int is_conflict_marker(const char *line, int marker_size, unsigned long l
 	for (cnt = 1; cnt < marker_size; cnt++)
 		if (line[cnt] != firstchar)
 			return 0;
-	/* line[1] thru line[marker_size-1] are same as firstchar */
+	/* line[1] through line[marker_size-1] are same as firstchar */
 	if (len < marker_size + 1 || !isspace(line[marker_size]))
 		return 0;
 	return 1;
diff --git a/dir.c b/dir.c
index ed1510f..a9511f0 100644
--- a/dir.c
+++ b/dir.c
@@ -1201,7 +1201,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
 		if (lstat(path->buf, &st))
-			; /* fall thru */
+			; /* fall through */
 		else if (S_ISDIR(st.st_mode)) {
 			if (!remove_dir_recurse(path, flag, &kept_down))
 				continue; /* happy */
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index d948aa8..ee14544 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1248,7 +1248,7 @@ sub summarize_hunk {


 # Print a one-line summary of each hunk in the array ref in
-# the first argument, starting wih the index in the 2nd.
+# the first argument, starting with the index in the 2nd.
 sub display_hunks {
 	my ($hunks, $i) = @_;
 	my $ctr = 0;
diff --git a/git-bisect.sh b/git-bisect.sh
index 99efbe8..ac241ad 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -137,7 +137,7 @@ bisect_start() {
 			# cogito usage, and cogito users should understand
 			# it relates to cg-seek.
 			[ -s "$GIT_DIR/head-name" ] &&
-				die "$(gettext "won't bisect on seeked tree")"
+				die "$(gettext "won't bisect on sought tree")"
 			start_head="${head#refs/heads/}"
 			;;
 		*)
diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 324f774..b1d15f4 100644
--- a/git-gui/lib/blame.tcl
+++ b/git-gui/lib/blame.tcl
@@ -5,7 +5,7 @@ class blame {

 image create photo ::blame::img_back_arrow -data {R0lGODlhGAAYAIUAAPwCBEzKXFTSZIz+nGzmhGzqfGTidIT+nEzGXHTqhGzmfGzifFzadETCVES+VARWDFzWbHzyjAReDGTadFTOZDSyRDyyTCymPARaFGTedFzSbDy2TCyqRCyqPARaDAyCHES6VDy6VCyiPAR6HCSeNByWLARyFARiDARqFGTifARiFAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAAYABgAAAajQIBwSCwaj8ikcsk0BppJwRPqHEypQwHBis0WDAdEFyBIKBaMAKLBdjQeSkFBYTBAIvgEoS6JmhUTEwIUDQ4VFhcMGEhyCgoZExoUaxsWHB0THkgfAXUGAhoBDSAVFR0XBnCbDRmgog0hpSIiDJpJIyEQhBUcJCIlwA22SSYVogknEg8eD82qSigdDSknY0IqJQXPYxIl1dZCGNvWw+Dm510GQQAh/mhDcmVhdGVkIGJ5IEJNUFRvR0lGIFBybyB2ZXJzaW9uIDIuNQ0KqSBEZXZlbENvciAxOTk3LDE5OTguIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQpodHRwOi8vd3d3LmRldmVsY29yLmNvbQA7}

-# Persistant data (survives loads)
+# Persistent data (survives loads)
 #
 field history {}; # viewer history: {commit path}
 field header    ; # array commit,key -> header field
diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index 8efbbdd..74a81a7 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -414,7 +414,7 @@ proc revert_helper {txt paths} {
 	# such distinction is needed in some languages. Previously, the
 	# code used "Revert changes in" for both, but that can't work
 	# in languages where 'in' must be combined with word from
-	# rest of string (in diffrent way for both cases of course).
+	# rest of string (in different way for both cases of course).
 	#
 	# FIXME: Unfortunately, even that isn't enough in some languages
 	# as they have quite complex plural-form rules. Unfortunately,
diff --git a/git-gui/lib/spellcheck.tcl b/git-gui/lib/spellcheck.tcl
index e612030..538d61c 100644
--- a/git-gui/lib/spellcheck.tcl
+++ b/git-gui/lib/spellcheck.tcl
@@ -14,7 +14,7 @@ field w_menu      ; # context menu for the widget
 field s_menuidx 0 ; # last index of insertion into $w_menu

 field s_i           {} ; # timer registration for _run callbacks
-field s_clear        0 ; # did we erase mispelled tags yet?
+field s_clear        0 ; # did we erase misspelled tags yet?
 field s_seen    [list] ; # lines last seen from $w_text in _run
 field s_checked [list] ; # lines already checked
 field s_pending [list] ; # [$line $data] sent to ispell/aspell
@@ -259,7 +259,7 @@ method _run {} {
 		if {$n == $cur_line
 		 && ![regexp {^\W$} [$w_text get $cur_pos insert]]} {

-			# If the current word is mispelled remove the tag
+			# If the current word is misspelled remove the tag
 			# but force a spellcheck later.
 			#
 			set tags [$w_text tag names $cur_pos]
diff --git a/git-pull.sh b/git-pull.sh
index 2a10047..1a44dff 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -132,7 +132,7 @@ do
 		usage
 		;;
 	*)
-		# Pass thru anything that may be meant for fetch.
+		# Pass through anything that may be meant for fetch.
 		break
 		;;
 	esac
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 9a6ba2b..8e17525 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -59,7 +59,7 @@ tmp_patch="$tmp_dir/patch"
 tmp_info="$tmp_dir/info"


-# Find the intial commit
+# Find the initial commit
 commit=$(git rev-parse HEAD)

 mkdir $tmp_dir || exit 2
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 6d45406..08f3dda 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -244,7 +244,7 @@ for gitweb (in gitweb/README), and gitweb.conf(5) manpage.
   through the GITWEB_CONFIG_SYSTEM environment variable.

   Note that if per-instance configuration file exists, then system-wide
-  configuration is _not used at all_.  This is quite untypical and suprising
+  configuration is _not used at all_.  This is quite untypical and surprising
   behavior.  On the other hand changing current behavior would break backwards
   compatibility and can lead to unexpected changes in gitweb behavior.
   Therefore gitweb also looks for common system-wide configuration file,
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 55e0e9e..a939f3c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -679,7 +679,7 @@ sub evaluate_gitweb_config {
 	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
 	our $GITWEB_CONFIG_COMMON = $ENV{'GITWEB_CONFIG_COMMON'} || "++GITWEB_CONFIG_COMMON++";

-	# Protect agains duplications of file names, to not read config twice.
+	# Protect against duplications of file names, to not read config twice.
 	# Only one of $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM is used, so
 	# there possibility of duplication of filename there doesn't matter.
 	$GITWEB_CONFIG = ""        if ($GITWEB_CONFIG eq $GITWEB_CONFIG_COMMON);
@@ -1132,7 +1132,7 @@ sub handle_errors_html {

 	# to avoid infinite loop where error occurs in die_error,
 	# change handler to default handler, disabling handle_errors_html
-	set_message("Error occured when inside die_error:\n$msg");
+	set_message("Error occurred when inside die_error:\n$msg");

 	# you cannot jump out of die_error when called as error handler;
 	# the subroutine set via CGI::Carp::set_message is called _after_
@@ -7468,7 +7468,7 @@ sub git_object {
 		system(git_cmd(), "cat-file", '-e', $hash_base) == 0
 			or die_error(404, "Base object does not exist");

-		# here errors should not hapen
+		# here errors should not happen
 		open my $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $file_name
 			or die_error(500, "Open git-ls-tree failed");
 		my $line = <$fd>;
diff --git a/kwset.c b/kwset.c
index 51b2ab6..5800999 100644
--- a/kwset.c
+++ b/kwset.c
@@ -26,7 +26,7 @@
    The author may be reached (Email) at the address mike@ai.mit.edu,
    or (US mail) as Mike Haertel c/o Free Software Foundation. */

-/* The algorithm implemented by these routines bears a startling resemblence
+/* The algorithm implemented by these routines bears a startling resemblance
    to one discovered by Beate Commentz-Walter, although it is not identical.
    See "A String Matching Algorithm Fast on the Average," Technical Report,
    IBM-Germany, Scientific Center Heidelberg, Tiergartenstrasse 15, D-6900
@@ -435,7 +435,7 @@ kwsprep (kwset_t kws)
 	  /* Update the delta table for the descendents of this node. */
 	  treedelta(curr->links, curr->depth, delta);

-	  /* Compute the failure function for the decendents of this node. */
+	  /* Compute the failure function for the descendants of this node. */
 	  treefails(curr->links, curr->fail, kwset->trie);

 	  /* Update the shifts at each node in the current node's chain
diff --git a/perl/Git.pm b/perl/Git.pm
index 497f420..2c5c2f0 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -954,7 +954,7 @@ my (%TEMP_FILEMAP, %TEMP_FILES);

 =item temp_acquire ( NAME )

-Attempts to retreive the temporary file mapped to the string C<NAME>. If an
+Attempts to retrieve the temporary file mapped to the string C<NAME>. If an
 associated temp file has not been created this session or was closed, it is
 created, cached, and set for autoflush and binmode.

diff --git a/perl/private-Error.pm b/perl/private-Error.pm
index 11e9cd9..9a0c567 100644
--- a/perl/private-Error.pm
+++ b/perl/private-Error.pm
@@ -769,7 +769,7 @@ is a numeric value. These values are what will be returned by the
 overload methods.

 If the text value ends with C<at file line 1> as $@ strings do, then
-this infomation will be used to set the C<-file> and C<-line> arguments
+this information will be used to set the C<-file> and C<-line> arguments
 of the error object.

 This class is used internally if an eval'd block die's with an error
diff --git a/po/git.pot b/po/git.pot
index f834a46..e4a0eb3 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -4681,7 +4681,7 @@ msgid ""
 msgstr ""

 #: git-bisect.sh:140
-msgid "won't bisect on seeked tree"
+msgid "won't bisect on sought tree"
 msgstr ""

 #: git-bisect.sh:144
diff --git a/sequencer.c b/sequencer.c
index bf078f2..17d5115 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -131,7 +131,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	if (msg) {
 		fprintf(stderr, "%s\n", msg);
 		/*
-		 * A conflict has occured but the porcelain
+		 * A conflict has occurred but the porcelain
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
diff --git a/sha1-lookup.c b/sha1-lookup.c
index c4dc55d..580d2b3 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -201,7 +201,7 @@ int sha1_entry_pos(const void *table,
 					break;
 			ofs_0 = ofs;
 			/*
-			 * byte 0 thru (ofs-1) are the same between
+			 * byte 0 through (ofs-1) are the same between
 			 * lo and hi; ofs is the first byte that is
 			 * different.
 			 */
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 098a6ae..9fab25c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -319,7 +319,7 @@ test_expect_success PERL 'split hunk "add -p (edit)"' '
 	# times to get out.
 	#
 	# 2. Correct version applies the (not)edited version, and asks
-	#    about the next hunk, against wich we say q and program
+	#    about the next hunk, against which we say q and program
 	#    exits.
 	for a in s e     q n q q
 	do
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b473b6d..86e0a51 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -681,21 +681,21 @@ test_expect_success 'format-patch --signature --cover-letter' '
 	test 2 = $(grep "my sig" output | wc -l)
 '

-test_expect_success 'format.signature="" supresses signatures' '
+test_expect_success 'format.signature="" suppresses signatures' '
 	git config format.signature "" &&
 	git format-patch --stdout -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
 '

-test_expect_success 'format-patch --no-signature supresses signatures' '
+test_expect_success 'format-patch --no-signature suppresses signatures' '
 	git config --unset-all format.signature &&
 	git format-patch --stdout --no-signature -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
 '

-test_expect_success 'format-patch --signature="" supresses signatures' '
+test_expect_success 'format-patch --signature="" suppresses signatures' '
 	git format-patch --stdout --signature="" -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 6f6ee88..581a801 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -47,7 +47,7 @@ test_fix () {
 	# find touched lines
 	$DIFF file target | sed -n -e "s/^> //p" >fixed

-	# the changed lines are all expeced to change
+	# the changed lines are all expected to change
 	fixed_cnt=$(wc -l <fixed)
 	case "$1" in
 	'') expect_cnt=$fixed_cnt ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 72e28ee..2ecdd46 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -190,7 +190,7 @@ test_expect_success 'bisect start: no ".git/BISECT_START" if checkout error' '
 # $HASH1 is good, $HASH4 is bad, we skip $HASH3
 # but $HASH2 is bad,
 # so we should find $HASH2 as the first bad commit
-test_expect_success 'bisect skip: successfull result' '
+test_expect_success 'bisect skip: successful result' '
 	git bisect reset &&
 	git bisect start $HASH4 $HASH1 &&
 	git bisect skip &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 8c12c65..6c427c1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -101,7 +101,7 @@ test_expect_success $PREREQ \

 test_expect_success $PREREQ 'Send patches with --envelope-sender' '
     clean_fake_sendmail &&
-     git send-email --envelope-sender="Patch Contributer <patch@example.com>" --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+     git send-email --envelope-sender="Patch Contributor <patch@example.com>" --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
 '

 test_expect_success $PREREQ 'setup expect' '
@@ -760,7 +760,7 @@ test_expect_success $PREREQ 'confirm detects EOF (auto causes failure)' '
 	test $ret = "0"
 '

-test_expect_success $PREREQ 'confirm doesnt loop forever' '
+test_expect_success $PREREQ "confirm doesn't loop forever" '
 	CONFIRM=$(git config --get sendemail.confirm) &&
 	git config sendemail.confirm auto &&
 	GIT_SEND_EMAIL_NOTTY=1 &&
diff --git a/transport.h b/transport.h
index b866c12..2739274 100644
--- a/transport.h
+++ b/transport.h
@@ -74,7 +74,7 @@ struct transport {
 		       const char *executable, int fd[2]);

 	/** get_refs_list(), fetch(), and push_refs() can keep
-	 * resources (such as a connection) reserved for futher
+	 * resources (such as a connection) reserved for further
 	 * use. disconnect() releases these resources.
 	 **/
 	int (*disconnect)(struct transport *connection);
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 1b7012a..b2eb6db 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -490,7 +490,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {

 		/*
 		 * Try to move back the possibly merged group of changes, to match
-		 * the recorded postion in the other file.
+		 * the recorded position in the other file.
 		 */
 		while (ixref < ix) {
 			rchg[--ixs] = 1;
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index bf99787..73210cb 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -55,7 +55,7 @@ struct histindex {
 	struct record {
 		unsigned int ptr, cnt;
 		struct record *next;
-	} **records, /* an ocurrence */
+	} **records, /* an occurrence */
 	  **line_map; /* map of line to record chain */
 	chastore_t rcha;
 	unsigned int *next_ptrs;
--
1.7.11.rc0.100.g5498c5f
