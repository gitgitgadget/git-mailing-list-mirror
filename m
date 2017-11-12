Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EB24201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 22:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdKLWHg (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 17:07:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751017AbdKLWHf (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 17:07:35 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 67213604A0;
        Sun, 12 Nov 2017 22:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510524445;
        bh=ZdjZ2rJ9bE04c+WZIEQt6ikHcCI63jlC4k2/uf6wHmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Zmw1uUrXh8HFATY4URJ3MkYwX5UzEBDPs39g3s+QjrO6DPtbw/pt0cJAdqzIs48zb
         c/vscLOWj2Y2/cOyZEmOhHTBfX1JejCsr8vRdjGflUieb8cNOyNZD9baGbVzVpV7+5
         m7xK3M4w5b09yd85XKAI6WyzaTnwz23KG5ThRdhBg9vn3NC8oo6rr1LoP3Bhrt7uVn
         L4HucjcpyRXDXmc+Uwg+MQFfjqQ75tZ3Zq0RJBh4cj3cdRA7M5MkI2+a/ykAVKSQgb
         IKoksjD2NFsgFGbAoxo1AJsVl86UCuO6MwRRvdy73Z9Avp39a+OIpJOE5F93RbyB0i
         o/3yEV0a5HFw2dzr+4iS/8bHuKiUBH2/jI02MIr367dCdUDlT+3EvaThvFeI6jUs9u
         /GItX+l6q6szmpkPJBhrY0Q/5XYGiFABJfOEvNCGfbKLg/eoIz0mHUI2m5DEv8Rkjz
         nK9LikdaGrQ33zYloUtK6EwNg9d60KxV6IrsvGkGNEd+AOwvK4z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 2/2] Documentation: convert SubmittingPatches to AsciiDoc
Date:   Sun, 12 Nov 2017 22:07:18 +0000
Message-Id: <20171112220718.792129-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a
In-Reply-To: <20171112220718.792129-1-sandals@crustytoothpaste.net>
References: <20171112220718.792129-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The SubmittingPatches document is often cited by outside parties as an
example of good practices to follow, including logical, independent
commits; patch sign-offs; and sending patches to a mailing list.
Currently, people who want to cite a particular section tend to either
refer to it by name and let the interested party search through the
document to find it, or link to a given line number on GitHub and hope
the file doesn't change.

Instead, convert the document to AsciiDoc.  Build it as part of the
technical documentation, since it is likely of interest to the same
group of people.  Provide stable links to the sections which outside
parties are likely to want to link to.  Make some minor structural
changes to organize it so that it can be formatted sanely.

Since the makefile needs a .txt extension in order to build with the
rest of the documentation, simply copy the file.  Ignore the temporary
file so it doesn't get checked in accidentally, and remove it as part of
the clean process.  Do this instead of renaming the file so that people
who have already linked to the documentation (who we're trying to help)
don't find their links broken.  Avoid symlinking since Windows will not
like that.

This allows us to render the document as part of the website for the
benefit of others who wish to link to it as well as providing a more
nicely formatted display for our community and potential contributors.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/.gitignore        |   1 +
 Documentation/Makefile          |   5 +
 Documentation/SubmittingPatches | 340 +++++++++++++++++++++-------------------
 3 files changed, 188 insertions(+), 158 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 2c8b2d612e..c7096f11f1 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -11,3 +11,4 @@ doc.dep
 cmds-*.txt
 mergetools-*.txt
 manpage-base-url.xsl
+SubmittingPatches.txt
diff --git a/Documentation/Makefile b/Documentation/Makefile
index d5ad85459e..2ab65561af 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -67,6 +67,7 @@ SP_ARTICLES += howto/maintain-git
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
 
+TECH_DOCS += SubmittingPatches
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
@@ -324,6 +325,7 @@ clean:
 	$(RM) *.pdf
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/*.html technical/api-index.txt
+	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
 
@@ -362,6 +364,9 @@ technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt asciidoc.conf
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
+SubmittingPatches.txt: SubmittingPatches
+	$(QUIET_GEN) cp $< $@
+
 XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b65..17419f7901 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -1,40 +1,47 @@
+Submitting Patches
+==================
+
+== Guidelines
+
 Here are some guidelines for people who want to contribute their code
 to this software.
 
-(0) Decide what to base your work on.
+[[base-branch]]
+=== Decide what to base your work on.
 
 In general, always base your work on the oldest branch that your
 change is relevant to.
 
- - A bugfix should be based on 'maint' in general. If the bug is not
-   present in 'maint', base it on 'master'. For a bug that's not yet
-   in 'master', find the topic that introduces the regression, and
-   base your work on the tip of the topic.
+* A bugfix should be based on `maint` in general. If the bug is not
+  present in `maint`, base it on `master`. For a bug that's not yet
+  in `master`, find the topic that introduces the regression, and
+  base your work on the tip of the topic.
 
- - A new feature should be based on 'master' in general. If the new
-   feature depends on a topic that is in 'pu', but not in 'master',
-   base your work on the tip of that topic.
+* A new feature should be based on `master` in general. If the new
+  feature depends on a topic that is in `pu`, but not in `master`,
+  base your work on the tip of that topic.
 
- - Corrections and enhancements to a topic not yet in 'master' should
-   be based on the tip of that topic. If the topic has not been merged
-   to 'next', it's alright to add a note to squash minor corrections
-   into the series.
+* Corrections and enhancements to a topic not yet in `master` should
+  be based on the tip of that topic. If the topic has not been merged
+  to `next`, it's alright to add a note to squash minor corrections
+  into the series.
 
- - In the exceptional case that a new feature depends on several topics
-   not in 'master', start working on 'next' or 'pu' privately and send
-   out patches for discussion. Before the final merge, you may have to
-   wait until some of the dependent topics graduate to 'master', and
-   rebase your work.
+* In the exceptional case that a new feature depends on several topics
+  not in `master`, start working on `next` or `pu` privately and send
+  out patches for discussion. Before the final merge, you may have to
+  wait until some of the dependent topics graduate to `master`, and
+  rebase your work.
 
- - Some parts of the system have dedicated maintainers with their own
-   repositories (see the section "Subsystems" below).  Changes to
-   these parts should be based on their trees.
+* Some parts of the system have dedicated maintainers with their own
+  repositories (see the section "Subsystems" below).  Changes to
+  these parts should be based on their trees.
 
-To find the tip of a topic branch, run "git log --first-parent
-master..pu" and look for the merge commit. The second parent of this
+To find the tip of a topic branch, run `git log --first-parent
+master..pu` and look for the merge commit. The second parent of this
 commit is the tip of the topic branch.
 
-(1) Make separate commits for logically separate changes.
+[[separate-commits]]
+=== Make separate commits for logically separate changes.
 
 Unless your patch is really trivial, you should not be sending
 out a patch that was generated between your working tree and
@@ -58,8 +65,9 @@ differs substantially from the prior version, are all good things
 to have.
 
 Make sure that you have tests for the bug you are fixing.  See
-t/README for guidance.
+`t/README` for guidance.
 
+[[tests]]
 When adding a new feature, make sure that you have new tests to show
 the feature triggers the new behavior when it should, and to show the
 feature does not trigger when it shouldn't.  After any code change, make
@@ -84,41 +92,45 @@ turning en_UK spelling to en_US).  Obvious typographical fixes are much
 more welcomed ("teh -> "the"), preferably submitted as independent
 patches separate from other documentation changes.
 
+[[whitespace-check]]
 Oh, another thing.  We are picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
-in templates/hooks--pre-commit.  To help ensure this does not happen,
-run "git diff --check" on your changes before you commit.
+in `templates/hooks--pre-commit`.  To help ensure this does not happen,
+run `git diff --check` on your changes before you commit.
 
-
-(2) Describe your changes well.
+[[describe-changes]]
+=== Describe your changes well.
 
 The first line of the commit message should be a short description (50
-characters is the soft limit, see DISCUSSION in git-commit(1)), and
-should skip the full stop.  It is also conventional in most cases to
+characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]),
+and should skip the full stop.  It is also conventional in most cases to
 prefix the first line with "area: " where the area is a filename or
 identifier for the general area of the code being modified, e.g.
 
-  . doc: clarify distinction between sign-off and pgp-signing
-  . githooks.txt: improve the intro section
+* doc: clarify distinction between sign-off and pgp-signing
+* githooks.txt: improve the intro section
 
-If in doubt which identifier to use, run "git log --no-merges" on the
+If in doubt which identifier to use, run `git log --no-merges` on the
 files you are modifying to see the current conventions.
 
+[[summary-section]]
 It's customary to start the remainder of the first line after "area: "
 with a lower-case letter. E.g. "doc: clarify...", not "doc:
 Clarify...", or "githooks.txt: improve...", not "githooks.txt:
 Improve...".
 
+[[meaningful-message]]
 The body should provide a meaningful commit message, which:
 
-  . explains the problem the change tries to solve, i.e. what is wrong
-    with the current code without the change.
+. explains the problem the change tries to solve, i.e. what is wrong
+  with the current code without the change.
 
-  . justifies the way the change solves the problem, i.e. why the
-    result with the change is better.
+. justifies the way the change solves the problem, i.e. why the
+  result with the change is better.
 
-  . alternate solutions considered but discarded, if any.
+. alternate solutions considered but discarded, if any.
 
+[[imperative-mood]]
 Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
 instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
 to do frotz", as if you are giving orders to the codebase to change
@@ -126,36 +138,43 @@ its behavior.  Try to make sure your explanation can be understood
 without external resources. Instead of giving a URL to a mailing list
 archive, summarize the relevant points of the discussion.
 
+[[commit-reference]]
 If you want to reference a previous commit in the history of a stable
 branch, use the format "abbreviated sha1 (subject, date)",
 with the subject enclosed in a pair of double-quotes, like this:
 
-    Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
-    noticed that ...
+....
+	Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
+	noticed that ...
+....
 
 The "Copy commit summary" command of gitk can be used to obtain this
-format, or this invocation of "git show":
+format, or this invocation of `git show`:
 
-    git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>
+....
+	git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>
+....
 
-(3) Generate your patch using Git tools out of your commits.
+[[git-tools]]
+=== Generate your patch using Git tools out of your commits.
 
 Git based diff tools generate unidiff which is the preferred format.
 
-You do not have to be afraid to use -M option to "git diff" or
-"git format-patch", if your patch involves file renames.  The
+You do not have to be afraid to use `-M` option to `git diff` or
+`git format-patch`, if your patch involves file renames.  The
 receiving end can handle them just fine.
 
+[[review-patch]]
 Please make sure your patch does not add commented out debugging code,
 or include any extra files which do not relate to what your patch
 is trying to achieve. Make sure to review
 your patch after generating it, to ensure accuracy.  Before
-sending out, please make sure it cleanly applies to the "master"
+sending out, please make sure it cleanly applies to the `master`
 branch head.  If you are preparing a work based on "next" branch,
 that is fine, but please mark it as such.
 
-
-(4) Sending your patches.
+[[send-patches]]
+=== Sending your patches.
 
 Learn to use format-patch and send-email if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
@@ -191,7 +210,7 @@ not ready to be applied but it is for discussion, [PATCH v2],
 [PATCH v3] etc. are often seen when you are sending an update to
 what you have previously sent.
 
-"git format-patch" command follows the best current practice to
+`git format-patch` command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
 patch should come your commit message, ending with the
 Signed-off-by: lines, and a line that consists of three dashes,
@@ -208,6 +227,7 @@ an explanation of changes between each iteration can be kept in
 Git-notes and inserted automatically following the three-dash
 line via `git format-patch --notes`.
 
+[[attachment]]
 Do not attach the patch as a MIME attachment, compressed or not.
 Do not let your e-mail client send quoted-printable.  Do not let
 your e-mail client send format=flowed which would destroy
@@ -222,6 +242,7 @@ that it will be postponed.
 Exception:  If your mailer is mangling patches then someone may ask
 you to re-send them using MIME, that is OK.
 
+[[pgp-signature]]
 Do not PGP sign your patch. Most likely, your maintainer or other people on the
 list would not have your PGP key and would not bother obtaining it anyway.
 Your patch is not judged by who you are; a good patch from an unknown origin
@@ -230,28 +251,27 @@ origin that is done poorly or does incorrect things.
 
 If you really really really really want to do a PGP signed
 patch, format it as "multipart/signed", not a text/plain message
-that starts with '-----BEGIN PGP SIGNED MESSAGE-----'.  That is
+that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the output from
-"git blame $path" and "git shortlog --no-merges $path" would help to
++git blame _$path_+ and +git shortlog {litdd}no-merges _$path_+ would help to
 identify them), to solicit comments and reviews.
 
-After the list reached a consensus that it is a good idea to apply the
-patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" the
-list [*2*] for inclusion.
+:1: footnote:[The current maintainer: gitster@pobox.com]
+:2: footnote:[The mailing list: git@vger.kernel.org]
 
-Do not forget to add trailers such as "Acked-by:", "Reviewed-by:" and
-"Tested-by:" lines as necessary to credit people who helped your
+After the list reached a consensus that it is a good idea to apply the
+patch, re-send it with "To:" set to the maintainer{1} and "cc:" the
+list{2} for inclusion.
+
+Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
+`Tested-by:` lines as necessary to credit people who helped your
 patch.
 
-    [Addresses]
-     *1* The current maintainer: gitster@pobox.com
-     *2* The mailing list: git@vger.kernel.org
-
-
-(5) Certify your work by adding your "Signed-off-by: " line
+[[sign-off]]
+=== Certify your work by adding your "Signed-off-by: " line
 
 To improve tracking of who did what, we've borrowed the
 "sign-off" procedure from the Linux kernel project on patches
@@ -263,35 +283,39 @@ the patch, which certifies that you wrote it or otherwise have
 the right to pass it on as a open-source patch.  The rules are
 pretty simple: if you can certify the below D-C-O:
 
-        Developer's Certificate of Origin 1.1
+[[dco]]
+.Developer's Certificate of Origin 1.1
+____
+By making a contribution to this project, I certify that:
 
-        By making a contribution to this project, I certify that:
+a. The contribution was created in whole or in part by me and I
+   have the right to submit it under the open source license
+   indicated in the file; or
 
-        (a) The contribution was created in whole or in part by me and I
-            have the right to submit it under the open source license
-            indicated in the file; or
+b. The contribution is based upon previous work that, to the best
+   of my knowledge, is covered under an appropriate open source
+   license and I have the right under that license to submit that
+   work with modifications, whether created in whole or in part
+   by me, under the same open source license (unless I am
+   permitted to submit under a different license), as indicated
+   in the file; or
 
-        (b) The contribution is based upon previous work that, to the best
-            of my knowledge, is covered under an appropriate open source
-            license and I have the right under that license to submit that
-            work with modifications, whether created in whole or in part
-            by me, under the same open source license (unless I am
-            permitted to submit under a different license), as indicated
-            in the file; or
+c. The contribution was provided directly to me by some other
+   person who certified (a), (b) or (c) and I have not modified
+   it.
 
-        (c) The contribution was provided directly to me by some other
-            person who certified (a), (b) or (c) and I have not modified
-            it.
-
-        (d) I understand and agree that this project and the contribution
-            are public and that a record of the contribution (including all
-            personal information I submit with it, including my sign-off) is
-            maintained indefinitely and may be redistributed consistent with
-            this project or the open source license(s) involved.
+d. I understand and agree that this project and the contribution
+   are public and that a record of the contribution (including all
+   personal information I submit with it, including my sign-off) is
+   maintained indefinitely and may be redistributed consistent with
+   this project or the open source license(s) involved.
+____
 
 then you just add a line saying
 
-        Signed-off-by: Random J Developer <random@developer.example.org>
+....
+	Signed-off-by: Random J Developer <random@developer.example.org>
+....
 
 This line can be automatically added by Git if you run the git-commit
 command with the -s option.
@@ -302,85 +326,86 @@ D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
 the change to its true author (see (2) above).
 
+[[real-name]]
 Also notice that a real name is used in the Signed-off-by: line. Please
 don't hide your real name.
 
+[[commit-trailers]]
 If you like, you can put extra tags at the end:
 
-1. "Reported-by:" is used to credit someone who found the bug that
-   the patch attempts to fix.
-2. "Acked-by:" says that the person who is more familiar with the area
-   the patch attempts to modify liked the patch.
-3. "Reviewed-by:", unlike the other tags, can only be offered by the
-   reviewer and means that she is completely satisfied that the patch
-   is ready for application.  It is usually offered only after a
-   detailed review.
-4. "Tested-by:" is used to indicate that the person applied the patch
-   and found it to have the desired effect.
+. `Reported-by:` is used to credit someone who found the bug that
+  the patch attempts to fix.
+. `Acked-by:` says that the person who is more familiar with the area
+  the patch attempts to modify liked the patch.
+. `Reviewed-by:`, unlike the other tags, can only be offered by the
+  reviewer and means that she is completely satisfied that the patch
+  is ready for application.  It is usually offered only after a
+  detailed review.
+. `Tested-by:` is used to indicate that the person applied the patch
+  and found it to have the desired effect.
 
 You can also create your own tag or use one that's in common usage
 such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
 
-------------------------------------------------
-Subsystems with dedicated maintainers
+== Subsystems with dedicated maintainers
 
 Some parts of the system have dedicated maintainers with their own
 repositories.
 
- - git-gui/ comes from git-gui project, maintained by Pat Thoyts:
+- 'git-gui/' comes from git-gui project, maintained by Pat Thoyts:
 
-        git://repo.or.cz/git-gui.git
+	git://repo.or.cz/git-gui.git
 
- - gitk-git/ comes from Paul Mackerras's gitk project:
+- 'gitk-git/' comes from Paul Mackerras's gitk project:
 
-        git://ozlabs.org/~paulus/gitk
+	git://ozlabs.org/~paulus/gitk
 
- - po/ comes from the localization coordinator, Jiang Xin:
+- 'po/' comes from the localization coordinator, Jiang Xin:
 
 	https://github.com/git-l10n/git-po/
 
 Patches to these parts should be based on their trees.
 
-------------------------------------------------
-An ideal patch flow
+[[patch-flow]]
+== An ideal patch flow
 
 Here is an ideal patch flow for this project the current maintainer
 suggests to the contributors:
 
- (0) You come up with an itch.  You code it up.
+. You come up with an itch.  You code it up.
 
- (1) Send it to the list and cc people who may need to know about
-     the change.
+. Send it to the list and cc people who may need to know about
+  the change.
++
+The people who may need to know are the ones whose code you
+are butchering.  These people happen to be the ones who are
+most likely to be knowledgeable enough to help you, but
+they have no obligation to help you (i.e. you ask for help,
+don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
+help you find out who they are.
 
-     The people who may need to know are the ones whose code you
-     are butchering.  These people happen to be the ones who are
-     most likely to be knowledgeable enough to help you, but
-     they have no obligation to help you (i.e. you ask for help,
-     don't demand).  "git log -p -- $area_you_are_modifying" would
-     help you find out who they are.
+. You get comments and suggestions for improvements.  You may
+  even get them in a "on top of your change" patch form.
 
- (2) You get comments and suggestions for improvements.  You may
-     even get them in a "on top of your change" patch form.
+. Polish, refine, and re-send to the list and the people who
+  spend their time to improve your patch.  Go back to step (2).
 
- (3) Polish, refine, and re-send to the list and the people who
-     spend their time to improve your patch.  Go back to step (2).
+. The list forms consensus that the last round of your patch is
+  good.  Send it to the maintainer and cc the list.
 
- (4) The list forms consensus that the last round of your patch is
-     good.  Send it to the maintainer and cc the list.
-
- (5) A topic branch is created with the patch and is merged to 'next',
-     and cooked further and eventually graduates to 'master'.
+. A topic branch is created with the patch and is merged to `next`,
+  and cooked further and eventually graduates to `master`.
 
 In any time between the (2)-(3) cycle, the maintainer may pick it up
-from the list and queue it to 'pu', in order to make it easier for
+from the list and queue it to `pu`, in order to make it easier for
 people play with it without having to pick up and apply the patch to
 their trees themselves.
 
-------------------------------------------------
-Know the status of your patch after submission
+[[patch-status]]
+== Know the status of your patch after submission
 
 * You can use Git itself to find out when your patch is merged in
-  master. 'git pull --rebase' will automatically skip already-applied
+  master. `git pull --rebase` will automatically skip already-applied
   patches, and will let you know. This works only if you rebase on top
   of the branch in which your patch has been merged (i.e. it will not
   tell you if your patch is merged in pu if you rebase on top of
@@ -390,8 +415,8 @@ Know the status of your patch after submission
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.
 
---------------------------------------------------
-GitHub-Travis CI hints
+[[travis]]
+== GitHub-Travis CI hints
 
 With an account at GitHub (you can get one for free to work on open
 source projects), you can use Travis CI to test your changes on Linux,
@@ -400,25 +425,25 @@ test build here: https://travis-ci.org/git/git/builds/120473209
 
 Follow these steps for the initial setup:
 
- (1) Fork https://github.com/git/git to your GitHub account.
-     You can find detailed instructions how to fork here:
-     https://help.github.com/articles/fork-a-repo/
+. Fork https://github.com/git/git to your GitHub account.
+  You can find detailed instructions how to fork here:
+  https://help.github.com/articles/fork-a-repo/
 
- (2) Open the Travis CI website: https://travis-ci.org
+. Open the Travis CI website: https://travis-ci.org
 
- (3) Press the "Sign in with GitHub" button.
+. Press the "Sign in with GitHub" button.
 
- (4) Grant Travis CI permissions to access your GitHub account.
-     You can find more information about the required permissions here:
-     https://docs.travis-ci.com/user/github-oauth-scopes
+. Grant Travis CI permissions to access your GitHub account.
+  You can find more information about the required permissions here:
+  https://docs.travis-ci.com/user/github-oauth-scopes
 
- (5) Open your Travis CI profile page: https://travis-ci.org/profile
+. Open your Travis CI profile page: https://travis-ci.org/profile
 
- (6) Enable Travis CI builds for your Git fork.
+. Enable Travis CI builds for your Git fork.
 
 After the initial setup, Travis CI will run whenever you push new changes
 to your fork of Git on GitHub.  You can monitor the test state of all your
-branches here: https://travis-ci.org/<Your GitHub handle>/git/branches
+branches here: https://travis-ci.org/__<Your GitHub handle>__/git/branches
 
 If a branch did not pass all test cases then it is marked with a red
 cross.  In that case you can click on the failing Travis CI job and
@@ -430,17 +455,16 @@ example: https://travis-ci.org/git/git/jobs/122676187
 Fix the problem and push your fix to your Git fork.  This will trigger
 a new Travis CI build to ensure all tests pass.
 
-
-------------------------------------------------
-MUA specific hints
+[[mua]]
+== MUA specific hints
 
 Some of patches I receive or pick up from the list share common
 patterns of breakage.  Please make sure your MUA is set up
 properly not to corrupt whitespaces.
 
-See the DISCUSSION section of git-format-patch(1) for hints on
+See the DISCUSSION section of linkgit:git-format-patch[1] for hints on
 checking your patch by mailing it to yourself and applying with
-git-am(1).
+linkgit:git-am[1].
 
 While you are at it, check the resulting commit log message from
 a trial run of applying the patch.  If what is in the resulting
@@ -452,23 +476,24 @@ should come after the three-dash line that signals the end of the
 commit message.
 
 
-Pine
-----
+=== Pine
 
 (Johannes Schindelin)
 
+....
 I don't know how many people still use pine, but for those poor
 souls it may be good to mention that the quell-flowed-text is
 needed for recent versions.
 
 ... the "no-strip-whitespace-before-send" option, too. AFAIK it
 was introduced in 4.60.
+....
 
 (Linus Torvalds)
 
+....
 And 4.58 needs at least this.
 
----
 diff-tree 8326dd8350be64ac7fc805f6563a1d61ad10d32c (from e886a61f76edf5410573e92e38ce22974f9c40f1)
 Author: Linus Torvalds <torvalds@g5.osdl.org>
 Date:   Mon Aug 15 17:23:51 2005 -0700
@@ -490,10 +515,11 @@ diff --git a/pico/pico.c b/pico/pico.c
 +#endif
 		c |= COMP_EXIT;
 		break;
-
+....
 
 (Daniel Barkalow)
 
+....
 > A patch to SubmittingPatches, MUA specific help section for
 > users of Pine 4.63 would be very much appreciated.
 
@@ -503,23 +529,21 @@ that or Gentoo did it.) So you need to set the
 "no-strip-whitespace-before-send" option, unless the option you have is
 "strip-whitespace-before-send", in which case you should avoid checking
 it.
+....
 
+=== Thunderbird, KMail, GMail
 
-Thunderbird, KMail, GMail
--------------------------
+See the MUA-SPECIFIC HINTS section of linkgit:git-format-patch[1].
 
-See the MUA-SPECIFIC HINTS section of git-format-patch(1).
+=== Gnus
 
-Gnus
-----
-
-'|' in the *Summary* buffer can be used to pipe the current
+"|" in the `*Summary*` buffer can be used to pipe the current
 message to an external program, and this is a handy way to drive
-"git am".  However, if the message is MIME encoded, what is
+`git am`.  However, if the message is MIME encoded, what is
 piped into the program is the representation you see in your
-*Article* buffer after unwrapping MIME.  This is often not what
+`*Article*` buffer after unwrapping MIME.  This is often not what
 you would want for two reasons.  It tends to screw up non ASCII
 characters (most notably in people's names), and also
-whitespaces (fatal in patches).  Running 'C-u g' to display the
-message in raw form before using '|' to run the pipe can work
+whitespaces (fatal in patches).  Running "C-u g" to display the
+message in raw form before using "|" to run the pipe can work
 this problem around.
