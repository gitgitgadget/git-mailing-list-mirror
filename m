Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59921D590
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071825; cv=none; b=nMKrarYOEivTe5AzAZ8iA9LGtciFZjk8LauhXcmcy1tmV5pQKqXJgMeIzAS7hH/9Uv/wHPw5G8Ut2mJDgbs6F8vuEf21LVCTMzds8dmWoyYb1v9LUhgeXjJUUqkb0/SAR/IAkFClBTBhpxES25msGOIjFCq+0hunkoUP8zmFaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071825; c=relaxed/simple;
	bh=jALel+Tr1ErMT5DUeEyP+dxyAISytOqcYYNbm974MbQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tI5zY6dIhfoXjK+K73bnIh8aJ4lk00VrwQHlGNsfUi7aZPd+E7chTfyMJQhFrtekC5FV8Z5VyETGzt3qkAFl+aghr0QAw1ao/Z8vrWi2UMnlej0esuRYqjFyDjg6NjfwMb3YfMKJxZeTSkBirLUUeyP0mhgUXpFe998zIL0LVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5zaA+oS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5zaA+oS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-25669596955so62987435ad.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071822; x=1758676622; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzIr5tZb9UMtqPm/xlPueTcZSPT96gmzFBTenfBjtY8=;
        b=N5zaA+oS+LDH+cgugKPErgRcUjLpNXnIGlwIBOpsqptUKxPit2zB9AgX0Z6GtG7u6/
         ENE8aaNtD54PoFmgzlovfpnxvbQm6KWloGevz6YrlEwxfPZnMvo/ysJCLsU9bWlFgCAO
         aYvpZxFLjcEg8W4I7irBZdbfhhciktNMBCpLIoainzAAxxEkhXmmYmVJiZRx1+iHipzr
         fddOR1qrTE0P9SQDNs3oPAAipPOXSYlpSqXWKtY9dcTqIW20HNyofOcHMO4YTpNbIQJr
         8U4u6gu+B+XMGPYG0ywuQYpfzAm0MqrD9AD/g0McwbddKAKYSG00kgqrkgpH+BEHVCl8
         AERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071822; x=1758676622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzIr5tZb9UMtqPm/xlPueTcZSPT96gmzFBTenfBjtY8=;
        b=RhuB7o1qTsYjQOYBLQ2LTYrYCgYd8IzNyLElZqIA4ZvVL2zAN1yIL7Oqjio+Klr3ku
         xl/8wJddmOsnTRmlhepnDRkN527XKn3SyykJTvz/IMW0J0YMeQa91u23WJ8GtGVgghgi
         C7qXLvJkna4nPtttxcEfRj36Lxwm+LwB9A1yovyso2D5fRTcrMNq04olDsfGn9IomOTf
         LQxOGcMo+JY/322Anmg4jduRkFvDz5BIdO+uczVkKcCpVgrB93X1kNp6CczdDnR0HmDM
         YzWjiO3PNfjBkHwxjRDPH1QISBwglQshKEZfRa/o39FEjZcjPAlPIdU8/VBeQ55af5Pw
         JugA==
X-Gm-Message-State: AOJu0YyUTCLKXwbNlAlA/U3+k4Ra17FuJD305mM7PBsroLftvGpJG0Qw
	6r91uOzRV0a22JxXNPi18KLdDxvKUfJ909OihfoOZTlxNE4iQYR9Gn9xceIXow==
X-Gm-Gg: ASbGncuiuEWdNrpWf1GI5oetPi43QWtWBU8Ct0ttfsqYugG8k0C0/sjr5+Edcbk8+0r
	Zxoq6pD9wJRTd+PCgMan3kunD5fiXyHhmMzR71vSlw1RvpbOrHvklUZFowUKg77iZOwlYiwQJYN
	iF4Wca0m8JUlHa3A99K6QjPFgt9IgOf+9UF/IZ+M/spD6AfDvOclnCs+0e1cK0Esx9caStSFzXv
	bc4xqL9XkXSUQLSFkA/dhyReNyiuBDX1J1eHNdNuTW47UnG/LqVpwvHxQfy24XCNSLadYWtAm4O
	orjVE3KzoRoMtkEHfCPR732HiAQNeFpnhFsknaVDLW+JBEWBvUNuqzHLdYSohbVA52/1Eh0zpgI
	9swQI4YR/LlHNvi/130nj0UePUvU=
X-Google-Smtp-Source: AGHT+IE5uVDvkEXh+UtWgH6kEBEQxb4mbl7SA/LGCizac3zLSFuCgIRKKSqHFY1kjX26o32SlkFAFQ==
X-Received: by 2002:a17:902:e84f:b0:264:f3ed:ee2c with SMTP id d9443c01a7336-268119b2af4mr4417655ad.12.1758071822441;
        Tue, 16 Sep 2025 18:17:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed2772863sm773946a91.28.2025.09.16.18.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:17:01 -0700 (PDT)
Message-Id: <3c521fa2e4bbaf9c6fb7682cd74b398acea350de.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Patrick Steinhardt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:38 +0000
Subject: [PATCH v2 18/18] misc::varint: reimplement as test balloon for Rust
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>

From: Patrick Steinhardt <ps@pks.im>

Implement a trivial test balloon for our Rust build infrastructure by
reimplementing the "varint.c" subsystem in Rust. This subsystem is
chosen because it is trivial to convert and because it doesn't have any
dependencies to other components of Git.

If support for Rust is enabled, we stop compiling "varint.c" and instead
compile and use "src/varint.rs".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile                |  2 +
 meson.build             |  7 +++-
 rust/misc/src/lib.rs    |  1 +
 rust/misc/src/varint.rs | 92 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 rust/misc/src/varint.rs

diff --git a/Makefile b/Makefile
index c363a6365d..9d50f88809 100644
--- a/Makefile
+++ b/Makefile
@@ -1259,7 +1259,9 @@ LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
+ifeq ($(WITH_RUST),false)
 LIB_OBJS += varint.o
+endif
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
diff --git a/meson.build b/meson.build
index 6911625f3b..1b191b12a3 100644
--- a/meson.build
+++ b/meson.build
@@ -571,7 +571,6 @@ libgit_sources = [
   'usage.c',
   'userdiff.c',
   'utf8.c',
-  'varint.c',
   'version.c',
   'versioncmp.c',
   'walker.c',
@@ -591,6 +590,12 @@ libgit_sources = [
   'xdiff/xutils.c',
 ]
 
+if not with_rust
+  libgit_sources += [
+    'varint.c',
+  ]
+endif
+
 libgit_sources += custom_target(
   input: 'command-list.txt',
   output: 'command-list.h',
diff --git a/rust/misc/src/lib.rs b/rust/misc/src/lib.rs
index e69de29bb2..9da70d8b57 100644
--- a/rust/misc/src/lib.rs
+++ b/rust/misc/src/lib.rs
@@ -0,0 +1 @@
+pub mod varint;
diff --git a/rust/misc/src/varint.rs b/rust/misc/src/varint.rs
new file mode 100644
index 0000000000..10c83e1f43
--- /dev/null
+++ b/rust/misc/src/varint.rs
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
gitgitgadget
