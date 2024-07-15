Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A11862A9
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035853; cv=none; b=PjN47ffBmL+5F0Ww5iSz5R+mkJpEtXY0bjKWmlAEKHx5jDKM5RG1MXNvBz7V89cB/xXSa0FAiUSlkMoaAt5+FBTIdSz6u7HTy/qeSxXcH/Ud0yO+KMsE8jITEByN7a3dsMAIsf8Vn1lDOksPNYkXrTbreIp6FgWF7ZmhlkQd6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035853; c=relaxed/simple;
	bh=T7gHZHhubAq/mSzgE+29Cxl7zkjwGkaqaAe6fTApPfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbsBw9QRM6gNzeafBPd+zfOVUsxFiWEmhHQLG6XVTALcL6k2OhL8BjjJf3xelaFeXh/FLswcv2ax2B8iGFWZPgFlJN2Sr5sQWfTEkQ+ALitKBHw9vW2aUphtvv8AVQmzrYz3ahuk+S04OarFH3ru18Jt3QcDllIQnfD8tej73Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUd7z1fq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUd7z1fq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso29097725e9.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721035850; x=1721640650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjjdDOlflOZn6xz3bGU40FS55UDjhPm6JK81BW3Bd/k=;
        b=gUd7z1fqImTvNBP2b20r5070rPr7WPRNEhUkWYeS+NjYtTSDhLhoc23edftIuM2qI+
         hxOy67LOFgTTd/hLu9PrBH6zWze5JCYt5+5axU4G8F1G7rREfLEO34QrqQAokah+tNNk
         QAQ/6Q9NJHW5OzTjcF1YNaDvX9syuY5O7vncrpU3e6ZJj8CsljpBkltJHqUEcGaSmP4h
         2ZmHfGkT1AP0XxVM5ZL+WfSj26ugh/4TsXpettlwu8lxhXBzMSexmMgenkU4Se0070CW
         Cd3nxuZYJ4n51WSYj2p3FJoaaJUi4xCPnRyL/3gBKoDLEblVKqPfqKtCYxBGDcVu3/s0
         7pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035850; x=1721640650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjjdDOlflOZn6xz3bGU40FS55UDjhPm6JK81BW3Bd/k=;
        b=qZAEgPFPL0AM9F1/7WP0hxKehb4Bn/eIWUlE24gKcqLww4C4fEGplgXkdcxYhy1kvN
         rDNLKRODu8N29LisCtRmIn+Vg9/Qt64u+PMunpdQ/cGX1nPNDNxmhYOGzDLxfctUKXXs
         YHUTMjC9DDGaGaaHsd6aCmb+WchhS31+XUmv7qpZxxUxpBBwRyXq7UlzL4nJr9fwmFLF
         8M59BW5r8LJtsR0xAgfAffYmUHxynIOyTKpvkoC6qn/zRH+ZGrgDt8/H6vEKfK45Os2R
         qTkTv0g+29R9ogGeH3bZlqKSfbW5a47cExlNmexSKQKG4ucouOtzyu/uM3EVZ/Y9LvNj
         qgIw==
X-Forwarded-Encrypted: i=1; AJvYcCXff4TJo4hDjBAoeRVdpikZTI+zJnefhYsk0107o0UyASeu7nbYeSJZ1qtLb5TAOoRudizD08S9hC/hP0pohGCiCSe2
X-Gm-Message-State: AOJu0YwFL990hXujvuItgb6DhR0UXTrKWajsMTGClypuS1m2Hw+znGkd
	nT7bBjUonCHZJe88zwlptQmqQZWWFIM6p9+VLTrqPT2Oe1CRQulA
X-Google-Smtp-Source: AGHT+IGhcMDzkX9mXop/Kec0c4g1KJQtH4RMuTFz2sydeCRvBCgumpJz9JGD5r0lXc7M/UWx/6XR1A==
X-Received: by 2002:a05:6000:188f:b0:362:ccb1:791f with SMTP id ffacd0b85a97d-36804e9df8emr9146666f8f.10.1721035849430;
        Mon, 15 Jul 2024 02:30:49 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1a3c:da7e:77ea:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm5745208f8f.68.2024.07.15.02.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:30:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 0/8] clang-format: add more rules and enable on CI
Date: Mon, 15 Jul 2024 11:30:39 +0200
Message-ID: <20240715093047.49321-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713134518.773053-1-karthik.188@gmail.com>
References: <20240713134518.773053-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v3 of my series to add clang-format to the CI.

The series was mostly inspired by a patch sent recently to 'include
kh_foreach* macros in ForEachMacros' [1]. I was wondering why we don't
run the formatting on CI and reduce some of the workload of reviewers.

We have a '.clang-format' file to provide rules for code formatting.
The commits 1-5 aims to add more rules to the file while deprecating old
ones.

Commit 6 enables CI action on GitHub and GitLab to also check for the
code formatting. Currently, it is allowed to fail. This way we can build
confidence and fine tune the values as needed and finally enforce the
check in a future patch. I'm not well versed with GitHub workflows, and
I mostly tried to copy existing work there. Expecting some feedback in
that section!

Commit 7 fixes an existing issue with the 'check-whitespace' job, which
is failing as success in the GitLab CI.

Commit 8 adds the `RemoveBracesLLVM` only in the context of the CI. If we
decide against it, we could drop this commit from the series.

1: https://lore.kernel.org/git/4e7893f5-2dd9-46cf-8a64-cf780f4e1730@web.de/

Changes against v3:
- The job was actually failing on GitHub but showing a success since we added
the allow to fail clause. This was because the dependency wasn't installed.
Have fixed that in this version.
- Simplified the bash script in the GitLab job, thanks to Junio.
- Fixed a style issue with redirection. 
- Added some more details to the commit messages. 

Job running on:
- GitHub: https://github.com/KarthikNayak/git/actions/runs/9936188558/job/27443871938?pr=1
- GitLab: https://gitlab.com/gitlab-org/git/-/jobs/7340770469

Karthik Nayak (8):
  clang-format: indent preprocessor directives after hash
  clang-format: avoid spacing around bitfield colon
  clang-format: ensure files end with newlines
  clang-format: replace deprecated option with 'SpacesInParens'
  clang-format: formalize some of the spacing rules
  ci: run style check on GitHub and GitLab
  check-whitespace: detect if no base_commit is provided
  ci/style-check: add `RemoveBracesLLVM` to '.clang-format'

 .clang-format                     | 36 +++++++++++++++++++++++++-----
 .github/workflows/check-style.yml | 34 ++++++++++++++++++++++++++++
 .gitlab-ci.yml                    | 37 ++++++++++++++++++++++++++++++-
 ci/check-whitespace.sh            | 10 +++++++--
 ci/install-dependencies.sh        |  6 ++++-
 ci/run-style-check.sh             | 21 ++++++++++++++++++
 6 files changed, 135 insertions(+), 9 deletions(-)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

Range-diff against v3:
1:  6cf91ffc86 = 1:  6cf91ffc86 clang-format: indent preprocessor directives after hash
2:  beb002885f = 2:  beb002885f clang-format: avoid spacing around bitfield colon
3:  3031be43e7 = 3:  3031be43e7 clang-format: ensure files end with newlines
4:  bc1550e300 = 4:  bc1550e300 clang-format: replace deprecated option with 'SpacesInParens'
5:  4586c0094b = 5:  4586c0094b clang-format: formalize some of the spacing rules
6:  c18cb23369 ! 6:  f8eba92c0c ci: run style check on GitHub and GitLab
    @@ Commit message
         this job to fail, so we can validate if this is useful and eventually
         enforce it.
     
    -    For GitLab, we use the 'CI_MERGE_REQUEST_TARGET_BRANCH_SHA' variable by
    -    default to obtain the base SHA of the merged pipeline (which is only
    -    available for merged pipelines [1]). Otherwise we use the
    +    For GitHub, we allow the job to pass by adding 'continue-on-error: true'
    +    to the workflow. This means the job would show as passed, even if the
    +    style check failed. To know the status of the job, users have to
    +    manually check the logs.
    +
    +    For GitLab, we allow the job to pass by adding 'allow_failure: true', to
    +    the job. Unlike GitHub, here the job will show as failed with a yellow
    +    warning symbol, but the pipeline would still show as passed.
    +
    +    Also for GitLab, we use the 'CI_MERGE_REQUEST_TARGET_BRANCH_SHA'
    +    variable by default to obtain the base SHA of the merged pipeline (which
    +    is only available for merged pipelines [1]). Otherwise we use the
         'CI_MERGE_REQUEST_DIFF_BASE_SHA' variable.
     
         [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## .github/workflows/check-style.yml (new) ##
    @@ .github/workflows/check-style.yml (new)
     +
     +jobs:
     +  check-style:
    ++    env:
    ++      CC: clang
    ++      jobname: ClangFormat
     +    runs-on: ubuntu-latest
     +    steps:
     +    - uses: actions/checkout@v4
     +      with:
     +        fetch-depth: 0
     +
    ++    - run: ci/install-dependencies.sh
    ++
     +    - name: git clang-format
     +      continue-on-error: true
     +      id: check_out
    @@ .gitlab-ci.yml: check-whitespace:
     +  allow_failure: true
     +  variables:
     +    CC: clang
    ++    jobname: ClangFormat
     +  before_script:
     +    - ./ci/install-dependencies.sh
     +  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
    @@ .gitlab-ci.yml: check-whitespace:
     +  # be defined in all pipelines.
     +  script:
     +    - |
    -+      if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    -+      then
    -+        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    -+      elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    ++      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
    ++
    ++      if test -z "$R"
     +      then
    -+        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    -+      else
    -+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"; exit 1
    ++        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
    ++        exit 1
     +      fi
    ++      ./ci/run-style-check.sh "$R"
     +  rules:
     +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
     +
    @@ ci/install-dependencies.sh: ubuntu-*)
      
      	mkdir --parents "$CUSTOM_PATH"
      	wget --quiet --directory-prefix="$CUSTOM_PATH" \
    +@@ ci/install-dependencies.sh: macos-*)
    + esac
    + 
    + case "$jobname" in
    ++ClangFormat)
    ++	sudo apt-get -q update
    ++	sudo apt-get -q -y install clang-format
    ++	;;
    + StaticAnalysis)
    + 	sudo apt-get -q update
    + 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
     
      ## ci/run-style-check.sh (new) ##
     @@
7:  4d08c570bb ! 7:  477419fc6b check-whitespace: detect if no base_commit is provided
    @@ Commit message
     
         [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## .gitlab-ci.yml ##
    @@ .gitlab-ci.yml: check-whitespace:
        script:
     -    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
     +    - |
    -+      if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    -+      then
    -+        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    -+      elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    ++      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
    ++
    ++      if test -z "$R"
     +      then
    -+        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    -+      else
    -+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"; exit 1
    ++        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
    ++        exit 1
     +      fi
    ++      ./ci/check-whitespace.sh "$R"
        rules:
          - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
      
8:  2b39431f93 ! 8:  50007c17da ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
    @@ Commit message
         its efficacy and decide if we want to add it to '.clang-format' or
         retract it entirely.
     
    +    A more ideal solution would be if 'clang-format' allowed us to append
    +    rules to the existing '.clang-format' when invoked. But such an option
    +    does not exist. Since modifying the in-tree '.clang-format' is only done
    +    on the CI job for style-check and doesn't affect any other jobs and is
    +    not persisted in any ways, this hack should be okay.
    +
         [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    @@ ci/run-style-check.sh
     +# While also ensuring that end-users are not affected directly.
     +#
     +# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
    -+echo "RemoveBracesLLVM: true" >> .clang-format
    ++echo "RemoveBracesLLVM: true" >>.clang-format
     +
      git clang-format --style file --diff --extensions c,h "$baseCommit"
-- 
2.45.2

