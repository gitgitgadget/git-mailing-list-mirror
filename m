Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D075366
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618667; cv=none; b=BHxu2fQw8PPhiw4R+x6dRYzJynYlClhrPtNIaL8KOVX/Yyt7mloYpRsgXde5jHLIVZdAug0QQLMD3OizTZTHJDCrRCaunxt5fC4JJUf7fQ+hAsXph2eq4NyImd4n+k2o7P4dwCztK3cmbeM4FR2VGKYnWXfbD3+aDBGAgHeyuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618667; c=relaxed/simple;
	bh=Dz12+GNdRAiIhzlGqp3dm9Db31q9BRKbIYcypZgnNhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euW91aNzqJFgw4424xCzu0ioarN+KK/E0TNv//EG1uOGHWvUV+XzHFDt5gj9s7VDWM3C6XX67cXfKFh0xGMM1bn2rLz44bpekbq/vlbcblRcvXHAiXAhAUczpjLCjqOC7jLnCvWArdUzCmpWyW0hEjoI1ytqjPfFg6Rt5DupsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hba1En2U; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hba1En2U"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so8761119a12.0
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 02:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732618664; x=1733223464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY5qHPlRxKO/3GwK3NuIxlOSN4ZXC4zqvO74HbZKFoQ=;
        b=Hba1En2UyeQ3OQ3YI5Ea0BuJkzAeiTj+L2AJMGIQc0jd2r8IAavz0iYTFcNLAoRGe/
         qeSVaDi2ep/k+doadPS6qi0vXNTr+kzhP4AnOSvTfuyQV9vXUb6bBKp0lWL/TCp3KEfM
         vlycaDOzvUmlFB/NwaJvj6rAXyB2qcV7lAXbBo3nAhRxw780M2wtkJabwuHCCFAXDDzS
         JDCj5Fkwvw3A/NKXfSe2PBbjop+Q/QAriPhLjXDFs/u+Ijyb2wMVpcBbulhZ5cfjNWh+
         j1QCXv1FcV1oh07UO6rlU1ab/EWAaNZGTAEoDoLfUSU7Om2+jV1kdyg76mNG+CwdBwdp
         0pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618664; x=1733223464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY5qHPlRxKO/3GwK3NuIxlOSN4ZXC4zqvO74HbZKFoQ=;
        b=fEmclqbk9efyKDJx/7ePBnQMAJGx5929gPD7QOzz+eeXTzJo5Z747x+3vLcuGnc62x
         vVvcG+lwB5LzpzLvjmI0XvuLVL9zJ32PCSvXxoTapOQhUzSth6ftYb20TlkaOCzmo22b
         QvWKczQsBo9k/bpUk1Yus1QQ9cpBbonJ9bJL8CAmDHlBSVv5Y79j8jt6YTlvViWu7xqO
         fiBCsM07ZmWoJWuRMYu/dm/2b/rv9MB1InRIPAgjetDKqmAAT+AW9TQgTVAtJ62rhldv
         ipSu2ZTBZAkSpl7GVAqAUOKRWFLnrI2rPjuHwl0phneIE7bvAQO4OPdNddZUYprbld1e
         3X8w==
X-Gm-Message-State: AOJu0YwFAQ9N0+ta0OkqPjDjCQiLX3wDy85zJDCcdFBGpG+VVwSNpuHD
	cgar1JLApkRc6qzaQxxnR+2gzwV1hbZ7szmmyJauj77ypY0Bdvw74zjZiOQH
X-Gm-Gg: ASbGncvBMVSAlck3jkdZWVCrtBrvvsFLRX0APosyA/LgfmPww2fUK50rjqFibNuH3gr
	qkxYS7U4G3vRpybv6pTQ8nk2XpujnlC7bg9n9TfXllRWifvPCgO9lR/eETYIwpxdMVLwL0wDNow
	LNDufWJVaQLR3L2PSszLFPgz0gS+Jk8Ku40L/h94+lbCd3KnshiTVeNYt6yxzGkCiFEzxzITISk
	OcXHSPgKSQ1fcNzJRxOyLmyhphdUTZcYEXffIJ9tvbNBgEaqWEMgjUK6AY2MIU=
X-Google-Smtp-Source: AGHT+IFvZdLZiSbyaR9nKVrG6zS41JWAJvxfe58MGgA0ZDEyJGLf1Lqp9L8/HAumdoWc5QPT2t2aiw==
X-Received: by 2002:a05:6402:90a:b0:5cf:d2ab:6bf3 with SMTP id 4fb4d7f45d1cf-5d06a537744mr2815451a12.0.1732618663430;
        Tue, 26 Nov 2024 02:57:43 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b8c77sm587461366b.187.2024.11.26.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:57:42 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v9 00/10] packfile: avoid using the 'the_repository' global variable
Date: Tue, 26 Nov 2024 11:57:31 +0100
Message-ID: <cover.1732618495.git.karthik.188@gmail.com>
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

Finally, the next two patches deal with global config values. These values are
localized. The last patch is removal of an unecessary call to `prepare_packed_git()`.
For v5 onwards, I've rebased the series off the master: 8f8d6eee53 (The
seventh batch, 2024-11-01), as a dependency for this series 'jk/dumb-http-finalize'
was merged to master. I've found no conflicts while merging with seen & next. But
since this series does touch multiple files, there could be future conflicts.

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

Range-diff against v8:
 -:  ---------- >  1:  d1fdd6996a packfile: add repository to struct `packed_git`
 -:  ---------- >  2:  65c09858ce packfile: use `repository` from `packed_git` directly
 -:  ---------- >  3:  80632934d1 packfile: pass `repository` to static function in the file
 -:  ---------- >  4:  67d71eab83 packfile: pass down repository to `odb_pack_name`
 -:  ---------- >  5:  ee210fa153 packfile: pass down repository to `has_object[_kept]_pack`
 -:  ---------- >  6:  8db7094f4e packfile: pass down repository to `for_each_packed_object`
 1:  d1b6e8801b !  7:  a66494384d config: make `delta_base_cache_limit` a non-global variable
    @@ builtin/gc.c: struct gc_config {
      	char *repack_filter_to;
      	unsigned long big_pack_threshold;
      	unsigned long max_delta_cache_size;
    ++	/*
    ++	 * Remove this member from gc_config once repo_settings is passed
    ++	 * through the callchain.
    ++	 */
     +	size_t delta_base_cache_limit;
      };
      
 2:  30a52f192f =  8:  bce9196f6b config: make `packed_git_(limit|window_size)` non-global variables
 3:  2fe5d2506f =  9:  c7fba8cf6a midx: add repository to `multi_pack_index` struct
 4:  05989c2e27 = 10:  d7f475fbd0 packfile.c: remove unnecessary prepare_packed_git() call
-- 
2.47.0

