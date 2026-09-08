Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828273B42D9
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900124; cv=none; b=n0HNLFGrC7D2x7nrU5FB7HmYznfd2nXSgFkSNiEAGfcROxIsDfJy9yoRPr2rPhBJBYLjaCA7a5bxyK7jJ537SLgvCxuAfIft+riXMyNFqZg3u29Z2UyNP7FVVLsL66RvyHwxW4Eyb7ExaUQv9qC5I8dUcWsheRDc46X4z/y0cSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900124; c=relaxed/simple;
	bh=Fgmg8bLBzHXerni8PuHnWxlUZhtLcZjfSngkNHsKLCI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gmlqtcjv9QeLplUci/kNOYYAxaTN8l2zBovZA1WaIjBlC2eYtX1IzcsW46kORr2xzsjn27Cq2FCZCOVvewdgNOCtcIWbf9NRcs/HWae+F4R+tSP3jECjGMC1irHPGSRcat+Lt8DWqwEb2T0GwMwF6c8VIT92iFevUiaC+Xwheak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2kv/Z/m; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2kv/Z/m"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91054f537ccso34445126d6.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900121; x=1789504921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PpKOVdKyW88XPR4tD0pj7+VssCpdEy2m6h5hk9HeEzM=;
        b=P2kv/Z/mMc1RMZ3TgCDUlcOO4SdwfCbUKvSk6zPRyVTnr2SHvbz8gwXuNzzTNyUdwI
         Ok4jvsALrMbowa3MVatcqx8IB8kN4cS6bfp7xbABr+WJAHLnRi1OBgSTJjzrFWgTe7ia
         xbHtSFdcd1CfOVn4xAkh2iYAVmPPxZpJ9ItDCFboNUAtT8eQebi6yrdOmQvZhVyEBIcH
         BoV0Yu7gAkSaJT2ZBYvEiHmrRquYRMv5ATALn+OePmlEWv/SNR6tuhMMBoZFq/xP60cP
         Cv1QEyUEisb16rbalZsfY6Rc+4JTm+5V3Xyvn/NueGAQ4EnPd5yR0jJwSHk7HpjeE00Z
         3cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900121; x=1789504921;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PpKOVdKyW88XPR4tD0pj7+VssCpdEy2m6h5hk9HeEzM=;
        b=pauPzAHcYaT8b6h45rxoGPN/0poM/r++I1vHwtEdOLMY3AophkiAYr/l0KCPgww6xm
         3bXfJOHYv3wr7sa9P12RIEaxtnu7IIKnx6GUl+7lcDeVo7npmZ1u9kEMA7DdXB8AWNpk
         FtUe8Hwhl586yPeXvlM7bnXTTLANevddfMBjq5azwuJDq9ykUnUWltUXwGgwwVoxO0VF
         bTJdlP7qmbZCFqX/sS1WL34nTzqRu42QzK3/cbpuqEeUN+wEeVgG2gaVKqMF5399SQ3E
         RXhtluHNMG2EJ2zSMZSsZHCCS+kx2eIJ0SvZLIM0hKOCZ6COTschGek/ggZttlzDEcpQ
         jIBQ==
X-Gm-Message-State: AFuF++lnsf1IG5O7bRYBVqCwEA0DNa5/3OcI55oTX7VraRcMtOt+PO7N
	uhAxrVyo4Wyq/7xatnEeMxBui/wsTII4i35FtP7P0p7zgZIxnouejczj1qx1Ww==
X-Gm-Gg: AYBFou0pBBOZBl8B9x7AD3kaYhSvrca2uJKjF07FmSkPU0wj6NmR4Q4YIz1rjhObE8S
	wJBPCEyC5iu7v/hegjYoVylI+Nst2+THx2etVCLobUsYRcA2YDpSlH08YLzkAKiE5o0j5qWIFSZ
	RAn3gu/gzEmaBdVTifae2CiARpAdjtushE/qzbXnlHNr8VKhu85OKFbkAN8AcjUgNwY1qMnmRTJ
	J8H6FIwllt6EIbGZ0MQ02q9EL/0VfDyOs3TlKt4+qmiLY+joj9QOCa8NP+d9XbFe4gh82xaSH1u
	Op2KmuY602OfK9uTb/iPlLYZuaxtRRCY17zWAGbaNYd+G3+Hb48HXHbD/ZmCD5IBCqkMhDNArsg
	zEogqw1m0y0+1H/7SIwJhMFMaqLf/2HrjGgFlMGWMzSaNWafmiPTzg001hEkDmE37eSwo4Xn9I8
	I8MhwQwYBem3euKC0AxDkQowk1Sp0GzmM7CygtGUM7eVMMka1soKiWm60LMquHosrU
X-Received: by 2002:a05:6214:5e0a:b0:910:3170:b90e with SMTP id 6a1803df08f44-9103ef95214mr402483546d6.13.1788900121004;
        Tue, 08 Sep 2026 13:42:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.198.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910464bf898sm106416666d6.7.2026.09.08.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:42:00 -0700 (PDT)
Message-Id: <pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 20:41:51 +0000
Subject: [PATCH v15 0/8] history: add squash subcommand to fold a range
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>

Adds git history squash <revision-range> to fold a range of commits.

Changes in v15:

 * Fixed istarts_with() → starts_with() in squash_check_autosquash_subject()
   so fixup! ABCdef (mixed/upper-case hex) is no longer accepted.
 * Fixed a typo in the adjacent comment (squshed → squashed).

Changes in v14:

 * Update commit message trailers.
 * Simplify rev-parse and tr complexity in the tests.

Changes in v13:

 * Split the squash implementation into five patches covering parsing, range
   validation, branch protection, commit creation, and message editing.
 * Print the sorted names of local branches that prevent a squash, with
   clearer advice for --update-refs=head.
 * Isolate --no-edit behavior from the final patch that enables default
   editor-based message combining.

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

Harald Nordgren (8):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  sequencer: share the squash message marker helpers and flags
  history: add skeleton for squash subcommand
  history: validate squash revision ranges
  history: protect branches when squashing a range
  history: create squashed commits without editing
  history: support editing squashed commit messages

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  59 +-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 720 +++++++++++++++++++++++--
 object.h                         |   1 +
 sequencer.c                      |  70 +--
 sequencer.h                      |  30 ++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 886 +++++++++++++++++++++++++++++++
 t/t9902-completion.sh            |   1 +
 11 files changed, 1703 insertions(+), 71 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: b8242b093d9e941a34460d715e3ce616a34ac3fe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v15
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v15
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v14:

 1:  19c5e311a3 = 1:  98a1b756bc history: extract helper for a commit's parent tree
 2:  aadb7a5df4 = 2:  9d99354988 history: give commit_tree_ext a message template
 3:  e1621f656e = 3:  b7a1796838 sequencer: share the squash message marker helpers and flags
 4:  016ae0fd42 ! 4:  8ad1faaa9a history: add skeleton for squash subcommand
     @@ builtin/history.c: int cmd_history(int argc,
       		OPT_END(),
       	};
       
     +
     + ## t/t9902-completion.sh ##
     +@@ t/t9902-completion.sh: test_expect_success 'git history subcommands' '
     + 	fixup Z
     + 	reword Z
     + 	split Z
     ++	squash Z
     + 	EOF
     + 	test_completion "git history --" ""
     + '
 5:  4992d14ce4 = 5:  4389729c83 history: validate squash revision ranges
 6:  b862a5b4c3 = 6:  4d30ff1936 history: protect branches when squashing a range
 7:  03528d3b34 ! 7:  96349a802e history: create squashed commits without editing
     @@ builtin/history.c: out:
      +	}
      +	/*
      +	 * Allow "fixup! <hex object id>", but not "fixup! HEAD^" or
     -+	 * "fixup! main". If the target is not being squshed check the subject
     ++	 * "fixup! main". If the target is not being squashed check the subject
      +	 * to allow "fixup! abc123" and "fixup! <subject of abc123>" to be
      +	 * squashed together.
      +	 */
      +	target = lookup_commit_reference_by_name(s);
     -+	if (target && istarts_with(oid_to_hex(&target->object.oid), s)) {
     ++	if (target && starts_with(oid_to_hex(&target->object.oid), s)) {
      +		unsigned flags =
      +			target->object.flags & (SQUASH_SEEN | SQUASH_AMEND_TARGET);
      +		if (!flags) {
 8:  98aa3922cb = 8:  8da0333646 history: support editing squashed commit messages

-- 
gitgitgadget
