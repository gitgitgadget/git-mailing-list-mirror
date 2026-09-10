Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371038DC50
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020331; cv=none; b=uxXga/ZAruXSSmfitS+yKVcwFheKcmYEdUwplpBoxBZVk8KeIxzLKkEGTTtydixFXB3DEV4OVeh+szPu7o44UG6E/rIMWXEzt1xkcVoZJ/YL4LaspwEHmM+ezuqfFOIAuC1rS7OZMhBAbP5m6ddwgzGhn6i2Mn0nVtmyDb7g9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020331; c=relaxed/simple;
	bh=p3kXdoGj6N0IpHcOjqCUoRWJwEic+ofLlIHR5U3iGEQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r6AD8VuRQW7F3LQu1jp5BjO5XXr3pTsbScQJyjylE754rSKvZpmt6hKCZFzC0ZHph5eJkIYTTkwC9iCnVqIt9rOQJVMpL6MKrdC8kR9ZyqYJO64fLRj6bmRT+4YC8BNw1CeFqEJ1Uf/3nbDubWf1LbnukR9X7l1oe6hR7XVFl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEuazSDM; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEuazSDM"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398e9698a70so6227156a91.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020329; x=1789625129; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9b61cAcjW8DL9nh2ANfQjf16Og2Unq6PNJcUKzcBaxA=;
        b=tEuazSDMTsmXuFyhrdc8M9j5z3SW7F8p6NKd6iqp01xwvCWakLMkTMW3pBUnxSZV4H
         cPoaVH00VYgxGlUapuVh9bvzcp1cfdU7MR1fUaLHWbdO91aPi7fB2pZCg6GCdq3KPSG9
         xBO1Y91ug9s4vNRXq3n5i6PmwRT2Jm0/iLDFIxXwyzqJXiIilGd/ULLwFc1EbFc6ns7+
         +DKo4CCBNoXq1yGy11/KpRwUgyQdR10swPen0+fWzN53TWqpJbUTe8q+YivkUY1tb2gq
         aMubSTemOOcyVN82TW0L6PZIXPmlqYLLIeG8A6acgoHg/DxT6ayUvI8dJWr7BPyJDccp
         p9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020329; x=1789625129;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9b61cAcjW8DL9nh2ANfQjf16Og2Unq6PNJcUKzcBaxA=;
        b=bk2aiwO+pTRq48hqK8h8UeLAwoIowkYI4UKyf4a/VHvZcENPtN4Ee0BqDgvLIp1BcJ
         zV9AbD+vvWvvB7ie+GApIFibHCeFdpfbY4VvL6kNydTdOwQI6RGs0W4OLtXbZB0sReQy
         T+NXdjAkOdZrfPid3zigDW46L3bWxmUs0Ke3kI7zQtJUSp7kju4bvLBzge1xc0g6xz6D
         llaZVYQLhrml14AW+/+VNythpGafS6yal6VSkdgFst/kG0KWetTjjwH/wlI2sk72rXF2
         cRUjolssF7UwE6cqtcbxxv17FfMhCBWj1DXqhODT2sXKSsrA8D//LbyUdWdTHvAUsg/s
         mjXA==
X-Gm-Message-State: AFuF++kiySWah/TnzLPalzknFSHOgNj29xGFoFC5UtteQizzPanP8T1C
	bU75KklI9HZdvjo/AXK6L4nCHcauUCe4iuqEkK2DouF7tBOL4N1BnKKMiKKosA==
X-Gm-Gg: AYBFou0e0sUamFa3kzEpxH1ejgio5qwwkVdCUdVz8f48YS549OVhQWBtFP83guImVvF
	XLj3G7hKvRM7gXIOoM5+pZSbNYu3OmswCtN4EN0KJJ9kMLt3ZOhWKp41FwDN+zvGxKEtJc2hCLZ
	MOJTZ62Mx/PUJq/H2f2Z+WMoSkj2B/drdKwguJZBgh36O7cqg40BfHQyUwOEQC/KNw+gs0J5XnW
	XxDy+O8gohUckB5Zxit1Pts4HEcFr9RSLea+LxlPLjh4kbhI3UlsUfsrujzVRyZ8C2P96MWQx4/
	6e6tlPzF77ZISfh+nr+z+Tr2Rb3SLDRE7hVTUOAAdH4m28H0HlpPV51sss0oLppsmYPBKhOuBG2
	oMaxZ/nFBKvLg01RLwnefkMyJSw2y9dbKaYiPC51StnTUqlBrnIMIO9LLCNvLJZ3uvzq6N2g5w2
	SLYTFXAdNiv3IHJQmYUT5fT0yP7hD7dcn9QRqGXNz6ZlnrSAfxJqelKW0I0fboCTRtKsxlhNjs
X-Received: by 2002:a17:90b:2884:b0:398:e86b:ce14 with SMTP id 98e67ed59e1d1-39b262ab44emr56880215a91.20.1789020328836;
        Wed, 09 Sep 2026 23:05:28 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33b95282a73sm1072322eec.31.2026.09.09.23.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:28 -0700 (PDT)
Message-Id: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:14 +0000
Subject: [PATCH v4 00/13] Upstream some more Git for Windows' patches
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

With the imminent switch of Git for Windows from the old MINGW64 environment
(that was deprecated by MSYS2) to the UCRT64 environment, this patch series
became quite urgent; I will have to work around this patch series not yet
being in master via setup-git-for-windows-sdk to be able to switch without
breaking Git's CI builds.

Originally, I noticed that these patches had not been upstreamed yet when
rebasing a Git for Windows commit to enable Rust in Windows CI.

Changes since v3:

 * Reinstated the fly-by style fix as a separate commit.
 * Added Helped-by trailers
 * Moved and reworded a paragraph from the commit message of 08/12 to 12/12;
   This should have been done as part of v2.

Changes since v2:

 * Moved some hunks that belonged into 12/12 out of 08/12.
 * Dropped a fly-by style cleanup from t0060.

Changes since v1:

 * Fixed the meson-side handling of the MINGW_PREFIX constant (this was not
   noticed in the Git for Windows project because it does not use Meson to
   build the project).

Johannes Schindelin (13):
  mingw: include the Python parts in the build
  mingw: stop hard-coding `CC = gcc`
  mingw: drop the -D_USE_32BIT_TIME_T option
  mingw: only use -Wl,--large-address-aware for 32-bit builds
  mingw: avoid over-specifying `--pic-executable`
  mingw: set the prefix and HOST_CPU as per MSYS2's settings
  mingw: only enable the MSYS2-specific stuff when compiling in MSYS2
  mingw: rely on MSYS2's metadata instead of hard-coding it
  windows: skip linking `git-<command>` for built-ins
  mingw: always define `ETC_*` for MSYS2 environments
  mingw: ensure valid CTYPE
  mingw: allow `git.exe` to be used instead of the "Git wrapper"
  t0060: adjust the code style

 compat/mingw.c                      | 68 +++++++++++++++++++++++++++++
 config.mak.uname                    | 61 ++++++++++++--------------
 contrib/buildsystems/CMakeLists.txt |  9 +++-
 meson.build                         | 15 ++++++-
 meson_options.txt                   |  4 ++
 t/t0060-path-utils.sh               | 33 +++++++++++++-
 6 files changed, 153 insertions(+), 37 deletions(-)


base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2195%2Fdscho%2Fupstream-some-more-git-for-windows-patches-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2195/dscho/upstream-some-more-git-for-windows-patches-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2195

Range-diff vs v3:

  1:  fd594ffa6c !  1:  0b8ca0e3b9 mingw: include the Python parts in the build
     @@ Commit message
          bandwidth), MSYS2 provides very fine Python interpreters that users can
          easily take advantage of, by using Git for Windows within its SDK.
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
  2:  47fc974582 !  2:  9894892ff5 mingw: stop hard-coding `CC = gcc`
     @@ Commit message
          This is no longer true in general, not with supporting Clang out of the
          box.
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
  3:  53f1fd5763 !  3:  340dd18f27 mingw: drop the -D_USE_32BIT_TIME_T option
     @@ Commit message
      
          So let's send that option into its well-deserved retirement.
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
  4:  ad96aedda6 !  4:  37c6563d74 mingw: only use -Wl,--large-address-aware for 32-bit builds
     @@ Commit message
          those builds; UCRT64 versions of GCC, for example, do not know what to
          do with that option.
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
  5:  d67201f9b3 !  5:  0063f2d96a mingw: avoid over-specifying `--pic-executable`
     @@ Commit message
      
          So let's drop the overly-specific definition.
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
  6:  b49c42c50d !  6:  e03279a0df mingw: set the prefix and HOST_CPU as per MSYS2's settings
     @@ Commit message
          can use those to infer the installation location as well as the CPU. No
          need for hard-coding ;-)
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
  7:  b00d242621 !  7:  29caf78bdd mingw: only enable the MSYS2-specific stuff when compiling in MSYS2
     @@ Commit message
          course. In that case, we want to ensure that `MSYSTEM` is set when
          running `git.exe`, and also enable the magic MSYS2 tty detection.
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
  8:  4cc14553dc !  8:  a9665a3304 mingw: rely on MSYS2's metadata instead of hard-coding it
     @@ Commit message
          Incidentally, this also broadens the support to all the configurations
          supported by the MSYS2 project, i.e. clang64 & ucrt64, too.
      
     -    Note: This keeps the same, hard-coded MSYSTEM platform support for CMake
     -    as before, but drops it for Meson (because it is unclear how Meson could
     -    do this in a more flexible manner).
     -
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
  9:  19c600cbee !  9:  0d2990aa14 windows: skip linking `git-<command>` for built-ins
     @@ Commit message
          This deprecation was never finalized by skipping these hard-links, but
          we can start the process now, in Git for Windows.
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
 10:  b8cc067e92 ! 10:  b5a78f65b6 mingw: always define `ETC_*` for MSYS2 environments
     @@ Commit message
      
          Special-casing even more configurations simply does not make sense.
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
 11:  09c90015fb ! 11:  1bbd0dc6aa mingw: ensure valid CTYPE
     @@ Commit message
      
          This fixes https://github.com/git-for-windows/git/issues/1036
      
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
 12:  4a4f24a1ba ! 12:  e8115c158c mingw: allow `git.exe` to be used instead of the "Git wrapper"
     @@ Commit message
      
          This addresses https://github.com/git-for-windows/git/issues/2283
      
     +    Note: This keeps the same, hard-coded MSYSTEM platform support for CMake
     +    as before, and introduces an `msystem' and `mingw-prefix` knob for Meson
     +    (read: neither CMake nor Meson will automatically inherit the setting
     +    from the current build environment).
     +
     +    Helped-by: Johannes Sixt <j6t@kdbg.org>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
  -:  ---------- > 13:  88403ffc9e t0060: adjust the code style

-- 
gitgitgadget
