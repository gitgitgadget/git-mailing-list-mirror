Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5F1EE7DF
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595257; cv=none; b=gSCMKa6ToPbY6DL8tdRlqOUEMp6GhoWZw/IKHAjWJkOUihaPMabjRBeO61SCRob6sBFoHpAT6Jnyyz+sdG6e1BO3eCSYeEMsvadPx+ndZEUvc3SkpVNzL3IbgLYfkntcb7Oh4Kb5AZ/SagygxZ7rFCfRaCmsrky9GezO+aPfR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595257; c=relaxed/simple;
	bh=U0eg0+jsZOeGfLxus45uDP0tgVW3w/oAZ+JHhm7qnQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ug/hS702qshiSfeBRTO+ScFHXbQiVdWc+lK7Wezc8/1WHphYP3CMfy9xYE0tVXHQ9lhfblZa1y23iOAFtPWA/YcMTjiq6JmsateXG97KgWkwx+JbRYFTjmC6O8JtkvbH7ZvIUC4FC0GzM+Kcb00FhHXazLjYwVRJl/SZklcwq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ory5nRMY; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ory5nRMY"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c2c24379a1so1637557fac.2
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595254; x=1743200054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5oYUJt6W1Ik82bSdUhQKQmcQe/tRXDQfeMsoXywrQOY=;
        b=ory5nRMYmQZ+3gCo0EHD/h64gPCeH6vM8NYsX0gUOfXYH6p+KUZbSvUyfRVT9z7+Fq
         yWjTF0nB/2N1r+WtaZzVQ/RfXZmY7CzlaUwlrZNWSAGgDjRZUyBNtrOA/hMYyr2N9tKO
         jA8uVmDgdB0kA8qzy+FsmPRaLzg+2boVG2SN4JrR8d6qRFp6cRuYvx7L7oEm7g795GYE
         6uixe7DFKT5bDg8U0+pJsIHPclyVt24RBxQEFgJBd3Tt9unLeaHdsEnnKmB2TRkKaNKd
         EHsRvoI9+Wbsef5OU4d7v/BApDz5br1XEe4n8BJUALIKWckDxpS0NX7LTqXxG1aQsaxO
         a3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595254; x=1743200054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oYUJt6W1Ik82bSdUhQKQmcQe/tRXDQfeMsoXywrQOY=;
        b=IjRawsnmSAv668HSTv3ngDbc6kndM3tDFdoDfFcppOOseqVImIrgT9S8vzoAZZfrq7
         6B2PQhCN/GHrlRnoKoGPlnIh9jG9NRA4PZIdSLOvQCq6VtpspUJFjyzZ/ZQifGD52Grx
         CPcEuobtezw7iy5XamR63llHaiK9eRCNang10UEWvsHPyRCDdFb4JpIOj+Wz0s5Qx8so
         ZEsBitRk71tdW+tfWQpnXikuefeY9Hw51V9D5ThexMJJfjK4EbouKOcGIWKr1lnyls8T
         CZbQGWf+8jSM8OBURLCn85pL/z7euRSc3ey91TmsL/X/Yncfzxq9QOM1Ya5/3+70c0Iv
         OKpA==
X-Gm-Message-State: AOJu0YxeQtKu0QSd5Ghxhqpo0PHujJ7eYDELOeMJaCf4jUgaZWcFEi8q
	WC0QNNakmJBslgpHQLdclSLYjdvhwXOjT4U/H/BdVA3EySWec29y6WJxROR47dv0wbZHSuL9Lfh
	mnvdQF7OnTUFchtAUlrV+V+cMkxN3BzLLGtk/CMX2K49PtgcYKoGBn1iZjsxVj2GgtilA8kJNrb
	tJBoWM92uyPg/dDUaVwvJS7nZUt0ePRav10XsDFsE=
X-Google-Smtp-Source: AGHT+IEiRVPU5PDYPUFy1n09CWr1oqL/qiaCJPdrRvz0RGU49T3y0CYofI5dIw3zvxMKGHjAi4uXWLMNdz23Ew==
X-Received: from oabho27.prod.google.com ([2002:a05:6870:499b:b0:2c2:5b99:3e17])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:7e11:b0:296:dd30:e90f with SMTP id 586e51a60fabf-2c780299312mr3516576fac.16.1742595253921;
 Fri, 21 Mar 2025 15:14:13 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:14:06 -0700
In-Reply-To: <cover.1742339107.git.josh@steadmon.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <cover.1742594960.git.steadmon@google.com>
Subject: [PATCH v2 0/5] Fix `cargo package` for libgit-sys
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix `cargo package` for the libgit-sys crate by providing a pristine
copy of the Git source tree at package time, and by building object
files and other generated files outside of this tree. While we're at it,
improve parallel builds by plumbing Cargo's make flags to the make
command invoked in our build.rs script.

We also fix a few problems that would prevent us from publishing the
libgit-sys crate: we add a license and description to Cargo.toml, and we
exclude unnecessary files from the packaged source, to stay below
crates.io's 10 MB limit.

`cargo package` for the libgit-rs crate is still broken for now, because
it will require publishing the libgit-sys crate first.

Changes from V1:
* Reworked patch #2 to build outside of the source tree rather than
  running `make clean` after the build.
* Simplified patch #4 now that cleaning is no longer necessary.
* Added patch #5 to add some required Cargo.toml fields.


Josh Steadmon (5):
  libgitpub: move to separate contrib/ directory
  libgit-sys: add symlink to git repo root and build out of tree
  libgit-sys: parallelize build with Cargo's jobserver
  libgit-sys: exclude unnecessary directories in git-src
  libgit-{sys,rs}: add license and description fields

 Makefile                                      | 145 +++++++++++-------
 contrib/libgit-rs/Cargo.toml                  |   2 +
 contrib/libgit-sys/Cargo.toml                 |  13 ++
 contrib/libgit-sys/build.rs                   |  12 +-
 contrib/libgit-sys/git-src                    |   1 +
 .../public_symbol_export.c                    |   2 +-
 .../public_symbol_export.h                    |   0
 shared.mak                                    |   5 +
 8 files changed, 117 insertions(+), 63 deletions(-)
 create mode 120000 contrib/libgit-sys/git-src
 rename contrib/{libgit-sys => libgitpub}/public_symbol_export.c (96%)
 rename contrib/{libgit-sys => libgitpub}/public_symbol_export.h (100%)

Range-diff against v1:
1:  28e10e1092 = 1:  28e10e1092 libgitpub: move to separate contrib/ directory
2:  58111043a1 < -:  ---------- libgit-sys: add symlink to git repo root and clean after build
-:  ---------- > 2:  6befc95a2d libgit-sys: add symlink to git repo root and build out of tree
3:  4cf9996096 ! 3:  a34e23a83d libgit-sys: parallelize build with Cargo's jobserver
    @@ contrib/libgit-sys/build.rs: pub fn main() -> std::io::Result<()> {
          let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
     +    let makeflags = env::var_os("CARGO_MAKEFLAGS").unwrap();

    -     let make_output = make_cmd::gnu_make()
    -         .env("DEVELOPER", "1")
    -+        .env("MAKEFLAGS", &makeflags)
    -         .env_remove("PROFILE")
    -         .current_dir(git_root.clone())
    -         .args([
    -@@ contrib/libgit-sys/build.rs: pub fn main() -> std::io::Result<()> {
    -
          let make_output = make_cmd::gnu_make()
              .env("DEVELOPER", "1")
     +        .env("MAKEFLAGS", &makeflags)
4:  9b5d4aa140 < -:  ---------- libgit-sys: exclude unnecessary directories in git-src
-:  ---------- > 4:  390695ac1f libgit-sys: exclude unnecessary directories in git-src
-:  ---------- > 5:  3a87f54693 libgit-{sys,rs}: add license and description fields


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0.395.g12beb8f557-goog

