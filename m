Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698BC1758B
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579039; cv=none; b=D4TxQv3MC/rp4YHo5BmOncTrecAt7068WZ+a7U06qmm2TGY3EUgpuw9okFBGjopgBJuLf1tWRdcBoKBe7sT/PZS3TH6bAa3UXfah36RUHArS/QZbYkBgquD6Nstsl4GJlZqVQJ1ckSGNtNTip81awl8I7fz2keavpibgIhsc78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579039; c=relaxed/simple;
	bh=4r4iUawROx1d6iT+99wjYemoeGCIsw2ATnLhsKJ5F64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxr20qIINHkQSzsSa4VHTbglZWX/nJZIeq537nI114FCjfWPOfKuzC64xNUExLVBJjTC6WbBWV6Is6FsGMZgz2jB/2yLcKoRrZfL7/UktXlGJUgP+smNmRshX5tyHIzQ0fyPAIy6QJ+aKubAeoNscWWRDTwaUwUxRV9+PigfA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc5sVlcB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc5sVlcB"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso824614a12.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754579037; x=1755183837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5kjXKJVBOBWBzK/2sYW9VjCbu/Ul9pHRAzPS2ubO1U=;
        b=Lc5sVlcBj3tHzYTTTdrEHJI7CPe15lYr1474uaCjWJmubnqHUocEClpjql37eXZe3+
         OAIx6TnRkc1gpQ3HU43EPNoQggc+Ydq2A1udtowUo06EP93IyoqB7UbUHjsTXZ6UY8lF
         1pAd0bfdCO/aSDIt0TM+uF520MMiITuI6dNBtzlGkINBJt2r3K9qebdI5CJbsWBi3e5f
         rYHEoQE3oUysSh/yUG3yg0WYMt9lkgKbtkWo+vQVQWaIJGUFQsMatqnGeeTMFaTS08V5
         XE6k2C1PXcW3M3HLKap8VANfZD9KDedOihnKPNmJ9SadEYCO4cSNZ8zZ1tOw1KzGCwkZ
         YEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579037; x=1755183837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5kjXKJVBOBWBzK/2sYW9VjCbu/Ul9pHRAzPS2ubO1U=;
        b=L4+bAcvgNCRv7p6fePd2Iw1EPYkjY4+FuVJYnQNA5XAZznzJt5/AkaehV95hMwDU9p
         CB9WxgAu6+Kr9FhUFwoerS+Dq42IH5gHvSKjk0q8JbmHEnvnkYPuTzwvzC5RZs/4+wfT
         oukryaTeHuDz1VHXIsMvNyBg5VccnGhYe6zjl/g8BNchSG9IdUPK7DaZfVdsjIebbt70
         YCjCXPs26zzQ6CMzqTUnt8059pc9zbaa/vXVdxYtmwyb0bKaXuNFJ8Xnn4k6K6qUtWgs
         inFA1xahIDfvOgAXfjHCuMfsfmzA2Rv45G4AsKwLzLpdhUX9Xp6GqPl8QSR/+cP63Tn4
         Av+g==
X-Gm-Message-State: AOJu0YxXKIXaqKDXluE3+tMO6AzSYPjFbufM+k1Ew4I3RqPPjnFpRd0b
	6gKAPNJGMtxPASsjXkB6yNnguG2cqjOlkmfcnBGtc+7bmIT73jxuGF4Jsc2FGA==
X-Gm-Gg: ASbGnct6zl+SVe9ZRa7B2ufU6p4b5CEeD43wgwVAjyagM4Y0SCpwwfpkVhEnijP5RBF
	LGSVgM3lMMOiN4p0/kWE+EMXvvVa1iBdvPm0Bq4ay8GvY8O+KgZFblZ/4FlL9ZQjBoEYP9nEVXa
	G1fMVs7RjjxvBSDjGRMP1lN4hiEIfNRHEhEneHbBhTT5tOg/Y81W4yz9ADFY8zIlRqOTTyiIeQw
	iAvZC8pgFTgahwdTzlwXW+hh6ron2vebBkZH5VcGs00KST50aoW/zb3ohtQLj+GTANv+euslN+S
	7QWrAYlzK5nwiNusCO4ZIPkrA8DQeA61R0sstatSCRhOVPn4QQnzkDqqDXLEVwhPJIn2+e5YQlq
	sWPoFvVNTUcZI77WgCa/u0+Hub3c5rHc5NaxkRBNYSQ6/cxAf5AdTywuuV3fpfA==
X-Google-Smtp-Source: AGHT+IF4SbGaz32ipr3xk7GemRn4WxWjl8PAO7aG8YtOYpmAY3Q8yl5hF+t8CaHtiCM135XPj2hSuw==
X-Received: by 2002:a17:903:189:b0:240:bf61:fee3 with SMTP id d9443c01a7336-2429f6556f8mr105769035ad.44.1754579036917;
        Thu, 07 Aug 2025 08:03:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8359:45d5:14c8:c621:17ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm106617065ad.54.2025.08.07.08.03.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:03:56 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	jn.avila@free.fr,
	sunshine@sunshineco.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v9 0/5] repo: add new command for retrieving repository info
Date: Thu,  7 Aug 2025 12:02:34 -0300
Message-Id: <20250807150239.6987-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Thank you all for your time reviewing and helping me with this patchset!

This v9 only solve tiny nitpicks pointed by Karthik and Patrick in v8,
just to make clear that everything is ok!

Junio, would you mind to replace v8 by this v9 as lo/repo-info in seen?

Here's the range-diff:

1:  3c2ede66be = 1:  3c2ede66be repo: declare the repo command
2:  396bee171a ! 2:  b18e74763d repo: add the field references.format
    @@ t/t1900-repo.sh (new)
     +	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
     +
     +test_expect_success 'git-repo-info fails if an invalid key is requested' '
    -+	echo "error: key '\'foo\'' not found" >expected_err &&
    ++	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
     +	test_must_fail git repo info foo 2>actual_err &&
     +	test_cmp expected_err actual_err
     +'
3:  4dbc83c64c ! 3:  35916b210e repo: add the field layout.bare
    @@ t/t1900-repo.sh: test_repo_info 'ref format files is retrieved correctly' '
     +	'git init --bare' 'bare' 'layout.bare' 'true'
     +
      test_expect_success 'git-repo-info fails if an invalid key is requested' '
    - 	echo "error: key '\'foo\'' not found" >expected_err &&
    + 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
      	test_must_fail git repo info foo 2>actual_err &&
     @@ t/t1900-repo.sh: test_expect_success 'only one value is returned if the same key is requested twi
      	test_cmp expect actual
    @@ t/t1900-repo.sh: test_expect_success 'only one value is returned if the same key
     +	references.format=files
     +	EOF
     +	git init --ref-format=files two-keys &&
    -+	git -C two-keys repo info layout.bare references.format > actual &&
    ++	git -C two-keys repo info layout.bare references.format >actual &&
     +	test_cmp expected actual
     +'
     +
4:  5c65a24df4 ! 4:  91fc5c4e50 repo: add the field layout.shallow
    @@ t/t1900-repo.sh: test_repo_info 'bare repository = false is retrieved correctly'
     +	git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
     +
      test_expect_success 'git-repo-info fails if an invalid key is requested' '
    - 	echo "error: key '\'foo\'' not found" >expected_err &&
    + 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
      	test_must_fail git repo info foo 2>actual_err &&
5:  923b491324 ! 5:  8af32d7066 repo: add the --format flag
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repo
     +			printf("%s\n%s%c", key, valbuf.buf, '\0');
     +			break;
     +		default:
    -+			BUG("%d: not a valid output format", format);
    ++			BUG("not a valid output format: %d", format);
     +		}
      	}

    @@ t/t1900-repo.sh: test_repo_info 'bare repository = true is retrieved correctly'
     +	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'

      test_expect_success 'git-repo-info fails if an invalid key is requested' '
    - 	echo "error: key '\'foo\'' not found" >expected_err &&
    + 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
     @@ t/t1900-repo.sh: test_expect_success 'output is returned correctly when two keys are requested' '
      	test_cmp expected actual
      '

Lucas Seiki Oshiro (5):
  repo: declare the repo command
  repo: add the field references.format
  repo: add the field layout.bare
  repo: add the field layout.shallow
  repo: add the --format flag

 .gitignore                  |   1 +
 Documentation/git-repo.adoc |  81 ++++++++++++++++++
 Documentation/meson.build   |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/repo.c              | 165 ++++++++++++++++++++++++++++++++++++
 command-list.txt            |   1 +
 git.c                       |   1 +
 meson.build                 |   1 +
 t/meson.build               |   1 +
 t/t1900-repo.sh             | 102 ++++++++++++++++++++++
 11 files changed, 356 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c
 create mode 100755 t/t1900-repo.sh

-- 
2.39.5 (Apple Git-154)

