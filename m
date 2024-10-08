Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83021643A
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429581; cv=none; b=LHKsn3yjsTvepxwablIIjFQqM1QxKb98iQao/eTTQU8NazaarjpaY/6ze+H36P3FrzIzSi5M7RliI+QmfZNftMt8wNZqCo6fv0qw9PqNQSrKkNA1eLLyHdZ5sI2DCfK5/fjnqMiGfQ5nQfSGG/ATtEjKGb4haze6mxIVE5dVsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429581; c=relaxed/simple;
	bh=VA0uK4xDVkfgJtYJnjZ3OVrfvuOUT6MhQQDJY+0DE4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYwOSA7KfAuIESwCwSD9e79V7OA258Vk027KSFLbTFZF246ccdJ+3tWfE5BhU/a5L8UQ9zeN8JM3UTIx+eyhSY1J47LiG21ndGjwuBwqCdlQDznHLGlbgkPex2124yAmzYP9rCSwUqFtqPl2NJG41rQDBMNVv4Ey9hrR2QmEFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlNQhOck; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlNQhOck"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc8902e6so614882276.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728429578; x=1729034378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=upMPegXg3KG47Pb7IkmNvUobUaFBNKGbpFM2y+u8a0M=;
        b=hlNQhOck428eTmqh+rEvX+CKyVV4QVZN71SVaxRR/Jfp8uGOKW6gaj35MVPU2AnFdV
         j5mbZcPvilfJbdqf379CAcO+waO12B/bimoyPD2Pk4ijOpOJgC4Bp/dSeTfBPLm81o9H
         nWd0d7iw8SjaEmz7n/PxmUGzbL7HiG46hEWJRoqDqqFnzbgZloESKH6seAhhye/hbiR2
         j3mlotFmCbX4tmG7QUVQvboJiTO4fFHW7tf/8eU4L5gRoeuECksJIVR1rtgsGg0tMgBl
         gSO53IAHdIaZEgIxRjp+scPfE72HZJFt/HlwtyjUHhrn/k9zBXob5TEg5T99WoiNajVZ
         8WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429578; x=1729034378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upMPegXg3KG47Pb7IkmNvUobUaFBNKGbpFM2y+u8a0M=;
        b=d9xv7JHdI5RY4NHTnZlixi0ehiLQYrDKa5IytMvDpmreZ8ZhZFPeKKWELWll/SkMvu
         QiLQGeB0Twr3qmw3mL3yoabUyhD9a3yu4alNue5eT8hLq+3X/bsefvM+bgJjT/WxIHZ/
         pNAgqGl9lJRauR9J1HOBT9HClj3RKuDjtZ9SpW3wh3tyiG9t4wfsOPJPMdP0mfanZTre
         B0VIlVPLbUEv2+b5Lu4gSTImYedX7RHu+AAAagBL3M/afCi0HGCs1XUMeCVjZhuezrfA
         wvD8PXHeEzcIGHZGO1fLiLDxQCC/eiTkdZ7cLpd5rSxIvQsV5Gg3252XkCEogitLKLNV
         V5/A==
X-Gm-Message-State: AOJu0YyEWQnZvSg7JE92g1dAsNAhq+2JXclanjZ2L/+TXiLfJJAtSrQn
	DON0ziehJqw20iXI56nXOmp6y9sT1o5wiorI7lgwgKJ30VlBNLePINthEg0OQYL0sYGbmuliYc8
	4iqdYEfBQWEyyyGW60f6yjYGPupB4UqaVXCYx+JKFHBI6vip63+5S2LwV3dPWy9LhQj6ruE+1nm
	YzP1y6KZ4RDCnut77h6PH99UkYfKPttu4d0WBgrG0=
X-Google-Smtp-Source: AGHT+IFhwpUjwSfuvkUJ4DJDk/ubWMG6SD1pcCRlV0RXih43aZJqN/hyXUIKJ1Ds1672MqoBDW2KfpwZ218PlQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:7c00:8752:4498:cc1b])
 (user=steadmon job=sendgmr) by 2002:a25:ce93:0:b0:e24:a393:bb8e with SMTP id
 3f1490d57ef6-e28fe3fb160mr10596276.7.1728429577294; Tue, 08 Oct 2024 16:19:37
 -0700 (PDT)
Date: Tue,  8 Oct 2024 16:19:30 -0700
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <cover.1728429158.git.steadmon@google.com>
Subject: [PATCH v4 0/5] Introduce libgit-rs, a Rust wrapper around libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, ps@pks.im, sunshine@sunshineco.com, 
	phillip.wood123@gmail.com, allred.sean@gmail.com
Content-Type: text/plain; charset="UTF-8"

This series provides two small Rust wrapper libraries around parts of
Git: "libgit-sys", which exposes a few functions from libgit.a, and
"libgit", which provides a more Rust-friendly interface to some of those
functions. In addition to included unit tests, at $DAYJOB we have tested
building JJ[1] with our library and used it to replace some of the
libgit2-rs uses.

[1] https://github.com/martinvonz/jj

Please find V1 cover letter here:
https://lore.kernel.org/git/cover.1723054623.git.steadmon@google.com/

Changes in V4:
* Drop V3 patch #3, which added wrappers around repository
  initialization and config access. These are not well-libified, and
  they are not necessary for JJ's proof-of-concept use case, so let's
  avoid exporting them for now.

* Set a minimum supported Rust version of 1.63. Autodetect whether our
  Rust version has c_int and c_char types; if not, define them
  ourselves.

* When building libgitpub.a via build.rs, set DEVELOPER=1 to catch
  additional errors at build time.

* In build.rs, use the make_cmd crate to portable select the correct
  invocation of GNU Make.

* Follow naming standards for _alloc() and _free() functions.

* Use String instead of CString in higher-level API.

* Move libgit_configset_alloc() and libgit_configset_free() out of
  upstream Git, to the libgitpub shim library.

* In libgitpub, initialize libgit_config_set structs in the _alloc()
  function rather than with a separate _init() function.

* Remove unnecessary comments in libgit-sys showing where the wrapped
  functions were originally defined.

* Fix clippy lint: don't reborrow configfile path references.

* Various typo fixes and `cargo fmt` fixes.

Changes in V3:
* Renamed cgit-rs to libgit-rs and cgit-sys to libgit-sys

* Makefile cleanup, particularly adding config.mak options that
  developers can set to run Rust builds and tests by default (Patch 6)

* Provide testdata configs for unit tests

* ConfigSet API now uses &Path instead of &str -- more ergonomic for
  Rust users to pass in and errors out if the path string isn't UTF-8

* Fixed unresolved dependency on libz in Cargo.toml

Known NEEDSWORK:

* Investigate alternative methods of managing symbol visibility &
  renaming.

* Figure out symbol versioning


Calvin Wan (2):
  libgit: add higher-level libgit crate
  Makefile: add option to build and test libgit-rs and libgit-rs-sys

Josh Steadmon (3):
  common-main: split init and exit code into new files
  libgit-sys: introduce Rust wrapper for libgit.a
  libgit-sys: also export some config_set functions

 .gitignore                                    |  2 +
 Makefile                                      | 31 ++++++
 common-exit.c                                 | 26 +++++
 common-init.c                                 | 63 ++++++++++++
 common-init.h                                 |  6 ++
 common-main.c                                 | 83 +---------------
 contrib/libgit-rs/Cargo.lock                  | 77 +++++++++++++++
 contrib/libgit-rs/Cargo.toml                  | 15 +++
 contrib/libgit-rs/build.rs                    |  4 +
 contrib/libgit-rs/libgit-sys/Cargo.lock       | 69 ++++++++++++++
 contrib/libgit-rs/libgit-sys/Cargo.toml       | 17 ++++
 contrib/libgit-rs/libgit-sys/README.md        | 15 +++
 contrib/libgit-rs/libgit-sys/build.rs         | 35 +++++++
 .../libgit-sys/public_symbol_export.c         | 50 ++++++++++
 .../libgit-sys/public_symbol_export.h         | 18 ++++
 contrib/libgit-rs/libgit-sys/src/lib.rs       | 79 +++++++++++++++
 contrib/libgit-rs/src/lib.rs                  | 95 +++++++++++++++++++
 contrib/libgit-rs/testdata/config1            |  2 +
 contrib/libgit-rs/testdata/config2            |  2 +
 contrib/libgit-rs/testdata/config3            |  2 +
 t/Makefile                                    | 16 ++++
 21 files changed, 626 insertions(+), 81 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 common-init.c
 create mode 100644 common-init.h
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
 create mode 100644 contrib/libgit-rs/build.rs
 create mode 100644 contrib/libgit-rs/libgit-sys/Cargo.lock
 create mode 100644 contrib/libgit-rs/libgit-sys/Cargo.toml
 create mode 100644 contrib/libgit-rs/libgit-sys/README.md
 create mode 100644 contrib/libgit-rs/libgit-sys/build.rs
 create mode 100644 contrib/libgit-rs/libgit-sys/public_symbol_export.c
 create mode 100644 contrib/libgit-rs/libgit-sys/public_symbol_export.h
 create mode 100644 contrib/libgit-rs/libgit-sys/src/lib.rs
 create mode 100644 contrib/libgit-rs/src/lib.rs
 create mode 100644 contrib/libgit-rs/testdata/config1
 create mode 100644 contrib/libgit-rs/testdata/config2
 create mode 100644 contrib/libgit-rs/testdata/config3

Range-diff against v3:
1:  83afd7f4a2 ! 1:  1ae14207f6 common-main: split init and exit code into new files
    @@ Commit message
         [2] https://lore.kernel.org/git/20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com/
     
    -    Signed-off-by: Calvin Wan <calvinwan@google.com>
    +    Signed-off-by: Josh Steadmon <steadmon@google.com>
     
      ## Makefile ##
     @@ Makefile: LIB_OBJS += combine-diff.o
2:  354b498494 ! 2:  ed925d6a33 libgit-sys: introduce Rust wrapper for libgit.a
    @@ Commit message
         Co-authored-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Kyle Lippincott <spectral@google.com>
    +    Signed-off-by: Josh Steadmon <steadmon@google.com>
     
      ## .gitignore ##
    @@ contrib/libgit-rs/libgit-sys/Cargo.lock (new)
     +version = 3
     +
     +[[package]]
    ++name = "autocfg"
    ++version = "1.4.0"
    ++source = "registry+https://github.com/rust-lang/crates.io-index"
    ++checksum = "ace50bade8e6234aa140d9a2f552bbee1db4d353f69b8217bc503490fc1a9f26"
    ++
    ++[[package]]
     +name = "cc"
     +version = "1.1.15"
     +source = "registry+https://github.com/rust-lang/crates.io-index"
    @@ contrib/libgit-rs/libgit-sys/Cargo.lock (new)
     +name = "libgit-sys"
     +version = "0.1.0"
     +dependencies = [
    ++ "autocfg",
     + "libz-sys",
    ++ "make-cmd",
     +]
     +
     +[[package]]
    @@ contrib/libgit-rs/libgit-sys/Cargo.lock (new)
     +]
     +
     +[[package]]
    ++name = "make-cmd"
    ++version = "0.1.0"
    ++source = "registry+https://github.com/rust-lang/crates.io-index"
    ++checksum = "a8ca8afbe8af1785e09636acb5a41e08a765f5f0340568716c18a8700ba3c0d3"
    ++
    ++[[package]]
     +name = "pkg-config"
     +version = "0.3.30"
     +source = "registry+https://github.com/rust-lang/crates.io-index"
    @@ contrib/libgit-rs/libgit-sys/Cargo.toml (new)
     +edition = "2021"
     +build = "build.rs"
     +links = "gitpub"
    ++rust-version = "1.63"
     +
     +[lib]
     +path = "src/lib.rs"
     +
     +[dependencies]
     +libz-sys = "1.1.19"
    - \ No newline at end of file
    ++
    ++[build-dependencies]
    ++autocfg = "1.4.0"
    ++make-cmd = "0.1.0"
     
      ## contrib/libgit-rs/libgit-sys/README.md (new) ##
     @@
    @@ contrib/libgit-rs/libgit-sys/build.rs (new)
     +use std::path::PathBuf;
     +
     +pub fn main() -> std::io::Result<()> {
    ++    let ac = autocfg::new();
    ++    ac.emit_has_path("std::ffi::c_char");
    ++
     +    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
     +    let git_root = crate_root.join("../../..");
     +    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
     +
    -+    let make_output = std::process::Command::new("make")
    ++    let make_output = make_cmd::gnu_make()
    ++        .env("DEVELOPER", "1")
     +        .env_remove("PROFILE")
     +        .current_dir(git_root.clone())
     +        .args([
    @@ contrib/libgit-rs/libgit-sys/build.rs (new)
     +        );
     +    }
     +    std::fs::copy(crate_root.join("libgitpub.a"), dst.join("libgitpub.a"))?;
    -+    println!("cargo::rustc-link-search=native={}", dst.display());
    -+    println!("cargo::rustc-link-lib=gitpub");
    -+    println!("cargo::rerun-if-changed={}", git_root.display());
    ++    println!("cargo:rustc-link-search=native={}", dst.display());
    ++    println!("cargo:rustc-link-lib=gitpub");
    ++    println!("cargo:rerun-if-changed={}", git_root.display());
     +
     +    Ok(())
     +}
    @@ contrib/libgit-rs/libgit-sys/public_symbol_export.c (new)
     @@
     +// Shim to publicly export Git symbols. These must be renamed so that the
     +// original symbols can be hidden. Renaming these with a "libgit_" prefix also
    -+// avoid conflicts with other libraries such as libgit2.
    ++// avoids conflicts with other libraries such as libgit2.
     +
    ++#include "git-compat-util.h"
     +#include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
     +#include "version.h"
     +
    @@ contrib/libgit-rs/libgit-sys/public_symbol_export.h (new)
     
      ## contrib/libgit-rs/libgit-sys/src/lib.rs (new) ##
     @@
    ++#[cfg(has_std__ffi__c_char)]
     +use std::ffi::c_char;
     +
    ++#[cfg(not(has_std__ffi__c_char))]
    ++#[allow(non_camel_case_types)]
    ++pub type c_char = i8;
    ++
     +extern crate libz_sys;
     +
     +extern "C" {
    -+    // From version.c
     +    pub fn libgit_user_agent() -> *const c_char;
     +    pub fn libgit_user_agent_sanitized() -> *const c_char;
     +}
3:  2ebff081f8 < -:  ---------- libgit-sys: add repo initialization and config access
4:  6b4b7e6ced ! 3:  8eeab7b418 config: add git_configset_alloc() and git_configset_clear_and_free()
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    config: add git_configset_alloc() and git_configset_clear_and_free()
    +    libgit-sys: also export some config_set functions
     
    -    Add git_configset_alloc() and git_configset_clear_and_free() functions
    -    so that callers can manage config_set structs on the heap. This also
    -    allows non-C external consumers to treat config_sets as opaque structs.
    +    In preparation for implementing a higher-level Rust API for accessing
    +    Git configs, export some of the upstream configset API via libgitpub and
    +    libgit-sys. Since this will be exercised as part of the higher-level API
    +    in the next commit, no tests have been added for libgit-sys.
    +
    +    While we're at it, add git_configset_alloc() and git_configset_free()
    +    functions in libgitpub so that callers can manage config_set structs on
    +    the heap. This also allows non-C external consumers to treat config_sets
    +    as opaque structs.
     
         Co-authored-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    +    Signed-off-by: Josh Steadmon <steadmon@google.com>
     
    - ## config.c ##
    -@@ config.c: static int config_set_element_cmp(const void *cmp_data UNUSED,
    - 	return strcmp(e1->key, e2->key);
    - }
    + ## contrib/libgit-rs/libgit-sys/public_symbol_export.c ##
    +@@
    + // avoids conflicts with other libraries such as libgit2.
    + 
    + #include "git-compat-util.h"
    ++#include "config.h"
    + #include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
    + #include "version.h"
      
    -+struct config_set *git_configset_alloc(void)
    + #pragma GCC visibility push(default)
    + 
    ++struct libgit_config_set *libgit_configset_alloc(void)
     +{
    -+	return xmalloc(sizeof(struct config_set));
    ++	struct config_set *cs = xmalloc(sizeof(struct config_set));
    ++	git_configset_init(cs);
    ++	return (struct libgit_config_set *) cs;
     +}
     +
    - void git_configset_init(struct config_set *set)
    - {
    - 	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
    -@@ config.c: void git_configset_clear(struct config_set *set)
    - 	set->list.items = NULL;
    - }
    - 
    -+void git_configset_clear_and_free(struct config_set *set)
    ++void libgit_configset_free(struct libgit_config_set *cs)
    ++{
    ++	git_configset_clear((struct config_set *) cs);
    ++	free((struct config_set *) cs);
    ++}
    ++
    ++int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
     +{
    -+	git_configset_clear(set);
    -+	free(set);
    ++	return git_configset_add_file((struct config_set *) cs, filename);
     +}
     +
    - static int config_set_callback(const char *key, const char *value,
    - 			       const struct config_context *ctx,
    - 			       void *cb)
    ++int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)
    ++{
    ++	return git_configset_get_int((struct config_set *) cs, key, dest);
    ++}
    ++
    ++int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
    ++{
    ++	return git_configset_get_string((struct config_set *) cs, key, dest);
    ++}
    ++
    + const char *libgit_user_agent(void)
    + {
    + 	return git_user_agent();
    +
    + ## contrib/libgit-rs/libgit-sys/public_symbol_export.h ##
    +@@
    + #ifndef PUBLIC_SYMBOL_EXPORT_H
    + #define PUBLIC_SYMBOL_EXPORT_H
    + 
    ++struct libgit_config_set *libgit_configset_alloc(void);
    ++
    ++void libgit_configset_free(struct libgit_config_set *cs);
    ++
    ++int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename);
    ++
    ++int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest);
    ++
    ++int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest);
    ++
    + const char *libgit_user_agent(void);
    + 
    + const char *libgit_user_agent_sanitized(void);
     
    - ## config.h ##
    -@@ config.h: struct config_set {
    - 	struct configset_list list;
    - };
    + ## contrib/libgit-rs/libgit-sys/src/lib.rs ##
    +@@
    + #[cfg(has_std__ffi__c_char)]
    +-use std::ffi::c_char;
    ++use std::ffi::{c_char, c_int};
    + 
    + #[cfg(not(has_std__ffi__c_char))]
    + #[allow(non_camel_case_types)]
    + pub type c_char = i8;
    + 
    ++#[cfg(not(has_std__ffi__c_char))]
    ++#[allow(non_camel_case_types)]
    ++pub type c_int = i32;
    ++
    + extern crate libz_sys;
      
    -+/**
    -+ * Alloc a config_set
    -+ */
    -+struct config_set *git_configset_alloc(void);
    -+
    - /**
    -  * Initializes the config_set `cs`.
    -  */
    -@@ config.h: int git_configset_get_string_multi(struct config_set *cs, const char *key,
    -  */
    - void git_configset_clear(struct config_set *cs);
    ++#[allow(non_camel_case_types)]
    ++#[repr(C)]
    ++pub struct libgit_config_set {
    ++    _data: [u8; 0],
    ++    _marker: core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
    ++}
    ++
    + extern "C" {
    +     pub fn libgit_user_agent() -> *const c_char;
    +     pub fn libgit_user_agent_sanitized() -> *const c_char;
    ++
    ++    pub fn libgit_configset_alloc() -> *mut libgit_config_set;
    ++    pub fn libgit_configset_free(cs: *mut libgit_config_set);
    ++
    ++    pub fn libgit_configset_add_file(cs: *mut libgit_config_set, filename: *const c_char) -> c_int;
    ++
    ++    pub fn libgit_configset_get_int(
    ++        cs: *mut libgit_config_set,
    ++        key: *const c_char,
    ++        int: *mut c_int,
    ++    ) -> c_int;
    ++
    ++    pub fn libgit_configset_get_string(
    ++        cs: *mut libgit_config_set,
    ++        key: *const c_char,
    ++        dest: *mut *mut c_char,
    ++    ) -> c_int;
    ++
    + }
      
    -+/**
    -+ * Clears and frees a heap-allocated `config_set` structure.
    -+ */
    -+void git_configset_clear_and_free(struct config_set *cs);
    -+
    - /*
    -  * These functions return 1 if not found, and 0 if found, leaving the found
    -  * value in the 'dest' pointer.
    + #[cfg(test)]
5:  18fea79783 ! 4:  29599e9c7b libgit: add higher-level libgit crate
    @@ Commit message
         a more Rust-friendly interface to config_set structs.
     
         Co-authored-by: Josh Steadmon <steadmon@google.com>
    +    Signed-off-by: Josh Steadmon <steadmon@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
     
    @@ contrib/libgit-rs/Cargo.lock (new)
     +version = 3
     +
     +[[package]]
    ++name = "autocfg"
    ++version = "1.4.0"
    ++source = "registry+https://github.com/rust-lang/crates.io-index"
    ++checksum = "ace50bade8e6234aa140d9a2f552bbee1db4d353f69b8217bc503490fc1a9f26"
    ++
    ++[[package]]
     +name = "cc"
     +version = "1.1.15"
     +source = "registry+https://github.com/rust-lang/crates.io-index"
    @@ contrib/libgit-rs/Cargo.lock (new)
     +name = "libgit"
     +version = "0.1.0"
     +dependencies = [
    ++ "autocfg",
     + "libgit-sys",
     +]
     +
    @@ contrib/libgit-rs/Cargo.lock (new)
     +name = "libgit-sys"
     +version = "0.1.0"
     +dependencies = [
    ++ "autocfg",
     + "libz-sys",
    ++ "make-cmd",
     +]
     +
     +[[package]]
    @@ contrib/libgit-rs/Cargo.lock (new)
     +]
     +
     +[[package]]
    ++name = "make-cmd"
    ++version = "0.1.0"
    ++source = "registry+https://github.com/rust-lang/crates.io-index"
    ++checksum = "a8ca8afbe8af1785e09636acb5a41e08a765f5f0340568716c18a8700ba3c0d3"
    ++
    ++[[package]]
     +name = "pkg-config"
     +version = "0.3.30"
     +source = "registry+https://github.com/rust-lang/crates.io-index"
    @@ contrib/libgit-rs/Cargo.toml (new)
     +name = "libgit"
     +version = "0.1.0"
     +edition = "2021"
    ++build = "build.rs"
    ++rust-version = "1.63"
     +
     +[lib]
     +path = "src/lib.rs"
     +
     +[dependencies]
     +libgit-sys = { version = "0.1.0", path = "libgit-sys" }
    -
    - ## contrib/libgit-rs/libgit-sys/public_symbol_export.c ##
    -@@ contrib/libgit-rs/libgit-sys/public_symbol_export.c: int libgit_parse_maybe_bool(const char *val)
    - 	return git_parse_maybe_bool(val);
    - }
    - 
    -+struct libgit_config_set *libgit_configset_alloc(void)
    -+{
    -+	return git_configset_alloc();
    -+}
    -+
    -+void libgit_configset_clear_and_free(struct libgit_config_set *cs)
    -+{
    -+	git_configset_clear_and_free(cs);
    -+}
     +
    -+void libgit_configset_init(struct libgit_config_set *cs)
    -+{
    -+	git_configset_init(cs);
    -+}
    -+
    -+int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
    -+{
    -+	return git_configset_add_file(cs, filename);
    -+}
    -+
    -+int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)
    -+{
    -+	return git_configset_get_int(cs, key, dest);
    -+}
    -+
    -+int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
    -+{
    -+	return git_configset_get_string(cs, key, dest);
    -+}
    -+
    - const char *libgit_user_agent(void)
    - {
    - 	return git_user_agent();
    ++[build-dependencies]
    ++autocfg = "1.4.0"
     
    - ## contrib/libgit-rs/libgit-sys/public_symbol_export.h ##
    -@@ contrib/libgit-rs/libgit-sys/public_symbol_export.h: void libgit_init_git(const char **argv);
    - 
    - int libgit_parse_maybe_bool(const char *val);
    - 
    -+struct libgit_config_set *libgit_configset_alloc(void);
    -+
    -+void libgit_configset_clear_and_free(struct libgit_config_set *cs);
    -+
    -+void libgit_configset_init(struct libgit_config_set *cs);
    -+
    -+int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename);
    -+
    -+int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest);
    -+
    -+int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest);
    -+
    - const char *libgit_user_agent(void);
    - 
    - const char *libgit_user_agent_sanitized(void);
    + ## contrib/libgit-rs/build.rs (new) ##
    +@@
    ++pub fn main() {
    ++    let ac = autocfg::new();
    ++    ac.emit_has_path("std::ffi::c_char");
    ++}
     
      ## contrib/libgit-rs/libgit-sys/src/lib.rs ##
     @@
    --use std::ffi::{c_char, c_int};
    -+use std::ffi::{c_char, c_int, c_void};
    ++use std::ffi::c_void;
     +
    -+#[allow(non_camel_case_types)]
    -+#[repr(C)]
    -+pub struct libgit_config_set {
    -+    _data: [u8; 0],
    -+    _marker: core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
    -+}
    + #[cfg(has_std__ffi__c_char)]
    + use std::ffi::{c_char, c_int};
      
    - extern crate libz_sys;
    +@@ contrib/libgit-rs/libgit-sys/src/lib.rs: pub struct libgit_config_set {
    + }
      
      extern "C" {
     +    pub fn free(ptr: *mut c_void);
     +
    -     pub fn libgit_setup_git_directory() -> *const c_char;
    - 
    -     // From config.c
    -@@ contrib/libgit-rs/libgit-sys/src/lib.rs: extern "C" {
    -     // From version.c
          pub fn libgit_user_agent() -> *const c_char;
          pub fn libgit_user_agent_sanitized() -> *const c_char;
    -+
    -+    pub fn libgit_configset_alloc() -> *mut libgit_config_set;
    -+    pub fn libgit_configset_clear_and_free(cs: *mut libgit_config_set);
    -+
    -+    pub fn libgit_configset_init(cs: *mut libgit_config_set);
    -+
    -+    pub fn libgit_configset_add_file(cs: *mut libgit_config_set, filename: *const c_char) -> c_int;
    -+
    -+    pub fn libgit_configset_get_int(
    -+        cs: *mut libgit_config_set,
    -+        key: *const c_char,
    -+        int: *mut c_int,
    -+    ) -> c_int;
    -+
    -+    pub fn libgit_configset_get_string(
    -+        cs: *mut libgit_config_set,
    -+        key: *const c_char,
    -+        dest: *mut *mut c_char,
    -+    ) -> c_int;
    -+
    - }
      
    - #[cfg(test)]
     
      ## contrib/libgit-rs/src/lib.rs (new) ##
     @@
    -+use std::ffi::{c_char, c_int, c_void, CStr, CString};
    ++use std::ffi::{c_void, CStr, CString};
     +use std::path::Path;
     +
    ++#[cfg(has_std__ffi__c_char)]
    ++use std::ffi::{c_char, c_int};
    ++
    ++#[cfg(not(has_std__ffi__c_char))]
    ++#[allow(non_camel_case_types)]
    ++pub type c_char = i8;
    ++
    ++#[cfg(not(has_std__ffi__c_char))]
    ++#[allow(non_camel_case_types)]
    ++pub type c_int = i32;
    ++
     +use libgit_sys::*;
     +
     +pub struct ConfigSet(*mut libgit_config_set);
     +impl ConfigSet {
     +    pub fn new() -> Self {
    -+        unsafe {
    -+            let ptr = libgit_configset_alloc();
    -+            libgit_configset_init(ptr);
    -+            ConfigSet(ptr)
    -+        }
    ++        unsafe { ConfigSet(libgit_configset_alloc()) }
     +    }
     +
     +    pub fn add_files(&mut self, files: &[&Path]) {
     +        for file in files {
    -+            let pstr: &str = file.to_str().expect("Invalid UTF-8");
    -+            let rs = CString::new(&*pstr).expect("Couldn't convert to CString");
    ++            let pstr = file.to_str().expect("Invalid UTF-8");
    ++            let rs = CString::new(pstr).expect("Couldn't convert to CString");
     +            unsafe {
     +                libgit_configset_add_file(self.0, rs.as_ptr());
     +            }
    @@ contrib/libgit-rs/src/lib.rs (new)
     +        Some(val)
     +    }
     +
    -+    pub fn get_str(&mut self, key: &str) -> Option<CString> {
    -+        let key = CString::new(key).expect("Couldn't convert to CString");
    ++    pub fn get_string(&mut self, key: &str) -> Option<String> {
    ++        let key = CString::new(key).expect("Couldn't convert key to CString");
     +        let mut val: *mut c_char = std::ptr::null_mut();
     +        unsafe {
     +            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
    @@ contrib/libgit-rs/src/lib.rs (new)
     +                return None;
     +            }
     +            let borrowed_str = CStr::from_ptr(val);
    -+            let owned_str = CString::from_vec_with_nul(borrowed_str.to_bytes_with_nul().to_vec());
    ++            let owned_str =
    ++                String::from(borrowed_str.to_str().expect("Couldn't convert val to str"));
     +            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
    -+            Some(owned_str.unwrap())
    ++            Some(owned_str)
     +        }
     +    }
     +}
    @@ contrib/libgit-rs/src/lib.rs (new)
     +impl Drop for ConfigSet {
     +    fn drop(&mut self) {
     +        unsafe {
    -+            libgit_configset_clear_and_free(self.0);
    ++            libgit_configset_free(self.0);
     +        }
     +    }
     +}
    @@ contrib/libgit-rs/src/lib.rs (new)
     +    #[test]
     +    fn load_configs_via_configset() {
     +        let mut cs = ConfigSet::new();
    -+        cs.add_files(&[Path::new("testdata/config1"),
    -+                       Path::new("testdata/config2"),
    -+                       Path::new("testdata/config3")]);
    -+        // ConfigSet retrieves correct value 
    ++        cs.add_files(&[
    ++            Path::new("testdata/config1"),
    ++            Path::new("testdata/config2"),
    ++            Path::new("testdata/config3"),
    ++        ]);
    ++        // ConfigSet retrieves correct value
     +        assert_eq!(cs.get_int("trace2.eventTarget"), Some(1));
     +        // ConfigSet respects last config value set
     +        assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
     +        // ConfigSet returns None for missing key
    -+        assert_eq!(cs.get_str("foo.bar"), None);
    ++        assert_eq!(cs.get_string("foo.bar"), None);
     +    }
     +}
     
6:  67c11dd143 ! 5:  2ed503216f Makefile: add option to build and test libgit-rs and libgit-rs-sys
    @@ Commit message
         automatically builds and tests libgit-rs and libgit-rs-sys when `make
         all` is ran.
     
         Signed-off-by: Calvin Wan <calvinwan@google.com>
     
      ## Makefile ##

base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
-- 
2.47.0.rc0.187.ge670bccf7e-goog

