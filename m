Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0AD2765E2
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760588; cv=none; b=UYa+VDidnOsrQ9H/jG2ajFAWbkESaJ4W2zjqAnoY4x0mjB2QyeupCZCEbcDR6TbVn0l+bO1mhTiNN9e42lQ7xYV+UYKcwFw2aS7XdnHVzrE03KUdW0svtI62QaWmRvpq+p32HeAgr0ulK3cdU5eHpb5AOrfVU4gtjk0FSAsreqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760588; c=relaxed/simple;
	bh=EFvf74pJ13fqmT4HBksbUCVLmyFPyQ28WyjjaH/s2BQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=R8wYaeny0RkCl4EN0xcUnVDcipmBSYApkiR1eRkxJ2VaeRTnH/3YJ9PuEGG4wciYeke+WamGUhUk9A9XXwP/uo2eBC5+RTxMAqvnQKBlN5Fgs4GMPKDAev7Xe3HFB3ayp8CF1jtU7VJYD0wKqp3VOVYPwwpmYusu+jhMHQOln58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsGFGcfr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsGFGcfr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so39381995e9.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760584; x=1760365384; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWttjk+wwtIemTnrPrZfi8vquKpvKrctpGCGlH+Q2kA=;
        b=dsGFGcfrRZ4zgVM3a+OlFSuHVguY+ARVAlwcFR6hRhX3zHLDt5fJnn7RbzCGbCW2zA
         +oTDIpbHmKrRdIUyA/hDoTaWFT1lHyQGwcapHEWoGYnZ7yq0qCch37nT3NIVHwaAxHLo
         UYa3iezyorQJgdlRDOOOujceW8uGBa3XHQ3pIWDttIeL8d2QDesE2plSr+/oTEB/kAHh
         iIaZieNfRYT8vdMOXivfpekY2nPeNG2RngL1K2cKn+IXkh9g61RIEvedmxjc/5LcIE4S
         LtpAZTpiqIPpArGv79AIpTQfIvp+Bb8nDrxUUxFlN7JX340iYgxAHNWp2HwIEND7wgsd
         6+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760584; x=1760365384;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZWttjk+wwtIemTnrPrZfi8vquKpvKrctpGCGlH+Q2kA=;
        b=Z6NXbE4J7eQX8Rn7oqzmivB/vCRIm9bqDx+3IpF4Dq8Eui3+UpuEbeyL3fqscAVxLW
         dkgVQ0vptAigdYU1DOURHtCIk2hbr+m8eFtguKL8PafPGMr/bFv7RDNpjRNbcgL3xMcf
         qW2hKDNUSO7Z68t3h1JjpgI4O1rssZ48u0+CUJ3vSw1hTDz0sQqC6M9O7RTOK1eTF6P6
         iLWc2rErVEXQLb4j6az3BshmiDh4tc9bvpdCVoGX/B3bMWCXrDrk+bkwj/296dYSDcHB
         nTGSbOm3qnhim1nev9BRluHm2YDJTgYpNqv1r/u3nu3ZUzXwdD5XoneEWnmIZyiA6t6m
         uN2g==
X-Gm-Message-State: AOJu0YyTbFogNdPNTawq9V6R+kWwWpdkb2oYt7GRTXa5V11bZngLRhJm
	ZqXwOxH9jGTEEpcMowI9LJS+ZBsjwsLvUNgPdZ5c0wYKi02g0iwYrGsIHhUIU76s
X-Gm-Gg: ASbGnculy59Lui/akRyMoNWpH1PR/VtTQEA+NoOeTWusMdN9q/ENx8RVfTzd+EFpw3F
	Gh8KjS0c99UqbrrQtPsPRJPBReV6zRH6ZxiUxn2iXgquPSqk6dzpLcM6b5oF6rLShLWpEzzT58X
	wIi0vTRNFZmkd8sxEwf0EqShgI6jVRHlCW9fo9ak68gxBmRH0GMyy2Iqvy7Y557OvfzrqtqDuT2
	2F4xKBcENULF5mbG/KHi5HB8CqxmkH2/jlIY2u+5OU832Xa589im9PMavIZSIwShNsaMJF0yA2k
	ONDSfDQMaIMsCrrdoGYEJp+s/WFRUxPEfXaLvHK3c/EeMdBwN57nVsXUl1KHLaOqJ/rUOXjqUE7
	JHJrFTel3Ho6PWHSwlqamYuwDASTBVfalHvaqc/C5Ylr94Uu79GN73jQKMHJC/oaIR3s=
X-Google-Smtp-Source: AGHT+IFSgroiDhHdvh+gqnKfI89i+zzO5X6qke2/AT++UZqVWXslDGvaqlvoFVFbYSann8OC/GHtnA==
X-Received: by 2002:a05:600c:8115:b0:46d:5572:547 with SMTP id 5b1f17b1804b1-46e71143124mr96199245e9.24.1759760583838;
        Mon, 06 Oct 2025 07:23:03 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f547sm171237555e9.9.2025.10.06.07.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:23:03 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/7] refs/reftable: add consistency checks
Date: Mon, 06 Oct 2025 16:22:58 +0200
Message-Id: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMLQ42gC/5XNS27DIBSF4a1EjEvFywYy6j6qDDBcYtQEInCsR
 pH33pt0ECszDw+P77+TBjVBI/vdnVSYU0sl4+g+dsSPLh+BpoCbCCY6prmiQhhaIU5uOOFdnmo
 JVw/Ul9xSmyD7G/Uj+J9GpbYBgpW+U4qgd8Fv6ffZ+j7gHvF9qbdneuaP0/+K4XZDZeaUUTOY2
 Btto7PwdTy7dPr05UwelVm8ZMvEFlmgrKLtB2mk0tq+y3Ilc7NFligLzV1kEgapwlpeluUPwz4
 enZYBAAA=
X-Change-ID: 20250714-228-reftable-introduce-consistency-checks-379ded93c544
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7868; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=EFvf74pJ13fqmT4HBksbUCVLmyFPyQ28WyjjaH/s2BQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjj0MX3I5Lh1ZESE90sTsT/QgX/wljGwmFE8
 6nC5b50HfZEj4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo49DFAAoJED7VnySO
 Rox/AFYL+wVMsmTLtqL9JqNEQRlXdrIzp/NDc9VSCeqWM5iuWlxbeMMIs/E2SGt5voko4pRcgil
 ucY9EV44TrhoAklac75DhEeuwdpw+r8jry5pD3LkT9V3ssL3pRordPEjEIinInwh4kGOcv74vbZ
 nadCCaGLxciQQSo+TEHnEGux1D+JBI6nrU33IiJTEE4hwYaGFomkKdvBeAbf6Rt9LruhepUXlGN
 X57VfB2nE7WhvSJ56p2lB4sVWcV2MfIWIWYM0BBs5+c8BK4ETkD6MVLXQcagPWaeny2u4TgKGku
 krM5d+NjoAUyMxt1mQJuDx5dD7yZm4rUbqH6svOZ7nYGZnP0CYqPOAo/b4F+9MHdAd6da8tGCTO
 X5M5FqFbvYLi3JrLBl+Mh9U4Bktjua4Z6Wryu67W17z73ZMHycdh64b1nlVyTmR7NUsJ5dxc+DR
 /tZid695KW4yLWCDttUVzNpl1H0Gs50nc01TfgdGlups9KRG2kafFskocHeTfRlxnGZHNU0tDL7
 TA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference subsystems allows for adding backend specific consistency
checks. These checks are run as part of 'git refs verify'.

While the files backend has some consistency checks added, the reftable
backend currently has none. This series first tightens the reftable
backend to make it a little more strict and then also adds the required
infrastructure and some simple consistency checks.

Since the reftable backend is treated as a library within the Git
codebase, we don't want to spillover our internal fsck implementation
into the library. At the same time, the fsck checks need to access
internal structures of the reftable library which aren't exposed outside
the library.

So we solve this by adding a 'reftable/fsck.[ch]' which implements and
exposes a checker for the reftable library and returns specific errors
as defined by the library. We then add glue code within
'refs/reftable-backend.c' to map these errors to errors which Git's fsck
implementation would understand. This allows us to separate concerns.

We add the following consistency checks:

  1. Check for validating the reftable table name. This is treated as a
  warning since the reftable specification only suggests a table name
  but doesn't enforce it. Also there is a difference in the table name
  used in Git vs that in jGit.

We tighten the reftable backend by raising a REFTABLE_FORMAT_ERROR error
when:

1. The 'tables.list' file doesn't have a trailing newline.

---
Changes in v5:
- Added documentation around the return value of 'parse_names()'.
- Added a test to validate that 'git refs verify' doesn't barf against
  a clean working repository with multiple reftable tables.
- Link to v4: https://lore.kernel.org/all/20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com

Changes in v4:
- The biggest change is to iterate over the tables in a reftable stack
  for consistency checks instead of all files inside the REFTABLE_DIR.
  This avoids all race conditions. Also, since we only check the tables
  in a stack, it no longer makes sense to check file type.
- The discussion about update indices was concluded that tables indices
  in a stack must be strictly monotonically increasing. While modifying
  the code to do the same. I realized that we already have this check in
  'reftable_addition_add()' where we check while adding a new table to
  the stack: `wr->min_update_index < add->next_update_index`. So I've
  dropped this patch from the series.
- Change parse_names() to accept the output string array as an argument
  and return an error instead. This makes the flow a little easier to
  understand.
- Link to v3: https://lore.kernel.org/r/20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com

Changes in v3:
- I took a long hiatus from this topic, mostly due to other priorities.
  This has been rebased on top of '92c87bdc40 (The eighth batch,
  2025-09-12)' since there were conflicts.
- Junio suggested that two of the consistency checks (trailing newlines,
  sequential update indices for tables in stack) should actually be
  checked during runtime. I have made that change in this version.
- I've cleaned up the code and modularized the 'reftable/fsck.c' code.
- Invalid table name emits a warning, since the reftable spec doesn't
  enforce it but only makes a suggestion.
- Broken down the commits to make it easier to review.
- Link to v2: https://lore.kernel.org/r/20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com

Changes in v2:
- Ensured that 'struct reftable_fsck_info' is passed around as a
  pointer, this provides a smaller footprint (pointer size vs struct
  size).
- Run FSCK checks for other worktrees too, even if one of them fails.
- Separate messaging for table name vs table check and add additional
  test.
- Use the relative path in messages used.
- Small style and typo fixes.
- Link to v1: https://lore.kernel.org/r/20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com

---
 Documentation/fsck-msgids.adoc   |   6 +--
 Makefile                         |   3 +-
 fsck.h                           |  39 +++++++--------
 meson.build                      |   1 +
 refs.c                           |   4 ++
 refs/debug.c                     |   1 -
 refs/files-backend.c             |   3 --
 refs/reftable-backend.c          |  58 ++++++++++++++++++++---
 reftable/basics.c                |  37 ++++++++++-----
 reftable/basics.h                |   7 +--
 reftable/fsck.c                  | 100 +++++++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h         |  40 ++++++++++++++++
 reftable/stack.c                 |   7 +--
 t/meson.build                    |   1 +
 t/t0614-reftable-fsck.sh         |  58 +++++++++++++++++++++++
 t/unit-tests/u-reftable-basics.c |  24 ++++++++--
 16 files changed, 330 insertions(+), 59 deletions(-)

Karthik Nayak (7):
      refs: remove unused headers
      refs: move consistency check  msg to generic layer
      reftable: check for trailing newline in 'tables.list'
      Documentation/fsck-msgids: remove duplicate msg id
      fsck: order 'fsck_msg_type' alphabetically
      reftable: add code to facilitate consistency checks
      refs/reftable: add fsck check for checking the table name

Range-diff versus v4:

1:  4e40ab1ff7 < -:  ---------- refs/reftable: add consistency checks
2:  b91194e060 = 1:  6e3766330b refs: remove unused headers
3:  d48afbf588 = 2:  e93c0deaf7 refs: move consistency check  msg to generic layer
4:  cd7ca2a585 ! 3:  7a282473a1 reftable: check for trailing newline in 'tables.list'
    @@ reftable/basics.h: void free_names(char **a);
     - * without terminating '\0'. Empty names are discarded. Returns a `NULL`
     - * pointer when allocations fail.
     + * without terminating '\0'. Empty names are discarded.
    ++ *
    ++ * Returns 0 on success, a reftable error code on error.
       */
     -char **parse_names(char *buf, int size);
     +int parse_names(char *buf, int size, char ***out);
5:  e3e0c0b4ae = 4:  4b47088232 Documentation/fsck-msgids: remove duplicate msg id
6:  24a8d93adc = 5:  112ae21321 fsck: order 'fsck_msg_type' alphabetically
7:  d83d763be1 = 6:  3d1fc18260 reftable: add code to facilitate consistency checks
8:  d86ecd5bed ! 7:  2b628e3623 refs/reftable: add fsck check for checking the table name
    @@ Commit message
     
         So treat non-conformant file names as warnings.
     
    -    While adding the fsck header to 'refs/reftable-backend.c', order the
    -    list of headers.
    +    While adding the fsck header to 'refs/reftable-backend.c', modify the
    +    list to maintain lexicographical ordering.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ t/t0614-reftable-fsck.sh (new)
     +
     +. ./test-lib.sh
     +
    ++test_expect_success "no errors reported on a well formed repository" '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		git commit --allow-empty -m initial &&
    ++
    ++		for i in $(test_seq 20)
    ++		do
    ++			git update-ref branch-$i HEAD || return 1
    ++		done &&
    ++
    ++		# The repository should end up with multiple tables.
    ++		test_line_count ">" 1 .git/reftable/tables.list &&
    ++
    ++		git refs verify 2>err &&
    ++		test_must_be_empty err
    ++	)
    ++'
    ++
     +for TABLE_NAME in "foo-bar-e4d12d59.ref" \
     +	"0x00000000zzzz-0x00000000zzzz-e4d12d59.ref" \
     +	"0x000000000001-0x000000000002-e4d12d59.abc" \


base-commit: a483264b01b977f3e65a4419103c21e6af7412a2
change-id: 20250714-228-reftable-introduce-consistency-checks-379ded93c544

Thanks
- Karthik

