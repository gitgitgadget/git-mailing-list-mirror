Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923F30C63E
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299527; cv=none; b=snHZbXFS4fMw0WhJet1epwmoS9a8BK2Z1L7ddBpxs7+bFDWzvcM7Vs0qJR+Rccxla+99N7DRLIJK26UErlCV4FRTVloN3fMwmpBDY7Ler+lVIAug8IuQCyOk1Am/ykZ+Erym+3R1P7dOhbv6wKXLyR5SxRclPh8UorUkALD1WTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299527; c=relaxed/simple;
	bh=AxZK8fY8gb2qOTycDOIYXSPwdvyhBgN6dT3uEjLn7WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IqfPcgiuGJPLEGZqIvIdYpGFcvInY44RTty6oQ1ehPbNnKDm93dK2eoqoICyO79qAmvFdz+8uoTdd80hcDkt7W9Fa8lxnZup/g8BbP/sUPP7aawQnDT7Wuk7a/Ube20bUDcSBILdAZHRVj1VBEaymXIWOxICyiZZZO30Ed29RHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rSKha8Tk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T77xxPnS; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rSKha8Tk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T77xxPnS"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 29E12EC027E;
	Fri, 24 Oct 2025 05:52:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 24 Oct 2025 05:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299525;
	 x=1761385925; bh=BsVvOQo4SdJ4aXn4gQoeIGOT0mZzIUJTPtQDRp1m1aI=; b=
	rSKha8TkZVjyTvlzkRwnYBuXc9qirnXKLw7Ju7oYrDlvJcQA7UkM4BOKEBoLJ9XG
	4GPEgkhTt0NeZ7gOYuGATbIvZIkrKAotd4HN5VbgtTX1a1iXOsD0C64yxuZqTu2X
	tAV1bjEFh/BmjZonv11C2kW9t0iyHOrBbdLno7GuY5etrAueGDVJa1tZ2icYjwSX
	NPt/kv9PCmqktFmLwap7vaagxSj2QphlrcockGu8g2IXcOTHQeJYzN/HpWh5jmJs
	N50q/yUrHyzrYO7opWkDM3+sCDKvEaYk6cifKUPkYi8cbl830CEsFbFl4WBKCSh2
	cvCjdfAxPQE3VdV7L+RWug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299525; x=
	1761385925; bh=BsVvOQo4SdJ4aXn4gQoeIGOT0mZzIUJTPtQDRp1m1aI=; b=T
	77xxPnS4rpydHuTM4vgT6rbBA9JNUNnSC5THc3ccByXbBWXXv35aPIMOY/dfDOIY
	I16n1ah315Lez2jA83MYd6UPQxc5RH7wtm9EVT/5qb8FytzbtmgtP4Nm+erL3SuP
	jxozGBOt0eXVvxT/O8Ev0q4sEQYabO9XuhHQ5YV/n/mvMVkEHp1TlYptMQBZ0+X8
	xqlXAYW3BaHuqq6NumVFx9QRRvnfWMR2o01xZCnJcyv1Wvqo7UpI1bZUxFHXUGr+
	CFgP+vl9IJbJ2YtoAcp+8iUImIn1RMcO0+t4NWlUZnhOqWzv/3LUkETPsmcx0nNf
	JQOvADFUddwlGyTMfUA9Q==
X-ME-Sender: <xms:REz7aIG3gjKrZsgjhtowpI-_oSoE5_EihuqZYp8c208zDWc4m8ykLA>
    <xme:REz7aIXIoF7jQf456e2YysnZjhV7UTS8DFbvLObASiq4LlFBg0Q5PaYYaRbVCjy0l
    hlY90M2oLkh6LUqXT8etUBnCyDFx42icRCvhkMO7HBvDuocv9IkrQ>
X-ME-Received: <xmr:REz7aHLsIl0wsGLCTp7BWIMZdw7HaxRFgKYtNiep7WyYEvaP_vMsMDt0IsvX6eQmUD31mDE4L8AzmuN3aSCWWy58pqeLo0mF8bL56b-UXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:REz7aI8mhbYd8hpGGLdRH7QM8RoPj6gD6tIC95ccBgN4-dl9MK453Q>
    <xmx:REz7aKIaa5JdBop0nMPJgdY9VNFCsGn-6XOAHlZ5HEZfraUfvV42dQ>
    <xmx:REz7aNkwdukZXTpapS63M0OrPNKuY64GCbqAJnXAxje6nJk8QreE2g>
    <xmx:REz7aOPVLFXAgVhZDa6VBToH3GtdL9AduOeLLjyoNNE_S7wZV1Bnjw>
    <xmx:RUz7aJ6nXo1oWNSlQqf6SlIqzunyrfLe0djHknYzMs5i7roRk0L68vL3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:52:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e86cb4cb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 09:52:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:51:37 +0200
Subject: [PATCH v2 5/5] rust: generate bindings via cbindgen
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-rust-cbindgen-v2-5-4b4bd4f18490@pks.im>
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
 cbindgen.toml              | 13 +++++++++++++
 ci/install-dependencies.sh | 10 ++++++++--
 meson.build                | 25 ++++++++++++++++++++-----
 shared.mak                 |  1 +
 varint.c                   |  9 +++++++++
 7 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index 78a45cb5be..20558c9dc8 100644
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
index 0bf5f17a90..1213a0fc96 100644
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
index 0000000000..7f8cdfa4b2
--- /dev/null
+++ b/cbindgen.toml
@@ -0,0 +1,13 @@
+language = "C"
+
+# Write a warning into the generated file.
+autogen_warning = "/* Warning, this file is autogenerated by cbindgen. Don't modify this manually. */"
+
+# Don't include standard C headers. These are managed by "git-compat-util.h".
+no_includes = true
+
+# Use plain structs instead of using typedefs.
+style = "tag"
+
+# Match our coding style more closely.
+tab_width = 8
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index b7b3cf35ed..d42c705391 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -32,12 +32,18 @@ alpine-*)
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;
 fedora-*|almalinux-*)
+	RUST_DEPS="cargo cbindgen"
 	case "$jobname" in
+	almalinux-8)
+		# AlmaLinux 8 does not have cbindgen, it was only added in version 9.
+		RUST_DEPS=;;
 	*-meson)
 		MESON_DEPS="meson ninja";;
 	esac
+
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
+	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext \
+		zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS $RUST_DEPS >/dev/null
 	;;
 ubuntu-*|i386/debian-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
@@ -64,7 +70,7 @@ ubuntu-*|i386/debian-*|debian-*)
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
-		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
+		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo cbindgen \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
 	# Starting with Ubuntu 25.10, sudo can now be provided via either
diff --git a/meson.build b/meson.build
index 308798e861..b4acc417ad 100644
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
index 0e7492076e..598e58e069 100644
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
index 03cd54416b..1ed738a756 100644
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

