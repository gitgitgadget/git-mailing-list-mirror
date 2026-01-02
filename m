Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37126ED45
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379950; cv=none; b=sgaCiEMXBx/3WBOhr+8jn+ib1J/H4WYXYjtvmaX+mWsSXQH1cV6/CJpPJnH+FlPdUhSQYsguMtJ5tAu85Bu5vIBT3Es9gIJutWfGwZeZsWm0LwnVTBFq7D+/QST/ve3VWv+Aytl0YGdjP8NRbGtLktpKaEP40vtF560Y8QraK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379950; c=relaxed/simple;
	bh=MWwpfV/IMJpFD5rbzkIRkACU5+/5yZ/XZT3en8gpIdM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jgjlfUZTi4aADiWGcVZYfrXA0TMVbTQ1OqkKBY8yiZ2GLVGG8EZ1PebOmQrE88bSbY7Bpo+yHtW9c4GW4nz6RGredcQ4goNLHLxM/fKuSqxJnEn5xO8ywN/Xhtt3l+P2ShtYR67gIt8fZ1gyGUKMLoJiT6XDTOppilU1EIkYPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEg3R1lK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEg3R1lK"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so13006476a12.0
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 10:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767379947; x=1767984747; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3kcaaN1sYG9d+VxtFOYriA6BCsC9Z6qfbmJQk8wJro=;
        b=hEg3R1lK6QIy81Rwa/j3BbhiiK1cUDlSDtu84bN4axEgWbGuX55ecrXf01F7OoEU2a
         ofD+ub0RhxJc1VLoquRqVpcPb3278tbo3Vo/FxE7m8COVD5AuvG8IT6WzoHRQICoUe6T
         00pC7x5ksqJh4PiUph7Z5Oao129xHQpMer3cEjiPtt8vZn5BYH89NzaJUm9sl3Nd1dKz
         Qma4SxPFjjrogwQcISbxjHPZmqRSGa94dWmhFZpSqj9MS3ry8XN4yVzAK4hRTptMfefE
         Y5LDZR0sMmBHVB8PO2qi9sh6cAowAcHriZinNFfkKEALv02ruw+2XwZ0Ni4mAK5sWc4/
         2b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379947; x=1767984747;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3kcaaN1sYG9d+VxtFOYriA6BCsC9Z6qfbmJQk8wJro=;
        b=RrPKM33C/rZg/Wm8Fi3vIt8bBQcuypZ0k2zme1NXaRELJGrWG2Yrw+uCwD90we2F1D
         kem+O6hliIc0dDzEwORRchenuCwwdkKNM7/jH906VrIfnyM2h4FrxFsMGyTQnFKj341L
         A74EHUrbFxyviVdOBejBZ0AkeSkRbuLkXwkcrIGRWdxbbmCYJ87nUF1RSEtzQEu4l+gS
         olTLfhDwqktXL3rGFdqbdO/Z2lqNQo5hKj7E/ntxbIkItmo/dgtUZCWxFqyJq7s1i7i9
         Rq553sLucOXeYGLKdtSyId1HBju+/HQlAPfdJJu5bcAlyMXbxx6ukMbtU9CA8stLhtdM
         0Ejg==
X-Gm-Message-State: AOJu0YxLdtNEE8vGxDvkItYCmNuWh0btp5BZGfljFo6+0T7uGs3/CGSf
	RhPVw/bsrPENvBC2YSzBpYWJL+w77q7v2bJSHKHiluzHWjMIAaIXBq6WbM+Ifw==
X-Gm-Gg: AY/fxX6WNPM07GD6qMp0/S1RI5Gjk234A86e6MZRZJEta2lbMQl15SzJteXZ3Jh/JAo
	fD7ePDzjCFH82OPVKAfpp4HDFMj8WAPKDw+4XJ9Qe4i7UHVYTIvofnMRXBtu58vv5QQXjIMVuP2
	rvqFhEa0qj0dTyxyIsD4Uy0ETvgrkX8D3El12usXoM2vqJPFAmTTUxmmCDJsFU/tr2z4IU7tXNy
	ufcXSTNW+P51TdtETtQXIBP+rfUgT20XOk+geNF69XCFoGZKTFjEHO5ZqB7DBvkf7DXXQQBbp/Y
	gT6b7ppUN50PEPahCxYXkUoaVvPYPK6MXVkxPa0wc7p+WR0KFo/50Rc+rq5h7uKaUrhIL2MhGJm
	YiXPSBvb0ZF4J9+AMcRwloq1EuZX2YpXGWS+AeVfnBFMGtNuCf26eznxT1rREh8xKDW7qP3NHVH
	mNb8bMY20Ik04ssA==
X-Google-Smtp-Source: AGHT+IEl+DUQGj9MXrQqJo9MVyOEYaoHvEvD6U5bgMdOs2qvA/7pf7wz4/cFby3YQ5gYMbUzaLf7tw==
X-Received: by 2002:a05:693c:2503:b0:2ae:5ee8:b774 with SMTP id 5a478bee46e88-2b05ebd8d59mr32325396eec.9.1767379946998;
        Fri, 02 Jan 2026 10:52:26 -0800 (PST)
Received: from [127.0.0.1] ([57.151.128.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e96sm1736072eec.14.2026.01.02.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:52:26 -0800 (PST)
Message-Id: <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 18:52:15 +0000
Subject: [PATCH 01/10] ivec: introduce the C side of ivec
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

Trying to use Rust's Vec in C, or git's ALLOC_GROW() macros (via
wrapper functions) in Rust is painful because:

  * C doesn't define its own vector type, and even though Rust does
    have Vec its painful to use on the C side (more on that below).
    However its still not viable to use Rust's Vec type because Git
    needs to be able to compile without Rust. So ivec was created
    expressley to be interoperable between C and Rust without needing
    Rust.
  * C doing vector things the Rust way would require wrapper functions,
    and Rust doing vector things the C way would require wrapper
    functions, so ivec was created to ensure a consistent contract
    between the 2 languages for how to manipulate a vector.
  * Currently, Rust defines its own 'Vec' type that is generic, but its
    memory allocator and struct layout weren't designed for
    interoperability with C (or any language for that matter), meaning
    that the C side cannot push to or expand a 'Vec' without defining
    wrapper functions in Rust that C can call. Without special care,
    the two languages might use different allocators (malloc/free on
    the C side, and possibly something else in Rust), which would make
    it difficult for a function in one language to free elements
    allocated by a call from a function in the other language.
  * Similarly, git defines ALLOC_GROW() and related macros in
    git-compat-util.h. While we could add functions allowing Rust to
    invoke something similar to those macros, passing three variables
    (pointer, length, allocated_size) instead of a single variable
    (vector) across the language boundary requires more cognitive
    overhead for readers to keep track of and makes it easier to make
    mistakes. Further, for low-level components that we want to
    eventually convert to pure Rust, such triplets would feel very out
    of place.

To address these issue, introduce a new type, ivec -- short for
interoperable vector. (We refer to it as 'ivec' generally, though on
the Rust side the struct is called IVec to match Rust style.)  This new
type is specifically designed for FFI purposes, so that both languages
handle the vector in the same way, though it could be used on either
side independently. This type is designed such that it can easily be
replaced by a Rust 'Vec' once interoperability is no longer a concern.

One particular item to note is that Git's macros to handle vec
operations infer the amount that a vec needs to grow from the size of
a pointer, but that makes it somewhat specific to the macros used in C.
To avoid defining every ivec function as a macro I opted to also
include an element_size field that allows concrete functions like
push() to know how much to grow the memory. This element_size also
helps in verifying that the ivec is correct when passing from C to
Rust.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile      |   1 +
 compat/ivec.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/ivec.h |  52 +++++++++++++++++++++++
 meson.build   |   1 +
 4 files changed, 167 insertions(+)
 create mode 100644 compat/ivec.c
 create mode 100644 compat/ivec.h

diff --git a/Makefile b/Makefile
index 89d8d73ec0..f923b307d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1107,6 +1107,7 @@ LIB_OBJS += commit-reach.o
 LIB_OBJS += commit.o
 LIB_OBJS += common-exit.o
 LIB_OBJS += common-init.o
+LIB_OBJS += compat/ivec.o
 LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/open.o
diff --git a/compat/ivec.c b/compat/ivec.c
new file mode 100644
index 0000000000..0a777e78dc
--- /dev/null
+++ b/compat/ivec.c
@@ -0,0 +1,113 @@
+#include "ivec.h"
+
+struct IVec_c_void {
+	void *ptr;
+	size_t length;
+	size_t capacity;
+	size_t element_size;
+};
+
+static void _set_capacity(void *self_, size_t new_capacity)
+{
+	struct IVec_c_void *self = self_;
+
+	if (new_capacity == self->capacity) {
+		return;
+	}
+	if (new_capacity == 0) {
+		free(self->ptr);
+		self->ptr = NULL;
+	} else {
+		self->ptr = realloc(self->ptr, new_capacity * self->element_size);
+	}
+	self->capacity = new_capacity;
+}
+
+
+void ivec_init(void *self_, size_t element_size)
+{
+	struct IVec_c_void *self = self_;
+
+	self->ptr = NULL;
+	self->length = 0;
+	self->capacity = 0;
+	self->element_size = element_size;
+}
+
+void ivec_zero(void *self_, size_t capacity)
+{
+	struct IVec_c_void *self = self_;
+
+	self->ptr = calloc(capacity, self->element_size);
+	self->length = capacity;
+	self->capacity = capacity;
+	// DO NOT MODIFY element_size!!!
+}
+
+void ivec_reserve_exact(void *self_, size_t additional)
+{
+	struct IVec_c_void *self = self_;
+
+	_set_capacity(self, self->capacity + additional);
+}
+
+void ivec_reserve(void *self_, size_t additional)
+{
+	struct IVec_c_void *self = self_;
+
+	size_t growby = 128;
+	if (self->capacity > growby)
+		growby = self->capacity;
+	if (additional > growby)
+		growby = additional;
+
+	_set_capacity(self, self->capacity + growby);
+}
+
+void ivec_shrink_to_fit(void *self_)
+{
+	struct IVec_c_void *self = self_;
+
+	_set_capacity(self, self->length);
+}
+
+void ivec_push(void *self_, const void *value)
+{
+	struct IVec_c_void *self = self_;
+	void *dst = NULL;
+
+	if (self->length == self->capacity)
+		ivec_reserve(self, 1);
+
+	dst = (uint8_t*)self->ptr + self->length * self->element_size;
+	memcpy(dst, value, self->element_size);
+	self->length++;
+}
+
+void ivec_free(void *self_)
+{
+	struct IVec_c_void *self = self_;
+
+	free(self->ptr);
+	self->ptr = NULL;
+	self->length = 0;
+	self->capacity = 0;
+	// DO NOT MODIFY element_size!!!
+}
+
+void ivec_move(void *src_, void *dst_)
+{
+	struct IVec_c_void *src = src_;
+	struct IVec_c_void *dst = dst_;
+
+	ivec_free(dst);
+	dst->ptr = src->ptr;
+	dst->length = src->length;
+	dst->capacity = src->capacity;
+	// DO NOT MODIFY element_size!!!
+
+	src->ptr = NULL;
+	src->length = 0;
+	src->capacity = 0;
+	// DO NOT MODIFY element_size!!!
+}
diff --git a/compat/ivec.h b/compat/ivec.h
new file mode 100644
index 0000000000..654a05c506
--- /dev/null
+++ b/compat/ivec.h
@@ -0,0 +1,52 @@
+#ifndef IVEC_H
+#define IVEC_H
+
+#include <git-compat-util.h>
+
+#define IVEC_INIT(variable) ivec_init(&(variable), sizeof(*(variable).ptr))
+
+#ifndef CBINDGEN
+#define DEFINE_IVEC_TYPE(type, suffix) \
+struct IVec_##suffix { \
+	type* ptr; \
+	size_t length; \
+	size_t capacity; \
+	size_t element_size; \
+}
+
+DEFINE_IVEC_TYPE(bool, bool);
+
+DEFINE_IVEC_TYPE(uint8_t, u8);
+DEFINE_IVEC_TYPE(uint16_t, u16);
+DEFINE_IVEC_TYPE(uint32_t, u32);
+DEFINE_IVEC_TYPE(uint64_t, u64);
+
+DEFINE_IVEC_TYPE(int8_t, i8);
+DEFINE_IVEC_TYPE(int16_t, i16);
+DEFINE_IVEC_TYPE(int32_t, i32);
+DEFINE_IVEC_TYPE(int64_t, i64);
+
+DEFINE_IVEC_TYPE(float, f32);
+DEFINE_IVEC_TYPE(double, f64);
+
+DEFINE_IVEC_TYPE(size_t, usize);
+DEFINE_IVEC_TYPE(ssize_t, isize);
+#endif
+
+void ivec_init(void *self_, size_t element_size);
+
+void ivec_zero(void *self_, size_t capacity);
+
+void ivec_reserve_exact(void *self_, size_t additional);
+
+void ivec_reserve(void *self_, size_t additional);
+
+void ivec_shrink_to_fit(void *self_);
+
+void ivec_push(void *self_, const void *value);
+
+void ivec_free(void *self_);
+
+void ivec_move(void *src, void *dst);
+
+#endif /* IVEC_H */
diff --git a/meson.build b/meson.build
index dd52efd1c8..42ac0c8c42 100644
--- a/meson.build
+++ b/meson.build
@@ -302,6 +302,7 @@ libgit_sources = [
   'commit.c',
   'common-exit.c',
   'common-init.c',
+  'compat/ivec.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/open.c',
-- 
gitgitgadget

