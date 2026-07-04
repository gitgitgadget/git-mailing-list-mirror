Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC51376475
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188361; cv=none; b=g+gDS9QZNE3qf12D8QXbtthP9jNEWyhMdQG5lfJeNntDv4ePeENlv4WiVc8RXU3IRab85FckFIix0gLMcf7b0/3cT0cvCsXykd0Tmu5zh4wV0ITGAThWq5UJEFe0JHzALOgpC43fq+Kxve9NLY0nYLYfw82Tq1YEX0NkQfAl4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188361; c=relaxed/simple;
	bh=HG5uypFyUKTmT2xii4q5vRvITkuc0JcBd4KNkvHo1M0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eR5Q2MX5/St5UY970oaf8RO2ItUQ7k7ry2ePhvZa9xfY3BBzVjgoIsfb/3zdztaDD7jNCccDyHHOTE6n5PZotHBVyq/+/d5YoycF5SIXa32OJXCqHX/+y15LDkVVzBK21phw8z3o8C7P6D5zPgS0yqEJLmhon1iny4QoQaDseRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anViarWt; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anViarWt"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so1323321a12.1
        for <git@vger.kernel.org>; Sat, 04 Jul 2026 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783188359; x=1783793159; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qRlPvcyW8/M3jd/EUwVvwQY34TM8DK9BVfhjB74dWJE=;
        b=anViarWtrBmCiyQ0ILbEu4ryrR3/5I2ohKP3AtS8Y1pvU7XZIHs27JAJIbZPcMgId/
         lcf9DYFrL94lNNnzk/OztYdrRtDsluL857fS/E3ikfdgbH3qFCKGQ+hhtGxvZXdXKqqf
         P/ibFfhk5z8lWKxGT3tjMSyn9zWOn2/8OZq3090gC6+viiBcI7utcLNM6EHFNBaPw6fs
         Ie46BwrI3eubooJLqZawUTPnkpVO9aLC931HoTGczEfotgKD1Iy9xykSTXmw+l0t9gjW
         XkMrgSee66V5xNJqchL+P6tLiunXkfwztdEFge51wTmPXsk2kg1xBCoUY9HTiCRZ/tfw
         Q9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783188359; x=1783793159;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRlPvcyW8/M3jd/EUwVvwQY34TM8DK9BVfhjB74dWJE=;
        b=IeZh++qgXE9N/4XK3YxBs2ySth8e1fCPYI/eVP3KhldU/87aFLW/oI8+kZOuWn/TfI
         pldF+fXqQbfxaYZPLq5Q8Oslbwnz75BUP2qSVKGNfdI788/JPbkp6BQvMQNJV8dkMupG
         jEuLpJ61rdlEuwUqezuYJKg6eqxIq45ui6LA6E2CiE88dEOUrJP/ldx1WtKcoVfzf5ra
         fjycXFzXr53RnSk7Oeuq+Juokx8ps1W+yGqqspVGOOjpYWOEP3FGNNPUDdPApyZD+OVO
         ep/NYGnT6mp5CvwrS3RS6AoIkomuhmzuYudUFHIGQda83BrNv+sbSVnerR1bxswB0bN6
         ocUQ==
X-Gm-Message-State: AOJu0YzKPFQSE4tw3wFevn2FPY+wr4WgRXGCGSskwAqLE03bovasGEZF
	0SfwXwxH98fL9pnfmtYBtUOk7rXiQBp9++r5OoFXwAVWH6JqhFIcPCV6ZwFspg==
X-Gm-Gg: AfdE7clhwfP25kFSXwhwHLu72jYSF+egKs0+9200IUpPqnTQLFcpbWYVr0uuFte9w4r
	59zRwt/WlOihJZbfgEgcHAzqvtHm75ED6et8bMdGAtiJ22xwOUWcxJlZbcI3SpA7A5jWENjEzqk
	I/Q5I/gzfbJ/plFAkUAxyS0lWGth2LkYtoNYUP7+z0HUK9ydYE6LOd6lmd2ZE/i8Qz+NiRH7O05
	pBvyrlfy1bAKIPHydOUVns1h2Bh6+/nAoJcFOSA83mK+w5NcYVVex0ZWHHE7oIRcA1mLUrwTdiS
	H/rcyxYfEr8QPAJak4d7ICg3AIU5FHDp/LvlrPgYW5X39COILl+aXoAnF99nQBh+CDbUeffd43e
	nA2wmpJcjz0ByBhyAk0U4xQuXFBZO4faEFtcBg9DcEDMJ0KaLA87Mu1eOE1iulkFJlzG5z0+114
	2DvgB2BG1BPSmdb1J/35vYbO8HBPxG
X-Received: by 2002:a05:6a20:3ca3:b0:3bf:bb46:8ed1 with SMTP id adf61e73a8af0-3c03e229875mr4930522637.17.1783188358889;
        Sat, 04 Jul 2026 11:05:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.214.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef5b3sm47634411c88.1.2026.07.04.11.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:05:58 -0700 (PDT)
Message-Id: <41de7d391ac00c70bfa981d20ed9df22dbdf7ace.1783188355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
References: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
	<pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Jul 2026 18:05:54 +0000
Subject: [PATCH v4 1/2] Makefile: add $(RUST_LIB) prerequisite to osxkeychain
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

