Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5532FA20
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536579; cv=none; b=H01v1VU7Db679qoaetBJsKuOFsB9IqvYhXHPdIzZSsBYm5y6vw6OTofh7giqMKkyYC8Rg9iPqHdjT4bxcngkt5OkoTG9wjOFQCTRrX8OE4NgAAhtUdNPPniTsox4/34YKC6VeNBToyhdDtoyuQ70aJXkuwNWa1BKcopGhoQodKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536579; c=relaxed/simple;
	bh=XhLwEn4PdZP0RTYbbC6FrzgWu9mLd96eZRwG4X4af3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNTzdteP5TFurqAeW5Ke9XwSt3de6imfIP6cxH6JyZovkJyG5mkixW0IqQRyikrG4g5W1wUI1cCNL8zwvQzUcUIwya7pwUvo7P347GNltZJH7FKsY7cJTBkjberXZF5jk7VmfFY1RpDlFC38yVEQEhwYnV49mxfIzr22ia/OhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWXqixM4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWXqixM4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779b49d724so6082105e9.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 16:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536576; x=1767141376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfSALm8uaOF5x8QSeyCnfwJfjNN/P6BDKiycuybyyaQ=;
        b=gWXqixM4S+fB6WXHd5P9/zL+1PBBYJX47fYCyNmVI03SBogdMR53vuXEgnBAB8i45d
         CgQbhoR1h1biWBEH4j5RBjf+s71F6dG0SG8ik2ctnF2aFXZ0mKxQRgWMGgk5x+CTmibj
         358Jee1rGbWh4rSSFOU5FJwqTkMO2PaSoy++n4JS7WbX7tEc/E2JSGOsG01CwvGgwMd2
         UdsYYvSc8I3ziZ92cDkFrs1nvAW9XLCvy/rW8JBftfVzeycUj3ohMH8gBWNo/33Ny8Nz
         CDVrP7qC4aOluvgl5OYsLSZOQZbd4Hj/P2uffk1eYs5OBoVBJeTuM6PauwQxzJZRdAAN
         rY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536576; x=1767141376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HfSALm8uaOF5x8QSeyCnfwJfjNN/P6BDKiycuybyyaQ=;
        b=t/l12SVb0pew/7w2ZmkbhG//0N/AV3wQIGx0j7xyHyBBHI3qTXUPXSfOeLrg0GxmVg
         iVtmUEIoAmBlqVzSQDfcttf5EtXMXEEzw8wCb5EsC90+ca9HSjOv6VbBKv0q0gEhMpK8
         EUpaz3XGPL+v5qft9vfGnj55MZj/mmReS3Woqafv2kSoowtgLJhyp0Rhpq9Afbir1ckV
         4yz7IeJjfbn/eUA7L3HSwY51cX9/a07HYF4qtSIU9VQ1A1MZ0396PFNhAKPvqsYerexM
         hZndb1g7qGW74nMxZ9HcDgE+pnhr1eeWDBOTg2X3bvgAHi+e4AM8ldLbPArR6FFM9nvl
         FWDw==
X-Gm-Message-State: AOJu0YyHp8FAIrYiFeNE/PHw8bxYHWHR8RyoovxsfEuiLGMjsutOwDCV
	hUydTFcXL0d4s9I+Piy3/daiH6lsnBW+0gVJrpbLmClR20k1zqkC5/jc5s8dHA/X
X-Gm-Gg: AY/fxX78e+U1cZEGRJfDHe/rKe6fj0PN35nkkJlg0UFOUMXSma4rCdMA/DGNIUNIKH4
	rJh+U5Xak5LrWj/cu2BVzqU+8wuN9ha1JKrysVNiey8TwZ7Nh6C424zye5QzlGWZFLMLvQte1WL
	quncAc13XbRL485FqqBTQwtYAx9v6ThlOZfuXmIvUSgw9vh5iZguQilUEjqw751K1RSG2/BbrAs
	3qj1yPCl7QmR7sGRzt9Wv/+EzoGKJX4m30SPkLA875/AEaS2gSAuJyzmmZR5yU30MfMJ9rH/6pF
	/BBq3mQy59pNdMHIfAeIDFXs43c6QClzx280cRDP2zp1HuxyAK/zJjKgjLr3MKgUD17rOBunSBa
	nSG3ModfwQ1Q/H0bc1bnAQzQaL0cEFifXM5w1wAV624wuhC5rCYb3BGEKc6Vdrffdiyx5g6emN+
	nSJz2USSWyKfYgDuQBlCU/SVHxiG3wb2H7VEMtF7Lff9GOJlutvnaPuJO/jFzYpw0t2eUEfA==
X-Google-Smtp-Source: AGHT+IG/7yzs9ffRSyTE5qjUiMah1tEN4D50h7M4XlWOPJrYg7KoDM8kFAzebPlZZwTGxa8VO2FxhQ==
X-Received: by 2002:a05:600c:3151:b0:477:a203:66dd with SMTP id 5b1f17b1804b1-47d197f69demr100876185e9.2.1766536575870;
        Tue, 23 Dec 2025 16:36:15 -0800 (PST)
Received: from pc-128.home ([2a01:cb15:523:b100:b9d2:873b:863:c3d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193522cdsm255240075e9.4.2025.12.23.16.36.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 16:36:15 -0800 (PST)
From: Matthew Dodd <mats.dodd12@gmail.com>
To: git@vger.kernel.org
Cc: Brandon Williams <bmwill@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mats-Dodd <mats.dodd12@gmail.com>
Subject: [PATCH 1/2] upload-pack: send shallow-info before wanted-refs in protocol v2
Date: Wed, 24 Dec 2025 01:35:03 +0100
Message-ID: <20251224003504.52660-2-mats.dodd12@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251224003504.52660-1-mats.dodd12@gmail.com>
References: <20251224003504.52660-1-mats.dodd12@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mats-Dodd <mats.dodd12@gmail.com>

The protocol v2 specification (Documentation/gitprotocol-v2.adoc) defines
the ordering of optional sections in the fetch response as:

    [acknowledgments delim-pkt] [shallow-info delim-pkt]
    [wanted-refs delim-pkt] [packfile-uris delim-pkt]
    packfile flush-pkt

However, since the ref-in-want feature was introduced in 516e2b76bdc
(upload-pack: implement ref-in-want, 2018-06-27), the server sends
wanted-refs before shallow-info. This violates the specification and
breaks the client (fetch-pack.c), which expects shallow-info first.

When a client performs a shallow clone/fetch against a server with
uploadpack.allowRefInWant=true, the client receives sections in the
wrong order and fails with:

    fatal: expected 'packfile', received 'shallow-info'

Fix by swapping the order of send_shallow_info() and
send_wanted_ref_info() to match both the protocol specification and
client expectations.

Signed-off-by: Mats-Dodd <mats.dodd12@gmail.com>
---
 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 1e87ae9559..029ca93e69 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1830,8 +1830,8 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 				state = UPLOAD_DONE;
 			break;
 		case UPLOAD_SEND_PACK:
-			send_wanted_ref_info(&data);
 			send_shallow_info(&data);
+			send_wanted_ref_info(&data);
 
 			if (data.uri_protocols.nr) {
 				create_pack_file(&data, &data.uri_protocols);
-- 
2.47.0

