Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B3171CD
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314125; cv=none; b=tr2/Ew15qictPO5x4NHipfR/61gM5LMl1Mgi9BrogYFFNXaGGjzxFGCDxJ0r49VfghGMfo6Nny9w+XOomPBB4saTqcPJ3DY/MbjVvhl16V32dk9CSMysRtaox0CySgFur1XfU0lYtBB0KPOkWJBC/p+mt6PwTkMc4eHhx+7znoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314125; c=relaxed/simple;
	bh=ogvAXMeUuJdsbVFovXm4WdhWDO4b4f8QcI5we51356g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E3c35c6PY02zpd6hr9Gtw2gPHAtAsEfW79HQOnbJv26IcBwLluV9A4ykvmNaRJ54uqUC8B38lAwnTLK5+owJudfTdPEKVoadnPNT2cze/6k0QzfjULKzYZ+9/KpHRDS+TW39jkHp6RynfzgQafLHT1Gi2N7Pa4wJsVQMhvINhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhRnAr/I; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhRnAr/I"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e51d3d83cso120298985a.2
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783314122; x=1783918922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VTKnrjcITTUBSgCDksByoe6ZYu8bkzt6A3DvfBWTe4=;
        b=fhRnAr/I3Ke5KLCvRkJ2UXA4cwmFIaWeftp1pGSmW5bspNjiUYrNXPtagq86n1GQXv
         2Vz+3CbXeAMRY0eM/OfHCqAGPu8immc9+k2qlZRQHd7dirWXeErLqG83E+0jQijF5NAj
         tic4zxT/sj2rUU7KWaSU6Dd9ao6OYQ8H2I5e8O+TWfkFLYXH5smEyrS6qufP8Eu17tga
         94BhOKNP0KKNXl7odfE76gCEV0ljV+3bxhH3vL050GNz0MNssxdvBE1wM2Es1zTDtkGH
         eiYTeEbA7z1naXGbn+wyWAVCK17j/H9if1uqw7e4M+vJakq8lkgieutctHQfArdF5Sh0
         YGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783314122; x=1783918922;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2VTKnrjcITTUBSgCDksByoe6ZYu8bkzt6A3DvfBWTe4=;
        b=MUNc+A3twGPcYQhA54LwN8Lu5qsaan8aHZ2r9Fiu/IuuTEMTKnT3crguSsZNeR35LK
         BUB2waF7PpXa3ja7q5MYjsdsxsu04oI+pKJbZqPVHQfSWZ/xRCape26LDL76LULcD4m5
         gjQJte/3CqO5isQiAMhqqWDJETCgk8xxF8KDF5dM/frPhAOCCGzZ0BxfaxXpeE75Zu5e
         KHRci13hvO+V18qcOC4iUdZx3qklMhXnQd1nP8NKDhB3Bu4UYuGJa6v2lHFWJ7nw6WaJ
         pPCT+4PiG6sHh5zrV07S1ExAkpzrG+37Euw7IWhBXY3kMx2453ppHwU39opCGfHkWCnb
         0JgA==
X-Gm-Message-State: AOJu0YwzoiOaGW2EttVUtNVW7Mr8N3JeQaWtyZxcXIeMK/zoailhFNcs
	04Vue4cDDBNc6wWP6xr0U/EgkRBaaQpr+uvINuEiDPSbfdre3PRZMIelIvXQPttC
X-Gm-Gg: AfdE7clM+SzBKeyAMbKN0tzf9T64asVrkKIuFc3ombHaItY01wMR0hjL94J2YFWw8qU
	14EcdDIj7xA3rcYuVtJwZ2Bs1q7QP5BLhDEnNfDwCYiqcrfhvFAR1vQy8Zk2QNHITot30jhwPLN
	FumCteOBrmwTid5DYu+dhn9HOMdbBOb/I8Wt1cAbIHO/wwj1vwXav1X8Rl3CmrsJ9AzeppuSIvZ
	RKmG9vVaDZgbwSEsOzL2cEZZ5QFbCFJUglzfaG6fnwdQ+skM1vjpUCQZ31SPBewj0K9tRbFLRth
	c+epMtI8jKV8+G0OVYyduxGz38b+ICYccbNCI4ku5YJaPvmGbpEqhuvmodGPbr9c0WGtdoMX7R/
	mzi6mXJl3y5OmDKp0ZTGFJKn4wG5637HyiHbb6gDaPgH4Yfosw8tKGWSIRE1l1DRyUrTWzdyvTj
	vuTZ2wCMegJUAz4u4SG1yoUS7A
X-Received: by 2002:a05:620a:4621:b0:92b:6805:eae7 with SMTP id af79cd13be357-92e9a51eedcmr1117639585a.68.1783314121327;
        Sun, 05 Jul 2026 22:02:01 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.38.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ba4209sm881026185a.12.2026.07.05.22.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 22:02:00 -0700 (PDT)
Message-Id: <pull.2135.v4.git.1783314119.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
References: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 05:01:52 +0000
Subject: [PATCH v4 0/6] t: add greplint.pl and convert grep to test_grep
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

test_grep is a wrapper around grep for test assertions that prints the file
contents on failure for easier debugging. Bare grep fails silently, making
it hard to diagnose what went wrong.

This series converts existing bare grep assertions to test_grep and adds
greplint.pl to prevent new ones from being introduced.

Patch 1 documents test_grep in t/README.

Patch 2 fixes three greps missing file arguments (t2402, t7507, t7700). They
were reading empty stdin and passing vacuously.

Patch 3 extracts chainlint's Lexer, ShellParser, and ScriptParser into a
shared module (lib-shell-parser.pl) so greplint.pl can reuse the same
tokenizer. No functional change to chainlint.

Patch 4 fixes a latent line-counting bug in scan_dqstring where newlines
from $() bodies inside double-quoted strings were counted twice. This does
not affect chainlint (which uses byte offsets) but matters for greplint.pl's
line-number reporting.

Patch 5 converts existing assertion greps to test_grep, including sourced
test helpers. Greps used as data filters are left unconverted with lint-ok
annotations; an assertion on a conditionally-present file is guarded on that
condition (a prerequisite, or a 'test -e') and uses test_grep inside the
guard.

Patch 6 adds greplint.pl with test fixtures (modeled on chainlint/) and
wires it into the Makefile as test-greplint and check-greplint.

Changes since v3:

 * t/README: reworded the guidance to encourage explicit file existence /
   pre-req checks. Instead of "keep a plain guarded 'grep'", it now says to
   guard the assertion on the condition that governs the file's presence (a
   prerequisite, or a 'test -e' on the path) and use test_grep inside the
   guard, with a worked example:
   
   if test_have_prereq REFFILES
   then
           test_grep ! "$refname" .git/packed-refs
   fi
   

 * t7450 (squatting-clone/d/a/git~2): converted the last
   missing-file-tolerant '! grep' to that guarded form:
   
   if test -f squatting-clone/d/a/git\~2
   then
           test_grep ! gitdir squatting-clone/d/a/git\~2
   fi
   
   
   'git~2' is the NTFS 8.3 short name of the planted '..git' file and exists
   only when 8.3 short-name generation is enabled. Use 'test -f' so the
   conditional presence is now explicit instead of relying on grep's
   tolerance for a missing file, and the assertion gains test_grep's
   diagnostics where git~2 does materialize. This removes the only '#
   lint-ok' in the series that guarded an assertion rather than a data
   filter.

 * greplint.pl: updated the lint_ok() comment to match. A '# lint-ok'
   annotation now documents a single case: a grep acting as a data filter
   whose output is consumed by a redirect or pipe on an enclosing compound
   command (a subshell or brace group), which the filter heuristic cannot
   detect locally. The "file may not exist" rationale is gone; the two
   remaining annotated greps (t5326, t5702) are exactly this shape.

Note on ordering: this series leaves the t3420 '! grep dirty file3' line
untouched (per the request to omit it), so it depends on
sg/t3420-do-not-grep-in-missing-file, which replaces that line with
'test_path_is_missing file3' and is already in 'next'. Applied on top of
that topic the series is lint-clean with no edits. On a plain 'master' that
does not yet contain it, the greplint check added by the final patch will
flag exactly that one line by design (the t3420 test itself still passes;
only the static lint fires).

Known limitation / follow-up:

Assertions like grep pattern file >/dev/null and grep pattern <file are not
converted because greplint.pl treats any redirect as a filter, so it does
not flag them. The former could be converted, but test_grep prints the
matching line on success just as grep does, so the >/dev/null would have to
be kept or dropped as a judgment call. The latter requires turning the <file
redirect into a positional file argument, since test_grep reads a named file
rather than stdin. Both are left as bare grep with no annotation: unlike the
genuine data-filter greps, they carry no '# lint-ok' marker, because
greplint silently classifies any redirect as a filter and never flags them.
A follow-up series can address these once a convention is established.

Michael Montalbo (6):
  t/README: document test_grep helper
  t: fix grep assertions missing file arguments
  t: extract chainlint's parser into shared module
  t: fix Lexer line count for $() inside double-quoted strings
  t: convert grep assertions to test_grep
  t: add greplint to detect bare grep assertions

 t/.gitattributes                              |   2 +
 t/Makefile                                    |  29 +-
 t/README                                      |  34 ++
 t/chainlint.pl                                | 529 +----------------
 t/for-each-ref-tests.sh                       |  12 +-
 t/greplint-cat.pl                             |  27 +
 t/greplint.pl                                 | 258 +++++++++
 t/greplint/bare-grep-after-and.expect         |   1 +
 t/greplint/bare-grep-after-and.test           |   4 +
 t/greplint/bare-grep-after-semicolon.expect   |   1 +
 t/greplint/bare-grep-after-semicolon.test     |   4 +
 t/greplint/bare-grep-compound-body.expect     |   3 +
 t/greplint/bare-grep-compound-body.test       |  17 +
 t/greplint/bare-grep-count-mode.expect        |   1 +
 t/greplint/bare-grep-count-mode.test          |   3 +
 t/greplint/bare-grep-explicit-pattern.expect  |   1 +
 t/greplint/bare-grep-explicit-pattern.test    |   3 +
 t/greplint/bare-grep-flags.expect             |   1 +
 t/greplint/bare-grep-flags.test               |   3 +
 t/greplint/bare-grep-lint-ok.expect           |   0
 t/greplint/bare-grep-lint-ok.test             |   4 +
 t/greplint/bare-grep-negated.expect           |   1 +
 t/greplint/bare-grep-negated.test             |   3 +
 t/greplint/bare-grep-pattern-file.expect      |   1 +
 t/greplint/bare-grep-pattern-file.test        |   3 +
 t/greplint/bare-grep-simple.expect            |   1 +
 t/greplint/bare-grep-simple.test              |   3 +
 t/greplint/bare-grep-subshell.expect          |   1 +
 t/greplint/bare-grep-subshell.test            |   5 +
 .../dqstring-continuation-offset.expect       |   1 +
 t/greplint/dqstring-continuation-offset.test  |  11 +
 t/greplint/filter-command-substitution.expect |   0
 t/greplint/filter-command-substitution.test   |   3 +
 t/greplint/filter-pipe-input.expect           |   0
 t/greplint/filter-pipe-input.test             |   3 +
 t/greplint/filter-pipe-output.expect          |   0
 t/greplint/filter-pipe-output.test            |   3 +
 t/greplint/filter-redirect-output.expect      |   0
 t/greplint/filter-redirect-output.test        |   3 +
 t/greplint/filter-stdin-redirect.expect       |   0
 t/greplint/filter-stdin-redirect.test         |   3 +
 t/greplint/grep-as-argument.expect            |   0
 t/greplint/grep-as-argument.test              |   3 +
 t/greplint/grep-as-value.expect               |   0
 t/greplint/grep-as-value.test                 |   6 +
 t/greplint/wrong-negation.expect              |   1 +
 t/greplint/wrong-negation.test                |   3 +
 t/lib-bitmap.sh                               |  12 +-
 t/lib-bundle-uri-protocol.sh                  |  26 +-
 t/lib-httpd.sh                                |   2 +-
 t/lib-shell-parser.pl                         | 534 ++++++++++++++++++
 t/pack-refs-tests.sh                          |   2 +-
 t/show-ref-exists-tests.sh                    |   2 +-
 t/t0000-basic.sh                              |  16 +-
 t/t0001-init.sh                               |  18 +-
 t/t0008-ignores.sh                            |   8 +-
 t/t0009-git-dir-validation.sh                 |   6 +-
 t/t0012-help.sh                               |   4 +-
 t/t0013-sha1dc.sh                             |   2 +-
 t/t0017-env-helper.sh                         |   4 +-
 t/t0021-conversion.sh                         |  18 +-
 t/t0029-core-unsetenvvars.sh                  |   4 +-
 t/t0030-stripspace.sh                         |   4 +-
 t/t0031-lockfile-pid.sh                       |   2 +-
 t/t0040-parse-options.sh                      |  52 +-
 t/t0041-usage.sh                              |   2 +-
 t/t0052-simple-ipc.sh                         |  10 +-
 t/t0061-run-command.sh                        |   2 +-
 t/t0066-dir-iterator.sh                       |   2 +-
 t/t0068-for-each-repo.sh                      |  16 +-
 t/t0070-fundamental.sh                        |   6 +-
 t/t0081-find-pack.sh                          |  12 +-
 t/t0091-bugreport.sh                          |  18 +-
 t/t0092-diagnose.sh                           |  12 +-
 t/t0100-previous.sh                           |   2 +-
 t/t0200-gettext-basic.sh                      |  14 +-
 t/t0203-gettext-setlocale-sanity.sh           |   4 +-
 t/t0204-gettext-reencode-sanity.sh            |   8 +-
 t/t0210-trace2-normal.sh                      |   6 +-
 t/t0211-trace2-perf.sh                        |  80 +--
 t/t0212-trace2-event.sh                       |   8 +-
 t/t0300-credentials.sh                        |   4 +-
 t/t0410-partial-clone.sh                      |  82 +--
 t/t0450-txt-doc-vs-help.sh                    |   2 +-
 t/t0500-progress-display.sh                   |  18 +-
 t/t0610-reftable-basics.sh                    |   8 +-
 t/t1004-read-tree-m-u-wf.sh                   |   8 +-
 t/t1006-cat-file.sh                           |  18 +-
 t/t1007-hash-object.sh                        |   8 +-
 t/t1011-read-tree-sparse-checkout.sh          |  10 +-
 t/t1050-large.sh                              |   6 +-
 t/t1091-sparse-checkout-builtin.sh            |  24 +-
 t/t1092-sparse-checkout-compatibility.sh      |  44 +-
 t/t1300-config.sh                             |  16 +-
 t/t1305-config-include.sh                     |   2 +-
 t/t1308-config-set.sh                         |   6 +-
 t/t1400-update-ref.sh                         | 173 +++---
 t/t1403-show-ref.sh                           |  18 +-
 t/t1410-reflog.sh                             |   4 +-
 t/t1415-worktree-refs.sh                      |   4 +-
 t/t1430-bad-ref-name.sh                       |  56 +-
 t/t1450-fsck.sh                               |  12 +-
 t/t1451-fsck-buffer.sh                        |   6 +-
 t/t1460-refs-migrate.sh                       |   2 +-
 t/t1500-rev-parse.sh                          |   6 +-
 t/t1502-rev-parse-parseopt.sh                 |   2 +-
 t/t1503-rev-parse-verify.sh                   |  10 +-
 t/t1510-repo-setup.sh                         |  10 +-
 t/t1512-rev-parse-disambiguation.sh           |   4 +-
 t/t1515-rev-parse-outside-repo.sh             |   2 +-
 t/t1800-hook.sh                               |  18 +-
 t/t2004-checkout-cache-temp.sh                |   4 +-
 t/t2019-checkout-ambiguous-ref.sh             |   4 +-
 t/t2024-checkout-dwim.sh                      |   8 +-
 t/t2030-unresolve-info.sh                     |   6 +-
 t/t2060-switch.sh                             |   6 +-
 t/t2070-restore.sh                            |   2 +-
 t/t2080-parallel-checkout-basics.sh           |  14 +-
 t/t2081-parallel-checkout-collisions.sh       |  24 +-
 t/t2082-parallel-checkout-attributes.sh       |  12 +-
 t/t2103-update-index-ignore-missing.sh        |   6 +-
 t/t2200-add-update.sh                         |   2 +-
 t/t2203-add-intent.sh                         |   6 +-
 t/t2400-worktree-add.sh                       |  24 +-
 t/t2402-worktree-list.sh                      |  16 +-
 t/t2403-worktree-move.sh                      |   6 +-
 t/t2405-worktree-submodule.sh                 |   6 +-
 t/t2407-worktree-heads.sh                     |  26 +-
 t/t2500-untracked-overwriting.sh              |   8 +-
 t/t2501-cwd-empty.sh                          |   4 +-
 t/t3001-ls-files-others-exclude.sh            |   6 +-
 t/t3007-ls-files-recurse-submodules.sh        |   6 +-
 t/t3200-branch.sh                             |  12 +-
 t/t3202-show-branch.sh                        |  10 +-
 t/t3203-branch-output.sh                      |   4 +-
 t/t3206-range-diff.sh                         |  78 +--
 t/t3207-branch-submodule.sh                   |   4 +-
 t/t3301-notes.sh                              |  32 +-
 t/t3310-notes-merge-manual-resolve.sh         |  16 +-
 t/t3320-notes-merge-worktrees.sh              |   2 +-
 t/t3400-rebase.sh                             |  16 +-
 t/t3402-rebase-merge.sh                       |  16 +-
 t/t3404-rebase-interactive.sh                 |  72 +--
 t/t3406-rebase-message.sh                     |   6 +-
 t/t3415-rebase-autosquash.sh                  |  10 +-
 t/t3416-rebase-onto-threedots.sh              |   4 +-
 t/t3418-rebase-continue.sh                    |  10 +-
 t/t3420-rebase-autostash.sh                   |  24 +-
 t/t3422-rebase-incompatible-options.sh        |   4 +-
 t/t3429-rebase-edit-todo.sh                   |   2 +-
 t/t3430-rebase-merges.sh                      |  32 +-
 t/t3500-cherry.sh                             |   4 +-
 t/t3501-revert-cherry-pick.sh                 |   6 +-
 t/t3504-cherry-pick-rerere.sh                 |   6 +-
 t/t3510-cherry-pick-sequence.sh               |  24 +-
 t/t3602-rm-sparse-checkout.sh                 |   4 +-
 t/t3705-add-sparse-checkout.sh                |  10 +-
 t/t3800-mktag.sh                              |   4 +-
 t/t3901-i18n-patch.sh                         |  16 +-
 t/t3903-stash.sh                              |  28 +-
 t/t3904-stash-patch.sh                        |   4 +-
 t/t3908-stash-in-worktree.sh                  |   2 +-
 t/t4000-diff-format.sh                        |   2 +-
 t/t4001-diff-rename.sh                        |   4 +-
 t/t4011-diff-symlink.sh                       |   2 +-
 t/t4013-diff-various.sh                       |   2 +-
 t/t4014-format-patch.sh                       | 344 +++++------
 t/t4015-diff-whitespace.sh                    |  16 +-
 t/t4017-diff-retval.sh                        |   2 +-
 t/t4018-diff-funcname.sh                      |   2 +-
 t/t4019-diff-wserror.sh                       |   8 +-
 t/t4020-diff-external.sh                      |  18 +-
 t/t4021-format-patch-numbered.sh              |   4 +-
 t/t4022-diff-rewrite.sh                       |  14 +-
 t/t4028-format-patch-mime-headers.sh          |   6 +-
 t/t4031-diff-rewrite-binary.sh                |  18 +-
 t/t4033-diff-patience.sh                      |   2 +-
 t/t4036-format-patch-signer-mime.sh           |   6 +-
 t/t4038-diff-combined.sh                      |   6 +-
 t/t4051-diff-function-context.sh              |  38 +-
 t/t4053-diff-no-index.sh                      |   4 +-
 t/t4063-diff-blobs.sh                         |   2 +-
 t/t4065-diff-anchored.sh                      |  26 +-
 t/t4067-diff-partial-clone.sh                 |  12 +-
 t/t4073-diff-stat-name-width.sh               |  24 +-
 t/t4103-apply-binary.sh                       |   2 +-
 t/t4120-apply-popt.sh                         |   2 +-
 t/t4124-apply-ws-rule.sh                      |  10 +-
 t/t4128-apply-root.sh                         |   2 +-
 t/t4140-apply-ita.sh                          |   4 +-
 t/t4141-apply-too-large.sh                    |   2 +-
 t/t4150-am.sh                                 |  48 +-
 t/t4200-rerere.sh                             |   6 +-
 t/t4201-shortlog.sh                           |   2 +-
 t/t4202-log.sh                                |  84 +--
 t/t4204-patch-id.sh                           |   2 +-
 t/t4205-log-pretty-formats.sh                 |   2 +-
 t/t4209-log-pickaxe.sh                        |  10 +-
 t/t4211-line-log.sh                           |  72 +--
 t/t4216-log-bloom.sh                          |  18 +-
 t/t4252-am-options.sh                         |  22 +-
 t/t4254-am-corrupt.sh                         |   6 +-
 t/t4258-am-quoted-cr.sh                       |   2 +-
 t/t4301-merge-tree-write-tree.sh              |  18 +-
 t/t5000-tar-tree.sh                           |  10 +-
 t/t5004-archive-corner-cases.sh               |   2 +-
 t/t5100-mailinfo.sh                           |   2 +-
 t/t5150-request-pull.sh                       |  18 +-
 t/t5300-pack-object.sh                        |  22 +-
 t/t5302-pack-index.sh                         |   6 +-
 t/t5304-prune.sh                              |   8 +-
 t/t5310-pack-bitmaps.sh                       |  14 +-
 t/t5317-pack-objects-filter-objects.sh        |  12 +-
 t/t5318-commit-graph.sh                       |   8 +-
 t/t5319-multi-pack-index.sh                   |  16 +-
 t/t5324-split-commit-graph.sh                 |  10 +-
 t/t5325-reverse-index.sh                      |   2 +-
 t/t5326-multi-pack-bitmaps.sh                 |  28 +-
 t/t5328-commit-graph-64bit-time.sh            |   2 +-
 t/t5329-pack-objects-cruft.sh                 |   8 +-
 t/t5334-incremental-multi-pack-index.sh       |   2 +-
 t/t5335-compact-multi-pack-index.sh           |   4 +-
 t/t5351-unpack-large-objects.sh               |   2 +-
 t/t5402-post-merge-hook.sh                    |   4 +-
 t/t5403-post-checkout-hook.sh                 |   2 +-
 t/t5404-tracking-branches.sh                  |   2 +-
 t/t5406-remote-rejects.sh                     |   2 +-
 t/t5407-post-rewrite-hook.sh                  |   8 +-
 t/t5409-colorize-remote-messages.sh           |  36 +-
 t/t5500-fetch-pack.sh                         |  38 +-
 t/t5504-fetch-receive-strict.sh               |  14 +-
 t/t5505-remote.sh                             |  20 +-
 t/t5510-fetch.sh                              |  10 +-
 t/t5512-ls-remote.sh                          |   8 +-
 t/t5514-fetch-multiple.sh                     |   2 +-
 t/t5516-fetch-push.sh                         |  20 +-
 t/t5520-pull.sh                               |   4 +-
 t/t5524-pull-msg.sh                           |   6 +-
 t/t5526-fetch-submodules.sh                   |  16 +-
 t/t5529-push-errors.sh                        |   4 +-
 t/t5530-upload-pack-error.sh                  |  18 +-
 t/t5531-deep-submodule-push.sh                |   2 +-
 t/t5532-fetch-proxy.sh                        |   2 +-
 t/t5533-push-cas.sh                           |  12 +-
 t/t5534-push-signed.sh                        |  22 +-
 t/t5537-fetch-shallow.sh                      |   2 +-
 t/t5538-push-shallow.sh                       |   2 +-
 t/t5539-fetch-http-shallow.sh                 |   4 +-
 t/t5541-http-push-smart.sh                    |  32 +-
 t/t5544-pack-objects-hook.sh                  |  12 +-
 t/t5550-http-fetch-dumb.sh                    |   4 +-
 t/t5551-http-fetch-smart.sh                   |  46 +-
 t/t5552-skipping-fetch-negotiator.sh          |   6 +-
 t/t5554-noop-fetch-negotiator.sh              |   4 +-
 t/t5557-http-get.sh                           |   2 +-
 t/t5558-clone-bundle-uri.sh                   |  38 +-
 t/t5562-http-backend-content-length.sh        |   2 +-
 t/t5564-http-proxy.sh                         |  10 +-
 t/t5581-http-curl-verbose.sh                  |   2 +-
 t/t5583-push-branches.sh                      |   8 +-
 t/t5601-clone.sh                              |  28 +-
 t/t5604-clone-reference.sh                    |   8 +-
 t/t5605-clone-local.sh                        |   2 +-
 t/t5606-clone-options.sh                      |   6 +-
 t/t5612-clone-refspec.sh                      |   2 +-
 t/t5616-partial-clone.sh                      |  60 +-
 t/t5619-clone-local-ambiguous-transport.sh    |   2 +-
 t/t5620-backfill.sh                           |  12 +-
 t/t5700-protocol-v1.sh                        |  46 +-
 t/t5701-git-serve.sh                          |  14 +-
 t/t5702-protocol-v2.sh                        | 154 ++---
 t/t5703-upload-pack-ref-in-want.sh            |  22 +-
 t/t5705-session-id-in-capabilities.sh         |  12 +-
 t/t5750-bundle-uri-parse.sh                   |   8 +-
 t/t5801-remote-helpers.sh                     |   4 +-
 t/t5810-proto-disable-local.sh                |   2 +-
 t/t5813-proto-disable-ssh.sh                  |   4 +-
 t/t6000-rev-list-misc.sh                      |  26 +-
 t/t6005-rev-list-count.sh                     |   8 +-
 t/t6006-rev-list-format.sh                    |   4 +-
 t/t6009-rev-list-parent.sh                    |   4 +-
 t/t6020-bundle-misc.sh                        |  12 +-
 t/t6022-rev-list-missing.sh                   |   4 +-
 t/t6030-bisect-porcelain.sh                   | 150 ++---
 t/t6040-tracking-info.sh                      |   2 +-
 t/t6112-rev-list-filters-objects.sh           |  24 +-
 t/t6115-rev-list-du.sh                        |   4 +-
 t/t6120-describe.sh                           |  14 +-
 t/t6200-fmt-merge-msg.sh                      |  82 +--
 t/t6402-merge-rename.sh                       |   4 +-
 t/t6403-merge-file.sh                         |   6 +-
 t/t6404-recursive-merge.sh                    |   2 +-
 t/t6406-merge-attr.sh                         |  20 +-
 t/t6417-merge-ours-theirs.sh                  |  30 +-
 t/t6418-merge-text-auto.sh                    |   2 +-
 t/t6422-merge-rename-corner-cases.sh          |   8 +-
 t/t6423-merge-rename-directories.sh           |  72 +--
 t/t6424-merge-unrelated-index-changes.sh      |   6 +-
 t/t6427-diff3-conflict-markers.sh             |  10 +-
 t/t6432-merge-recursive-space-options.sh      |   4 +-
 t/t6436-merge-overwrite.sh                    |   6 +-
 t/t6437-submodule-merge.sh                    |  10 +-
 t/t6500-gc.sh                                 |   8 +-
 t/t6600-test-reach.sh                         |   4 +-
 t/t7001-mv.sh                                 |  16 +-
 t/t7002-mv-sparse-checkout.sh                 |  38 +-
 t/t7003-filter-branch.sh                      |  16 +-
 t/t7004-tag.sh                                |   2 +-
 t/t7006-pager.sh                              |  16 +-
 t/t7012-skip-worktree-writing.sh              |   6 +-
 t/t7030-verify-tag.sh                         |  52 +-
 t/t7031-verify-tag-signed-ssh.sh              |  46 +-
 t/t7102-reset.sh                              |   2 +-
 t/t7110-reset-merge.sh                        |  40 +-
 t/t7201-co.sh                                 |   6 +-
 t/t7300-clean.sh                              |   2 +-
 t/t7301-clean-interactive.sh                  |   2 +-
 t/t7400-submodule-basic.sh                    |  32 +-
 t/t7402-submodule-rebase.sh                   |   2 +-
 t/t7406-submodule-update.sh                   |  26 +-
 t/t7416-submodule-dash-url.sh                 |  20 +-
 t/t7417-submodule-path-url.sh                 |   2 +-
 t/t7450-bad-git-dotfiles.sh                   |  20 +-
 t/t7501-commit-basic-functionality.sh         |  16 +-
 t/t7502-commit-porcelain.sh                   |   2 +-
 t/t7507-commit-verbose.sh                     |   6 +-
 t/t7508-status.sh                             |   6 +-
 t/t7510-signed-commit.sh                      |  68 +--
 t/t7516-commit-races.sh                       |   4 +-
 t/t7519-status-fsmonitor.sh                   |  14 +-
 t/t7527-builtin-fsmonitor.sh                  |  82 +--
 t/t7528-signed-commit-ssh.sh                  |  68 +--
 t/t7600-merge.sh                              |  10 +-
 t/t7603-merge-reduce-heads.sh                 |  20 +-
 t/t7606-merge-custom.sh                       |   2 +-
 t/t7607-merge-state.sh                        |   4 +-
 t/t7610-mergetool.sh                          |  18 +-
 t/t7700-repack.sh                             |  14 +-
 t/t7703-repack-geometric.sh                   |   4 +-
 t/t7704-repack-cruft.sh                       |  12 +-
 t/t7800-difftool.sh                           |  26 +-
 t/t7810-grep.sh                               |  22 +-
 t/t7814-grep-recurse-submodules.sh            |   2 +-
 t/t7900-maintenance.sh                        |  34 +-
 t/t8008-blame-formats.sh                      |   2 +-
 t/t8010-cat-file-filters.sh                   |   2 +-
 t/t8012-blame-colors.sh                       |   2 +-
 t/t9001-send-email.sh                         | 190 +++----
 t/t9003-help-autocorrect.sh                   |   6 +-
 t/t9106-git-svn-commit-diff-clobber.sh        |   2 +-
 t/t9107-git-svn-migrate.sh                    |  30 +-
 t/t9110-git-svn-use-svm-props.sh              |  20 +-
 t/t9111-git-svn-use-svnsync-props.sh          |  18 +-
 t/t9114-git-svn-dcommit-merge.sh              |   6 +-
 t/t9116-git-svn-log.sh                        |   8 +-
 t/t9117-git-svn-init-clone.sh                 |  12 +-
 t/t9119-git-svn-info.sh                       |  16 +-
 t/t9122-git-svn-author.sh                     |   8 +-
 t/t9130-git-svn-authors-file.sh               |   8 +-
 t/t9138-git-svn-authors-prog.sh               |  14 +-
 t/t9140-git-svn-reset.sh                      |   4 +-
 t/t9153-git-svn-rewrite-uuid.sh               |   4 +-
 t/t9200-git-cvsexportcommit.sh                |   2 +-
 t/t9210-scalar.sh                             |  34 +-
 t/t9211-scalar-clone.sh                       |  16 +-
 t/t9300-fast-import.sh                        |  10 +-
 t/t9350-fast-export.sh                        |  54 +-
 t/t9351-fast-export-anonymize.sh              |  36 +-
 t/t9400-git-cvsserver-server.sh               |   4 +-
 t/t9501-gitweb-standalone-http-status.sh      |  58 +-
 t/t9502-gitweb-standalone-parse-output.sh     |  38 +-
 t/t9800-git-p4-basic.sh                       |  10 +-
 t/t9801-git-p4-branch.sh                      |  48 +-
 t/t9806-git-p4-options.sh                     |  10 +-
 t/t9807-git-p4-submit.sh                      |   2 +-
 t/t9810-git-p4-rcs.sh                         |   8 +-
 t/t9813-git-p4-preserve-users.sh              |   8 +-
 t/t9814-git-p4-rename.sh                      |   8 +-
 t/t9827-git-p4-change-filetype.sh             |   4 +-
 t/t9832-unshelve.sh                           |   6 +-
 t/t9833-errors.sh                             |   4 +-
 t/t9835-git-p4-metadata-encoding-python2.sh   |  36 +-
 t/t9836-git-p4-metadata-encoding-python3.sh   |  38 +-
 t/t9850-shell.sh                              |   2 +-
 t/t9902-completion.sh                         |  26 +-
 385 files changed, 3810 insertions(+), 3328 deletions(-)
 create mode 100644 t/greplint-cat.pl
 create mode 100644 t/greplint.pl
 create mode 100644 t/greplint/bare-grep-after-and.expect
 create mode 100644 t/greplint/bare-grep-after-and.test
 create mode 100644 t/greplint/bare-grep-after-semicolon.expect
 create mode 100644 t/greplint/bare-grep-after-semicolon.test
 create mode 100644 t/greplint/bare-grep-compound-body.expect
 create mode 100644 t/greplint/bare-grep-compound-body.test
 create mode 100644 t/greplint/bare-grep-count-mode.expect
 create mode 100644 t/greplint/bare-grep-count-mode.test
 create mode 100644 t/greplint/bare-grep-explicit-pattern.expect
 create mode 100644 t/greplint/bare-grep-explicit-pattern.test
 create mode 100644 t/greplint/bare-grep-flags.expect
 create mode 100644 t/greplint/bare-grep-flags.test
 create mode 100644 t/greplint/bare-grep-lint-ok.expect
 create mode 100644 t/greplint/bare-grep-lint-ok.test
 create mode 100644 t/greplint/bare-grep-negated.expect
 create mode 100644 t/greplint/bare-grep-negated.test
 create mode 100644 t/greplint/bare-grep-pattern-file.expect
 create mode 100644 t/greplint/bare-grep-pattern-file.test
 create mode 100644 t/greplint/bare-grep-simple.expect
 create mode 100644 t/greplint/bare-grep-simple.test
 create mode 100644 t/greplint/bare-grep-subshell.expect
 create mode 100644 t/greplint/bare-grep-subshell.test
 create mode 100644 t/greplint/dqstring-continuation-offset.expect
 create mode 100644 t/greplint/dqstring-continuation-offset.test
 create mode 100644 t/greplint/filter-command-substitution.expect
 create mode 100644 t/greplint/filter-command-substitution.test
 create mode 100644 t/greplint/filter-pipe-input.expect
 create mode 100644 t/greplint/filter-pipe-input.test
 create mode 100644 t/greplint/filter-pipe-output.expect
 create mode 100644 t/greplint/filter-pipe-output.test
 create mode 100644 t/greplint/filter-redirect-output.expect
 create mode 100644 t/greplint/filter-redirect-output.test
 create mode 100644 t/greplint/filter-stdin-redirect.expect
 create mode 100644 t/greplint/filter-stdin-redirect.test
 create mode 100644 t/greplint/grep-as-argument.expect
 create mode 100644 t/greplint/grep-as-argument.test
 create mode 100644 t/greplint/grep-as-value.expect
 create mode 100644 t/greplint/grep-as-value.test
 create mode 100644 t/greplint/wrong-negation.expect
 create mode 100644 t/greplint/wrong-negation.test
 create mode 100644 t/lib-shell-parser.pl


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2135%2Fmmontalbo%2Fmm%2Ftest-grep-docs-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2135/mmontalbo/mm/test-grep-docs-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2135

Range-diff vs v3:

 1:  ec6b478c4c ! 1:  44d5db91bc t/README: document test_grep helper
     @@ t/README: see test-lib-functions.sh for the full list and their options.
      +   'grep' is the right choice because the exit code is not the
      +   assertion itself.
      +
     -+   test_grep requires <file> to exist and will BUG otherwise.
     -+   When a file's presence is conditional (a backend-specific
     -+   file, or a path that only exists on some platforms, such as
     -+   an NTFS 8.3 short name), keep a plain guarded 'grep' instead.
     ++   test_grep requires <file> to exist and will BUG otherwise, so
     ++   use it only where the file is guaranteed to exist at that point.
     ++   When a file's presence is conditional (a backend-specific file,
     ++   or a path that only exists on some platforms, such as an NTFS
     ++   8.3 short name), guard the assertion on that condition (a
     ++   prerequisite, or a 'test -e' on the path) and use test_grep
     ++   inside the guard:
     ++
     ++	if test_have_prereq REFFILES
     ++	then
     ++		test_grep ! "$refname" .git/packed-refs
     ++	fi
      +
        - test_path_is_file <path>
          test_path_is_dir <path>
 2:  7a837b77cd = 2:  44ba6d1f1a t: fix grep assertions missing file arguments
 3:  5894ca1724 = 3:  8f3ebe6426 t: extract chainlint's parser into shared module
 4:  416c95fee5 = 4:  5689d2074a t: fix Lexer line count for $() inside double-quoted strings
 5:  7518445733 ! 5:  53fedba4d4 t: convert grep assertions to test_grep
     @@ Commit message
          exists only with the files backend, so its check is guarded with a
          REFFILES prerequisite; the backend-agnostic 'git show-ref' check
          that follows still runs under every backend.  In t7450 'git~2' is
     -    the NTFS 8.3 short name of a decoy '..git' file and only exists
     -    when 8.3 short-name generation is enabled; that '! grep' tolerates
     -    the missing file on purpose, so it is left as-is with a
     -    "# lint-ok" annotation rather than converted (a plain test_grep
     -    would BUG when the short name is absent).
     +    the NTFS 8.3 short name of a '..git' file and only exists
     +    when 8.3 short-name generation is enabled, so its check is guarded
     +    with a 'test -f' on the path and uses test_grep inside the guard,
     +    the same shape as t1400 (a plain test_grep would BUG when the
     +    short name is absent).
      
          The conversion was generated using a grep-assertion linter
          (greplint.pl, added in the following commit) to identify bare
     @@ Commit message
              #      test_must_fail git show-ref --verify -q $m
              #
              # t7450: git~2 is an NTFS 8.3 short name that exists only when
     -        # short-name generation is enabled, so this stays a missing-file-
     -        # tolerant '! grep'; add a comment plus "# lint-ok" so the linter
     -        # skips it.
     +        # short-name generation is enabled, so guard the check on its
     +        # presence with 'test -f' and note in a comment why the path can
     +        # be absent (a plain test_grep would BUG when it is):
     +        #
     +        #  -   ! grep gitdir squatting-clone/d/a/git~2
     +        #  +   if test -f squatting-clone/d/a/git~2
     +        #  +   then
     +        #  +           test_grep ! gitdir squatting-clone/d/a/git~2
     +        #  +   fi
      
              # Step 2: reorder pre-existing '! test_grep' to 'test_grep !'
              # (must come before steps 3-4 so greplint does not see them)
     @@ t/t7450-bad-git-dotfiles.sh: test_expect_success WINDOWS 'prevent git~1 squattin
       			clone --recurse-submodules squatting squatting-clone 2>err &&
       		test_grep -e "directory not empty" -e "not an empty directory" err &&
      -		! grep gitdir squatting-clone/d/a/git~2
     -+		# git~2 is the 8.3 short name of the ..git decoy, present
     -+		# only when 8.3 name generation is on; a missing git~2 is
     -+		# fine because the "directory not empty" check above is the
     -+		# real assertion.
     -+		! grep gitdir squatting-clone/d/a/git~2 # lint-ok: 8.3 short name git~2 may not exist
     ++		# git~2 is an 8.3 short name, present only when 8.3 name
     ++		# generation is enabled. The "directory not empty" check
     ++		# above is the primary assertion.
     ++		if test -f squatting-clone/d/a/git~2
     ++		then
     ++			test_grep ! gitdir squatting-clone/d/a/git~2
     ++		fi
       	fi
       '
       
 6:  3b12a959fd ! 6:  5cda64fc26 t: add greplint to detect bare grep assertions
     @@ t/greplint.pl (new)
      +	return 1;
      +}
      +
     -+# Some bare greps are intentional (e.g. file may not exist,
     -+# data filter).  A '# lint-ok' annotation on the source line
     -+# suppresses the warning.
     ++# lint_ok() reports whether a bare grep carries a trailing
     ++# '# lint-ok' comment telling this linter to skip it.
     ++#
     ++# In practice this is needed for just one case: a grep acting
     ++# as a data filter whose output is consumed by a redirect or
     ++# pipe on an enclosing compound command (such as a subshell or
     ++# brace group) rather than by grep's own pipeline, e.g.
     ++#
     ++#	( grep ... && # lint-ok
     ++#	  sed ... ) >out
     ++#
     ++#	{ grep ... || : # lint-ok
     ++#	} >out
     ++#
     ++# is_filter() only scans grep's own pipeline: it stops at the
     ++# separator before the compound command closes and never sees
     ++# the outer redirect, so it would flag such a grep as an
     ++# assertion.  A grep that really is an assertion is better
     ++# written as test_grep (or a guarded test_grep when the file's
     ++# presence is conditional) than annotated with lint-ok.
      +sub lint_ok {
      +	my ($raw_lines, $ln) = @_;
      +	if ($ln < 1 || $ln > @$raw_lines) {

-- 
gitgitgadget
