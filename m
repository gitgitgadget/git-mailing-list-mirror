Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FFC2D4B5E
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390256; cv=none; b=dBuHavHmd+/RXpRVVFcOQsxdK9dw8Z8ooju8yuRC+SQqSIzEfn/l58/P8Sthcx9e9Uyc8YurCHRcGsg6P35MGbv1IDEPlNDqxEYV2CS+ZPbWir5o6l7CJ+kuC2uleF4MWo1QSXm5f5r7p4btV7Oo/C7kk5hPR/3lxePLMsshuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390256; c=relaxed/simple;
	bh=1JdFzWOrmuzrVhFumlWoDUfH81PqInrdh4S5ZrPx6So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfuqzhdzc1KISUiUQH+8d9rGFv4KOwShhr60Jep70oYRIFFrhCxlbKgF8657qtCTVt5xakvzXnOI7IXuCcudgEXO9GQIZqf75S0FnClOg9r/A27Q8EVcXaaoLjrEllJv7SGYBaEQIq9eX5dGOX3IQ0M+L39aOlCMlhYV3MWLlnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AjDVNzob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t9xGlYCH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AjDVNzob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t9xGlYCH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D42F71D007F0;
	Thu,  2 Oct 2025 03:30:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 02 Oct 2025 03:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759390253;
	 x=1759476653; bh=mTYQ9mW3OnsPAPTKfdW3QNywZ5ZSE2WNCCMhxWjflGQ=; b=
	AjDVNzobkr4170SSBREMDoUw3k00IdfWB4aq6485GCysxKRx9gc9uzHUiGHVpF0L
	nTl/isdyaaf3CPIg0BIQfDokhRRKPgQKgNDvBF4UWHHCfYSVxQs86nA6hTgiQnZ0
	30xYt/ApU4EBHCNFet0madHDo+5CBTE2R49qA7cKxHrWuw8sOiM+D0I78job2onq
	BzggUndH978fnQPrWEspFikum4l2YunkK7W0Fc0b/bILiCCRgmeGx5dv04gmYTte
	i9nKqD1gNrz7r5YsR/BPGgP3GG8KL9cuar1fNweRvbEv5NkhoK5eOnC+e+uaASZB
	Fax+c6WRCMn7kq7QX8GXFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759390253; x=
	1759476653; bh=mTYQ9mW3OnsPAPTKfdW3QNywZ5ZSE2WNCCMhxWjflGQ=; b=t
	9xGlYCHQTDvtJssr+AYXQGMTuCXwxviVHPQbq3km11x2JZ+PpxyX8vQ4Z7lGhQsz
	xA9FsKLUG2udcIInO9DP/azloTlensQ7KzVW8dOaxqL7qe5oHMbVwur/z4ABMA8H
	j6mXKX7ANvTYJKmwLOPYtzlXSVmqGA8jUVwLKBXyqPw8PiAB9fa/75+i0fAAJHgz
	/uWHPK9RZZIvdbexjSEPdVoLI0sOg1Ep4IDIR+5nSNkhd/04nI8SK2aPEVowgAvx
	qiPNWPax24+qicOV+E2BDpZcF5uIwZQL0poYOFeS6AyjWTTT1U63iYzsINvz+RS9
	tanpaQvOWnscvt/7eOSwQ==
X-ME-Sender: <xms:LSreaC9kKjm4-erCtOfko8f7Rs0U9KS_8tu1f5_6N346jme_v1aayg>
    <xme:LSreaDJVDb6irnmNS53bizFDYZpRIMqrfG2329Vy43TtbYSmnnz69HCd8QlJ26Chq
    VPW9vGN7LoEBLmbQ2gqvt4XA1YhXrs4LgOZ8_eler3Tp0YzVgle0g>
X-ME-Received: <xmr:LSreaHyiMy1mu3OOK9GllHJHKJoG6EU3cCCx-WZeUV-HdgDT3xSUuQFy4WMd4MMBcPHTBP4WHBcppnW7DI8KPjb6IwfgVxrLjQEMbFG_xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheegjeelgfdugeellefflefhieeuteehfefhvedtfedvtdfhhfekgfehleeggfdtnecu
    ffhomhgrihhnpegrshgpmhhuthgpshhlihgtvgdrrghsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegviigvkhhivghlnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghk
    thhivhhishdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggvpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrth
    hrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepshgrmhesghgvnhhtohhordho
    rhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:LSreaG1m2Uthbw8--yronJ5ulFHi5B0Ou7hlYqTHETSyU5JAFRZkZA>
    <xmx:LSreaA-VvarLiF1q213vLnXn1li96ubvjpAV9UT-o7P4dGGYYjhHNA>
    <xmx:LSreaORQKyZM1wP2ouS0d-CP91aY6KqHJkxCK9LmfahcaR6-U6au8Q>
    <xmx:LSreaPnQn4lee5vdyBI0zG5Y6msqpQWBVhbaIOSISx0Sc2jckfSMBA>
    <xmx:LSreaP31fpIGbgT0G4UGJzYfaGCmunhsOqHA1MX3tJXfRpM0C6dhyIQ6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 03:30:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5288a2f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 07:30:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 09:29:31 +0200
Subject: [PATCH v8 6/9] varint: reimplement as test balloon for Rust
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-b4-pks-rust-breaking-change-v8-6-3a89fd5b1ce7@pks.im>
References: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
In-Reply-To: <20251002-b4-pks-rust-breaking-change-v8-0-3a89fd5b1ce7@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Implement a trivial test balloon for our Rust build infrastructure by
reimplementing the "varint.c" subsystem in Rust. This subsystem is
chosen because it is trivial to convert and because it doesn't have any
dependencies to other components of Git.

If support for Rust is enabled, we stop compiling "varint.c" and instead
compile and use "src/varint.rs".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile        |  3 ++
 meson.build     |  5 +++-
 src/lib.rs      |  1 +
 src/meson.build |  1 +
 src/varint.rs   | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 31e79342e1d..2a7fc5cb1f3 100644
--- a/Makefile
+++ b/Makefile
@@ -1307,7 +1307,9 @@ LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
+ifndef WITH_RUST
 LIB_OBJS += varint.o
+endif
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
@@ -1499,6 +1501,7 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
 RUST_SOURCES += src/lib.rs
+RUST_SOURCES += src/varint.rs
 
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
diff --git a/meson.build b/meson.build
index 234a9e9d6fd..37dfa286017 100644
--- a/meson.build
+++ b/meson.build
@@ -522,7 +522,6 @@ libgit_sources = [
   'usage.c',
   'userdiff.c',
   'utf8.c',
-  'varint.c',
   'version.c',
   'versioncmp.c',
   'walker.c',
@@ -1707,6 +1706,10 @@ rust_option = get_option('rust').disable_auto_if(not cargo.found())
 if rust_option.allowed()
   subdir('src')
   libgit_c_args += '-DWITH_RUST'
+else
+  libgit_sources += [
+    'varint.c',
+  ]
 endif
 
 libgit = declare_dependency(
diff --git a/src/lib.rs b/src/lib.rs
index e69de29bb2d..9da70d8b57d 100644
--- a/src/lib.rs
+++ b/src/lib.rs
@@ -0,0 +1 @@
+pub mod varint;
diff --git a/src/meson.build b/src/meson.build
index c8d874b2106..25b9ad5a147 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,5 +1,6 @@
 libgit_rs_sources = [
   'lib.rs',
+  'varint.rs',
 ]
 
 # Unfortunately we must use a wrapper command to move the output file into the
diff --git a/src/varint.rs b/src/varint.rs
new file mode 100644
index 00000000000..6e610bdd8e0
--- /dev/null
+++ b/src/varint.rs
@@ -0,0 +1,92 @@
+#[no_mangle]
+pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> u64 {
+    let mut buf = *bufp;
+    let mut c = *buf;
+    let mut val = u64::from(c & 127);
+
+    buf = buf.add(1);
+
+    while (c & 128) != 0 {
+        val = val.wrapping_add(1);
+        if val == 0 || val.leading_zeros() < 7 {
+            return 0; // overflow
+        }
+
+        c = *buf;
+        buf = buf.add(1);
+
+        val = (val << 7) + u64::from(c & 127);
+    }
+
+    *bufp = buf;
+    val
+}
+
+#[no_mangle]
+pub unsafe extern "C" fn encode_varint(value: u64, buf: *mut u8) -> u8 {
+    let mut varint: [u8; 16] = [0; 16];
+    let mut pos = varint.len() - 1;
+
+    varint[pos] = (value & 127) as u8;
+
+    let mut value = value >> 7;
+    while value != 0 {
+        pos -= 1;
+        value -= 1;
+        varint[pos] = 128 | (value & 127) as u8;
+        value >>= 7;
+    }
+
+    if !buf.is_null() {
+        std::ptr::copy_nonoverlapping(varint.as_ptr().add(pos), buf, varint.len() - pos);
+    }
+
+    (varint.len() - pos) as u8
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_decode_varint() {
+        unsafe {
+            assert_eq!(decode_varint(&mut [0x00].as_slice().as_ptr()), 0);
+            assert_eq!(decode_varint(&mut [0x01].as_slice().as_ptr()), 1);
+            assert_eq!(decode_varint(&mut [0x7f].as_slice().as_ptr()), 127);
+            assert_eq!(decode_varint(&mut [0x80, 0x00].as_slice().as_ptr()), 128);
+            assert_eq!(decode_varint(&mut [0x80, 0x01].as_slice().as_ptr()), 129);
+            assert_eq!(decode_varint(&mut [0x80, 0x7f].as_slice().as_ptr()), 255);
+
+            // Overflows are expected to return 0.
+            assert_eq!(decode_varint(&mut [0x88; 16].as_slice().as_ptr()), 0);
+        }
+    }
+
+    #[test]
+    fn test_encode_varint() {
+        unsafe {
+            let mut varint: [u8; 16] = [0; 16];
+
+            assert_eq!(encode_varint(0, std::ptr::null_mut()), 1);
+
+            assert_eq!(encode_varint(0, varint.as_mut_slice().as_mut_ptr()), 1);
+            assert_eq!(varint, [0; 16]);
+
+            assert_eq!(encode_varint(10, varint.as_mut_slice().as_mut_ptr()), 1);
+            assert_eq!(varint, [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+
+            assert_eq!(encode_varint(127, varint.as_mut_slice().as_mut_ptr()), 1);
+            assert_eq!(varint, [127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+
+            assert_eq!(encode_varint(128, varint.as_mut_slice().as_mut_ptr()), 2);
+            assert_eq!(varint, [128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+
+            assert_eq!(encode_varint(129, varint.as_mut_slice().as_mut_ptr()), 2);
+            assert_eq!(varint, [128, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+
+            assert_eq!(encode_varint(255, varint.as_mut_slice().as_mut_ptr()), 2);
+            assert_eq!(varint, [128, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+        }
+    }
+}

-- 
2.51.0.700.g236ee7b076.dirty

