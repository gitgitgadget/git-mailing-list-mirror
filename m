Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7FE3A8FEE
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673350; cv=none; b=p5vZ4CRKSoco6CTPMDIYZd3cVPIQ4MpDZKecvpzuZ+xDbVNfxVzlRu0uv5l865VpsItgCfeZ1bPz4nvo3gTH9zkCzWjQGPs3gAvU4QztqazkS/FoqKOxqioAXexYvUlMZhvWO2GqyMD0xXqMKJSS4B3ERTpM9h9DQp3fXwiBJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673350; c=relaxed/simple;
	bh=qUN4CU4K6Blw4TCJ/zs/WqZffyyWU6OvSBxtaLRHigs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEvLFIsKDM91nfmTuWMF0BC1vC9Q+LPkmi1dDlukk/NxI8EWtBD5wKx/WX6vvadBaX8y7GBUqOdegwG51Iakv38DpoJVgIkyfNuKEIKhIsvGuTU+FOma1pHzJKv90EOjb/MSCmvQZTob2syq4far11Yztx6U/dFIFEp9OqeFULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VCB1luw0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V0aBaiDi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VCB1luw0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0aBaiDi"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 96E03EC01A0;
	Fri, 10 Jul 2026 04:49:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 10 Jul 2026 04:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783673348;
	 x=1783759748; bh=6dAbnt0ygVKo0x5mo6oqDYhS6ggMGoapagP1TmhsLtQ=; b=
	VCB1luw0U9rqrIVVihfk2Oj3I+3xZbocxumu3X0QFryK4Be8OgI1H0E/LIkc86ay
	jAqGLEJ2lyTfnCj5xYEHZ9BfdUiLnTf58/ZVVkx4ETZpXeHsxNLtS4D1FNgK8jbd
	Ry8+D5yvgIZLcXO39zTw8YDyClN2HwFhv+OtGTeQyfvmSnDnw2IRBPyXGY+7/weR
	N95tW5NVFpy+vjVScnd7trTSH5ZSaLwQSaY6gjJu1wX/db6h+oxj2voq1wiML4Sf
	hgwHDN6Bd+IvbiODELSA1kC9PPlbjQCGLdhTntrdMqnuErc4YV3pLAUnSnc3Br95
	N14T6Jn/nYUe4Ast8N/Lrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783673348; x=
	1783759748; bh=6dAbnt0ygVKo0x5mo6oqDYhS6ggMGoapagP1TmhsLtQ=; b=V
	0aBaiDiOgkMZcIJRS05dIotGZnl5RYtsxa4y6bchsQlAvttUSBb4Wl6ftqEIEQiq
	ybY+2zaKNIz3b+zh9JcqnL2bdvx0L+aidbQEcZ6sh6DR9A5ySt6NltS12G8e4PCU
	BeTEIdzdduHMiKcNKsp2BKQ45a6eL//ePEiOuka52naMf2gWkTwuionArp0U3Yww
	5KXBv7zsawKH+GF6iws4mwQIfiXgY25LWQf8FyLCjxgtmAlTaw6Tid/arVlg9aVS
	o4bvur3zBXaUqLu1KYY6mYxNEN8YroVzrlmryF1j4k0V5XLp9WCvtsjM40SF/1kT
	7ftyt3VxoPJTKIzzJhz2A==
X-ME-Sender: <xms:BLJQar-Bcygav9plz8Ju_xUnVXya5AW1owJeY9AxtJyuLL6w9Sj5pA>
    <xme:BLJQavLPpe_qAOEzmyoy1911Fmb48-Kc3iCDlpXVJ9EQg5IQqDQJatEl8DdhoEJdi
    NPM6xXrznaC9hWFYoME8-rZC-kSyPo3gcf6OUcrZfx4ieMuvuqDnA>
X-ME-Received: <xmr:BLJQamb-AsbSOrTz4mZ9KxbmA5ESeg-uDlakerijzNWfYgAF9QII-KFCUhgYFORDlEDlcRF8oD_Swe05QrsFiIlNIMpymf6kWSsRHL2cz4Majw>
X-ME-Proxy-Cause: dmFkZTEgZYCWI0CbwqLDlonRXrqrFzk687BySmUYIjUL8URshR1m/EiDVyblVfOFgWBhiF
    2W31tpdXDxKGKgaYhurSLLFU+BbNgi/4C0xxaRmtYJz7HeqEFi+QwvHb7kxQHb/YWwMtb7
    j3NTQXjJMxj+MM+cU2WaoisEZ014DFJUFWVLynF63QDmY3YIVdTHjtzzSe4K8qmVO3lsb0
    CsQzE07xbJQnig+5tGzXACaJVyeO5r47D8vtKLZkkZ/UYzA1paKzr4n2FRqRHlz2sPYkEh
    4LtdzZNrewg5qHCD0/9LlGVHJkWjCyl/Ps9v10iDJeQ6MHaHMd3Oy/Da6KmnDR+SDj2QpQ
    FGQdPLiHwjrGuaw7bA2i8o0ysA+z8X3RNDcVRKVYPNXP7UaQm1u0NJ9jPVOOBC7kJ5MtL7
    3kbjELS3TUEBASv19UL3Hb/bVLzKdJbjsFjNolq6LkSoN5YdiGHGLhg2x1aySQUmM/mIqN
    2FHZ/0NhimSx/mg+B647nhHB36qYxdczU0TfH6qcrB7d1GZHkN7s1PDnMcuHEC2EkeIip2
    HS2+8gQ/5cPA9aPZIKqTkIO3mip97nguM1uVxK9HUZLduL3jlSJ9e+T/J5tXci0A81stZa
    gCNKnD99+6Bu8yZrFB+c4EbCl2Gmv8CGYsSILr/nMRp6z2I5RuxYl9GU0BCA
X-ME-Proxy: <xmx:BLJQahJ5qOKJE0AtxcacAAnm8rK9D0I1FD3fykfsD-s0st5giFD4kQ>
    <xmx:BLJQakA0e4Ft1clJ_DPl4lIzuUTJJ2I3wy46G7DHFkqAlM2y3xaVZQ>
    <xmx:BLJQampA-IdmIZrWgIJiC2IrL0-kgGIOgg5zh7FKfR1IQGQAj13MDw>
    <xmx:BLJQaviyHaqZKKPC-cdA0slu3ifAgSvLZvkI9egzFgkQWjvkxyIvEg>
    <xmx:BLJQarIcCjIxCYLqWhsXMUY6IsOtM-F0y2r9_2Y_vo3DHq1MQm_lCiK4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:49:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20e2a89b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:49:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jul 2026 10:48:54 +0200
Subject: [PATCH v2 2/8] pack-bitmap: mark object filter as `const`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pks-odb-for-each-object-filter-v2-2-3710a9cc165a@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The function `for_each_bitmapped_object()` accepts an optional object
filter. This filter is never modified by the function, but is not
declared as `const`. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 6 +++---
 pack-bitmap.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 35774b6f0c..a47c231632 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1976,7 +1976,7 @@ static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
-			 struct list_objects_filter_options *filter)
+			 const struct list_objects_filter_options *filter)
 {
 	if (!filter || filter->choice == LOFC_DISABLED)
 		return 0;
@@ -2027,7 +2027,7 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
 	return -1;
 }
 
-static int can_filter_bitmap(struct list_objects_filter_options *filter)
+static int can_filter_bitmap(const struct list_objects_filter_options *filter)
 {
 	return !filter_bitmap(NULL, NULL, NULL, filter);
 }
@@ -2058,7 +2058,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 }
 
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
-			      struct list_objects_filter_options *filter,
+			      const struct list_objects_filter_options *filter,
 			      show_reachable_fn show_reach,
 			      void *payload)
 {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 19a8655457..47935eb24e 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -96,7 +96,7 @@ struct list_objects_filter_options;
  * not supported, `0` otherwise.
  */
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
-			      struct list_objects_filter_options *filter,
+			      const struct list_objects_filter_options *filter,
 			      show_reachable_fn show_reach,
 			      void *payload);
 

-- 
2.55.0.229.g6434b31f56.dirty

