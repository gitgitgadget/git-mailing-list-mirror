Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D23BCD3D
	for <git@vger.kernel.org>; Fri, 29 May 2026 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056281; cv=none; b=ZugSfZtVQKLuE78l1TnkbWDc6JNwmuHDLLPbr8Kd0IF5qx00XOk+RKWCTxEg6U6dwFXNN9GAb4sM8DuovdTpwBCvXxmddua1CzsZO+XxE+C2xdJmtC4CQdTlmHxs03JiWmsjmRkodHF9wUl7ze7Ld8bHieqjrkPnCuAgzfqSQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056281; c=relaxed/simple;
	bh=1To2p24V3hzt8xTvEHl4vVqGJ0EyQxFZGPRS23be55Y=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=kcSPAPVZ3bvaKIhlgCcXjrAzZFPMLYprNbWu0qqk882v56qh2FdGsJprvpC0U3obdttVDjl3Nw8s4NhQjb/kLY3O9Q9tZTprGc7XFivGt3pjDAJfyHuU55IRl0gMM9ULJQY+aRO2E6v12TAarvzwe9Y+XuAVTh9hnNYaaEqjIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6j3khzC; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6j3khzC"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-654672a6d68so13326339d50.0
        for <git@vger.kernel.org>; Fri, 29 May 2026 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780056279; x=1780661079; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqcZNrM2tHsbPyiuGK/x9rxIBFtX6kL/9m9QowsM1Nw=;
        b=W6j3khzCHpmpa62AjT2Ni9xkXRmG9L+Ea0I1qV85+DLGNMOosktK8ePbwHm5PUILDM
         3GMo/SxARjtRV61/tto2JVnjF3wbVvFyJZPpENe1L3PyoFeac+7Nv4aR58cbJ+s7M7zx
         bWf6kJ9qgl/nbfFA4f6PeNC0NuHHA0npO/hUExXot9wiqOraj+Zp2yjn2QQjXuenkAyx
         b3UqZBHOLkJSOS0cld+EVpyTV1qrLGM+QmV1DYIZX0hc2UOKz9GJOtdF85bTiNQclocl
         lKutKIgIccyvx6H4z4gcmOpNtTBoXw91G6ff6ATEcBg0WwBaMLfQ8zqXX2AkfIJX1FaO
         DBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056279; x=1780661079;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wqcZNrM2tHsbPyiuGK/x9rxIBFtX6kL/9m9QowsM1Nw=;
        b=L5xRCxndeTlEdjN/QCg6XjhdnKVoRN1jN5zWhrPa4joxHPYCImRhckQxjK18WG0meB
         vJTpseJ1P34dm4Q1zrncqh6zNR6+xrfbOzqxI1mFEk3d2qoeWcTX6lkp+NNqdf6SZxIe
         bagd+PuTwT3LuTd68035mzml/DCD+qY2UFyEdAGteKYpHgvEfaF4lhAl8droIvy4Ba5g
         PFKyzSdmGgt4YdVE82kAQwrTx+2m3ouDgryQT4cSfoq5/+FKPkx3qzdKW1ROF73otzC0
         ablS8AkKL6CwRnFOfWb/S3qZ4I81zBhwG35qmeTZ5f1s6aijNGzhNB6rIdRVCJOahrwN
         ZOuQ==
X-Gm-Message-State: AOJu0YzpbmWtpuQtzlHCcUqZMkowLow+gJUvWMZYkQJYF/zVex4JZFfz
	s+7o5ib96HyWyzUsssIH98QKLwtYQ4XdWkfMMdyA9NgsSn8L5CVBWK3K
X-Gm-Gg: Acq92OHw9uwuRjLKwST4OThlQgbPfO4pL22/8efLY42ewm1UGqyP1/EoTdF1DYg92qi
	/U2I7tn07SoxvsIfMdKNMFK+taOvIl5s5M2u65v5x0ZJl9cMwzYi9tqChgLK48KVknplA2hFQaS
	Rm2PX8Dznls34luC8xk1uO0aHRgn4LkfmvYcNBPLqVw666d1dc1GKyvnsKmjWpptlUZYydwc907
	czhV8KNTenE71t1QDYgXr/mfz7mL28f4DyRQqCy/LpDK5CNcZhra1ZMxAFdjVvvTYrcyDjzO+sw
	68Qa1wPcD7G8t38u57aeyy3Bfxl0CIcjbHZ7iMD94gTCqrZNT90XBpJ+93rZvzHiCJuS3O55xMm
	n21ogk4Bk9tpMsi+sstddHt3jQxxA0L/R4WIK6/PmNJnA98VFa+v7nR1VFievd01YJXHxluue6v
	hqP2JMkQesyAqTU7Ya4gwB2Y+aaSvk/iLGWQTiXcwPoEviogIKzBHf6jUdIHmK5fFFZwovjP8HC
	5cnPrq3slMLJvMXSVFCxiQ8JmS6RBn67ftNtqyNHpHn7/X+hIME+qc9
X-Received: by 2002:a05:690e:169b:b0:65c:217d:f01f with SMTP id 956f58d0204a3-66052cb1c04mr1783567d50.3.1780056279006;
        Fri, 29 May 2026 05:04:39 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:a5b1:99dc:3743:5205])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6605367d0b8sm623018d50.6.2026.05.29.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:04:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/3] line-log: integrate -L with the standard log output pipeline
Date: Fri, 29 May 2026 08:04:27 -0400
Message-Id: <B59BA5B1-184D-48A8-8BAD-11EB6F8EB50C@gmail.com>
References: <pull.2094.v3.git.1780001267.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
In-Reply-To: <pull.2094.v3.git.1780001267.gitgitgadget@gmail.com>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 28 mai 2026 =C3=A0 16:47, Michael Montalbo via GitGitGadget <gitgitgadg=
et@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFSince its introduction, git log -L has short-circuited from
> log_tree_commit() into its own output function, bypassing log_tree_diff()
> and log_tree_diff_flush(). This skips no_free save/restore,
> always_show_header, diff_free() cleanup, and means that pickaxe (-S, -G,
> --find-object) and --diff-filter cannot suppress commits whose pairs are a=
ll
> filtered out, because show_log() runs before diffcore_std().
>=20
> This series restructures the flow so that -L goes through the same
> log_tree_diff() -> log_tree_diff_flush() path as normal single-parent and
> merge diffs, then uses that to enable several non-patch diff formats.
>=20
> Patch 1: revision: move -L setup before output_format-to-diff derivation
>=20
> Preparatory reorder in setup_revisions(). The -L block sets a default
> DIFF_FORMAT_PATCH when no format is requested; move it before the derivati=
on
> of revs->diff from output_format so the default is visible to that check. N=
o
> behavior change on its own.
>=20
> Patch 2: line-log: integrate -L output with the standard log-tree pipeline=

>=20
> Rename line_log_print() to line_log_queue_pairs(), stripping it down to on=
ly
> queue pre-computed filepairs. log_tree_diff_flush() handles show_log(),
> diffcore_std(), and diff_flush(). This fixes pickaxe and --diff-filter
> suppression, and aligns the commit/diff separator with the rest of log
> output. Rejects --full-diff, which is not yet supported when filepairs are=

> pre-computed.
>=20
> Patch 3: line-log: allow non-patch diff formats with -L
>=20
> Expand the allowlist to accept --raw, --name-only, --name-status, and
> --summary. These only read filepair metadata already set by the line-log
> machinery. Diff stat formats (--stat, --numstat, --shortstat, --dirstat)
> remain blocked because they call compute_diffstat() on full blob content a=
nd
> would show whole-file statistics rather than range-scoped ones.
>=20
> Changes since v2:
>=20
> * Switch "! test_grep" to "test_grep !" in tests.

Thanks ! I did not read the tests carefully for semantic value, but the rati=
onale and overall code looks good to me as discussed previously.

The range-diff here looks good, too.=20


> Michael Montalbo (3):
>  revision: move -L setup before output_format-to-diff derivation
>  line-log: integrate -L output with the standard log-tree pipeline
>  line-log: allow non-patch diff formats with -L
>=20
> Documentation/line-range-options.adoc         |  10 +-
> line-log.c                                    |  30 ++----
> line-log.h                                    |   2 +-
> log-tree.c                                    |  10 +-
> revision.c                                    |  24 +++--
> t/t4211-line-log.sh                           | 100 +++++++++++++++---
> t/t4211/sha1/expect.parallel-change-f-to-main |   1 -
> .../sha256/expect.parallel-change-f-to-main   |   1 -
> 8 files changed, 121 insertions(+), 57 deletions(-)
>=20
>=20
> base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2094%2Fm=
montalbo%2Fmm%2Fline-log-use-log-tree-diff-flush-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2094/mmonta=
lbo/mm/line-log-use-log-tree-diff-flush-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/2094
>=20
> Range-diff vs v2:
>=20
> 1:  9633eb62c6 =3D 1:  9633eb62c6 revision: move -L setup before output_fo=
rmat-to-diff derivation
> 2:  7acfc5376e =3D 2:  7acfc5376e line-log: integrate -L output with the s=
tandard log-tree pipeline
> 3:  10a3d8dde2 ! 3:  ae0b7f3ca8 line-log: allow non-patch diff formats wit=
h -L
>     @@ t/t4211-line-log.sh: test_expect_success '-p shows the default patc=
h output' '
>      +test_expect_success '--raw shows mode, oid, status and path' '
>      +    git log -L1,24:b.c --raw --format=3D >actual &&
>      +    test_grep "^:100644 100644 [0-9a-f]\{7\} [0-9a-f]\{7\} M    b.c$=
" actual &&
>     -+    ! test_grep "^diff --git" actual &&
>     -+    ! test_grep "^@@" actual
>     ++    test_grep ! "^diff --git" actual &&
>     ++    test_grep ! "^@@" actual
>      +'
>      +
>      +test_expect_success '--name-only shows path' '
>      +    git log -L1,24:b.c --name-only --format=3D >actual &&
>      +    test_grep "^b.c$" actual &&
>     -+    ! test_grep "^diff --git" actual &&
>     -+    ! test_grep "^@@" actual
>     ++    test_grep ! "^diff --git" actual &&
>     ++    test_grep ! "^@@" actual
>      +'
>      +
>      +test_expect_success '--name-status shows status and path' '
>      +    git log -L1,24:b.c --name-status --format=3D >actual &&
>      +    test_grep "^M    b.c$" actual &&
>     -+    ! test_grep "^diff --git" actual &&
>     -+    ! test_grep "^@@" actual
>     ++    test_grep ! "^diff --git" actual &&
>     ++    test_grep ! "^@@" actual
>      +'
>      +
>      +test_expect_success '--stat is not yet supported with -L' '
>=20
> --
> gitgitgadget
