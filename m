Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03652361C8
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855870; cv=none; b=RjTTrrizwmElkqyN7a+qK0UwdtDJlQYhd8VDGYW9Ne1FalhutLZa7Zvag+IpBRUe8CM2MWtXqNysQawH776B6NJI9rJCdGoOg2BER3Q/aBBguS2ItwmwImkr2Syzry5IbQ6WK6EEHxZy3LFHKNH+ckelJsbqS6tQDPdX4pSx2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855870; c=relaxed/simple;
	bh=zmo6BVZ1CYKNXz3Rwdif4bODMzIk6Rrwkla9swhhwkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hk2rfmMNr8H5lCX/qw8JHcnneqhkvfa0RpiTlJvcWCJDm1APCodxS+wyYO6St9Irn1J25fLm2MtBcDOZb6KQMEtwIHC7gND9WHG7LjWf/35H1Kbjjj3HjMuCVHHQenwfL3/CaWHdX/2y5QCiPY9Z9vIqmP4btfypiZwQbdBFeug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Do4eM8e0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPrpA45Q; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Do4eM8e0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPrpA45Q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D864114012E;
	Tue, 14 Jan 2025 06:57:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jan 2025 06:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855868;
	 x=1736942268; bh=G09U1odGoU23BD8i38JKusb6NDdpZEv4ha72RO1CYyA=; b=
	Do4eM8e0WAKOhqKSUlVzQuutqldyr5HeebZkfUIiBVxm0yoxGLBKjNY6hccmIwIN
	xsZFwj/kg7x6rmmWNwaLu2Y122v7qrrwDmjx5nehyE9zAhm+QVJCMv1BIHa/X7KV
	Eet6krP/vFR/3MC6M8scoCeKzvdt17sf6ntqFjM5e2PlXLA2khPzM+fbK+AmUanx
	Bj7dpcyIX4otBx8XlPzPHUBBm5+0OxdcHiIgsEYan2YU8/KiQngcHyR9eqwwnqy8
	4NoRe9fPvXdVNw0KJeqCbVEvFipBv7Hr40+HYO3LCSBqpdq/yVkRhte3v6yNTkky
	42eZ9xxGJRIxEY9D3vVHrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855868; x=
	1736942268; bh=G09U1odGoU23BD8i38JKusb6NDdpZEv4ha72RO1CYyA=; b=F
	PrpA45QHk1KrV1yfNDo+rNeMHtg725YYzcS0753UJVejGjYUomdePlxgvE1Q3G68
	hQSn5Ze/cw2qA4msx6tLeH7gD05nc9D8k0XLLidN0CBENbTC6M5wRP+avKiO103u
	U8Kuulsu0H+jFcGryaQfHLAxe/XbDe2vFab4TzbNnYA+9CK/3EcPJivU3CEn3V0K
	Vn7anBn2Ec4rzwRnpb4WldkSpDhLIYpqS+5cPubkzXtti7boTtjWXS2csKzgSvFA
	20U8lFxAevzdbnVcfU0qwZPcBqMrnDFFT4l8rxTEKPZUx3GzyROiy8iQzsblUiEx
	BfG/L2ZLoVyJDAdehqyjQ==
X-ME-Sender: <xms:O1GGZyfJWn92rTHK-TIiuheHRzZoo2cc0NmRZyjsz94sgxaokUj3dw>
    <xme:O1GGZ8PLSlT-UkVR6exU2WCiDdHiYSfke1IvVzJ7ZXLtOvFNP54hGSFSuC7Rwi5l1
    _XrLRwQiHr7QhRxxg>
X-ME-Received: <xmr:O1GGZzhMDgCFjajOlLQDHaxmQ0x4rzifPybRUkqAoiJXXdTYdHvarfyBR_VG-gDudPKVLK_UepZxNA9Yh8frcM6o5t5y-1GPDzyXJ-c3ewRiAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:O1GGZ_8vFPc5PBXwfe9P6yF5OPZLusOxLBkhYpIGU9YuW5cjG9Gdqw>
    <xmx:O1GGZ-tND_Qjdb7X-DZcweqHUU-IYpA2VQU5jwZcsfXxpkWDZVwAfA>
    <xmx:O1GGZ2HrD8qgNIXX56XOndSVq_zPZHv6ft8lPikfRb_uCDa6zZ-FiQ>
    <xmx:O1GGZ9PvSeRg1lnL0npPKrQ4R8nTqLkZMjQsJ0CjsDcHpdiGvS3TPw>
    <xmx:PFGGZ34NIOwTAHrAB4YcU_Zo4NVQxfQaRfBYuXpjaC8q4N2drBhSfevf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93958383 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:43 +0100
Subject: [PATCH v2 02/10] git-compat-util: drop `z_const` define
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-2-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Before including <zlib.h> we explicitly define `z_const` to an empty
value. This has the effect that the `z_const` macro in "zconf.h" itself
will remain empty instead of being defined as `const`, which effectively
adapts a couple of APIs so that their parameters are not marked as being
constants.

It is dubious though whether this is something we actually want: not
marking a parameter as a constant doesn't make it any less constant than
it was. The define was added via 07564773c2 (compat: auto-detect if zlib
has uncompress2(), 2022-01-24), where it was seemingly carried over from
our internal compatibility shim for `uncompress2()` that was removed in
the preceding commit. The commit message doesn't mention why we carry
over the define and make it public, either, and I cannot think of any
reason for why we would want to have it.

Drop the define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-compat-util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index d50f487c00d7958e871bb9a98419e55f866cdd1d..c4b4b372b473ca0af2a4f5f60554f6d3df74f112 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,7 +1537,6 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#define z_const
 #include <zlib.h>
 
 /*

-- 
2.48.0.257.gd3603152ad.dirty

