Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F31D3195
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401213; cv=none; b=ru4lQ5hSXWaYR7FgDps3oFyU95U/EJa+UAemLUNOYhOnZmMtWFcdAAfu3go0oeEKWQUSwVxjDQ2/E+EVKw8+xlTwtaR4JN2I/iWVN+MfJRMdOmjmWy1oQvCMnqdR+u53eDn9Emlt3WgJ7VykxQYPwLVDbERHPIeonYoO/hEIBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401213; c=relaxed/simple;
	bh=cbSyPphKftt0whyse7kP+RAtTACLL1h3q9dguQez/FU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rCeoHiWOx+95GiQalx7cKbej1S6Ye33kRUxTwGgRneZKQlzJ7zGSQDd73JP85bBPOQUpwSF7O7vu4+dbEUuezSPPevaVBZGCo4WUM3tn2ds8UoVcuQKXSJg3QcJTFbOsXout/ZXypdI0yzPhlnDv2dJ3n4SFtStA6il3/puq5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy8dyME4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy8dyME4"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c263118780so2119309a12.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725401210; x=1726006010; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaFSvxwtBRRNPUDg2XK9qA3yFkN2M5oauyUKFbC4b70=;
        b=Fy8dyME4s5YtyEM5r8IdS/NJXgi2EFY1H2lndnyzzwPp2BvCWquzcGVzxEY8bN17Ma
         1Nc3k/m53H4cQoX9WFQLSWX0aSnkaJ+ZeEbyySdIN/Hh3JptepbIXof14YEEMu07NRg5
         OqRAZcsj1WH0i4X++YopR1xt7U7pT1qK29VIVt8pqIe7d4L2ozH2N16qeJn8YPGfprq4
         ckGtBwYBhzRIGbu/pLWwb7mQeYF7GBDx5sRrmvw0/X8SQAYBM7UZFdMXom0+VDOy0DEx
         Jv4VKnNPZ8ECsD13SbG4xiefJVOolPmKR/fpfLZfWQbaQ1EtOmLRhs3sDXOSJ6lxyk5K
         g7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401210; x=1726006010;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaFSvxwtBRRNPUDg2XK9qA3yFkN2M5oauyUKFbC4b70=;
        b=wUtcFj9fyHFnfFabp6LgZHw41BdXQuYeg+iGIqWp4v3wmPmkSEkGCgHv6DB+sx75jz
         RmBwobEkU17wG27YhClVt8QkCCkk6tEECl7ppm2V/B31jXODdfOLKsaP11DKqGHTB2ET
         E3kM5SiAvGMQvHC3XeqwYtI6hA0uzx1EHcckhxC/Lo3prouuWSN0IzRVp2aSnc5YW3fj
         6wXx6fnkeGrZr4m2szPu4arzSNIU5ZZmeR6zQigOMddmQFm6GksXryy56FalHZA2mVKq
         KamL3D8lE7QrLu8ezIl3q2BwtdhsVKZTwu2aIqo3U5kgkHgIOGiIRiyPxoQQJnWHSqvT
         zK8Q==
X-Gm-Message-State: AOJu0YxvXz7Akl4OpgWZQSQZXC30agYnLsC3FcdOJC5x5mnn2yZ7o95w
	cTbS+blrgsmUbV4syKmuRRpnuJrv/T27na4E5V69SJUB3Ba84VeJRdFL5A==
X-Google-Smtp-Source: AGHT+IGDtXn/ejsxOjDODTSDd1vN+/ZfVTtX0gEsb/U1lsHi5PsGmUv1dl1sRCwejLANULTrUkAIwg==
X-Received: by 2002:a50:c94a:0:b0:5c0:903e:963a with SMTP id 4fb4d7f45d1cf-5c25f269a23mr4519695a12.29.1725401209086;
        Tue, 03 Sep 2024 15:06:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a2a6sm6872154a12.7.2024.09.03.15.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:06:48 -0700 (PDT)
Message-Id: <pull.1770.v4.git.git.1725401207.gitgitgadget@gmail.com>
In-Reply-To: <pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
References: <pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Sep 2024 22:06:45 +0000
Subject: [PATCH v4 0/2] builtin/cat-file: mark 'git cat-file' sparse-index compatible
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Kevin Lyles <klyles+github@epic.com>

I believe I've addressed all issues raised except the question about how to
exhaustively validate the changes. I was under the impression that the
combination of the existing 'git cat-file' test cases and my new cases were
enough, but I have thus far been unable to get code coverage working locally
to validate that myself, due to spurious failures in other tests. I've
kicked off another run with most unrelated tests removed to see if that
helps.

Please note that this is my first contribution to git. I've tried to follow
the instructions about how to correctly submit a patch (I'm using
GitGitGadget as getting Outlook to do plain text e-mail correctly seems
impossible), but please let me know if I've missed something.

My motivation for making this change is purely performance. We have a large
repository that we enable the sparse index for, and I am developing a
pre-commit hook that (among other things) uses git cat-file to get the
staged contents of certain files. Without this change, getting the contents
of a single small file from the index can take upwards of 10 seconds due to
the index expansion. After this change, it only takes ~0.3 seconds unless
the file is outside of the sparse index.

Kevin Lyles (2):
  t1092: allow run_on_* functions to use standard input
  builtin/cat-file: mark 'git cat-file' sparse-index compatible

 builtin/cat-file.c                       |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 50 +++++++++++++++++++++---
 2 files changed, 48 insertions(+), 5 deletions(-)


base-commit: 4590f2e9412378c61eac95966709c78766d326ba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1770%2Fklylesatepic%2Fkl%2Fmark-cat-file-sparse-index-compatible-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1770/klylesatepic/kl/mark-cat-file-sparse-index-compatible-v4
Pull-Request: https://github.com/git/git/pull/1770

Range-diff vs v3:

 1:  b310593aec2 ! 1:  73fe71abcd5 Allow using stdin in run_on_* functions
     @@ Metadata
      Author: Kevin Lyles <klyles@epic.com>
      
       ## Commit message ##
     -    Allow using stdin in run_on_* functions
     +    t1092: allow run_on_* functions to use standard input
      
     -    The 'run_on_sparse' and 'run_on_all' functions previously did not work
     -    correctly for commands accepting standard input. This also indirectly
     -    affected 'test_all_match' and 'test_sparse_match'.
     +    The 'run_on_sparse' and 'run_on_all' functions do not work correctly for
     +    commands accepting standard input, because they run the same command
     +    multiple times and the first instance consumes it. This also indirectly
     +    affects 'test_all_match' and 'test_sparse_match'.
      
     -    Now, we accept standard input and will send it to each command that we
     -    run. This does not impact using the functions for commands that don't
     -    need standard input.
     +    To allow these functions to work with commands accepting standard input,
     +    first slurp standard input to a temporary file, and then run the command
     +    with its standard input redirected from the temporary file. This ensures
     +    that each command sees the same contents from its standard input.
     +
     +    Note that this does not impact commands that do not read from standard
     +    input; they continue to ignore it. Additionally, existing uses of the
     +    run_on_* functions do not need to do anything differently, as the
     +    standard input of the test environment is already connected to
     +    /dev/null.
     +
     +    We do not explicitly clean up the input files because they are cleaned
     +    up with the rest of the test repositories and their contents may be
     +    useful for figuring out which command failed when a test case fails.
      
          Signed-off-by: Kevin Lyles <klyles@epic.com>
      
     @@ t/t1092-sparse-checkout-compatibility.sh: init_repos_as_submodules () {
       }
       
       run_on_sparse () {
     -+	cat >run_on_sparse-input &&
     ++	cat >run-on-sparse-input &&
      +
       	(
       		cd sparse-checkout &&
       		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
      -	) &&
     -+	) <run_on_sparse-input &&
     ++	) <run-on-sparse-input &&
       	(
       		cd sparse-index &&
       		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
      -	)
     -+	) <run_on_sparse-input
     ++	) <run-on-sparse-input
       }
       
       run_on_all () {
     -+	cat >run_on_all-input &&
     ++	cat >run-on-all-input &&
      +
       	(
       		cd full-checkout &&
       		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
      -	) &&
      -	run_on_sparse "$@"
     -+	) <run_on_all-input &&
     -+	run_on_sparse "$@" <run_on_all-input
     ++	) <run-on-all-input &&
     ++	run_on_sparse "$@" <run-on-all-input
       }
       
       test_all_match () {
 2:  f4d1461b993 ! 2:  ac913257309 Mark 'git cat-file' sparse-index compatible
     @@ Metadata
      Author: Kevin Lyles <klyles+github@epic.com>
      
       ## Commit message ##
     -    Mark 'git cat-file' sparse-index compatible
     +    builtin/cat-file: mark 'git cat-file' sparse-index compatible
      
          This change affects how 'git cat-file' works with the index when
          specifying an object with the ":<path>" syntax (which will give file
          contents from the index).
      
     -    'git cat-file' will expand a sparse index to a full index when needed,
     -    but is currently marked as needing a full index (or rather, not marked
     -    as not needing a full index). This results in much slower 'git cat-file'
     -    operations when working within the sparse index, since we expand the
     -    index whether it's needed or not.
     +    'git cat-file' expands a sparse index to a full index any time contents
     +    are requested from the index by specifying an object with the ":<path>"
     +    syntax. This is true even when the requested file is part of the sparse
     +    index, and results in much slower 'git cat-file' operations when working
     +    within the sparse index.
      
          Mark 'git cat-file' as not needing a full index, so that you only pay
          the cost of expanding the sparse index to a full index when you request

-- 
gitgitgadget
