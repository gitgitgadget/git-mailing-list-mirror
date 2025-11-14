Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8929D27A
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159823; cv=none; b=dmV0XPxpcToQD2qHp3TQ7s2nahqzZy3QVi0xXxxUl+aRsEUWyn56bqd/SEAfZwIsyk9KuwDZyeeNWHPvwzzjz7l7x4KLdHImpwIyVnlhlEa6ZLdRuUChPXxKhJj4FPlCFaguAgdtjITiYHdJq1Gh+v3ZfUV9fB8aB1Zb42gQ8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159823; c=relaxed/simple;
	bh=F9U7u3r7Pu1pp9uDLF7qEy3Chkv28K6PHnaqzpI322E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TrheJt5pOUIVwEi8N4FLcfBraHWsRBf1y3YM2hBNDU7phdfx8y5a002qwFRlV55BGmR2Y8KrBOrCVsGumQokv+4JSNj3uk2kKr+SqSfEsgG7t5ZJhZXbQejgLFH0PoY//G9IQO3xeeRAStwrX6UkjyYx1ELksqEa3O50A9vFWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlnQKstQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlnQKstQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297d4a56f97so25636985ad.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 14:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159818; x=1763764618; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dMF1FIUoZTtwKrIy02EprjTBCg7DT7Wj8vgHIBXmMg=;
        b=jlnQKstQqIGLfQANEHfthuHoc4NNML6coszLn5XpgG3t1wI08kLyuYWv+CyBVoJOUu
         8sgUl0PgRU30aHscWj0jyioQMlmH+OWBGtNkhNdDiZ1hdrrEhHl0RAT2fSZeOV4MpiWa
         /ygKCoexrraX04WNIpZ2jIuryNlbT2AcMUkTkWL1+ocQ86iMpjKeQc5boccMsGP2TxK2
         b6tNFgymglv9iRKC7iGII51CpAY2KT5snH5RJg6Y2zUCCN6O9tc4zDsGA7DwBcCKeawK
         XvZPpa2SPbFv6t58rBuXpokBkFaiENXkimxSzdBrnNEUjsB/vCiMnQX5cBG4lV8df1GL
         LLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159818; x=1763764618;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2dMF1FIUoZTtwKrIy02EprjTBCg7DT7Wj8vgHIBXmMg=;
        b=gDlDYIbF50PRKV/JJfzg1zoR5rWKjdM1VCbtC1IQr6ExNmleLVEHRwSQrjUHGOT3Nh
         2G0zLQ28+71MEko8yPWpL/jdbhAOhtY357DH9a8yTKq9qE597iTv0OGXch2cJ8oU+9Cu
         tj3g+2+ENupz5RAib39piEF+uxbxQ48m0rQPc0KofIOYfJYReO7jMNuTsdqTQeJOPByQ
         M8+ByNhiK8ryV96UyezuX5+xG4hABymuQd9xdmXGUtqnbyHg5k9ELY1eGyQZ1mXcmsYW
         SjaoOnAvbz3L47nQrc5pyx2FoO14aXLrTu6/cTM88m+k/0d8LE5PLSo627ZhDfLxceAf
         f1vA==
X-Gm-Message-State: AOJu0YxWYE3R+rH4V2mlJ85MWHBMvDoXhoom38HfbHmfJLGWlA7ZQUdy
	0p5W34pHVXrJV/JxqATwXfAVBv0sC8QFMY4ZPIZCfhDFpDgtR9rKh8ePNyLyMEXj
X-Gm-Gg: ASbGncsk0zIG7VkiTaX8EI3AauzIKCFpg4ZwwO8hG+6jqow4aJ5IMS1/JZVs7lyM1sX
	mnQYP+K4Yz1ap3BbzrOVvnOGt/lJ7JjHEpVYTLNfTjO4ZalsyjdCNBGv7qPM66VtBFhqxhb/rhv
	9gt4K4xeDN2OKQSiW50qKlu56cYv+ehXx4JCxTsS/3l4wsx5HxuYc0a55sTC4uDbJiLBFaVtyyM
	f4CenRSqR5kFvZsau0RxbWKjb3scmgDUW8uMkq/HeGwObg7lAy6mJ6gYe2dTZlaClpyQGAW7hiG
	G/ihfa3P2J284/KPx6zJ9xPQBODEracbNKNcIUsKVR53ECDwiO9+ZQN65l7phGpdI68PX2N4mvC
	PezeWxTXC0Dgc7+GYifVWzzVLcWX34/ljTywjpH6R5yybOWDlOe+xJ0iViWf1dtkklqjEVGOtyp
	EjiR/MDTusqHsU
X-Google-Smtp-Source: AGHT+IGNkSh2YNTBNCZYKkHFEF/bFxXLa/Hr93scprqmQWHcNaWt7gCObchY2ggZqpPFvUiQLGZGzA==
X-Received: by 2002:a05:7022:922:b0:11a:4ffb:9825 with SMTP id a92af1059eb24-11b40e7b6admr1908623c88.6.1763159817958;
        Fri, 14 Nov 2025 14:36:57 -0800 (PST)
Received: from [127.0.0.1] ([20.169.73.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885d8sm13902177c88.2.2025.11.14.14.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:36:57 -0800 (PST)
Message-Id: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Nov 2025 22:36:46 +0000
Subject: [PATCH v4 00/10] Xdiff cleanup part2
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

Changes in v4:

 * Update documentation to not mention Unicode except once
 * Don't move dstart/dend with in the xdfile_t struct
 * Rephrase justification on changing xrecord_t.ptr's type

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
	ptrdiff_t dstart, dend;
	bool *changed;
	size_t *reference_index;
	size_t nreff;
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
 .../technical/unambiguous-types.adoc          | 224 ++++++++++++++++++
 xdiff-interface.c                             |   2 +-
 xdiff/xdiffi.c                                |  29 ++-
 xdiff/xemit.c                                 |  28 +--
 xdiff/xhistogram.c                            |   4 +-
 xdiff/xmerge.c                                |  30 +--
 xdiff/xpatience.c                             |  14 +-
 xdiff/xprepare.c                              |  60 ++---
 xdiff/xtypes.h                                |  15 +-
 xdiff/xutils.c                                |  32 +--
 xdiff/xutils.h                                |   6 +-
 13 files changed, 336 insertions(+), 110 deletions(-)
 create mode 100644 Documentation/technical/unambiguous-types.adoc


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2070%2Fezekielnewren%2Fxdiff_cleanup_part2-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2070/ezekielnewren/xdiff_cleanup_part2-v4
Pull-Request: https://github.com/git/git/pull/2070

Range-diff vs v3:

  1:  e5d084d340 !  1:  af732beb69 doc: define unambiguous type mappings across C and Rust
     @@ Metadata
       ## Commit message ##
          doc: define unambiguous type mappings across C and Rust
      
     -    Document other nuances with crossing the FFI boundary. Other language
     +    Document other nuances when crossing the FFI boundary. Other language
          mappings may be added in the future.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
     @@ Documentation/technical/unambiguous-types.adoc (new)
      +
      +This is where C and Rust don't have a clean one-to-one mapping.
      +
     ++A C `char` and a Rust `u8` share the same bit width, so any C struct containing
     ++a `char` will have the same size as the corresponding Rust struct using `u8`.
     ++In that sense, such structs are safe to pass over the FFI boundary, because
     ++their fields will be laid out identically. However, beyond bit width, C `char`
     ++has additional semantics and platform-dependent behavior that can cause
     ++problems, as discussed below.
     ++
      +C comparison problem: While the sign of `char` is implementation defined, it's
      +also signless (neither signed nor unsigned). When building with
      +`make DEVELOPER=1` it will complain about a "differ in signedness" when `char`
      +is compared with `uint8_t` or `int8_t`.
      +
     -+Rust's `char` type is an unsigned 32-bit integer that is used to describe
     -+Unicode code points. Even though a C `char` is the same width as `u8`, `char`
     -+should be converted to u8 where it is describing bytes in memory. If a C
     -+`char` is not describing bytes, then it should be converted to a more accurate
     -+unambiguous type. The reason for mentioning Unicode here is because of how &str
     -+is defined in Rust and how to create a &str from &[u8]. Rust assumes that &str
     -+is a correctly encoded utf-8 string, i.e. text in memory. Where as a C `char`
     -+makes no assumption about the bytes that it is representing.
     -+
     -+```
     -+let raw_bytes = b"abc\n";
     -+let result = std::str::from_utf8(raw_bytes);
     -+if let Ok(line) = result {
     -+    // do something with text
     -+}
     -+```
     -+
     -+While you could specify `char` in the C code and `u8` in Rust code, it's not as
     -+clear what the appropriate type is, but it would work across the FFI boundary.
     -+However, the bigger problem comes from code generation tools like cbindgen and
     -+bindgen. When cbindgen sees u8 in Rust it will generate uint8_t on the C side
     -+which will cause differ in signedness warnings/errors. Similarly if bindgen
     -+sees `char` on the C side it will generate `std::ffi::c_char` which has its own
     -+problems.
     ++Note: Rust's `char` type is an unsigned 32-bit integer that is used to describe
     ++Unicode code points.
      +
      +=== Notes
      +^1^ This is only true if stdbool.h (or equivalent) is used. +
  2:  52e3f589b1 !  2:  b60a03eb31 xdiff: use ptrdiff_t for dstart/dend
     @@ Commit message
          ptrdiff_t is appropriate for dstart and dend because they both describe
          positive or negative offsets relative to a pointer.
      
     -    A future patch will move these fields to a different struct. Moving
     -    them to the end of xdfile_t now, means the field order of xdfile_t will
     -    be disturbed less.
     -
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xtypes.h ##
     @@ xdiff/xtypes.h: typedef struct s_xrecord {
       	xrecord_t *recs;
       	long nrec;
      -	long dstart, dend;
     ++	ptrdiff_t dstart, dend;
       	bool *changed;
       	long *rindex;
       	long nreff;
     -+	ptrdiff_t dstart, dend;
     - } xdfile_t;
     - 
     - typedef struct s_xdfenv {
  3:  83e7bf180a !  3:  042fbb11d0 xdiff: make xrecord_t.ptr a uint8_t instead of char
     @@ Commit message
      
          Make xrecord_t.ptr uint8_t because it's referring to bytes in memory.
      
     -    Every usage of this field was inspected and cast to char*, or similar,
     -    to avoid signedness warnings/errors from the compiler. Casting was used
     -    so that the whole of xdiff doesn't need to be refactored in order to
     -    change the type of this field.
     +    In order to avoid a refactor avalanche, many uses of this field were
     +    cast to char* or similar. One exception is in get_indent() where the
     +    local variable `char c` was changed to `uint8_t c`.
     +
     +    Places where casting was unnecessary:
     +    xemit.c:156
     +    xmerge.c:124
     +    xmerge.c:127
     +    xmerge.c:164
     +    xmerge.c:169
     +    xmerge.c:172
     +    xmerge.c:178
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
  4:  da2b80ea0b =  4:  c103fa6bea xdiff: use size_t for xrecord_t.size
  5:  c6ba630ac5 =  5:  2ee9a74653 xdiff: use unambiguous types in xdl_hash_record()
  6:  3834ea8f9b !  6:  f044274bd5 xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
     @@ Commit message
              field. It comes from the classifier's general-purpose hash table,
              which assigns each line a unique and minimal hash across the two
              files. A size_t is used here because it's meant to be used to
     -        index an array. This also this avoids ` as usize` casts on the Rust
     +        index an array. This also avoids ` as usize` casts on the Rust
              side when using it to index a slice.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
  7:  e2a2c7530c !  7:  f7a3731d94 xdiff: make xdfile_t.nrec a size_t instead of long
     @@ xdiff/xtypes.h: typedef struct s_xrecord {
       	xrecord_t *recs;
      -	long nrec;
      +	size_t nrec;
     + 	ptrdiff_t dstart, dend;
       	bool *changed;
       	long *rindex;
     - 	long nreff;
  8:  31cd2a1aa4 !  8:  93f84ae72e xdiff: make xdfile_t.nreff a size_t instead of long
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
      
       ## xdiff/xtypes.h ##
      @@ xdiff/xtypes.h: typedef struct s_xdfile {
     - 	size_t nrec;
     + 	ptrdiff_t dstart, dend;
       	bool *changed;
       	long *rindex;
      -	long nreff;
      +	size_t nreff;
     - 	ptrdiff_t dstart, dend;
       } xdfile_t;
       
     + typedef struct s_xdfenv {
  9:  aee0d3958b !  9:  39369becc8 xdiff: change rindex from long to size_t in xdfile_t
     @@ Commit message
      
       ## xdiff/xtypes.h ##
      @@ xdiff/xtypes.h: typedef struct s_xdfile {
     - 	xrecord_t *recs;
       	size_t nrec;
     + 	ptrdiff_t dstart, dend;
       	bool *changed;
      -	long *rindex;
      +	size_t *rindex;
       	size_t nreff;
     - 	ptrdiff_t dstart, dend;
       } xdfile_t;
     + 
 10:  75c26fe160 ! 10:  950d1e6193 xdiff: rename rindex -> reference_index
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
      
       ## xdiff/xtypes.h ##
      @@ xdiff/xtypes.h: typedef struct s_xdfile {
     - 	xrecord_t *recs;
       	size_t nrec;
     + 	ptrdiff_t dstart, dend;
       	bool *changed;
      -	size_t *rindex;
      +	size_t *reference_index;
       	size_t nreff;
     - 	ptrdiff_t dstart, dend;
       } xdfile_t;
     + 

-- 
gitgitgadget
