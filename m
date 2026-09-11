Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74FA45FFDD
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130006; cv=none; b=KfThUuxmb40ciqcWc3hnhTLqIXl3gxvvrmZhHWOB/0RpMiaFXsGvjQ4IHaVQerROL7QqaEXKRMas9QE9EKzkuT/3LVdHKQOo3ZULdm2V9d7Sx4e8Jcm6bdDZVmq1h4Zo701T5dt4ohFun/Z+uKsPZtMolx7KhPvj6c4pWwBjA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130006; c=relaxed/simple;
	bh=JszuMxaa2pWgOQSN0c4TtVsJ694+exI1Lg3cErscs8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiCiVohnBulqWE08NnfFBOgkbHTt9eJfcY6Xd+Qwd+qd22/tMYxjjo9aA5+MfXr5EUbDYb8GKVLqkusNMBHrNvLyZuv0RghoJqpkMaGTjuAirBnAM69gXk+CHka36UqZ6djhIUKWd6SSgbtABS7iiBLkdmlUMXKfSU7u5LO+mRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3vJSzf8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3vJSzf8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-871c8a36fe3so6861117b3.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789130001; x=1789734801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f34TOvBWXXuk1FSRah/NFXPDd/ZbITeFZcvGPXXA0z8=;
        b=J3vJSzf8b9nlL0omRUhkXxtFSg6WC2WOV1+8R/pWx1lrlJH8Mv1xgp7unZ6PPQqADu
         YGLLHXAhdR7xaAuFurHdX99u0MHPWsXmzQb0dys38cMWMOwdbzeMXieLo+HnULE7ngng
         ZMoVIUfRm2Lf0KcjO/4Z6uNHCVYYh6Hzau1HqFcYPW0axu1Vo2+u3eJsR+lp89jYF9kG
         +is4UNoInqHmD3Yqwi0wrKhGBBHYsyhjaSnO0b46vPLbZGyWVAMLCeUvsT6yLXSCG9Xx
         MrMCjVM0wgDjomfIHHdbuM66ZbeHoKM+NOLvSRdbf55x5Mfln0TfuRV6FT8f01VyIHtt
         +XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130001; x=1789734801;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f34TOvBWXXuk1FSRah/NFXPDd/ZbITeFZcvGPXXA0z8=;
        b=TIQk+jOzEMqx49JjasCmk873pP7jA/8aVuEkSUhZMQxLdrkJ+jZcjjKcsRpf4joAZt
         9lHe5n704nDpRBD80aYmDngIzgSsZncCBi5gsvuU4vp4XqYopLYSYx+J34UCKBMn2fJw
         O56HMQlzHoaCVajaadZVq7YIXxACjnhKEjcWLoa1hd8yD/sUGqwl9eW8B/zkhvBEvFHx
         tRfliLqFzYtFxOuAWF/zxT/FtwhM8cxgaeeiQEE/HnsH2P2SxZin8DzOAAt5+R6f3+Js
         MjIzMaAbAClHZFWnIBXG+RX/eHmemzWtXyq4kpIFsEOlfVYnUb5KO77OCsGihQLBu0pE
         A96g==
X-Gm-Message-State: AFuF++l9NEwAnZHKkbO+Ty0MxY6vOGE/8CbCfmEV6nI+UtJd9egMZ7bd
	zPUg8M1PQCAsfFxKQulgh8OfijE3d1oJPIp636LAcU+584eBaiOuPrteJ/HcMA==
X-Gm-Gg: AYBFou2xyWb8JkAEiftyTZdcKGE96m9W9UtAd/ACix873QikVnZ0QihFVfHVPtpiww7
	Pa13zSqrleO9+wcsz8NQ1rGviRMd13EF17/2RclvwoaVo2kidvz7HvrgLa4HaLfPqoDPZOA11LK
	HpDvfvD6lyd99AEy3gUA8wgoGvGFhowSle+Og8DVlo9+97ViPMVjg6AJ/M/CPbJu4rpBTbS5gpd
	PV5y/jb5I+XwZDD1XtaK8/41nLhIdZP8+Grvn6mVBGZ3Sn1Lk0fEU6BYIy2RXJzUCW89TFG3+7b
	Epob8vb6jAAN4tHCVF6s7SlTfrYvEax1A7iHcWQ22NkN83YafJeOiu+JKvS5l9nAqsz2u1kPNG7
	VIFrqlMut5crPPpy+v1T7d/kahd0usfpIiA59uaCF/fm1k4iFHZgKGbB8wCTIz121zFRKeFpsiq
	KaCqukPDA9XA9dx98kDlRnSEbrZ/uCn8GsD7ZxjbYj2U7faE9WrzCDVTvpMrYbaPAZzlL5stpmm
	OnXwKCeD44eH89TBXoQLxAXXfk/9plgLOYLwTP3QVy2geB/YOc0y6bSq2Q1ezZ3XM/3juzrOCdM
	k0zvQkgcipEuBBnR3iz+Ww==
X-Received: by 2002:a05:690c:e155:b0:873:5bb2:6c1f with SMTP id 00721157ae682-884b210acebmr10797837b3.38.1789130000527;
        Fri, 11 Sep 2026 05:33:20 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8848701e82fsm9785247b3.22.2026.09.11.05.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:33:20 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v7 0/3] Convert USE_NSEC to runtime config
Date: Fri, 11 Sep 2026 08:32:26 -0400
Message-ID: <cover.1789129924.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699.dirty
In-Reply-To: <cover.1787231825.git.ben.knoble@gmail.com>
References: <cover.1787231825.git.ben.knoble@gmail.com>
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

Changes in v7:

• documentation typofix
• I opted not to finagle #ifdefs more [2] nor to add a "safe default
  when istate->repo is different from the_repository" (replies to [2])

[2]: https://lore.kernel.org/git/842F2470-F158-4E77-AD98-DEA530FC4460@gmail.com/

Changes in v6:

• comment wording tweak

Changes in v5:

• improve message flow in patch 2

Changes in v4:

• fix message typo
• change #ifdef strategy: only ignore the config variable.
  Otherwise, use the use_nanosec member unconditionally. Also clarify
  that config might be ignore depending on build options in the docs.
• mention potential platform unsafety directly in config doc in
  addition to the link to Racy Git

Changes in v3:

• #ifdef out use_nanosec when NO_NSEC is requested

As I have heard no comments about the "Todo" lines below, which perhaps
could more clearly be marked "RFC"/"RFH", I've added this line to call
them out ;) and renamed them "Comments welcome"

Changes in v2:

• move Best-viewed-with trailer into message body as descriptive
  text.
• read core.useNanosec through struct repo instead of parsing
  config strings. The test suite passes locally this way, though that
  skipped 151 tests.
    • CI run: https://github.com/benknoble/git/actions/runs/31701945211

Original cover letter:

Hi all, this series follows up on the previous racy Git/USE_NSEC
conversations.

• The first patch is a mostly-unrelated documentation fix for Meson, but
  it came out of something I spotted while reviewing the outputs of the
  final (main) patch.
• The second patch is a preliminary no-op reorganization of
  repo_config_values_init.
• The third patch is the meat, converting USE_NSEC into core.useNanosec.

There is a small textual and semantic conflict with
'ty/repo-config-cleanups' in 'seen', since that branch removes the
comments in 'struct repo_config_values' which this series adds to. (The
semantic conflict is that, if we drop those comments, we should probably
not add them to repo_config_values_init like I do in patch 2.)

Comments welcome: I haven't touched any tests; I saw a bunch of hits for
"git grep racy t" but wasn't sure how to fit this particular change in,
especially since it won't be equally valid on all systems? Advice
welcome.

Comments welcome: I wonder if "useNanosec" paints us into too much of a
corner; that is (slightly more abstractly), we are using *extended
precision* in the index. Maybe the name and documentation should reflect
that, so we aren't too committed to "nanoseconds"?
    • Some platforms could offer extended precision that is not as
      precise as nanoseconds
    • Some could offer precision _beyond_ nanoseconds

idk.

v1: <cover.1786103607.git.ben.knoble@gmail.com>
v2: <cover.1786710807.git.ben.knoble@gmail.com>
v3: <cover.1787065125.git.ben.knoble@gmail.com>
v4: <cover.1787231825.git.ben.knoble@gmail.com>
v5: <cover.1788010335.git.ben.knoble@gmail.com>
v6: <cover.1788206466.git.ben.knoble@gmail.com>

[1/3] meson: expose knob for xmlto relative links in manuals
[2/3] environment: align repo_config_values_init with struct declaration
[3/3] core: convert build-time USE_NSEC into runtime core.useNanosec

 Documentation/config/core.adoc        |  7 +++++++
 Documentation/meson.build             |  7 ++++++-
 Documentation/technical/racy-git.adoc | 11 ++++++-----
 Makefile                              | 12 +-----------
 builtin/update-index.c                |  2 +-
 compat/posix.h                        |  1 -
 configure.ac                          |  6 ------
 environment.c                         | 27 ++++++++++++++++++++-------
 environment.h                         |  1 +
 meson_options.txt                     |  2 ++
 read-cache.c                          | 15 ++++++---------
 statinfo.c                            | 14 +++++++-------
 12 files changed, 57 insertions(+), 48 deletions(-)

Diff-intervalle contre v6 :
1:  d612de6c2d = 1:  d612de6c2d meson: expose knob for xmlto relative links in manuals
2:  12974e07d0 = 2:  12974e07d0 environment: align repo_config_values_init with struct declaration
3:  0a611f6140 ! 3:  d983e2f0a5 core: convert build-time USE_NSEC into runtime core.useNanosec
    @@ Documentation/config/core.adoc: core.trustctime::
      
     +core.useNanosec::
     +	If true, use nanosecond precision for ctime and mtime
    -+	comparisions between the index and the working tree (if Git
    ++	comparisons between the index and the working tree (if Git
     +	was compiled to respect this option).
     +	This is unsafe on some platforms;
     +	see link:technical/racy-git.html[Racy Git]. False by default.

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.1003.g10538fe699.dirty

