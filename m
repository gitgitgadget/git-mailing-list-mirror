Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C622FF4D
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595265; cv=none; b=d2NS0iGEGWNeKwNkiFoaAg1G/B5D5k1EDhb3aEIbJFnYGlXgkoCdq61N7pf/r6ZAEriBzjdnHZRPFhDS+mav6Ea5YziFyxZYRSz2C34opxXDwhAUFcltMUAl71iHffb8zx1R7FdzPz/w5+pykeV/wIjtHvfoEJGvy8jtQORbw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595265; c=relaxed/simple;
	bh=SXQxqvcl51eQdBFx6XgZhjdKY+isdFKWWwkPxXhmGZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FwXNoNOCXgIMKH2Loh5a4pjKHNxViBOg+Uqs5hXLrYyMW1onkqtHESgJoQDTwFPBmPJXoBPhTuNquidwNQJsPot9oUCLaeycsacHPb0gh/akgkeSsBEWV2YZtCwv91c3azHwi36W5FUc6vae+6hMRaoeoEGlEPRcqk2vrT3cyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcGRJOSN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcGRJOSN"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff69646218so6080290a91.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595262; x=1743200062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gvj0h43I4xmzFi92yvvKoyUcHm2ce3WpkFuhpwJQti4=;
        b=gcGRJOSNh8aBdTMpXJoH7gPy9grNmUacg4PDAAuXvbOD0a2SVMTDNTMLHfmF0QumWi
         o+r2atCBcq2oydWmqROEohBKqf5zI0M2Fr2j56cVl90eKuAPq4JMmzndXcYG7FHr1HN+
         3AbntDyiSoB/QU8ip+XOp87WEp0pHTxo432qdh+vHV4d0TsG3SOUlHE6MCh/HCItRb4b
         fcXwPBbrNYBz6p3ylhPSH4e03LfLZrhwO4hj0qKuGW2V6TYO3rdgZa3mtFvMxB3Pr/Qq
         HhPibFrZqxgcC/YmF2o+VMtiEqtaWrTIgSVc3ph8VmQuEuXHcqd1QyA8eAQB+441xsML
         Togw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595262; x=1743200062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvj0h43I4xmzFi92yvvKoyUcHm2ce3WpkFuhpwJQti4=;
        b=CEZ6e6QG2GNIyctyIBK0MrKajoJ02ZaUvGjx7v4Kt6+673vZ5oetyIvjTzn+VG6z42
         DDLUonsbVD8vBXsrgfReB4wbqN/AnFgFr9GEtHil9lJG0FYoDA/mgbgzIAy8poFBi6Pe
         aFVHDxuxGuSeU9vLVrEGebAvPDVWVjyWS+1x/qLnGezmVbBpwfmj/8lBCAZtf8ffmQtG
         ShcSOJC778Ib31FVorBiOdsaO/8EvKIFOycUJq10gclAeJuewnfQngX46GiIj4zuhJXP
         shB6v26nXSwbRY4tmdhFbb+EXAs7nPZ79Lb3Jz6jOsTQveUMJOh83r8lkHZLJldLHkjG
         3xzg==
X-Gm-Message-State: AOJu0Yy8cJOyrFl+ayCK+g18hAFir1WDeSvRAv/WBf1poZ+Re89FKIqo
	wYYPKJp2pf/CAIo3Qq+4Lo0UsCjERoFoGt7MfLxiwXNmBEUj5qiqKr2kD++jA4Brut2QQIn7dvH
	thqH5Ie1YgLWvcYj41eYJxwhILskXmjHJuv+LenIYXZh6tHoO3xVoBULy7FOC6BLgWKEXn4pcK1
	Uy4O/8veGt/oQc1AJ03pPveoadGOxM3FLc0oRKNVM=
X-Google-Smtp-Source: AGHT+IGL8drlTa6gcqMcEhzh8GZdYLkcgUij7x3D9GtZeaBH2wQFAUjKQPqm8wsNlahj24J+H3CwYpLv6m7Gvw==
X-Received: from pjg8.prod.google.com ([2002:a17:90b:3f48:b0:2e9:38ea:ca0f])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c4a:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-3030ff21efdmr8762900a91.33.1742595262043;
 Fri, 21 Mar 2025 15:14:22 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:14:10 -0700
In-Reply-To: <cover.1742594960.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net> <cover.1742594960.git.steadmon@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <390695ac1f929727478e6c8c26f5c69b9a6c068a.1742594960.git.steadmon@google.com>
Subject: [PATCH v2 4/5] libgit-sys: exclude unnecessary directories in git-src
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

We can avoid copying tens of megabytes of unnecessary source files by excluding
a few directories which are not needed to compile libgitpub.a. This helps us
stay below crates.io's 10 MB size limit.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                      |  2 +-
 contrib/libgit-sys/Cargo.toml | 12 ++++++++++++
 contrib/libgit-sys/build.rs   |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 91677448ba..1574fc76e2 100644
--- a/Makefile
+++ b/Makefile
@@ -3500,13 +3500,13 @@ coccicheck-pending: $(COCCICHECK_PATCHES_PENDING_INTREE)
 
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
 
diff --git a/contrib/libgit-sys/Cargo.toml b/contrib/libgit-sys/Cargo.toml
index e0623022c3..1c1efb6211 100644
--- a/contrib/libgit-sys/Cargo.toml
+++ b/contrib/libgit-sys/Cargo.toml
@@ -7,6 +7,18 @@ links = "gitpub"
 rust-version = "1.63" # TODO: Once we hit 1.84 or newer, we may want to remove Cargo.lock from
                       # version control. See https://lore.kernel.org/git/Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net/
 description = "Native bindings to a portion of libgit"
+exclude = [
+  "git-src/.github",
+  "git-src/Documentation",
+  "git-src/ci",
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
index 1237c9a37f..7e1244fcd5 100644
--- a/contrib/libgit-sys/build.rs
+++ b/contrib/libgit-sys/build.rs
@@ -17,6 +17,9 @@ pub fn main() -> std::io::Result<()> {
         .current_dir(git_root.clone())
         .args([
             &format!("CARGO_OUT_DIR={}", dst.display()),
+            "NO_GITWEB=YesPlease",
+            "NO_PERL=YesPlease",
+            "NO_TCLTK=YesPlease",
             "INCLUDE_LIBGIT_RS=YesPlease",
             &format!("{}/contrib/libgitpub/libgitpub.a", dst.display()),
         ])
-- 
2.49.0.395.g12beb8f557-goog

