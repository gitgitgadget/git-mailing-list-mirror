Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6832A3D7
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890157; cv=none; b=jVrLKy7bfdjC2BwmepT1kaQlUtyS5G3lBJxUlsiKqovHT7hxOd0qmXoIrRRzd0EZ2Uw5Bsu8uAnS4daRSZkhqzyGGpjgxwh5TiZ/bwBJwyj2IhxTnfQTJCACph9/PQkB66tmI61nWAgfXGa5K1a8arR6WOypr7jxUz4Z+WOol+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890157; c=relaxed/simple;
	bh=3h6qu+Lpd6oDi2duoShCxiWtkUsDt2l2KVK8yKQd3JU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n49mrh4JWDq7cpLwMNPIBmteS1o+8qZ9Kf2dnuN7Y8fEnDAVaFth1Ovv8lPGM+MhR3UZbobq2p7XudDgKaE4RFAOezTw958UBiEMmi/EQzrtL8oZmKO1B9TAapPm7jxQt2NYVhWX6yS8EwCU6YpqLSDF4MYflwzx3MxPjhNvzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFY2FEWT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFY2FEWT"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8a3eac7ca30so8332485a.2
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890154; x=1763494954; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER+AX5SX31xDelYlgeIJ2fRyAAD0RPsl4GGm9QvNAP0=;
        b=eFY2FEWTE23mK8ZK8CIdxu/jH/HjtC4dU7BMatsYuezAvpmmnThh+NSnGZx6QkpLky
         A2r7UHRdLgXg921WrfnH9vbJkp9ehTDqI6rfc6QWkRdR9fYJtjy2KYG+1yq3/k9CIwaL
         +jrHHQh4c0zC5Pl4j9H7D64MrkyfV84keea+TvdP+b+HO0gCr+PEEa8fG9AXkBOqsbmL
         6zU0azo66K0LFgy/ESoCAqGQTiQESLbGqwezKXsxDVrg3D8XWUu+c242Obm1icpAsSqs
         nEUsBDI7gfJs42Tf3XRUXbDskhxo75tZTyopbwvJicIZ56mpofKgdUL0UKXsacNceJm3
         284A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890154; x=1763494954;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ER+AX5SX31xDelYlgeIJ2fRyAAD0RPsl4GGm9QvNAP0=;
        b=LfsgWaTzI0dYgsYZofPy6wsalxorHi8UyaJzL4Grv7CVFjamaEFcRc92F+USeOyzCq
         uD2UedV6RGSgAs2gV/oyX0o7/T5v5469XmKlggcWGNKRklwm0FSjVGtgm9LE1wKb+0jb
         fE4xk6yxPoSBAa8VchIP9x7DrgITiBDsW+Bcco8JhQtfOvP8PXBQvMXVg+drV+iIQt6N
         kKToVRDYhuFUruBQeNwx2d0elys8E/8owwbLFUs+lUvQUGYSlRuDvZcf1d6Sc7jfUVqf
         ljQsmOevVqF3keZCfBGjzb3FPsvnqz98PFJZIvOe4mEzToII1Jqb37I7EqVMBV+nr7hV
         9KIw==
X-Gm-Message-State: AOJu0YzuXaQICcxVIgMyUAo7qkq+A5qsrXkxoRNdyCYvqlDtEp8Jh3L3
	fOXPm5C/NrrFlhNdNglxkC3+DKNfKArpBVKrltZf7lf/ms9l36+cQaleojczNg==
X-Gm-Gg: ASbGncuV47l+oIwubRHxLf45ha1xABNl+OUNV9VFCyc1NO7WXU7Zjyl1iN27VXH/4TZ
	JV+Yp6iR2uWRxJENyWZEqevhi1UIuErvwtAo2vbyxMOucQSp44ivqe4Pfvi8HU0wtW3pUVytrsx
	qUe1bp35yVKFwkVYzxNc4WOdMHyZEzx/890iJ0MBzPdeAjS+1HTgN6JYKAweVNoeo07fclFXakY
	dZ7me2P5SFZk49O0B2ADWZuQ22W2Ith5j0EVyXFyerI+wo/xqeTkQzz1SlMtQmm7cCPCoHjiQQ7
	pRYy4I4eRB4v1OF+RDP/517XqV7aEBvRT5CilGv2iU+cMn3hAY3BkOWGkPRKvU88SbRzu9gn7Rs
	THWK5VqgENK6EMFesNN8qrRtxGdwTjssMG/i7tJZ7s+9T/V2RY1ZLAeYBYux5UCT59iamZs3BoW
	dm7n4=
X-Google-Smtp-Source: AGHT+IEBKFcJwQpODk4sMXS/XXDIDbEVrMapqe+y8VchRJQNGBgjW/g8QVp4Ysnbx9i/4MquxBADig==
X-Received: by 2002:a05:620a:2546:b0:8a3:cd9e:e40e with SMTP id af79cd13be357-8b29b84ff51mr56233085a.86.1762890153817;
        Tue, 11 Nov 2025 11:42:33 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a84b075sm44653485a.7.2025.11.11.11.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:42:33 -0800 (PST)
Message-Id: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 19:42:22 +0000
Subject: [PATCH v3 00/10] Xdiff cleanup part2
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
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes in v3:

 * Address comments about commit messages and documentation
 * Add unambiguous-types.adoc to Makefile and Meson
 * Use markdown style to avoid asciidoc issues

Changes in v2:

 * Added documentation about unambiguous types and FFI
 * Addressed comments on the mailing list


Original cover letter below:
============================

Maintainer note: This patch series builds on top of en/xdiff-cleanup and
am/xdiff-hash-tweak (both of which are now in master).

The primary goal of this patch series is to convert every field's type in
xrecord_t and xdfile_t to be unambiguous, in preparation to make it more
Rust FFI friendly. Additionally the ha field in xrecord_t is split into
line_hash and minimal_perfect hash.

The order of some of the fields has changed as called out by the commit
messages.

Before:

typedef struct s_xrecord {
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	long nrec;
	long dstart, dend;
	bool *changed;
	long *rindex;
	long nreff;
} xdfile_t;


After part 2

typedef struct s_xrecord {
	uint8_t const *ptr;
	size_t size;
	uint64_t line_hash;
	size_t minimal_perfect_hash;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	size_t nrec;
	bool *changed;
	size_t *reference_index;
	size_t nreff;
	ssize_t dstart, dend;
} xdfile_t;


Ezekiel Newren (10):
  doc: define unambiguous type mappings across C and Rust
  xdiff: use ptrdiff_t for dstart/dend
  xdiff: make xrecord_t.ptr a uint8_t instead of char
  xdiff: use size_t for xrecord_t.size
  xdiff: use unambiguous types in xdl_hash_record()
  xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
  xdiff: make xdfile_t.nrec a size_t instead of long
  xdiff: make xdfile_t.nreff a size_t instead of long
  xdiff: change rindex from long to size_t in xdfile_t
  xdiff: rename rindex -> reference_index

 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/unambiguous-types.adoc          | 239 ++++++++++++++++++
 xdiff-interface.c                             |   2 +-
 xdiff/xdiffi.c                                |  29 +--
 xdiff/xemit.c                                 |  28 +-
 xdiff/xhistogram.c                            |   4 +-
 xdiff/xmerge.c                                |  30 +--
 xdiff/xpatience.c                             |  14 +-
 xdiff/xprepare.c                              |  60 ++---
 xdiff/xtypes.h                                |  15 +-
 xdiff/xutils.c                                |  32 +--
 xdiff/xutils.h                                |   6 +-
 13 files changed, 351 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/technical/unambiguous-types.adoc


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2070%2Fezekielnewren%2Fxdiff_cleanup_part2-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2070/ezekielnewren/xdiff_cleanup_part2-v3
Pull-Request: https://github.com/git/git/pull/2070

Range-diff vs v2:

  1:  88133848d1 !  1:  e5d084d340 doc: define unambiguous type mappings across C and Rust
     @@ Commit message
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     + ## Documentation/Makefile ##
     +@@ Documentation/Makefile: TECH_DOCS += technical/shallow
     + TECH_DOCS += technical/sparse-checkout
     + TECH_DOCS += technical/sparse-index
     + TECH_DOCS += technical/trivial-merge
     ++TECH_DOCS += technical/unambiguous-types
     + TECH_DOCS += technical/unit-tests
     + SP_ARTICLES += $(TECH_DOCS)
     + SP_ARTICLES += technical/api-index
     +
     + ## Documentation/technical/meson.build ##
     +@@ Documentation/technical/meson.build: articles = [
     +   'sparse-checkout.adoc',
     +   'sparse-index.adoc',
     +   'trivial-merge.adoc',
     ++  'unambiguous-types.adoc',
     +   'unit-tests.adoc',
     + ]
     + 
     +
       ## Documentation/technical/unambiguous-types.adoc (new) ##
      @@
      += Unambiguous types
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +|===
      +| C Type | Rust Type
      +| size_t^3^     | usize
     -+| ptrdiff_t^4^  | isize
     ++| ptrdiff_t^3^  | isize
      +|===
      +
      +== Character types
      +
     -+This is where C and Rust don't have a clean one-to-one mapping. A C `char` is
     -+an 8-bit type that is signless (neither signed nor unsigned) which causes
     -+problems with e.g. `make DEVELOPER=1`. Rust's `char` type is an unsigned 32-bit
     -+integer that is used to describe Unicode code points. Even though a C `char`
     -+is the same width as `u8`, `char` should be converted to u8 where it is
     -+describing bytes in memory. If a C `char` is not describing bytes, then it
     -+should be converted to a more accurate unambiguous type.
     ++This is where C and Rust don't have a clean one-to-one mapping.
     ++
     ++C comparison problem: While the sign of `char` is implementation defined, it's
     ++also signless (neither signed nor unsigned). When building with
     ++`make DEVELOPER=1` it will complain about a "differ in signedness" when `char`
     ++is compared with `uint8_t` or `int8_t`.
     ++
     ++Rust's `char` type is an unsigned 32-bit integer that is used to describe
     ++Unicode code points. Even though a C `char` is the same width as `u8`, `char`
     ++should be converted to u8 where it is describing bytes in memory. If a C
     ++`char` is not describing bytes, then it should be converted to a more accurate
     ++unambiguous type. The reason for mentioning Unicode here is because of how &str
     ++is defined in Rust and how to create a &str from &[u8]. Rust assumes that &str
     ++is a correctly encoded utf-8 string, i.e. text in memory. Where as a C `char`
     ++makes no assumption about the bytes that it is representing.
     ++
     ++```
     ++let raw_bytes = b"abc\n";
     ++let result = std::str::from_utf8(raw_bytes);
     ++if let Ok(line) = result {
     ++    // do something with text
     ++}
     ++```
      +
      +While you could specify `char` in the C code and `u8` in Rust code, it's not as
      +clear what the appropriate type is, but it would work across the FFI boundary.
     -+However the bigger problem comes from code generation tools like cbindgen and
     -+bindgen. When cbindgen see u8 in Rust it will generate uint8_t on the C side
     -+which will cause differ in signedness warnings/errors. Similaraly if bindgen
     -+see `char` on the C side it will generate `std::ffi::c_char` which has its own
     ++However, the bigger problem comes from code generation tools like cbindgen and
     ++bindgen. When cbindgen sees u8 in Rust it will generate uint8_t on the C side
     ++which will cause differ in signedness warnings/errors. Similarly if bindgen
     ++sees `char` on the C side it will generate `std::ffi::c_char` which has its own
      +problems.
      +
      +=== Notes
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +platform/arch for C does not follow IEEE-754 then this equivalence does not
      +hold. Also, it's assumed that `float` is 32 bits and `double` is 64, but
      +there may be a strange platform/arch where even this isn't true. +
     -+^3^ C also defines uintptr_t, but this should not be used in Git. +
     -+^4^ C also defines ssize_t and intptr_t, but these should not be used in Git. +
     ++^3^ C also defines uintptr_t, ssize_t and intptr_t, but these types are
     ++discouraged for FFI purposes. For functions like `read()` and `write()` ssize_t
     ++should be cast to a different, and unambiguous, type before being passed over
     ++the FFI boundary. +
      +
      +== Problems with std::ffi::c_* types in Rust
     -+TL;DR: They're not guaranteed to match C types for all possible C
     -+compilers/platforms/architectures.
     ++TL;DR: In practice, Rust's `c_*` types aren't guaranteed to match C types for
     ++all possible C compilers, platforms, or architectures, because Rust only
     ++ensures correctness of C types on officially supported targets. These
     ++definitions have changed over time to match more targets which means that the
     ++c_* definitions will differ based on which Rust version Git chooses to use.
      +
     -+Only a few of Rust's C FFI types are considered safe and semantically clear to
     -+use: +
     ++Current list of safe, Rust side, FFI types in Git: +
      +
      +* `c_void`
      +* `CStr`
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +Even then, they should be used sparingly, and only where the semantics match
      +exactly.
      +
     -+The std::os::raw::c_* (which is deprecated) directly inherits the problems of
     -+core::ffi, which changes over time and seems to make a best guess at the
     -+correct definition for a given platform/target. This probably isn't a problem
     -+for all platforms that Rust supports currently, but can anyone say that Rust
     -+got it right for all C compilers of all platforms/targets?
     -+
     -+On top of all of that we're targeting an older version of Rust which doesn't
     -+have the latest mappings.
     ++The std::os::raw::c_* directly inherits the problems of core::ffi, which
     ++changes over time and seems to make a best guess at the correct definition for
     ++a given platform/target. This probably isn't a problem for all other platforms
     ++that Rust supports currently, but can anyone say that Rust got it right for all
     ++C compilers of all platforms/targets?
      +
      +To give an example: c_long is defined in
      +footnote:[https://doc.rust-lang.org/1.63.0/src/core/ffi/mod.rs.html#175-189[c_long in 1.63.0]]
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +
      +=== Rust version 1.63.0
      +
     -+[source]
     -+----
     ++```
      +mod c_long_definition {
      +    cfg_if! {
      +        if #[cfg(all(target_pointer_width = "64", not(windows)))] {
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +        }
      +    }
      +}
     -+----
     ++```
      +
      +=== Rust version 1.89.0
      +
     -+[source]
     -+----
     ++```
      +mod c_long_definition {
      +    crate::cfg_select! {
      +        any(
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +        }
      +    }
      +}
     -+----
     ++```
      +
      +Even for the cases where C types are correctly mapped to Rust types via
      +std::ffi::c_* there are still problems. Let's take c_char for example. On some
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +The following code will panic in debug on platforms that define c_char as u8,
      +but won't if it's an i8.
      +
     -+[source]
     -+----
     ++```
      +let mut x: std::ffi::c_char = 0;
      +x -= 1;
     -+----
     ++```
      +
      +=== Inconsistent shift behavior
      +
      +`x` will be 0xC0 for platforms that use i8, but will be 0x40 where it's u8.
      +
     -+[source]
     -+----
     ++```
      +let mut x: std::ffi::c_char = 0x80;
      +x >>= 1;
     -+----
     ++```
      +
      +=== Equality fails to compile on some platforms
      +
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +if it's u8. You can cast x e.g. `assert_eq!(x as u8, b'a');`, but then you get
      +a warning on platforms that use u8 and a clean compilation where i8 is used.
      +
     -+[source]
     -+----
     ++```
      +let mut x: std::ffi::c_char = 0x61;
      +assert_eq!(x, b'a');
     -+----
     ++```
      +
      +== Enum types
      +Rust enum types should not be used as FFI types. Rust enum types are more like
      +C union types than C enum's. For something like:
      +
     -+[source]
     -+----
     ++```
      +#[repr(C, u8)]
      +enum Fruit {
      +    Apple,
      +    Banana,
      +    Cherry,
      +}
     -+----
     ++```
      +
      +It's easy enough to make sure the Rust enum matches what C would expect, but a
      +more complex type like.
      +
     -+[source]
     -+----
     ++```
      +enum HashResult {
      +    SHA1([u8; 20]),
      +    SHA256([u8; 32]),
      +}
     -+----
     ++```
      +
      +The Rust compiler has to add a discriminant to the enum to distinguish between
      +the variants. The width, location, and values for that discriminant is up to
  2:  9197903add !  2:  52e3f589b1 xdiff: use ssize_t for dstart/dend, make them last in xdfile_t
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: use ssize_t for dstart/dend, make them last in xdfile_t
     +    xdiff: use ptrdiff_t for dstart/dend
      
     -    ssize_t is appropriate for dstart and dend because they both describe
     +    ptrdiff_t is appropriate for dstart and dend because they both describe
          positive or negative offsets relative to a pointer.
      
          A future patch will move these fields to a different struct. Moving
  3:  46bc1b3e25 !  3:  83e7bf180a xdiff: make xrecord_t.ptr a uint8_t instead of char
     @@ Metadata
       ## Commit message ##
          xdiff: make xrecord_t.ptr a uint8_t instead of char
      
     -    Rust uses u8 to refer to bytes in memory. Since xrecord_t.ptr is also
     -    referring to bytes in memory, rather than Unicode code points, use
     -    uint8_t instead of char.
     +    Make xrecord_t.ptr uint8_t because it's referring to bytes in memory.
      
          Every usage of this field was inspected and cast to char*, or similar,
          to avoid signedness warnings/errors from the compiler. Casting was used
     @@ xdiff/xprepare.c: static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, lo
       				goto abort;
       			crec = &xdf->recs[xdf->nrec++];
      -			crec->ptr = prev;
     --			crec->size = (long) (cur - prev);
      +			crec->ptr = (uint8_t const *)prev;
     -+			crec->size =(long) ( cur - prev);
     + 			crec->size = (long) (cur - prev);
       			crec->ha = hav;
       			if (xdl_classify_record(pass, cf, crec) < 0)
     - 				goto abort;
      
       ## xdiff/xtypes.h ##
      @@ xdiff/xtypes.h: typedef struct s_chastore {
  4:  07e28aad3b !  4:  da2b80ea0b xdiff: use size_t for xrecord_t.size
     @@ xdiff/xprepare.c: static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, lo
       				goto abort;
       			crec = &xdf->recs[xdf->nrec++];
       			crec->ptr = (uint8_t const *)prev;
     --			crec->size =(long) ( cur - prev);
     +-			crec->size = (long) (cur - prev);
      +			crec->size = cur - prev;
       			crec->ha = hav;
       			if (xdl_classify_record(pass, cf, crec) < 0)
  5:  1ade7d8165 =  5:  c6ba630ac5 xdiff: use unambiguous types in xdl_hash_record()
  6:  59054ea0cb !  6:  3834ea8f9b xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
     @@ Commit message
          xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
      
          The ha field is serving two different purposes, which makes the code
     -    harder to read. At first glance it looks like many places assume
     +    harder to read. At first glance, it looks like many places assume
          there could never be hash collisions between lines of the two input
          files. In reality, line_hash is used together with xdl_recmatch() to
          ensure correct comparisons of lines, even when collisions occur.
      
          To make this clearer, the old ha field has been split:
     -      * line_hash: The straightforward hash of a line, requiring no
     -        additional context.
     +      * line_hash: a straightforward hash of a line, independent of any
     +        external context. Its type is uint64_t, as it comes from a fixed
     +        width hash function.
            * minimal_perfect_hash: Not a new concept, but now a separate
              field. It comes from the classifier's general-purpose hash table,
              which assigns each line a unique and minimal hash across the two
     -        files.
     +        files. A size_t is used here because it's meant to be used to
     +        index an array. This also this avoids ` as usize` casts on the Rust
     +        side when using it to index a slice.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     @@ xdiff/xpatience.c: static int match(struct hashmap *map, int line1, int line2)
       static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
      
       ## xdiff/xprepare.c ##
     -@@ xdiff/xprepare.c: static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
     - 	long hi;
     +@@ xdiff/xprepare.c: static void xdl_free_classifier(xdlclassifier_t *cf) {
     + 
     + 
     + static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
     +-	long hi;
     ++	size_t hi;
       	xdlclass_t *rcrec;
       
      -	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
     -+	hi = (long) XDL_HASHLONG(rec->line_hash, cf->hbits);
     ++	hi = XDL_HASHLONG(rec->line_hash, cf->hbits);
       	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
      -		if (rcrec->rec.ha == rec->ha &&
      +		if (rcrec->rec.line_hash == rec->line_hash &&
  7:  f91be17858 !  7:  e2a2c7530c xdiff: make xdfile_t.nrec a size_t instead of long
     @@ Metadata
       ## Commit message ##
          xdiff: make xdfile_t.nrec a size_t instead of long
      
     -    size_t is used because nrec describes the number of elements in memory
     -    for recs, and the number of elements in memory for 'changed' + 2.
     +    size_t is used because nrec describes the number of elements for both
     +    recs, and for 'changed' + 2.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
  8:  e2a6a23cc4 =  8:  31cd2a1aa4 xdiff: make xdfile_t.nreff a size_t instead of long
  9:  3b6054945f !  9:  aee0d3958b xdiff: change rindex from long to size_t in xdfile_t
     @@ Metadata
       ## Commit message ##
          xdiff: change rindex from long to size_t in xdfile_t
      
     -    rindex describes a index offset which means it's an index into memory
     -    which should use size_t.
     +    The field rindex describes an index offset for other arrays. Change it
     +    to size_t.
      
          Changing the type of rindex from long to size_t has no cascading
          refactor impact because it is only ever used to directly index other
 10:  1856a29026 ! 10:  75c26fe160 xdiff: rename rindex -> reference_index
     @@ Commit message
      
          The classic diff adds only the lines that it's going to consider,
          during the diff, to an array. A mapping between the compacted
     -    array, and the lines of the file that they reference, are
     +    array, and the lines of the file that they reference, is
          facilitated by this array.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>

-- 
gitgitgadget
