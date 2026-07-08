Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0903BB4A
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480884; cv=none; b=l8pehdbqNDKYwbeQDTV4/XyhWCz/p5bNIzseeZtXno86LTiXRvGUToj15NZhB0sLsvo1nztwEvG5H7UohA/alWa/4OTCOqW7i3GNjck2ysn0Q3fiy6zY2sc9oSwVuKu2ySdQRa4aZN2ER9XMvNgY3bSWseWrQ0+mrQriWJkMXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480884; c=relaxed/simple;
	bh=jr3midZpBh4oIdMZiKVJ78ZTtL8ldWiGXLhKtJhSP+Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fesCWK9fR3Kh/0pmO4kNQfUBtYsQx4r1EyFVpHpfo5R9Vaun+JymdQ+xB9xdVy1TftdXV4OehasuhewSp7+GQr2KeJt2QKKpanJOiu8JJZRN+bAePlfA2m+5VVzMTuAUONkLxn4ECNR3hZy3UlM4EGaD/rrHOeuZu2+Ff3BxB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF8a++Fi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF8a++Fi"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-517dc520840so945241cf.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 20:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480881; x=1784085681; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qEzJDvhpFnVrzyfV6GCkvaX0yqXAAb8hXbVj+ITfF7c=;
        b=cF8a++FixvbAmOXrkO0qGwY6CxVTXYIYVuoL/QQDgqqLpYXOzB4iZgdbT3Z6miJrcP
         cXyibN5RoO2O7mn3+OL0sRl/cuJKw4cLqQ7cFcVjEZiOtA+/EEYxLYE08Y+kjS+6qnX+
         SBOWD+52I2Xest3rlMBIc6VG8PEa5COCtZ/d9AFGwXK5LFneTr3re0672tVZCKEOIOHs
         2XjXof681i/Gv+nPenII0ozMlbue66MXcOObA9GoXEhVHH59EaUNezWGHi77SmeuX8Sc
         IpKHH6GqQeAm/j0A0NZBOczgM/D/Z+sZfbs1Jd9kDviUFINR4Z3ieXiX8MbHuWuPfOw9
         ZCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480881; x=1784085681;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qEzJDvhpFnVrzyfV6GCkvaX0yqXAAb8hXbVj+ITfF7c=;
        b=kLqUK9OHzQUpTfGDqEszG47QWtK9YC29E5KpyCBywO9cthKIo1Wh/pYFl+oIaOeLDi
         NT8jIh6yYvgEpFPYdqNRO3+fITfigZdF9ebNDz4aBUMUcR/dAQM1+28b1U3r2bfiQijM
         wtxXvM+CJDQRIyHsnv9lhJyrj5KovoR8lcBYbybtQ6UPSxAVIcKWBFcvtu/qPOqrXo7I
         O3G/0cKdZhz0qZNRLvCpjte2Rpa1QVP/gqafIeXgeL46yskd2v1ShPv+YRkZ9y5jw/6L
         AD0grAxE1JHxITep+HC3g8hgWYokHh8LRrlaHuUNE1j2mu5zH75ViK11CjdDd6jvaPK2
         nLrQ==
X-Gm-Message-State: AOJu0Yw96LcHfOeGImYl3NMtY9luYhTnAQLWaLUUoDbi0N4Op5FfQ1b+
	Aa+UgtihBnC56/DRHtktjZc20o3Vp2E9MsFfx5x1BH6cq+w22OODkS+UxBF2MBir
X-Gm-Gg: AfdE7ckZFPqK+kEheVJ/m6GPhWZ4egRAlU8ff3HFEBYBn5AqQ3JF/8KGNsL7dzoWhZT
	MPbJlaMOTNncOvzRaoalDtRe6ePVLltKNntWNK1uh1ELUQFDjOVaWrqoDaK8cyThslHkPG3T0mt
	MluAp4K1327gSKlsFDqJFwvqSMIUxaD73jX+vseJ4lkj+/v4jUVNzqMgd8FzmOfCs4LJ9baEGuW
	hsQoVCPdQbhX6R+tMQhIBmRr7LXIRCl4OlOLVg2pIJtFV+xsVhyLpab3uUIBqKdM4m/i4iV/Gd5
	G/d18R7EdkcyXkWKtpf8QoCXF0GNiHhUgVW8hC8hchIFGLrlZDEXlbCIjn92Va8getQxSEMFF7y
	wraksb5/jyNmpbyAC3oLf04f+z07QKyDiK/GhlXLpvSoIKse7boWsgbgTsCZxoqTh28Kx4Cf+x3
	fGas7f/YAPTSDdF8xldQ==
X-Received: by 2002:ac8:5fc5:0:b0:517:5add:e449 with SMTP id d75a77b69052e-51c8b3e1780mr9081281cf.22.1783480881483;
        Tue, 07 Jul 2026 20:21:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.110.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b266c0sm127554151cf.8.2026.07.07.20.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:21:20 -0700 (PDT)
Message-Id: <pull.2288.v8.git.git.1783480879.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
References: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 03:21:16 +0000
Subject: [PATCH v8 0/3] Makefile: link osxkeychain helper against Rust
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Shardul Natu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Patrick Steinhardt <ps@pks.im>,
    Shardul Natu <shardul.27591@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>

This series improves macOS build reliability, automated CI verification, and
distribution support when Rust is enabled in the Git build system. It
addresses three distinct challenges: a parallel build race condition in
git-credential-osxkeychain, support for macOS Universal Binaries
(multi-architecture distribution), and missing automated CI test wiring for
macOS contrib utilities.


Why This Series is Needed
=========================

 1. Parallel Build Race Condition (make -j): While commit 522ea8ef7d
    ("osxkeychain: fix build with Rust") updated the link command for
    git-credential-osxkeychain to pass $(LIBS), it omitted $(RUST_LIB) from
    the target prerequisite list. When running a parallel build (make -j)
    from a clean working tree, Make can attempt to link
    git-credential-osxkeychain before Cargo has finished compiling
    libgitcore.a, causing linker failures.

 2. macOS Universal Binary (lipo) Support: On macOS, Universal Binaries
    bundle native executable code for multiple architectures (Intel x86_64
    and Apple Silicon arm64) into a single file. This is standard practice
    for macOS distribution and CI packaging (such as Burrito, Homebrew, and
    Git's macOS CI runners), allowing a single artifact to run natively
    across all Macs without Rosetta translation.

While Apple's C compiler (clang) natively supports universal builds by
passing -arch x86_64 -arch arm64 in CFLAGS and LDFLAGS, Cargo and rustc do
not support multiple -arch flags in a single invocation. Instead, Cargo must
be invoked separately for each target triple (--target x86_64-apple-darwin
and --target aarch64-apple-darwin). This series bridges that gap.

 3. Automated CI Verification for Contrib on macOS: When running make test
    with TEST_CONTRIB_TOO=yes (default in macOS CI workflows), $(MAKE) -C
    contrib/ test is invoked. However, contrib/Makefile only invoked tests
    for diff-highlight and subtree, meaning git-credential-osxkeychain was
    never compiled or verified during standard CI test runs.


Overview of Patches
===================

 * Patch 1: Makefile: add $(RUST_LIB) prerequisite to osxkeychain Adds
   $(RUST_LIB) as a prerequisite dependency to the osxkeychain target,
   eliminating the parallel build race condition. Additionally, wraps the
   definitions of $(RUST_LIB) and the rust build target in ifndef NO_RUST so
   that disabling Rust cleanly makes the dependency a no-op.

 * Patch 2: Makefile: support universal macOS builds via RUST_TARGETS Allows
   users to specify space-separated target triples in RUST_TARGETS.
   Introduces declarative pattern rules (target/%/...) to compile each
   target slice via Cargo, and uses lipo (part of the mandatory Xcode
   Command Line Tools) to combine the resulting static archives into a
   universal library at target/release/libgitcore.a. Uses
   mkdir_p_parent_template to guarantee directory creation before lipo.
   
   * Patch 3: contrib: wire up osxkeychain in contrib/Makefile on macOS Adds
     a test target to contrib/credential/osxkeychain/Makefile that depends
     on building git-credential-osxkeychain. Introduces a generic OS_CONTRIB
     variable in contrib/Makefile to conditionally wire
     credential/osxkeychain into all, test, and clean whenever running on
     macOS (Darwin). This guarantees that standard CI test runs on macOS
     automatically compile and link the helper, preventing build
     regressions.

Changes since v7:

 * Added inclusion of ../config.mak.uname to the top of contrib/Makefile in
   the canonical order. This guarantees that $(uname_S) is correctly defined
   on the shell, preventing the OS_CONTRIB additions from being silently
   ignored.

Changes since v5:

 * Reverted Patch 1 to depend explicitly on $(LIB_FILE) $(RUST_LIB) rather
   than $(GITLIBS). Unlike Git builtins or scalar (which define cmd_main()),
   git-credential-osxkeychain.c defines its own standalone main(), meaning
   $(GITLIBS) caused a duplicate symbol error for _main during linking.
 * Added Patch 3 ("contrib: wire up osxkeychain in contrib/Makefile on
   macOS") using a scalable OS_CONTRIB variable so that running make test
   with TEST_CONTRIB_TOO=yes in macOS CI workflows automatically verifies
   compilation and linking integrity.

Changes since v4:

 * Changed the osxkeychain prerequisite dependency from $(LIB_FILE)
   $(RUST_LIB) to $(GITLIBS) to match the canonical prerequisite pattern
   used by all other core Git targets linking $(LIBS).

Changes since v3:

 * Removed leading @ from $(call mkdir_p_parent_template) so it relies on
   the built-in $(QUIET_MKDIR_P_PARENT) behavior, matching existing Makefile
   conventions.
 * Replaced if [ with if test in Bourne shell recipe snippets to strictly
   adhere to the project's CodingGuidelines.

Changes since v2:

 * Split the original combined commit into a two-patch series to separate
   prerequisite bug fixes from Universal Binary features.
 * Added $(call mkdir_p_parent_template) prior to invoking lipo to guarantee
   that parent target directories exist.

Shardul Natu (3):
  Makefile: add $(RUST_LIB) prerequisite to osxkeychain
  Makefile: support universal macOS builds via RUST_TARGETS
  contrib: wire up osxkeychain in contrib/Makefile on macOS

 Makefile                                | 46 ++++++++++++++++++++++---
 contrib/Makefile                        | 12 +++++++
 contrib/credential/osxkeychain/Makefile |  4 ++-
 3 files changed, 56 insertions(+), 6 deletions(-)


base-commit: 00534a21ce949ef80a5b8b9d7fc20b7d381038e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2288%2Fkiranani%2Fnext-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288/kiranani/next-v8
Pull-Request: https://github.com/git/git/pull/2288

Range-diff vs v7:

 1:  8f2bd4b14a = 1:  8f2bd4b14a Makefile: add $(RUST_LIB) prerequisite to osxkeychain
 2:  a999be6939 = 2:  a999be6939 Makefile: support universal macOS builds via RUST_TARGETS
 3:  32af2c51a8 ! 3:  5659709ab4 contrib: wire up osxkeychain in contrib/Makefile on macOS
     @@ Commit message
      
       ## contrib/Makefile ##
      @@
     ++include ../config.mak.uname
      +-include ../config.mak.autogen
      +-include ../config.mak
      +
     ++
      +ifeq ($(uname_S),Darwin)
      +OS_CONTRIB += credential/osxkeychain
      +endif

-- 
gitgitgadget
