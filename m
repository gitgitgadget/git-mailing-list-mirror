Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D20473C8C
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104056; cv=none; b=pucqBXbJ3G2MIGAVo0Op8r8cccSHBuSzRIYzrtf9jK1dRQwhX+wjXe4vRQi5J4gm+eN4xcAB/ri3VvSkuuHvAWWYg57yioaGLXWpyPnJsruZQX3ZvgnNyrMW8ANtAmIObZNtpQsTyDA66hKU8kLBzmd3z3dCMFwGSjy2K6vntXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104056; c=relaxed/simple;
	bh=vwAkG4qIz0JfjcDY+ymFfnvU3vAzdOwgxWpC5fvEflI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AFFqmkCQDriEiDkxmyUWbjD1u29oYnBeJ7WgdklG1V3VlaAJ/4/j2jmjSbRWUP0WK5jvoD/0YKZSmj4filZ/yUos1NVBX1nH243lvXw0oJOHHq7VwpdT32oCV0ii3PdSPN1vdQWLnX+xrXhE/BxmmaetJUI2+AOWf5lIZyzbZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maf74jCE; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maf74jCE"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66807ba2f0fso5049968d50.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786104043; x=1786708843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CrVvm05ysgs+yMuCQJwcCnYjhRzZM+vksnxSbidOo4M=;
        b=maf74jCEN2ezODGIvL0KFDNADKjYtp+7N8sFbElFiy6DAM68bAIJiRs0oibbMYAUI9
         zHsNX/XmLQPSAhnbU8mf4TiOheHgg+GKrTqrzcwI1EIYixmJt6ZrVHsQf4QDUrFM9ywI
         k9GxnD9x1nL9wYHSZNPpeNzp3QEriNvMdDZxmIZlOO2tPS33k4KhLySOJynunXK2xtc8
         qVIxEbghFUCLWOQnqIs+EHyzxp9hDyRI070BoE9rJZQTIu3zzEe1F7/03CTSpjKmfOwh
         PQrhOfiOrSAaEus+jKUAZW3CbEqjyGcuWDYYW5J/Yl2zp29uWMgWpWm5l9wX3m46zM1v
         +02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104043; x=1786708843;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CrVvm05ysgs+yMuCQJwcCnYjhRzZM+vksnxSbidOo4M=;
        b=n9TXkmUqrLiXYZryXx4lYHum7tLt10JSx7XZzlDcrYfI9c3ypd5jxSVstsbL7xR/xi
         gsulgt+YbwE/uJHDoIH0RLuVETu0STMWCAIsOHEA7Sn85h1pTQWmeEi4RxXxUDZvAmar
         g4tm+zwS1FJffk2IJXBuUI3xv6g1+tDA3fLxkEi2bqH59i4TVdwSCECsPz0H+M2x2kVH
         MMQW0wD7A2T5qYwYlMJtU9i2amIn2/LEO0Jx7yZq4A8yxv4U18LQ2tV6Og2vTF2nDvqm
         z4y/HCkHS05sY10yEPRHzZKpzV/eGTaLnQ0jY76CLyGe7NXXYtcYkaUb64PHSiE8FFFD
         nkrQ==
X-Gm-Message-State: AOJu0YygkV+fkMWVS3tHmwVmNClA8cbSPWIwVEyHYZhTKpkujhj+ui2f
	W0K1ZzOkdnEQnwiOAezlziX34jIP9r2EpKFhrongxPY9DoC8AilqdM4Vl3+CqjiiGcg=
X-Gm-Gg: AR+sD11Esz4miFv1zglFIiGlUTGmpfgpyGH8qdLLSt2UXLnXForN+XIi1o4iyVtm9yx
	hMgMdjVkLQQ+Aa7micrPVQiEx+GX35wgf7FLF1dAjOoiPMfhD8epIaPWjHY40678I5j6kR6ITsV
	tiVwF7z8MBTn0unSQNArC/1qjjUnYNA/V1oVSbf6KT21Mz1IE5LF81Xw0zh4B5DZA1/Zd2GWVil
	zznVq/e3NIzvfOJxoXAowb3qShtHS3CDUF1Erz3Yl0YevK2GN2C0BGaDErX48QiIzeELXi9DJqH
	tL/cUJiCzH1DPWJMfGxp4oXO5DcqYDOWaiGK5tCqGmrZ1vBR4DAspKzU10JAUHD3sU1LdPhFsRE
	QuAQDQzMAYaREMB19Y3/ZcegW7abDfSooiwsKzOLhrpW6Rmm/TwmdpLAROMOgkn2cBX5VgR/540
	a1/J4StdXozRJiT4sdobdHbaEQHywfsNtR3uXyTyTBJH3SQqhyPQ2YogxwAIK5OYxpZfAN6521f
	7K4MiA9igD/axnuUVHDamrDFU4lZ6EaFNxPDCQSkvZQA/JpUSYa0MFHj7ir1fZR7qmJcNUS3w1o
	L7mlSc/9lo4=
X-Received: by 2002:a05:690e:c8f:b0:667:c3f6:3810 with SMTP id 956f58d0204a3-6699ab97ab4mr13473750d50.49.1786104043330;
        Fri, 07 Aug 2026 05:00:43 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acae63149sm1048042d50.11.2026.08.07.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:00:42 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH 0/3] Convert USE_NSEC to runtime config
Date: Fri,  7 Aug 2026 07:56:23 -0400
Message-ID: <cover.1786103607.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.340.g8e2bf96aa5.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Topic name: dk/use-nsec-runtime

Topic summary: Expose USE_NSEC as a runtime configuration, since
build-time is too early for distributing Git [1]. As a result, common
index-related options, like git-diff, are less likely to hit "racy git"
problems on supported filesystems.

[1]: https://git.github.io/rev_news/2026/07/31/edition-137/

Built on master (2c78326f81 (The 11th batch, 2026-08-05)).

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
 read-cache.c                          | 17 +++++++++--------
 statinfo.c                            | 14 +++++++-------
 12 files changed, 57 insertions(+), 47 deletions(-)


base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
2.55.0.340.g8e2bf96aa5.dirty

