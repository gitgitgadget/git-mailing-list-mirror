Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E8207667
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340275; cv=none; b=L0Te1qYpOJE9H9ibG5AhtlvmetQoeStbUfLZqwvzifFg7QocA3njJFb15E0oXUXAhP5tTdVtrdxmvqQBVPnPMVJVnpOT45wJ+LoEgJf652gfbOA3OwSHLDDffmIWW8KzSX4BFjRcaVFZ4Ji6fDnFnrTGN9Dmynv1YQZ00Qcgqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340275; c=relaxed/simple;
	bh=pDDqEUY35UZCBK2KEGJB9dQvPCDROMhyzeMjes3P2I0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Td28DoWzAo3iAOTC/uve4fhgh2neKefmMj/Zq0MckWcYHjJnscDzyP4O+fsxFJuuxTH8u+/cTBep+amM3S4gQeg8R0iBOeyKbvHUaasgUBVCT5iNcgJfdJLRI4UJSrJgaFTHzkOVcENJVI7JDRXI9ail7mrdDXUEpiDPHWp4egs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWNR4qXY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWNR4qXY"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso6676606a91.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742340273; x=1742945073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYuUOdSwt7gcTEjgg0vjyAebV+1EDCjlpvkJSkWhiM8=;
        b=oWNR4qXYJPa9+TDZh6Ei/+ydwh0IfYqfbp025MflL7c2f8tXhXIMtzGEW/u8PDqvHn
         9C0U4kBAdKoJGhL5rABnoUkq+lkfN44/jSrtB79clWmVjN3wIPJWpy4gggdpJcAbmM7+
         cWjctqDH9fvEKa7bqDPruQPds2GRb4YPrDZRKRlzyv43TWF65Mz3sBFnqEW68VFR1S41
         JyFbPIdZbE0YsP43MoQrnZ5X2Q89vAJc8CKWNDBX8IZHn9HOVHCMYVa7kZHIbk5cByIO
         ReCF8RlMkAdj1hx0keox7sRJeyTbMqCkuOl43MayszjSAcyRxMav4A5oSBIyyQxnEPFj
         oRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340273; x=1742945073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYuUOdSwt7gcTEjgg0vjyAebV+1EDCjlpvkJSkWhiM8=;
        b=OsIfil7PV6K1gjJ1SimWLW68+VH22v7bpVDz8BO0fECpaige+qkzcGChoXAuhRvexW
         x/P6IGtGc5YRui7ZDAI/3dpXLXTQ7Ol7qngS6tkV/YlfaoOzIdbjMW4IuER0Vd6OjpRf
         sHYo9p8/JqhdWdpjL2BZUdE3jMuzu/sca6TMdUJwR2uKebSS8OIREfHRvnYSKFklAayy
         MAHid/GbVQZ5gmYgLPsqD9YS6uTerp300NaAkTjFetK7LaNu+eXo88UTqOU5anJRoK/x
         luR9V/+086jxv3ilZQl0VjPN4BW/9OnIHaQx0AFSPaLZD57UsCOxJgOM/Pg/WT5UHvCx
         k79A==
X-Gm-Message-State: AOJu0YyvXmsQmGVQt8C9noMZvR2NomnmJHJ4j1m/6vk5eaYl2v6ZWoAS
	8Zk5KFUQYwYgXBmhgfZAsqOsngMCcNBI/OlXUC9d0pM4zTnPGsNUU7XiE0mmGTzjIN575KP/weP
	cm3NB1FatZZyjwHBpmy4J6fs9PkHydsg4fnoCI6s+YWr3zN0z5f5pGn6Ap857SFyU1+grL3uixK
	uDkO1r+96H0WFjgn689f/gilV6Cd2h4yypWlOI8kU=
X-Google-Smtp-Source: AGHT+IEibM7gnY3bUv7up703qGv4MtubFUyULRH1ANFX7JiawSHCRFQfv29tKIFI4RbgQ/jhyVjPNggAG9nH5w==
X-Received: from pjbpw8.prod.google.com ([2002:a17:90b:2788:b0:2fa:15aa:4d2b])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:180f:b0:2ef:114d:7bf8 with SMTP id 98e67ed59e1d1-301bde359demr739527a91.6.1742340272576;
 Tue, 18 Mar 2025 16:24:32 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:24:22 -0700
In-Reply-To: <cover.1742339107.git.josh@steadmon.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <8bd61ee5dd33d0529240b677caaff361876ec271.1742339107.git.josh@steadmon.net>
Subject: [RFC PATCH v1 4/4] libgit-sys: exclude unnecessary directories in git-src
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

We can avoid copying tens of megabytes of unnecessary source files by excluding
a few directories which are not needed to compile libgitpub.a. This helps us
stay below crates.io's 10 MB size limit.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                      | 14 +++++++++++++-
 contrib/libgit-sys/Cargo.toml | 12 ++++++++++++
 contrib/libgit-sys/build.rs   |  8 +++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e7d8786e4e..c75f1d0208 100644
--- a/Makefile
+++ b/Makefile
@@ -651,6 +651,7 @@ export prefix bindir sharedir sysconfdir perllibdir localedir
 CC = cc
 AR = ar
 RM = rm -f
+RMDIR = rmdir --ignore-fail-on-non-empty
 DIFF = diff
 TAR = tar
 FIND = find
@@ -3477,13 +3478,13 @@ coccicheck-pending: $(COCCICHECK_PATCHES_PENDING_INTREE)
 
 # "Sub"-Makefiles, not really because they can't be run stand-alone,
 # only there to contain directory-specific rules and variables
+ifndef NO_GITWEB
 ## gitweb/Makefile inclusion:
 MAK_DIR_GITWEB = gitweb/
 include gitweb/Makefile
 
 .PHONY: gitweb
 gitweb: $(MAK_DIR_GITWEB_ALL)
-ifndef NO_GITWEB
 all:: gitweb
 endif
 
@@ -3763,7 +3764,9 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .dist-tmp-dir .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
+ifndef INCLUDE_LIBGIT_RS
 	$(MAKE) -C Documentation/ clean
+endif
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef PRESERVE_LIBGIT_TARGET
 	$(RM) -r contrib/libgit-sys/target contrib/libgit-rs/target
@@ -3775,7 +3778,9 @@ ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
 	$(MAKE) -C templates/ clean
+ifndef INCLUDE_LIBGIT_RS
 	$(MAKE) -C t/ clean
+endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git clean
 	$(MAKE) -C git-gui clean
@@ -3798,6 +3803,13 @@ ifdef MSVC
 	$(RM) compat/vcbuild/MSVC-DEFS-GEN
 endif
 
+# Handle additional cleanup needed for running `cargo package` for libgit-sys.
+ifdef INCLUDE_LIBGIT_RS
+libgit-pkg-clean: clean
+	$(RMDIR) t/helper t/unit-tests/clar t/unit-tests t
+	$(RMDIR) oss-fuzz
+endif
+
 .PHONY: all install profile-clean cocciclean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: FORCE
diff --git a/contrib/libgit-sys/Cargo.toml b/contrib/libgit-sys/Cargo.toml
index e0623022c3..4b8facccfe 100644
--- a/contrib/libgit-sys/Cargo.toml
+++ b/contrib/libgit-sys/Cargo.toml
@@ -7,6 +7,18 @@ links = "gitpub"
 rust-version = "1.63" # TODO: Once we hit 1.84 or newer, we may want to remove Cargo.lock from
                       # version control. See https://lore.kernel.org/git/Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net/
 description = "Native bindings to a portion of libgit"
+exclude = [
+  "git-src/.github",
+  "git-src/ci",
+  "git-src/Documentation",
+  "git-src/git-gui",
+  "git-src/gitk-git",
+  "git-src/gitweb",
+  "git-src/oss-fuzz",
+  "git-src/perl",
+  "git-src/po",
+  "git-src/t"
+]
 
 [lib]
 path = "src/lib.rs"
diff --git a/contrib/libgit-sys/build.rs b/contrib/libgit-sys/build.rs
index 16e0d66afb..0a72040726 100644
--- a/contrib/libgit-sys/build.rs
+++ b/contrib/libgit-sys/build.rs
@@ -17,6 +17,9 @@ pub fn main() -> std::io::Result<()> {
         .current_dir(git_root.clone())
         .args([
             "INCLUDE_LIBGIT_RS=YesPlease",
+            "NO_GITWEB=YesPlease",
+            "NO_PERL=YesPlease",
+            "NO_TCLTK=YesPlease",
             "contrib/libgitpub/libgitpub.a",
         ])
         .output()
@@ -40,8 +43,11 @@ pub fn main() -> std::io::Result<()> {
         .current_dir(git_root.clone())
         .args([
             "INCLUDE_LIBGIT_RS=YesPlease",
+            "NO_GITWEB=YesPlease",
+            "NO_PERL=YesPlease",
+            "NO_TCLTK=YesPlease",
             "PRESERVE_LIBGIT_TARGET=YesPlease",
-            "clean",
+            "libgit-pkg-clean",
         ])
         .output()
         .expect("`make clean` failed to run");
-- 
2.49.0.rc1.451.g8f38331e32-goog

