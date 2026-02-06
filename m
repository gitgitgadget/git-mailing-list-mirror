Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849F3093D8
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405386; cv=none; b=hRdfEO8EMH7dGOPYGNC9QJ91xciNR1nAcuBXEaE74fER7WyAJ+21TDg689lvMEq4I4wE2rZRBz1vzGTpUD9YD7PAlk3a2zpUSBwbdC1p8iQwUoPn9ezCXFPJxqGTQtES1ID1RKWOX+2Jl2SH2tuscVtk1j+6JkDOHCtVBV/Ivoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405386; c=relaxed/simple;
	bh=5OyAoPWFAMKQXE0Wvv63JCdNhdv14U+XDWqhDbUMHTY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ST2VBMy2poNjZM/2/68yMzqHeF/H0R+6ZVHbl7l1hmcuun9J8qd6rDAFbUJ3vBNgL2qutJPkm/hh7XhzaIuM3bPr6NV0TOOGSCge/LFevsR589gzHrA44gHT6ufHVfEgX6j4dSsSGCcfJC/jTkACXihN/XM0zB7+41bIzXL+L6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZsQVSP/; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZsQVSP/"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124566b6693so2651420c88.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 11:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770405385; x=1771010185; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUYJcPZI5sQhDIqpw7lEfqsEF1sb4U4IS260pdTaQL0=;
        b=gZsQVSP/fZbpK+6IRX2qMWGGYT8TAkJjvBETYfgGHBNWWKf6kqP4YCFOv741k2geij
         ydXgjytXepWfOya/Ofh8mnzStamNkRXIRwUyWRNVO7sZA0cMDE4L+yxoHMk6RK+Ku4v9
         sdv8KYx4ikiA5ZBry7ZAAZcrndsxattWlT6s7iKbCe3FfTJn+/Yl6akGHcfQBzBqK7cn
         QDO4vmXMXrygIGTb9Z2ylWa4qDlg5BeGGkGzQAk/oj+YwgMYPu6782EkeTvLM3oJGPyx
         IXAXLk2l9OIAIJxCi5dAvRjF5ELDV9HNrx00dYukPaM6urlNwIcfhncw+UFKJaExfD/U
         fJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405385; x=1771010185;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PUYJcPZI5sQhDIqpw7lEfqsEF1sb4U4IS260pdTaQL0=;
        b=YfylhCQNkNeB7fhfmJKGsJEXDnv7yGh1lLiiwK18qPsiif8PFjTWfPJT6WHjjQh/E2
         57F+TjMXrCjIhpt1rTrYGbQfirOIDCzwUWeEyAjHhoBss9vZq5pNLhKszNWymZRhd0tP
         iTxD6+mQ0grj+8cEsaDf9LbcIXOgio9yb8rrBsbGDtTGoinS3c5kaSqtbJnWNm9xi0V5
         SVMXbz9iZEtBC0C9CWU8Lc8lSdcVJVr9hGxOlEYOyGjfNFBBNaVITBDrCgyx4pVPGzNt
         Ua8hWi3ogvIQCY96PhaP2ZFj/ftSgbDyC2SKd0z8/DYqclCY3yK424dAHT0K2IFnNUJm
         TQTw==
X-Gm-Message-State: AOJu0YxGdvLoFQrtUhc+3bJzoJFmHKhUheVs9VwGGodJvWAFk7nHc8vm
	XFxGcgEiPOcOI0OUR/c2piVtisomP7IEKrg+Xl6aOdcnJSbI+Zmw8MkIz7QldQ==
X-Gm-Gg: AZuq6aLV+kaxf8+V2z2lih0qvxiLlBMJAmL8QBjRFaoVHS9T0bDz9Eyw3A4BgFbwx6m
	O6hmK7MUbmgGuU4JIAzAR1pZKh47RCAdEE6kgktnke28M8O+I3o0pLohFdPPd1GnxltACH7KIh3
	bDki/5t3GBw/Bt1tVokhrff326L7arGOzPaGnf9EZxsEfvqtY8TecGe5K43W151Tc9U/REmTxQZ
	9z84JA5QB3j3gGHIr0D6B9/MuBk/fgJ1itHCykYi58bvJrFmaWZbI7nrpXCTJ8XNDZ+K+KJ7cm0
	WD8u94Dy76d1jTyKYrszs6dBkgH3+MZny3d1hB49b7fnNWq/DYP/xWN/gD2gX56JUJ+5x7sJqRt
	0xlYZZ2utiEfiMVLiIrCb4IEDTOz7m1rdlpsuFOmH7PhShJBlBzs3e+7LqEh8gERBPqyQjwiH4Z
	fCzi0MGTAv981opQ==
X-Received: by 2002:a05:7022:523:b0:123:2c98:f65d with SMTP id a92af1059eb24-12703ff1d2bmr1864090c88.13.1770405385268;
        Fri, 06 Feb 2026 11:16:25 -0800 (PST)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270414f28bsm2821763c88.0.2026.02.06.11.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:16:24 -0800 (PST)
Message-Id: <pull.2189.v2.git.git.1770405383.gitgitgadget@gmail.com>
In-Reply-To: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 19:16:21 +0000
Subject: [PATCH v2 0/2] merge-ours: sparse-index integration
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Sam Bostock <sam@sambostock.ca>

This short series teaches merge-ours to work with a sparse index as a small
step toward broader sparse-index support.

Patch 1 is a preparatory cleanup that converts merge-ours away from
the_repository global, using the repo parameter instead.

Patch 2 adds the actual sparse-index integration and tests.

Changes since v1:

 * Patch 1: note in commit message that RUN_SETUP guarantees repo is never
   NULL (Patrick, Junio)
 * Patch 2: rewrite commit message to follow the project's standard log
   message structure (Junio)

Thanks Junio and Patrick for the review.

Developed with AI assistance (Claude).

Sam Bostock (2):
  merge-ours: drop USE_THE_REPOSITORY_VARIABLE
  merge-ours: integrate with sparse-index

 builtin/merge-ours.c                     | 15 +++++++++------
 t/t1092-sparse-checkout-compatibility.sh | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)


base-commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2189%2Fsambostock%2Fsb%2Fmerge-ours-sparse-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2189/sambostock/sb/merge-ours-sparse-index-v2
Pull-Request: https://github.com/git/git/pull/2189

Range-diff vs v1:

 1:  6cb970e512 ! 1:  775d76df69 merge-ours: drop USE_THE_REPOSITORY_VARIABLE
     @@ Metadata
       ## Commit message ##
          merge-ours: drop USE_THE_REPOSITORY_VARIABLE
      
     -    Use the `repo` parameter passed to cmd_merge_ours() instead of
     -    `the_repository`, and drop the USE_THE_REPOSITORY_VARIABLE macro that
     -    is no longer needed.
     +    The merge-ours built-in uses the `the_repository` global to access
     +    the repository. The project is moving away from this global in favor
     +    of the `repo` parameter that is passed to each built-in command.
     +    Since merge-ours is registered with RUN_SETUP, `repo` is guaranteed
     +    to be non-NULL and can be used directly.
     +
     +    Drop the USE_THE_REPOSITORY_VARIABLE macro and use `repo` throughout.
      
          While at it, remove a stray double blank line between the #include
          block and the usage string.
 2:  20b9e0bf6e ! 2:  55d39ff778 merge-ours: integrate with sparse-index
     @@ Metadata
       ## Commit message ##
          merge-ours: integrate with sparse-index
      
     -    The merge-ours builtin reads the index only to compare it against HEAD
     -    via index_differs_from(), whose diff machinery (run_diff_index) is
     -    already sparse-aware.
     +    The merge-ours built-in opens the index to compare it against HEAD.
     +    The machinery used to do this (i.e. run_diff_index()) is capable of
     +    working with a sparse index, but the start-up sequence of this
     +    command does not take the necessary steps, so we end up expanding the
     +    index fully before doing the comparison.
      
     -    Teach merge-ours to opt out of requiring a full index by setting
     -    command_requires_full_index to 0. Because merge-ours is invoked as a
     -    subprocess by "git merge -s ours" and never previously read config,
     -    the global variables core_apply_sparse_checkout and
     -    core_sparse_checkout_cone remained unset, causing
     -    is_sparse_index_allowed() to return false and the index to be expanded
     -    anyway. Add a repo_config() call with git_default_config to populate
     -    these globals.
     +    In order to convince sparse-index.c:is_sparse_index_allowed() to
     +    return true, we need to:
      
     -    Add tests to t1092 verifying that "git merge -s ours" produces
     -    identical results across full-checkout, sparse-checkout, and
     -    sparse-index modes, including verifying the resulting merge commit
     -    structure, and that the sparse index is not expanded during the
     -    operation.
     +     - Read basic configuration with git_default_config so that global
     +       variables like core_apply_sparse_checkout are populated.
     +       merge-ours currently does not read configuration at all.
     +
     +     - Set command_requires_full_index to 0.
     +
     +    With that, the command can work without expanding the index fully
     +    before doing its work.
      
          Signed-off-by: Sam Bostock <sam@sambostock.ca>
      

-- 
gitgitgadget
