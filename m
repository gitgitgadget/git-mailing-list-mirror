Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA5317713
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755384392; cv=none; b=U3IrtV3g8mBqnGIUCnVFYcKCnELDjayvuJwAQWcPK92wpgV7me+KgCY5Lj0trQLDUWmbMSvwzQDgZ6EBkqzZIYMyGQSVolsSj7pWCv2l6ppRnL0WOyEFZdWYzSt6ZMWkwywxOX0+YOOHwaOwO+ElB+UR3jGjcGHQliUtGVTknmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755384392; c=relaxed/simple;
	bh=2H9+mXRdqSALaKcxxJn6CrnaBnTpzBwMI/dbLHsXvgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqjxJKm+J4jrXtdg9qAk3DMx0lmSKYOdbJkIh9jWfAtGQM6meUkhoDo/cRZpaQb+fw3OhA2W5ZIi8Ch8ZIiTuMdfETL7kDtxhiu4OkgpUh0OAF6+xrgkWHW7cPHQXKANXyRceWyGBArlGYdsRJT0LQkesyO2sWKVPsTknje8ORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnnAYspp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnnAYspp"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso1812225b3a.3
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755384390; x=1755989190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PGcaaLLpmxb8tjzwGIKmwo5hynHY+IPfZtJmKDbGVo=;
        b=DnnAYsppZ1V0AlpwP+ZmDpJ7SZq/GJ7Uo8U0qBuYf4Zr4QkX5jBtfdRnQM/OuF9dsM
         KXAwPCnXybgdWL0JzYaJtgtol0PhZXtHsNFTRMyTdlPw4iafaZyPKZ0m5a8HQlUcfjna
         S0edGnOi/jBJ49cfREMfoPzcJOw43y3tRfyi+UGX3RlM11UDrLnmaRmVxzZn4Bw50Ek6
         RsprTNBmwRPHhoDs6Xxt9OuuEpdFW9P9E38k10TMbQCUJj0Ny8BTWBlobiZ77GG4X9uF
         qT/te9T/hSHSxLPRm7tw9W/3JSDiNuMQpo+rI+Ni6hfBco7UhfE3rCT8P0AXdTiUo/n2
         Lthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755384390; x=1755989190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PGcaaLLpmxb8tjzwGIKmwo5hynHY+IPfZtJmKDbGVo=;
        b=JSSSG6je/LEtDM4QMY0G6Qw9o53ED8fh5n0GkTwrBdEyrNDi9biyHjyPRY64F7okeb
         gXONK4Ib53oDy6oZ3xldS1uTQXkhJjIsQ2CDnt5sRKX27Ig/imnXLCa1If5x9ZRI9QOZ
         xtggA7urebNO/DbRAJCnjrWKHmjTFYlgX1qmS9INn3/y6d0Q6JfjcTHWBaxFRXT+G+e1
         MulS35+djhM9/hnLT1/33gGpwQiAO+fLjrSMliP7USIXelecx1Ew9VqC/Nd6MMGGILLE
         IAIJ+fM79tIRLsJrSoxMSGcBaPZKNLw14bSDOdhhqdi6oXq0n1p05orf86bd1IscaOMi
         dtzw==
X-Gm-Message-State: AOJu0YzyZ1zEqi3j0CpyVpeyGTHEWyZ6r/pZT/uC2ZVYqtDHltRjwVaB
	1JkC6Tzg1MavINLkEDHxDDT0bwDrU9FmK/xKsfA7uz1XtM7SZlqTzejN6XkIBg==
X-Gm-Gg: ASbGnct3skxSRTC2O7tcmXqUU0sRSqaeX/bCgdZzZ3VEBTumcET4j1qyIgxbPD1UF+R
	JHW+DeejhoCaZ0gnvQQ/SHdA3PfilsdPRfAO4T5XQ4nVGzcfhRDZ/jlXzcjrYRGdSP8/Uqmv7od
	ySKkyK+svL6Hxlv9sgnIfQtWGtYAry2hEOOck4/otAGnANY1xpTRbUTCORhmIu3yWl1vR0dTXli
	tuzUJpibzOKXh6yLezDj6C0LL6jDvBamarq/GMHNhz9niSgjB83g2fEpQiBul+H52VkXiIym09t
	FsuiW/PTjDbkp6Dorm94aCX7ozGEO/aa+4wopxgY+rUZx+9Hs6NgeEikHOh8nSyP8hEBhTaBLhC
	KWYs2AhrTkUyK/+FdU75toSwVxJ9mjIGJacpwdKylhlA0cRbOz4kZqHlqD+cCrw==
X-Google-Smtp-Source: AGHT+IGRJQmIw6etJwzpMaEdq7dr56VbniqM+QF82wNZqAgKsAEHZkJhZuZ04Tg/b5HcP++m9Ua5xw==
X-Received: by 2002:a05:6a21:999c:b0:232:4a42:dfd1 with SMTP id adf61e73a8af0-240d2ff67b2mr10708940637.36.1755384390128;
        Sat, 16 Aug 2025 15:46:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:e855:1cad:1392:e988])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5ad0f7sm4617280a12.2.2025.08.16.15.46.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 16 Aug 2025 15:46:29 -0700 (PDT)
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
Subject: [GSoC PATCH v11 0/5] repo: declare the repo command
Date: Sat, 16 Aug 2025 19:45:58 -0300
Message-Id: <20250816224603.3307-1-lucasseikioshiro@gmail.com>
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

This v11 addresses the minor issues pointed by Junio in v10. They are mostly
spelling changes:

- using "expect" and "actual" in all test_cmp calls, even when we're capturing
  stderr

- indent list items in the documentation

- use a nested description list when describing the possible values of --format

- spelling: "NUL characters" instead of "null characters"

- initialize the repository in `test_repo_info` outside the test cases,
  creating a single repository for both keyvalue and nul formats

Here's the rangediff versus v10:

1:  6767028da3 = 1:  6767028da3 repo: declare the repo command
2:  c44e2d1619 ! 2:  1a3fa8e12f repo: add the field references.format
    @@ Documentation/git-repo.adoc: COMMANDS
     +values that they return:
     +
     +`references.format`::
    -+The reference storage format. The valid values are:
    ++	The reference storage format. The valid values are:
     ++
     +include::ref-storage-format.adoc[]

    @@ t/t1900-repo.sh (new)
     +	key=$4
     +	expected_value=$5
     +
    ++	test_expect_success "setup: $label" '
    ++		eval "$init_command $repo_name"
    ++	'
    ++
     +	test_expect_success "$label" '
    -+		eval "$init_command $repo_name" &&
    -+		echo "$key=$expected_value" >expected &&
    ++		echo "$key=$expected_value" >expect &&
     +		git -C $repo_name repo info "$key" >actual &&
    -+		test_cmp expected actual
    ++		test_cmp expect actual
     +	'
     +}
     +
    @@ t/t1900-repo.sh (new)
     +	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
     +
     +test_expect_success 'git-repo-info fails if an invalid key is requested' '
    -+	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
    -+	test_must_fail git repo info foo 2>actual_err &&
    -+	test_cmp expected_err actual_err
    ++	echo "error: key ${SQ}foo${SQ} not found" >expect &&
    ++	test_must_fail git repo info foo 2>actual &&
    ++	test_cmp expect actual
     +'
     +
     +test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
    -+	echo "references.format=$(test_detect_ref_format)" >expected &&
    ++	echo "references.format=$(test_detect_ref_format)" >expect &&
     +	test_must_fail git repo info foo references.format bar >actual &&
    -+	test_cmp expected actual
    ++	test_cmp expect actual
     +'
     +
     +test_done
3:  e3009a85e1 ! 3:  a3b05def63 repo: add the field layout.bare
    @@ Documentation/git-repo.adoc: In order to obtain a set of values from `git repo i
      values that they return:

     +`layout.bare`::
    -+`true` if this is a bare repository, otherwise `false`.
    ++	`true` if this is a bare repository, otherwise `false`.
     +
      `references.format`::
    - The reference storage format. The valid values are:
    + 	The reference storage format. The valid values are:
      +

      ## builtin/repo.c ##
    @@ t/t1900-repo.sh: test_repo_info 'ref format files is retrieved correctly' \
     +'
     +
      test_expect_success 'git-repo-info fails if an invalid key is requested' '
    - 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
    - 	test_must_fail git repo info foo 2>actual_err &&
    + 	echo "error: key ${SQ}foo${SQ} not found" >expect &&
    + 	test_must_fail git repo info foo 2>actual &&
4:  3837899c32 ! 4:  034dd414e5 repo: add the field layout.shallow
    @@ Commit message
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: values that they return:
      `layout.bare`::
    - `true` if this is a bare repository, otherwise `false`.
    + 	`true` if this is a bare repository, otherwise `false`.

     +`layout.shallow`::
    -+`true` if this is a shallow repository, otherwise `false`.
    ++	`true` if this is a shallow repository, otherwise `false`.
     +
      `references.format`::
    - The reference storage format. The valid values are:
    + 	The reference storage format. The valid values are:
      +

      ## builtin/repo.c ##
5:  19fdfce646 ! 5:  442a3b7afa repo: add the --format flag
    @@ Commit message
         - keyvalue, where the retrieved data is printed one per line, using =
           for delimiting the key and the value. This is the default format,
           targeted for end users.
    -    - nul, where the retrieved data is separated by null characters, using
    +    - nul, where the retrieved data is separated by NUL characters, using
           the newline character for delimiting the key and the value. This
           format is targeted for being read by machines.

    @@ Documentation/git-repo.adoc: COMMANDS
     +The output format can be chosen through the flag `--format`. Two formats are
     +supported:
     ++
    -+* `keyvalue`: output key-value pairs one per line using the `=` character as
    -+the delimiter between the key and the value. Values containing "unusual"
    -+characters are quoted as explained for the configuration variable
    -+`core.quotePath` (see linkgit:git-config[1]). This is the default.
    ++`keyvalue`:::
    ++	output key-value pairs one per line using the `=` character as
    ++	the delimiter between the key and the value. Values containing "unusual"
    ++	characters are quoted as explained for the configuration variable
    ++	`core.quotePath` (see linkgit:git-config[1]). This is the default.
     +
    -+* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
    -+between the key and the value and using a null character after each value.
    -+This format is better suited for being parsed by another applications than
    -+`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
    ++`nul`:::
    ++	similar to `keyvalue`, but using a newline character as the delimiter
    ++	between the key and the value and using a NUL character after each value.
    ++	This format is better suited for being parsed by another applications than
    ++	`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.

      INFO KEYS
      ---------
    @@ Documentation/git-repo.adoc: COMMANDS
      In order to obtain a set of values from `git repo info`, you should provide
      the keys that identify them. Here's a list of the available keys and the
      values that they return:
    -@@ Documentation/git-repo.adoc: The reference storage format. The valid values are:
    +@@ Documentation/git-repo.adoc: values that they return:
      +
      include::ref-storage-format.adoc[]

    @@ builtin/repo.c: static int print_fields(int argc, const char **argv, struct repo

      ## t/t1900-repo.sh ##
     @@ t/t1900-repo.sh: test_repo_info () {
    - 	key=$4
    - 	expected_value=$5
    + 		eval "$init_command $repo_name"
    + 	'

     -	test_expect_success "$label" '
    --		eval "$init_command $repo_name" &&
    --		echo "$key=$expected_value" >expected &&
    +-		echo "$key=$expected_value" >expect &&
     -		git -C $repo_name repo info "$key" >actual &&
    -+	repo_name_keyvalue="$repo_name"-keyvalue
    -+	repo_name_nul="$repo_name"-nul
    -+
     +	test_expect_success "keyvalue: $label" '
    -+		eval "$init_command $repo_name_keyvalue" &&
    -+		echo "$key=$expected_value" > expected &&
    -+		git -C "$repo_name_keyvalue" repo info "$key" >actual &&
    - 		test_cmp expected actual
    ++		echo "$key=$expected_value" > expect &&
    ++		git -C "$repo_name" repo info "$key" >actual &&
    + 		test_cmp expect actual
      	'
     +
     +	test_expect_success "nul: $label" '
    -+		eval "$init_command $repo_name_nul" &&
    -+		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
    -+		git -C "$repo_name_nul" repo info --format=nul "$key" >actual &&
    -+		test_cmp_bin expected actual
    ++		printf "%s\n%s\0" "$key" "$expected_value" >expect &&
    ++		git -C "$repo_name" repo info --format=nul "$key" >actual &&
    ++		test_cmp_bin expect actual
     +	'
      }

      test_repo_info 'ref format files is retrieved correctly' \
     @@ t/t1900-repo.sh: test_expect_success 'git-repo-info outputs data even if there is an invalid fiel
    - 	test_cmp expected actual
    + 	test_cmp expect actual
      '

     +test_expect_success 'git-repo-info aborts when requesting an invalid format' '
    -+	echo "fatal: invalid format ${SQ}foo${SQ}" >expected &&
    -+	test_must_fail git repo info --format=foo 2>err &&
    -+	test_cmp expected err
    ++	echo "fatal: invalid format ${SQ}foo${SQ}" >expect &&
    ++	test_must_fail git repo info --format=foo 2>actual &&
    ++	test_cmp expect actual
     +'
     +
      test_done

Lucas Seiki Oshiro (5):
  repo: declare the repo command
  repo: add the field references.format
  repo: add the field layout.bare
  repo: add the field layout.shallow
  repo: add the --format flag

 .gitignore                  |   1 +
 Documentation/git-repo.adoc |  84 ++++++++++++++++++++
 Documentation/meson.build   |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/repo.c              | 150 ++++++++++++++++++++++++++++++++++++
 command-list.txt            |   1 +
 git.c                       |   1 +
 meson.build                 |   1 +
 t/meson.build               |   1 +
 t/t1900-repo.sh             |  95 +++++++++++++++++++++++
 11 files changed, 337 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c
 create mode 100755 t/t1900-repo.sh

-- 
2.39.5 (Apple Git-154)

