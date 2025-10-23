Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849552C11C2
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203876; cv=none; b=Xhyu6p/zOwPcd9bCETojawYlTm4nxaWEX7oCPldrbg5mbEreEtzDeYtsysl2z+N+WrC5qkOkAXCF7IG66YIWDlH4ZpSK6XEG7H/znQ3isWdq2LXDEtb2Z9oAnFXDUYcoSPNHAnB7vXiiultZ5F3OrUcR6SErSvsuacJSGDWudjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203876; c=relaxed/simple;
	bh=OhxsqapUMPoGp1o5/6y3IO6hfr22UczHxYluR5WRw1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtrUsSc5ilh9KH6sSvoUdYJYQ0muQGNNBW/pwbb5X2s9bUeEmeJZIhvTxjhsoNlL7pGFwvoiG7BQnsGjibuz2ukqMJT6m7bXVTV5bJmjGgn7bn01twHgBjWOboDb9jtqIbf0AjF7gemRB4iWbFO9/gbrux3We9s/9uqYurwDUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VDx5nCE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KTs6YEot; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VDx5nCE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KTs6YEot"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CCE6B14001DE;
	Thu, 23 Oct 2025 03:17:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 23 Oct 2025 03:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203873;
	 x=1761290273; bh=bCO3SDcO8hPHRgr5Ou7e/4xErqhe+PMDMKcphteliD4=; b=
	VDx5nCE0uEm7vUs7UEuOGiwDvpaRV/tX56yAO55WsuZIHfAFJEGeiX5TA+3jfnNq
	MNMDR34KHiizWPfq92obR4+es59vibzFe2rS/txazCbnS5ptLXoowiE0uv7lq+ZY
	eMCQFBoHreSLQZNVsCXQ/aDWnZ5oAowMOjsNKmACH6QWiLdzOR8hjM5tr4r+2hZw
	iYqC6cuSfXP06/y+Qb1Y1WJ6Qwehvy3sgwC1k8oy65vRsUnEKDR8XPLYjboNk/mt
	58JYPbWimk8YAYI58eVme59uKTF6w6j5pmLu2cv9l5duIfbkxDMJ5KJm8d0kzq+6
	bahPNfEF18TWwR1xcRRVuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203873; x=
	1761290273; bh=bCO3SDcO8hPHRgr5Ou7e/4xErqhe+PMDMKcphteliD4=; b=K
	Ts6YEotV0pJqtx9OQd1RIwXd/CjBbQ8K1scjpyEeurIjzLrwXrrI1vNOWoiZNqse
	eiEgS+4Bjz+/588s4jtrdmcuwtDAtIfCIKOK+21XE0xoLck2qB9gVnikWh7kLyO1
	hdBQDQwI8fOGb8ZJnrVdUIUrFiqHxONZGUe0fpbBDcGo+ySkOEsEW5MhvQjtn0aX
	ETrFFt21G6/R6cHDBsQGF9XuofY+t+jka95xrnzYoiO3m8BW3cGmaR7hjbgOhYrb
	SBfRCZ8DziWCmiOJ+tjnmZKXuPPcE7pHugmA6+P77EfGIZNNejnoWXBGOSWwklBo
	tM8k3CDSp8EB1FHgh279w==
X-ME-Sender: <xms:odb5aEOA6DxxhmKF3TrRNYQoWtGrpzghkazgIMs43c4pZYqQ60x3tg>
    <xme:odb5aCbG0NvdO8rINRar4Y6CX-zvV6vASh6SoSdf43TZbjhkog2YmEmDVMVCn_fVU
    h6OYTPMrYBU6V4a9JDAbpLWAnbnpqLmaMA4jjtNotM0LzF2pI2DqQ>
X-ME-Received: <xmr:odb5aIqKcP1Hop-JpmF59AdSGo3YnxVXYqIyJx0U42vaMM-6NMYgdQ5TOaWQYThS08g7EzEGxovT-61yQDSZRJ-ZloU_oKF-RghRDOj3KxiegA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:odb5aGZ8ZVGCrPRh4eJzzObhEy2i2SI3t5wcit3_Jj_THm-7JtG_rg>
    <xmx:odb5aAQXY2JL0Kcwy1v1bkhFHibuCMADL8JWf-ifHa_V_bH3dVqd6w>
    <xmx:odb5aN7lH6VbHxHbtudVl2kLKI8DYNtFxj2FpYz93haZdKCbCH6xZw>
    <xmx:odb5aFxdldEFHGO6VXxqd2dbO0d9y4i-92BOkscx8aHvgzrn2qto7w>
    <xmx:odb5aJkVNO_qYKb86Szklyvf3jDy9vMT7YCBwk6nUu6FMVfR51Ie52JI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:17:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed0ccdeb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:17:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:17:40 +0200
Subject: [PATCH 3/3] rust: generate bindings via cbindgen
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
In-Reply-To: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>
X-Mailer: b4 0.14.3

When compiling Git with Rust enabled we replace our C implementation of
the varint encoding with a Rust implementation. A prerequisite for doing
so is of course that the interfaces for both implementations are exactly
the same. If they aren't, then we risk subtle runtime errors.

We don't really have a way to detect such interface mismatches though:
the code will happily compile if we change either of the implementations
without adjusting the other implementation in the same spirit. The risk
of divergence is low right now as we only replace a single subsystem.
But it is expected that we'll grow more reimplementations over time, so
it is bound to increase.

A related issue is that we don't have an easy way to implement features
exclusively in Rust and make them available to our C library. Again, we
don't have such features yet, but there are work-in-progress patch
series that will eventually add them.

Both of these issues can be addressed by generating C bindings via the
cbindgen(1) tool: given a Rust crate, it extracts all functions marked
with `extern "C"` and creates a C declaration for them. These are then
written into a header file that we can include.

Set up this infrastructure in both our Makefile and in Meson. To
demonstrate its use, the generated "c-bindings.h" header is included in
"varint.c". If we now adapt "varint.rs" to have a different function
signature than the C code we'll now get a compiler error:

    In file included from ../varint.c:10:
    ./c-bindings.h:10:10: error: conflicting types for 'decode_varint'
       10 | uint32_t decode_varint(const uint8_t **bufp);
          |          ^
    ../varint.h:5:10: note: previous declaration is here
        5 | uint64_t decode_varint(const unsigned char **);

An initial version instead included the bindings in "varint.h". But that
would cause us to recompile all dependents of "varint.h" every time the
signatures of exported Rust functions change. So instead, we now include
it in "varint.c" and compile that file unconditionally again.

Adapt our CI to install cbindgen(1) accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore                 |  1 +
 Makefile                   | 14 +++++++++++---
 cbindgen.toml              |  7 +++++++
 ci/install-dependencies.sh |  4 ++--
 meson.build                | 25 ++++++++++++++++++++-----
 shared.mak                 |  1 +
 varint.c                   |  9 +++++++++
 7 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index 78a45cb5bec..20558c9dc8a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -197,6 +197,7 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
+/c-bindings.h
 /config-list.h
 /command-list.h
 /hook-list.h
diff --git a/Makefile b/Makefile
index 0bf5f17a90c..1213a0fc960 100644
--- a/Makefile
+++ b/Makefile
@@ -1326,9 +1326,7 @@ LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
-ifndef WITH_RUST
 LIB_OBJS += varint.o
-endif
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
@@ -1562,6 +1560,14 @@ ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 ifdef WITH_RUST
 BASIC_CFLAGS += -DWITH_RUST
 GITLIBS += $(RUST_LIB)
+
+C_BINDINGS = c-bindings.h
+
+GENERATED_H += $(C_BINDINGS)
+
+$(C_BINDINGS): cbindgen.toml $(RUST_SOURCES)
+	$(QUIET_CBINDGEN)cbindgen --output $@
+
 ifeq ($(uname_S),Windows)
 EXTLIBS += -luserenv
 endif
@@ -2619,6 +2625,8 @@ PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
 pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
 	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
 
+varint.sp varint.s varint.o: $(C_BINDINGS)
+
 version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
 	$(QUIET_GEN)$(call version_gen,"$(shell pwd)",$<,$@)
 
@@ -3806,7 +3814,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
-	$(RM) -r Cargo.lock target/
+	$(RM) -r Cargo.lock target/ $(C_BINDINGS)
 	$(RM) version-def.h
 	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
 	$(RM) $(test_bindir_programs)
diff --git a/cbindgen.toml b/cbindgen.toml
new file mode 100644
index 00000000000..ba4b2d63672
--- /dev/null
+++ b/cbindgen.toml
@@ -0,0 +1,7 @@
+language = "C"
+
+# Don't include standard C headers. These are managed by "git-compat-util.h".
+no_includes = true
+
+# Use plain structs instead of using typedefs.
+style = "tag"
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index b7b3cf35edf..3bce6f47f87 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,7 +37,7 @@ fedora-*|almalinux-*)
 		MESON_DEPS="meson ninja";;
 	esac
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
+	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo cbindgen >/dev/null
 	;;
 ubuntu-*|i386/debian-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
@@ -64,7 +64,7 @@ ubuntu-*|i386/debian-*|debian-*)
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
-		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
+		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo cbindgen \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
 	# Starting with Ubuntu 25.10, sudo can now be provided via either
diff --git a/meson.build b/meson.build
index 308798e861b..b4acc417ad4 100644
--- a/meson.build
+++ b/meson.build
@@ -523,6 +523,7 @@ libgit_sources = [
   'usage.c',
   'userdiff.c',
   'utf8.c',
+  'varint.c',
   'version.c',
   'versioncmp.c',
   'walker.c',
@@ -1704,7 +1705,9 @@ version_def_h = custom_target(
 libgit_sources += version_def_h
 
 cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
-rust_option = get_option('rust').disable_auto_if(not cargo.found())
+cbindgen = find_program('cbindgen', dirs: program_path, native: true, required: get_option('rust'))
+
+rust_option = get_option('rust').disable_auto_if(not cargo.found() or not cbindgen.found())
 if rust_option.allowed()
   subdir('src')
   libgit_c_args += '-DWITH_RUST'
@@ -1712,10 +1715,22 @@ if rust_option.allowed()
   if host_machine.system() == 'windows'
     libgit_dependencies += compiler.find_library('userenv')
   endif
-else
-  libgit_sources += [
-    'varint.c',
-  ]
+
+  cbindgen_input = [ 'cbindgen.toml' ]
+  foreach source : libgit_rs_sources
+    cbindgen_input += 'src' / source
+  endforeach
+
+  libgit_sources += custom_target('c-bindings.h',
+    input: cbindgen_input,
+    output: 'c-bindings.h',
+    command: [
+      cbindgen,
+      '--output',
+      '@OUTPUT@',
+      meson.current_source_dir(),
+    ],
+  )
 endif
 
 libgit = declare_dependency(
diff --git a/shared.mak b/shared.mak
index 0e7492076eb..598e58e069c 100644
--- a/shared.mak
+++ b/shared.mak
@@ -57,6 +57,7 @@ ifndef V
 
 ## Used in "Makefile"
 	QUIET_CARGO    = @echo '   ' CARGO $@;
+	QUIET_CBINDGEN = @echo '   ' CBINDGEN $@;
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
diff --git a/varint.c b/varint.c
index 03cd54416b6..1ed738a756c 100644
--- a/varint.c
+++ b/varint.c
@@ -1,6 +1,14 @@
 #include "git-compat-util.h"
 #include "varint.h"
 
+/*
+ * When building with Rust we don't compile the C code, but we only verify
+ * whether the function signatures of our C bindings match the ones we have
+ * declared in "varint.h".
+ */
+#ifdef WITH_RUST
+# include "c-bindings.h"
+#else
 uint64_t decode_varint(const unsigned char **bufp)
 {
 	const unsigned char *buf = *bufp;
@@ -28,3 +36,4 @@ uint8_t encode_varint(uint64_t value, unsigned char *buf)
 		memcpy(buf, varint + pos, sizeof(varint) - pos);
 	return sizeof(varint) - pos;
 }
+#endif

-- 
2.51.1.930.gacf6e81ea2.dirty

