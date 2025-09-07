Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CC329E115
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274337; cv=none; b=s2ngGyC8WniFOSiyDcQzSB6j6ur0PepVNnpmnArVEIkg/AmQyZNNkPr5txYDbgmz1IWcZYP7+ikUF2juGwwnsm1zw6Iy15DrGh6b2j+wxzMVgx50xM7RiWmfbsm9XXID/5r0EwkhJhpeR5bVVo+s+YbPk2SnddDK4MgIvsZKGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274337; c=relaxed/simple;
	bh=45fwoU6ZzCRKrA4Y1m9Z5hfC6xUvMPu5EyLR1loZCEw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NSsAYkIaLvJOInI+mKdDGVnpaUuN3Fu+Zja9mAbijVsZDhUD32X6d1OcKgkv3ZfNuFZ5ciPBv/8HvoG+rtMcAZDf75x48iV9mTBZPxhZMjunwPQMMRy48clJSjX6ni95yyl5bRIAlkJfo6djBk2//wxA+HyYvWCs2Hd8Mhdu2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4W+v5w5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4W+v5w5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f722cb35fdso317004885a.3
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274334; x=1757879134; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+48tATkaDFeXaHSeY1ouWvOtv7eSX+sXV67s46QBG0=;
        b=A4W+v5w5kT6Zx4wxgd99oegBP6n6CAm+N1hnsAkQD+U/Yk5pdn1Fedr55IwutZ08V/
         95SqhjPtszw5IZNDSmFUtfTjIsssAv7tvc4aIyzQQTnI8kcxiWriQ532iswLmXwhEjoL
         ZPfhiW15OX1tqmArcWShoZC9WD4TLCWNEozkH2KP+TWF7KojoawzqD/88hcbZwgkZWoQ
         qzeBBIPubk0RmDWtlJpNoxOCfY5cMuBai3THeACbcrUz7SITTOuQdwT3c4KMfOEK+PmW
         VcMY43IuIfhCO7s0h0fQ7oBp8d7cHQUCPJ5MgVnblft2NXSg5ntOI/U2u6qzgc0zHUr2
         +/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274334; x=1757879134;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+48tATkaDFeXaHSeY1ouWvOtv7eSX+sXV67s46QBG0=;
        b=D+N9rYn9mt8nq3M4d7Ss7yHiHuOlMY7euQQQ1jOnpNrykonc7tZ3JqiVqvP9esvp61
         nFBcUO3O1j+hTiySSV1ZePwKwtewnVKi0GF9oUaSJSR3l69/zu8iUxx1PW+btV6TUUVc
         jnKamUOIDrDU628YIy3Uncq7lHdhlt8MK9RXoA2eFqefDWji0IFL+lVPYTqXqfW+mllT
         hjZnhMXJAsPbvOwrWv7ANenIW5o7HDC4wHb+00M50zVNVcjddgjYynlOzm1zrOZB7gnw
         JycX6O0bQMxm1db9N8A9t9hbpN8u0P/d03Z2EjPrxBFcC/UevmTWU4QW0YnW5Af0HFxo
         jsqg==
X-Gm-Message-State: AOJu0YyDPO8P41+HUP8nuEKtpB/8IAHhdt3k7TduvpM+fkfa8z2/dxrT
	0Niid+3oeErLihaxuz2bOYtXIuf8Jjv3olGiBJEmTWoS7CBn3pLQ3QvDNM377GF6
X-Gm-Gg: ASbGncvfE6z6MlesvojAyhE635HOPDvEIrk2I1G3pgI/Dwm6XTsPohwP8zTyhzPjuVK
	Q0LGB4c9dWcF3GQRCtG9xZeZMasHVmyzKTuwUSg027rq2ySBjOcechq5FXD6X91zz7AH5PMuyYH
	s8DhL11ZC7RckZjhjSyVeDVxPUmCaQsUNH8fQE+R0mXOq/OkgRmJ1ygPQxLSGnWw83jST0D2Bi9
	LD1THOPILA4BcVrD9+J3m8IPBpgWh9qIacAri8wBtKZK0mr6UXmPNurHUbv0eHbHD0nUmKBn6Ws
	328vRkVSgMXUrhs/HH3eUfd82h0fmvom3HSLZZNABQ/CP5jJxIpbZVWrxu3xpQDTshueito6/V4
	NsRyh687jMA8TV/MIRbHHgO0=
X-Google-Smtp-Source: AGHT+IHaQYtPe2qjvYhbzjPFcfqXkl56MJdf2BsT3WEox4e42vK4LoU342tpDejsnRJ8kKKPEIIo0w==
X-Received: by 2002:a05:620a:3189:b0:812:f1e3:44fc with SMTP id af79cd13be357-813c26488c7mr501080585a.47.1757274334136;
        Sun, 07 Sep 2025 12:45:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aab3b772bsm886103385a.51.2025.09.07.12.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:32 -0700 (PDT)
Message-Id: <2a7d5b05c18d4a96f1905b7043d47c62d367cd2a.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:13 +0000
Subject: [PATCH 10/17] compat/rust_types.h: define rust primitive types
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
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Why Rust primitive types should be used in C:
  * Consistency across languages: Sharing the same type names makes it
    easier to translate and refactor code across boundaries, and search
    history.
  * Clarity and ergonomics: The types f32 and f64 are clearer than
    float and double. The types u64 or isize are easier to write than
    uint64_t, or ptrdiff_t.
  * Explicit intent: Inclusion of compat/rust_types.h signals other
    readers that the code is designed, or being cleaned up, for Rust
    interop.
  * Character types: Rust's char is defined as an unsigned 32-bit type.
    In contrast, C's char is an 8-bit type that is neither signed nor
    unsigned. The u8 type should be used instead of C's char when
    referring to bytes in memory.
  * Keep the FFI boundary precise: When Rust calls into C, the C
    interface should use Rust types exclusively in both functions and
    structs. If a broad refactor would cause too much churn, C stub
    functions may be used as an interim step.

Reasons to avoid c_* types (e.g. c_char, c_long) in Rust:
  * Rust remains precise: Bringing c_* into Rust reintroduces the very
    ambiguity Rust was designed to eliminate. Using only Rust
    primitives keeps our code portable and predictable.
  * One clear contract: Rust should define the interface with precise
    types. C adapts through compat/rust_types.h, ensuring the boundary
    is consistent and easy to audit.
  * Future-proof interop: Other runtimes (Python, Go, Java, Wasm, etc.)
    map cleanly onto Rust's primitives, but not onto c_*. Sticking with
    Rust types makes bindings straightforward and avoids locking Git's
    ABI to C's historical quirks.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 compat/rust_types.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 compat/rust_types.h

diff --git a/compat/rust_types.h b/compat/rust_types.h
new file mode 100644
index 0000000000..af93d0a116
--- /dev/null
+++ b/compat/rust_types.h
@@ -0,0 +1,28 @@
+#ifndef COMPAT_RUST_TYPES_H
+#define COMPAT_RUST_TYPES_H
+
+#include <compat/posix.h>
+
+/*
+ * A typedef for bool is not needed because C bool and Rust bool are
+ * the same if #include <stdbool.h> is used.
+ */
+
+typedef uint8_t   u8;
+typedef uint16_t  u16;
+typedef uint32_t  u32;
+typedef uint64_t  u64;
+
+typedef int8_t    i8;
+typedef int16_t   i16;
+typedef int32_t   i32;
+typedef int64_t   i64;
+
+typedef float     f32;
+typedef double    f64;
+
+typedef size_t    usize;
+typedef ptrdiff_t isize;
+typedef uint32_t  rust_char;
+
+#endif /* COMPAT_RUST_TYPES_H */
-- 
gitgitgadget

