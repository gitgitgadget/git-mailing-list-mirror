Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86421263A
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988644; cv=none; b=rAigGM5+MLrP+gW41Rk8VZv8H0of1g9eBc3mebQL0UyrmzIzJSpzD4Z6/d0GRRFJf/JQWSPbV5sz9rCi/OcDC0yECpCDzphbFSIkSeHuTDAJ3aL1qjLWQPTcqECNnXTURJDzEZL0NR1FB79+eF3dwiqyxZcKi3I55jaByBzOmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988644; c=relaxed/simple;
	bh=f0Tu+VTCFN+qlNPoD6QxLjGhg4uUeeawxuRCURm3z5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulfukMDf4ZGldmwElY/mLY7MvorxmXEHWo3FFZ7uMgNlTe1tHcb1h5np50cEqL5kM/KOI1CrpdmCSjfgVlUBHS2mxyelnzljWxyirZ7Ol6Kr0OIvT8HSJoSg+mN+EccMO1vT1SnhdvMlE989MAEasgzfQY0DIV80GWS7mf788Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imESouJp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imESouJp"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so1238033a12.0
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730988640; x=1731593440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoLBRZTfZBC1F0yqCt8YO/D8eqsTdw7a066Uzezt4qc=;
        b=imESouJpngLuuJ9It7c9wAHwo1BWBZOa9s5ZDF33sUJclRdO6fSUBpx7frYMEpNqtV
         Y/4vyHiqj0YvZFzlRzE2kb77UZDwraYTqTJ3vRX6ULtj8IuAPOr2eZwtvmFK+DNZvNvd
         3NHzbMeJc29cUPMihkMSSzpO+BW8yI8rP7aapcgpXNDHLJdOxdh0GW8U6k1fybktYCTh
         lw8Vv5mreMzk9b7NvOndAHMu0zKFocD+FyTXkh0uZnQCDx+WJyu0DvWxbZa/6TI1U/Yg
         LgUhVqxwAn8w6jyMt0YMl3lUiNEN2a+62WzkdmvDbYG4Ip9Hc70CUl8jnNnfXsLTQe0A
         firQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730988640; x=1731593440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoLBRZTfZBC1F0yqCt8YO/D8eqsTdw7a066Uzezt4qc=;
        b=aY7dSUxydSykte6AVqyO32fEngna+LmrWjsMAs4OdGjHRY4PVKH8vZyW/9gA+6/N4h
         lXbI4Bpmo5KYrP1GOHKapRgd4T20wh8Uz4G8F+YRZrLke+/RcbKWoDYL8MUEPAJ4sE2e
         fbip5wkCZSbdjOErwE/A6xph7Ffhnh9/4pkuGDXtSyIU1VUJLbfosB8rToUwh3kMYMT7
         ptTUuelmYE7+R1Jx0u6a5aUzZ/9vwz9V3kIBYLBonNKJ6m1H6BS7SWGdYAopsOZxpXtT
         OJ6m7FnnyiDvmEPt4fPlL1WFNq+k8M83+d23JFt+Mj9V0af9e9ynlWA2bcosYWXSpORw
         IjPg==
X-Gm-Message-State: AOJu0YwZ2DoutpdjasBA4q1REfK90v5ItBRFWza/N8AcJ6hsuYTizuyd
	UHHaqlv2SXjbwYamJKHcKL1UuqTtDHQnC710JNbylQkydGW6BZ1mbNHF5hrS
X-Google-Smtp-Source: AGHT+IE2Xk3Vd6dwBmG5ir/Rh9jkvyzZhOtdW3VWGg6xtBN3/rTj7g2z+jgeaUoKPUj/YWfbS0FECw==
X-Received: by 2002:a05:6402:280f:b0:5ce:deaa:27c8 with SMTP id 4fb4d7f45d1cf-5cedeaa27efmr10255946a12.12.1730988639932;
        Thu, 07 Nov 2024 06:10:39 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ec90sm815424a12.58.2024.11.07.06.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:10:39 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v6 0/9] packfile: avoid using the 'the_repository' global variable 
Date: Thu,  7 Nov 2024 15:10:27 +0100
Message-ID: <cover.1730976185.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `packfile.c` file uses the global variable 'the_repository' extensively
throughout the code. Let's remove all usecases of this, by modifying the
required functions to accept a 'struct repository' instead. This is to clean up
usage of global state.

The first 3 patches are mostly internal to `packfile.c`, we add the repository
field to the `packed_git` struct and this is used to clear up some useages of
the global variables.

The next 3 patches are more disruptive, they modify the function definition of
`odb_pack_name`, `has_object[_kept]_pack` and `for_each_packed_object` to receive
a repository, helping remove other usages of 'the_repository' variable.

Finally, the last two patches deal with global config values. These values are
localized.

For v5/6 onwards, I've rebased the series off the new master: 8f8d6eee53 (The
seventh batch, 2024-11-01), as a dependency for this series 'jk/dumb-http-finalize'
was merged to master. I've found no conflicts while merging with seen & next. But
since this series does touch multiple files, there could be future conflicts.

Changes in v6:
- Lazy load repository settings in packfile.c. This ensures that the settings are
available for sure and we do not rely on callees setting it.
- Use `size_t` for `delta_base_cache_limit`.

Changes in v5:
- Move packed_git* settings to repo_settings to ensure we don't keep reparsing the
settings in `use_pack`.

Changes in v4:
- Renamed the repository field within `packed_git` and `multi_pack_index` from
`r` to `repo`, while keeping function parameters to be `r`.
- Fixed bad braces. 

Changes in v3:
- Improved commit messages. In the first commit to talk about how packed_git
struct could also be part of the alternates of a repository. In the 7th commit
to talk about the motive behind removing the global variable.
- Changed 'packed_git->repo' to 'packed_git->r' to keep it consistent with the
rest of the code base.
- Replaced 'the_repository' with locally available access to the repository
struct in multiple regions.
- Removed unecessary inclusion of the 'repository.h' header file by forward
declaring the 'repository' struct.
- Replace memcpy with hashcpy.
- Change the logic in the 7th patch to use if else statements.
- Added an extra commit to cleanup `pack-bitmap.c`. 

Karthik Nayak (9):
  packfile: add repository to struct `packed_git`
  packfile: use `repository` from `packed_git` directly
  packfile: pass `repository` to static function in the file
  packfile: pass down repository to `odb_pack_name`
  packfile: pass down repository to `has_object[_kept]_pack`
  packfile: pass down repository to `for_each_packed_object`
  config: make `delta_base_cache_limit` a non-global variable
  config: make `packed_git_(limit|window_size)` non-global variables
  midx: add repository to `multi_pack_index` struct

 builtin/cat-file.c       |   7 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |  15 ++--
 builtin/fsck.c           |  20 +++---
 builtin/gc.c             |   8 ++-
 builtin/index-pack.c     |  20 ++++--
 builtin/pack-objects.c   |  11 +--
 builtin/pack-redundant.c |   2 +-
 builtin/repack.c         |   2 +-
 builtin/rev-list.c       |   2 +-
 commit-graph.c           |   4 +-
 config.c                 |  22 ------
 connected.c              |   3 +-
 diff.c                   |   3 +-
 environment.c            |   3 -
 environment.h            |   1 -
 fsck.c                   |   2 +-
 http.c                   |   4 +-
 list-objects.c           |   7 +-
 midx-write.c             |   2 +-
 midx.c                   |   3 +-
 midx.h                   |   3 +
 object-store-ll.h        |   9 ++-
 pack-bitmap.c            |  90 +++++++++++++++---------
 pack-objects.h           |   3 +-
 pack-write.c             |   1 +
 pack.h                   |   1 +
 packfile.c               | 148 +++++++++++++++++++++++----------------
 packfile.h               |  18 +++--
 promisor-remote.c        |   2 +-
 prune-packed.c           |   2 +-
 reachable.c              |   4 +-
 repo-settings.c          |  14 ++++
 repo-settings.h          |   5 ++
 revision.c               |  13 ++--
 tag.c                    |   2 +-
 36 files changed, 268 insertions(+), 190 deletions(-)

Range-diff against v5:
 -:  ---------- >  1:  6c00e25c86 packfile: add repository to struct `packed_git`
 -:  ---------- >  2:  70fc8a79af packfile: use `repository` from `packed_git` directly
 -:  ---------- >  3:  167a1f3a11 packfile: pass `repository` to static function in the file
 -:  ---------- >  4:  b7cfe78217 packfile: pass down repository to `odb_pack_name`
 -:  ---------- >  5:  5566f5554c packfile: pass down repository to `has_object[_kept]_pack`
 -:  ---------- >  6:  1b26e45a9b packfile: pass down repository to `for_each_packed_object`
 1:  7654bf5e7e !  7:  89313cfed4 config: make `delta_base_cache_limit` a non-global variable
    @@ Commit message
         this value from the repository config, since the value is only used once
         in the entire subsystem.
     
    -    The type of the value is changed from `size_t` to an `unsigned long`
    -    since the default value is small enough to fit inside the latter on all
    -    platforms.
    -
         These changes are made to remove the usage of `delta_base_cache_limit`
         as a global variable in `packfile.c`. This brings us one step closer to
         removing the `USE_THE_REPOSITORY_VARIABLE` definition in `packfile.c`
    @@ builtin/gc.c: struct gc_config {
      	char *repack_filter_to;
      	unsigned long big_pack_threshold;
      	unsigned long max_delta_cache_size;
    -+	unsigned long delta_base_cache_limit;
    ++	size_t delta_base_cache_limit;
      };
      
      #define GC_CONFIG_INIT { \
    @@ builtin/gc.c: struct gc_config {
      
      static void gc_config_release(struct gc_config *cfg)
     @@ builtin/gc.c: static void gc_config(struct gc_config *cfg)
    + {
    + 	const char *value;
    + 	char *owned = NULL;
    ++	unsigned long longval;
      
    + 	if (!git_config_get_value("gc.packrefs", &value)) {
    + 		if (value && !strcmp(value, "notbare"))
    +@@ builtin/gc.c: static void gc_config(struct gc_config *cfg)
      	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
      	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
    -+	git_config_get_ulong("core.deltabasecachelimit", &cfg->delta_base_cache_limit);
      
    ++	if(!git_config_get_ulong("core.deltabasecachelimit", &longval))
    ++		cfg->delta_base_cache_limit = longval;
    ++
      	if (!git_config_get_string("gc.repackfilter", &owned)) {
      		free(cfg->repack_filter);
    + 		cfg->repack_filter = owned;
     @@ builtin/gc.c: static uint64_t estimate_repack_memory(struct gc_config *cfg,
      	 * read_sha1_file() (either at delta calculation phase, or
      	 * writing phase) also fills up the delta base cache
 2:  2730aacd8e !  8:  3a8e3b88df config: make `packed_git_(limit|window_size)` non-global variables
    @@ packfile.c: unsigned char *use_pack(struct packed_git *p,
     -			size_t window_align = packed_git_window_size / 2;
     +			size_t window_align;
      			off_t len;
    -+			struct repo_settings *settings = &p->repo->settings;
    ++			struct repo_settings *settings;
    ++
    ++			/* lazy load the settings incase it hasn't been setup */
    ++			prepare_repo_settings(p->repo);
    ++			settings = &p->repo->settings;
     +
     +			window_align = settings->packed_git_window_size / 2;
      
 3:  8e33d40077 =  9:  2f9a146978 midx: add repository to `multi_pack_index` struct
-- 
2.47.0

