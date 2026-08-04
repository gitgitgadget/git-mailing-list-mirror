Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B639099A
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832258; cv=none; b=BuB8r4U0BmeSKqvXj0ZW8wHtDDLvYPNFQqjiFedu4MLE85h/3TKArVicUV0ueciXSAjJumn3YJ3WN9nLevRdICVM25qsV2FBU3e861kykvyarMeIbwis8/5EV76FvrkGIld06trMNNQciO5ST17qcLWsPdiHYSx42+JXcA7OPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832258; c=relaxed/simple;
	bh=XZ0OA+aCY0epvWkaQkV1Whc0SZByiEg7crAg10e+6dM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=odzwwu/7yR01+oT32ZDb+0/eeBBKaYQZxT0U+oTh3ttgp51miVacieDBbdmRm4fB7BfWUx9b3jWnvrEl6aNLghsfxYljLEnDR8Pc1nAGRNgWsyA8zia/v8ng56lA/YPEPmjTbqZE65YHQ+EPuYkFSeS26jhUQdxAchCH+vr6YKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQQSD2BN; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQQSD2BN"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66804667af2so3198245d50.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832254; x=1786437054; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CRm5ltvoL++d701qjKvmsxWdjLpr9vV+4m1Tv+d8Ceo=;
        b=bQQSD2BNnSaqCHl1rWi57kCcZ2UHqZVc9ovg1rsboaBUkWXcJ4EX2qlY8g3LsxqP6V
         +VPjOs82tB1SO6eSip8vJeoDKFCN2A1sAxjZTgtMVupOeJyazRnIAtdoneD/9sRkR89Q
         b2LALUJHoifiXpwyx2lv140Btae6qzTgHUt4kgkEj0BPq0Y/AnWfH8FR/ohYNS2bV4c2
         f+AU2jaqxaCTdwjYVKqVRMDeBu5IoAcBhWRiW9pFmUU9JpyuLlc9ShdcKRjLKfevDK/u
         CoKp1rSHZFTF2sy4862+t6efTllQw68Plt1KFn3fD+EDo18ipEgXitopR1Mbmqxyw1EM
         hfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832254; x=1786437054;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CRm5ltvoL++d701qjKvmsxWdjLpr9vV+4m1Tv+d8Ceo=;
        b=OVGLMsR4cCPq4N4e69+4XDiN9kr0LUhF/CxNT1SqVm/Fg6v2mACrlPrHz2zoo1sNt4
         jbWqxMOc1GqK2y7Tf739mqskDGUcZEzK4bJxTieGAP0TPRZxJHoT4QI9m91PtUmedOvv
         SmRGpTB44E8N7gBo6TjWcZAAkX/v5VzUtrVx6BFWBq3TV14W5UcgdhFzagk7us4xTapd
         WHuAw6XT9F08ct7nCYgInJxUnngillCgbVnnf7TNWmYCoaMoKBIeJpzursqhJn/Jlbtm
         0DBKQsyO9j+jMEHn7wLG45yqcNe1pZp58hRD9Cs2yh1H2LDyB/HJIFqXjeMAENJyl9gQ
         Yjyg==
X-Gm-Message-State: AOJu0YwmaLxQjtQ76akrVK9J4IVBI2nFIvQZPmaUjiOJ45FWOzuNYlt+
	lGp88puUL+MXw+SBXAi8NmkSe2NCiJmvVPgIVy63K16YeNEN//BG1Z4mqUupcQ==
X-Gm-Gg: AR+sD12u2pjO8KrGkctm/YAzUNF87s9lMKKelYi68BJyW82dpfYWIeTD3imnrR8ZBNv
	j3ecych4hepYUhKchwOEAZc3RYbKg8St1tcw3RGaMjFBDxXoRHO7ykqclP1gT4eFgBw8J4la3tO
	PtfiG5QqDpGHkWJ9JT1rT6l38odILFMCwze6d4geTN5jW1cyLnmvpviozkn0pT0R4BoJYS5gdeZ
	jfib6zEir5RcmPqt7IdTbooOmrPtEewrYRINHDhCj9hlgZKQWiyhbh7rSAd3QP/jOQhqss+LC4R
	OdORIuZ9jUREcCudMZCpxKuyUebG1129/I6mLcnG48aPjCRjgMao+p+b+IBcKhXVZetnx4whKp3
	lpz+OXLyzxIcokN0ORyWvJBEGHtHPUP/xkkvbX4BtgkDjHwQp2+Zv/XDeIrmI3k9QK3Dl5T+JJh
	XA7s2EI27WOBV3USaK1GgqYQ2tNlYI/dger6dV8W0UI2aLyU2YtaGmGD8R8ZcsouA=
X-Received: by 2002:a05:690c:9c05:b0:81e:be69:821f with SMTP id 00721157ae682-81fd4bec06fmr147888317b3.32.1785832253005;
        Tue, 04 Aug 2026 01:30:53 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.40])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820134cadb4sm1407897b3.44.2026.08.04.01.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:30:52 -0700 (PDT)
Message-Id: <pull.2337.v12.git.git.1785832251.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
References: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 04 Aug 2026 08:30:47 +0000
Subject: [PATCH v12 0/4] history: add squash subcommand to fold a range
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>

Adds git history squash <revision-range> to fold a range of commits.

Changes in v12:

 * Incorporated fixups from Phillip:
   * Reworks range validation into a single walk that rejects roots and
     multiple tips while preserving every parent when squashing into a
     merge.
   * Resolves fixup!, squash! and amend! targets directly, preserving
     message intent and safely consolidating related markers.
   * Builds the editor template from the exact selected revisions, including
     exclusions, while retaining --no-edit behavior.
   * Protects descendant local branches while leaving tags and
     remote-tracking refs unchanged.

Changes in v11:

 * Make message editing the default with the autosquash-style template, add
   --no-edit instead of squash-specific --reedit-message.
 * Validate one actual boundary and tip, rejecting root-reaching and
   multi-tip ranges.
 * Protect only interior local branches, leaving tags and remote-tracking
   refs unchanged.
 * Move sequencer preparation before squash and fold the later
   message-editing patch into the feature commit.

Changes in v10:

 * Record the full revision expression in squash reflog.
 * Preserve the boundary-walk invariant when sanitizing rev-list options.
 * Clarify amend! and --reedit-message documentation.

Changes in v9:

 * Use the last amend! targeting the oldest folded commit as the default
   squashed message. Ignore amend! markers targeting later commits while
   selecting that replacement message.
 * Improve tests.

Changes in v8:

 * --reedit-message now builds the same editor template as git rebase -i
   --autosquash: fixup!, squash! and amend! commits are grouped under the
   commit they target instead of shown in commit order, and an amend!
   replaces its target's message.
 * A fixup!, squash! or amend! is refused only when its target is outside
   the range, so several fixups for an in-range commit fold together. A
   range that is entirely markers for one below-range target is combined
   into a single commit, keeping the last amend! message.
 * Merges inside the range are folded when the range has a single base, with
   no dedicated opt-in flag, --ancestry-path ensures only commits descended
   from the base are folded, and a range reaching more than one base is
   rejected.
 * Rev-list options are accepted and sanitized the way git replay does,
   forcing the walk order back with a warning, which also fixes git history
   squash -- --reverse slipping past the previous option check.
 * Kept this as an explicit squash subcommand rather than making
   --reedit-message the default or renaming the command.

Changes in v7:

 * --reedit-message now builds the same editor template git rebase -i shows
   for a squash (a combination of N commits banner with each folded message
   under its own header) and follows autosquash for markers: a fixup!
   message falls out (commented under a will be skipped header), while a
   squash! or amend! keeps its body with only the marker subject commented
   so its remark can be reworded in. Only the message text is affected,
   every commit's changes are always folded in.
 * Reuse git rebase -i's squash-message code: a preparatory sequencer:
   commit extracts the banner, header and marker-comment helpers so both
   rebase and git history squash build the identical template from one
   source.
 * Refuse a range whose oldest commit is a fixup!, squash! or amend!, since
   the marker's target cannot be inside the range.
 * Reorder the squash usage so dashed options come before <revision-range>,
   and spell out HEAD instead of @ in the documentation and examples.
 * Expand the squash commit message and documentation with this overview,
   and scope the merge limitation so it no longer contradicts squash folding
   a single-base interior merge.

Changes in v6:

 * git history squash now accepts multiple revision arguments, read like the
   arguments to git-rev-list, so a compound range such as @~3.. ^topic
   works.
 * The base to reparent onto is now the oldest in-range commit's parent; a
   boundary other than that base means the range has more than one base and
   is rejected. This also fixes the earlier overly-restrictive handling of
   merges and side branches.
 * A single-commit range (e.g. @^!) is rejected with "nothing to squash"
   (this also covers the @^!-style example that previously succeeded
   silently).
 * Commit messages reworded: the squash commit now gives an overview of
   fixup!/squash!/amend! handling, rewording, merge-parent and ref behavior.

Changes in v5:

 * The range walk now uses --ancestry-path, so only commits descended from
   the base are folded; a single revision such as HEAD or HEAD~1 is now
   rejected as "not a <base>..<tip> range" rather than treated as a squash
   down to the root.
 * This adopts the --ancestry-path suggestion; the multi-base rejection is
   unchanged, so a side branch that forked before the base and merged in is
   still refused.
 * Added tests covering more merge topologies: two interior merges, a nested
   merge, an octopus merge, an octopus arm forked before the base, a merge
   among the descendants replayed above the range, and a ref pointing at an
   interior merge commit.

Changes in v4:

 * git history squash now detects when another ref points at a commit inside
   the range being folded and refuses, with an advice.historyUpdateRefs hint
   to use --update-refs=head.
 * A merge inside the range is folded fine as long as the range has a single
   base; a range with merge commit at the tip or base also folds correctly.
   Only a range with more than one base is rejected.

Changes in v3:

 * Moved the feature out of git rebase and into a new git history squash
   <revision-range> subcommand, per the list discussion. git rebase --squash
   is dropped.
 * Takes an arbitrary range (git history squash @~3.., git history squash
   @~5..@~2), folding it into the oldest commit and replaying any
   descendants on top.
 * Implemented as a single tree operation rather than picking each commit,
   so there are no repeated conflict stops (addresses Phillip's efficiency
   point).
 * A merge inside the range is folded fine, only a range with more than one
   base is rejected.
 * --reedit-message seeds the editor with every folded-in message, not just
   the oldest.

Harald Nordgren (4):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  sequencer: share the squash message marker helpers and flags
  history: add squash subcommand to fold a range

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  59 ++-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 685 ++++++++++++++++++++++--
 object.h                         |   1 +
 sequencer.c                      |  70 +--
 sequencer.h                      |  30 ++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 884 +++++++++++++++++++++++++++++++
 10 files changed, 1665 insertions(+), 71 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v12
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v11:

 1:  dd1deb5e5b = 1:  20e050a0ad history: extract helper for a commit's parent tree
 2:  7309f64485 = 2:  b99867a0d4 history: give commit_tree_ext a message template
 3:  0762589e22 = 3:  352db997e9 sequencer: share the squash message marker helpers and flags
 4:  7abda3643c ! 4:  33d3eca6db history: add squash subcommand to fold a range
     @@ Commit message
          a "git reset --soft" to the merge base followed by "git commit --amend".
      
          Add "git history squash <revision-range>" to do this directly. It folds
     -    every commit in the range into one commit, preserving the authorship of
     +    every selected commit into one, preserving the authorship and parents of
          the oldest commit and taking the tree of the tip, then replays commits
     -    above the range. The editor opens with every folded message in the same
     -    template used by "git rebase -i --autosquash". With --no-edit, the
     -    oldest message is kept, or the last amend! replacement that targets it.
     +    above the range. By default an editor opens with every folded message in
     +    the same template used by "git rebase -i --autosquash". With --no-edit,
     +    the selected message is used without opening an editor.
      
     -    A fixup!, squash! or amend! commit is refused unless its target is also
     -    in the range, so the fold does not silently absorb a marker intended for
     -    another commit. As an exception, a range made up entirely of markers for
     -    one target is combined, allowing a batch of related fixups to be
     -    consolidated.
     +    Resolve fixup!, squash! and amend! subjects directly while walking the
     +    selected commits. A marker is rejected unless its fixed target is also
     +    selected, except that a range made up entirely of related markers can be
     +    consolidated. Without editing, refuse any squash! or amend! whose message
     +    would be discarded.
      
     -    The range is read like the arguments to "git rev-list", so several
     -    revisions such as "HEAD~3..HEAD ^topic" may be given, and rev-list
     -    options are accepted too. Walk-order options needed by the fold are
     -    restored after setup_revisions(), with a warning when an option changed
     -    them. The selected graph must have one actual boundary and one actual
     -    tip and must not reach a root. A merge inside the range is folded when
     -    all selected history reaches the same boundary; otherwise the range has
     -    more than one base and is rejected.
     +    Read the range like arguments to "git rev-list" and accept multiple
     +    revisions and rev-list options. Restore the walk settings required by the
     +    fold after setup_revisions(), warning when an option changed them. The
     +    range must name a bottom commit, must not reach a root, and must have one
     +    tip. Every parent after the oldest commit must be selected or also be a
     +    parent of the oldest commit. This permits internal merges and preserves
     +    all parents when the oldest commit is itself a merge.
      
     -    By default the command refuses when a local branch points inside the
     -    range, because that branch cannot be replayed as a descendant of the
     -    result. Tags and remote-tracking refs are left unchanged. Use
     -    --update-refs=head to leave interior branches unchanged as well.
     +    By default, refuse when a local branch descends from the selected commits
     +    but cannot remain a descendant of the result. Tags and remote-tracking
     +    refs are left unchanged. Use --update-refs=head to leave such local
     +    branches unchanged as well.
      
          Inspired-by: Sergey Chernov <serega.morph@gmail.com>
     +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/config/advice.adoc ##
     @@ Documentation/git-history.adoc: at once.
      +This command does not (yet) replay merge commits onto the rewritten
      +history: if a commit that would be replayed is a merge, the operation is
      +rejected, and you should use linkgit:git-rebase[1] with the
     -+`--rebase-merges` flag instead. The `squash` subcommand can still fold a
     -+merge that lies inside the range, as long as the range has a single base.
     ++`--rebase-merges` flag instead. The `squash` subcommand can still fold merges
     ++that lie inside the selected range, subject to the restrictions below.
       
       Furthermore, the command does not support operations that can result in merge
       conflicts. This limitation is by design as history rewrites are not intended to
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +already on `topic`. Rev-list options may also be given, but any that would
      +change how the range is walked are overridden with a warning.
      ++
     -+An editor opens pre-filled with the messages of all the folded commits so
     -+you can combine them. With `--no-edit`, the oldest commit's message is
     -+preserved instead, except that an `amend!` commit targeting it replaces its
     -+message. A merge commit inside the range is folded like any other, but the
     -+range must have a single base and a single tip. A range that reaches more
     -+than one entry point (for example a side branch that forked before the range
     -+and was later merged into it), or that selects two unmerged tips, is rejected.
     ++An editor opens pre-filled with the messages of all the folded commits so you
     ++can combine them. With `--no-edit`, the oldest commit's message is preserved
     ++instead, except that an `amend!` commit targeting it replaces its message.
     +++
     ++The selected commits must form a connected graph with a single tip and must
     ++not include a root commit. Every parent of a commit after the oldest one must
     ++either be selected or also be a parent of the oldest commit. When the oldest
     ++commit is a merge, all of its parents are preserved in the squashed commit.
      ++
      +A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
      +targets is also in the range, so the fold does not silently absorb a
      +marker meant for a commit outside it. As an exception, a range made up entirely
      +of markers for one target is combined into a single commit. With `--no-edit`,
     -+the last `amend!` message is used if there is one.
     ++the last `amend!` message is used if there is one; a `squash!` or `amend!` is
     ++otherwise refused if folding it would discard its message.
      ++
     -+The template mirrors `git rebase -i --autosquash`: each `fixup!`, `squash!`,
     -+or `amend!` is grouped under the commit it targets rather than shown in
     -+commit order. A `fixup!` message is dropped (commented out in full), a
     -+`squash!` keeps its body with only the marker subject commented, and an
     ++The editor template mirrors `git rebase -i --autosquash`: each `fixup!`,
     ++`squash!`, or `amend!` is grouped under the commit it targets rather than
     ++shown in commit order. A `fixup!` message is dropped (commented out in full),
     ++a `squash!` keeps its body with only the marker subject commented, and an
      +`amend!` replaces its target's message, unless a `squash!` folded into that
      +target first, in which case it keeps its body like a `squash!`.
      ++
     -+A local branch that points at a commit inside the range cannot be rewritten
     -+as a descendant of the result, so with the default `--update-refs=branches`
     -+the command refuses. Rerun with `--update-refs=head` to rewrite only the
     -+current branch and leave such branches pointing at the old commits. Tags and
     -+remote-tracking refs are always left unchanged.
     ++A local branch descended from a selected commit but not from the range tip
     ++cannot be rewritten as a descendant of the result, so with the default
     ++`--update-refs=branches` the command refuses. Rerun with `--update-refs=head`
     ++to rewrite only the current branch and leave such branches unchanged. Tags
     ++and remote-tracking refs are always left unchanged.
      +
       OPTIONS
       -------
     @@ Documentation/git-history.adoc: OPTIONS
      +`--edit`::
      +`--no-edit`::
      +	For `squash`, open an editor to combine the messages of the folded commits.
     -+	This is the default; use `--no-edit` to keep the selected message
     -+	without opening an editor.
     ++	This is the default; use `--no-edit` to keep the selected message without
     ++	opening an editor.
      +
       `--reedit-message`::
       	Open an editor to modify the target commit's message.
     @@ builtin/history.c
       #include "cache-tree.h"
       #include "commit.h"
       #include "commit-reach.h"
     +@@
     + #include "path.h"
     + #include "read-cache.h"
     + #include "refs.h"
     ++#include "ref-filter.h"
     + #include "replay.h"
     + #include "reset.h"
     + #include "revision.h"
      @@
       	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
       #define GIT_HISTORY_SPLIT_USAGE \
     @@ builtin/history.c: out:
       	return ret;
       }
       
     ++/*Remember to update object flag allocation in object.h */
     ++#define SQUASH_SEEN (1u << 11)
     ++#define SQUASH_TIP (1u << 12)
     ++#define SQUASH_AMEND_TARGET (1u << 13)
     ++
     ++static bool is_autosquash_subject(const char *s)
     ++{
     ++	return starts_with(s, "amend!") || starts_with(s, "fixup!") ||
     ++		starts_with(s, "squash!");
     ++}
     ++
     ++static bool skip_one_autosquash_prefix(const char *s, const char **out)
     ++{
     ++	if (skip_prefix(s, "amend!", out) || skip_prefix(s, "fixup!", out) ||
     ++	    skip_prefix(s, "squash!", out)) {
     ++		while (**out == ' ')
     ++			(*out)++;
     ++		return true;
     ++	}
     ++	return false;
     ++}
     ++
     ++static void truncate_message_to_subject(struct strbuf *msg)
     ++{
     ++	const char *eos = strstr(msg->buf, "\n\n");
     ++
     ++	if (eos)
     ++		strbuf_setlen(msg, eos - msg->buf + 1);
     ++}
     ++
     ++struct subject_data {
     ++	struct strintmap subjects;
     ++	struct strbuf subject;
     ++	struct strbuf squash_message;
     ++	const char *message;
     ++	bool edit_message;
     ++};
     ++
     ++#define SUBJECT_DATA_INIT {		\
     ++	.subjects = STRINTMAP_INIT,	\
     ++	.subject = STRBUF_INIT,		\
     ++	.squash_message = STRBUF_INIT,	\
     ++}
     ++
     ++static void subject_data_clear(struct subject_data *data)
     ++{
     ++	strintmap_clear(&data->subjects);
     ++	strbuf_release(&data->subject);
     ++	strbuf_release(&data->squash_message);
     ++}
     ++
     ++static int squash_amend_message(struct repository *repo,
     ++				struct commit *commit,
     ++				struct subject_data *data,
     ++				unsigned flags)
     ++{
     ++	const char *body = data->message + data->subject.len;
     ++
     ++	while (isspace(*body))
     ++		body++;
     ++
     ++	if (!*body) {
     ++		warning(_("ignoring %s (%s): message body is empty"),
     ++			repo_find_unique_abbrev(repo, &commit->object.oid,
     ++						DEFAULT_ABBREV),
     ++			data->subject.buf);
     ++		return 0;
     ++	}
     ++
     ++	if (data->edit_message) {
     ++		return 0;
     ++	} else if (flags & SQUASH_AMEND_TARGET) {
     ++		if (starts_with(data->squash_message.buf, "squash!"))
     ++			return error(_("squashing %s (%s) would overwrite "
     ++				       "'squash!' message, please combine them "
     ++				       "using '--edit'"),
     ++				     repo_find_unique_abbrev(repo,
     ++							     &commit->object.oid,
     ++							     DEFAULT_ABBREV),
     ++				     data->subject.buf);
     ++		if (starts_with(data->squash_message.buf, "fixup!"))
     ++			strbuf_splice(&data->squash_message, 0, 5, "amend!", 5);
     ++		if (starts_with(data->squash_message.buf, "amend!")) {
     ++			truncate_message_to_subject(&data->squash_message);
     ++			strbuf_addch(&data->squash_message, '\n');
     ++		} else {
     ++			strbuf_reset(&data->squash_message);
     ++		}
     ++		strbuf_addstr(&data->squash_message, body);
     ++		strbuf_complete_line(&data->squash_message);
     ++	} else {
     ++		return error(_("cannot squash %s (%s) that does not target "
     ++			       "base commit without '--edit'"),
     ++			     repo_find_unique_abbrev(repo, &commit->object.oid,
     ++						     DEFAULT_ABBREV),
     ++			     data->subject.buf);
     ++	}
     ++	return 0;
     ++}
     ++
     ++static int squash_squash_message(struct repository *repo,
     ++				struct commit *commit,
     ++				struct subject_data *data,
     ++				unsigned flags)
     ++{
     ++	const char *body = data->message + data->subject.len;
     ++
     ++	while (isspace(*body))
     ++		body++;
     ++
     ++	if (data->edit_message) {
     ++		return 0;
     ++	} else if (flags & SQUASH_AMEND_TARGET) {
     ++		if (starts_with(data->squash_message.buf, "fixup!")) {
     ++			truncate_message_to_subject(&data->squash_message);
     ++			strbuf_splice(&data->squash_message, 0, 5, "squash", 6);
     ++		}
     ++		if (starts_with(data->squash_message.buf, "squash!")) {
     ++			strbuf_addch(&data->squash_message, '\n');
     ++			strbuf_addstr(&data->squash_message, body);
     ++			strbuf_complete_line(&data->squash_message);
     ++		} else {
     ++			return error(_("squashing %s (%s) would discard its "
     ++				       "message, please combine them using "
     ++				       "'--edit'"),
     ++				     repo_find_unique_abbrev(repo,
     ++							     &commit->object.oid,
     ++							     DEFAULT_ABBREV),
     ++				     data->subject.buf);
     ++		}
     ++	} else {
     ++		return error(_("cannot squash %s (%s) that does not target "
     ++			       "base commit without '--edit'"),
     ++			      repo_find_unique_abbrev(repo, &commit->object.oid,
     ++						      DEFAULT_ABBREV),
     ++			      data->subject.buf);
     ++	}
     ++	return 0;
     ++}
     ++
     ++static int squash_check_can_autosquash(struct repository *repo,
     ++				       struct commit *commit,
     ++				       struct subject_data *data,
     ++				       unsigned flags)
     ++{
     ++	commit->object.flags |= flags & SQUASH_AMEND_TARGET;
     ++	if (starts_with(data->subject.buf, "amend!"))
     ++		return squash_amend_message(repo, commit, data, flags);
     ++	else if (starts_with(data->subject.buf, "squash!"))
     ++		return squash_squash_message(repo, commit, data, flags);
     ++
     ++	return 0;
     ++}
     ++
     ++static int squash_check_autosquash_subject(struct repository *repo,
     ++					   struct commit *commit,
     ++					   struct subject_data *data)
     ++{
     ++	const char* s = data->subject.buf;
     ++	struct commit *target;
     ++	struct hashmap_iter iter;
     ++	struct strmap_entry *entry;
     ++	/* Try skipping autosquash prefixes one at a time to allow
     ++	 * squashing
     ++	 *     a commit
     ++	 *     fixup! fixup! a commit
     ++	 *
     ++	 * where we may have started with
     ++	 *     a commit
     ++	 *     fixup! a commit
     ++	 *     fixup! fixup! a commit
     ++	 *
     ++	 * and squashed the first fixup separately from the second
     ++	 */
     ++	while (skip_one_autosquash_prefix(s, &s)) {
     ++		unsigned flags = strintmap_get(&data->subjects, s);
     ++		if (flags)
     ++			return squash_check_can_autosquash(repo, commit, data, flags);
     ++	}
     ++	/*
     ++	 * Allow "fixup! <hex object id>", but not "fixup! HEAD^" or
     ++	 * "fixup! main". If the target is not being squshed check the subject
     ++	 * to allow "fixup! abc123" and "fixup! <subject of abc123>" to be
     ++	 * squashed together.
     ++	 */
     ++	target = lookup_commit_reference_by_name(s);
     ++	if (target && istarts_with(oid_to_hex(&target->object.oid), s)) {
     ++		unsigned flags =
     ++			target->object.flags & (SQUASH_SEEN | SQUASH_AMEND_TARGET);
     ++		if (!flags) {
     ++			const char *subject_start;
     ++			const char *buffer = repo_logmsg_reencode(repo, target,
     ++								  NULL, NULL);
     ++			size_t subject_len = find_commit_subject(buffer,
     ++								 &subject_start);
     ++			char *subject = xmemdupz(subject_start, subject_len);
     ++
     ++			flags = strintmap_get(&data->subjects, subject);
     ++			free(subject);
     ++			repo_unuse_commit_buffer(repo, target, buffer);
     ++		}
     ++		if (flags)
     ++			return squash_check_can_autosquash(repo, commit,
     ++							   data, flags);
     ++	}
     ++	/* Try subject prefix matches */
     ++	strintmap_for_each_entry(&data->subjects, &iter, entry) {
     ++		s = data->subject.buf;
     ++		while(skip_one_autosquash_prefix(s, &s)) {
     ++			if (starts_with(entry->key, s)) {
     ++				unsigned value = (intptr_t)entry->value;
     ++
     ++				return squash_check_can_autosquash(repo, commit,
     ++								   data, value);
     ++			}
     ++		}
     ++	}
     ++	return error(_("cannot squash %s (%s): its target is not being "
     ++		       "squashed"),
     ++		       repo_find_unique_abbrev(repo, &commit->object.oid,
     ++					       DEFAULT_ABBREV),
     ++		       data->subject.buf);
     ++}
     ++
     ++static int squash_check_subject(struct repository *repo,
     ++				struct commit *commit,
     ++				struct subject_data *data)
     ++{
     ++	int ret = 0;
     ++	const char *buf = repo_logmsg_reencode(repo, commit, NULL, NULL);
     ++	size_t subject_len = find_commit_subject(buf, &data->message);
     ++
     ++	strbuf_reset(&data->subject);
     ++	strbuf_add(&data->subject, data->message, subject_len);
     ++
     ++	if (!strintmap_get_size(&data->subjects)) {
     ++		const char *s;
     ++
     ++		strbuf_addstr(&data->squash_message, data->message);
     ++		strbuf_complete_line(&data->squash_message);
     ++		/*
     ++		 * Strip a single autosquash prefix to allow squashing
     ++		 *     fixup! base
     ++		 *     amend! base
     ++		 */
     ++		s = data->subject.buf;
     ++		skip_one_autosquash_prefix(s, &s);
     ++		strintmap_set(&data->subjects, s, SQUASH_AMEND_TARGET | SQUASH_SEEN);
     ++		commit->object.flags |= SQUASH_AMEND_TARGET;
     ++	} else if (is_autosquash_subject(data->subject.buf)) {
     ++		ret = squash_check_autosquash_subject(repo, commit, data);
     ++	} else {
     ++		strintmap_set(&data->subjects, data->subject.buf, SQUASH_SEEN);
     ++	}
     ++	repo_unuse_commit_buffer(repo, commit, buf);
     ++	return ret;
     ++}
     ++
     ++static int build_squash_message(struct repository *repo,
     ++				const struct strbuf *todo_buf,
     ++				struct strbuf *out);
     ++
      +/*
      + * Resolve a "<base>..<tip>" revision range into the base commit just outside
      + * the range (which becomes the parent of the squashed commit), the oldest
     @@ builtin/history.c: out:
      + * but the range must have a single base and must not reach a root commit.
      + */
      +static int resolve_squash_range(struct repository *repo,
     -+				const char **argv,
     -+				struct commit **base_out,
     ++				bool update_branches,
     ++				bool edit_message,
     ++				int argc, const char **argv,
      +				struct commit **oldest_out,
      +				struct commit **tip_out,
     -+				struct oidset *interior_out)
     ++				char **message_out)
      +{
      +	struct rev_info revs;
     -+	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
     -+	struct commit_list *boundaries = NULL, *commits = NULL, *iter,
     -+		**commits_tail = &commits;
     -+	struct oidset selected = OIDSET_INIT, has_children = OIDSET_INIT;
     -+	struct strvec args = STRVEC_INIT;
     -+	bool reaches_root = false;
     ++	struct subject_data subject_data = SUBJECT_DATA_INIT;
     ++	struct commit *commit, *oldest = NULL, *tip = NULL;
     ++	struct strbuf todo_buf = STRBUF_INIT;
      +	size_t i;
     -+	int ret;
     ++	int ret, tip_count = 0;
     ++	struct ref_filter filter = REF_FILTER_INIT;
     ++	struct ref_array refs = { 0 };
      +
      +	repo_init_revisions(repo, &revs, NULL);
     ++	subject_data.edit_message = edit_message;
      +	revs.reverse = 1;
      +	revs.topo_order = 1;
      +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
      +	revs.simplify_history = 0;
     -+	revs.boundary = 1;
     -+
     -+	strvec_push(&args, "ignored");
     -+	strvec_push(&args, "--ancestry-path");
     -+	strvec_pushv(&args, argv);
     -+	setup_revisions_from_strvec(&args, &revs, NULL);
     -+	if (args.nr != 1) {
     -+		ret = error(_("unrecognized argument: %s"), args.v[1]);
     ++	revs.ancestry_path = 1;
     ++	revs.limited = 1;
     ++	revs.ancestry_path_implicit_bottoms = 1;
     ++
     ++	argc = setup_revisions(argc, argv, &revs, NULL);
     ++	if (argc > 1) {
     ++		ret = error(_("unrecognized argument: %s"), argv[1]);
      +		goto out;
      +	}
      +
      +	if (revs.reverse != 1 || revs.topo_order != 1 ||
      +	    revs.sort_order != REV_SORT_IN_GRAPH_ORDER ||
     -+	    revs.simplify_history != 0 || revs.boundary != 1) {
     ++	    revs.simplify_history != 0 || revs.boundary == 1 ||
     ++	    revs.ancestry_path != 1 || revs.limited != 1 ||
     ++	    revs.ancestry_path_implicit_bottoms != 1) {
      +		warning(_("ignoring rev-list options that would change how the "
      +			  "range is walked"));
      +		revs.reverse = 1;
      +		revs.topo_order = 1;
      +		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
      +		revs.simplify_history = 0;
     -+		revs.boundary = 1;
     ++		revs.boundary = 0;
     ++		revs.ancestry_path = 1;
     ++		revs.limited = 1;
     ++		revs.ancestry_path_implicit_bottoms = 1;
      +	}
      +
     -+	/* A squash range must name a bottom revision to reparent onto. */
     ++	/*
     ++	 * A squash needs a base to reparent onto, so the range has to exclude
     ++	 * something, as in "<base>..<tip>". A revision range with no such
     ++	 * bottom commit cannot be squashed.
     ++	 */
      +	for (i = 0; i < revs.cmdline.nr; i++)
      +		if (revs.cmdline.rev[i].flags & BOTTOM)
      +			break;
     @@ builtin/history.c: out:
      +		ret = error(_("error preparing revisions"));
      +		goto out;
      +	}
     -+
     -+	/* Set boundary commits aside for the base check below. */
      +	while ((commit = get_revision(&revs))) {
     -+		if (commit->object.flags & BOUNDARY) {
     -+			commit_list_insert(commit, &boundaries);
     -+			continue;
     ++		struct commit_list *p;
     ++
     ++		if (edit_message)
     ++			strbuf_addf(&todo_buf, "pick %s\n",
     ++				    oid_to_hex(&commit->object.oid));
     ++
     ++		if (!commit->parents) {
     ++			ret = error(_("cannot squash down to root commit"));
     ++			goto out;
     ++		}
     ++		for (p = commit->parents; oldest && p; p = p->next) {
     ++			struct commit_list *q;
     ++			struct object *o;
     ++			bool seen;
     ++
     ++			if (repo_parse_commit(repo, p->item)) {
     ++				ret = error(_("cannot parse commit"));
     ++				goto out;
     ++			}
     ++			o = &p->item->object;
     ++			seen = o->flags & SQUASH_SEEN;
     ++			/*
     ++			 * Allow parents that match the parents of the
     ++			 * squashed commit.
     ++			 */
     ++			for (q = oldest->parents; !seen && q; q = q->next) {
     ++				if (p->item == q->item) {
     ++					seen = true;
     ++					commit_list_insert(commit, &filter.with_commit);
     ++				}
     ++			}
     ++			if (!seen) {
     ++				ret = error(_("parent %s of commit %s is "
     ++					      "outside the revision range"),
     ++					    repo_find_unique_abbrev(repo, &o->oid,
     ++								    DEFAULT_ABBREV),
     ++					    repo_find_unique_abbrev(repo, &commit->object.oid,
     ++								    DEFAULT_ABBREV));
     ++				goto out;
     ++			}
     ++			if (o->flags & SQUASH_TIP) {
     ++				tip_count--;
     ++				o->flags &= ~SQUASH_TIP;
     ++			}
      +		}
     -+		if (!oldest)
     ++		if (!oldest) {
     ++			commit_list_insert(commit, &filter.with_commit);
      +			oldest = commit;
     -+		oidset_insert(&selected, &commit->object.oid);
     -+		commits_tail = commit_list_append(commit, commits_tail);
     ++		}
     ++		if (squash_check_subject(repo, commit, &subject_data)) {
     ++			ret = -1;
     ++			goto out;
     ++		}
     ++		tip = commit;
     ++		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
     ++		tip_count++;
      +	}
     -+
     -+	if (!oldest) {
     ++	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP | SQUASH_AMEND_TARGET);
     ++	reset_revision_walk();
     ++	if (!tip_count) {
      +		ret = error(_("the revision range is empty"));
      +		goto out;
     -+	} else if (!commits->next) {
     ++	} else if (tip_count != 1) {
     ++		  ret = error(_("the revision range contains more than one tip "
     ++				"commit"));
     ++		  goto out;
     ++	  } else if (oldest == tip) {
      +		ret = error(_("the revision range holds a single commit; "
      +			      "nothing to squash"));
      +		goto out;
     ++	} else if (!oldest->parents) {
     ++		BUG("an in-range commit must have a parent");
      +	}
     -+
     -+	/*
     -+	 * Find the selected commits that have selected children. The only
     -+	 * remaining commit must be the tip whose tree becomes the result.
     -+	 */
     -+	for (iter = commits; iter; iter = iter->next) {
     -+		struct commit_list *p;
     -+
     -+		if (!iter->item->parents)
     -+			reaches_root = true;
     -+		for (p = iter->item->parents; p; p = p->next)
     -+			if (oidset_contains(&selected, &p->item->object.oid))
     -+				oidset_insert(&has_children,
     -+					      &p->item->object.oid);
     -+	}
     -+	if (reaches_root) {
     -+		ret = error(_("the revision range reaches a root commit; "
     -+			      "cannot squash"));
     ++	commit_list_insert(tip, &filter.no_commit);
     ++	filter.kind = FILTER_REFS_BRANCHES;
     ++	if (update_branches &&
     ++	    filter_refs(&refs, &filter, filter.kind)) {
     ++		ret = error(_("could not filter refs"));
      +		goto out;
      +	}
     -+	for (iter = commits; iter; iter = iter->next) {
     -+		if (oidset_contains(&has_children, &iter->item->object.oid))
     -+			continue;
     -+		if (tip) {
     -+			ret = error(_("the revision range has more than one tip; "
     -+				      "cannot squash"));
     -+			goto out;
     -+		}
     -+		tip = iter->item;
     -+	}
     -+
     -+	/* The range must reach exactly one commit outside it. */
     -+	if (!boundaries) {
     -+		ret = error(_("the revision range has no base; cannot squash"));
     ++	if (refs.nr) {
     ++		/*
     ++		 * TODO: list the branches and also check HEADS from other worktrees
     ++		 */
     ++		ret = error(_("a branch points to a commit that is being squashed"));
     ++		advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
     ++				  _("Use --update-refs=head to rewrite only "
     ++				    "the current branch and leave such refs "
     ++				    "untouched."));
      +		goto out;
      +	}
     -+	base = boundaries->item;
     -+	for (iter = boundaries; iter; iter = iter->next) {
     -+		if (iter->item != base) {
     -+			ret = error(_("the revision range has more than one base; "
     -+				      "cannot squash"));
     ++	if (edit_message) {
     ++		strbuf_reset(&subject_data.squash_message);
     ++		ret = build_squash_message(repo, &todo_buf,
     ++					   &subject_data.squash_message);
     ++		if (ret < 0)
      +			goto out;
     -+		}
      +	}
     -+
     -+	for (iter = commits; iter; iter = iter->next)
     -+		if (iter->item != tip)
     -+			oidset_insert(interior_out, &iter->item->object.oid);
     -+
     -+	*base_out = base;
      +	*oldest_out = oldest;
      +	*tip_out = tip;
     ++	*message_out = strbuf_detach(&subject_data.squash_message, NULL);
      +	ret = 0;
      +
      +out:
     -+	commit_list_free(boundaries);
     -+	commit_list_free(commits);
     -+	oidset_clear(&selected);
     -+	oidset_clear(&has_children);
     -+	reset_revision_walk();
     ++	strbuf_release(&todo_buf);
     ++	subject_data_clear(&subject_data);
      +	release_revisions(&revs);
     -+	strvec_clear(&args);
     ++	ref_filter_clear(&filter);
     ++	ref_array_clear(&refs);
      +	return ret;
      +}
      +
     -+static const char *autosquash_target(const char *subject)
     -+{
     -+	const char *rest;
     -+
     -+	while (skip_prefix(subject, "fixup! ", &rest) ||
     -+	       skip_prefix(subject, "squash! ", &rest) ||
     -+	       skip_prefix(subject, "amend! ", &rest))
     -+		subject = rest;
     -+	return subject;
     -+}
     -+
     -+static int reject_dangling_fixups(struct repository *repo,
     -+				  struct commit *base,
     -+				  struct commit *tip,
     -+				  struct commit **amend_source)
     -+{
     -+	struct todo_list todo = TODO_LIST_INIT;
     -+	struct replay_opts opts = REPLAY_OPTS_INIT;
     -+	struct rev_info revs;
     -+	struct commit *commit, *last_amend = NULL;
     -+	struct strvec args = STRVEC_INIT;
     -+	char *dangling_subject = NULL, *dangling_target = NULL;
     -+	bool mixed_target = false, all_fixups_one_target;
     -+	bool past_oldest_group = false;
     -+	int i, ret, nr_dangling = 0;
     -+
     -+	*amend_source = NULL;
     -+
     -+	repo_init_revisions(repo, &revs, NULL);
     -+	strvec_push(&args, "ignored");
     -+	strvec_push(&args, "--reverse");
     -+	strvec_push(&args, "--topo-order");
     -+	strvec_pushf(&args, "%s..%s", oid_to_hex(&base->object.oid),
     -+		     oid_to_hex(&tip->object.oid));
     -+	setup_revisions_from_strvec(&args, &revs, NULL);
     -+
     -+	if (prepare_revision_walk(&revs) < 0) {
     -+		ret = error(_("error preparing revisions"));
     -+		goto out;
     -+	}
     -+	while ((commit = get_revision(&revs)))
     -+		strbuf_addf(&todo.buf, "pick %s\n",
     -+			    oid_to_hex(&commit->object.oid));
     -+
     -+	if (todo_list_parse_insn_buffer(repo, &opts, todo.buf.buf, &todo) < 0 ||
     -+	    todo_list_rearrange_squash(&todo) < 0) {
     -+		ret = error(_("could not check the range for fixups"));
     -+		goto out;
     -+	}
     -+
     -+	for (i = 0; i < todo.nr; i++) {
     -+		const char *message, *subject_start, *target;
     -+		char *subject;
     -+		size_t sublen;
     -+
     -+		message = repo_logmsg_reencode(repo, todo.items[i].commit,
     -+					       NULL, NULL);
     -+		sublen = find_commit_subject(message, &subject_start);
     -+
     -+		if (todo.items[i].command != TODO_PICK) {
     -+			if (!past_oldest_group &&
     -+			    starts_with(subject_start, "amend! "))
     -+				*amend_source = todo.items[i].commit;
     -+			repo_unuse_commit_buffer(repo, todo.items[i].commit, message);
     -+			continue;
     -+		}
     -+		if (i)
     -+			past_oldest_group = true;
     -+
     -+		subject = xmemdupz(subject_start, sublen);
     -+		target = autosquash_target(subject);
     -+		if (target != subject) {
     -+			nr_dangling++;
     -+			if (!dangling_target) {
     -+				dangling_target = xstrdup(target);
     -+				dangling_subject = xstrdup(subject);
     -+			} else if (strcmp(dangling_target, target)) {
     -+				mixed_target = true;
     -+			}
     -+			if (starts_with(subject, "amend! "))
     -+				last_amend = todo.items[i].commit;
     -+		}
     -+		free(subject);
     -+		repo_unuse_commit_buffer(repo, todo.items[i].commit, message);
     -+	}
     -+
     -+	all_fixups_one_target = nr_dangling == todo.nr && !mixed_target;
     -+	if (nr_dangling && !all_fixups_one_target) {
     -+		ret = error(_("cannot squash '%s': its target is not in the "
     -+			      "range"), dangling_subject);
     -+	} else {
     -+		if (last_amend)
     -+			*amend_source = last_amend;
     -+		ret = 0;
     -+	}
     -+
     -+out:
     -+	free(dangling_subject);
     -+	free(dangling_target);
     -+	todo_list_release(&todo);
     -+	replay_opts_release(&opts);
     -+	reset_revision_walk();
     -+	release_revisions(&revs);
     -+	strvec_clear(&args);
     -+	return ret;
     -+}
     -+
     -+struct interior_ref_cb {
     -+	const struct oidset *interior;
     -+	const char *name;
     -+};
     -+
     -+static int find_interior_ref(const struct reference *ref, void *cb_data)
     -+{
     -+	struct interior_ref_cb *data = cb_data;
     -+
     -+	if (oidset_contains(data->interior, ref->oid)) {
     -+		data->name = xstrdup(ref->name);
     -+		return 1;
     -+	}
     -+
     -+	return 0;
     -+}
     -+
      +static bool amend_replaces_target(struct todo_list *todo, int target)
      +{
      +	int i;
     @@ builtin/history.c: out:
      +}
      +
      +static int build_squash_message(struct repository *repo,
     -+				struct commit *base,
     -+				struct commit *tip,
     ++				const struct strbuf *todo_buf,
      +				struct strbuf *out)
      +{
     -+	struct rev_info revs;
     -+	struct commit *commit;
     -+	struct strvec args = STRVEC_INIT;
      +	struct todo_list todo = TODO_LIST_INIT;
      +	struct replay_opts opts = REPLAY_OPTS_INIT;
      +	int i, nr_commits, ret;
      +
     -+	repo_init_revisions(repo, &revs, NULL);
     -+	strvec_push(&args, "ignored");
     -+	strvec_push(&args, "--reverse");
     -+	strvec_push(&args, "--topo-order");
     -+	strvec_pushf(&args, "%s..%s", oid_to_hex(&base->object.oid),
     -+		     oid_to_hex(&tip->object.oid));
     -+	setup_revisions_from_strvec(&args, &revs, NULL);
     -+
     -+	if (prepare_revision_walk(&revs) < 0) {
     -+		ret = error(_("error preparing revisions"));
     -+		goto out;
     -+	}
     -+
     -+	while ((commit = get_revision(&revs)))
     -+		strbuf_addf(&todo.buf, "pick %s\n",
     -+			    oid_to_hex(&commit->object.oid));
     -+
     -+	if (todo_list_parse_insn_buffer(repo, &opts, todo.buf.buf, &todo) < 0 ||
     ++	if (todo_list_parse_insn_buffer(repo, &opts, todo_buf->buf, &todo) < 0 ||
      +	    todo_list_rearrange_squash(&todo) < 0) {
      +		ret = error(_("could not prepare the squash message"));
      +		goto out;
     @@ builtin/history.c: out:
      +out:
      +	todo_list_release(&todo);
      +	replay_opts_release(&opts);
     -+	reset_revision_walk();
     -+	release_revisions(&revs);
     -+	strvec_clear(&args);
      +	return ret;
      +}
      +
     @@ builtin/history.c: out:
      +		NULL,
      +	};
      +	enum ref_action action = REF_ACTION_DEFAULT;
     -+	enum commit_tree_flags flags = 0;
      +	int dry_run = 0;
      +	int edit = 1;
      +	struct option options[] = {
     @@ builtin/history.c: out:
      +		OPT_END(),
      +	};
      +	struct strbuf reflog_msg = STRBUF_INIT;
     -+	struct strbuf message = STRBUF_INIT;
     -+	struct oidset interior = OIDSET_INIT;
     -+	struct commit *base = NULL, *oldest = NULL, *tip = NULL, *rewritten,
     -+		*amend_source = NULL;
     ++	struct commit *oldest, *tip, *rewritten;
      +	const struct object_id *base_tree_oid, *tip_tree_oid;
     -+	const char *message_template = NULL;
     -+	struct commit_list *parents = NULL;
     ++	char *message_template = NULL;
      +	struct rev_info revs = { 0 };
      +	int ret;
      +
      +	argc = parse_options(argc, argv, prefix, options, usage,
     -+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
     -+	if (!argc) {
     ++			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
     ++	if (argc < 2) {
      +		ret = error(_("command expects a revision range"));
      +		goto out;
      +	}
     @@ builtin/history.c: out:
      +	if (action == REF_ACTION_DEFAULT)
      +		action = REF_ACTION_BRANCHES;
      +
     -+	ret = resolve_squash_range(repo, argv, &base, &oldest, &tip,
     -+				   &interior);
     -+	if (ret < 0)
     -+		goto out;
     ++	strbuf_addstr(&reflog_msg, "squash: updating ");
     ++	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
      +
     -+	ret = reject_dangling_fixups(repo, base, tip, &amend_source);
     ++	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
     ++				   edit,
     ++				   argc, argv, &oldest, &tip,
     ++				   &message_template);
      +	if (ret < 0)
      +		goto out;
     -+	if (!edit && amend_source) {
     -+		const char *amend_message, *body;
     -+
     -+		amend_message = repo_logmsg_reencode(repo, amend_source,
     -+						     NULL, NULL);
     -+		find_commit_subject(amend_message, &body);
     -+		body = skip_blank_lines(body + commit_subject_length(body));
     -+		strbuf_addstr(&message, body);
     -+		message_template = message.buf;
     -+		repo_unuse_commit_buffer(repo, amend_source, amend_message);
     -+	}
     -+
     -+	if (action == REF_ACTION_BRANCHES) {
     -+		struct interior_ref_cb cb = { .interior = &interior };
     -+
     -+		refs_for_each_branch_ref(get_main_ref_store(repo),
     -+					 find_interior_ref, &cb);
     -+		if (cb.name) {
     -+			ret = error(_("'%s' points into the squashed range"),
     -+				    cb.name);
     -+			advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
     -+					  _("Use --update-refs=head to rewrite only "
     -+					    "the current branch and leave such refs "
     -+					    "untouched."));
     -+			free((char *)cb.name);
     -+			goto out;
     -+		}
     -+	}
     -+
     -+	if (edit) {
     -+		ret = build_squash_message(repo, base, tip, &message);
     -+		if (ret < 0)
     -+			goto out;
     -+		message_template = message.buf;
     -+		flags |= COMMIT_TREE_EDIT_MESSAGE;
     -+	}
      +
      +	ret = setup_revwalk(repo, action, tip, &revs);
      +	if (ret < 0)
      +		goto out;
      +
     -+	base_tree_oid = &repo_get_commit_tree(repo, base)->object.oid;
     ++	base_tree_oid = &repo_get_commit_tree(repo,
     ++					oldest->parents->item)->object.oid;
      +	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
     -+	commit_list_append(base, &parents);
      +
      +	ret = commit_tree_ext(repo, "squash", oldest, message_template,
     -+			      parents,
     -+			      base_tree_oid, tip_tree_oid, &rewritten, flags);
     ++			      oldest->parents, base_tree_oid, tip_tree_oid,
     ++			      &rewritten,
     ++			      edit ? COMMIT_TREE_EDIT_MESSAGE : 0);
      +	if (ret < 0) {
      +		ret = error(_("failed writing squashed commit"));
      +		goto out;
      +	}
      +
     -+	strbuf_addstr(&reflog_msg, "squash: updating ");
     -+	strbuf_join_argv(&reflog_msg, argc, argv, ' ');
     -+
      +	ret = handle_reference_updates(&revs, action, tip, rewritten,
      +				       reflog_msg.buf, dry_run,
      +				       REPLAY_EMPTY_COMMIT_ABORT);
     @@ builtin/history.c: out:
      +
      +out:
      +	strbuf_release(&reflog_msg);
     -+	strbuf_release(&message);
     -+	oidset_clear(&interior);
     -+	commit_list_free(parents);
      +	release_revisions(&revs);
     ++	free(message_template);
      +	return ret;
      +}
      +
     @@ builtin/history.c: int cmd_history(int argc,
       	};
       
      
     + ## object.h ##
     +@@ object.h: void object_array_init(struct object_array *array);
     +  * bisect.c:                                        16
     +  * bundle.c:                                        16
     +  * http-push.c:                          11-----14
     ++ * builtin/history.c:                    11---13
     +  * commit-graph.c:                                15
     +  * commit-reach.c:                                  16-------20
     +  * builtin/last-modified.c:                         1617
     +
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
         't3452-history-split.sh',
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp expect actual
      +}
      +
     ++# Checks that the author data of two commits matches
     ++# Usage: check_commit_author <rev1> <rev2>
     ++check_commit_author () {
     ++	git show -s --format="%an <%ae> %ad" "$1" >expect &&
     ++	git show -s --format="%an <%ae> %ad" "$2" >actual &&
     ++	test_cmp expect actual
     ++}
     ++
      +test_expect_success 'setup linear history touching two files' '
     -+	test_commit base file a &&
     -+	git tag start &&
     -+	GIT_AUTHOR_NAME=Squasher GIT_AUTHOR_EMAIL=squash@example.com \
     -+		test_commit --no-tag one other x &&
     -+	test_commit --no-tag two file c &&
     -+	test_commit three file d
     ++	test_commit base file a start &&
     ++	GIT_AUTHOR_NAME=One GIT_AUTHOR_EMAIL=one@example.com \
     ++		test_commit one other x &&
     ++	GIT_AUTHOR_NAME=Two GIT_AUTHOR_EMAIL=two@example.com \
     ++		test_commit two file c &&
     ++	GIT_AUTHOR_NAME=Three GIT_AUTHOR_EMAIL=three@example.com \
     ++		test_commit three file d
      +'
      +
      +test_expect_success 'errors on missing range argument' '
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp_rev "$head_before" HEAD
      +'
      +
     ++test_expect_success 'rejects root commit' '
     ++	# create a disconnected root commit
     ++	oid=$(git commit-tree -m root three^{tree}) &&
     ++	# because we pass --ancestry-path when calling setup_revs() it the
     ++	# revision walk will only include commits decended from $oid so
     ++	# we need to give it another --ancestry-path commit to actually walk
     ++	# any commits.
     ++	test_must_fail git history squash --ancestry-path=start $oid..three 2>err &&
     ++	echo "error: cannot squash down to root commit" >expect &&
     ++	test_cmp expect err
     ++'
     ++
     ++test_expect_success 'rejects multiple tips' '
     ++	oid=$(git commit-tree -m tip -p start^0 three^{tree}) &&
     ++	test_must_fail git history squash ^start $oid three~1 2>err &&
     ++	echo "error: the revision range contains more than one tip commit" >expect &&
     ++	test_cmp expect err &&
     ++
     ++	git reset --hard three &&
     ++	git history squash --no-edit ^start three~1 three &&
     ++	test_cmp_rev HEAD~1 start^0 &&
     ++	test_cmp_rev HEAD^{tree} three^{tree}
     ++'
     ++
      +test_expect_success 'accepts multiple revision arguments with an exclusion' '
      +	git reset --hard three &&
      +	git branch -f keep HEAD~2 &&
     @@ t/t3455-history-squash.sh (new)
      +	git branch -D keep
      +'
      +
     -+test_expect_success 'refuses a range with more than one tip' '
     -+	git reset --hard start &&
     -+	main=$(git symbolic-ref --short HEAD) &&
     -+	test_commit --no-tag main-one file b &&
     -+	test_commit --no-tag main-two file c &&
     -+	git checkout -b other-tip start &&
     -+	test_commit --no-tag other-tip other d &&
     -+	git checkout "$main" &&
     -+	main_before=$(git rev-parse HEAD) &&
     -+	other_before=$(git rev-parse other-tip) &&
     -+
     -+	test_must_fail git history squash ^start HEAD other-tip 2>err &&
     -+	test_grep "more than one tip" err &&
     -+	test_cmp_rev "$main_before" HEAD &&
     -+	test_cmp_rev "$other_before" other-tip &&
     -+
     -+	git branch -D other-tip
     -+'
     -+
     -+test_expect_success 'refuses a range that reaches a root commit' '
     -+	git reset --hard three &&
     -+	root=$(printf "unrelated root\n" |
     -+		git commit-tree "$(git rev-parse HEAD^{tree})") &&
     -+	head_before=$(git rev-parse HEAD) &&
     -+
     -+	test_must_fail git history squash --ancestry-path="$root" \
     -+		^start HEAD "$root" 2>err &&
     -+	test_grep "reaches a root commit" err &&
     -+	test_cmp_rev "$head_before" HEAD
     -+'
     -+
      +test_expect_success 'squashes a branch the current branch is not on' '
      +	git reset --hard three &&
      +	main=$(git symbolic-ref --short HEAD) &&
     @@ t/t3455-history-squash.sh (new)
      +	git branch -D off-history
      +'
      +
     -+test_expect_success 'squashes a range preserving its tree and oldest authorship' '
     ++test_expect_success 'squashes a range into a single commit without changing the tree' '
      +	git reset --hard three &&
      +	head_before=$(git rev-parse HEAD) &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash --dry-run start.. >out &&
     ++	git history squash --no-edit --dry-run start.. >out &&
      +	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
      +	test_cmp_rev "$head_before" HEAD &&
      +
     -+	git history squash start.. &&
     ++	git history squash --no-edit start.. &&
      +
      +	test "$predicted" = "$(git rev-parse HEAD)" &&
      +	check_commit_count start..HEAD 1 &&
     @@ t/t3455-history-squash.sh (new)
      +	check_log_subjects -1 <<-\EOF &&
      +	one
      +	EOF
     -+	git log -1 --format="%an <%ae>" >actual &&
     -+	echo "Squasher <squash@example.com>" >expect &&
     -+	test_cmp expect actual &&
      +	git reflog >reflog &&
      +	test_grep "squash: updating" reflog
      +'
     @@ t/t3455-history-squash.sh (new)
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
      +'
      +
     ++test_expect_success 'squashing a mix of fixups' '
     ++	git reset --hard three &&
     ++	echo fix >file &&
     ++	git commit --fixup=two -a &&
     ++	echo really fix >file &&
     ++	git commit --fixup=one -a &&
     ++	echo really really fix >file &&
     ++	git commit --fixup=HEAD~1 -a && # fixup! two
     ++	echo really really really fix >file &&
     ++	git commit --fixup=HEAD~1 -a && # fixup! one
     ++
     ++	# squashing fixup! with a target that is not being squashed fails
     ++	test_must_fail git history squash one.. 2>err &&
     ++	test_grep "^error: cannot squash .* (fixup! one): its target is not being squashed" err &&
     ++
     ++	# squashing fixup! into fixup! with a different target fails
     ++	test_must_fail git history squash HEAD~4.. 2>err && # HEAD~4 is fixup! two
     ++	test_grep "^error: cannot squash .* (fixup! one): its target is not being squashed" err &&
     ++
     ++	# squashing a sequence of fixup! commits into their targets
     ++	git history squash --no-edit start..HEAD~1 &&
     ++	test_cmp_rev start HEAD~2 &&
     ++	check_commit_author one HEAD~1 &&
     ++	test_commit_message HEAD~1 -m one &&
      +
     -+test_expect_success 'folds fixups whose target is in the range' '
     -+	git reset --hard start &&
     -+	test_commit --no-tag target file b &&
     -+	git commit --allow-empty -m "fixup! target" &&
     -+	git commit --allow-empty -m "fixup! target" &&
     -+	test_commit --no-tag later file c &&
     -+
     ++	# squashing "fixup! fixup! <target>" into "<target>"
      +	git history squash --no-edit start.. &&
     -+
     -+	check_commit_count start..HEAD 1 &&
     -+	check_log_subjects -1 <<-\EOF
     -+	target
     -+	EOF
     ++	test_cmp_rev start HEAD~1 &&
     ++	check_commit_author one HEAD &&
     ++	test_commit_message HEAD -m one
      +'
      +
     -+test_expect_success 'refuses a below-range fixup! after an in-range commit' '
     -+	git reset --hard start &&
     -+	test_commit --no-tag inside file b &&
     -+	test_commit --no-tag "fixup! outside" file c &&
     -+	head_before=$(git rev-parse HEAD) &&
     -+
     -+	test_must_fail git history squash start.. 2>err &&
     -+	test_grep "target is not in the range" err &&
     -+	test_cmp_rev "$head_before" HEAD
     -+'
     ++test_expect_success 'squashing "squash!" messages' '
     ++	git reset --hard two &&
     ++	echo fix >file &&
     ++	git commit --fixup=HEAD -a &&
     ++	oldest=$(git rev-parse HEAD) &&
     ++	echo better fix >file &&
     ++	git commit -a -F - <<-EOF &&
     ++	squash! $(git rev-parse two)
      +
     -+test_expect_success 'combines a run of fixups for one commit below the range' '
     -+	git reset --hard start &&
     -+	stage_file b && git commit -m "fixup! base" &&
     -+	stage_file c && git commit -m "fixup! base" &&
     ++	Append this
     ++	EOF
      +
     -+	git history squash --no-edit start.. &&
     ++	echo an even better fix >file &&
     ++	git commit -a -F - <<-EOF &&
     ++	squash! squash! two
      +
     -+	check_commit_count start..HEAD 1 &&
     -+	check_log_subjects -1 <<-\EOF
     -+	fixup! base
     ++	Append this as well
      +	EOF
     -+'
      +
     -+test_expect_success 'combining below-range markers offers every message' '
     -+	git reset --hard start &&
     -+	stage_file b && git commit -m "fixup! base" &&
     -+	stage_file c &&
     -+	commit_with_message "amend! base\n\namended body\n" &&
     ++	# must edit when squashing "squash!" into its target
     ++	test_must_fail git history squash --no-edit two^.. 2>err &&
     ++	test_grep "^error: squashing .* (squash! [a-f0-9]*) would discard its message" err &&
      +
     -+	git history squash start.. &&
     ++	# squashing "squash!" into "fixup!" appends messages and changes
     ++	# subject prefix
     ++	git history squash --no-edit two.. &&
     ++	test_cmp_rev HEAD^ two &&
     ++	test_commit_message HEAD <<-\EOF &&
     ++	squash! two
      +
     -+	check_commit_count start..HEAD 1 &&
     -+	check_log_messages -1 <<-\EOF
     -+	fixup! base
     ++	Append this
      +
     -+	amend! base
     ++	Append this as well
     ++	EOF
     ++	check_commit_author "$oldest" HEAD &&
      +
     -+	amended body
     ++	git commit --allow-empty -F - <<-\EOF &&
     ++	amend! two
      +
     ++	A new message
      +	EOF
     ++
     ++	# "amend!" does not replace "squash!"
     ++	test_must_fail git history squash --no-edit HEAD~2.. 2>err &&
     ++	test_grep "^error: squashing .* (amend! two) would overwrite .squash!. message" err
      +'
      +
     -+test_expect_success 'refuses fixups for two different commits below the range' '
     -+	git reset --hard start &&
     -+	stage_file b && git commit -m "fixup! aaa" &&
     -+	stage_file c && git commit -m "fixup! bbb" &&
     -+	head_before=$(git rev-parse HEAD) &&
     ++test_expect_success '--no-edit uses last "amend!" message without an editor' '
     ++	git reset --hard three &&
     ++	write_script editor <<-\EOF &&
     ++	exit 1
     ++	EOF
     ++	test_set_editor "$(pwd)/editor" &&
     ++	echo fix >file &&
     ++	git commit --author="Fix Me <fix.me@example.com>" --fixup=HEAD -a &&
     ++	git commit --allow-empty -F - <<-EOF &&
     ++	amend! $(git rev-parse --short HEAD)
      +
     -+	test_must_fail git history squash start.. 2>err &&
     -+	test_grep "target is not in the range" err &&
     -+	test_cmp_rev "$head_before" HEAD
     -+'
     ++	The first reword
      +
     -+test_expect_success 'does not discard squash! or amend! message bodies' '
     -+	git reset --hard start &&
     -+	test_commit --no-tag marker-oldest file b &&
     -+	git commit --allow-empty -m "squash! marker-oldest" &&
     -+	commit_with_message "amend! marker-oldest\n\nearlier message\n" &&
     -+	commit_with_message \
     -+		"amend! marker-oldest\n\namended subject\n\namended body\n" &&
     -+	test_commit --no-tag marker-later file c &&
     -+	commit_with_message "amend! marker-later\n\nwrong message\n" &&
     ++	More detail
     ++	EOF
      +
     -+	git history squash start.. &&
     ++	git commit --allow-empty -F - <<-\EOF &&
     ++	amend! three
      +
     -+	check_commit_count start..HEAD 1 &&
     -+	check_log_messages -1 <<-\EOF
     -+	marker-oldest
     ++	The second reword
      +
     -+	earlier message
     ++	Extra detail
     ++	EOF
      +
     -+	amended subject
     ++	test_commit WIP &&
      +
     -+	amended body
     ++	cat >msg <<-EOF &&
     ++	amend! $(git rev-parse HEAD^ | tr a-f A-F)
      +
     -+	wrong message
     ++	The third reword
      +
     ++	Excruciating detail
      +	EOF
     -+'
     -+
     -+test_expect_success '--no-edit keeps the selected message without an editor' '
     -+	git reset --hard start &&
     -+	test_commit --no-tag no-edit-target file b &&
     -+	git commit --allow-empty -m "squash! no-edit-target" &&
     -+	commit_with_message "amend! no-edit-target\n\namended subject\n\namended body\n" &&
      +
     -+	write_script editor <<-\EOF &&
     -+	exit 1
     ++	git commit --author="Someone Else <s.else@example.com>" --allow-empty \
     ++		-F msg &&
     ++
     ++	# squashing amend! updates the commit message
     ++	git history squash --no-edit three^.. &&
     ++	sed -e 1,2d msg | test_commit_message HEAD &&
     ++	check_commit_author three HEAD &&
     ++	test_cmp_rev HEAD^ three^ &&
     ++
     ++	# squashing amend! into fixup! updates subject prefix
     ++	git reset --hard HEAD@{1} &&
     ++	git history squash --no-edit three.. &&
     ++	sed "1s/.*/amend! three/" msg | test_commit_message HEAD &&
     ++	check_commit_author HEAD@{1}~4 HEAD &&
     ++	test_cmp_rev HEAD^ three &&
     ++
     ++	# squashing amend! into amend! keeps original subject line
     ++	git reset --hard HEAD@{1} &&
     ++	git history squash --no-edit HEAD~3.. &&
     ++	sed "1s/.*/amend! three/" msg | test_commit_message HEAD &&
     ++	test_cmp_rev HEAD~3 three &&
     ++
     ++	# all amend! messages must target the first commit
     ++	git reset --hard HEAD@{1} &&
     ++	git commit --allow-empty -F - <<-\EOF &&
     ++	amend! WIP
     ++
     ++	The real message
      +	EOF
     -+	test_set_editor "$(pwd)/editor" &&
     -+	git history squash --no-edit start.. &&
      +
     -+	check_log_messages -1 <<-\EOF &&
     -+	amended subject
     ++	test_must_fail git history squash --no-edit HEAD~4.. 2>err &&
     ++	test_grep "^error: cannot squash .* that does not target" err &&
      +
     -+	amended body
     ++	# amend! message that targets commit that is not in range is rejected
     ++	test_must_fail git history squash --no-edit HEAD~3.. 2>err &&
     ++	test_grep "^error: cannot squash .* target is not being squashed" err &&
     ++	test_set_editor :
     ++'
      +
     ++test_expect_success 'squashing fixups into a merge' '
     ++	test_when_finished \
     ++		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
     ++		 git branch -D feature" &&
     ++	git checkout -f start &&
     ++	test_commit F1 &&
     ++	git checkout -b feature start &&
     ++	test_commit F2 &&
     ++	git merge F1 &&
     ++	echo fixed >F1.t &&
     ++	cat >msg <<-EOF &&
     ++	amend! $(git rev-parse HEAD)
     ++
     ++	merge F1 and F2
     ++
     ++	reworded
      +	EOF
     -+	test_set_editor :
     ++
     ++	git commit -a -F msg &&
     ++	git history squash --no-edit HEAD^^! HEAD &&
     ++	test_cmp_rev HEAD^1 F2 &&
     ++	test_cmp_rev HEAD^2 F1 &&
     ++	test_cmp_rev HEAD@{1}^{tree} HEAD^{tree} &&
     ++	sed 1,2d msg | test_commit_message HEAD
      +'
      +
      +test_expect_success 'edits every message and aborts on an empty result' '
     @@ t/t3455-history-squash.sh (new)
      +	EOF
      +'
      +
     -+test_expect_success 'handles fixup!, squash! and amend! messages like rebase' '
     ++test_expect_success 'handles fixup!, squash! and amend! like rebase' '
      +	git reset --hard start &&
      +	test_commit --no-tag mark-base file b &&
      +	stage_file c &&
     @@ t/t3455-history-squash.sh (new)
      +	EOF
      +'
      +
     -+test_expect_success 'handles branches pointing at the squashed range' '
     ++test_expect_success '--update-refs=head only moves HEAD' '
      +	git reset --hard three &&
      +	git branch -f other HEAD &&
     -+	git branch -f mid HEAD~1 &&
      +	other_before=$(git rev-parse other) &&
     -+	mid_before=$(git rev-parse mid) &&
     -+	head_before=$(git rev-parse HEAD) &&
     ++
     ++	git history squash --no-edit --update-refs=head start.. &&
     ++
     ++	check_commit_count start..HEAD 1 &&
     ++	test_cmp_rev "$other_before" other
     ++'
     ++
     ++test_expect_success 'refuses to fold a range a branch points into' '
     ++	test_when_finished \
     ++		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
     ++		 git branch -D feature" &&
     ++	git checkout -f -b feature start &&
     ++	test_commit C1 &&
     ++	test_commit C2 &&
     ++	git checkout -b topic-1 start &&
     ++	test_commit C3 &&
     ++	test_commit C4 &&
     ++	git checkout C3 &&
     ++	test_commit C5 &&
     ++	git checkout feature &&
     ++	git merge C5 &&
     ++	test_commit C6 &&
     ++	git checkout -b topic-2 C2 &&
     ++	test_commit C7 &&
     ++	git checkout feature &&
      +
      +	test_must_fail git history squash start.. 2>err &&
     -+	test_grep "error: .* points into the squashed range" err &&
     -+	test_grep "hint: .*--update-refs=head" err &&
     -+	test_cmp_rev "$head_before" HEAD &&
     ++	# TODO: check the branch names when we print them (topic-1 & topic-2)
     ++	test_grep "^error: a branch points to" err &&
     ++	test_grep "^hint: .* --update-refs=head" err &&
     ++	test_cmp_rev C6 HEAD &&
     ++
     ++	# squash succeeds with --update-refs=head
     ++	git history squash --no-edit --update-refs=head start.. &&
     ++	test_cmp_rev start HEAD^ &&
     ++	test_cmp_rev C6^{tree} HEAD^{tree} &&
     ++	test_cmp_rev C6 HEAD@{1}
     ++'
     ++
     ++test_expect_success 'advice.historyUpdateRefs silences the hint' '
     ++	git reset --hard three &&
     ++	git branch -f mid HEAD~1 &&
     ++	head_before=$(git rev-parse HEAD) &&
      +
      +	test_must_fail git -c advice.historyUpdateRefs=false \
      +		history squash start.. 2>err &&
     -+	test_grep "points into the squashed range" err &&
     ++	test_grep "^error: a branch points to" err &&
      +	test_grep ! "hint:" err &&
      +	test_cmp_rev "$head_before" HEAD &&
      +
     -+	git history squash --no-edit --update-refs=head start.. &&
     -+
     -+	check_commit_count start..HEAD 1 &&
     -+	test_cmp_rev "$other_before" other &&
     -+	test_cmp_rev "$mid_before" mid &&
     -+
     -+	git branch -D other mid
     ++	git branch -D mid
      +'
      +
      +test_expect_success 'leaves tags and remote-tracking refs unchanged' '
     @@ t/t3455-history-squash.sh (new)
      +	git update-ref -d refs/remotes/origin/mark
      +'
      +
     -+test_expect_success 'handles a branch pointing at an internal merge' '
     ++test_expect_success 'squashes a range whose internal merge has a single base' '
      +	git reset --hard start &&
      +	main=$(git symbolic-ref --short HEAD) &&
      +	test_commit --no-tag before-side file b &&
     @@ t/t3455-history-squash.sh (new)
      +	test_commit --no-tag after-side file c &&
      +	git merge --no-ff -m merge inner-side &&
      +	git branch -D inner-side &&
     -+	git branch at-merge HEAD &&
      +	test_commit --no-tag after-merge file d &&
     -+	head_before=$(git rev-parse HEAD) &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	test_must_fail git history squash start.. 2>err &&
     -+	test_grep "at-merge" err &&
     -+	test_grep "points into the squashed range" err &&
     -+	test_cmp_rev "$head_before" HEAD &&
     -+	git branch -D at-merge &&
     -+
      +	git history squash --no-edit start.. &&
      +
      +	check_commit_count start..HEAD 1 &&
     @@ t/t3455-history-squash.sh (new)
      +	merged=$(git rev-parse HEAD) &&
      +
      +	test_must_fail git history squash "$base.." 2>err &&
     -+	test_grep "more than one base" err &&
     ++	test_grep "parent .* of commit .* is outside the revision range" err &&
      +	test_cmp_rev "$merged" HEAD
      +'
      +
     @@ t/t3455-history-squash.sh (new)
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
      +'
      +
     ++test_expect_success 'folds a range with two interior merges' '
     ++	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	test_commit --no-tag two-merge-a file a1 &&
     ++	git checkout -b two-merge-s1 &&
     ++	test_commit --no-tag two-merge-s1 s1 x &&
     ++	git checkout "$main" &&
     ++	git merge --no-ff -m "merge s1" two-merge-s1 &&
     ++	test_commit --no-tag two-merge-b file b1 &&
     ++	git checkout -b two-merge-s2 &&
     ++	test_commit --no-tag two-merge-s2 s2 y &&
     ++	git checkout "$main" &&
     ++	git merge --no-ff -m "merge s2" two-merge-s2 &&
     ++	git branch -D two-merge-s1 two-merge-s2 &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
     ++
     ++	git history squash --no-edit start.. &&
     ++
     ++	check_commit_count start..HEAD 1 &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     ++	test_path_is_file s1 &&
     ++	test_path_is_file s2
     ++'
     ++
      +test_expect_success 'folds a range with a nested merge' '
      +	git reset --hard start &&
      +	main=$(git symbolic-ref --short HEAD) &&
     @@ t/t3455-history-squash.sh (new)
      +	git branch -D octo-pre octo-within &&
      +
      +	test_must_fail git history squash "$octo_base.." 2>err &&
     -+	test_grep "more than one base" err &&
     ++	test_grep "parent .* of commit .* is outside the revision range" err &&
      +	test_cmp_rev "$merged" HEAD
      +'
      +
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp_rev "$head_before" HEAD
      +'
      +
     ++test_expect_success 'refuses to fold a range a ref points into at a merge' '
     ++	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	test_commit --no-tag refmerge-base file b &&
     ++	git checkout -b refmerge-side &&
     ++	test_commit --no-tag refmerge-side side x &&
     ++	git checkout "$main" &&
     ++	test_commit --no-tag refmerge-main file c &&
     ++	git merge --no-ff -m "interior merge" refmerge-side &&
     ++	git branch -D refmerge-side &&
     ++	git branch at-merge HEAD &&
     ++	test_commit --no-tag refmerge-tail file d &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash start.. 2>err &&
     ++	# TODO: test for branch nome "at-merge"
     ++	test_grep "a branch points to a commit" err &&
     ++	test_cmp_rev "$head_before" HEAD &&
     ++
     ++	git branch -D at-merge
     ++'
     ++
      +test_done

-- 
gitgitgadget
