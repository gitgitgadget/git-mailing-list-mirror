Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F92DF718
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840621; cv=none; b=SnZM8rV4Wec3VeIXQieu/K2UUyFaRYGos/++fOmQSMQHX5svxpfY0AzAExEJ0Mj6by3pHdMvF6Is8Ma+q6tH4SahZJoPP+ykVKX/IAFP37SQftKj21UHuTx04zWRB/8OO6kSCu/aqwU4323UqRWArVB+xS3/dk9nLiPD4wW5qU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840621; c=relaxed/simple;
	bh=OHrav56wnnpr2WmGA40My6eS/QFUFV4UXJSXzYxCFYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmODHfzYzaxAUSkTHiGqFvRCmLcS9WG9undmHhanI4E8ji3M+DbWyJZX6L0oZOTRlq6w426UCX/QpJKYpQ0ddN0nwOZSMAt1wdstL21gWq7ZliyhFcc0JvNvvskPyrbtCMeihFSgVychjti8kiGU+XZNqBseonWCZJtOR9vS1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H/mVDXU2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYLC5ClN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H/mVDXU2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYLC5ClN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C20811400306;
	Tue,  7 Oct 2025 08:36:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Oct 2025 08:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840618;
	 x=1759927018; bh=sDFyuOKuxRlo6LwyuIgr9w0jRfb/AzRoQMLQa1PYSeE=; b=
	H/mVDXU2nwJsV6PNZLWFn3+hQyTeb0bhc6vTSJlyO1AXb8o5wpvEprgHTzCrGVjG
	yZSxYuTEqTz8LsEF7SpAV1PTCxGuepajaqk4JiT/hfRtB3+jG6xQfCM7wWrEYb8K
	oSKy1JeSDlqoUv5s8wqSlQm1D3MvcM3PzluOsDpTSYTtVVfPDqGLF5r9KY6RFgvD
	Q3YdCysXKHQ+g1AHj+x4D1ksTCVIJCkv6NTqZZNY+eemNk9czTzVs78IebcQcBpJ
	vxzBiIq5pYk4bOaICUcI5vO0AWF7oWnmjMJ8FSgkVHZpl+HzgwlaWso7Ooclt9x5
	q1/qOJNBM++79Q0xVLcqoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840618; x=
	1759927018; bh=sDFyuOKuxRlo6LwyuIgr9w0jRfb/AzRoQMLQa1PYSeE=; b=g
	YLC5ClNMBftXlafpAk8N7iccGs/4K3sAkqAqGdvdaESH1k27qYidBBFZf70jIFR9
	jjJZZiYaYlQKiocs4evdB2LZUtz0tM4G1VLk+pXdPdN1wAK4q0s6hKhU4tBH9/Of
	RL5lcIcgT66fo9Tf+LpkQS0Nr4kLJ3tKG5Nm8W7HXEZtcN2VFR901P/Vd5QEC+6u
	KNgyXZ7O5k2Co+2ZFopg78GbjCouvx+t2aZJI5iDrD1Ywi1e0A3Xl1PLJM2xx1wy
	EnU3Z04uf3QEDd9Ou1aq3qGGbqGl5Yy3azMNnk93W80Ud/9wRcVlK+4k4Iq0PT8J
	3NhNZA4+C7a2MZhZh62/g==
X-ME-Sender: <xms:agnlaHHFbmJdrehk2GmXtsLpaMNhTcVBzH-TKkpnpxyphDJJT02abA>
    <xme:agnlaLVX6NNFfBkn_1Drvj49F5JFIobe2u8Z8nUlmU4INCKky1t5U4NdlSnMMaDpy
    JntgD98XA32piZIoGAu0ZJiWBk-zyJbsff4QJV91Z8noKitZIpX>
X-ME-Received: <xmr:agnlaOIDgDcu8eZdTS_tmkayh4cBjYGRHJ4TdTTnkXun7X9rxksi9DfceEYexIM7rzybC-ykfuCgvI7xnkxNJQ5WuMR8R1vVAsF01pyT8Mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkih
    gvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:agnlaD_Bdg6goZ3ACVszm2bB3Q9LM-uzficoJLiScdgQFG5rpSZ8oQ>
    <xmx:agnlaJIXhE8DgXac4qzoEM4t9cVdZShaDVNmO56l-NhlNFwvEnQE4A>
    <xmx:agnlaAmDmS05oW4yDNs4WYQwKrUfelhUaUPxt59-KGF1Cad8eTapYg>
    <xmx:agnlaFP0TXiTII8FWKKUDDItSwVaj3XWscbUWTphPeMlJayw8xs1iA>
    <xmx:agnlaG3EupleO7ybo57tzEHnRmfWJrN6VLLgYZGc69m9fZ82xH087PQT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:36:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86f6f592 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:36:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:36:34 +0200
Subject: [PATCH 6/6] rust: support for Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ci-rust-v1-6-394502abe7ea@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
In-Reply-To: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

The initial patch series that introduced Rust into the core of Git only
cared about macOS and Linux. This specifically leaves out Windows, which
indeed fails to build right now due to two issues:

  - The Rust runtime requires `GetUserProfileDirectoryW()`, but we don't
    link against "userenv.dll".

  - The path of the Rust library built on Windows is different than on
    most other systems systems.

Fix both of these issues to support Windows.

Note that this commit fixes the Meson-based job in GitHub's CI. Meson
auto-detects the availability of Rust, and as the Windows runner has
Rust installed by default it already enabled Rust support there. But due
to the above issues that job fails consistently.

Install Rust on GitLab CI, as well, to improve test coverage there.

Based-on-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Based-on-patch-by: Ezekiel Newren <ezekielnewren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml     |  2 +-
 Makefile           | 14 ++++++++++++--
 meson.build        |  4 ++++
 src/cargo-meson.sh | 11 +++++++++--
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a47d839e39..b419a84e2c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,7 +161,7 @@ test:mingw64:
     - saas-windows-medium-amd64
   before_script:
     - *windows_before_script
-    - choco install -y git meson ninja
+    - choco install -y git meson ninja rust-ms
     - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
     - refreshenv
 
diff --git a/Makefile b/Makefile
index 7ea149598d..366fd173e7 100644
--- a/Makefile
+++ b/Makefile
@@ -929,10 +929,17 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
+
 ifdef DEBUG
-RUST_LIB = target/debug/libgitcore.a
+RUST_TARGET_DIR = target/debug
 else
-RUST_LIB = target/release/libgitcore.a
+RUST_TARGET_DIR = target/release
+endif
+
+ifeq ($(uname_S),Windows)
+RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
+else
+RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
 endif
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
@@ -1538,6 +1545,9 @@ ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 ifdef WITH_RUST
 BASIC_CFLAGS += -DWITH_RUST
 GITLIBS += $(RUST_LIB)
+ifeq ($(uname_S),Windows)
+EXTLIBS += -luserenv
+endif
 endif
 
 ifdef SANITIZE
diff --git a/meson.build b/meson.build
index ec55d6a5fd..a9c865b2af 100644
--- a/meson.build
+++ b/meson.build
@@ -1707,6 +1707,10 @@ rust_option = get_option('rust').disable_auto_if(not cargo.found())
 if rust_option.allowed()
   subdir('src')
   libgit_c_args += '-DWITH_RUST'
+
+  if host_machine.system() == 'windows'
+    libgit_dependencies += compiler.find_library('userenv')
+  endif
 else
   libgit_sources += [
     'varint.c',
diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 99400986d9..3998db0435 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -26,7 +26,14 @@ then
 	exit $RET
 fi
 
-if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
+case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
+	*-windows-*)
+		LIBNAME=gitcore.lib;;
+	*)
+		LIBNAME=libgitcore.a;;
+esac
+
+if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
 then
-	cp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a"
+	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
 fi

-- 
2.51.0.764.g787ff6f08a.dirty

