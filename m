Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE31E5739
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389852; cv=none; b=ZCAbiAwbfi2vskmPcO2ywX4xv64DevZ/g6IFfGkfwugotEBcTkl5l1GmCXjP1R9xozWUGbDPC/M7vuOxOkf7EMKCg1P+iEJxUPCYdvm4lYVPr9zrI8RiTphbhcV1r0+Vf2gXZujueY9dH5WWpAjimBi7RIyQzqwGQ3UrakcFckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389852; c=relaxed/simple;
	bh=m87Ho+3YbBoyDrPxeA/eFFv/F5dhyzsCeokoBgpmhXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFISsd/bFDdhCL9rypdQgCvDq6axpLjoFuMye0Xo6cCBDCHb2q7xPvyy5aM9f2GSkarmclCmlhepOTRRD0tp/YfXEcRxljC6QWhGJyFUwzR2Y6HGczJbPJdebSh8XeLarhGF30Qzlr/zeNC5o7s5ugjIoUWH3CLxLlpY979BPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ig5Gu49B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLuwvTmH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ig5Gu49B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLuwvTmH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55DD91140177;
	Mon, 20 Jan 2025 11:17:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 20 Jan 2025 11:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389849;
	 x=1737476249; bh=QD+ejurp6QxirfZ+QI6M7kUKEnMmt+/3awOEb8PtY1U=; b=
	ig5Gu49BoyXJyPwNjiyUDaYhLa1IAG40OD4iVTqtVFR93jPqUafFrt3a0ZQv27se
	Ot7KOvjG/0PagIiHFJC8+82vibjwWKdP7ntYctZOW+ELmHQO2lgNIyF5yEMWaycC
	38tbX/oLYI8emISmgNUdSGw9Kip++wg1gFxrJ+OsQ4o4dmwsINvfjUGmNfw8xUQ+
	e4DMajI6vbrDLNv32YVlxeoR9u+Vu0UongzMPoPDEA3eLIkkLuw3D/wPHRcBN8e1
	O+t8JFgHF3GwLJaOnq5zx+hv8ucHYtVb0PiwDo68hQfTaj2WjhfLtByvDSV2mAvZ
	mfQLV9L7Hb3uX26LcqokEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389849; x=
	1737476249; bh=QD+ejurp6QxirfZ+QI6M7kUKEnMmt+/3awOEb8PtY1U=; b=f
	LuwvTmHKLqUp8fCCA9eLsU2LXVzwMGJp6ABNRUR14uzxExvOh4xuv644gvQateBu
	IkoUgHWrYJWUkjw0a0GOvXMisvWxQF0ImDPYfPSyld9boT4DULNjux2HwO/XKbb/
	VElLWqoogyZbuzUBhXBH+l0tn5DtdlAB3L6KV9ZGpK4OT8ubB5ndokTDmSS1+KyN
	K8sUHrb8b47gLvEOlCYv/RdW1+NHYi4duVdEvp9O4pB0fbo3kFB02DyzfY5FUr3y
	Xix8WgL9JDgCKKDuFf5sIhuKigD6Mc/q4rfkUmmcW2bMSn7wjy9quD6BhhE/I7IS
	ttlQ6Ooxk8lakBd6mrHvg==
X-ME-Sender: <xms:GXeOZxOInaatpUwh4kCoNuJqE5RHzVA4wyApmjljVG0Y3Lo7gKpYDw>
    <xme:GXeOZz8ezqxtjKXZEG4hJCV4DBTWmgFPNXlr2mB0pVNgWwmunGkte1zHd02A87cVz
    ALMU5M4zZ-3ZqofCg>
X-ME-Received: <xmr:GXeOZwTTYz7rcKcSzmkv_XdXdUi3FfUTZzhOJf3hoiLmbRDhxlLW3ug5m33g0lYBmGz3ouiObK-RyhdCw9_KY1NwctMjV8nqvAAnBBfZCM4T4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GXeOZ9vcqYSpKEPDV4vjW1G2rqU8v_5QEw7IvItyJEkK7v1JrIAqtA>
    <xmx:GXeOZ5eP59i4ZLWftOvUiDzubnKGRhlEIlwB_BOALlztnEUM4lJXCA>
    <xmx:GXeOZ51ptDcSXGpuMlJSfej8jzefb3Mqj99MQUauW3eY58eKAaSQ4g>
    <xmx:GXeOZ1-XDcRzWYF3K7IDfHbSY9SEGV7nBtXt1koJzf2FDEiYzzR7SA>
    <xmx:GXeOZ6pYpg5NzwG2J_Y_driN3ZLvCYIQYsisT4qZ7Elg33vp-H09_mNy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be24cf4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:20 +0100
Subject: [PATCH v2 02/10] reftable/record: drop unused `print` function
 pointer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-2-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

In 42c424d69d (t/helper: inline printing of reftable records,
2024-08-22) we stopped using the `print` function of the reftable record
vtable and instead moved its implementation into the single user of it.
We didn't remove the function itself from the vtable though. Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/reftable/record.h b/reftable/record.h
index 25aa908c85..a24cb23bd4 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -73,9 +73,6 @@ struct reftable_record_vtable {
 	 * the same type.
 	 */
 	int (*cmp)(const void *a, const void *b);
-
-	/* Print on stdout, for debugging. */
-	void (*print)(const void *rec, int hash_size);
 };
 
 /* returns true for recognized block types. Block start with the block type. */

-- 
2.48.0.257.gd3603152ad.dirty

