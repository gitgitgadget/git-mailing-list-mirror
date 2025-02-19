Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FE1E25EF
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970846; cv=none; b=ZH3d09mP+VOP6ajUO2k53/vySC7TJK/U3Qhoe2ekDwodAhtIXXkVxJZQO9EB28ioXmyzYPrVlCfnDBiHLEzHNH2Zfg6ewAHOwi+C5d4l3p2vAP4XIcVLJSfIB3Ooz2nVImW8r/5xoD7GwYxW3UMSH9uq8XasZ+rrKD2A8sg4f7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970846; c=relaxed/simple;
	bh=P7belojgmpWqg6uu+gumhfaimrGgyr69IOfM6F5m33M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nV4SrvSNgZMwz/ngoJYGQqasZP6V1pqCMST3uTKgT1iT8yuYClUWKMrDOcviF1vuhjWe5C8GEz5lNYyrdld9sXOgcplAckg8zW/XcwijS5VpAMyKx7t5nNH98aVKB1ljUoCWVNIDq4GhNvs47w4VnyFYXUa0lmclU1qILQ/djp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LxHBQ8Dc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DEjkpXdi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LxHBQ8Dc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DEjkpXdi"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 57CD0114015E;
	Wed, 19 Feb 2025 08:14:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 08:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970843;
	 x=1740057243; bh=SyCuoN07KpprDPsZYdCQnC/i7dD0nywt1RH8i+RgF20=; b=
	LxHBQ8DcyK+bLFZg5HBdSiYRqz2Av2afWO3442FHskyiWdxEhp2MX2qET0i2OZOM
	d/eHh4h4WLcLobahm1T+T9QmvKRqBDjNQIE2Ey60TI1mD/oh+Dr8xMxq3I53ZJnL
	G6J1PAfsoDIRBRHnpLTeZ3ZNibCOdzm/YH7L1kxKKUmzBVfv6/kaOhu0RnFUYJ/8
	tZle6WaF0EPqGBDNwue2bFOtjLMb2nTHRPHVIVEvMhvt/Cf5w2twPXVhl7CRWTfX
	tJuN+M2TBBntpU2RxCtih5jxHmG7MFfZSYj+JqppAL40D6Y1L4+G5FeNy72rHbsH
	2BGDgcLL9kftqT0z8/szrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970843; x=
	1740057243; bh=SyCuoN07KpprDPsZYdCQnC/i7dD0nywt1RH8i+RgF20=; b=D
	EjkpXditDsy9AvaSuzjQvh4NADjUpKSdwZcE9yj+o5LiOZTOu9OeZSrx1+Uobqyx
	198yhLnhjK585czpYw4b3EP+JmzMm0OKBkqwn67cAD6l7/3d0KhmYdCHEhLPFtys
	G4xsvVHR9p9n9js6/iHSOoB9ue8OYLn5bqzz6bylFmcAN2gwwRQhZoE9okKmaPZi
	S3PDjGdZNgHjtX8ct2OnZWtgZnhjGyzSaOdE7RBlCgd+PFgLaD2CB9P48UnHnG5J
	E3FmuAGEfmOZ0iLBO0iDtW5pzR5Ud5Ul6kU2wswEj7ZYdh918IKZaMU5o2Fmkklu
	dwOpH8URQG6cjzW0MUmwQ==
X-ME-Sender: <xms:G9m1Z3AzNAbnngSWq41Bk37eOa940cnYqWuoPxBbAKrNHduU0B88zw>
    <xme:G9m1Z9iipl0v4PPPXKEEjuHkDfPy5dterQkJy63HIe0PaL6LgnblcKnXj_siQRE07
    j8hrt0HDuu-cWZSDQ>
X-ME-Received: <xmr:G9m1Zym-wfyPjTWYlpPut9gHkB9EKYLduD8ZwrbQlhx0Dh96hoL1HTfo1dJwXxWco4zI4IFxv11yqtYj7Xna_WsWmw-rV1kBwojESXNdEEuMAZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskh
    gusghgrdhorhhg
X-ME-Proxy: <xmx:G9m1Z5w5BtBAXecmckSYmM4ZHatWnUXjymMh38cVmjczwGecCEJ_MQ>
    <xmx:G9m1Z8RzfMrYYxS_MZzq4OwjezIpGk9K2srWZA1FyfRv9u_ox-Aehw>
    <xmx:G9m1Z8b-lTisyB8F1rBt0dYiY7jYzFlxUTTQ1ScxwsXMlox09lBosA>
    <xmx:G9m1Z9Tv6N_FAeJwCdb6uILC8CENo1hUwMcrt4dR3yJqiKKtClXOIQ>
    <xmx:G9m1ZyMlkTSVO69Reins0f6G0FDqtFrq9ffwHESYo2kd9SRJnALazydd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3f1b2b33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:14:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:43 +0100
Subject: [PATCH v2 03/10] contrib/credential: fix compilation of wincred
 helper with MSVC
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-3-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

From: M Hickford <mirth.hickford@gmail.com>

The git-credential-wincred helper does not compile on Windows with
Microsoft Visual Studio because of our use of `__attribute__()`, which
its compiler doesn't support. While the rest of our codebase would know
to handle this because we redefine the macro in "compat/msvc.h", this
stub isn't available here because we don't include "git-compat-util.h"
in the first place.

Fix the issue by making the attribute depend on the `_MSC_VER`
preprocessor macro.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/wincred/git-credential-wincred.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 4be0d58cd89..04145b51183 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -12,7 +12,9 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#ifndef _MSC_VER
 __attribute__((format (printf, 1, 2)))
+#endif
 static void die(const char *err, ...)
 {
 	char msg[4096];

-- 
2.48.1.666.gff9fcf71b7.dirty

