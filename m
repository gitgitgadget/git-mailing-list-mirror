Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FF2F60DF
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781841; cv=none; b=DxaYgprZqF//V1Fyn345CeuC0xi5WxrS7kerm0V6/1akVWFwkM3cBFPtg3VireFILm+L6su1l5tPxVQXUk3rWrgDHLpgoUOdjqEWYMNjoBN9SE+euHiW9HyWUOHVa0f+CA5dYbh76DkbyKRTVHpNS7RwWY4jiakAMJG9U0KRqrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781841; c=relaxed/simple;
	bh=AWy5tSXlSfE1PJ072LLuHO8I/QrGSat58zDJBttdxXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQut45qguQ6TBgbzBsc2sXYymj1wRBb9vPnMH099EK4gUFLG86r7Lx5nT4Agmi/F7+GNuS9bktdgL1bMrs2s9eXOF3T8EL9d83JM2hOVNyjM9hBsnLtu2gK+VZsBtgt5MA6jnz/Vw0KHa4CUtre44lNALvzVCHYzoU2xZanVwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PwIfEzti; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBaG95Vl; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PwIfEzti";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBaG95Vl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA8E37A00AF;
	Thu, 25 Sep 2025 02:30:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 02:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781837;
	 x=1758868237; bh=iHC4CzYiX4HVoXUunF1L+RhC++xKpyszIqExFwV/1gE=; b=
	PwIfEzti5/j7CWhahhTmzNDgEwd8C7mprIIq56OxJGYKFq2bko+UcTRDxx5waiub
	32hf/hV2LnBl0V1kgJtsYYWo2Ri/s0sVf0e5GVnucRc5bUT2eHnhyBI21MiEZ+Au
	L6nBlIxZLuV+BCwXWNIF89jmMofHEkLgBNMEzvsUa95Tc7msrC0wG7rQ++JPkDZM
	phju2cMB9jjt8paDmPyzO9tMnw+o4r55dwZAmq0C0OaBHZw2NJT6N4BbZhpDMqcn
	QYry9UtGfC0pUeG6If4KwpDOr71KYv1NyPrqWJ1LEumDMF7LpFZwPUSZcK1+75SW
	wIMbC2s1eJhe4fuM45ucAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781837; x=
	1758868237; bh=iHC4CzYiX4HVoXUunF1L+RhC++xKpyszIqExFwV/1gE=; b=X
	BaG95Vl6mnDDvxnjeWlWWBSYNesbySDWMVu2lVlCSI8LzP2SAnGsrXjC1tnh6GDb
	l1ref5rFjNxPUl4NVdLBrsdhgVxitCg0DnwP4zPGuTPvkQpV1gRHzxdOewDwmHiA
	Vh4SbpuY8d9so7Jqg76PWjV3vaZQbqEQSRNugzaS7BGwKxqdQ4hwZ75ViOI6Ednb
	PPydmj0CRu1C5pxs2Dj9VeDBMueQGlV+rgDy5vlR0+FEWxiCPiWKhEDqsOCZ4RIQ
	G9AjZcmMRUbIjoJBFc3P+zZvDBwH+nG1D/R1jLIigxKP6G3WWeluaf588CGqjEbz
	Lny//2FBxyW7+NpKOKy/Q==
X-ME-Sender: <xms:jeHUaH75g7-H83VLP5llda88JuohlkhGNiZBIBX5VUHNrnbhQVNofg>
    <xme:jeHUaNXhKpVtTf9txE45gUtztlNYPpnACC8fV4Yz5Z_CBPXuj6Tv9zE4qPCptDig6
    DyvbnYCAWj88BzPZuoJUE0UAE6Da5w1nbqjJdLHUUvARfav_v0>
X-ME-Received: <xmr:jeHUaOP1ZlEiRaIjI7ggbDHRYAKzRT5y2cNvr2nN5MQVZ8dwcE86W6t1TGiBUwR41vyBEtCiLd4N5IpNIK0TwXVMYC8C1oZ_FVIeDAiv_9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheegjeelgfdugeellefflefhieeuteehfefhvedtfedvtdfhhfekgfehleeggfdtnecu
    ffhomhgrihhnpegrshgpmhhuthgpshhlihgtvgdrrghsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhr
    tghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkhhivghl
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstg
    hhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:jeHUaEhzlgc2FhIhiA_EUq66mEX1SPBN6P2OP5XAzDOTuOb_jh48Cw>
    <xmx:jeHUaE7QrDfJnbvzRj7JBLwrCuXWmwBn6XaDO7YSfcPBSyx1o8Cg3A>
    <xmx:jeHUaLckVle-fbPRQGhfcYA3UVrw5pLZO7mhZQq76dJmCOabUaPxgA>
    <xmx:jeHUaNCTrzOhXS4XiNoyjJZkDgiB6NPf6nzhlX3C-khHSd6qoJxCyg>
    <xmx:jeHUaFxJ-v1ABwNt7u-IpnxIL9EQwIPxOGSGxfwcER4FH8U85nhGqOu4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:30:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6ad6875 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:30:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Sep 2025 08:30:08 +0200
Subject: [PATCH v7 6/9] varint: reimplement as test balloon for Rust
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-b4-pks-rust-breaking-change-v7-6-4e49dcb904d5@pks.im>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
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
2.51.0.618.g983fd99d29.dirty

