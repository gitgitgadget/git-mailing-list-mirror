Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BA31B133
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993963; cv=none; b=iM4UDqRdyXW7GRFM2Jp/2/6I1dJFhrJrFI4b1hciiyXKJfSXNYReJ6al3lZ6WLr6l2m0jDgr0u+NKVOJx+zQHBgCsRc9zYr0KBXWSjos6gbHvygx1JXlQf7kaj7yG3ig3Gp85ExLfO7K2nnf5EvFr1bDYAQdWEWnEG6PG42AD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993963; c=relaxed/simple;
	bh=EJi3A4ntgZ1VJLqGjkC8fjy0tS6S5rzOiViMQqayed8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxKREvHt6K9rQUCbhqVsghzi534YsEJBTjQoAHpQWiiZ2/5u6xp57ZbsWLqaojvf48zfJJOsd7KJ/UWvC8Z62w8n9UJ9T+9iAGICVllBly/HJYzOQ27u6A3zfcbVMsnyxLj2XeRKDVM2CuU3CYa+YyPhc3OpY7+4PVTZeQo0ibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+kUMEVJ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+kUMEVJ"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-563641b24b9so503501e0c.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 13:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767993961; x=1768598761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCP/krCJFxgMPH0c31wDLt1a//lYFzjDNuNXirkQWOc=;
        b=S+kUMEVJxSSoWDzywaZlKlODM1dFqzU49RpVGl+ao/zsZMSzTssp64G6zdYHgVE0LO
         bier9r6oyW4MtK3wMPz9ScE7vtm6IDszq+x83qTnIeh5c06okUkNo/h2SkBVjrh+uWCY
         p/HNecADus9lmCTFL2w5lAAT8UbY0s+hlCW8Qjml/W/vZZsi9PcfMjP7ye2kjm0PFbnu
         IeIoTzSpjIacQGhViG5rNRxSZhPR3QYjAfQCKwwsTgFQbqLzNybyimX9yfAeLT+lYzUA
         V1kKps9aOsa4hxv4iyM569q6mc/wn0hgoIaYublWqBftao0A1g5AnYByshspn1NxuX7G
         0EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767993961; x=1768598761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCP/krCJFxgMPH0c31wDLt1a//lYFzjDNuNXirkQWOc=;
        b=kP+zURfoYsgKmAHoSfUs+YE/cpvv+kSLciz83MNNjQ5eLc3A41gMI2pOeBfCPW60fb
         xZryds1RkefFmZYERu9keQaLbw4RZLgSNevp8P0CnQVwjbzqWdGfgSp8yYtDg1pUhI7f
         1CJtzOoWbbcs2fFUsmTzuod7uyvpgl5tvnOcaaKNMEOhXquYKlyh9wlZDyzBl8uk3sG9
         mUc9zydTN0HbbgJ8Cxkocqr6q1bErIXEk1FkKFWZjsp16CbvoNRAj6h/ufDHhEJYU/CO
         gBWI5GDRblH/8wKLKDzMDrQTD1fDrmVT6O6CDX767S49CznKK4yh96HwQz+TUBlF6ZAr
         3xcA==
X-Gm-Message-State: AOJu0YyFpeOSvpl25/w2dfqnwxekMXVs4FZXrY0sLLnslYYBxScHNR2h
	WPkHyD+lV5hCQmyN8IvN5NC/IBIGrXe914tu1pfyUqtTS4zZcK7qhgOQF5P//A==
X-Gm-Gg: AY/fxX5WK3G3+1OipUcBZpA5RqEe7NOd+YcU+05SUcWT5vIPEhsN+MegCIHjlEX2xCv
	vmYyzy7dXdF+owWsM5o0d41cwNIU+I3Sx2tOKju7F4Pf0XT6e0kPA/Nd1gOFeTpDLjMdlfscIYp
	47KozLEYreeRPWieQ0FWV9gEkJA7dwnuuyFe9HcZmtlRMGdrsBCaHwAdAwTRq5VYZoMX2G0H0Ce
	Q/kbSfHvffHANnpiWpISW6J2J0ua1mXTM5EsRZBsfuCkepb37SugraynUXDqKsDZLpVAxUq4Aq9
	kBmSfBBNkC/SHPFrWX92y2kwYVDXnrWsaXAyJ+JrmuahDEt0pJPs5JQSU+w+E13Irv/1YTTHg6+
	vUU3zQVl+hoK81wLB6OrgGf15Hzcwm4NMAtjwG2id0fg+kTtxY08dCxEbJ2DCxMtEibE8xR2pvh
	XPF8N9h9nEJQknEKtxJ2RnOXW7MuxBo6T6M49MljsEYLGBVaOfKzLugW7v
X-Google-Smtp-Source: AGHT+IHrS91HzY8XUTI6eoxCXeWKyLmHPaq4x1SpgmTiPfnOERPF+8+LJp2JQXf5YSNt0quQpG5JBQ==
X-Received: by 2002:a05:6122:3c4f:b0:55f:e06c:442e with SMTP id 71dfb90a1353d-56347fad1f6mr3697162e0c.13.1767993961087;
        Fri, 09 Jan 2026 13:26:01 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:586:c136:4246:ee92:fdfb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5633a443e32sm10595955e0c.22.2026.01.09.13.25.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jan 2026 13:26:00 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v3 0/2] repo: add --format=default and --keys
Date: Fri,  9 Jan 2026 17:31:51 -0300
Message-ID: <20260109211554.90828-2-lucasseikioshiro@gmail.com>
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

Hi!

The main change in this version is that git-repo-structure now supports
`--format=default`. This way, both git-repo-info and git-repo-structure
now can be used with `--format=default`, which resets the output format
to the default one (`keyvalue` in repo-info, `table` in repo-structure).

I'm also cc'ing Justin to see if he agrees with this change to
git-repo-structure.

Lucas Seiki Oshiro (2):
  repo: add a default output format to enum output_format
  repo: add new flag --keys to git-repo-info

 Documentation/git-repo.adoc | 30 ++++++++++++++++------
 builtin/repo.c              | 50 ++++++++++++++++++++++++++++++++++---
 t/t1900-repo.sh             | 46 ++++++++++++++++++++++++++--------
 t/t1901-repo-structure.sh   | 22 ++++++++++++++++
 4 files changed, 126 insertions(+), 22 deletions(-)

Range-diff against v2:
1:  9eb2549806 ! 1:  97f8eee687 repo: add a default output format to enum output_format
    @@ Metadata
      ## Commit message ##
         repo: add a default output format to enum output_format
     
    -    Add a `FORMAT_DEFAULT` value to `enum output_format`. Change the initial
    -    value of `format` to `FORMAT_DEFAULT` in cmd_repo_info, indicating that
    -    the initial value hasn't been changed. Also map the string "default" to
    -    this new value in `parse_format_cb`, allowing future patches to add
    -    support to --format=default.
    +    Add "default" as an option for --format in both git-repo-info and
    +    git-repo-structure. Using `--format=default` makes those commands use
    +    their default output format.
     
         Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
     
    + ## Documentation/git-repo.adoc ##
    +@@ Documentation/git-repo.adoc: git-repo - Retrieve information about the repository
    + SYNOPSIS
    + --------
    + [synopsis]
    +-git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
    +-git repo structure [--format=(table|keyvalue|nul) | -z]
    ++git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]
    ++git repo structure [--format=(default|table|keyvalue|nul) | -z]
    + 
    + DESCRIPTION
    + -----------
    +@@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    + 
    + COMMANDS
    + --------
    +-`info [--format=(keyvalue|nul) | -z] [--all | <key>...]`::
    ++`info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]`::
    + 	Retrieve metadata-related information about the current repository. Only
    + 	the requested data will be returned based on their keys (see "INFO KEYS"
    + 	section below).
    +@@ Documentation/git-repo.adoc: requested. The `--all` flag requests the values for all the available keys.
    + The output format can be chosen through the flag `--format`. Two formats are
    + supported:
    + +
    ++`default`:::
    ++	synonym for `keyvalue`.
    ++
    + `keyvalue`:::
    + 	output key-value pairs one per line using the `=` character as
    + 	the delimiter between the key and the value. Values containing "unusual"
    + 	characters are quoted as explained for the configuration variable
    +-	`core.quotePath` (see linkgit:git-config[1]). This is the default.
    ++	`core.quotePath` (see linkgit:git-config[1]).
    + 
    + `nul`:::
    + 	similar to `keyvalue`, but using a newline character as the delimiter
    +@@ Documentation/git-repo.adoc: supported:
    + +
    + `-z` is an alias for `--format=nul`.
    + 
    +-`structure [--format=(table|keyvalue|nul) | -z]`::
    ++`structure [--format=(default|table|keyvalue|nul) | -z]`::
    + 	Retrieve statistics about the current repository structure. The
    + 	following kinds of information are reported:
    + +
    +@@ Documentation/git-repo.adoc: supported:
    + The output format can be chosen through the flag `--format`. Three formats are
    + supported:
    + +
    ++`default`:::
    ++	synonym for `table`.
    ++
    + `table`:::
    + 	Outputs repository stats in a human-friendly table. This format may
    +-	change and is not intended for machine parsing. This is the default
    +-	format.
    ++	change and is not intended for machine parsing.
    + 
    + `keyvalue`:::
    + 	Each line of output contains a key-value pair for a repository stat.
    +
      ## builtin/repo.c ##
    -@@ builtin/repo.c: static const char *const repo_usage[] = {
    +@@
    + #include "utf8.h"
    + 
    + static const char *const repo_usage[] = {
    +-	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
    +-	"git repo structure [--format=(table|keyvalue|nul) | -z]",
    ++	"git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]",
    ++	"git repo structure [--format=(default|table|keyvalue|nul) | -z]",
    + 	NULL
    + };
    + 
      typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
      
      enum output_format {
    @@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char
      	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
      		die(_("unsupported output format"));
      
    +@@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    + 	struct stats_table table = {
    + 		.rows = STRING_LIST_INIT_DUP,
    + 	};
    +-	enum output_format format = FORMAT_TABLE;
    ++	enum output_format format = FORMAT_DEFAULT;
    + 	struct repo_structure stats = { 0 };
    + 	struct rev_info revs;
    + 	int show_progress = -1;
    +@@ builtin/repo.c: static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
    + 	if (argc)
    + 		usage(_("too many arguments"));
    + 
    ++	if (format == FORMAT_DEFAULT)
    ++		format = FORMAT_TABLE;
    ++
    + 	repo_init_revisions(repo, &revs, prefix);
    + 
    + 	if (show_progress < 0)
    +
    + ## t/t1900-repo.sh ##
    +@@ t/t1900-repo.sh: test_expect_success 'git repo info --all <key> aborts' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success '--format=default is a synonym for --format=keyvalue' '
    ++	git repo info --all --format=keyvalue >expect &&
    ++	git repo info --all --format=default >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success '--format=default resets the format' '
    ++	git repo info --all >expect &&
    ++	git repo info --all --format=nul --format=default >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_done
    +
    + ## t/t1901-repo-structure.sh ##
    +@@ t/t1901-repo-structure.sh: test_expect_success 'progress meter option' '
    + 	)
    + '
    + 
    ++test_expect_success '--format=default is a synonym for --format=table' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		git repo structure --format=table >expect &&
    ++		git repo structure --format=default >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success '--format=default resets the format' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		git repo structure >expect &&
    ++		git repo structure --format=nul --format=default >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    + test_done
2:  c5b7ba8824 ! 2:  0c7d3bca32 repo: add new flag --keys to git-repo-info
    @@ Documentation/git-repo.adoc
     @@ Documentation/git-repo.adoc: SYNOPSIS
      --------
      [synopsis]
    - git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
    + git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]
     +git repo info --keys [--format=(default|nul) | -z]
    - git repo structure [--format=(table|keyvalue|nul) | -z]
    + git repo structure [--format=(default|table|keyvalue|nul) | -z]
      
      DESCRIPTION
     @@ Documentation/git-repo.adoc: supported:
    @@ Documentation/git-repo.adoc: supported:
     +`nul`:::
     +	similar to `default`, but using a NUL character after each value.
     +
    - `structure [--format=(table|keyvalue|nul) | -z]`::
    + `structure [--format=(default|table|keyvalue|nul) | -z]`::
      	Retrieve statistics about the current repository structure. The
      	following kinds of information are reported:
     
    @@ builtin/repo.c
     @@
      
      static const char *const repo_usage[] = {
    - 	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
    + 	"git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]",
     +	"git repo info --keys [--format=(default|nul) | -z]",
    - 	"git repo structure [--format=(table|keyvalue|nul) | -z]",
    + 	"git repo structure [--format=(default|table|keyvalue|nul) | -z]",
      	NULL
      };
     @@ builtin/repo.c: static int print_all_fields(struct repository *repo,
    @@ t/t1900-repo.sh: test_expect_success 'git repo info uses the last requested form
      	git repo info --all >actual &&
      	test_cmp expect actual
      '
    -@@ t/t1900-repo.sh: test_expect_success 'git repo info --all <key> aborts' '
    +@@ t/t1900-repo.sh: test_expect_success '--format=default resets the format' '
      	test_cmp expect actual
      '
      
     +test_expect_success 'git repo info --keys --format=nul uses nul-terminated output' '
     +	git repo info --keys --format=default >default &&
    -+	lf_to_nul <default > expect &&
    ++	lf_to_nul <default >expect &&
     +	git repo info --keys --format=nul >actual &&
     +	test_cmp expect actual
     +'
    @@ t/t1900-repo.sh: test_expect_success 'git repo info --all <key> aborts' '
     +	test_cmp expect actual_all &&
     +	test_cmp expect actual_key
     +'
    ++
      test_done
-- 
2.50.1 (Apple Git-155)

