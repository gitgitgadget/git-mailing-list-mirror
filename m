Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B8239E75
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856986; cv=none; b=lW5aDypFva0GzyFhOaRgU2Td2yGEKoIUPxXkYJbeh9hJMUxs3K6G9GU1I2HSg6/Fu8JbntHckIa628NwBND2A7zrrUTvILXVp8lbJcvsbdioZTUumRcSJ/fY5u0KyWrIt7ixzISNt7mddY6/cNRlmb5x/nko8Hb7eSb/gCSzKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856986; c=relaxed/simple;
	bh=/hvfr3n8KF3sW67i3luQbIU+Qgaxc7L42sK1MF0JyPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPACPBzbW1kCAGGqOroSwR04tsDZfr9DrfTlF3/drz1MmOJj3pq5LtjStMnRujKIav3PbY8tnseLa5HLpxZjF0wmSCGoO+SKdMIRou53gsPwgB3YGR2LTSIlxDreNGZDniwZ4tZS8M2xtUxPWm12PMhbwe9/0j9gT2m7O4jU0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpbvtGne; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpbvtGne"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1233702afd3so6016274c88.0
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 13:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768856984; x=1769461784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZrwhLlT60WpuSvjkjwKiaBhz4nKk2Pp9DzBequvtWc=;
        b=mpbvtGnegJQ0t/lZkfBc2qkAWswUHC9CIRrDuTBtVIm+kn6+OUs+xTW4jEbntikJek
         G2lDi1ifM/UR1b2dnqX8f4tAmLfW/gP53FKg/4dKNopOSg8WQe8xzgnG+oO0jy+WkypV
         TQGvkqp6M49GcWOEc3sH4/BApEDupKPCi+/Xjojj+hEI+OmuuuLDc9hqsVm6yNuhZLEB
         vZMhb0cOARHi3TOD6404ZRDcPT6mUClVkNWyLaDTxe2/C2LjBu54UBcQtTi0lfI+JSaY
         kSIOVlZ1fS3TayBjhtfzA7hnCZjIOhCQbMchvq1JYSX8bKuw1f+okfCvPCyp3ElCj5K2
         s3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768856984; x=1769461784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZrwhLlT60WpuSvjkjwKiaBhz4nKk2Pp9DzBequvtWc=;
        b=hJhMJqErftgiw5ucnt1mjSCaNUj7VEhMDlZfciPRUY6zRBZOsTAguzxmUNoLmGrfdU
         wBHgmy4HPjfu/+IAkoP34md+HlLBo0U3AbpFFSL8ZQEuMbW465oGXo6bWZK0JM90RKR3
         NU+waBjRECnDt0aVrfC39FZM9prbjRWrNK3T/jhzVr/hr4ac2DoaTciwYrPpamOSbOZA
         cU6A2rR6FyWTZjQI7SGfx3uemDZ+Nsniiqh5ta2mJeb/N658eKM3u7LmpXBoXO6A/HL0
         Ev/cECPgBW1YIQU9a8CSulknrZwFSoJmthUAejiUWrjw/Y47XVNH3o3z30rmc/B7A9s4
         nTag==
X-Gm-Message-State: AOJu0YyiXxApnxln308tUjUwT5akQlBQ3L/X7nIKIRruJ9p+NNvP5u3f
	qYCu7w+OzWxLg2HnItd8UZ9N9DEn4qO0yBk56Q0pzcZHjX6x/jXe2Gnw1EqFLw==
X-Gm-Gg: AY/fxX6QSHCXLMz/aBTcNb2uyv7ZWzSaN7wdTjaVOj9IDhWk4gWOzcGPWSIWpeIYDO1
	PL8tkhFUa88Ad1D2hl54QTqNlobJ7u4zWG9r+zjqxIpbI9dR5GTQxnS8Z5zoayiNgLgXaXAn60i
	HaAjfK9766Af53KCzs+ebERgMVHfm6SMAVUiLcC71FU6lMwfwWY3UonZ/Tspp/vmD6eOBMuNzPi
	R7tTwUhHitBsuUutt5adenFQGVDjWC/jNg87qBoBREYe6TCNiBbT5vCBX/3j3UApTJwCE3VHgfl
	R1ha7u63UrefnLBxBZCAZrddp+q2zm2fHWgLZ5fUiHuTzSAxUh5ihZ49SvcHqb62wHYHQGhFa9q
	76W42C2JqO6krJDSyd5si2Pwl2Ir2MjoyV2lzEWQFKEbVV4xWA1M7X2rH5wBNQ0hJdXOWhH1YrG
	p1fUFtfcNSKdHBwaNtpfacSHndTfuRRowL2QQhtVvaYG6x0TY=
X-Received: by 2002:a05:7022:619d:b0:122:8d:3688 with SMTP id a92af1059eb24-1244a73bacdmr9200253c88.22.1768856984150;
        Mon, 19 Jan 2026 13:09:44 -0800 (PST)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac57fd0sm16935706c88.3.2026.01.19.13.09.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jan 2026 13:09:43 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v4 0/2] repo: add --format=default and --keys
Date: Mon, 19 Jan 2026 17:20:18 -0300
Message-ID: <20260119210932.68893-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, again!

This v4 addresses these two issues:

1. NUL was replaced by _NUL_ in the documentation
2. Now, the default output format of `git repo info --keys` is "lines"
   and "default" is a synonym for it. I prefer to called it "lines"
   instead of "newline" (as suggested by Patrick) because I thought that
   it would be clear to the user

Lucas Seiki Oshiro (2):
  repo: add a default output format to enum output_format
  repo: add new flag --keys to git-repo-info

 Documentation/git-repo.adoc | 33 +++++++++++++++++-----
 builtin/repo.c              | 56 ++++++++++++++++++++++++++++++++++---
 t/t1900-repo.sh             | 54 +++++++++++++++++++++++++++--------
 t/t1901-repo-structure.sh   | 22 +++++++++++++++
 4 files changed, 143 insertions(+), 22 deletions(-)

Range-diff against v3:
1:  97f8eee687 = 1:  7dabd62250 repo: add a default output format to enum output_format
2:  0c7d3bca32 ! 2:  fba621fc4f repo: add new flag --keys to git-repo-info
    @@ Documentation/git-repo.adoc: SYNOPSIS
      --------
      [synopsis]
      git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]
    -+git repo info --keys [--format=(default|nul) | -z]
    ++git repo info --keys [--format=(default|lines|nul) | -z]
      git repo structure [--format=(default|table|keyvalue|nul) | -z]
      
      DESCRIPTION
    @@ Documentation/git-repo.adoc: supported:
      +
      `-z` is an alias for `--format=nul`.
      
    -+`info --keys [--format=(default|nul) | -z]`::
    ++`info --keys [--format=(default|lines|nul) | -z]`::
     +	List all the available keys, one per line. The output format can be chosen
     +	through the flag `--format`. The following formats are supported:
     ++
     +`default`:::
    ++	synonym for `lines`.
    ++
    ++`lines`:::
     +	output the keys one per line.
     +
     +`nul`:::
    -+	similar to `default`, but using a NUL character after each value.
    ++	similar to `default`, but using a _NUL_ character after each value.
     +
      `structure [--format=(default|table|keyvalue|nul) | -z]`::
      	Retrieve statistics about the current repository structure. The
    @@ builtin/repo.c
      
      static const char *const repo_usage[] = {
      	"git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]",
    -+	"git repo info --keys [--format=(default|nul) | -z]",
    ++	"git repo info --keys [--format=(default|lines|nul) | -z]",
      	"git repo structure [--format=(default|table|keyvalue|nul) | -z]",
      	NULL
      };
    +@@ builtin/repo.c: enum output_format {
    + 	FORMAT_TABLE,
    + 	FORMAT_KEYVALUE,
    + 	FORMAT_NUL_TERMINATED,
    ++	FORMAT_LINES
    + };
    + 
    + struct field {
     @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
      	return 0;
      }
    @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
     +{
     +	char sep;
     +
    ++	if (format == FORMAT_DEFAULT)
    ++		format = FORMAT_LINES;
    ++
     +	switch (format) {
    -+	case FORMAT_DEFAULT:
    ++	case FORMAT_LINES:
     +		sep = '\n';
     +		break;
     +	case FORMAT_NUL_TERMINATED:
    @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
      static int parse_format_cb(const struct option *opt,
      			   const char *arg, int unset UNUSED)
      {
    +@@ builtin/repo.c: static int parse_format_cb(const struct option *opt,
    + 		*format = FORMAT_KEYVALUE;
    + 	else if (!strcmp(arg, "table"))
    + 		*format = FORMAT_TABLE;
    ++	else if (!strcmp(arg, "lines"))
    ++		*format = FORMAT_LINES;
    + 	else if (!strcmp(arg, "default"))
    + 		*format = FORMAT_DEFAULT;
    + 	else
     @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
      {
      	enum output_format format = FORMAT_DEFAULT;
    @@ t/t1900-repo.sh: test_expect_success '--format=default resets the format' '
     +	test_cmp expect actual_all &&
     +	test_cmp expect actual_key
     +'
    ++
    ++test_expect_success 'git repo info --keys uses lines as its default output format' '
    ++	git repo info --keys --format=lines >expect &&
    ++	git repo info --keys --format=default >actual_explicit &&
    ++	git repo info --keys >actual_implicit &&
    ++	test_cmp expect actual_explicit &&
    ++	test_cmp expect actual_implicit
    ++'
     +
      test_done
-- 
2.50.1 (Apple Git-155)

