Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B915E5D4
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496546; cv=none; b=fTFZGoGtQF9gI4mlVYO/j/ahnAOqIyrTX3Mj3svJh5JzYT6SHMmzBtkrw5pUiCo1j77/mtEZECxso1E29lUf/0mKLSevSHQEKgt3p4quViBF1lUYKB0U20pZXIYuC8mPW+F28QypxetNV4rLTbLshmJZ/zmBJEvUcKPsBhYq9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496546; c=relaxed/simple;
	bh=H2TTGatqiVLvOr3aB865+9llaiiqfZK9ApmgR4fK+9U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NvHEPeoChpYWCYh6/PxyW29DCF/LqyQGgrVT5dNwZDIhoamrJb4wd8h+JyAkV1xw7NBE/5wHT99+5J3M2zWb9ayZByeMeS39yMKhIQJ7uM8D68iBxd9+rxe4V1aN+Pq+KEL4exLtNXlukAl/To2PhG7oAPZRb6+6NJFU2J/69s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzYNwN9f; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzYNwN9f"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326793a85so2051195a91.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496543; x=1757101343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLxpqd4/BKWjp3+SBEHwAf2MU2ceBlUrbn/NUK7ZdRg=;
        b=TzYNwN9fnbrso/v/hQHZ+U+RggTjSq9/Ni+aQQGaOL0afElw8RFeyJy4xmp0mDNaHt
         aTZ2HAv/41cw26PM5GBaZ37PMOSKbOlaVpz2BVRJXv+QuC52NuMLpI1G+oaVjfj5ulYQ
         Y860dDwAy3xQq1GlPpAL2Nf0RobD90dRE5qnfGPN7RNcMKsk0hEZF5aSMPyLpfQzWOb5
         llgc8krG7IOOsMfMwTCFnSah90a0c/gfqdx5XnVZUvPzxU2RoP2fRWfHHw8qCXgftSL5
         bqWsQyVncI/AdTTOAFV4bu1l5tY/Km6ZINBbmq8Olf1VubSJfHzozLH+DV9lRwdTu1iE
         i4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496543; x=1757101343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLxpqd4/BKWjp3+SBEHwAf2MU2ceBlUrbn/NUK7ZdRg=;
        b=efY1xOZf2TuifQF7SNq31DVJPOxuxcTOU7G/duH/e4yW/kJKvgjOTSgc+l5I/yPrio
         oPbGrdblHfbra9O+gkSOGYuZ2iZoEiRz9F9jxQdvMsEoy3NzaLYGk+t99uF0z1JArqSf
         WE3RQccm96rFF4n502usjRo44Nunmb7b2Dp7g1SWkEiRoubnS/hkklNjcFpafxf1pf1F
         diIgMmaI6MzeTw/LTAHX5ZKjbN+mcFN03EQzKzW9jJW4tWixPonWi1M09j3a3n8T3KrV
         LfJs6+QFcKTxE8R+U9Hg4gWs7jtGM+EQfQabi8wiNpTMAaeQ0U8KsOQlGulzyN+apWCR
         zsYQ==
X-Gm-Message-State: AOJu0YxMYB3GIz3kJJEVg4Y+nBMlnxFHYbxcyaZnqqQMAb67h6B+oQTr
	DUKO/I1D7jVYBV5UOwNGG7EOUI0IDn5J8oZwDJomkgFkueOtMxA7ExJgYUw0xw==
X-Gm-Gg: ASbGncuAdGsxMj8Zw1RzGwzmU/zt3XKyrJ/vFa02y8n/+2VsRshy10Tw0K40gtBrjhY
	sg9rjkKgnFjT6ufRz7KFgAhm4icpwIc5CXOrKmds0w5hf17XhCH/r1EUlJLqEPRGcQ75Q0enFBl
	6tqXzrao5wwPIEqKLhf9N08Z97Ma89P+StdGW0kEMu/AjRDrsqfUdW1FyNLmPj9J7PZVR5smZUL
	JgaZeRLEqWlfYgv4aKEdEOwe8KMPrI1X1VSkOmQX8dwFHp15OCAXWyHghIsFjkJL87sOvfiuBcd
	i6Q0IHLXDVJXxyI3ISPLposVHTf0CT1C9ayhyJFP1nkIn/bmWKqaan+Kdmft7+qtdsfcPgeALKB
	/VlzaSsjezKZ5PlQw5A9zNBhtrnY9Y9T/LiC1zg==
X-Google-Smtp-Source: AGHT+IF+UK9aKmy/ruUE3ZpXFsNRsDUUPlDcAqMKLMjoW9TF7w5CFGNy2vvrWv3ssQxj3hZrKb77hg==
X-Received: by 2002:a17:90a:da86:b0:31e:3f7f:d4b1 with SMTP id 98e67ed59e1d1-32515eaedcdmr39943764a91.24.1756496542804;
        Fri, 29 Aug 2025 12:42:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1b21sm3181617b3a.69.2025.08.29.12.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:22 -0700 (PDT)
Message-Id: <6d065f550fe871cf010409f7bd2a63438cf52723.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:05 +0000
Subject: [PATCH 01/15] doc: add a policy for using Rust
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Git has historically been written primarily in C, with some shell and
Perl.  However, C is not memory safe, which makes it more likely that
security vulnerabilities or other bugs will be introduced, and it is
also more verbose and less ergonomic than other, more modern languages.

One of the most common modern compiled languages which is easily
interoperable with C is Rust.  It is popular (the most admired language
on the 2024 Stack Overflow Developer Survey), efficient, portable, and
robust.

Introduce a document laying out the incremental introduction of Rust to
Git and provide a detailed rationale for doing so, including the points
above.  Propose a design for this approach that addresses the needs of
downstreams and distributors, as well as contributors.

Since we don't want to carry both a C and Rust version of code and want
to be able to add new features only in Rust, mention that Rust is a
required part of our platform support policy.

It should be noted that a recent discussion at the Berlin Git Merge
Contributor Summit found widespread support for the addition of Rust to
Git.  While of course not all contributors were represented, the
proposal appeared to have the support of a majority of active
contributors.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
[en: Added some comments about types, and changed the recommondations
     about cbindgen, bindgen, rustix, libc.]
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/platform-support.adoc |   2 +
 Documentation/technical/rust-support.adoc     | 142 ++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 Documentation/technical/rust-support.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b109d25e9c..066b761c01 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -127,6 +127,7 @@ TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/platform-support
 TECH_DOCS += technical/racy-git
+TECH_DOCS += technical/rust-support
 TECH_DOCS += technical/reftable
 TECH_DOCS += technical/scalar
 TECH_DOCS += technical/send-pack-pipeline
diff --git a/Documentation/technical/platform-support.adoc b/Documentation/technical/platform-support.adoc
index 0a2fb28d62..dc71672dcb 100644
--- a/Documentation/technical/platform-support.adoc
+++ b/Documentation/technical/platform-support.adoc
@@ -33,6 +33,8 @@ meet the following minimum requirements:
 
 * Has active security support (taking security releases of dependencies, etc)
 
+* Supports Rust and the toolchain version specified in link:rust-support.adoc[].
+
 These requirements are a starting point, and not sufficient on their own for the
 Git community to be enthusiastic about supporting your platform. Maintainers of
 platforms which do meet these requirements can follow the steps below to make it
diff --git a/Documentation/technical/rust-support.adoc b/Documentation/technical/rust-support.adoc
new file mode 100644
index 0000000000..57a001fa2d
--- /dev/null
+++ b/Documentation/technical/rust-support.adoc
@@ -0,0 +1,142 @@
+Usage of Rust in Git
+====================
+
+Objective
+---------
+Introduce Rust into Git incrementally to improve security and maintainability.
+
+Background
+----------
+Git has historically been written primarily in C, with some portions in shell,
+Perl, or other languages.  At the time it was originally written, this was
+important for portability and was a logical choice for software development.
+
+:0: link:https://security.googleblog.com/2024/09/eliminating-memory-safety-vulnerabilities-Android.html
+:1: link:https://www.cisa.gov/resources-tools/resources/product-security-bad-practices
+
+However, as time has progressed, we've seen an increased concern with memory
+safety vulnerabilities and the development of newer languages, such as Rust,
+that substantially limit or eliminate this class of vulnerabilities.
+Development in a variety of projects has found that memory safety
+vulnerabilities constitute about 70% of vulnerabilities of software in
+languages that are not memory safe.  For instance, {0}[one survey of Android]
+found that memory safety vulnerabilities decreased from 76% to 24% over six
+years due to an increase in memory safe code.  Similarly, the U.S. government
+is {1}[proposing to classify development in memory unsafe languages as a
+Product Security Bad Practice"].
+
+These risks are even more substantial when we consider the fact that Git is a
+network-facing service.  Many organizations run Git servers internally or use a
+cloud-based forge, and the risk of accidental exposure or compromise of user
+data is substantial.  It's important to ensure that Git, whether it's used
+locally or remotely, is robustly secure.
+
+In addition, C is a difficult language to write well and concisely.  While it
+is of course possible to do anything with C, it lacks built-in support for
+niceties found in modern languages, such as hash tables, generics, typed
+errors, and automatic destruction, and most modern language offer shorter, more
+ergonomic syntax for expressing code.  This is valuable functionality that can
+allow Git to be developed more rapidly, more easily, by more developers of a
+variety of levels, and with more confidence in the correctness of the code.
+
+For these reasons, adding Rust to Git is a sensible and prudent move that will
+allow us to improve the quality of the code and potentially attract new developers.
+
+Goals
+-----
+1. Git continues to build, run, and pass tests on a wide variety of operating
+   systems and architectures.
+2. Transition from C to Rust is incremental; that is, code can be ported as it
+   is convenient and Git does not need to transition all at once.
+3. Git continues to support older operating systems in conformance with the
+   platform support policy.
+
+Non-Goals
+---------
+1. Support for every possible operating system and architecture.  Git already
+   has a platform support policy which defines what is supported and we already
+   exclude some operating systems for various reasons (e.g., lacking enough POSIX
+   tools to pass the test suite).
+2. Implementing C-only versions of Rust code or compiling a C-only Git.  This
+   would be difficult to maintain and would not offer the ergonomic benefits we
+   desire.
+
+Design
+------
+Git will adopt Rust incrementally.  This transition will start with the
+creation of a static library that can be linked into the existing Git binaries.
+At some point, we may wish to expose a dynamic library and compile the Git
+binaries themselves using Rust.  Using an incremental approach allows us to
+determine as we go along how to structure our code in the best way for the
+project and avoids the need to make hard, potentially disruptive, transitions
+caused by porting a binary wholesale from one language to another that might
+introduce bugs.
+
+Crates like libc or rustix define types like c_long, but in ways that are not
+safe across platforms.
+From https://docs.rs/rustix/latest/rustix/ffi/type.c_long.html:
+
+    This type will always be i32 or i64.  Most notably, many Linux-based
+    systems assume an i64, but Windows assumes i32.  The C standard technically
+    only requires that this type be a signed integer that is at least 32 bits
+    and at least the size of an int, although in practice, no system would
+    have a long that is neither an i32 nor i64.
+
+Also, note that other locations, such as
+https://docs.rs/libc/latest/libc/type.c_long.html, just hardcode c_long as i64
+even though C may mean i32 on some platforms.
+
+As such, using the c_long type would give us portability issues, and
+perpetuate some of the bugs git has faced across platforms.  Avoid using C's
+types (long, unsigned, char, etc.), and switch to unambiguous types (e.g. i32
+or i64) before trying to make C and Rust interoperate.
+
+Crates like libc and rustix may have also traditionally aided interoperability
+with older versions of Rust (e.g.  when worrying about stat[64] system calls),
+but the Rust standard library in newer versions of Rust handle these concerns
+in a platform agnostic way.  There may arise cases where we need to consider
+these crates, but for now we omit them.
+
+Tools like bindgen and cbindgen create C-styled unsafe Rust code rather than
+idiomatic Rust; where possible, we prefer to switch to idiomatic Rust.  Any
+standard C library functions that are needed can be manually wrapped on the
+Rust side.
+
+Rust upstream releases every six weeks and only supports the latest stable
+release.  While it is nice that upstream is active, we would like our software
+releases to have a lifespan exceeding six weeks.  To allow compiling our code
+on a variety of systems, we will support the version of Rust in Debian stable,
+plus, for a year after a new Debian stable is released, the version in Debian
+oldstable.
+
+This provides an approximately three-year lifespan of support for a Rust
+release and allows us to support a variety of operating systems and
+architectures, including those for which Rust upstream does not build binaries.
+Debian stable is the benchmark distribution used by many Rust projects when
+determining supported Rust versions, and it is an extremely portable and
+popular free software operating system that is available to the public at no
+charge, which makes it a sensible choice for us as well.
+
+We may change this policy if the Rust project issues long-term support releases
+or the Rust community and distributors agree on releases to target as if they
+were long-term support releases.
+
+This version support policy necessitates that we be very careful about the
+dependencies we include, since many Rust projects support only the latest
+stable version.  However, we typically have been careful about dependencies in
+the first place, so this should not be a major departure from existing policy,
+although it may be a change for some existing Rust developers.
+
+We will avoid including the `Cargo.lock` file in the repository and instead
+specify minimum dependency versions in the `Cargo.toml` file.  We want to allow
+people to use newer versions of dependencies if necessary to support newer
+platforms without needing to force upgrades of dependencies on all users, and
+it provides additional flexibility for distribution maintainers.
+
+We do not plan to support beta or nightly versions of the Rust compiler.  These
+versions may change rapidly and especially parts of the toolchain such as
+Clippy, the lint tool, can have false positives or add additional warnings with
+too great of a frequency to be supportable by the project.  However, we do plan
+to support alternate compilers, such as the rust_codegen_gcc backend and gccrs
+when they are stable and support our desired release versions.  This will
+provide greater support for more operating systems and architectures.
-- 
gitgitgadget

