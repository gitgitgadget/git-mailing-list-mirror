Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9237DA66
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480884; cv=none; b=oM+qmBJHjRjKzsbS2pkXRXWzcjL+FRfZkvXeKrRexw1Ob4jyESQXB5rDYFH3PoEb4xEx6tYN7Lj8AyC8J6ofiABFRUKShgdIHt0bWn1PHkdnmX39EVIWJns46PTpw581PE0fol+MXEEWgokEhhJDUkMvsWIq+wnqgnYBZ8TxfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480884; c=relaxed/simple;
	bh=0iTpiH+GqxosFP1vcOYy9y02k15D3wpUNMZn4KpT9rk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NdRvrtuy1g6D6p8XFx4I9dkj0DlpmQaeJv3gMMnvKLcDs9Bs+zmE8fVZ2LqWvp22UafzBN7tW2C91EH2vEE4nAEjc26BmdNeUTEcfMTBsU5Bf2WQnl86AIcP3lhQ89zybD1hzKBuX23OgU6LGho7QqFAlh+67j1LU3r9aHecLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ92G6YO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ92G6YO"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5b048375so6294885a.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 20:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480882; x=1784085682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c+djyqxJ6HrOAGz2szKTIFezncc7v+/4FZEIriMmSKA=;
        b=DQ92G6YO2uC1hy4b9hheukdMb1kjCn2kDqsFc1mY/gEugCx+3+I9xomEzvWuZXJucI
         PxVpLnZK9S1oCUcNxduy6bevcjwF3lDLUCo2SJTr1h3xWW+kik8p4cFsMB5fg4ZehaAh
         b8ql7x19OKljcAqhImHeNGNb39MktCTIH4lWL+ZRmKH7pK3xOp7/yFZrUVoCRduPqAHB
         J0+spDOHAEyLrya0U7tzutg5/oZSmkAVaZDDvb6vBBiSedUu5lsgp1hbo9FRMJ5C/xmR
         X2I2A6PScs2DuVSt9WEFZhbTxk3sXbSKWsae8jCa7LdQmDnM4x5pKyLGvH7BolW2qaBG
         BGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480882; x=1784085682;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+djyqxJ6HrOAGz2szKTIFezncc7v+/4FZEIriMmSKA=;
        b=FDv0kVer6NA3DA9sj+8q6QCGLi7VKc1sRVlsbI0zxoycJpRRjrVtGU5l8ADA8Q+0CF
         qOmuIj0ZJdOBuPzZjP357KUScy4gDpHxrlTkUjb728ruPuRgE7TpC4Bc1bsmpOt2T91n
         /WkNd1mJIEY6IYx0sZkpiB6azUMS//kEkQ+xsWda48XnaTOKgy0XPKoRJ07zQ+6WEuxX
         DfjCHQO/ALYBR21YVv9QC4JKYuzb2gP6HeyR/VJcGivIuq1Cs7etc7umgQu/aCINP1Sd
         LGxaOBDk9bVl1rqAeSBS+z96SM53rfPOS7Xgs1dTdRPtqExIuMSiPwYAWHVwvmj8vx4e
         XtDw==
X-Gm-Message-State: AOJu0Yzl3NfqA6yci15U2EWl2CN41x6M+rKGuPZFcoBdZe+GEO8bRLSX
	p5ElPinOtoO/lUTRfw/hNMNcKP71tMLEiCan0WVXMcLHncOmYD2V5NPW9Ij4Jdej
X-Gm-Gg: AfdE7ckYjUs3pMgMeQU+R6RopdFQ/D70zrsBqw7hfnR+1ilHiU3xBTdAQxgJ5t1uYb9
	yIT9UUnlkw/yn7uQEHH0WryYZu67BwofeX+Un8kMYkE5559Nj54+pGP4RcEK9WQiUIEuUTtsGmC
	DCYnNcLTxw9fV3jlP2fKK+v+h/I6DqKuvQxWDaLkTtpqMFmBPA2iHtXsE7vghqwELPffvcmZ8ju
	EUj4w1QtXWb/niUqyQqlRoXK75wI6vr2lgpHOScAJ0b4EVtQULamFsKvNS3DJo7oflL9ImbcPzT
	/smAPRqqE5c4XsCb3m9M3sXis/6CHANXtMOiTFU89rYxtUYkkY4S6SpXYX/v6fzKVe/GLy6i1UX
	cPe3/9pKC6Q0o6j610NJ7/UnVUqBk6xZRabe5af7uHhaEfAFAV0kmcEH0vZqb8CzQSAuANP3NVi
	6CuIstwmTk4lHY9TUOUg==
X-Received: by 2002:a05:620a:4723:b0:92e:c117:5ee9 with SMTP id af79cd13be357-92ecf65dc41mr61888685a.85.1783480882339;
        Tue, 07 Jul 2026 20:21:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.110.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de87e3sm175266386d6.35.2026.07.07.20.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:21:21 -0700 (PDT)
Message-Id: <8f2bd4b14a3ed796fc58184d305e4b64ca52c9a9.1783480879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v8.git.git.1783480879.gitgitgadget@gmail.com>
References: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
	<pull.2288.v8.git.git.1783480879.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 03:21:17 +0000
Subject: [PATCH v8 1/3] Makefile: add $(RUST_LIB) prerequisite to osxkeychain
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
    Shardul Natu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Patrick Steinhardt <ps@pks.im>,
    Shardul Natu <shardul.27591@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Shardul Natu <snatu@google.com>

From: Shardul Natu <snatu@google.com>

When Rust is enabled, the git-credential-osxkeychain helper depends on
Rust symbols compiled into $(RUST_LIB). While commit 522ea8ef7d
("osxkeychain: fix build with Rust") updated the linker command line to
use $(LIBS), it omitted $(RUST_LIB) from the target prerequisite list.
Without this prerequisite, running a parallel build ("make -j") from a
clean working tree can fail because Make does not know to invoke Cargo
to build libgitcore.a before linking git-credential-osxkeychain.

Note that we depend explicitly on $(LIB_FILE) and $(RUST_LIB) rather
than $(GITLIBS). Unlike standard Git builtins and programs like scalar
(which define cmd_main() and rely on common-main.o to supply main()),
git-credential-osxkeychain.c defines its own standalone int main().
If $(GITLIBS) were used, $(filter %.o,$^) in the link recipe would
match both git-credential-osxkeychain.o and common-main.o, causing a
duplicate symbol linking error for _main on macOS.

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

