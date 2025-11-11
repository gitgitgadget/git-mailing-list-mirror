Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D8329E7E
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890158; cv=none; b=sAQ+zHQNtajbevzYIFvFDmsON2YH9EnYcfICYsfMraDvhkTjPP7cOJ3mKkhGuSx6Sd+l0gdFEYpc92EVaUeFXq33fH2vuZJB1D5FL2dEETHOvWvXbTFnzlaHcBN7ukyRfcRBvEjzxa+DqwqCl7nLCVkHeQUKSoHHcIwlRehcSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890158; c=relaxed/simple;
	bh=m0KmGHzK/+0gxMswnXmXweZbRupU/HQodwf4b6LZ4SU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I3pAbY9H2RS5TNniQHt4tjcVDCWml7mJU1nV13myOpMLh6OKJwdeGr2gziRmZmN4HEMwcBGkoZeRFvpo43yES57GWPQ9Wm1qXZeNMrL+xn4Rz9nGN9thD4bzJY0q/2U7o2WzrPmZpIKAIzna5HqABRTnN24n449If5Yr0ppI5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niYm7sm7; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niYm7sm7"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88267973e5cso473776d6.3
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890155; x=1763494955; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYPnR8awitMB4YjhLWB5BMkTHZUuUJGamie9k96V6hE=;
        b=niYm7sm75B37aI5z0OQZhPeTBP5CJLAE3HGhG4cBcJckyKtsirIOBF45YwVkGTlMP3
         HnzpFleLgMjt9AC0gpmt/5shXJAsMXvUuE1QnZXV0ncv+Qb7nFS1aNBpNkrr9sghZj0f
         zVG0lHOSz2XD9FxkzVrvut9Z9Bhnme6604vKLsRePNz8m1zVTkTbXgU547R599onLOB2
         R4OuQBA+YkTf74iYmFiFGc/rEetAGuvb4ZaGO56nSzWFEki84iSOiaesjFojz+jfSdCE
         QVT4qM+byj7ua+YanL7MYAbQtZD3SzFie3VrNq1q2yK8bMBtA6QzK14zJsON3mSnbZoG
         CUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890155; x=1763494955;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZYPnR8awitMB4YjhLWB5BMkTHZUuUJGamie9k96V6hE=;
        b=RwRqbZXa5kZG6ATAe5RSnpISnDp/83Ex/LEPhGr5Exe4AkUI166n2GOuJdcyELvOv0
         ZJPMoC9gooDn1DfPI4jfPNXSCACvAOvmEjo9TzZWqD1wlx3hXU+04iliZwAXWquvVATc
         GLCO4wE8URfZY/vpWA6GA5dL6BaCbZVVb6esRshF6eCqG8an4uZSh6LeYfYXZSTZneWT
         4RbQl7e7KMvMQBlefo5Y4ukpazwq5O7L6ldDYs0GNjEHJQY8EpPp56O/0LAFGFMpk554
         fm7K0jnrEY3WHCrtV/UF9xUjMXM18kw4wTczmr9Zjcrt4XAROvhS7Clusu7kkGfUSwey
         Qz9Q==
X-Gm-Message-State: AOJu0YzlPZfGgHCbpFXmWGurvD7ixo5Vih3184oZfgzzXSJgVefeoFte
	1vh4AKZo4hb4GDgrNqUEi7NvTzjkP8pcEbgywN/7FhihA2u5tpxArIYPO9Jr9A==
X-Gm-Gg: ASbGncuXO7NZrY8utcHh9esLiPIX3/FQ1NqPa+K9jCvfJXlwGQWX5FIvWa9YwWHvCYQ
	AaWX4uWX6wDXXRztJoOi9BXLUPu1mTW0lYyAzyT/EeoVyFAIKl3STJvZF5pbUxu53FfNMzpzf0b
	49Z5kR0qvjoZEnoxpEa+DF4chhGDqnu05X+QNnD44fkcmzYifQC+gy/FLjVxUktHpXuogWGX6x8
	Wkt94VlsMhRzw6gaflKfgIKZTb6tETCPq9blbzDNQSuoRDOu6UKE7Xf8IeIhnuOuMfagZLrHC0/
	msEirbU/ZMOnxLET5ZKgGmUKInoRf2Keq1KkSUjfWzzLZSBjpJJ90K2/CR3UFp4bmOXybfLQ+7G
	CQyBl/f4VXQbfTsIRnQAYdO7QwTJ1+kbLC5rseKoWOs7eqImdqxFKHFKT6jcmh/VUBEDJ4bBDGo
	ESl86AjTdd9N2v1A==
X-Google-Smtp-Source: AGHT+IFCr8cbHyl2dJV8U53tFvBddOnsHokmMSkg3xHVrLqI7w4hY4wmN9HqnRABvqZmgwIaVGDFYg==
X-Received: by 2002:a05:6214:2602:b0:879:6db9:148d with SMTP id 6a1803df08f44-8827191f32cmr8159536d6.27.1762890155140;
        Tue, 11 Nov 2025 11:42:35 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b8520bsm77677006d6.50.2025.11.11.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:42:34 -0800 (PST)
Message-Id: <e5d084d340e874be52e7c3b056ada15ab5557877.1762890152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 19:42:23 +0000
Subject: [PATCH v3 01/10] doc: define unambiguous type mappings across C and
 Rust
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
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Document other nuances with crossing the FFI boundary. Other language
mappings may be added in the future.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/meson.build           |   1 +
 .../technical/unambiguous-types.adoc          | 239 ++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 Documentation/technical/unambiguous-types.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 04e9e10b27..bc1adb2d9d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -142,6 +142,7 @@ TECH_DOCS += technical/shallow
 TECH_DOCS += technical/sparse-checkout
 TECH_DOCS += technical/sparse-index
 TECH_DOCS += technical/trivial-merge
+TECH_DOCS += technical/unambiguous-types
 TECH_DOCS += technical/unit-tests
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index be698ef22a..89a6e26821 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -32,6 +32,7 @@ articles = [
   'sparse-checkout.adoc',
   'sparse-index.adoc',
   'trivial-merge.adoc',
+  'unambiguous-types.adoc',
   'unit-tests.adoc',
 ]
 
diff --git a/Documentation/technical/unambiguous-types.adoc b/Documentation/technical/unambiguous-types.adoc
new file mode 100644
index 0000000000..6bca39209b
--- /dev/null
+++ b/Documentation/technical/unambiguous-types.adoc
@@ -0,0 +1,239 @@
+= Unambiguous types
+
+Most of these mappings are obvious, but there are some nuances and gotchas with
+Rust FFI (Foreign Function Interface).
+
+This document defines clear, one-to-one mappings between primitive types in C,
+Rust (and possible other languages in the future). Its purpose is to eliminate
+ambiguity in type widths, signedness, and binary representation across
+platforms and languages.
+
+For Git, the only header required to use these unambiguous types in C is
+`git-compat-util.h`.
+
+== Boolean types
+[cols="1,1", options="header"]
+|===
+| C Type | Rust Type
+| bool^1^       | bool
+|===
+
+== Integer types
+
+In C, `<stdint.h>` (or an equivalent) must be included.
+
+[cols="1,1", options="header"]
+|===
+| C Type | Rust Type
+| uint8_t    | u8
+| uint16_t   | u16
+| uint32_t   | u32
+| uint64_t   | u64
+
+| int8_t     | i8
+| int16_t    | i16
+| int32_t    | i32
+| int64_t    | i64
+|===
+
+== Floating-point types
+
+Rust requires IEEE-754 semantics.
+In C, that is typically true, but not guaranteed by the standard.
+
+[cols="1,1", options="header"]
+|===
+| C Type | Rust Type
+| float^2^      | f32
+| double^2^     | f64
+|===
+
+== Size types
+
+These types represent pointer-sized integers and are typically defined in
+`<stddef.h>` or an equivalent header.
+
+Size types should be used any time pointer arithmetic is performed e.g.
+indexing an array, describing the number of elements in memory, etc...
+
+[cols="1,1", options="header"]
+|===
+| C Type | Rust Type
+| size_t^3^     | usize
+| ptrdiff_t^3^  | isize
+|===
+
+== Character types
+
+This is where C and Rust don't have a clean one-to-one mapping.
+
+C comparison problem: While the sign of `char` is implementation defined, it's
+also signless (neither signed nor unsigned). When building with
+`make DEVELOPER=1` it will complain about a "differ in signedness" when `char`
+is compared with `uint8_t` or `int8_t`.
+
+Rust's `char` type is an unsigned 32-bit integer that is used to describe
+Unicode code points. Even though a C `char` is the same width as `u8`, `char`
+should be converted to u8 where it is describing bytes in memory. If a C
+`char` is not describing bytes, then it should be converted to a more accurate
+unambiguous type. The reason for mentioning Unicode here is because of how &str
+is defined in Rust and how to create a &str from &[u8]. Rust assumes that &str
+is a correctly encoded utf-8 string, i.e. text in memory. Where as a C `char`
+makes no assumption about the bytes that it is representing.
+
+```
+let raw_bytes = b"abc\n";
+let result = std::str::from_utf8(raw_bytes);
+if let Ok(line) = result {
+    // do something with text
+}
+```
+
+While you could specify `char` in the C code and `u8` in Rust code, it's not as
+clear what the appropriate type is, but it would work across the FFI boundary.
+However, the bigger problem comes from code generation tools like cbindgen and
+bindgen. When cbindgen sees u8 in Rust it will generate uint8_t on the C side
+which will cause differ in signedness warnings/errors. Similarly if bindgen
+sees `char` on the C side it will generate `std::ffi::c_char` which has its own
+problems.
+
+=== Notes
+^1^ This is only true if stdbool.h (or equivalent) is used. +
+^2^ C does not enforce IEEE-754 compatibility, but Rust expects it. If the
+platform/arch for C does not follow IEEE-754 then this equivalence does not
+hold. Also, it's assumed that `float` is 32 bits and `double` is 64, but
+there may be a strange platform/arch where even this isn't true. +
+^3^ C also defines uintptr_t, ssize_t and intptr_t, but these types are
+discouraged for FFI purposes. For functions like `read()` and `write()` ssize_t
+should be cast to a different, and unambiguous, type before being passed over
+the FFI boundary. +
+
+== Problems with std::ffi::c_* types in Rust
+TL;DR: In practice, Rust's `c_*` types aren't guaranteed to match C types for
+all possible C compilers, platforms, or architectures, because Rust only
+ensures correctness of C types on officially supported targets. These
+definitions have changed over time to match more targets which means that the
+c_* definitions will differ based on which Rust version Git chooses to use.
+
+Current list of safe, Rust side, FFI types in Git: +
+
+* `c_void`
+* `CStr`
+* `CString`
+
+Even then, they should be used sparingly, and only where the semantics match
+exactly.
+
+The std::os::raw::c_* directly inherits the problems of core::ffi, which
+changes over time and seems to make a best guess at the correct definition for
+a given platform/target. This probably isn't a problem for all other platforms
+that Rust supports currently, but can anyone say that Rust got it right for all
+C compilers of all platforms/targets?
+
+To give an example: c_long is defined in
+footnote:[https://doc.rust-lang.org/1.63.0/src/core/ffi/mod.rs.html#175-189[c_long in 1.63.0]]
+footnote:[https://doc.rust-lang.org/1.89.0/src/core/ffi/primitives.rs.html#135-151[c_long in 1.89.0]]
+
+=== Rust version 1.63.0
+
+```
+mod c_long_definition {
+    cfg_if! {
+        if #[cfg(all(target_pointer_width = "64", not(windows)))] {
+            pub type c_long = i64;
+            pub type NonZero_c_long = crate::num::NonZeroI64;
+            pub type c_ulong = u64;
+            pub type NonZero_c_ulong = crate::num::NonZeroU64;
+        } else {
+            // The minimal size of `long` in the C standard is 32 bits
+            pub type c_long = i32;
+            pub type NonZero_c_long = crate::num::NonZeroI32;
+            pub type c_ulong = u32;
+            pub type NonZero_c_ulong = crate::num::NonZeroU32;
+        }
+    }
+}
+```
+
+=== Rust version 1.89.0
+
+```
+mod c_long_definition {
+    crate::cfg_select! {
+        any(
+            all(target_pointer_width = "64", not(windows)),
+            // wasm32 Linux ABI uses 64-bit long
+            all(target_arch = "wasm32", target_os = "linux")
+        ) => {
+            pub(super) type c_long = i64;
+            pub(super) type c_ulong = u64;
+        }
+        _ => {
+            // The minimal size of `long` in the C standard is 32 bits
+            pub(super) type c_long = i32;
+            pub(super) type c_ulong = u32;
+        }
+    }
+}
+```
+
+Even for the cases where C types are correctly mapped to Rust types via
+std::ffi::c_* there are still problems. Let's take c_char for example. On some
+platforms it's u8 on others it's i8.
+
+=== Subtraction underflow in debug mode
+
+The following code will panic in debug on platforms that define c_char as u8,
+but won't if it's an i8.
+
+```
+let mut x: std::ffi::c_char = 0;
+x -= 1;
+```
+
+=== Inconsistent shift behavior
+
+`x` will be 0xC0 for platforms that use i8, but will be 0x40 where it's u8.
+
+```
+let mut x: std::ffi::c_char = 0x80;
+x >>= 1;
+```
+
+=== Equality fails to compile on some platforms
+
+The following will not compile on platforms that define c_char as i8, but will
+if it's u8. You can cast x e.g. `assert_eq!(x as u8, b'a');`, but then you get
+a warning on platforms that use u8 and a clean compilation where i8 is used.
+
+```
+let mut x: std::ffi::c_char = 0x61;
+assert_eq!(x, b'a');
+```
+
+== Enum types
+Rust enum types should not be used as FFI types. Rust enum types are more like
+C union types than C enum's. For something like:
+
+```
+#[repr(C, u8)]
+enum Fruit {
+    Apple,
+    Banana,
+    Cherry,
+}
+```
+
+It's easy enough to make sure the Rust enum matches what C would expect, but a
+more complex type like.
+
+```
+enum HashResult {
+    SHA1([u8; 20]),
+    SHA256([u8; 32]),
+}
+```
+
+The Rust compiler has to add a discriminant to the enum to distinguish between
+the variants. The width, location, and values for that discriminant is up to
+the Rust compiler and is not ABI stable.
-- 
gitgitgadget

