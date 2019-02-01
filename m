Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6BC11F453
	for <e@80x24.org>; Fri,  1 Feb 2019 03:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfBADJc (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 22:09:32 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37438 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBADJc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 22:09:32 -0500
Received: by mail-pl1-f201.google.com with SMTP id v11so4021779ply.4
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 19:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=47RKW2uq+q59aZ/vJipWPa8sYlMPbGdbY2MUUSRWtTo=;
        b=N38RVK3VO/pGb2rnXyd3Z0KMglp+9PN/3AI/tDhmSXs7UE6DuhUx+X+7zMocC1ibk5
         8K46kM8jR9wB4heT9/EbJQzk0JgH+sR+EzplTCCgzH2Hj6b5jcC7CTcg3yZSVPgWKAyB
         gBO7Xa4/EEags5Qtb6up3ejm6YqX7BD05xvV6X21nwpz9ViDk5dE/CdV8Nf1AfVIJ3AE
         3edAqTqX40DOj2ypCLI2vyf+vTKpmwI0lrh7pvWCKOUwEmd4LEurwZNSScxcOnM9kpmX
         7ihKcyrFlKJ2O4GWlY3BhM99cKBA5I+qsT7uC0wDHasHp597wERu8jNNT0K+vGkq39z4
         ZZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=47RKW2uq+q59aZ/vJipWPa8sYlMPbGdbY2MUUSRWtTo=;
        b=ksR1uDTYgEsbA+4Yyt+AxVJXNf0SXKyR3jB0kh7VJjFCMMny9x1HQS8MSgsTm4bdrN
         UWyA9SObK4r3MMt59oNF+/qBlKOwzJ8b+UA60rJHBXCUFLASHlYXKQ6SqM0fbRAiCv3X
         q6oeM3KBP6sxDKl24pBC/UTmLqWvCGYIPwBu5/JAZZMHyof+ARbaCYy4p8rk/vpdKowc
         VLGW59iZLyrDT4fDZ3L2+oD/gxPxJMdkcjDkTaPoJDBP7Lr3/WFyIbV2oTmOaDnSYEf+
         zvyJ9AWgWR1wavpeTGv76nyo8aDIh2i9rYfHNby65bnv0b1u7Y3Q24lWDy02CBm+Af3o
         zqQA==
X-Gm-Message-State: AHQUAuaxLac49RuCvOK56Y8YeniVOGzNW5ccwNu2lZfLCjR31W0SfJMq
        sskhSVIzaculvN+8DD9TvhlSXFKjF8A+Q5fqfxo9AQsAllHT+JrDKOkhxFs1j/gdWs6oUHy1aKA
        Kun09o6kWEGmo9w8ZB24cgM5EIa41VCvfrAiaRtkxHB+Jv/MZ+hkZLbcAvQ==
X-Google-Smtp-Source: AHgI3IbQ2r2zBNJLQ6b+PycPiss6l4PTcOueF56KeY1bPujCizzicGqM0JKU3y9gjmnLTHjMtzIMOgLNeI4=
X-Received: by 2002:a62:9f9c:: with SMTP id v28mr7277846pfk.72.1548990570474;
 Thu, 31 Jan 2019 19:09:30 -0800 (PST)
Date:   Thu, 31 Jan 2019 19:09:18 -0800
Message-Id: <20190201030925.177124-1-sxenos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH v4 1/8] technical doc: add a design doc for the evolve command
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

This document describes what a change graph for
git would look like, the behavior of the evolve command,
and the changes planned for other commands.

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 Documentation/technical/evolve.txt | 1034 ++++++++++++++++++++++++++++
 1 file changed, 1034 insertions(+)
 create mode 100644 Documentation/technical/evolve.txt

diff --git a/Documentation/technical/evolve.txt b/Documentation/technical/e=
volve.txt
new file mode 100644
index 0000000000..7967c73e5d
--- /dev/null
+++ b/Documentation/technical/evolve.txt
@@ -0,0 +1,1034 @@
+Evolve
+=3D=3D=3D=3D=3D=3D
+
+Objective
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Create an "evolve" command to help users craft a high quality commit histo=
ry.
+Users can improve commits one at a time and in any order, then run git evo=
lve to
+rewrite their recent history to ensure everything is up-to-date. We track
+amendments to a commit over time in a change graph. Users can share their
+progress with others by exchanging their change graphs using the standard =
push,
+fetch, and format-patch commands.
+
+Status
+=3D=3D=3D=3D=3D=3D
+This proposal has not been implemented yet.
+
+Background
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Imagine you have three sequential changes up for review and you receive fe=
edback
+that requires editing all three changes. We'll define the word "change"
+formally later, but for the moment let's say that a change is a work-in-pr=
ogress
+whose final version will be submitted as a commit in the future.
+
+While you're editing one change, more feedback arrives on one of the other=
s.
+What do you do?
+
+The evolve command is a convenient way to work with chains of commits that=
 are
+under review. Whenever you rebase or amend a commit, the repository rememb=
ers
+that the old commit is obsolete and has been replaced by the new one. Then=
, at
+some point in the future, you can run "git evolve" and the correct sequenc=
e of
+rebases will occur in the correct order such that no commit has an obsolet=
e
+parent.
+
+Part of making the "evolve" command work involves tracking the edits to a =
commit
+over time, which is why we need an change graph. However, the change
+graph will also bring other benefits:
+
+- Users can view the history of a change directly (the sequence of amends =
and
+  rebases it has undergone, orthogonal to the history of the branch it is =
on).
+- It will be possible to quickly locate and list all the changes the user
+  currently has in progress.
+- It can be used as part of other high-level commands that combine or spli=
t
+  changes.
+- It can be used to decorate commits (in git log, gitk, etc) that are eith=
er
+  obsolete or are the tip of a work in progress.
+- By pushing and pulling the change graph, users can collaborate more
+  easily on changes-in-progress. This is better than pushing and pulling t=
he
+  changes themselves since the change graph can be used to locate a more
+  specific merge base, allowing for better merges between different versio=
ns of
+  the same change.=20
+- It could be used to correctly rebase local changes and other local branc=
hes
+  after running git-filter-branch.
+- It can replace the change-id footer used by gerrit.
+
+Goals
+-----
+Legend: Goals marked with P0 are required. Goals marked with Pn should be
+attempted unless they interfere with goals marked with Pn-1.
+
+P0. All commands that modify commits (such as the normal commit --amend or
+    rebase command) should mark the old commit as being obsolete and repla=
ced by
+    the new one. No additional commands should be required to keep the
+    change graph up-to-date.
+P0. Any commit that may be involved in a future evolve command should not =
be
+    garbage collected. Specifically:
+    - Commits that obsolete another should not be garbage collected until
+      user-specified conditions have occurred and the change has expired f=
rom
+      the reflog. User specified conditions for removing changes include:
+      - The user explicitly deleted the change.
+      - The change was merged into a specific branch.
+    - Commits that have been obsoleted by another should not be garbage
+      collected if any of their replacements are still being retained.
+P0. A commit can be obsoleted by more than one replacement (called diverge=
nce).
+P0. Must be able to resolve divergence (convergence).
+P1. Users should be able to share chains of obsolete changes in order to
+    collaborate on WIP changes.
+P2. Such sharing should be at the user=E2=80=99s option. That is, it shoul=
d be possible
+    to directly share a change without also sharing the file states or com=
mit
+    comments from the obsolete changes that led up to it, and the choice n=
ot to
+    share those commits should not require changing any commit hashes.
+P2. It should be possible to discard part or all of the change graph
+    without discarding the commits themselves that are already present in
+    branches and the reflog.
+P2. Provide sufficient information to replace gerrit's Change-Id footers.
+
+Similar technologies
+--------------------
+There are some other technologies that address the same end-user problem.
+
+Rebase -i can be used to solve the same problem, but users can't easily sw=
itch
+tasks midway through an interactive rebase or have more than one interacti=
ve
+rebase going on at the same time. It can't handle the case where you have
+multiple changes sharing the same parent when that parent needs to be reba=
sed
+and won't let you collaborate with others on resolving a complicated inter=
active
+rebase. You can think of rebase -i as a top-down approach and the evolve c=
ommand
+as the bottom-up approach to the same problem.
+
+Several patch queue managers have been built on top of git (such as topgit=
,
+stgit, and quilt). They address the same user need. However they also rely=
 on
+state managed outside git that needs to be kept in sync. Such state can be
+easily damaged when running a git native command that is unaware of the pa=
tch
+queue. They also typically require an explicit initialization step to be d=
one by
+the user which creates workflow problems.
+
+Mercurial implements a very similar feature in its EvolveExtension. The be=
havior
+of the evolve command itself is very similar, but the storage format for t=
he
+change graph differs. In the case of mercurial, each change set can have o=
ne or
+more obsolescence markers that point to other changesets that they replace=
. This
+is similar to the "Commit Headers" approach considered in the other option=
s
+appendix. The approach proposed here stores obsolescence information in a
+separate metacommit graph, which makes exchanging of obsolescence informat=
ion
+optional.
+
+Mercurial's default behavior makes it easy to find and switch between
+non-obsolete changesets that aren't currently on any branch. We introduce =
the
+notion of a new ref namespace that enables a similar workflow via a differ=
ent
+mechanism. Mercurial has the notion of changeset phases which isn't presen=
t
+in git and creates new ways for a changeset to diverge. Git doesn't need
+to deal with these issues, but it has to deal with picking an upstream bra=
nch as
+a target for rebases and protecting obsolescence information from GC. We a=
lso
+introduce some additional transformations (see obsolescence-over-cherry-pi=
ck,
+below) that aren't present in the mercurial implementation.
+
+Semi-related work
+-----------------
+There are other technologies that address different problems but have some
+similarities with this proposal.
+
+Replacements (refs/replace) are superficially similar to obsolescences in =
that
+they describe that one commit should be replaced by another. However, they
+differ in both how they are created and how they are intended to be used.
+Obsolescences are created automatically by the commands a user runs, and t=
hey
+describe the user=E2=80=99s intent to perform a future rebase. Obsolete co=
mmits still
+appear in branches, logs, etc like normal commits (possibly with an extra
+decoration that marks them as obsolete). Replacements are typically create=
d
+explicitly by the user, they are meant to be kept around for a long time, =
and
+they describe a replacement to be applied at read-time rather than as the =
input
+to a future operation. When a replaced commit is queried, it is typically =
hidden
+and swapped out with its replacement as though the replacement has already
+occurred.
+
+Git-imerge is a project to help make complicated merges easier, particular=
ly
+when merging or rebasing long chains of patches. It is not an alternative =
to
+the change graph, but its algorithm of applying smaller incremental merges
+could be used as part of the evolve algorithm in the future.
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+We introduce the notion of =E2=80=9Cmeta-commits=E2=80=9D which describe h=
ow one commit was
+created from other commits. A branch of meta-commits is known as a change.
+Changes are created and updated automatically whenever a user runs a comma=
nd
+that creates a commit. They are used for locating obsolete commits, provid=
ing a
+list of a user=E2=80=99s unsubmitted work in progress, and providing a sta=
ble name for
+each unsubmitted change.
+
+Users can exchange edit histories by pushing and fetching changes.
+
+New commands will be introduced for manipulating changes and resolving
+divergence between them. Existing commands that create commits will be upd=
ated
+to modify the meta-commit graph and create changes where necessary.
+
+Example usage
+-------------
+# First create three dependent changes
+$ echo foo>bar.txt && git add .
+$ git commit -m "This is a test"
+created change metas/this_is_a_test
+$ echo foo2>bar2.txt && git add .
+$ git commit -m "This is also a test"
+created change metas/this_is_also_a_test
+$ echo foo3>bar3.txt && git add .
+$ git commit -m "More testing"
+created change metas/more_testing
+
+# List all our changes in progress
+$ git change list
+metas/this_is_a_test
+metas/this_is_also_a_test
+* metas/more_testing
+metas/some_change_already_merged_upstream
+
+# Now modify the earliest change, using its stable name
+$ git reset --hard metas/this_is_a_test
+$ echo morefoo>>bar.txt && git add . && git commit --amend --no-edit
+
+# Use git-evolve to fix up any dependent changes
+$ git evolve
+rebasing metas/this_is_also_a_test onto metas/this_is_a_test
+rebasing metas/more_testing onto metas/this_is_also_a_test
+Done
+
+# Use git-obslog to view the history of the this_is_a_test change
+$ git log --obslog
+93f110 metas/this_is_a_test@{0} commit (amend): This is a test
+930219 metas/this_is_a_test@{1} commit: This is a test
+
+# Now create an unrelated change
+$ git reset --hard origin/master
+$ echo newchange>unrelated.txt && git add .
+$ git commit -m "Unrelated change"
+created change metas/unrelated_change
+
+# Fetch the latest code from origin/master and use git-evolve
+# to rebase all dependent changes.
+$ git fetch origin master
+$ git evolve origin/master
+deleting metas/some_change_already_merged_upstream
+rebasing metas/this_is_a_test onto origin/master
+rebasing metas/this_is_also_a_test onto metas/this_is_a_test
+rebasing metas/more_testing onto metas/this_is_also_a_test
+rebasing metas/unrelated_change onto origin/master
+Conflict detected! Resolve it and then use git evolve --continue to resume=
.
+
+# Sort out the conflict
+$ git mergetool
+$ git evolve --continue
+Done
+
+# Share the full history of edits for the this_is_a_test change
+# with a review server
+$ git push origin metas/this_is_a_test:refs/for/master
+# Share the lastest commit for =E2=80=9CUnrelated change=E2=80=9D, without=
 history
+$ git push origin HEAD:refs/for/master
+
+Detailed design
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Obsolescence information is stored as a graph of meta-commits. A meta-comm=
it is
+a specially-formatted merge commit that describes how one commit was creat=
ed
+from others.
+
+Meta-commits look like this:
+
+$ git cat-file -p <example_meta_commit>
+tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+parent aa7ce55545bf2c14bef48db91af1a74e2347539a
+parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
+parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
+author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
+committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
+parent-type c r o
+
+This says =E2=80=9Ccommit aa7ce555 makes commit d64309ee obsolete. It was =
created by
+cherry-picking commit 7e1bbcd3=E2=80=9D.
+
+The tree for meta-commits is always the empty tree whose hash matches
+4b825dc642cb6eb9a060e54bf8d69288fbee4904 exactly, but future versions of g=
it may
+attach other trees here. For forward-compatibility fsck should ignore such=
 trees
+if found on future repository versions. Similarly, current versions of git
+should always fill in an empty commit comment and tools like fsck should i=
gnore
+the content of the commit comment if present in a future repository versio=
n.
+This will allow future versions of git to add metadata to the meta-commit
+comments or tree without breaking forwards compatibility.
+
+Parent-type
+-----------
+The =E2=80=9Cparent-type=E2=80=9D field in the commit header identifies a =
commit as a
+meta-commit and indicates the meaning for each of its parents. It is never
+present for normal commits. It contains a space-deliminated list of enum v=
alues
+whose order matches the order of the parents. Possible parent types are:
+
+- c: (content) the content parent identifies the commit that this meta-com=
mit is
+  describing.
+- r: (replaced) indicates that this parent is made obsolete by the content
+  parent.
+- o: (origin) indicates that this parent was generated from the given comm=
it.
+- a: (abandoned) used in place of a content parent for abandoned changes. =
Points
+  to the final content commit for the change at the time it was abandoned.
+
+There must be exactly one content or abandoned parent for each meta-commit=
 and it is
+always the first parent. The content commit will always be a normal commit=
 and not a
+meta-commit. However, future versions of git may create meta-commits for o=
ther
+meta-commits and the fsck tool must be aware of this for forwards compatib=
ility.
+
+A meta-commit can have zero or more replaced parents. An amend operation c=
reates
+a single replaced parent. A merge used to resolve divergence (see divergen=
ce,
+below) will create multiple replaced parents. A meta-commit may have no
+replaced parents if it describes a cherry-pick or squash merge that copies=
 one
+or more commits but does not replace them.
+
+A meta-commit can have zero or more origin parents. A cherry-pick creates =
a
+single origin parent. Certain types of squash merge will create multiple o=
rigin
+parents. Origin parents don't directly cause their origin to become obsole=
te,
+but are used when computing blame or locating a merge base. The section
+on obsolescence over cherry-picks describes how the evolve command uses
+origin parents.
+
+A replaced parent or origin parent may be either a normal commit (indicati=
ng
+the oldest-known version of a change) or another meta-commit (for a change=
 that
+has already been modified one or more times).
+
+The parent-type field needs to go after the committer field since git's ru=
les
+for forwards-compatibility require that new fields to be at the end of the
+header. Putting a new field in the middle of the header would break fsck.=
=20
+
+The presence of an abandoned parent indicates that the change should be pr=
uned
+by the evolve command, and removed from the repository's history. The aban=
doned
+parent points to the version of the change that should be restored if the =
user
+attempts to restore the change.
+
+Changes
+-------
+A branch of meta-commits describes how a commit was produced and what prev=
ious
+commits it is based on. It is also an identifier for a thing the user is
+currently working on. We refer to such a meta-branch as a change.
+
+Local changes are stored in the new refs/metas namespace. Remote changes a=
re
+stored in the refs/remote/<remotename>/metas namespace.
+
+The list of changes in refs/metas is more than just a mechanism for the ev=
olve
+command to locate obsolete commits. It is also a convenient list of all of=
 a
+user=E2=80=99s work in progress and their current state - a list of things=
 they=E2=80=99re
+likely to want to come back to.
+
+Strictly speaking, it is the presence of the branch in the refs/metas name=
space
+that marks a branch as being a change, not the fact that it points to a
+metacommit. Metacommits are only created when a commit is amended or rebas=
ed, so
+in the case where a change points to a commit that has never been modified=
, the
+change points to that initial commit rather than a metacommit.
+
+Changes are also stored in the refs/hiddenmetas namespace. Hiddenmetas hol=
ds
+metadata for historical changes that are not currently in progress by the =
user.
+Commands like filter-branch and other bulk import commands create metadata=
 in
+this namespace.
+
+Note that the changes in hiddenmetas get special treatment in several ways=
:
+
+- They are not cleaned up automatically once merged, since it is expected =
that
+  they refer to historical changes.
+- User commands that modify changes don't append to these changes as they =
would
+  to a change in refs/metas.
+- They are not displayed when the user lists their local changes.
+
+Obsolescence
+------------
+A commit is considered obsolete if it is reachable from the =E2=80=9Crepla=
ces=E2=80=9D edges
+anywhere in the history of a change and it isn=E2=80=99t the head of that =
change.
+Commits may be the content for 0 or more meta-commits. If the same commit
+appears in multiple changes, it is not obsolete if it is the head of any o=
f
+those changes.
+
+Note that there is an exeption to this rule. The metas namespace takes
+precedence over the hiddenmetas namespace for the purpose of obsolescence.=
 That
+is, if a change appears in a replaces edge of a change in the metas namesp=
ace,
+it is obsolete even if it also appears as the head of a change in the
+hiddenmetas namespace.
+
+This special case prevents the hiddenmetas namespace from creating diverge=
nce
+with the user's work in progress, and allows the user to resolve historica=
l
+divergence by creating new changes in the metas namespace.
+
+Divergence
+----------
+From the user=E2=80=99s perspective, two changes are divergent if they bot=
h ask for
+different replacements to the same commit. More precisely, a target commit=
 is
+considered divergent if there is more than one commit at the head of a cha=
nge in
+refs/metas that leads to the target commit via an unbroken chain of =E2=80=
=9Cobsolete=E2=80=9D
+parents.
+
+Much like a merge conflict, divergence is a situation that requires user
+intervention to resolve. The evolve command will stop when it encounters
+divergence and prompt the user to resolve the problem. Users can solve the
+problem in several ways:
+
+- Discard one of the changes (by deleting its change branch).
+- Merge the two changes (producing a single change branch).
+- Copy one of the changes (keep both commits, but one of them gets a new
+  metacommit appended to its history that is connected to its predecessor =
via an
+  origin edge rather than an obsolete edge. That new change no longer obso=
letes
+  the original.)
+
+Obsolescence across cherry-picks
+--------------------------------
+By default the evolve command will treat cherry-picks and squash merges as=
 being
+completely separate from the original. Further amendments to the original =
commit
+will have no effect on the cherry-picked copy. However, this behavior may =
not be
+desirable in all circumstances.
+
+The evolve command may at some point support an option to look for cases w=
here
+the source of a cherry-pick or squash merge has itself been amended, and
+automatically apply that same change to the cherry-picked copy. In such ca=
ses,
+it would traverse origin edges rather than ignoring them, and would treat =
a
+commit with origin edges as being obsolete if any of its origins were obso=
lete.
+
+Garbage collection
+------------------
+For GC purposes, meta-commits are normal commits. Just as a commit causes =
its
+parents and tree to be retained, a meta-commit also causes its parents to =
be
+retained.
+
+Change creation
+---------------
+Changes are created automatically whenever the user runs a command like =
=E2=80=9Ccommit=E2=80=9D
+that has the semantics of creating a new change. They also move forward
+automatically even if they=E2=80=99re not checked out. For example, whenev=
er the user
+runs a command like =E2=80=9Ccommit --amend=E2=80=9D that modifies a commi=
t, all branches in
+refs/metas that pointed to the old commit move forward to point to its
+replacement instead. This also happens when the user is working from a det=
ached
+head.
+
+This does not mean that every commit has a corresponding change. By defaul=
t,
+changes only exist for recent locally-created commits. Users may explicitl=
y pull
+changes from other users or keep their changes around for a long time, but
+either behavior requires a user to opt-in. Code review systems like gerrit=
 may
+also choose to keep changes around forever.
+
+Note that the changes in refs/metas serve a dual function as both a way to
+identify obsolete changes and as a way for the user to keep track of their=
 work
+in progress. If we were only concerned with identifying obsolete changes, =
it
+would be sufficient to create the change branch lazily the first time a co=
mmit
+is obsoleted. Addressing the second use - of refs/metas as a mechanism for
+keeping track of work in progress - is the reason for eagerly creating the
+change on first commit.
+
+Change naming
+-------------
+When a change is first created, the only requirement for its name is that =
it
+must be unique. Good names would also serve as useful mnemonics and be eas=
y to
+type. For example, a short word from the commit message containing no numb=
ers or
+special characters and that shows up with low frequency in other commit me=
ssages
+would make a good choice.
+
+Different users may prefer different heuristics for their change names. Fo=
r this
+reason a new hook will be introduced to compute change names. Git will inv=
oke
+the hook for all newly-created changes and will append a numeric suffix if=
 the
+name isn=E2=80=99t unique. The default heuristics are not specified by thi=
s proposal and
+may change during implementation.
+
+Change deletion
+---------------
+Changes are normally only interesting to a user while a commit is still in
+development and under review. Once the commit has submitted wherever it is
+going, its change can be discarded.
+
+The normal way of deleting changes makes this easy to do - changes are del=
eted
+by the evolve command when it detects that the change is present in an ups=
tream
+branch. It does this in two ways: if the latest commit in a change either =
shows
+up in the branch history or the change becomes empty after a rebase, it is
+considered merged and the change is discarded. In this context, an =E2=80=
=9Cupstream
+branch=E2=80=9D is any branch passed in as the upstream argument of the ev=
olve command.
+
+In case this sometimes deletes a useful change, such automatic deletions a=
re
+recorded in the reflog allowing them to be easily recovered.
+
+Sharing changes
+---------------
+Change histories are shared by pushing or fetching meta-commits and change
+branches. This provides users with a lot of control of what to share and
+repository implementations with control over what to retain.
+
+Users that only want to share the content of a commit can do so by pushing=
 the
+commit itself as they currently would. Users that want to share an edit hi=
story
+for the commit can push its change, which would point to a meta-commit rat=
her
+than the commit itself if there is any history to share. Note that multipl=
e
+changes can refer to the same commits, so it=E2=80=99s possible to constru=
ct and push a
+different history for the same commit in order to remove sensitive or irre=
levant
+intermediate states.
+
+Imagine the user is working on a change =E2=80=9Cmychange=E2=80=9D that is=
 currently the latest
+commit on master, they have two ways to share it:
+
+# User shares just a commit without its history
+> git push origin master
+
+# User shares the full history of the commit to a review system
+> git push origin metas/mychange:refs/for/master
+
+# User fetches a collaborator=E2=80=99s modifications to their change
+> git fetch remotename metas/mychange
+# Which updates the ref remote/remotename/metas/mychange
+
+This will cause more intermediate states to be shared with the server than=
 would
+have been shared previously. A review system like gerrit would need to kee=
p
+track of which states had been explicitly pushed versus other intermediate
+states in order to de-emphasize (or hide) the extra intermediate states fr=
om the
+user interface.
+
+Merge-base
+----------
+Merge-base will be changed to search the meta-commit graph for common ance=
stors
+as well as the commit graph, and will generally prefer results from the
+meta-commit graph over the commit graph. Merge-base will consider meta-com=
mits
+from all changes, and will traverse both origin and obsolete edges.
+
+The reason for this is that - when merging two versions of the same commit
+together - an earlier version of that same commit will usually be much mor=
e
+similar than their common parent. This should make the workflow of collabo=
rating
+on unsubmitted patches as convenient as the workflow for collaborating in =
a
+topic branch by eliminating repeated merges.
+
+Configuration
+-------------
+The core.enableChanges configuration variable enables the creation and upd=
ate
+of change branches. This is enabled by default.
+
+User interface
+--------------
+All git porcelain commands that create commits are classified as having on=
e of
+four behaviors: modify, create, copy, or import. These behaviors are discu=
ssed
+in more detail below.
+
+Modify commands
+---------------
+Modification commands (commit --amend, rebase) will mark the old commit as
+obsolete by creating a new meta-commit that references the old one as a
+replaced parent. In the event that multiple changes point to the same comm=
it,
+this is done independently for every such change.
+
+More specifically, modifications work like this:
+
+1. Locate all existing changes for which the old commit is the content for=
 the
+   head of the change branch. If no such branch exists, create one that po=
ints
+   to the old commit. Changes that include this commit in their history bu=
t not
+   at their head are explicitly not included.
+2. For every such change, create a new meta-commit that references the new
+   commit as its content and references the old head of the change as a
+   replaced parent.
+3. Move the change branch forward to point to the new meta-commit.
+
+Copy commands
+-------------
+Copy commands (cherry-pick, merge --squash) create a new meta-commit that
+references the old commits as origin parents. Besides the fact that the ne=
w
+parents are tagged differently, copy commands work the same way as modify
+commands.
+
+Create commands
+---------------
+Creation commands (commit, merge) create a new commit and a new change tha=
t
+points to that commit. The do not create any meta-commits.
+
+Import commands
+---------------
+Import commands (fetch, pull) do not create any new meta-commits or change=
s
+unless that is specifically what they are importing. For example, the fetc=
h
+command would update remote/origin/metas/change35 and fetch all referenced
+meta-commits if asked to do so directly, but it wouldn=E2=80=99t create an=
y changes or
+meta-commits for commits discovered on the master branch when running =E2=
=80=9Cgit fetch
+origin master=E2=80=9D.
+
+Other commands
+--------------
+Some commands don=E2=80=99t fit cleanly into one of the above categories.
+
+Semantically, filter-branch should be treated as a modify command, but doi=
ng so
+is likely to create a lot of irrelevant clutter in the changes namespace a=
nd the
+large number of extra change refs may introduce performance problems. We
+recommend treating filter-branch as an import command initially, but makin=
g it
+behave more like a modify command in future follow-up work. One possible
+solution may be to treat commits that are part of existing changes as bein=
g
+modified but to avoid creating changes for other rewritten changes.
+
+Once the evolve command can handle obsolescence across cherry-picks, such
+cherry-picks will result in a hybrid move-and-copy operation. It will crea=
te
+cherry-picks that replace other cherry-picks, which will have both origin =
edges
+(pointing to the new source commit being picked) and obsolete edges (point=
ing to
+the previous cherry-pick being replaced).
+
+Evolve
+------
+The evolve command performs the correct sequence of rebases such that no c=
hange
+has an obsolete parent. The syntax looks like this:
+
+git evolve [--abort][--continue][--quit] [upstream=E2=80=A6]
+
+It takes an optional list of upstream branches. All changes whose parent s=
hows
+up in the history of one of the upstream branches will be rebased onto the
+upstream branch before resolving obsolete parents.
+
+Any change whose latest state is found in an upstream branch (or that ends=
 up
+empty after rebase) will be deleted. This is the normal mechanism for dele=
ting
+changes. Changes are created automatically on the first commit, and are de=
leted
+automatically when evolve determines that they=E2=80=99ve been merged upst=
ream.
+
+Orphan commits are commits with obsolete parents. The evolve command then
+repeatedly rebases orphan commits with non-orphan parents until there are =
either
+no orphan commits left, a merge conflict is discovered, or a divergent par=
ent is
+discovered.
+
+When evolve discovers divergence, it will first check if it can resolve th=
e
+divergence automatically using one of its enabled transformations. Support=
ed
+transformations are:
+
+- Check if the user has already merged the divergent changes in a follow-u=
p
+  change. That is, look for an existing merge in a follow-up change where =
all
+  the parents are divergent versions of the same change. Squash that merge=
 with
+  its parents and use the result as the resolution for the divergence.
+
+- Attempt to auto-merge all the divergent changes (disabled by default).
+
+Each of the transformations can be enabled or disabled by command line opt=
ions.
+
+The --abort option returns all changes to the state they were in prior to
+invoking evolve, and the --quit option terminates the current evolution wi=
thout
+changing the current state.
+
+If the working tree is dirty, evolve will attempt to stash the user's chan=
ges
+before applying the evolve and then reapply those changes afterward, in mu=
ch
+the same way as rebase --autostash does.
+
+Checkout
+--------
+Running checkout on a change by name has the same effect as checking out a
+detached head pointing to the latest commit on that change-branch. There i=
s no
+need to ever have HEAD point to a change since changes always move forward=
 when
+necessary, no matter what branch the user has checked out
+
+Meta-commits themselves cannot be checked out by their hash.
+
+Reset
+-----
+Resetting a branch to a change by name is the same as resetting to the com=
mit at
+that change=E2=80=99s head.
+
+Commit
+------
+Commit --amend gets modify semantics and will move existing changes forwar=
d. The
+normal form of commit gets create semantics and will create a new change.
+
+$ touch foo && git add . && git commit -m "foo" && git tag A
+$ touch bar && git add . && git commit -m "bar" && git tag B
+$ touch baz && git add . && git commit -m "baz" && git tag C
+
+This produces the following commits:
+A(tree=3D[foo])
+B(tree=3D[foo, bar], parent=3DA)
+C(tree=3D[foo, bar, baz], parent=3DB)
+
+...along with three changes:
+metas/foo =3D A
+metas/bar =3D B
+metas/baz =3D C
+
+Running commit --amend does the following:
+$ git checkout B
+$ touch zoom && git add . && git commit --amend -m "baz and zoom"
+$ git tag D
+
+Commits:
+A(tree=3D[foo])
+B(tree=3D[foo, bar], parent=3DA)
+C(tree=3D[foo, bar, baz], parent=3DB)
+D(tree=3D[foo, bar, zoom], parent=3DA)
+Dmeta(content=3DD, obsolete=3DB)
+
+Changes:
+metas/foo =3D A
+metas/bar =3D Dmeta
+metas/baz =3D C
+
+Merge
+-----
+Merge gets create, modify, or copy semantics based on what is being merged=
 and
+the options being used.
+
+The --squash version of merge gets copy semantics (it produces a new chang=
e that
+is marked as a copy of all the original changes that were squashed into it=
).
+
+The =E2=80=9Cmodify=E2=80=9D version of merge replaces both of the origina=
l commits with the
+resulting merge commit. This is one of the standard mechanisms for resolvi=
ng
+divergence. The parents of the merge commit are the parents of the two com=
mits
+being merged. The resulting commit will not be a merge commit if both of t=
he
+original commits had the same parent or if one was the parent of the other=
.
+
+The =E2=80=9Ccreate=E2=80=9D version of merge creates a new change pointin=
g to a merge commit
+that has both original commits as parents. The result is what merge produc=
es now
+- a new merge commit. However, this version of merge doesn=E2=80=99t direc=
tly resolve
+divergence.
+
+To select between these two behaviors, merge gets new =E2=80=9C--amend=E2=
=80=9D and =E2=80=9C--noamend=E2=80=9D
+options which select between the =E2=80=9Ccreate=E2=80=9D and =E2=80=9Cmod=
ify=E2=80=9D behaviors respectively,
+with noamend being the default.
+
+For example, imagine we created two divergent changes like this:
+
+$ touch foo && git add . && git commit -m "foo" && git tag A
+$ touch bar && git add . && git commit -m "bar" && git tag B
+$ touch baz && git add . && git commit --amend -m "bar and baz"
+$ git tag C
+$ git checkout B
+$ touch bam && git add . && git commit --amend -m "bar and bam"
+$ git tag D
+
+At this point the commit graph looks like this:
+
+A(tree=3D[foo])
+B(tree=3D[bar], parent=3DA)
+C(tree=3D[bar, baz], parent=3DA)
+D(tree=3D[bar, bam], parent=3DA)
+Cmeta(content=3DC, obsoletes=3DB)
+Dmeta(content=3DD, obsoletes=3DB)
+
+There would be three active changes with heads pointing as follows:
+
+metas/changeA=3DA
+metas/changeB=3DCmeta
+metas/changeB2=3DDmeta
+
+ChangeB and changeB2 are divergent at this point. Lets consider what happe=
ns if
+perform each type of merge between changeB and changeB2.
+
+Merge example: Amend merge
+One way to resolve divergent changes is to use an amend merge. Recall that=
 HEAD
+is currently pointing to D at this point.
+
+$ git merge --amend metas/changeB
+
+Here we=E2=80=99ve asked for an amend merge since we=E2=80=99re trying to =
resolve divergence
+between two versions of the same change. There are no conflicts so we end =
up
+with this:
+
+E(tree=3D[bar, baz, bam], parent=3DA)
+Emeta(content=3DE, obsoletes=3D[Cmeta, Dmeta])
+
+With the following branches:
+
+metas/changeA=3DA
+metas/changeB=3DEmeta
+metas/changeB2=3DEmeta
+
+Notice that the result of the =E2=80=9Camend merge=E2=80=9D is a replaceme=
nt for C and D rather
+than a new commit with C and D as parents (as a normal merge would have
+produced). The parents of the amend merge are the parents of C and D which=
 - in
+this case - is just A, so the result is not a merge commit. Also notice th=
at
+changeB and changeB2 are now aliases for the same change.
+
+Merge example: Noamend merge
+Consider what would have happened if we=E2=80=99d used a noamend merge ins=
tead. Recall
+that HEAD was at D and our branches looked like this:
+
+metas/changeA=3DA
+metas/changeB=3DCmeta
+metas/changeB2=3DDmeta
+
+$ git merge --noamend metas/changeB
+
+That would produce the sort of merge we=E2=80=99d normally expect today:
+
+F(tree=3D[bar, baz, bam], parent=3D[C, D])
+
+And our changes would look like this:
+metas/changeA=3DA
+metas/changeB=3DCmeta
+metas/changeB2=3DDmeta
+metas/changeF=3DF
+
+In this case, changeB and changeB2 are still divergent and we=E2=80=99ve c=
reated a new
+change for our merge commit. However, this is just a temporary state. The =
next
+time we run the =E2=80=9Cevolve=E2=80=9D command, it will discover the div=
ergence but also
+discover the merge commit F that resolves it. Evolve will suggest converti=
ng F
+into an amend merge in order to resolve the divergence and will display th=
e
+command for doing so.
+
+Rebase
+------
+In general the rebase command is treated as a modify command. When a chang=
e is
+rebased, the new commit replaces the original.
+
+Rebase --abort is special. Its intent is to restore git to the state it ha=
d
+prior to running rebase. It should move back any changes to point to the r=
efs
+they had prior to running rebase and delete any new changes that were crea=
ted as
+part of the rebase. To achieve this, rebase will save the state of all cha=
nges
+in refs/metas prior to running rebase and will restore the entire namespac=
e
+after rebase completes (deleting any newly-created changes). Newly-created
+metacommits are left in place, but will have no effect until garbage colle=
cted
+since metacommits are only used if they are reachable from refs/metas.
+
+Change
+------
+The =E2=80=9Cchange=E2=80=9D command can be used to list, rename, reset or=
 delete change. It has
+a number of subcommands.
+
+The "list" subcommand lists local changes. If given the -r argument, it li=
sts
+remote changes.
+
+The "rename" subcommand renames a change, given its old and new name. If t=
he old
+name is omitted and there is exactly one change pointing to the current HE=
AD,
+that change is renamed. If there are no changes pointing to the current HE=
AD,
+one is created with the given name.
+
+The "forget" subcommand deletes a change by deleting its ref from the meta=
s/
+namespace. This is the normal way to delete extra aliases for a change if =
the
+change has more than one name. By default, this will refuse to delete the =
last
+alias for a change if there are any other changes that reference this chan=
ge as
+a parent.
+
+The "update" subcommand adds a new state to a change. It uses the default
+algorithm for assigning change names. If the content commit is omitted, HE=
AD is
+used. If given the optional --force argument, it will overwrite any existi=
ng
+change of the same name. This latter form of "update" can be used to effec=
tively
+reset changes.
+
+The "update" command can accept any number of --origin and --replace argum=
ents.
+If any are present, the resulting change branch will point to a metacommit
+containing the given origin and replacement edges.
+
+The "replace" command records a replacement in the obsolescence graph, giv=
en a
+list of obsolete commits or metacommits followed by their replacement. Thi=
s
+behaves like a normal "modify" command, except that the replacement is an
+existing commit. If an obsolete commit points to a metacommit, only a chan=
ge
+branch pointing to exactly that metacommit moves forward. If an obsolete c=
ommit
+points to a normal commit, all change branches pointing to that commit mov=
e
+forward. If no change branches moved forward, a new change branch is creat=
ed
+using the default name.
+
+The "abandon" command deletes a change using obsolescence markers. It mark=
s the
+change as being obsolete and having been replaced by its parent. If given =
no
+arguments, it applies to the current commit. Running evolve will cause any
+abandoned changes to be removed from the branch. Any child changes will be
+reparented on top of the parent of the abandoned change. If the current ch=
ange
+is abandoned, HEAD will move to point to its parent.
+
+The "restore" command restores a previously-abandoned change.
+
+The "prune" command deletes all obsolete changes and all changes that are
+present in the given branch. Note that such changes can be recovered from =
the
+reflog.
+
+Combined with the GC protection that is offered, this is intended to facil=
itate
+a workflow that relies on changes instead of branches. Users could choose =
to
+work with no local branches and use changes instead - both for mailing lis=
t and
+gerrit workflows.
+
+Log
+---
+When a commit is shown in git log that is part of a change, it is decorate=
d with
+extra change information. If it is the head of a change, the name of the c=
hange
+is shown next to the list of branches. If it is obsolete, it is decorated =
with
+the text =E2=80=9Cobsolete, <n> commits behind <changename>=E2=80=9D.
+
+Log gets a new --obslog argument indicating that the obsolescence graph sh=
ould
+be followed instead of the commit graph. This also changes the default
+formatting options to make them more appropriate for viewing different
+iterations of the same commit.
+
+Pull
+----
+
+Pull gets an --evolve argument that will automatically attempt to run "evo=
lve"
+on any affected branches after pulling.
+
+We also introduce an "evolve" enum value for the branch.<name>.rebase conf=
ig
+value. When set, the evolve behavior will happen automatically for that br=
anch
+after every pull even if the --evolve argument is not used.
+
+Next
+----
+
+The "next" command will reset HEAD to a non-obsolete commit that refers to=
 this
+change as its parent. If there is more than one such change, the user will=
 be
+prompted. If given the --evolve argument, the next commit will be evolved =
if
+necessary first.
+
+The "next" command can be thought of as the opposite of
+"git reset --hard HEAD^" in that it navigates to a child commit rather tha=
n a
+parent.
+
+Other options considered
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+We considered several other options for storing the obsolescence graph. Th=
is
+section describes the other options and why they were rejected.
+
+Commit header
+-------------
+Add an =E2=80=9Cobsoletes=E2=80=9D field to the commit header that points =
backwards from a
+commit to the previous commits it obsoletes.
+
+Pros:
+- Very simple
+- Easy to traverse from a commit to the previous commits it obsoletes.
+Cons:
+- Adds a cost to the storage format, even for commits where the change his=
tory
+  is uninteresting.
+- Unconditionally prevents the change history from being garbage collected=
.
+- Always causes the change history to be shared when pushing or pulling ch=
anges.
+
+Git notes
+---------
+Instead of storing obsolescence information in metacommits, the metacommit
+content could go in a new notes namespace - say refs/notes/metacommit. Eac=
h note
+would contain the list of obsolete and origin parents, and an automerger c=
ould
+be supplied to make it easy to merge the metacommit notes from different r=
emotes.
+
+Pros:
+- Easy to locate all commits obsoleted by a given commit (since there woul=
d only
+  be one metacommit for any given commit).
+Cons:
+- Wrong GC behavior (obsolete commits wouldn=E2=80=99t automatically be re=
tained by GC)
+  unless we introduced a special case for these kinds of notes.
+- No way to selectively share or pull the metacommits for one specific cha=
nge.
+  It would be all-or-nothing, which would be expensive. This could be addr=
essed
+  by changes to the protocol, but this would be invasive.
+- Requires custom auto-merging behavior on fetch.
+
+Tags
+----
+Put the content of the metacommit in a message attached to tag on the
+replacement commit. This is very similar to the git notes approach and has=
 the
+same pros and cons.
+
+Simple forward references
+-------------------------
+Record an edge from an obsolete commit to its replacement in this form:
+
+refs/obsoletes/<A>
+
+pointing to commit <B> as an indication that B is the replacement for the
+obsolete commit A.
+
+Pros:
+- Protects <B> from being garbage collected.
+- Fast lookup for the evolve operation, without additional search structur=
es
+  (=E2=80=9Cwhat is the replacement for <A>?=E2=80=9D is very fast).
+
+Cons:
+- Can=E2=80=99t represent divergence (which is a P0 requirement).
+- Creates lots of refs (which can be inefficient)
+- Doesn=E2=80=99t provide a way to fetch only refs for a specific change.
+- The obslog command requires a search of all refs.
+
+Complex forward references
+--------------------------
+Record an edge from an obsolete commit to its replacement in this form:
+
+refs/obsoletes/<change_id>/obs<A>_<B>
+
+Pointing to commit <B> as an indication that B is the replacement for obso=
lete
+commit A.
+
+Pros:
+- Permits sharing and fetching refs for only a specific change.
+- Supports divergence
+- Protects <B> from being garbage collected.
+
+Cons:
+- Creates lots of refs, which is inefficient.
+- Doesn=E2=80=99t provide a good lookup structure for lookups in either di=
rection.
+
+Backward references
+-------------------
+Record an edge from a replacement commit to the obsolete one in this form:
+
+refs/obsolescences/<B>
+
+Cons:
+- Doesn=E2=80=99t provide a way to resolve divergence (which is a P0 requi=
rement).
+- Doesn=E2=80=99t protect <B> from being garbage collected (which could be=
 fixed by
+  combining this with a refs/metas namespace, as in the metacommit variant=
).
+
+Obsolescences file
+------------------
+Create a custom file (or files) in .git recording obsolescences.
+
+Pros:
+- Can store exactly the information we want with exactly the performance w=
e want
+  for all operations. For example, there could be a disk-based hashtable
+  permitting constant time lookups in either direction.
+
+Cons:
+- Handling GC, pushing, and pulling would all require custom solutions. GC
+  issues could be addressed with a repository format extension.
+
+Squash points
+-------------
+We create and update change branches in refs/metas them at the same time w=
e
+would in the metacommit proposal. However, rather than pointing to a metac=
ommit
+branch they point to normal commits and are treated as =E2=80=9Csquash poi=
nts=E2=80=9D - markers
+for sequences of commits intended to be squashed together on submission.
+
+Amends and rebases work differently than they do now. Rather than actually
+containing the desired state of a commit, they contain a delta from the pr=
evious
+version along with a squash point indicating that the preceding changes ar=
e
+intended to be squashed on submission. Specifically, amends would become n=
ew
+changes and rebases would become merge commits with the old commit and new
+parent as parents.
+
+When the changes are finally submitted, the squashes are executed, produci=
ng the
+final version of the commit.
+
+In addition to the squash points, git would maintain a set of =E2=80=9Cnos=
quash=E2=80=9D tags
+for commits that were used as ancestors of a change that are not meant to =
be
+included in the squash.
+
+For example, if we have this commit graph:
+
+A(...)
+B(parent=3DA)
+C(parent=3DB)
+
+...and we amend B to produce D, we=E2=80=99d get:
+
+A(...)
+B(parent=3DA)
+C(parent=3DB)
+D(parent=3DB)
+
+...along with a new change branch indicating D should be squashed with its
+parents when submitted:
+
+metas/changeB =3D D
+metas/changeC =3D C
+
+We=E2=80=99d also create a nosquash tag for A indicating that A shouldn=E2=
=80=99t be included
+when changeB is squashed.
+
+If a user amends the change again, they=E2=80=99d get:
+
+A(...)
+B(parent=3DA)
+C(parent=3DB)
+D(parent=3DB)
+E(parent=3DD)
+
+metas/changeB =3D E
+metas/changeC =3D C
+
+Pros:
+- Good GC behavior.
+- Provides a natural way to share changes (they=E2=80=99re just normal bra=
nches).
+- Merge-base works automatically without special cases.
+- Rewriting the obslog would be easy using existing git commands.
+- No new data types needed.
+Cons:
+- No way to connect the squashed version of a change to the original, so n=
o way
+  to automatically clean up old changes. This also means users lose all be=
nefits
+  of the evolve command if they prematurely squash their commits. This may=
 occur
+  if a user thinks a change is ready for submission, squashes it, and then=
 later
+  discovers an additional change to make.
+- Histories would look very cluttered (users would see all previous edits =
to
+  their commit in the commit log, and all previous rebases would show up a=
s
+  merges). Could be quite hard for users to tell what is going on. (Possib=
le
+  fix: also implement a new smart log feature that displays the log as tho=
ugh
+  the squashes had occurred).
+- Need to change the current behavior of current commands (like amend and
+  rebase) in ways that will be unexpected to many users.
--=20
2.20.1.611.gfbb209baf1-goog

