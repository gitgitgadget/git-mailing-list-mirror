Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F81DDA36
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053698; cv=none; b=lw+pcutYPQX9JrQL8bHWi7lcZQ0PnhL8DwrGMgVBSawcpVgqbagc/aR7uWYgf1VlsYCNwDKypGtFmqCdqt9Whqg/+xNm540cuzJ7VALnqj//93Dj3IzfBdWlo0QJ/7Gs4p8OsoEK4q/tX8rbCPqPUa+rdcm1rDKQPkfKzwHFWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053698; c=relaxed/simple;
	bh=0ESeJ/clcUxsa1/WrgwCxMxks+IRMjLX5BpUfAJluJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBssTRg642usrrR8wVt9b1Pr5KKFPoUr0do7hEAGddx9hEmWQt0gM7cZVmBvNGpyUuROZTKMYfrFf9YrLoxR8YIXztmyBIZyWygTb0vU3Fx7WvBWexuKoIaXfJFZSoPoxLFwun9VyEb05mgUDAXOVtjxJXODDVPHcPV/SjnUj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QrMUtx79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SM0I6RWS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QrMUtx79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SM0I6RWS"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94318254022F;
	Tue, 28 Jan 2025 03:41:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jan 2025 03:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053695;
	 x=1738140095; bh=dU3Nw17EkYC+I6bOmnksW6voTrbRYNVUBehKMUaRJtg=; b=
	QrMUtx79ouPn4ht3ueDEuU8tzpixqOBe82H6Z9J5DWP4rtR3o40k/k/dmzNk3Hgs
	rtbRIZvg/SdSS1JF9movVWu0Xiu1zu+UWamSvhAYWcakzbztM+1T5yH5AIs5Jvv3
	Zw5n76yx3d7rlpPugJsqJ16mFbq1GYX7B0RxdU7rQ0WqRkj/jGbr7R0MpCibvfXJ
	uJarrJMRdZI55GhfbwRL9DvahAkNX+oOOn01UJ3Z0nUjM53OnFkLJQFnqEa5rePM
	P1XqRDVWTJBp3NqAb9Y2LlYtcmZMNm/6kdlNlKwpmw96JVYfBdxl0JBKdKovY+V+
	qE+o4JKIcylGAXOJRUyArw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053695; x=
	1738140095; bh=dU3Nw17EkYC+I6bOmnksW6voTrbRYNVUBehKMUaRJtg=; b=S
	M0I6RWSEbTBhQE4Z6OBQrArMoNnMdYxTyFvo2hlFihCgsGc+u5gPFvgQXX4GceNc
	Lae/2Uev1psSiBSOttdhldVtwQEqP6Jwx1VvomMtCV/fOV/8OHiVd57+b4HqHjLO
	i6KTrtxH9435+CYmL69/WIMRcBHfgnXnoZeaQPvKnLEBnLL2gyGEW8lErN2ORoL8
	/DP2hGCecFUe9U2Vp8ulKKbwn+sZmetkXt58gBE9VmG2PFvMlnz8WX9hC6d+fq1v
	0EmKlnKdB0PnFD4vOh2ZXiXARMUloi1gXtapbHvYg6QqQX2gR1PP9ThGly34ev2d
	KkU/n84FN+FhTK/+5YlPA==
X-ME-Sender: <xms:P5iYZ0mhaHhGpGTrh5MT71FIrwuRM6adPz_9azozvo6pU3QqxjLE6A>
    <xme:P5iYZz1etorn-UOvkHUcCARsTw5h9rwscZAhBTZmE4_yEFZPiAnnN9xSo6Zpj7iWS
    jU9-RXDKq7uACCwEQ>
X-ME-Received: <xmr:P5iYZypG7aWTYc7B1Qcg_DHC8XOmo7cZXJ_oJSrMBT42ZAgUNyN6gV8vVsbFQmJn0xCyLSpARuCRU0FypDHOXMr1uIwY-f55A4PZfBHOIHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:P5iYZwkIrDJ20ITizXTp8_CDxjCCllgZ1_WWtraWVn-dVus6Lhhglg>
    <xmx:P5iYZy1GB5VpsALP79Km-VOcd0un9PYV_ryq3l4dm6JC4jS3XhfYsQ>
    <xmx:P5iYZ3vrhzUsR2XqOMhOCb3Ea6__Z7OklwyQTzcik21q4NlW-mgcaQ>
    <xmx:P5iYZ-VWcRr9bdKauVtj7A-VLvLMJbjm_-HOMZs5fyItLB4Ee0iOgw>
    <xmx:P5iYZ3wlNqVqoYeEj_rYpeji-Nn6A6BU4eDIveqkPzp7yf4dR2NWlYT2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 424396f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:29 +0100
Subject: [PATCH v4 03/10] compat: introduce new "zlib.h" header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-3-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Introduce a new "compat/zlib-compat.h" header that we include instead of
including <zlib.h> directly. This will allow us to wire up zlib-ng as an
alternative backend for zlib compression in a subsequent commit.

Note that we cannot just call the file "compat/zlib.h", as that may
otherwise cause us to include that file instead of <zlib.h>.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/zlib-compat.h | 6 ++++++
 git-compat-util.h    | 2 +-
 reftable/block.c     | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
new file mode 100644
index 0000000000..bc20b884ef
--- /dev/null
+++ b/compat/zlib-compat.h
@@ -0,0 +1,6 @@
+#ifndef COMPAT_ZLIB_H
+#define COMPAT_ZLIB_H
+
+#include <zlib.h>
+
+#endif /* COMPAT_ZLIB_H */
diff --git a/git-compat-util.h b/git-compat-util.h
index c4b4b372b4..1ca2671322 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,7 +1537,7 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#include <zlib.h>
+#include "compat/zlib-compat.h"
 
 /*
  * This include must come after system headers, since it introduces macros that
diff --git a/reftable/block.c b/reftable/block.c
index 9858bbc7c5..bc9b079634 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -13,7 +13,7 @@ license that can be found in the LICENSE file or at
 #include "record.h"
 #include "reftable-error.h"
 #include "system.h"
-#include <zlib.h>
+#include "compat/zlib-compat.h"
 
 int header_size(int version)
 {

-- 
2.48.1.362.g079036d154.dirty

