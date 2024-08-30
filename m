Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1116D325
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052249; cv=none; b=qx1Wu7ZOj72/UAidaCIlxH9UJQaBTGflAbLSsycmW/5LwXKheByFvikjw1pGrDtwHYCybmVlJHuxZDDNKm74VURe+U1FA5bgYGps84Ij5ROv0JIw7eoP5+wiftEtF823WW+mvdvFvhVNkDzwDuFs8Rzq8cU18aGqabpHF9VVTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052249; c=relaxed/simple;
	bh=CZcHoPPfepoCdevP/OFXk8YHFCgqEzVwYuL3t2BLrZ4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UG4FOzF3sN4zHRHG8VnfWsjwLgi7KJ3B9QW0F62i3GaTmJTPhTmWRjlSFZhuFhiQjY1Auk7bA1lgvXQXjRxHLX27aze8R1iJyGBt3U70O5LIVAiwGXGjLx/aPj+xggct6XgfTLSx+LgvXaTZkN6YthNm92AxESNIlfo1XiW9Hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyUOdYK9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyUOdYK9"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c0a9f2b967so2414980a12.2
        for <git@vger.kernel.org>; Fri, 30 Aug 2024 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725052245; x=1725657045; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEciOma/e6rpY63pVal0k0KwgGtB1BZ97kTFzIDMmjk=;
        b=HyUOdYK9r0HQ6mZF69ZpawTdF7T8f7IoADs+/y7oaSojFYbeGBohgrZFJOM6sQT7nj
         AhWAm4/zq5zs1WydOZfGxP9jdSSnJ7khd/gCtzmqz8pNqZ4VnksqL3/qykA4qnElxXAs
         5aFMq/vjN3iZicNwGbpotQS66wb0gaeZlaKCw9sDFvJq3cUFzv/KaQM0GMfABhGq9kKQ
         MGFIyjvjcLE3CnuC6IMAyFKSZ/8FEe5i7g48foVjw9aAJz8XE9cOa4Nvj04Zqzf+dpAR
         KQfw2ay9Lmkf4yJUm14KUz0qkux44x2Y34KZmNiCJlPSGkgS146aeMQRCMGA8uLfLTSZ
         hx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725052245; x=1725657045;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEciOma/e6rpY63pVal0k0KwgGtB1BZ97kTFzIDMmjk=;
        b=oOd2baekehYiSsyzP9OGbjMekPTSM0q2mJ3fZ5HTQV7vh5hWB2kAzrtBOacNdnTraq
         4YAEwveNoMDZLzRr4JH7c4iOzk4lGbnJOnWCxEhvqLnfuAR7ehIhECdi5BKnuKKSDhXa
         P8U5ul4UUdwws3a4JhRfdvm66s8WFaMrCh8//xFNM7gxRtq83d26P7bO9i7htS2bZNT6
         F5z7FzdzmiYuZEVAg/7dEzozbNT1jV2lWd1tajWKcvM/Vo6vyyIu12k761jdmlAcl/E/
         63pLLnE3IrFtpTcp5znslpmoUNCAQkQwx6xzV6GwtMxW+YWoHX/1QV5LrmUOCA1mrKr4
         5rLw==
X-Gm-Message-State: AOJu0YwcLFinzTTyZpp0h3GXfMlW9e/emt1d3l9oMPHO6+KeGD/A8uns
	5w9a1Z/Cd0vibTcQsYcDxY8o02sCRBev+34nlxRdxZiyjYkBUyVH+CinZQ==
X-Google-Smtp-Source: AGHT+IFdWR0fkZ3ji1vd9y+JHuinnQwfsVzKnhdoJjwJXrT1fadrAyx8FzIA2Aw1JN2psKv0+wPd8A==
X-Received: by 2002:a05:6402:35d2:b0:5c2:43bd:8d3d with SMTP id 4fb4d7f45d1cf-5c243bd90eamr376212a12.15.1725052245037;
        Fri, 30 Aug 2024 14:10:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccfeb7sm2271742a12.63.2024.08.30.14.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:10:44 -0700 (PDT)
Message-Id: <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
In-Reply-To: <pull.1770.git.git.1724695732305.gitgitgadget@gmail.com>
References: <pull.1770.git.git.1724695732305.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Aug 2024 21:10:41 +0000
Subject: [PATCH v2 0/2] Mark cat-file sparse-index compatible
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
    Kevin Lyles <klyles+github@epic.com>

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
  Allow using stdin in run_on_* functions
  Mark 'git cat-file' sparse-index compatible

 builtin/cat-file.c                       |  3 ++
 t/t1092-sparse-checkout-compatibility.sh | 48 +++++++++++++++++++++---
 2 files changed, 46 insertions(+), 5 deletions(-)


base-commit: 80ccd8a2602820fdf896a8e8894305225f86f61d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1770%2Fklylesatepic%2Fkl%2Fmark-cat-file-sparse-index-compatible-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1770/klylesatepic/kl/mark-cat-file-sparse-index-compatible-v2
Pull-Request: https://github.com/git/git/pull/1770

Range-diff vs v1:

 -:  ----------- > 1:  7067a4c5da2 Allow using stdin in run_on_* functions
 1:  60c15dd246a ! 2:  a92825e502f Mark `cat-file` sparse-index compatible
     @@ Metadata
      Author: Kevin Lyles <klyles+github@epic.com>
      
       ## Commit message ##
     -    Mark `cat-file` sparse-index compatible
     +    Mark 'git cat-file' sparse-index compatible
      
     -    `cat-file` will expand a sparse index to a full index when needed, but
     -    is currently marked as needing a full index (or rather, not marked as
     -    not needing a full index). This results in much slower `cat-file`
     +    This change affects how 'git cat-file' works with the index when
     +    specifying an object with the ":<path>" syntax (which will give file
     +    contents from the index).
     +
     +    'git cat-file' will expand a sparse index to a full index when needed,
     +    but is currently marked as needing a full index (or rather, not marked
     +    as not needing a full index). This results in much slower 'git cat-file'
          operations when working within the sparse index, since we expand the
          index whether it's needed or not.
      
     -    Mark `cat-file` as not needing a full index, so that you only pay the
     -    cost of expanding the sparse index to a full index when you request a
     -    file outside of the sparse index.
     +    Mark 'git cat-file' as not needing a full index, so that you only pay
     +    the cost of expanding the sparse index to a full index when you request
     +    a file outside of the sparse index.
      
          Add tests to ensure both that:
     -    - `cat-file` returns the correct file contents whether or not the file
     -      is in the sparse index
     -    - `cat-file` warns about expanding to the full index any time you
     -      request something outside of the sparse index
     +    - 'git cat-file' returns the correct file contents whether or not the
     +      file is in the sparse index
     +    - 'git cat-file' expands to the full index any time you request
     +      something outside of the sparse index
      
          Signed-off-by: Kevin Lyles <klyles+github@epic.com>
      
     @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
       		if (opt_cw)
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
     -@@ t/t1092-sparse-checkout-compatibility.sh: init_repos_as_submodules () {
     - }
     - 
     - run_on_sparse () {
     -+	tee run_on_sparse-checkout run_on_sparse-index &&
     -+
     - 	(
     - 		cd sparse-checkout &&
     - 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
     --	) &&
     -+	) <run_on_sparse-checkout &&
     - 	(
     - 		cd sparse-index &&
     - 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
     --	)
     -+	) <run_on_sparse-index
     - }
     - 
     - run_on_all () {
     -+	tee run_on_all-full run_on_all-sparse &&
     -+
     - 	(
     - 		cd full-checkout &&
     - 		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
     --	) &&
     --	run_on_sparse "$@"
     -+	) <run_on_all-full &&
     -+	run_on_sparse "$@" <run_on_all-sparse
     - }
     - 
     - test_all_match () {
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_sparse_unstaged () {
     - 	done
     - }
     - 
     --# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
     -+# Usage: test_sparse_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
     - # Verifies that "git sparse-checkout set <c1> ... <cN>" succeeds and
     - # leaves the sparse index in a state where <s1> ... <sM> are sparse
     - # directories (and <c1> ... <cN> are not).
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'advice.sparseIndexExpanded' '
       	grep "The sparse index is expanding to a full index" err
       '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'advice.sparseInde
      +	echo "new content" >>sparse-index/deep/a &&
      +	run_on_all git add deep/a &&
      +
     -+	test_all_match git cat-file -p HEAD:deep/a &&
     -+	ensure_not_expanded cat-file -p HEAD:deep/a &&
     -+	test_all_match git cat-file -p HEAD:folder1/a &&
     -+	ensure_not_expanded cat-file -p HEAD:folder1/a &&
     -+
      +	test_all_match git cat-file -p :deep/a &&
      +	ensure_not_expanded cat-file -p :deep/a &&
     -+	run_on_all git cat-file -p :folder1/a &&
     -+	test_cmp full-checkout-out sparse-checkout-out &&
     -+	test_cmp full-checkout-out sparse-index-out &&
     -+	test_cmp full-checkout-err sparse-checkout-err &&
     ++	test_all_match git cat-file -p :folder1/a &&
      +	ensure_expanded cat-file -p :folder1/a'
      +
      +test_expect_success 'cat-file --batch' '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'advice.sparseInde
      +	echo "new content" >>sparse-index/deep/a &&
      +	run_on_all git add deep/a &&
      +
     -+	cat <<-\EOF | test_all_match git cat-file --batch &&
     -+	HEAD:deep/a
     -+	:deep/a
     -+	EOF
     -+	cat <<-\EOF | ensure_not_expanded cat-file --batch &&
     -+	HEAD:deep/a
     -+	:deep/a
     -+	EOF
     ++	echo ":deep/a">in &&
     ++	test_all_match git cat-file --batch <in &&
     ++	ensure_not_expanded cat-file --batch <in &&
      +
     -+	echo "HEAD:folder1/a" | test_all_match git cat-file --batch &&
     -+	echo "HEAD:folder1/a" | ensure_not_expanded cat-file --batch &&
     ++	echo ":folder1/a">in &&
     ++	test_all_match git cat-file --batch <in &&
     ++	ensure_expanded cat-file --batch <in &&
      +
     -+	echo ":folder1/a" | run_on_all git cat-file --batch &&
     -+	test_cmp full-checkout-out sparse-checkout-out &&
     -+	test_cmp full-checkout-out sparse-index-out &&
     -+	test_cmp full-checkout-err sparse-checkout-err &&
     -+	echo ":folder1/a" | ensure_expanded cat-file --batch &&
     -+
     -+	cat <<-\EOF | run_on_all git cat-file --batch &&
     ++	cat <<-\EOF >in &&
      +	:deep/a
      +	:folder1/a
      +	EOF
     -+	test_cmp full-checkout-out sparse-checkout-out &&
     -+	test_cmp full-checkout-out sparse-index-out &&
     -+	test_cmp full-checkout-err sparse-checkout-err &&
     -+	cat <<-\EOF | ensure_expanded cat-file --batch
     -+	:deep/a
     -+	:folder1/a
     -+	EOF'
     ++	test_all_match git cat-file --batch <in &&
     ++	ensure_expanded cat-file --batch <in'
      +
       test_done

-- 
gitgitgadget
