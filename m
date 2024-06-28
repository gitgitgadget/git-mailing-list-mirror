Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A013E029
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578611; cv=none; b=L2l7XqTEiRmy9F3WoeUyysW3kFsziT3Uduf7sooV0bnOQ8lSZ0vyV3Sm5CqzClcoIQza2f7Y0oq4hhQKIN3bN9usKjll5wreKkQZSJYSMic7j1EJicUUtlTssBZFTNddLFCGDj5owWUPlbAEBjDixru92EWWonsOzJJezyo2B4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578611; c=relaxed/simple;
	bh=2O/1ErdSNbeIeJGo366EFBNR0bpo7HxKXrkoDEz2xIc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=GZTXWa/5bW7hLXAQIH1pCfK+crlKCzZbFnQkUacnQpz0KcU0yI1NkiWPy/HVhlwQWFprwsWKtm+7b/tHj9Kch3ZwZ8Wz0+gGyYBkhxlElWgabVcJBJwc0O+r2wu/LxbuWyE1BZ+RmTSCLIwufWBPKeGTRZ4gWt9q9NxGvIoyZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh2mdY2M; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh2mdY2M"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso6477011fa.3
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719578608; x=1720183408; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygU0Fe9nRkU4Xe2SUxwUGpAwqCrVeB7vYAPKMKvZg4Y=;
        b=Wh2mdY2MXNBkzNxQ+Nn5mjJdOKu+N6NCleaGHzIX4ruXPaDN2YtvaMPyfZQOZpJp1L
         irlwT0hyaCmxfFebSWIWP4DqtOKChoV2LctBaEzLkpk7ihF5OEEAjEQKaanZW5Q15ZhB
         8V+SeTt4HXsCA9BQB628a0vmC1nJfUvmg4yFp6b13vWt6dILhNNIbJIe65lmfpeRjVbs
         7sbBDeMSHaA2S4tizTNh3cB2QKdTHNs4cYOOTvAytIZh/R/VfZoggYI8Mz3LTxrDhpMP
         126eZTG/+ryxSFPHGLbZuXCZpdJOBvO5ZAINEvmOv786xmoK1Q5OYqpGjLUf3PklAxm0
         4pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578608; x=1720183408;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygU0Fe9nRkU4Xe2SUxwUGpAwqCrVeB7vYAPKMKvZg4Y=;
        b=OWCM/v6J0wPrWTJsMCvlnFvT83N5QgbfHvDuEba90y+lpnkr9R22Bf0FgVEkVBeBRc
         8HLBcEOs7cLWKZXzwrR6mZKCUeGd4FcEGP62Pdb5Mg1INebuMFPtYe98QslHtwNGXlzp
         RdiNyUhAztGdMcygmhdPq9NEAK3nng71pw99E6lmXc1toiJjYlXeZXkhMUZzjtcKYuOs
         5h3Xus3Q351f4RRuC+LRqrRyfYpy4SuqNgQ9vKKalH2LtrrFE5bPpU9OlEkV9SdBX+Gw
         iMYuNHSMyjxlwIkZ330NG5wrFnEv3n3gl4Ik6xdVH90H9lZ5KVFe7Oj0ki6vslMqpWov
         ZC5g==
X-Gm-Message-State: AOJu0YyJQ3qxhqgJ2Fw9FmDJLPe12Zlh2o2GQlm/cdazfU2mUTDNDlk0
	l2AJsnNZrr3KBnlZjuStBwzZe5i3En1gg5OFajW8o5nOk//kF2Mm33ADMQ==
X-Google-Smtp-Source: AGHT+IGllVOo5Q4Ue2tUw/9flWejJ7DahNLj/cAvXdbYrp9kOR7fnJyHGFf8i7W8mEzqPca1nKwtFg==
X-Received: by 2002:a2e:88c9:0:b0:2ec:57c7:c737 with SMTP id 38308e7fff4ca-2ec5b357a17mr124784071fa.40.1719578607363;
        Fri, 28 Jun 2024 05:43:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3f14csm33672605e9.6.2024.06.28.05.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:43:26 -0700 (PDT)
Message-Id: <pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
References: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Jun 2024 12:43:20 +0000
Subject: [PATCH v3 0/5] sparse-index: improve clear_skip_worktree_from_present_files()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>

While doing some investigation in a private monorepo with sparse-checkout
and a sparse index, I accidentally left a modified file outside of my
sparse-checkout cone. This caused my Git commands to slow to a crawl, so I
reran with GIT_TRACE2_PERF=1.

While I was able to identify clear_skip_worktree_from_present_files() as the
culprit, it took longer than desired to figure out what was going on. This
series intends to both fix the performance issue (as much as possible) and
do some refactoring to make it easier to understand what is happening.

In the end, I was able to reduce the number of lstat() calls in my case from
over 1.1 million to about 4,400, improving the time from 13.4s to 81ms on a
warm disk cache. (These numbers are from a test after v2, which somehow hit
the old caching algorithm even worse than my test in v1.)


Updates in v3
=============

 * Removed the incorrect paragraph in the commit message of patch 1.
 * Replaced "largest" with "longest" in the final patch.

Thanks, Stolee

Derrick Stolee (5):
  sparse-checkout: refactor skip worktree retry logic
  sparse-index: refactor path_found()
  sparse-index: use strbuf in path_found()
  sparse-index: count lstat() calls
  sparse-index: improve lstat caching of sparse paths

 sparse-index.c | 216 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 164 insertions(+), 52 deletions(-)


base-commit: 66ac6e4bcd111be3fa9c2a6b3fafea718d00678d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1754%2Fderrickstolee%2Fclear-skip-speed-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1754/derrickstolee/clear-skip-speed-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1754

Range-diff vs v2:

 1:  93d0baed0b0 ! 1:  0844cda94cf sparse-checkout: refactor skip worktree retry logic
     @@ Commit message
          stored in the index, so caching was introduced in d79d299352 (Accelerate
          clear_skip_worktree_from_present_files() by caching, 2022-01-14).
      
     -    If users are having trouble with the performance of this operation and
     -    don't care about paths outside of the sparse-checkout, they can disable
     -    them using the sparse.expectFilesOutsideOfPatterns config option
     -    introduced in ecc7c8841d (repo_read_index: add config to expect files
     -    outside sparse patterns, 2022-02-25).
     -
          This check is particularly confusing in the presence of a sparse index,
          as a sparse tree entry corresponding to an existing directory must first
          be expanded to a full index before examining the paths within. This is
 2:  69c3beaabf7 = 2:  c242e2c9168 sparse-index: refactor path_found()
 3:  0a82e6b4183 = 3:  ad63bf746ca sparse-index: use strbuf in path_found()
 4:  9549f5b8062 = 4:  db6ded0df0d sparse-index: count lstat() calls
 5:  0cb344ac14f ! 5:  1f58e19691f sparse-index: improve lstat caching of sparse paths
     @@ sparse-index.c: static void clear_path_found_data(struct path_found_data *data)
       }
       
      +/**
     -+ * Return the length of the largest common substring that ends in a
     -+ * slash ('/') to indicate the largest common parent directory. Returns
     ++ * Return the length of the longest common substring that ends in a
     ++ * slash ('/') to indicate the longest common parent directory. Returns
      + * zero if no common directory exists.
      + */
      +static size_t max_common_dir_prefix(const char *path1, const char *path2)

-- 
gitgitgadget
