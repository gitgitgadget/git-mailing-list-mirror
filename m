Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9A459AED
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710866; cv=none; b=eFXfVyuznGCzaPadljPqxlvKOVqgGW25Y8fT05tLolWYr4iZqqikzhLvnwrIDihoq/KqCr1R5xl75x5ysJ+RVXDW4hHzNHaBPlulmwNq0gKY98DDoRSuhXLQLPGk6rp9ZRre/IAYppD2Ais2onIbYq239Ug+d+y1Yz2hZprzedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710866; c=relaxed/simple;
	bh=8AJclBLL4eLF7ZzcRWmplRkghu20lfMCQc57P7+EXug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=norf+JCfAvd8a4TAMWIXVCH4Fcp+OzJim98M8TznGs2i4XeZW2yxveApCBQhX+1d7NlcZVI8LEnytACSf3FBVjKTlw6uNevjsVXkl1zDyPKZDSgUKab8OFQW0+WxAXCgh5qsWoDIWySwaC6NABze3CejxVYz/gsrOvr2K2nzhN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egu9lv8s; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egu9lv8s"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836cb2fa1bcso13446417b3.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786710863; x=1787315663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r4WwwQKfbJN/Ocdg9DCVO0lAif6w4E4oIvrwYwAzT6w=;
        b=egu9lv8seBbW2AWoSgccX15fw2c/myM1+2UqkQN8689SvPi9FULID2dCf1DsqN9JZL
         /tCusJwvH3sdwrURdQnbN6SThtkxa1XwX23uQATqa3dkpTIjcEYI9roR9BRayeKqoJtG
         iV1b41mlw9cgRVOiB1y3tiQAXVUn2OOtC08adUU5FuSbNNUdnsAcBteJnDhyWFprT9zs
         hmV1FYfm1E35IEPbu4zdo+5VxWsKP/4wX7GuUrOhCIEq9xExvyz4rlFy0oak9OVn6K7o
         dxtpslG5MSdYZrma6MH0zuJ4mFHV4lzfOTtREllXA9yiP4tshKB1WnkNE9/Suv4BCTQp
         Mq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786710863; x=1787315663;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4WwwQKfbJN/Ocdg9DCVO0lAif6w4E4oIvrwYwAzT6w=;
        b=WPHewUEVhtQR9WqOwAT223m9kCxbxGLJnKD5QPddy4PvJXPCjrAxEDXIwa5dSgjzH6
         CS1RGSFlfY9DIGBf6B5Nd+1rVRaD7YWCbReIAuaLdl2WdykawfgUUxg++RUv4XgKsSuU
         J29pQxom8S3H9qy1jRloRRqiQaz4PjblA6jqEhweCyjxl8h9OE0N9W4U2ipwksePcUHp
         xk5EZ1578UKxwfkFgGh+p+iy9oxGr2P1oxJ8J/ddr+IRQB3WEY8b3/5fErpz5t3GApA5
         Ym0dCNE7aWmA65xZKeVbiZobMfVc79dGrDcmq+T0Mdai6yJT7Hl0rgbpjlNCwZjSHX6l
         srHA==
X-Gm-Message-State: AOJu0YytLFgaz7XpPKN1PzLXIrz9bRLAC84IiqdrsLVnaJPEYdAqtPGg
	Mg9M41xuBJ6I7avzIFXx9SOvjRYBHsaHC7jCfbrtKVIQ2tWM9WrSOVemQguPcW6aW68=
X-Gm-Gg: AR+sD11H7m0SRwhrhtL/UH/oxP84lK5yF76eYFRa8qZcWzu793WPoRQcqC2anyzU20B
	GOgs8rV5roDUQnqVN/cZMEzxVjKm1dNv4Bh8tbbQ6IFQTAMcY2ZrqmIJDAQxdXtIyJ64qlewNgL
	KmHGefUzhNsqagBrugqYeaD75GyJMQwXYqnB15g7MJ4SjGg0I/89XHMz5w2mpEKjRxPbZz9s/aV
	tgIPjNHzUpaIxNRY0lJuxIwW0bnsS0F1Pmuyjzo5RDj48xNSir9y5nb9+G2KPI+r7l2NW5unmsd
	6x5CB2ZCUVQLCXWwgDnuB5Z23PW3BPsl/2yzGrXntImBnq+y2ZeVi9Vb53eQEHPvHPuyzJgbwn8
	tml9y3Z5hHKzRHKsgAP/qqtLMMBG5Paw+gVuNL6IvnFENZ65y2Q/gEJyZUInrLxgMmgtkrhC4hz
	OvT5YnP4Y8/umCk0eWehK5t8zcQtU6VsEakdHz/gfI5ZdCp1WaQxSCx+W/PXZ1WamMY2UPA4r76
	+lVyIALObG6B0VaWWA2DVU3aNh61fs69fU2sZ52utZTamp1qRwHwS73NO5yoUqZgMU3aAVt2IKD
	cMxKZeywI8o=
X-Received: by 2002:a05:690c:2701:b0:81f:64e8:d86a with SMTP id 00721157ae682-83712ac20bemr24176877b3.30.1786710863308;
        Fri, 14 Aug 2026 05:34:23 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c21409eesm12428357b3.33.2026.08.14.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:34:22 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 0/3] Convert USE_NSEC to runtime config
Date: Fri, 14 Aug 2026 08:33:59 -0400
Message-ID: <cover.1786710807.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f.dirty
In-Reply-To: <cover.1786103607.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Topic name: dk/use-nsec-runtime (applied)

Topic summary: Expose USE_NSEC as a runtime configuration, since
build-time is too early for distributing Git [1]. As a result, common
index-related options, like git-diff, are less likely to hit "racy git"
problems on supported filesystems.

[1]: https://git.github.io/rev_news/2026/07/31/edition-137/

Built on master (2c78326f81 (The 11th batch, 2026-08-05)).

Changes in v2:

- move Best-viewed-with trailer into message body as descriptive
  text.
- read core.useNanosec through struct repo instead of parsing
  config strings. The test suite passes locally this way, though that
  skipped 151 tests.
    - CI run: https://github.com/benknoble/git/actions/runs/31701945211

Original cover letter:

Hi all, this series follows up on the previous racy Git/USE_NSEC
conversations.

- The first patch is a mostly-unrelated documentation fix for Meson, but
  it came out of something I spotted while reviewing the outputs of the
  final (main) patch.
- The second patch is a preliminary no-op reorganization of
  repo_config_values_init.
- The third patch is the meat, converting USE_NSEC into core.useNanosec.

There is a small textual and semantic conflict with
'ty/repo-config-cleanups' in 'seen', since that branch removes the
comments in 'struct repo_config_values' which this series adds to. (The
semantic conflict is that, if we drop those comments, we should probably
not add them to repo_config_values_init like I do in patch 2.)

Todo: I haven't touched any tests; I saw a bunch of hits for "git grep
racy t" but wasn't sure how to fit this particular change in, especially
since it won't be equally valid on all systems? Advice welcome.

Todo: I wonder if "useNanosec" paints us into too much of a corner; that
is (slightly more abstractly), we are using *extended precision* in the
index. Maybe the name and documentation should reflect that, so we
aren't too committed to "nanoseconds"?
    - Some platforms could offer extended precision that is not as
      precise as nanoseconds
    - Some could offer precision _beyond_ nanoseconds
idk.

v1: <cover.1786103607.git.ben.knoble@gmail.com>

[1/3] meson: expose knob for xmlto relative links in manuals
[2/3] environment: align repo_config_values_init with struct declaration
[3/3] core: convert build-time USE_NSEC into runtime core.useNanosec

 Documentation/config/core.adoc        |  6 ++++++
 Documentation/meson.build             |  7 ++++++-
 Documentation/technical/racy-git.adoc | 11 ++++++-----
 Makefile                              | 12 +-----------
 builtin/update-index.c                |  2 +-
 compat/posix.h                        |  1 -
 configure.ac                          |  6 ------
 environment.c                         | 25 ++++++++++++++++++-------
 environment.h                         |  1 +
 meson_options.txt                     |  2 ++
 read-cache.c                          | 16 ++++++++--------
 statinfo.c                            | 14 +++++++-------
 12 files changed, 56 insertions(+), 47 deletions(-)

Diff-intervalle contre v1 :
1:  d612de6c2d = 1:  d612de6c2d meson: expose knob for xmlto relative links in manuals
2:  5693baa992 = 2:  5693baa992 environment: align repo_config_values_init with struct declaration
3:  dbbd96d508 ! 3:  2d1424732a core: convert build-time USE_NSEC into runtime core.useNanosec
    @@ Commit message
         In addition, update the Racy Git documentation and other mentions of
         USE_NSEC in the code.
     
    -    Best-viewed-with: --ignore-space-change
    +    Due to the conversion from #ifdef to runtime check, using the flag
    +    "--ignore-space-change" may be particularly helpful when viewing changes
    +    from this patch.
     
     
      ## Notes (benknoble/commits) ##
    -    Repeating the benchmark from my original mail [1] shows an improvement
    -
    -    # git worktree add -d ../perf-test HEAD
    -    # hyperfine -N --warmup=10 './build/bin-wrappers/git diff'
    -    Benchmark 1: ./build/bin-wrappers/git diff
    -      Time (mean ± σ):       3.8 ms ±   0.4 ms    [User: 4.7 ms, System: 4.4 ms]
    -      Range (min … max):     3.2 ms …   5.6 ms    780 runs
    -    # (pushd ../perf-test && hyperfine -N --warmup=10 $OLDPWD/'./build/bin-wrappers/git diff')
    -    Benchmark 1: /home/benknoble/code/git/./build/bin-wrappers/git diff
    -      Time (mean ± σ):     217.5 ms ±   2.9 ms    [User: 202.1 ms, System: 23.4 ms]
    -      Range (min … max):   213.9 ms … 223.3 ms    13 runs
    -    # (pushd ../perf-test && hyperfine -N --warmup=10 $OLDPWD/'./build/bin-wrappers/git -c core.useNanosec=true diff')
    -    Benchmark 1: /home/benknoble/code/git/./build/bin-wrappers/git -c core.useNanosec=true diff
    -      Time (mean ± σ):       3.8 ms ±   0.4 ms    [User: 5.3 ms, System: 4.2 ms]
    -      Range (min … max):     3.2 ms …   6.9 ms    541 runs
    -
    -    [1]: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
    -
    -    Passing CI: https://github.com/benknoble/git/actions/runs/31104581195
    +    Related benchmarks: <https://lore.kernel.org/git/CALnO6CBm4g27mWBvD9m6yL0e5YZu3M9_zcUeLZk7QwTgnxMLQA@mail.gmail.com/>
    +    CI: <https://github.com/benknoble/git/actions/runs/31701945211>
     
      ## Documentation/config/core.adoc ##
     @@ Documentation/config/core.adoc: core.trustctime::
    @@ read-cache.c: static int ce_match_stat_basic(const struct cache_entry *ce, struc
      static int is_racy_stat(const struct index_state *istate,
      			const struct stat_data *sd)
      {
    -+	int use_nsec = 0;
    -+	repo_config_get_bool(the_repository, "core.useNanosec", &use_nsec);
    ++	int use_nsec = repo_config_values(istate->repo)->use_nanosec;
     +
      	return (istate->timestamp.sec &&
     -#ifdef USE_NSEC

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.699.gb54405d56f.dirty

