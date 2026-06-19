Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E137C109
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868498; cv=none; b=ou06OzfkrNdl+1LtoN4ciL2c/wuGf4/NKfxslrXywNXQLfDQj1Sfizoo1FPG0aUeo5MJj89vkx4FlN75BuOcMlFLTe8Oz9WSddKH/QehDbro0FofaxourG7SdAwZWfodSkAw4gUhiSP0oTni81dV+9QcdhQ8L4TfxVPvrdss9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868498; c=relaxed/simple;
	bh=n2x4SdULt17oTXasIaaEIAZsEazPn/nBDsuoRdCEXCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AueJBvlb8KTeH7qrk8CSHQLTsAO+4vA1DFZZ3A5QvWq6EJuMjaHGTFflapnUFeeQMgFCPvU0+DiL83kJXUms9t8sDAfpKacVhjs6RRMoCADxBRHKIe0gzWysrWmlZDRulPDBoSzoJSiP7efenXPs1YaagwWMgQjJF8WL1t8SZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QeYZj28h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnxBWvJO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QeYZj28h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnxBWvJO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CB367A015E;
	Fri, 19 Jun 2026 07:28:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 19 Jun 2026 07:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868496;
	 x=1781954896; bh=EtDgyq/MBj0r7r6w7bvmuXXgVNe8cs6vnGibsFG0VaI=; b=
	QeYZj28hCeAV3H1/pkMfS1yfC3diyxI6hRgRoAAzYG64z53vq4IrcKFdSGKk4e9Y
	FzepiqRRhOzB5imzf9l9dNjRRIYpK8NuTSahKf7DOqICvjsDKYUpKvTve1EYUPPZ
	nra+55Elm96fmrbHQpKOwbRg1lQ1P1oJhpPgDr2yqcQIVCl1ldjpKhUy/IMS3y+k
	w8PopEVAEFL6SxCY61uuqQqwLoYVLW/kDf18c1CF69UOdwEmo8RhPFXa5pe3x0fs
	vr+tCYo/d8Fn7ianP6x3EcqWUbMSBdahmRqpZ9XxGV86MnHN/ufggseGfPzXm2El
	oqkBXDdsVCpmSb3CcfmTHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868496; x=
	1781954896; bh=EtDgyq/MBj0r7r6w7bvmuXXgVNe8cs6vnGibsFG0VaI=; b=d
	nxBWvJOU8udoFpuLsZ5NckKtReba6wRZkg8PuD9Fu4gL1Em2nn1vB3tIbI5W7JI0
	5pIXdy57ej3BLlc8rX0S88Tu/IDGblfVGueWMiM9V6UoXDXngE2sgl/Du9FpWQtN
	qCaiqM/JM2Facvr6E9TdCku/QwoI7hE3FCAlvcU4t2KMqM82zAr2YWVgiT996EoL
	EavS+cfv8B1+ZOa8S6/xoLr4bkiac+Q2HjkBZG+hevCNcBbgXZtXcEcTsgz47OVj
	4msQl2NkVGCQUbfdIaQryHftx/44qIs+w4xUazbPEKmmFzU8hKZ2h0kWRsF6IniA
	GUFT4JLgom5/bn16jk8WQ==
X-ME-Sender: <xms:0Cc1avaaP1ueW25EEOtd4fmwMyn_HcKbEU6ectfk0XKxVZPubK15fA>
    <xme:0Cc1ala_RJGWWIQD_TeNn7NVs7IcfeakJhsmTbI1ob_NPtQC7CDp6Bbtt1FH8C17q
    uG_QAxoKDI7ctt12CbrQh335-VjTPr0Nivvp69W8QbD81t2afRlsg>
X-ME-Received: <xmr:0Cc1am_JXgMNUAsQUBhzA24LDRZREvWujoFZoYMVtJZozMFsk_9dsRjenfhwX0QdzUfiiwtZhiuBRAHS0Vn7YMWFU5Vzv0o02QDWfDjUVUk>
X-ME-Proxy-Cause: dmFkZTEde8rkG7Ow/YQajJOxpUKYHnTWdG0AUznTDLiHmSMbSqWzB/6nKIAIdk1nkTwS0K
    C8jTqdNp1V7h/KMFCwexCiiwcxkUoPM3XGMXsNXnEqixWMufecGwaAXNpfHOfwmwhgziKB
    gEME1JUhRUF4zEWjEcolbPL4SS80OZZVhDQXhaESCZsPSITOIFAzr9mdv/wwDKbMEUglz6
    Lrw5108LV8TWN60J1S3iQg3WXtzla3Zx7Q2iJ+qofdJhYzq3vyVO5Ie87s6Y7SykEWxrmz
    /vmzMKfUyKVDBOQcXezzDDbfTiNE3Vevxi8qzYGVvv3v5UE9OxNTzNX4wxQEWsT+cwQAOe
    KIae6KfQGFOGlbsCZsLQCZjrrM6JJulpxa2uUeUtfXHfA2CPzHp9h+8QM22ZWWqixj7lAK
    3J7md+4UkfkP23eP5oksalAZVA51qBrmBNnlpn6Xf+jOyKAM35ea2x2jRkET4SL5qzMyhq
    wGUm5hSBkiqUTs3GZ7O2TVhDBOxkvQp5ddFP/0vX8dFIw8QVgzdaO7DjTh8sm4cm+WHrAV
    8ptEGry/Z2SC16+zfN12rripJ5UVUBPjQOhYmc8o1VKAaQKOWKA7j3EiDrhg8P7eCPU/tS
    hMs69zrug/eJVUWLfm1W4VVoV1bzUm2zLgjfh8Crd/AFwkvkQa3IjKyrGJhA
X-ME-Proxy: <xmx:0Cc1akiMyWUK2KJXoRJ0opO0b7liGs1tsp9aybspSYaU2Yryp9KBgw>
    <xmx:0Cc1amegetr0L9xyBHJ5ACIawW5h2kvjcE1TFClWKU09dQch4_Uc-Q>
    <xmx:0Cc1aroj3bGimMuoYwRnhVpFcQvh8Mka8_XAvuaAqcXYmlfEaw5X5w>
    <xmx:0Cc1arBlpCwMLyxFLZ6InUhpQhlZQtf7Vr8VCW2CRrthKHjvdwpzyw>
    <xmx:0Cc1apAN7IezG_EAmCXmX-M7PD5D-f8Xb7doDA4j5GLOCicpEeOkTExH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50f20657 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:53 +0200
Subject: [PATCH v4 05/10] chdir-notify: drop unused
 `chdir_notify_reparent()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-5-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

With the preceding commit we've removed all callers of
`chdir_notify_reparent()`, so the function is unused now. Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 chdir-notify.c | 26 --------------------------
 chdir-notify.h |  6 +-----
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/chdir-notify.c b/chdir-notify.c
index f8bfe3cbef..1237a45e2e 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -43,32 +43,6 @@ void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
 	}
 }
 
-static void reparent_cb(const char *name,
-			const char *old_cwd,
-			const char *new_cwd,
-			void *data)
-{
-	char **path = data;
-	char *tmp = *path;
-
-	if (!tmp)
-		return;
-
-	*path = reparent_relative_path(old_cwd, new_cwd, tmp);
-	free(tmp);
-
-	if (name) {
-		trace_printf_key(&trace_setup_key,
-				 "setup: reparent %s to '%s'",
-				 name, *path);
-	}
-}
-
-void chdir_notify_reparent(const char *name, char **path)
-{
-	chdir_notify_register(name, reparent_cb, path);
-}
-
 int chdir_notify(const char *new_cwd)
 {
 	struct strbuf old_cwd = STRBUF_INIT;
diff --git a/chdir-notify.h b/chdir-notify.h
index 81eb69d846..36b4114472 100644
--- a/chdir-notify.h
+++ b/chdir-notify.h
@@ -19,10 +19,7 @@
  *   chdir_notify_register("description", foo, data);
  *
  * In practice most callers will want to move a relative path to the new root;
- * they can use the reparent_relative_path() helper for that. If that's all
- * you're doing, you can also use the convenience function:
- *
- *   chdir_notify_reparent("description", &my_path);
+ * they can use the reparent_relative_path() helper for that.
  *
  * Whenever a chdir event occurs, that will update my_path (if it's relative)
  * to adjust for the new cwd by freeing any existing string and allocating a
@@ -43,7 +40,6 @@ typedef void (*chdir_notify_callback)(const char *name,
 void chdir_notify_register(const char *name, chdir_notify_callback cb, void *data);
 void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
 			     void *data);
-void chdir_notify_reparent(const char *name, char **path);
 
 /*
  *

-- 
2.55.0.rc1.722.g2b3ac350e6.dirty

