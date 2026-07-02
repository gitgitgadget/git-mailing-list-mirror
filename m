Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD533ACF12
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030977; cv=none; b=jL41zbfi3zHYAt2z43wwGFpeBKG61x1wA2pypFN37bAppbolPeJTChqjo9AKLDEw7QyqcuECU9Oeohg2jz6+I4yCnruaKUdT7473KcVwexpPxvmHxoy0tdfOXiibPz6iBJA34zJwpCF32zphv47TtrdR9IrAESjvsFCjo4vT1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030977; c=relaxed/simple;
	bh=HG5uypFyUKTmT2xii4q5vRvITkuc0JcBd4KNkvHo1M0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H2DaSXpFApNUzTnMx0jNvxVRNvl6NIn31E9/k+KjlveLg3yI82sgyGmU072JK722JfcmgTVbvJAX1aFhkmT4A6E8LpciNOzamBSPx/c/YjLz5umyFPIl4ubu7xA7W8Er4kzIzeWxwvJfNKgyFeww6uvxSRgBHgrANFYFvUBlVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnCXlZr2; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnCXlZr2"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so16876546d6.1
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783030975; x=1783635775; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRlPvcyW8/M3jd/EUwVvwQY34TM8DK9BVfhjB74dWJE=;
        b=WnCXlZr2JAH3l+DLsOw3nTUX2Y1aLjJoeM33+cYOlHSypYqDHdFZfTKVVQRBj9Z3bS
         UE6suLsZpQdtp6MSFfrPXP33ddydmJPIfZipnxPtSzBfMC3HTUoM3GBzCSrZ1VzAjJBz
         SyU7v3w8x9hzCUjdHANGC2pX0dthI5whx7r+vgpn0JtbE7YB8ZC25G59DqjNNw3H6eNU
         dralVTptPH3sftz3YqaYG6JMdU98RNsBkf/aFnPhDGOTYNb9eMsio51GZjWwPSjLT6KR
         s+jHrnA/JsCteHuCDrsQlIt2QcmBmrWRH2wb0B+LOiW9aIujIhe04UPqpMZNitPBdsOG
         JBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783030975; x=1783635775;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qRlPvcyW8/M3jd/EUwVvwQY34TM8DK9BVfhjB74dWJE=;
        b=RBkCvn9+myZaIJC1MhH+pUqIpZMgCDgtmfdVeeOEwH17+S+9Hi+0Ztvwss+kuZwVYp
         evgJSYA0TIuetl5HkgpLHmbvQ1PxP1cvqk7lwKhnmFHxTUkw9fUvizW+v1jua1nVuKM+
         bSOsMJdf9SDJsyBgEneiXHhESxv57jhkqnmZAHrrwrAvGTi8/+neqDcDG6nIFhXCNzCY
         9ZVa4xkGtuRo2NGlRug/28BZSCKxoU08E6o7W/MMsPdv1P2g9KNpzy68JvIG4oAyEgca
         VTJXKio+a2bfanbOkKVfquWWbflVNSmMSmgt6kxvXasqSKY/lWPJq+BLoqrfrHSCaCuh
         HyyA==
X-Gm-Message-State: AOJu0YzCsnPgpw6FYrhrttHpKicl723UqDOzUf/J7nqo+5UnMK81vD+a
	jWhm6v23GB8J38lqRmUNfGCBx/CRP1x46gd8qyzXSpkD3eAKn7cocnCSIcqSLE7H
X-Gm-Gg: AfdE7cll7FldtjB5lgwR8/hXyTyqho/rMiXlNeN3taTD5PvihE9wQ/6Pv73ojgk4CiK
	EOBiJ+GcVdpnESIVB+0UKNyjdRPdDIRFvEqyF9CrVsANGEzgZJopP+DZDCHZTw/3Y/3C5n7ZlC2
	qy8GAf0oZGG053glQ7fEfQHTQXKJ9m/f7hQeQt0OklbwRMt5tFzEhrhEb51FNYYej+B6Zid469M
	5LF2yTM3wFesyF2unSuoPTAukEtgo9wNTpKfpH8EePXC0dd/ARlku2Q0rVW+cOavvO7GB1OvsuT
	VK5T6K9FwZ/ryJJrLoQmcdO9IS11s4dhOtmtwSzKUXd9S2OiFjuSxiUovtDZRONAF2Wt6tsvxM2
	wg39TDwwZFtcY8+5pG03d1r60rZo///fYCtdKlJ9IT3Nw0auhtpffCEHM0t2lN6xmYFNT0nJvRc
	WMhcWAaful6nEJxmOK
X-Received: by 2002:a05:6214:2687:b0:8f3:13e4:739d with SMTP id 6a1803df08f44-8f421ca247dmr99889286d6.7.1783030975434;
        Thu, 02 Jul 2026 15:22:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.103.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724ba6fesm37732576d6.41.2026.07.02.15.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:22:54 -0700 (PDT)
Message-Id: <41de7d391ac00c70bfa981d20ed9df22dbdf7ace.1783030971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
References: <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
	<pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Jul 2026 22:22:50 +0000
Subject: [PATCH v3 1/2] Makefile: add $(RUST_LIB) prerequisite to osxkeychain
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
    Shnatu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Shardul Natu <snatu@google.com>

From: Shardul Natu <snatu@google.com>

When Rust is enabled, the git-credential-osxkeychain helper depends on
Rust symbols compiled into $(RUST_LIB). While commit 522ea8ef7d
("osxkeychain: fix build with Rust") updated the linker command line to
use $(LIBS), it omitted $(RUST_LIB) from the target prerequisite list.
Without this prerequisite, running a parallel build ("make -j") from a
clean working tree can fail because Make does not know to invoke Cargo
to build libgitcore.a before linking git-credential-osxkeychain.

Add $(RUST_LIB) as a prerequisite dependency to the
git-credential-osxkeychain target.

Additionally, wrap the definitions of $(RUST_LIB) and the "rust" build
target in "ifndef NO_RUST". This ensures that when NO_RUST=1 is
specified, $(RUST_LIB) evaluates to empty, making the Rust dependency a
clean no-op without needing intermediate variables.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1f3f099f5c..7db38ecce9 100644
--- a/Makefile
+++ b/Makefile
@@ -939,6 +939,7 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 
+ifndef NO_RUST
 ifdef DEBUG
 RUST_TARGET_DIR = target/debug
 else
@@ -950,6 +951,7 @@ RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
 else
 RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
 endif
+endif
 
 GITLIBS = common-main.o $(LIB_FILE)
 EXTLIBS =
@@ -3019,11 +3021,13 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+ifndef NO_RUST
 $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
 	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
 
 .PHONY: rust
 rust: $(RUST_LIB)
+endif
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
@@ -4074,7 +4078,8 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
 	$(AR) $(ARFLAGS) $@ $^
 
-contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
+# When Rust is enabled, git-credential-osxkeychain depends on Rust symbols in $(RUST_LIB)
+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
 
-- 
gitgitgadget

