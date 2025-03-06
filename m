Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BD41C92
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256786; cv=none; b=M6chj/hoz1m29bSTeRyt03j3EXD/nxIbrXiREydV0l58mhkTbZgRWH6A1limPFVQoqqpSChfgJ2GH/yASc4mnCVWIkcLD8zVG4ZrzG6B6V9GdntzcCSzdyar6ynUZHPQwq74fYuhI/jVCt4bqJ9+ItYPWbwiO7HEGG3Za9THE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256786; c=relaxed/simple;
	bh=707cVrwsDJgji4Gpl+LmoD+AkPUicreQWkGbNZDrEXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y2StrwBNYl9ZRwOxZVsOLWH98z22g4aJxyxFFMd/V0RrF5KiX5/sl9wtdlSK5XdqB6fxbqEHnCmmSJ1UoE1suogERH2tAolsXJwcKHnziKh/56WvK9b+Cli+3/nPkfFyz+vabx6MAijn4VJpuINDsjj8wgJoGnQYTaJUqDKjH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwW38FPn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwW38FPn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so4706585e9.3
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 02:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741256783; x=1741861583; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRFWKrEyroMqBFlxB36VildNPZeQRRkszw5Nt64tZ34=;
        b=GwW38FPnM9Ir5u1t6gApMiHqwujCZ0CmyrVKpcUSTswf09teyTrpERh1ai8/r6dpVK
         UAQyvgFlBDG0iPvUSf1cRtA4SPXUP23HtE4bcfm5grZeF1b0yTUf46KVHdZwWIs7uGxC
         0RqC+sKtv+OziMRj/esHNdncez1LV7JwA5nmFcvsNMIcfX+T1mIKO2q/d6v3p1q+dCls
         9go1/WTvrk+b4p/24iNeI2oo8svM5OmA6aspoh9Hjh4y9svYWSGBMkuhFbRu5AWRAZrm
         VZgpjmbm9O9VEY8NajMIbsMCAd4wLFoUicg4daFkWBuRUkVaO8Remi2GGbwy2gWMB/37
         6E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256783; x=1741861583;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRFWKrEyroMqBFlxB36VildNPZeQRRkszw5Nt64tZ34=;
        b=iSZ8NTncOGQ1KApoPSz8fab8zpTNE2EcTXe/+/KLCDdvFViBGvau4Coi7GJid8o+ml
         93ybfmG5S3Klsgcct3H1zgXVSlRPXy59CXrUQQCKDb/fvOjUo4W9ZchJhBmCsxr2Gp61
         HMPM9+ErleKq3EIiKf2TWhIhKEdtWSiJafrOo9LxVuDWPOyZudaUQ60hRLv211tAJR+r
         LS59x8duVIuwODmTLukYBmrsZABQwiLzA2SxJWX4uFLmqIINBcNWCk/1q1tykP1+EWHm
         PiNZ/PRb8hU53rGFAhkfd+BJOVXe/JdWevJuLA58XSJj2i0DAf83UlndYD/AAGWPYf5U
         L1UA==
X-Gm-Message-State: AOJu0YzBQ6Lpfo7GBUuKFWiyE4fjZqFGmAIwS01gNSdxdHyAyIeEs+QM
	0QJYhNW+HoFDWtnM3jtN00QUhIAoqDudfFhZ8OpXJ5XcFyv/j5QTqjxVFg==
X-Gm-Gg: ASbGncte2zvWNkQS4N7gTO66OGM9DDyl0uCnl5yNtMgzdZZaO0jm448q2vayEHQV1Nk
	az8n/2Ij1Thn6kUgUgHwKLPARgd49ayplOXiETJLUkcsAYBIZB/9c8BuQaxjVXyRYjWG11WQDqg
	5X/fhPug+PP3Jt9dGaDWCwqmKKOzAvdjLdexA89WseByMIH7uFiyHHidDV1UW4As4j1pnmDhT9F
	cMcjyYv4+Wa/TD0THs9Bkr1K255KEUA+McClxyUwjUsGVp82vUeUnMH8rNIkNGca7idVMkT4KNY
	eK8WRZRGB3fPeat7I29TipKSoWWpD2srwPL+C6uy+MTIUQ==
X-Google-Smtp-Source: AGHT+IF7xTJfohJIgCzwGv+WTlpFm11PQqLwgL3KlFzwdFEhEksm5m0k0Xg7woUz9DxTuf3kdBTB7Q==
X-Received: by 2002:a05:600c:1c90:b0:43b:bfb7:e099 with SMTP id 5b1f17b1804b1-43bd29d2a35mr58561645e9.29.1741256782357;
        Thu, 06 Mar 2025 02:26:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988bdc7sm71161766b.133.2025.03.06.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:26:21 -0800 (PST)
Message-Id: <pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
In-Reply-To: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 10:26:17 +0000
Subject: [PATCH v2 0/3] Hot fixes from Git for Windows v2.49.0-rc0
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

I needed many patches to make Git for Windows v2.49.0-rc0 compile and run
the many, many CI jobs successfully. These here patches even apply to
upstream Git. (Technically, the Meson sorting patch is not required to
compile, but it was the fall-out from many required adjustments to make the
Meson jobs happy.)

Changes since v1:

 * I spent two hours investigating under which circumstances the (correct)
   compiler error about a non-writable pw_gecos field triggers, and
   augmented the commit message accordingly.
 * Since -rc1, another breaking change necessitated yet another hot fix,
   which I invites to this patch fest (and the patch series hence had to be
   rebased to the current tip of Git's main branch).

Johannes Schindelin (3):
  ident: stop assuming that `gw_gecos` is writable
  meson: fix sorting
  cmake: generalize the handling of the `CLAR_TEST_OBJS` list

 contrib/buildsystems/CMakeLists.txt | 12 ++++++++----
 ident.c                             |  2 +-
 meson.build                         |  2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)


base-commit: e969bc875963a10890d61ba84eab3a460bd9e535
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1867%2Fdscho%2Fg4w-hot-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1867/dscho/g4w-hot-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1867

Range-diff vs v1:

 1:  045c11dc1d5 ! 1:  3e9ccffc747 ident: stop assuming that `gw_gecos` is writable
     @@ Commit message
          writable in the first place), so let's switch the loop variable type to
          `const char *`.
      
     +    This is not a new problem, but what is new is the Meson build. While it
     +    does not trigger in CI builds, imitating the commands of
     +    `ci/run-build-and-tests.sh` in a regular Git for Windows SDK (`meson
     +    setup build . --fatal-meson-warnings --warnlevel 2 --werror --wrap-mode
     +    nofallback -Dfuzzers=true` followed by `meson compile -C build --`
     +    results in this beautiful error:
     +
     +      "cc" [...] -o libgit.a.p/ident.c.obj "-c" ../ident.c
     +      ../ident.c: In function 'copy_gecos':
     +      ../ident.c:68:18: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     +         68 |         for (src = get_gecos(w); *src && *src != ','; src++) {
     +            |                  ^
     +      cc1.exe: all warnings being treated as errors
     +
     +    Now, why does this not trigger in CI? The answer is as simple as it is
     +    puzzling: The `win+Meson` job completely side-steps Git for Windows'
     +    development environment, opting instead to use the GCC that is on the
     +    `PATH` in GitHub-hosted `windows-latest` runners. That GCC is pinned to
     +    v12.2.0 and targets the UCRT (unlikely to change any time soon, see
     +    https://github.com/actions/runner-images/blob/win25/20250303.1/images/windows/toolsets/toolset-2022.json#L132-L141).
     +    That is in stark contrast to Git for Windows, which uses GCC v14.2.0 and
     +    targets MSVCRT. Git for Windows' `Makefile`-based build also obviously
     +    uses different compiler flags, otherwise this compile error would have
     +    had plenty of opportunity in almost 14 years to surface.
     +
     +    In other words, contrary to my expectations, the `win+Meson` job is
     +    ill-equipped to replace the `win build` job because it exercises a
     +    completely different tool version/compiler flags vector than what Git
     +    for Windows needs.
     +
     +    Nevertheless, there is currently this huge push, including breaking
     +    changes after -rc1 and all, for switching to Meson. Therefore, we need
     +    to make it work, somehow, even in Git for Windows' SDK, hence this
     +    patch, at this point in time.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## ident.c ##
 2:  9d1faeae8a4 = 2:  4e9ab3e011f meson: fix sorting
 -:  ----------- > 3:  59a2e586e1a cmake: generalize the handling of the `CLAR_TEST_OBJS` list

-- 
gitgitgadget
