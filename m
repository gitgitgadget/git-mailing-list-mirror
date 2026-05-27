Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A93B7B66
	for <git@vger.kernel.org>; Wed, 27 May 2026 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913251; cv=pass; b=PtDvNRPREm4/uPU+bJiGiJ84/5fLxp67x0tcCfoJ+E1paA+kCyZv21isU2sLOFuSa4AMxks5hYmVntf6Fi8w9aRMn4yh+hQ2HZ7V+nL1AmIb0eBteYyIcrIEIUbGtehhjX5HVD+aMMQW+3dl20iLE4cHB47fBLNvtBasi6kHfcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913251; c=relaxed/simple;
	bh=MI5yG+deUk1iSrmzloiyEoKEHo34N/EJqJKLBXE8M1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlTCjhZqSdBccVtBsOQUpffhpbwPNNw9bmPeNpLG0g2jhm86OJzq2xxqZHiXiSN7aPZpEl2mXx/yPTNPSL1MM0dEPyMHgeuDVmNuhgaCjFUGvJ7ua6FTUcW2QGzqYncw8eLPlNtHk96Q4zCczdxO1BeyjsccV/0pVCvpoapZzLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5jlGYK1; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5jlGYK1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so8764363a12.3
        for <git@vger.kernel.org>; Wed, 27 May 2026 13:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779913249; cv=none;
        d=google.com; s=arc-20240605;
        b=MDgMtmhNuhzQeKpkZKmGyabXSQZQuPyKqJ05mshNnUP2OPVBflB+vvbGgpuE9M6Z86
         PZIBNrA+9ySUkqwbkTWkZzdIVdez68Tb7/8je4sq8CkQyXf0AEzK506YG6ehpDFQPt/R
         3RhSpIHg700cdSfvYT1v4ZaC4ee+dTpnpOfFKQCNP185gIhyWENsGJqwxCVEg3Rz8DHi
         Qng8XYNic/NeptRQAD7ScpCjrcuQ7cThvphFpew1y+ST6F2+4KFmf7+S+aBSxc4GU5VI
         TS0LorNRu+mEo2KpGvbGILMgD2G26zdNCb/apkaV5tnnfX3LMRT2w2f/hPztOrhJNcu/
         uvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mIbdKw6ouJ1vZnlDKzIZ1rKFQFGFBLTyiAKOt3DwKPE=;
        fh=pBkNBsI4sm7Q4IEH/pHj2bTSCi7U0DK00WqphPWss7o=;
        b=EplPvN6f3dQnMNh4x1Aj4Ay1bm07rKymeNcQsRbc0ali3MNLeh6D5bZqOrDDUa+wMd
         bdl2N6kJsr4y+sgAUC9UCMI1gSCn+ygxRSNC3oKIMkvvoCJs2lwvUHeiFFmMbLwOtomg
         guCol5/X+QSReyx4MCmvs8EMx5SRF2yXLbgA0oHWWgx6zoRsPBRUcfc/YFun5PNbCJIw
         XQG5rOdUVC2nvwqwzeajQzz88ctAIFkeKrv340rqB9ghR2tQLcm66qt5j6OGATzKKtQY
         xoL88hImGiGyO2DRuBGAcPMPG95oKtkCEVYWHh2/vFXnox+GY9MCWxE/G3hiCWjv6cko
         7azA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779913249; x=1780518049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIbdKw6ouJ1vZnlDKzIZ1rKFQFGFBLTyiAKOt3DwKPE=;
        b=s5jlGYK1ONaGSclqLWJSB6GjKMdJbib7AY8TnBkav0OVO//wn6CII637K87KukYx5y
         Iy+hQ02MNrTPtIE8QcFeH7Te1vc396irEZhOYQg+ejTinkemPYqBRStT78wGXnY6CzXv
         34Z+Q65KaBMoLtUvxofdyrsnrumi1MDA/KWqohH8srjPu+c3lhkUQhWOuJNXtf2lBch6
         0ptVe7YA89j6RDD5EKLBrZ8AC90JWWDio1KTGUgl2DKRlXqYoIq8IK7mv/NrJpzsfNsf
         j1ObY3oK5H0kJNWUwGak+YDauOBTREE0MLihVxDt50NeVXbTdvYwPYHstrLyWQsj8g4S
         JlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913249; x=1780518049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIbdKw6ouJ1vZnlDKzIZ1rKFQFGFBLTyiAKOt3DwKPE=;
        b=EyRUbVnKGRjlXP/UYbHx9P8tfZCJxmgYaHARJ+ciK8TA11oE1ZRS36ZFV/ntttLg2v
         Hp+qv7vBDj5GzF+sgsH/L5E9FWyI4H+DhEFrQ/itXMuNHHyNT40ik/vKh0WM3DkPl4J5
         wJauRsFW6R/JhoDeXbhKjnKIBmyt0KWKS6PL6mKoipXouAn9STxIFDj3KSzT2FxuwGWH
         swZ3bDlpjekYTfIjWTQfdd/WDLp7DG1vP45Ura9t/DPJnAobb3hf6uU/Zup7EK3sBtm2
         Ul1ZWS8+2ddDU2UvOLANPD9PREHDYk8/hI2v3GsszkRuvYQqJO5GyIXB6yvtqhl61HtX
         P4FA==
X-Gm-Message-State: AOJu0Yz35lAeatIC/Klj2P2Qeo1mJQQwkOJTK+HVX7wt0gB9MxwzL/co
	zO+YBDzXfx3rdO1VeXr+rZ9NiWQTVm5PyTqK8ZEh9K3F4SgTchuswI8zhVkEN9VNIzO9MGDq/8u
	8HrF6MoNtGqHwljMavceMeEYgwcNnKdg=
X-Gm-Gg: Acq92OFv4TUa/YWMJnMSDKCAd+La2JopVD25WD+e4tW3lTE58nBK/Fqhb0rVQDgMW8F
	6TkpqwFVNPf6XTN0HjxunkuPGtgHllYC+FzeVAcQJVKFcBTr/0ifju4qpYpLHWIjVtHxbi5vl7C
	MiCml2NqsmVZEsl1ODIzyRLwI0wuPSXl94VqShZpUW287TKi2meoD2Oexz6+MQhedin5iyUbLmg
	yAd8HtwGDFiAGrg+8q8e2qZ15AnBM7OJBLbf57CzXXlHAuRWpkr13qVUutA1bzPORQHmaqYwneU
	t86Yfr041t3f6DR1CVlnj9iI7aXRPOl89xhByKC6pFgqDJhHVNyuc0uDH9aoqezfQxgu1005PtR
	8iUKhwi3HSordT3g=
X-Received: by 2002:a05:6a00:4482:b0:82f:a89e:e16f with SMTP id
 d2e1a72fcca58-8415f3fdbd5mr22778125b3a.14.1779913249273; Wed, 27 May 2026
 13:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2094.git.1777349126.gitgitgadget@gmail.com> <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
In-Reply-To: <pull.2094.v2.git.1779738059.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 27 May 2026 16:20:37 -0400
X-Gm-Features: AVHnY4IBzL_HJy41geeav8mTdcYnO3fMgnQosFwRu0sLmFG6r_V_lUVqewN36kA
Message-ID: <CALnO6CA5GPS2CMv_x_=wOPBgspe31FkW=h832GCBpAUbBoJNLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] line-log: integrate -L with the standard log
 output pipeline
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 3:41=E2=80=AFPM Michael Montalbo via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Since its introduction, git log -L has short-circuited from
> log_tree_commit() into its own output function, bypassing log_tree_diff()
> and log_tree_diff_flush(). This skips no_free save/restore,
> always_show_header, diff_free() cleanup, and means that pickaxe (-S, -G,
> --find-object) and --diff-filter cannot suppress commits whose pairs are =
all
> filtered out, because show_log() runs before diffcore_std().
>
> This series restructures the flow so that -L goes through the same
> log_tree_diff() -> log_tree_diff_flush() path as normal single-parent and
> merge diffs, then uses that to enable several non-patch diff formats.
>
> Patch 1: revision: move -L setup before output_format-to-diff derivation
>
> Preparatory reorder in setup_revisions(). The -L block sets a default
> DIFF_FORMAT_PATCH when no format is requested; move it before the derivat=
ion
> of revs->diff from output_format so the default is visible to that check.=
 No
> behavior change on its own.
>
> Patch 2: line-log: integrate -L output with the standard log-tree pipelin=
e
>
> Rename line_log_print() to line_log_queue_pairs(), stripping it down to o=
nly
> queue pre-computed filepairs. log_tree_diff_flush() handles show_log(),
> diffcore_std(), and diff_flush(). This fixes pickaxe and --diff-filter
> suppression, and aligns the commit/diff separator with the rest of log
> output. Rejects --full-diff, which is not yet supported when filepairs ar=
e
> pre-computed.
>
> Patch 3: line-log: allow non-patch diff formats with -L
>
> Expand the allowlist to accept --raw, --name-only, --name-status, and
> --summary. These only read filepair metadata already set by the line-log
> machinery. Diff stat formats (--stat, --numstat, --shortstat, --dirstat)
> remain blocked because they call compute_diffstat() on full blob content =
and
> would show whole-file statistics rather than range-scoped ones.
>
> Changes since v1:
>
>  * Patch 2: use !opt->loginfo return convention in log_tree_diff() to mat=
ch
>    the existing single-parent and merge codepaths, instead of returning
>    log_tree_diff_flush() directly.
>  * Patch 2: reword the early-return removal to explicitly tie it to the
>    pipeline change.
>  * Patch 2: soften --full-diff rejection to "not yet supported".
>  * Patches 2-3: use test_grep consistently in new tests.
>  * Patch 2: replace sed | grep pipe with sed > file && test_grep for prop=
er
>    exit status handling.
>
> Michael Montalbo (3):
>   revision: move -L setup before output_format-to-diff derivation
>   line-log: integrate -L output with the standard log-tree pipeline
>   line-log: allow non-patch diff formats with -L
>
>  Documentation/line-range-options.adoc         |  10 +-
>  line-log.c                                    |  30 ++----
>  line-log.h                                    |   2 +-
>  log-tree.c                                    |  10 +-
>  revision.c                                    |  24 +++--
>  t/t4211-line-log.sh                           | 100 +++++++++++++++---
>  t/t4211/sha1/expect.parallel-change-f-to-main |   1 -
>  .../sha256/expect.parallel-change-f-to-main   |   1 -
>  8 files changed, 121 insertions(+), 57 deletions(-)
>
>
> base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2094%2F=
mmontalbo%2Fmm%2Fline-log-use-log-tree-diff-flush-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2094/mmont=
albo/mm/line-log-use-log-tree-diff-flush-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2094
>
> Range-diff vs v1:

Looks good.

>
>  1:  9633eb62c6 =3D 1:  9633eb62c6 revision: move -L setup before output_=
format-to-diff derivation
>  2:  2d9e0ca015 ! 2:  7acfc5376e line-log: integrate -L output with the s=
tandard log-tree pipeline
>      @@ Commit message
>              log_tree_diff_flush(), mirroring the diff_tree_oid() + flush
>              pattern used by the single-parent and merge codepaths.
>
>      -     - Remove the early return in log_tree_commit() that bypassed
>      -       no_free save/restore, always_show_header, and diff_free().
>      +     - Remove the early return in log_tree_commit() that is no long=
er
>      +       needed now that -L output flows through log_tree_diff() and
>      +       log_tree_diff_flush(); this restores no_free save/restore,
>      +       always_show_header, and diff_free() cleanup.
>
>           Because show_log() is now deferred until after diffcore_std() i=
nside
>           log_tree_diff_flush(), pickaxe (-S, -G, --find-object) and
>      @@ Commit message
>           log_tree_diff_flush() only emits one for verbose headers.  This
>           matches the rest of log output.
>
>      -    Also reject --full-diff, which is meaningless with -L: the file=
pairs
>      -    are pre-computed during the history walk and scoped to tracked =
paths,
>      -    so there is no tree diff to widen.
>      +    Also reject --full-diff, which is not yet supported with -L: th=
e
>      +    filepairs are pre-computed during the history walk and scoped t=
o
>      +    tracked line ranges, so there is currently no full-tree diff to
>      +    fall back to for display.
>
>           Update tests accordingly.
>
>      @@ log-tree.c: static int log_tree_diff(struct rev_info *opt, struct=
 commit *commit
>
>       + if (opt->line_level_traverse) {
>       +         line_log_queue_pairs(opt, commit);
>      -+         return log_tree_diff_flush(opt);
>      ++         log_tree_diff_flush(opt);
>      ++         return !opt->loginfo;
>       + }
>       +
>         parse_commit_or_die(commit);
>      @@ log-tree.c: int log_tree_commit(struct rev_info *opt, struct comm=
it *commit)
>
>        ## revision.c ##
>       @@ revision.c: int setup_revisions(int argc, const char **argv, str=
uct rev_info *revs, struct s
>      +          die(_("the option '%s' requires '%s'"), "--grep-reflog", =
"--walk-reflogs");
>      +
>         if (revs->line_level_traverse &&
>      -      (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FOR=
MAT_NO_OUTPUT)))
>      -          die(_("-L does not yet support diff formats besides -p an=
d -s"));
>      -+ if (revs->line_level_traverse && revs->full_diff)
>      -+         die(_("-L is not compatible with --full-diff"));
>      +-     (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FOR=
MAT_NO_OUTPUT)))
>      +-         die(_("-L does not yet support diff formats besides -p an=
d -s"));
>      ++     (revs->full_diff ||
>      ++      (revs->diffopt.output_format &
>      ++       ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT))))
>      ++         die(_("-L does not yet support the requested diff format"=
));
>
>         if (revs->expand_tabs_in_log < 0)
>                 revs->expand_tabs_in_log =3D revs->expand_tabs_in_log_def=
ault;
>      @@ t/t4211-line-log.sh: test_expect_success '-L with -G filters to d=
iff-text matche
>       + test_cmp expect actual
>       +'
>       +
>      -+test_expect_success '--full-diff is not supported with -L' '
>      ++test_expect_success '--full-diff is not yet supported with -L' '
>       + test_must_fail git log -L1,24:b.c --full-diff 2>err &&
>      -+ test_grep "not compatible with --full-diff" err
>      ++ test_grep "does not yet support" err
>       +'
>       +
>       +test_expect_success '-L --oneline has no extra blank line before d=
iff' '
>       + git checkout parent-oids &&
>       + git log --oneline -L:func2:file.c -1 >actual &&
>       + # Oneline header on line 1, diff starts immediately on line 2
>      -+ sed -n 2p actual | grep "^diff --git"
>      ++ sed -n 2p actual >line2 &&
>      ++ test_grep "^diff --git" line2
>       +'
>       +
>        test_done
>  3:  06c24b416f ! 3:  10a3d8dde2 line-log: allow non-patch diff formats w=
ith -L
>      @@ Documentation/line-range-options.adoc
>
>        ## revision.c ##
>       @@ revision.c: int setup_revisions(int argc, const char **argv, str=
uct rev_info *revs, struct s
>      -          die(_("the option '%s' requires '%s'"), "--grep-reflog", =
"--walk-reflogs");
>      -
>         if (revs->line_level_traverse &&
>      --     (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FOR=
MAT_NO_OUTPUT)))
>      --         die(_("-L does not yet support diff formats besides -p an=
d -s"));
>      -+     (revs->diffopt.output_format &
>      -+      ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT |
>      -+        DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
>      -+        DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY)))
>      -+         die(_("-L does not yet support the requested diff format"=
));
>      -  if (revs->line_level_traverse && revs->full_diff)
>      -          die(_("-L is not compatible with --full-diff"));
>      +      (revs->full_diff ||
>      +       (revs->diffopt.output_format &
>      +-       ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT))))
>      ++       ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT |
>      ++         DIFF_FORMAT_RAW | DIFF_FORMAT_NAME |
>      ++         DIFF_FORMAT_NAME_STATUS | DIFF_FORMAT_SUMMARY))))
>      +          die(_("-L does not yet support the requested diff format"=
));
>
>      +  if (revs->expand_tabs_in_log < 0)
>
>        ## t/t4211-line-log.sh ##
>       @@ t/t4211-line-log.sh: test_expect_success '-p shows the default p=
atch output' '
>      @@ t/t4211-line-log.sh: test_expect_success '-p shows the default pa=
tch output' '
>       - test_must_fail git log -L1,24:b.c --raw
>       +test_expect_success '--raw shows mode, oid, status and path' '
>       + git log -L1,24:b.c --raw --format=3D >actual &&
>      -+ grep "^:100644 100644 [0-9a-f]\{7\} [0-9a-f]\{7\} M     b.c$" act=
ual &&
>      -+ ! grep "^diff --git" actual &&
>      -+ ! grep "^@@" actual
>      ++ test_grep "^:100644 100644 [0-9a-f]\{7\} [0-9a-f]\{7\} M        b=
.c$" actual &&
>      ++ ! test_grep "^diff --git" actual &&
>      ++ ! test_grep "^@@" actual

I wish we had docs for all the little test helpers=E2=80=A6 in particular, =
I
think this is supposed to be "test_grep !" ?

>       +'
>       +
>       +test_expect_success '--name-only shows path' '
>       + git log -L1,24:b.c --name-only --format=3D >actual &&
>      -+ grep "^b.c$" actual &&
>      -+ ! grep "^diff --git" actual &&
>      -+ ! grep "^@@" actual
>      ++ test_grep "^b.c$" actual &&
>      ++ ! test_grep "^diff --git" actual &&
>      ++ ! test_grep "^@@" actual
>       +'
>       +
>       +test_expect_success '--name-status shows status and path' '
>       + git log -L1,24:b.c --name-status --format=3D >actual &&
>      -+ grep "^M        b.c$" actual &&
>      -+ ! grep "^diff --git" actual &&
>      -+ ! grep "^@@" actual
>      ++ test_grep "^M   b.c$" actual &&
>      ++ ! test_grep "^diff --git" actual &&
>      ++ ! test_grep "^@@" actual
>       +'
>       +
>       +test_expect_success '--stat is not yet supported with -L' '
>      @@ t/t4211-line-log.sh: test_expect_success '-p shows the default pa=
tch output' '
>
>        test_expect_success 'setup for checking fancy rename following' '
>       @@ t/t4211-line-log.sh: test_expect_success '-L --oneline has no ex=
tra blank line before diff' '
>      -  sed -n 2p actual | grep "^diff --git"
>      +  test_grep "^diff --git" line2
>        '
>
>       +test_expect_success '--summary shows new file on root commit' '
>       + git checkout parent-oids &&
>       + git log -L:func2:file.c --summary --format=3D >actual &&
>      -+ grep "create mode 100644 file.c" actual
>      ++ test_grep "create mode 100644 file.c" actual
>       +'
>       +
>        test_done
>
> --
> gitgitgadget

Thanks

--=20
D. Ben Knoble
