Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC961EE7DF
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595261; cv=none; b=r87O/w4mInxPZGr31Bi7mBj6JneCJJWp+Ae+SZ5VWxF5Eq3IWbVTPmsl27wdiUzUueR0oPH5VipyeizMdYW3n9Q5JqmhEekrImlmyWuw4Z4RUHVmAZTYi5UqmlN8whUvR7bVvq6bElS9F9VWCq2pNOO00gqxVGTiHFRzDcTGX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595261; c=relaxed/simple;
	bh=z19qv0Tpiz6iEt+JY2Cxa/HknOw9Ful9sFfIYD/TPdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrylVEhPBD9A6uVPqp9WGFBMJuQAo5ckucXI8vQ1Ju6iWXJeRa5e6Lv0QfOXwg2+uL0ADu/vNIv/w7iCc15Qt/CbuZ34AUZsEtTqco49wiWz5xyCR+YBi1DPQvgCnsQT+4wNxtORJThABujpszGbQb0D5ejLWad2I9zneHkRKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQcZul4O; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQcZul4O"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22650077995so61810755ad.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595256; x=1743200056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2J8J8zr1M88D69/p3MFDyLpOxKJc+Zxy1Ic51TISZU=;
        b=vQcZul4O7+yfDTMOXtvNY9fhwe364pU0841FgYQagNesrXSvbI+PF+pgxF5VNHA/hL
         qKruYCi1U43BMINFeqU0Cej6h2/lQw6UcYWPXiN+pOvneCe1fnflIb1ApxwZB6FqyvEu
         1tLlM4d+bA5dTQNveNKg6sgq4Uv4HhZRQ9Y4/kohvTWcbFmHrA2s6BiHt8H5dkMQrXIK
         2WYRG16ywbIpyYbAh8ES6u2VY6QMzGoYAJzY8tO63Z/M86CXmi1CqBaaGXgaWKDRw4Qj
         AnE6652NkFAbehNs98IKPzFs/rmheUNl46EAzCA1qLXlx8eirwzQ8TSM9cX7Hi2Fx7wl
         cjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595256; x=1743200056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2J8J8zr1M88D69/p3MFDyLpOxKJc+Zxy1Ic51TISZU=;
        b=knCSxi5NK2/m21R7QrbeB+ouYqstVnDFOZ+sC/Hs+vRVFwHj1xRPZTx2wYrXvxdR1/
         50o7Pesoey83SODE0eyKeRjUDsGlQzRbQIuZFz0Uosa03qrLWNjdXnWmwpblVOH7mnhp
         3ivBZL7+wyCCcydVAreG7yBCJCr6myHmwpkw0BnFHGdaQkpJyDAWzV7GJ6EC8/Ulm5QP
         ouEce1Bb+e7RkmAbbv6RIrOGcEbOcjUZilp9b3J9nMkIeh1tHnN7hCxeYoVUfJXUR68A
         4WL0/IY+n51WjvJmz/ZY3NlrhzI+4nVka2fMJEeLWn4Jm8CbMh74JkgThMrgehvJFY4V
         YLTA==
X-Gm-Message-State: AOJu0YwA3M9lPcUAIcw9aSLpmjCzP845PZ3MIlAqitlf+BVjq1igcI9H
	oKDIskyB72OZdIoKK3TpL8iLDRN+lAUTWl83v1xnKjhf1YgoKQw8WpbJN94+O+Jt5K/u5pLxLpR
	/EMFVzKz9RYc/XzXXmqOeLRnP2xdOZ+xPwfjDRfrQ4v/XhiC9CFNJt4X+diT7T2k2AJ6VuFzETm
	6sAEqvQbE4zq9uEg+DcT52ZbnJ7S8ihW4RAXBiJ+o=
X-Google-Smtp-Source: AGHT+IETQPCPw8BIu8KlFxGTicPf0V0xOL8GzJHZ8haRr0EHt9DbgOpahgOgWiwLFuRWhkiYx1xfUFoPupiRBg==
X-Received: from pjl4.prod.google.com ([2002:a17:90b:2f84:b0:2fc:2f33:e07d])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e844:b0:220:e896:54e1 with SMTP id d9443c01a7336-22780d8c42emr78227935ad.26.1742595255977;
 Fri, 21 Mar 2025 15:14:15 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:14:07 -0700
In-Reply-To: <cover.1742594960.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net> <cover.1742594960.git.steadmon@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <28e10e1092bff1d3185c29b905f6410b2ea0d13d.1742594960.git.steadmon@google.com>
Subject: [PATCH v2 1/5] libgitpub: move to separate contrib/ directory
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

For Cargo packaging purposes, it is better for any dependencies built with Git's
Makefile to live outside the libgit-{sys,rs} crates. This, plus some future
changes to the crates, will allow `cargo package` to treat all of the non-Rust
source as a separate tree apart from the Cargo-managed inputs.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                                         | 16 ++++++++--------
 contrib/libgit-sys/build.rs                      |  4 ++--
 .../public_symbol_export.c                       |  2 +-
 .../public_symbol_export.h                       |  0
 4 files changed, 11 insertions(+), 11 deletions(-)
 rename contrib/{libgit-sys => libgitpub}/public_symbol_export.c (96%)
 rename contrib/{libgit-sys => libgitpub}/public_symbol_export.h (100%)

diff --git a/Makefile b/Makefile
index 7315507381..52eed88dde 100644
--- a/Makefile
+++ b/Makefile
@@ -2764,7 +2764,7 @@ OBJECTS += $(CLAR_TEST_OBJS)
 OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 
 ifdef INCLUDE_LIBGIT_RS
-	OBJECTS += contrib/libgit-sys/public_symbol_export.o
+	OBJECTS += contrib/libgitpub/public_symbol_export.o
 endif
 
 ifndef NO_CURL
@@ -3762,9 +3762,9 @@ clean: profile-clean coverage-clean cocciclean
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 	$(RM) -r contrib/libgit-sys/target contrib/libgit-rs/target
-	$(RM) contrib/libgit-sys/partial_symbol_export.o
-	$(RM) contrib/libgit-sys/hidden_symbol_export.o
-	$(RM) contrib/libgit-sys/libgitpub.a
+	$(RM) contrib/libgitpub/partial_symbol_export.o
+	$(RM) contrib/libgitpub/hidden_symbol_export.o
+	$(RM) contrib/libgitpub/libgitpub.a
 ifndef NO_PERL
 	$(RM) -r perl/build/
 endif
@@ -3937,14 +3937,14 @@ ifdef INCLUDE_LIBGIT_RS
 all:: libgit-sys libgit-rs
 endif
 
-LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
+LIBGIT_PUB_OBJS += contrib/libgitpub/public_symbol_export.o
 LIBGIT_PUB_OBJS += libgit.a
 LIBGIT_PUB_OBJS += reftable/libreftable.a
 LIBGIT_PUB_OBJS += xdiff/lib.a
 
-LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
+LIBGIT_PARTIAL_EXPORT = contrib/libgitpub/partial_symbol_export.o
 
-LIBGIT_HIDDEN_EXPORT = contrib/libgit-sys/hidden_symbol_export.o
+LIBGIT_HIDDEN_EXPORT = contrib/libgitpub/hidden_symbol_export.o
 
 $(LIBGIT_PARTIAL_EXPORT): $(LIBGIT_PUB_OBJS)
 	$(LD) -r $^ -o $@
@@ -3952,5 +3952,5 @@ $(LIBGIT_PARTIAL_EXPORT): $(LIBGIT_PUB_OBJS)
 $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 	$(OBJCOPY) --localize-hidden $^ $@
 
-contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
+contrib/libgitpub/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
 	$(AR) $(ARFLAGS) $@ $^
diff --git a/contrib/libgit-sys/build.rs b/contrib/libgit-sys/build.rs
index 3ffd80ad91..e0d979c196 100644
--- a/contrib/libgit-sys/build.rs
+++ b/contrib/libgit-sys/build.rs
@@ -15,7 +15,7 @@ pub fn main() -> std::io::Result<()> {
         .current_dir(git_root.clone())
         .args([
             "INCLUDE_LIBGIT_RS=YesPlease",
-            "contrib/libgit-sys/libgitpub.a",
+            "contrib/libgitpub/libgitpub.a",
         ])
         .output()
         .expect("Make failed to run");
@@ -26,7 +26,7 @@ pub fn main() -> std::io::Result<()> {
             String::from_utf8(make_output.stderr).unwrap()
         );
     }
-    std::fs::copy(crate_root.join("libgitpub.a"), dst.join("libgitpub.a"))?;
+    std::fs::copy(git_root.join("contrib/libgitpub/libgitpub.a"), dst.join("libgitpub.a"))?;
     println!("cargo:rustc-link-search=native={}", dst.display());
     println!("cargo:rustc-link-lib=gitpub");
     println!("cargo:rerun-if-changed={}", git_root.display());
diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgitpub/public_symbol_export.c
similarity index 96%
rename from contrib/libgit-sys/public_symbol_export.c
rename to contrib/libgitpub/public_symbol_export.c
index dfbb257115..de5f6943c2 100644
--- a/contrib/libgit-sys/public_symbol_export.c
+++ b/contrib/libgitpub/public_symbol_export.c
@@ -6,7 +6,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
-#include "contrib/libgit-sys/public_symbol_export.h"
+#include "contrib/libgitpub/public_symbol_export.h"
 #include "version.h"
 
 #pragma GCC visibility push(default)
diff --git a/contrib/libgit-sys/public_symbol_export.h b/contrib/libgitpub/public_symbol_export.h
similarity index 100%
rename from contrib/libgit-sys/public_symbol_export.h
rename to contrib/libgitpub/public_symbol_export.h
-- 
2.49.0.395.g12beb8f557-goog

