Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B94C1FA261
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340270; cv=none; b=TJ9Z/N89lvZItB60To5/R3UXV4jrooshvGkmftG/XCDFsqboJKwOv9dW1dZBudKpa+iSyLn6hcfMgz+lNgEeQTK/oGyVpA40c4VpGOTF7AlXmqJ3Z9c9gv148dIt/WM9FQ11rQGkQbIvm144qu1ihTZuys5lqenPa7T6sBzsFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340270; c=relaxed/simple;
	bh=EQw3deP8HZMFRySHpcTELECiAM4UtnK2aoKiDcsnOPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X/11JK1gipHuOw78xPPfMikki1z6RkSnlf/HpOWsePaDwZaEEom53Rn10q7hZPCsc0dHnM9xwKcL3v7fA9McGAfCiBod2Hpr5UF4PtxOvDRxZtBgJgpVpXWyOrow49ltRbOJICGuzuLt8cD4KPl8Vij0+NBevkzBa0y3JCSiLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PyEDE9p; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PyEDE9p"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so5903952a91.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742340266; x=1742945066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Smav4aO7m/YKT3dg9mORFdn+kiS9F6m1uRKkJci/u6g=;
        b=1PyEDE9pzcJyJNb+Hj+iGaq6a8hMlhHoVb5GjWlwdnSu8Z8GNcIEQchzsSnBjgCVSF
         dZ4WNRDQThTQQycHG6JrEDPHO2+sUXCAQ000Gz9gpI/ijN2u3WH5k6701IErOeF4AuXa
         JZbDbYfTMR6oQsPDRhyp7jEgYeAD0TeBComY2hHbsJOYIxj3Gq6v8sGi+fMKC7cCR5qR
         0zTDrAnXT64jeDEo+fnzNmZmLk8z+yEE2TOnX7YOPeIc127/WVkwri2qjuzVaaHDVgMs
         AfF36Ghc577CmMWpORNJIdLYhBpX68k3TinrLbCkRTHN7+ERJwKz9xI+scsHuKlZ7Vae
         /Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340266; x=1742945066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Smav4aO7m/YKT3dg9mORFdn+kiS9F6m1uRKkJci/u6g=;
        b=d0rVHfeXgMSqzZH1rZx8hRnfKnBoStgLPp7i4bv1yMkj9ThfVgeuq8TPPy0FkYj7OP
         JOrMhXqcclu/mDZIzXn4PeNWKXZs4yWWyoEUkqa1PDNo8KU3mXSzjSIKZyVxPafyEnsV
         c0HBFqUeO+9f6/EtxTAh7B54XlF3/0pk1aC4RmNrLmWxarLAk1kXsevTJesivtkqCgqz
         7wbghFOT9rl82umfAgRaMu4sUCEPwgn6RhxnRqVLufgK9hCHoRPYwaaRfxIGzJdD+FEA
         HLfRIho5aqkaQefvxGxlucWpQ1LbLywLXkh8lknWQCfaPiqG2tuKjJhOBLneJXPJdW3V
         cllQ==
X-Gm-Message-State: AOJu0YxUY4EhPWJBZFpQMyfQilQgzrz7JvdRU/cO/so+ctCAqKjas43A
	QH+i0ZRTMq+m0bwmGTUgzj6UtS57OwAL87KWFzuI/um4gqBKsZbhuNevkTgiCe+3yuJ/2r2wjtg
	aAYSy5bxKPi6kYEMMhTCayj07U+PYlGs5F+GHJefWgIKFfc8DcXYID56GKb5yOC/peC6a417ROE
	kI85eTu2izvyX3A2uR0XTShcqmtACbuRMpA8+ocfY=
X-Google-Smtp-Source: AGHT+IHa/b2nv1X8mhdOKDq2Ryx3jLDl9Ktkr8CsA2jOA2SRuo5rRX0nrOEM1Q+/fTb9y6xPimApnPEzkmOZvw==
X-Received: from pgbbz14.prod.google.com ([2002:a05:6a02:60e:b0:af5:da83:bdc0])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6e48:b0:1f5:839e:ece8 with SMTP id adf61e73a8af0-1fbeb1854bcmr778609637.2.1742340266536;
 Tue, 18 Mar 2025 16:24:26 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:24:19 -0700
In-Reply-To: <cover.1742339107.git.josh@steadmon.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <d4128b7618fde469dabee9366221f6593456213f.1742339107.git.josh@steadmon.net>
Subject: [RFC PATCH v1 1/4] libgitpub: move to separate contrib/ directory
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
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
2.49.0.rc1.451.g8f38331e32-goog

