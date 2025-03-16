Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC13FE4
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742107328; cv=none; b=P6md/cYAB0lIZsuvxC7nIcL6ghryeCx5/lr0udBLtNS7Lp6GdsmM3qd+NXG2gRziQbcWbGN7//xmMxt6Fh8yQCF0BX/fsT2kqJ9yeEY32B4r62dLbzHulNJLY7JlqbZ629qOjkM8nMk8+fnhPqxEyRbkf2Ldl/k4O5pm87PLEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742107328; c=relaxed/simple;
	bh=25DFnwDuUBI7cvnY8yxMiRleito42JG7TGEyIDuSl8E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Gfnt++wwJCP/HPBLaIUT8RrxWfefTBSYDrTKuo4LIe+5x0zbvgDs98sXPTj1xsVnzJa3xkrmaOQqEAIZzYQVnBM/63Tuc0bhkadn+Q3081f3OLXxIUXrEV1PtuIjQhNhZwCzTEFw/pLVAe8A4gzs7VTGErfUbskNm4FUHotjU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVNOdL8K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVNOdL8K"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39127512371so2059359f8f.0
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742107324; x=1742712124; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yScqragxlmrFR9gUM+9DCxCtvWhKk2pSdHGGwAOBsO8=;
        b=SVNOdL8KWjHlIqbWRooKFNV/CL/aXO9k09xvxOzwW9adnnO6pHHL3rEwowGFiBt514
         P45tuoYtORGPz6Wv7PO/x/o9NqkOU5/Fy8ICrDuLH+d7bWBL0hvkCwAsOeu9M/yKKULp
         M4LJXqTXnrmKN3DleLlFFXMZx8HGwY7Vth6EsU/6mP538qkPLe1HsBfRIaxikCvT9a+5
         ROyaFtvS7DYqH8v2VvaxxQCxenq/pFuyiPuKVbNLvpFsZU2IUCAGJAlATGxS014ZYs43
         /hLm/4iXBOihGtK+AS9XREG0J/BUw4fAraaAcMhsOUPUndi8E+jo7V80GInyrOrNYnPL
         4yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742107324; x=1742712124;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yScqragxlmrFR9gUM+9DCxCtvWhKk2pSdHGGwAOBsO8=;
        b=flVBuzWbInIWWucfeZgmjcQdRK+ri1Kjr9BAiQ0FSm2LE/FvICMzHYOcbesGXXf5Sg
         BT4Hq+TiY9Eg8vwcQCWEWoBJDPqyPOSQ8GZHkHnUclXHN1/U1pFdnMV1lyu1y/drJ2Hz
         mTsD9rZaXs65QbGmsgEC2S7AnVm5hWBu1EyLNEHDwP43ATT+Z4QgWA2G0YfCz2O5sDQh
         NQY3m5WaAQuxtyg6Ad/0nVgzosD4UhmfB7K/1CJs/klZ7H3MjryJ/0m4brFfh4xivZZ9
         vZD8weq/r188roF3i2v19A0vhnMC8vT47MuRtTxBC8CpPQY8wGDNyV1UrFnAVdbh6NVH
         3T5g==
X-Gm-Message-State: AOJu0Yzfz5ubpejiJ07FYElUfCBNzdOo9K+fNmCq5nULm0lQnKjSSRL0
	GKnPgz670RyoEF5cLRBuJf15MJvzppO08wc4/H5KpQBzJ6PUHeAoJdtLgw==
X-Gm-Gg: ASbGncujc0JHBwOz3HookeVyT636qxMgdz1ptq/4iEmSdSOTum1yWmkg0j0S84nuQ+h
	rdYLVHJ4udvevdG6scj+Ncz3daNb8+61EAW1A+KKQsrRzn5R6CGOtWDZnNAEHPvMCphYEZC0cv2
	tIIuuAiEsJSmzIBNFPpWcOLp+ktqZ++VIzQJFnVpHyngKyoF22KWfLcGgVXIJkwI07l0usLyikM
	uTh3bEMmJn0berMqmJLgdG8ltWUOItmwf5/aUnuINeKoJyPidyGGs/wYm5AXAyvWGfJOT6z+RlU
	SlXajHQ+cuTBAYTU5sDJXADB7VFpepiBYp4N3/z0P33RFQ==
X-Google-Smtp-Source: AGHT+IENvH850Vz7uU06Y4KjISLpOV7jBp5/XgPtha0CjyUvAbbEecOeVFtcxtecdCleoodOwvNcMg==
X-Received: by 2002:a5d:64e3:0:b0:395:dbbe:2b1f with SMTP id ffacd0b85a97d-3971ee43d81mr10046977f8f.37.1742107323898;
        Sat, 15 Mar 2025 23:42:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df342fsm11349601f8f.14.2025.03.15.23.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:42:03 -0700 (PDT)
Message-Id: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:41:59 +0000
Subject: [PATCH v2 0/3] Add a static analysis job to prevent assertions with side effects
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

We have several hundred assert() invocations in our code base. Some have
suggested that we should add a recommendation in our CodingGuidelines to
avoid their use, because there is a risk that someone might include
something with a side-effect in their assertion, which can lead to a very
difficult to debug problem. However, CodingGuidelines are going to be less
effective at preventing that foot-gun than a CI job which can warn of
assertions that possibly have side-effects. So, let's add a CI job instead.

While it is difficult to perfectly determine whether any expression has side
effects, a simple compiler/linker hack can prove that all but 9 of our
several hundred assert() calls are indeed free from them. While I believe
the remaining 9 are also free of side effects, it's easier to just convert
those 9 to a new macro (which will not be compiled out when NDEBUG is
defined), and instruct any future assertion writers to likewise switch to
that alternative macro if they have a slightly more involved assert()
invocation.

See
https://github.com/newren/git/actions/runs/13845548634/job/38743076293#step:4:1938
for an example of it running in CI and reporting possibly problematic
assertions (sample output also included in the commit message of the middle
commit in this series if you don't have access to view the link; I'm not
sure what the rules on that are).

Elijah Newren (3):
  git-compat-util: introduce BUG_IF_NOT() macro
  ci: add build checking for side-effects in assert() calls
  treewide: replace assert() with BUG_IF_NOT() in special cases

 Makefile                      |  4 ++++
 ci/check-unsafe-assertions.sh | 18 ++++++++++++++++++
 ci/run-static-analysis.sh     |  2 ++
 diffcore-rename.c             |  2 +-
 git-compat-util.h             |  7 +++++++
 merge-ort.c                   |  4 ++--
 merge-recursive.c             |  2 +-
 object-file.c                 |  2 +-
 parallel-checkout.c           |  2 +-
 scalar.c                      |  4 ++--
 sequencer.c                   |  2 +-
 11 files changed, 40 insertions(+), 9 deletions(-)
 create mode 100755 ci/check-unsafe-assertions.sh


base-commit: 4b68faf6b93311254efad80e554780e372deb42f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1881%2Fnewren%2Fassertion-side-effects-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1881/newren/assertion-side-effects-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1881

Range-diff vs v1:

 1:  109060ccb86 = 1:  109060ccb86 git-compat-util: introduce BUG_IF_NOT() macro
 2:  80dcc2ba3aa ! 2:  58cb8f6a160 ci: add build checking for side-effects in assert() calls
     @@ Commit message
          We have roughly 566 assert() calls in our codebase (my grep might have
          picked up things that aren't actually assert() calls, but most appeared
          to be).  All but 9 of them can be determined by gcc to be free of side
     -    effects with a clever redefine of assert().  The current 9 appear to be
     -    free of side effects to me as well, but are too complicated for a
     -    compiler/linker to figure that since each assertion involves some kind
     -    of function call.  Add a CI job which will find and report these
     -    possibly problematic assertions, and have the job suggest to the user
     -    that they replace these with BUG_IF_NOT() calls.
     +    effects with a clever redefine of assert() provided by Bruno De Fraine
     +    (from
     +    https://stackoverflow.com/questions/10593492/catching-assert-with-side-effects),
     +    who upon request has graciously placed his two-liner into the public
     +    domain without warranty of any kind.  The current 9 assert() calls
     +    flagged by this clever redefinition of assert() appear to me to be free
     +    of side effects as well, but are too complicated for a compiler/linker
     +    to figure that since each assertion involves some kind of function call.
     +    Add a CI job which will find and report these possibly problematic
     +    assertions, and have the job suggest to the user that they replace these
     +    with BUG_IF_NOT() calls.
      
          Example output from running:
      
     @@ Commit message
          run, subsequent runs will show (some of) the ones that remain, allowing
          you to iteratively remove them all.
      
     +    Helped-by: Bruno De Fraine <defraine@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## Makefile ##
 3:  4c668039bb7 = 3:  20c763f2951 treewide: replace assert() with BUG_IF_NOT() in special cases

-- 
gitgitgadget
