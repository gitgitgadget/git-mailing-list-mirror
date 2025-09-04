Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD4313557
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996035; cv=none; b=JqcEMnzMvkPAiPZPIi2xIXumnbsAWNIvG72jzogUELilsVVJF3yJ0Ur4IHs03UQTRzRYxmyKcQQS1Q5ss2TRkhTv5g2Vr1VFRWpSpuANOU6muYQLhwowFYmSA6c+bdNUn7h8sPy41oZLaOP9OjtTqgsGbV0l0r8Z7xP4dd8D+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996035; c=relaxed/simple;
	bh=cJ6JqjwFS3TjKAfGm16dLK2i5M33BxnZLzHAoXKpBag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/JZ4rKkwDIbs7QS5TNhjzSwFSxN4wL0oKmD2t9hbiGULip82P4Y2yUNm1G6bbP1sji/hcDAqj43UESQDbWF2+eLKc5UwC5WQQPLGcXA2sICmpmLjRSdDgn3Ykq8ag8EzbgXM4bLcX1SIxeXGcuIdz2SrJ67Uv2hcTnmctc1i7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r3T0D2+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZfiv5Sl; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r3T0D2+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZfiv5Sl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E04151D0028C;
	Thu,  4 Sep 2025 10:27:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 04 Sep 2025 10:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996032;
	 x=1757082432; bh=SmMunoq7ofplMQvPUxg37VqwoV8nT8ohuZ/4exww620=; b=
	r3T0D2+5ZXVwF9KKMNGy1glyLHsf/aD9HV5wyLe7c3wjdW+dHIj+hcDy1GuPYURT
	oZRzcgTMFK8pOjaokXNlVnXKrrBYJBg1kPZ57v0R+kyrJd1sMcbtWf/nE0GYzweq
	uCnmtBnXCkrr60SBJ/5W081Q4pPGKD/NZfFUMTaf4FuUSNbzECxHCsdlOBGLwCwD
	qI9sCD0wkcWbHUz+UPMcARDMg1W81P+WNVbCwyleOo0uOFKOGnhURETg3TiCOp/V
	aC+QFh1D3aOMvMMI8dYGie3e2w/NZ5/ZfwoJSex8zfhCrwx4XmOtMBqDu+HZgGHg
	brUfIFWbP9AwFI7MmoZVaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996032; x=
	1757082432; bh=SmMunoq7ofplMQvPUxg37VqwoV8nT8ohuZ/4exww620=; b=Z
	Zfiv5Sl86aN+W/hKGvLMkIL1kXub/QcOi45HrwyacVyV7k8wcmdCUlIGdByjHp0X
	VSC3DIpq8R/7WQdvdiTSdPV78lpeFtVrZXhFklyo3VPtZnlheVkY+T7IhvO7mh5y
	iJ7iNHepCaiLdIIZj/ZDSjbAMwOj9TTYLNlk/36upjYbRTJaiOLa0iaDCU6uCea2
	IjoUvwjJRVxzEad7jCrZYrOdPx9awTLqeIpS1Wa34nhO7BGLIVPpPs4BKoMcP0Dt
	ZvxQW54lrkjXCzNsgIuZIfLtU1sz1mqn8GLfHS7uyE9zy7atqdb1p0Pzc3+xOtLp
	AJel7pwTSUTFTSDjtMRoA==
X-ME-Sender: <xms:wKG5aF8poDmXvF0G69Nb2gsjvze9D7vwLHLaBjYBgd9g4f0mIKaSqw>
    <xme:wKG5aJ2IrDZtunYd3ZdVHJWeQheP3zPC2BfFplGWtSYAqalrUcykR1cN0qc1gDqiF
    DyqRIEfE-HzGahuEQ>
X-ME-Received: <xmr:wKG5aKdNJOhRMpgLl-tmT5olom97dkSVmWsihIndcl7dv8emKqjJgdjbKGc1uxFrELVEPtCa7GFHefEg9_Vkkox75obXb8dFTGAAQ49kKK9QIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehgeejlefgudegleelffelhfeiueetheefhfevtdefvddthffhkefgheelgefgtdenucff
    ohhmrghinheprghspghmuhhtpghslhhitggvrdgrshenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghonhhtrggttheshh
    grtghkthhivhhishdrmhgvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthht
    ohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtoh
    hmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghmsehgvghnth
    hoohdrohhrghdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:wKG5aAC684kpOMIVgrpeHUzTIbdMTePRnlIp523iMBEm6188RDa9CQ>
    <xmx:wKG5aB9WSUlnWC014t61f7JGkhO6wjbC3N0bDXYxpESXBnNJ2x55BQ>
    <xmx:wKG5aEqKWPK_3EHnORnkQmAOK1P_fpJURckMLCAwN7Y2aAXT2jSiOQ>
    <xmx:wKG5aLHQ05e1DIRmnVRsMJ2qjVP1Yi8FoCMcVEs2Cmtuv2E0cYmLgQ>
    <xmx:wKG5aNgudxWHkvv1-ufao-qPSqR9bIbphpRJ1OdDWfg1zEyZdCdRRNJJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba60049b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:26:44 +0200
Subject: [PATCH RFC 2/3] rust: implement a test balloon via the "varint"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
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
 meson.build     |  5 +++-
 src/lib.rs      |  1 +
 src/meson.build |  1 +
 src/varint.rs   | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1c0e98bbc14..b52a68b0bb6 100644
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
@@ -1713,6 +1712,10 @@ rust_option = get_option('rust').disable_auto_if(not rust_available)
 
 if rust_option.allowed() and meson.version().version_compare('>=1.9.0')
   subdir('src')
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
index 2bd2045a8ab..b3164fb5ed4 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -3,6 +3,7 @@ rustmod = import('rust')
 libgit_rs = static_library('git_rs',
   sources: [
     'lib.rs',
+    'varint.rs',
   ],
   rust_abi: 'c',
 )
diff --git a/src/varint.rs b/src/varint.rs
new file mode 100644
index 00000000000..3d41760a555
--- /dev/null
+++ b/src/varint.rs
@@ -0,0 +1,92 @@
+use std::os::raw::c_int;
+use std::os::raw::c_uchar;
+
+#[no_mangle]
+pub unsafe extern "C" fn decode_varint(bufp: *mut *const c_uchar) -> usize {
+    let mut buf = *bufp;
+    let mut c = *buf;
+    let mut val = usize::from(c & 127);
+
+    buf = buf.add(1);
+
+    while (c & 128) != 0 {
+        val += 1;
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
+pub unsafe extern "C" fn encode_varint(value: usize, buf: *mut c_uchar) -> c_int {
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
+    (varint.len() - pos) as c_int
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
2.51.0.417.g1ba7204a04.dirty

