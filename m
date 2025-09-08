Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251CB30CDB3
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340819; cv=none; b=ulyZFMlbi5XOO+90F9o0qj6S1eCJdaxxZ82Fqgv0dN6NlJTPZfmpWCp++WMIrxxGfpVK/eH8pTfrZgPQVAg6Ypct85Z9RGQfFHmmOfa0/Z75E7xiw/8xwoZ+BiziI0dzXf2fT+ubvmA9BtaZmigEydnjVu5eTQTP2kQfnY4X0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340819; c=relaxed/simple;
	bh=tuZj+J4Ak3eC9a3vAzwxNC6phk/4qvE0du9buP7eumw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K71jJf397J81C1cp3yPleWAQPGn01hc8NJIxokF9cR709zK/kqDD1DZjGLm4mwggQcO89ckXfMGh14CnGVsl69txTeisBTFxTm6ZTkA8q+uEYvdSxP9ZWe8ObzBx+tEVnStxAFl8zIf+ThGXGJsJkf8KHCjO1jNDrNJsOREWNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E0moej8L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kbqyns+F; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E0moej8L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kbqyns+F"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FAD6EC022D;
	Mon,  8 Sep 2025 10:13:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 08 Sep 2025 10:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757340817;
	 x=1757427217; bh=OdhdYyYDmCOfqiV81r9rLILHacGNnVmZ68TvbQvflzE=; b=
	E0moej8LM6j6Jp4ZfTmxQ7jmE9VOidn7bz/GkB4Ipj15UAOqpGXI3GhmHQ9HDWsc
	l8YDC9oAjGpDhxaFxT9GGqKQdEF3XP3TV+xQOc11b9YWz+6C6NTiFCMaifS1ENn+
	AP71hcL/DbzBMXUkKm8QbL8+IOyMOJaNrQlIkG/PmX4jt1xRx7r5rJVqhUTJZ99B
	55ycWXg/A022dtHYGjIyWxN/YcMMS4KfBPQyBEvtj07L8yQw+7buwKJyHP4ROY+I
	4YOA9A/ihTI8M4eGXQXKSrN0d34SF/kWrLxlPYB7GVLNq7neBFa2SFiwCtXgFVrZ
	14PB6pRsjimtxro+WyBvDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757340817; x=
	1757427217; bh=OdhdYyYDmCOfqiV81r9rLILHacGNnVmZ68TvbQvflzE=; b=k
	bqyns+FqYIcWz4bVU4Eiskk/MY8I6FlIJb9oPZcMZyDb+LAD8n1pc7tOV3kC/lvQ
	LqgSkxkxMaiAgjqaTfwb9BKs4CCyckyzdDXs4h/7OfUVZkNqeZJ1sFXLWITPD6Uw
	DK3aLbtG0Hod3mKfmkU9GaAgYG6iyHNYowpg+jyfRw+bxTasULbuNnJteoXp50sB
	QS93KNzNl3mt4LLlQ0SLdqrsoK+6Au1a9V9Y0czRo7uMH1b6m/6dFj2liAhwDZLx
	U9KIE25kCPXuE0r0jY3LCW//BXZ5msRDl2+dE2WLJCQivIBfSW0Fv9W+37fdqXQX
	1Or3HYJTO0pL19d5IMHdg==
X-ME-Sender: <xms:kOS-aJIbHdqrSosIQ-sHmMFj1fJNkd6Xt3RWy1W2oYfsjUlgrTM9qQ>
    <xme:kOS-aFR6fU7TTpn-0lUhlVD9HE0iE_oNcyXBucoh50bqr0U0TfyIC5e_XCi07Dp5z
    vjmSMBpbPb-9PCZdA>
X-ME-Received: <xmr:kOS-aJKi-UshYjTg_0kkBNIz7ZPxZVe7wQGCFWSt8XUmMeEhCNvFLH7Lfmr8O_qMb-q36Nkjb3DnT4QhvSDHb9QxINPv2ocM8ngXv9V7VewItw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheegjeelgfdugeellefflefhieeuteehfefhvedtfedvtdfhhfekgfehleeggfdtnecu
    ffhomhgrihhnpegrshgpmhhuthgpshhlihgtvgdrrghsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrd
    hmvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghn
    uhgvlhdrphgrthhrhiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtoheptgholhhlih
    hnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:kOS-aA8EuMi7b1eXWWRYnX-LbpVzRPxDzKzu9xKuU2VQnav3AFazvg>
    <xmx:kOS-aIJYOqU5g7wCzthZfrV_YjhnSOytvY-qDTUu8Ubg4cORObzpxw>
    <xmx:kOS-aHGAX63NaqMjPbTio3YlzuCQfuxZ4llCBZWGlvE5I_ogX9ftBA>
    <xmx:kOS-aEyp5TgHhi10oZIlEgn2tkjgdwpaSUcENpRnljZEDXs0nx7Tcw>
    <xmx:keS-aAe3TQsBEw9iAD-oRmkgcCLLO62XblJH-jHfoBIc07MDSeCDyvE1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:13:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6504666a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 14:13:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Sep 2025 16:13:12 +0200
Subject: [PATCH RFC v3 5/8] rust: implement a test balloon via the "varint"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-b4-pks-rust-breaking-change-v3-5-1cd7189fed3b@pks.im>
References: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
In-Reply-To: <20250908-b4-pks-rust-breaking-change-v3-0-1cd7189fed3b@pks.im>
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
 meson.build     |  5 ++-
 src/lib.rs      |  1 +
 src/meson.build |  1 +
 src/varint.rs   | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 104 insertions(+), 1 deletion(-)

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
index 3d6601225ba..48b80cb832c 100644
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
@@ -1716,6 +1715,10 @@ rust_option = get_option('rust').disable_auto_if(not rust_available)
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
index 59e810b4d41..03b71a5c7bd 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,5 +1,6 @@
 libgit_rs_sources = [
   'lib.rs',
+  'varint.rs',
 ]
 
 if meson.version().version_compare('>=1.5.0')
diff --git a/src/varint.rs b/src/varint.rs
new file mode 100644
index 00000000000..7e50cfa09fe
--- /dev/null
+++ b/src/varint.rs
@@ -0,0 +1,95 @@
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
2.51.0.417.g1ba7204a04.dirty

