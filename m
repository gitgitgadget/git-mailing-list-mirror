Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2022128A
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071809; cv=none; b=IB/EqrxzH8xmX5h4gpjvXMTaSIEUTwu/yLoW3/it76G/yDn2LCgqJqCdkoebK+ouf+6wrMk8Ft8Erp/btlnZu/Y2KIa0O8B5oBRulX0fuVOzYDl9ZWXnzhVprxhIx0AAwqoD7DwCbXHbDa8RrhCUlm3ileQyLIwlIiYj4sqvGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071809; c=relaxed/simple;
	bh=FNnkULqFCGfFtMyvmbSM16B2TVFQHd9SPmVdjr+UlFY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G+f61SoEQbIW7Jx2cqrByK62QcGj4S6VisNaUFJkhRxkPohAIN3tESJP7xLtWiryiAFcyxRlOGU0mrDBnPgHrYpbDsGkXIh2BJgLP5cVHsQvhYe6R/rI8cLYM//A2N0ycHyvZspsPM/vbaUKl/lmry52gL1QKFb4j9CQ8i7aJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzdtFMTH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzdtFMTH"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7761b83fd01so4422406b3a.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071806; x=1758676606; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qU0hFUTw+1MKskcFpNw8jnnz5QYltUUL6ALHcxFnB4=;
        b=HzdtFMTH7n/rnZLliCsLQSGP2Yieqv+NSwSm7QyxMW8EsYREnpWzv9Cy5ESa6Vfkqq
         FMEZk2QT5KrcTQ0HFFrQcn6SXCCiwzvdzYeox2q/ppjHJf4sVj3FjZZ2TZK+n2TjmSoa
         DeJX3c9b9SG16waq6obXOVAg4nUtmapdRCH8zKhBchXXWPWtLnIuz9gHN+gpiXG/Q0dq
         7AcGdyEPGu1rvNgzcrSU2HqlckZehGHVlyVDgfhgFT09JNGgx5RBBgBrPe6Nl3Tp7TzC
         koD/evVgmaIe1dejcFoI9BU3PhjpDU8RPQ2IH+334QiJ181wY6/59gbtKbceX2Ezsqn8
         w5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071806; x=1758676606;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qU0hFUTw+1MKskcFpNw8jnnz5QYltUUL6ALHcxFnB4=;
        b=D/QjulDf1W2xAai2v5VifTtWn9rYfCIEZzo40f50SmJRy4vsEx3DfIsDu46ySUh2RQ
         hV65m01E884/1k8xX3HKS6gx4KsgQcsBz/9h8kVlc2uEXIJSVXEja1f+ucu+tw58fQfs
         wSpL/9RDNFZd1Fu+tfCuc0LocNtCG/u5LvyDAcQakGflEmtCwvwADBZQHFPoX5U9BVzm
         a6Xm2/bDcdC/K/Ti15jqJdY0LfhX6RF0hO8oYPNBC7iPSS0DXpdsEuQNTIEurJBPXJo3
         RalQ6uKK4W8ksj0ZbpzsZkgOdxM125B0lR44OtwUE/fB3O2PzRuOx0Zd4P3OGs1vNCM5
         Xvhw==
X-Gm-Message-State: AOJu0YzKwR0Sm9NvfEYLYwTVF/+hDVjYuCkgZBq0zUpHUmO3/WpQnfir
	gg+eFB0NGUGN8XQeIpnfMBXUVj3pSlUkHRmRlwyGKaAbjcKgFJOwtS5ragwZQA==
X-Gm-Gg: ASbGncu6Yg207J5pq5esjWzpS8dx8HL+QsEBJmlYcCREgaeYw11qr8A56CBsu1BWFi4
	tuDNzBe7flTjggASupGfN+MgzYL+9QDvANjEsBoYgw7mEohh6DqQY6LtIQfH1f2Bdf8emki1GnW
	6qod8PKQ4teXQT73C9x/PXtCoTAB2DB04audQlyIStXVbPBhVe/zga1/oyqJQTwRtvB9IT4ryi9
	yPgvEaJCcoJhtuZjxQf2PzX2rnMJzsq37PtzpgtzdK2TjI2q0FREYu3O7R+lSuAtRpI1q2Cmhd7
	P1WW3NdmuAnZXwwAtAkbNOH7nQvpnmhp7rve6Q6DiEt4/Tg6f4lOHR0ArM+NlzKZUkyB23YpjKh
	NH7A+WQODZvolsUV5GnNkzhKFUD0=
X-Google-Smtp-Source: AGHT+IEZVGglz97KE2HfT2BUZyiomvm2qeLe8MtOIjbSEbzb46zieDVVPO5w2UTBUfftJlZc+klFOA==
X-Received: by 2002:a05:6a00:14c1:b0:771:ecf2:53ba with SMTP id d2e1a72fcca58-77bf74c438dmr347143b3a.7.1758071805996;
        Tue, 16 Sep 2025 18:16:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a6a2ccsm17035729b3a.45.2025.09.16.18.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:45 -0700 (PDT)
Message-Id: <0fc89c3ec300008c27e877006d7236b39bb95868.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:25 +0000
Subject: [PATCH v2 05/18] doc: add a policy for using Rust
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
index df2ce187eb..5e7821db3c 100644
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
index 0000000000..5b856bdee6
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
+idiomatic Rust; where possible, we prefer to switch to idiomatic Rust.
+However, we may use bindgen and cbindgen to share existing Git types as an
+interim step.
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

