Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402ED1F63ED
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052917; cv=none; b=eu6rMe9A3ysL9MIO/zEq3lQQF0DlgOaNSWmQat39WVN21JjWOhRi+hXVXAvi0TR3tfb7TzHtlgssTS6ArrA244Q0+sALJvBtFox0APPY5aPYFI+YmQkg8JETMj6BjhdO1LCuYS6IILppgcJgN2NsxEuC8YqxpiAQB+HnBEOKdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052917; c=relaxed/simple;
	bh=1cfGhv2CtVDI+uEnfhoidh6GGJu7m6+3q1YI4IY2DdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asuSfrVqlu3MP0GOHUIGSi+TUSI3EnPcWmBEzRjGrQoxLKx9+ZqFs0dAizGmtRVijzQwzTAdQtYV7wW/Hjziv0lTAqtGX7QZ7b+WmTsvNRmwf5n9bJ1OsipRDN2BPrYCaja6i/DAmpnXycfgxL9WuPS4tvTRVgQ0BsiJbvcvvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dqOvDXqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8LoXXnm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dqOvDXqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8LoXXnm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89E5A254024A;
	Tue, 28 Jan 2025 03:28:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 28 Jan 2025 03:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052915;
	 x=1738139315; bh=2YvloPgJ0adqNdO3FdP2VF6v6pumLPMKOE7ELd1HVTE=; b=
	dqOvDXqty5u27wYYFbzNAz50nZEugqIw+csveZeBnTsGgiyW65PBWfTZKwLGj39s
	h7WpwK11tg9h6r6tSpGO2eWSuw28dvu9KS8uyLrvJ/a/b9/WVpKyVSI/+KpJaM3i
	Vh1ArkKptTQth3Oh9Fw27Xq3IkSoHy/Tan6W7hd1BhRzE1Vf60sShVufKzvRDn6N
	S1IwsqvbC2M2I9FIA1J3SHWFYmNhj4yK9H2WocXEPBMsJFIcxYFvmJEYtI+a/2nz
	xbY0XonenbzK008N4HdQfIZDkcd2/iHJPKA8gINVDOfQlJQIweAD9qVn8xM9hoAQ
	ilC4AhdhUKffBL1BNgOaoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052915; x=
	1738139315; bh=2YvloPgJ0adqNdO3FdP2VF6v6pumLPMKOE7ELd1HVTE=; b=e
	8LoXXnm09tD/sxUO2lJ6n3JE2Gdtznfwyu8re3FMCLMMdpfLkpGkCNj+FbZtjgCu
	hFhOKXa9QJFroiW+0sPhcqhQ4DYSH8BSUGGIVfAp84EMRrrD4skIq0ZhJuq9d3A4
	UE3dPTV6ZMrTGAd9QlLfWseqaBlrfUIEBAHvt9uy/SPT5Hbo5bDZpvXP6NKeCYq6
	7EmDRDUWGkosOZbuW0n7DDWjXzVSGGVbkbwzh/aBRkCgFzvNu51wgrVfgmOgSxou
	wEcosa+h3eWzfwNWSYP/AJpWoDjl2tsz+929vxDAvTwjy6U9xHIvfYAVqXRAbIO7
	+sD/StzjPY2w99ilyRtBA==
X-ME-Sender: <xms:M5WYZ0ZlzBmY91ahTVjXblYqGmHIrLDPYlU-l8I4Kz328-QqNEvU8g>
    <xme:M5WYZ_YegvfUkW200UQTU5mvLMlKfgGcG_t0xhn9v4GXgKgUXk26Ctd8yNi4IQIFf
    hpWVu5YyM_matCgHQ>
X-ME-Received: <xmr:M5WYZ--KYCD_H9WMatZT8RhynZlipDVXcC7Zc_KJiXBL5mxEnQnIrl53R5JdHfZnkeJwMSKxmH6O5oNWlWbuujIPS7FR6uVma_ebpka8NS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:M5WYZ-pNJSHJZi5RhgcLcn0oYSIhAhpy2mQLFYs0ELcLOZvsrLo6wA>
    <xmx:M5WYZ_os3pwRZjzNjTbnn76vyg4fBl2v0RuKzRGFwQCW902D3lq7fQ>
    <xmx:M5WYZ8ReYCohl9_DApCeEJVTuj_bQnNktqS3IOOPxl70M9RdEVCj6Q>
    <xmx:M5WYZ_oCemc6jwq9rjieVl82txqHplCXlxjdnGr7_ZONJ8589yMDuw>
    <xmx:M5WYZwk3pydJdPQr8hvpsgxiOea-6HJ3ijxhCkrf75uykqP_qLZVnlhS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b1bf8b7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:20 +0100
Subject: [PATCH v2 19/20] reftable: decouple from Git codebase by pulling
 in "compat/posix.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-19-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The reftable library includes "git-compat-util.h" in order to get a
POSIX-like programming environment that papers over various differences
between platforms. The header also brings with it a couple of helpers
specific to the Git codebase though, and over time we have started to
use these helpers in the reftable library, as well.

This makes it very hard to use the reftable library as a standalone
library without the rest of the Git codebase, so other libraries like
e.g. libgit2 cannot easily use it. But now that we have removed all
calls to Git-specific functionality and have split out "compat/posix.h"
as a separate header we can address this.

Stop including "git-compat-util.h" and instead include "compat/posix.h"
to finalize the decoupling of the reftable library from the rest of the
Git codebase. The only bits which remain specific to Git are "system.h"
and "system.c", which projects will have to provide.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/system.c | 2 ++
 reftable/system.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/reftable/system.c b/reftable/system.c
index e25ccc0da3..1ee268b125 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -1,3 +1,5 @@
+#include "../git-compat-util.h"
+
 #include "system.h"
 #include "basics.h"
 #include "reftable-error.h"
diff --git a/reftable/system.h b/reftable/system.h
index 3bd4a4e322..e4a8944a70 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -11,7 +11,8 @@ license that can be found in the LICENSE file or at
 
 /* This header glues the reftable library to the rest of Git */
 
-#include "git-compat-util.h"
+#include "compat/posix.h"
+#include <zlib.h>
 
 /*
  * Return a random 32 bit integer. This function is expected to return

-- 
2.48.1.362.g079036d154.dirty

