Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C54BC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 02:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiBJCTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:19:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiBJCTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 21:19:10 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A47E22B33
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 18:19:12 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92710112949;
        Wed,  9 Feb 2022 21:19:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=2
        UKYtDYBFOiIHxNrF1molgnB4qt/WZ5vv6uUagmv8v8=; b=ECocDXHuwsbFfg0vT
        ZmzajfG6vFn87aaMT146pYp/BLaYTgiMqhha9SzfmptmKayPScXXcSmj60JAfdkH
        mjBgGICcNANoR1RnnQz9SrkWvFejLvU6IoOTMULfjE6C5CV9L2cnBjryOk+oaNhE
        sgUUKVAwyq6GprxGRc9uGTwkUg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F73B112948;
        Wed,  9 Feb 2022 21:19:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC4E7112947;
        Wed,  9 Feb 2022 21:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH] glossary: describe "worktree"
Date:   Wed, 09 Feb 2022 18:19:07 -0800
Message-ID: <xmqqczjvxy3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4B63CB2-8A17-11EC-80AC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have description on "per worktree ref", but "worktree" is not
described in the glossary.  We do have "working tree", though.

Casually put, a "working tree" is what your editor and compiler
interacts with.  "worktree" is a mechanism to allow one or more
"working tree"s to be attached to a repository and used to check out
different commits and branches independently, which includes not
just a "working tree" but also repository metadata like HEAD, the
index to support simultaneous use of them.  Historically, we used
these terms interchangeably but we have been trying to use "working
tree" when we mean it, instead of "worktree".

Most of the existing references to "working tree" in the glossary do
refer primarily to the working tree portion, except for one that
said refs like HEAD and refs/bisect/* are per "working tree", but it
is more precise to say they are per "worktree".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Mostly unchanged from the version in the original discussion
   https://lore.kernel.org/git/xmqqo83hatm1.fsf@gitster.g/ except
   that we now mention that pseudorefs are also per worktree.

   One thing that makes me worried somewhat is what I did not touch,
   namely, how pseudo refs are defined.  I know MERGE_HEAD is very
   special and it may be impossible to coax it into refs API for
   writing, so the text there makes sense for it, but there are
   other all-caps-and-directly-under-dot-git-directory files like
   ORIG_HEAD and CHERRY_PICK_HEAD that are written using the refs
   API, so the description would have to be updated there.

 Documentation/glossary-content.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index c077971335..9eb8920552 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -312,7 +312,7 @@ Pathspecs are used on the command line of "git ls-files", "git
 ls-tree", "git add", "git grep", "git diff", "git checkout",
 and many other commands to
 limit the scope of operations to some subset of the tree or
-worktree.  See the documentation of each command for whether
+working tree.  See the documentation of each command for whether
 paths are relative to the current directory or toplevel.  The
 pathspec syntax is as follows:
 +
@@ -446,7 +446,7 @@ exclude;;
 	interface than the <<def_plumbing,plumbing>>.
 
 [[def_per_worktree_ref]]per-worktree ref::
-	Refs that are per-<<def_working_tree,worktree>>, rather than
+	Refs that are per-<<def_worktree,worktree>>, rather than
 	global.  This is presently only <<def_HEAD,HEAD>> and any refs
 	that start with `refs/bisect/`, but might later include other
 	unusual refs.
@@ -669,3 +669,12 @@ The most notable example is `HEAD`.
 	The tree of actual checked out files.  The working tree normally
 	contains the contents of the <<def_HEAD,HEAD>> commit's tree,
 	plus any local changes that you have made but not yet committed.
+
+[[def_work_tree]]worktree::
+	A repository can have zero (i.e. bare repository) or one or
+	more worktrees attached to it. One "worktree" consists of a
+	"working tree" and repository metadata, most of which are
+	shared among other worktrees of a single repository, and
+	some of which are maintained separately per worktree
+	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
+	per-worktree refs and per-worktree configuration file).
-- 
2.35.1-102-g2b9c120970

