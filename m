Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728827B355
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518580; cv=none; b=ugm8ntm9igAcNwA+XIhkm9vCBdzaViQ7UZ5XDyNDhd45RePcclQvAzMez39jqMut0FMDknyBhq66Jnc5AxI5AtRtEeK9AWlTW7Z+so7uLKRwN+ask/rLTNAL+E+aORAyKZID3DdQMq+BpLtNMXvd1wsBIbjx0wjRLKiiLsuMoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518580; c=relaxed/simple;
	bh=55XH5S+MjYID72dXWR4rJ0hsDbHekvgF+x34rWhpn6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfigAPoG24i+DRFVLtwQZoYaF9rw0KI9+9b8HMMchaA9d9MPkfUrpYa6Fgch1eXLX+xfyBm7fnd5Gcc4GAys4b6JJDZnvVGKWlFlyw2xjhp4ssAL2QV2KVLW5ylM1Mj4RSHydXQ9Heo/qVvF2o2Xa3xh8g2x0A0dHA56J+tusGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=clBb1rwo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeH0vcvE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="clBb1rwo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeH0vcvE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6E8514000CE;
	Wed, 10 Sep 2025 11:36:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 11:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518577;
	 x=1757604977; bh=X+/omrTTtfMTIzk2zNTAPcX+qxMObKHeMhDEZbKNlMQ=; b=
	clBb1rwo2VltAq6WHilE+/DGNrZWxJx3aHvcR+J2fAHvVeQevxZ15VblRB7nOQqE
	RRIFTKiWNdfZdoQ9S8ctbIMFxWhHJo59NFWuOPa7lXHfDjaHDkxmFbc0FmCPGg6H
	mX299A2TWSma9i0oPrQPLvEuR5A9/lrLCPj9p/XsQQxBjBFKt6egNqVDmMY/9jA1
	tKO+mR1LoR0niaYfKphPNLJGG/1s3hs9iABNBPLZGx+zyZ5s/wVECuQYWBEAtxeN
	dMvmyjrv1zjE4pkNwKq/ndnBj2HmioQ+74Mjh1njSe3Qtv1T2YB8wgCpgy4BwAhl
	hl5tBCYcz9TnsOZv1JEJuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518577; x=
	1757604977; bh=X+/omrTTtfMTIzk2zNTAPcX+qxMObKHeMhDEZbKNlMQ=; b=P
	eH0vcvECs7/rW6kuI6LcQeNWEczkvhIkYf0+pMiNSxzyAsDf0547gBRJ8IGvr/ID
	YJh1wg2Y1Zhe5yG2sXLg3+QIPovYpNIxKkNP7IApZ8Tyyosy6GyM2XznAtSa5p+a
	YVa1+Zjy6/v2BMDpHaGjXzE8P5aPhksSqJEQFM4DYb0f+n58DR4JCVf+4xe4W5Ir
	NXVe+Hnz1F9VNVIV8kHb+STI9NyNsJlFbg3XLv0lbaiG80XQ0lN62LjZP96cWcrc
	wqZAO5JH5cPSQE8vecQtzKMcfqAGKKo3JBxbCBK3L6Dfyrn1GO8ulGvum6T0QM0b
	I6tqN7b/2FU4c6CjVVlZg==
X-ME-Sender: <xms:8ZrBaNiNoWsw8AZhkI5fsFPSEuPxHm3s5bBj4JXJUwa3k_3oUZTISg>
    <xme:8ZrBaCIGFU9iPACLoZpsxfTFt751g1A3IqGP2OC-ob_-6RuQ9ki4KqiLi3GJ8bGq1
    2gFue9_e7e7Qa4Nag>
X-ME-Received: <xmr:8ZrBaEg9AzprnUHZxqaogWyZSH-C1QiA_LlaGA3YEZxftVaO-G6j8iDHP93TFI0vk3oWyT8eghEhzcHacTtUlkuk4HXWtTR4isXdLRrLSm4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheegjeelgfdugeellefflefhieeuteehfefhvedtfedvtdfhhfekgfehleeggfdtnecu
    ffhomhgrihhnpegrshgpmhhuthgpshhlihgtvgdrrghsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhllhhinhdrfhhunhhk
    udesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprh
    gtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8ZrBaI1nljcXJkJYGJd2H-bC9uTyxeasIZGFKYNnilG-8duB2WbKbA>
    <xmx:8ZrBaCjpdaOmMrHYyohj_5aqqQEqWJOTCFV_SERwgXAqRkIZaEJ3Kw>
    <xmx:8ZrBaB87ub1LkBaDNiTgQx7kwSdJj-HXS9dT_ocDqUC_FTForDFHug>
    <xmx:8ZrBaGJ5Osk4qlj9joA7y3m6CMItowf-Bbz3R3qkk0bHUZxV7nvGQw>
    <xmx:8ZrBaMWqxkmSOzfif9ukC9MT9JVAoRZC67KqtQRkoYL-2WfrQafcQoVW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:36:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54db8445 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:36:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 17:35:52 +0200
Subject: [PATCH RFC v4 6/9] varint: reimplement as test balloon for Rust
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-6-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
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
index 94950a0ffe2..7640d0d76ac 100644
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
index 734de0b4fa9..b19ef4c0b51 100644
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
index 00000000000..10c83e1f439
--- /dev/null
+++ b/src/varint.rs
@@ -0,0 +1,92 @@
+#[no_mangle]
+pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> usize {
+    let mut buf = *bufp;
+    let mut c = *buf;
+    let mut val = usize::from(c & 127);
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
+        val = (val << 7) + usize::from(c & 127);
+    }
+
+    *bufp = buf;
+    val
+}
+
+#[no_mangle]
+pub unsafe extern "C" fn encode_varint(value: usize, buf: *mut u8) -> u8 {
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
2.51.0.450.g87641ccf93.dirty

