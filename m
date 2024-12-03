Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3D1F668E
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237050; cv=none; b=XA2KcRrZNkKuVT551DJ2XqJ3RoqN5sShtiAsP5tHGdJ//O6igYdMEruDws2SxEIBWETxNwbjTOS1LhKww34zD9HML0eN710hRc5TllW3RNifcn38rzdiEmrgz3Z9/p0UTs/SO3q5v6CtF50zkki8o7tahc+r9YE1qS6CT1pe2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237050; c=relaxed/simple;
	bh=FE8s8Z8/aN4C8LEbUb7qpzcMvquZ7f13n4tA3DNpwkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNsKcRcX6Il0fd9V6t+3nwOiTZVh/QqhLuHlJk9K6N8j/fU57mqODFT8bOFGfKSI58zb8fpctd4BZWBLLQWPv6LzZq0jtrYZv8+JlCLl4mLm4lZy7LytaDrJxqpBUda2nyg4RRgYkngM15P4WPc3bNhQDkAIhXnzQH3/ecUB2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3DrnoqR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3DrnoqR"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so1008731566b.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237047; x=1733841847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaZ0ejenbQZ/3rINeWHnfvJEeRgIdsoEQ2RBXyBsOss=;
        b=b3DrnoqRYqCglhjmsQc+pmbKtCPiTdrMhC/23vRPcjpltVAKgDiE2ePBaDeIUucuKr
         HbOCC/Yw3ObqakjgRC8PU/wS8tCP62DccEQYpcu/s5Vm8dU96AeuONlgWJaGT+X3QuE4
         uel/mMOWDb2hpQ0MlSk71PHSRzkSf8uAy54PZIqDWjkvJqAo7zJraBEVKKijRE9NHYuJ
         LOAD5SDWROOCwXVGE3Mw4uBdYDhiYQBh//ZHhVLxLGjfMt+SuAHoJ9bUA0owBYn4X8kN
         s17kXeKA9cgOgBSCBPCWRJW+WajDKrt46bS3AGGSEHW0oF/NKneqEBgA5Yztob+fxg6+
         5EUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237047; x=1733841847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaZ0ejenbQZ/3rINeWHnfvJEeRgIdsoEQ2RBXyBsOss=;
        b=rRSgqUsCqVwECtm3rPd2VMC3mMm7InFV0REEw6wlDDpwLIFLsqfi8OQWcBevnrM9uY
         HlpkWPEVgOrfc8voMbdJgFZ2TYQ5DZsrWXP2GPAn2g7sfUb7w9r8rqBzWcb/lq6Yt1kW
         mVjTceqqCla0hoevXYR8eWdV4kpFrTbe7JrlRKUog08Nh36hQhBGJ/XpeeCiGxaQT6it
         zFhi97KXC81B5a4taBzXGchV86CTXdm8O//eLe6ID9+/acKxICr6wy9Fl72DrTIq/H+n
         PVXbBfI0dGHtpGQu8maL3QQcm5ycMFAd7ij5PLUfFI6M84Tu+bi02t8uEhOKJ64m6+u0
         b+xw==
X-Gm-Message-State: AOJu0Yx2Qw8PuOPlzrU5abXNNsw5lDOhT3spA/7F/30KMUk2dvQwxKKa
	1b0C5kQtQbL6WI06uQNbs4yWtZPnY0axXZzNAChJQ3kRWVCrsrh0
X-Gm-Gg: ASbGncuW4VblDDr3cqpBaLEPIN8vbBRihz6YUWXIT0wG3JTnStN1A6+kOqnWOxLuT1d
	5yl8O9QC09CQGaDcY1ax6N+S0GDig0ntCemjBQHN6JLFHxaqCBQPAIRDA++34ypPM3LpJvFKiCO
	RRDZeXhSXcQ9zLeRK6t/6cmOrXM13GE22/Feu+GkaMaR3OfZd3TBHxFKVJeNRg0VIW8ox2rODzI
	zDojbAMb3tTzLI44Esw3X4hEm18/ofDwWSQ1H0PtsMUGFZN6SuePkWang2DLXdjodji
X-Google-Smtp-Source: AGHT+IHGgjvqb0gV1RhjKz6yXze9jc0XQyT7V/aiZwvTjSYarGSz8OX0CKmDiZkr97yVaSdsl7zOtw==
X-Received: by 2002:a17:906:328a:b0:aa5:f2c0:2378 with SMTP id a640c23a62f3a-aa5f7161db9mr345601566b.13.1733237047206;
        Tue, 03 Dec 2024 06:44:07 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de782sm619021466b.56.2024.12.03.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:44:06 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v10 00/10] packfile: avoid using the 'the_repository' global variable
Date: Tue,  3 Dec 2024 15:43:54 +0100
Message-ID: <cover.1733236936.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
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

Finally, the next two patches deal with global config values. These values are
localized. The last patch is removal of an unecessary call to `prepare_packed_git()`.
For v5 onwards, I've rebased the series off the master: 8f8d6eee53 (The
seventh batch, 2024-11-01), as a dependency for this series 'jk/dumb-http-finalize'
was merged to master. I've found no conflicts while merging with seen & next. But
since this series does touch multiple files, there could be future conflicts.

Changes in v10:
- Grammar corrections in the commit messages.

Changes in v9:
- Added a comment in gc_config to indicate that eventually the
  `delta_base_cache_limit` variable should be used through repo_settings. 

Changes in v8:
- Fix typos in comments
- For packfile.c use delta_base_cache_limit from the repository
settings, this avoids loading the config in hot paths.
- Rename `longval` to `ulongval` to better signify the type.

Changes in v7:
- Cleanup stale commit message.
- Add missing space in `if` statement.
- Fix typo s/incase/in case/.

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

Taylor Blau (1):
  packfile.c: remove unnecessary prepare_packed_git() call

 builtin/cat-file.c       |   7 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |  15 ++--
 builtin/fsck.c           |  20 +++---
 builtin/gc.c             |  12 +++-
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
 pack-bitmap.c            |  90 ++++++++++++++----------
 pack-objects.h           |   3 +-
 pack-write.c             |   1 +
 pack.h                   |   2 +
 packfile.c               | 144 ++++++++++++++++++++++-----------------
 packfile.h               |  18 +++--
 promisor-remote.c        |   2 +-
 prune-packed.c           |   2 +-
 reachable.c              |   4 +-
 repo-settings.c          |  18 +++++
 repo-settings.h          |   7 ++
 revision.c               |  13 ++--
 tag.c                    |   2 +-
 36 files changed, 275 insertions(+), 190 deletions(-)

Range-diff against v9:
 1:  d1fdd6996a !  1:  d6d571c58e packfile: add repository to struct `packed_git`
    @@ Commit message
         on the global `the_repository` object in `packfile.c` by simply using
         repository information now readily available in the struct.
     
    -    We do need to consider that a pack file could be part of the alternates
    +    We do need to consider that a packfile could be part of the alternates
         of a repository, but considering that we only have one repository struct
    -    and also that we currently anyways use 'the_repository'. We should be
    +    and also that we currently anyways use 'the_repository', we should be
         OK with this change.
     
         We also modify `alloc_packed_git` to ensure that the repository is added
 2:  65c09858ce =  2:  fa69763468 packfile: use `repository` from `packed_git` directly
 3:  80632934d1 !  3:  c6acbece46 packfile: pass `repository` to static function in the file
    @@ Commit message
         packfile: pass `repository` to static function in the file
     
         Some of the static functions in the `packfile.c` access global
    -    variables, which can simply be avoiding by passing the `repository`
    +    variables, which can simply be avoided by passing the `repository`
         struct down to them. Let's do that.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
 4:  67d71eab83 =  4:  a8588d6086 packfile: pass down repository to `odb_pack_name`
 5:  ee210fa153 =  5:  b3fe20c8f1 packfile: pass down repository to `has_object[_kept]_pack`
 6:  8db7094f4e =  6:  ad46b339ea packfile: pass down repository to `for_each_packed_object`
 7:  a66494384d =  7:  342a26572d config: make `delta_base_cache_limit` a non-global variable
 8:  bce9196f6b =  8:  6e55daf5b3 config: make `packed_git_(limit|window_size)` non-global variables
 9:  c7fba8cf6a =  9:  6e0ec955e6 midx: add repository to `multi_pack_index` struct
10:  d7f475fbd0 = 10:  e33fa2ea0d packfile.c: remove unnecessary prepare_packed_git() call
-- 
2.47.1

