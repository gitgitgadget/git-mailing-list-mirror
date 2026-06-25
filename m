Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C13DEACB
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389624; cv=none; b=XAkPw3WqSdM+NDdtxylpraKRdQBCtdDOCvUYWgfm8/DjfW7s3FGuu83EK9+Qk2XGH7vszQ7+Qt58Ep+7PGdFig6NLrQcBXIIdaJi7M9amQRyS+KVwDmf9kxYswUhUKyo/muE0G10tXIhJ/u+aI/nBZ3o2nklRAwTWNU5MXkrb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389624; c=relaxed/simple;
	bh=blJ5FqaWdCTfda2s6RbKWHltAxOuo/rKez6pnPXrAtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvj8PYIffJIQfEPH8uWMfx3YDFALzx9aaaZCMzzDdjIM6GPH3AstgcPTotPbTrc4X6xMJzbO18YiNIAiMZL0Uk/W2ILPb33z6+MwHzakDCU1Z+UUblWm6gyJHrKP7XGNwZcOqXI7vJxxArodOzfqvF7jLyIISpWYVvpkOSaHmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biU++sgN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biU++sgN"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49241a577d8so13715305e9.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389621; x=1782994421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCNm8/UFFIh3bKnUZ6YECOpZnxUit300Bx1rdYzNR2A=;
        b=biU++sgNzJj0xM3T1V6TZs0xpDhy8jCm1Zww5Y5pxAUBXTD3TxylHT7L3HW9L6vbSQ
         TIWu7bTin3p9jrfgB3oTW1XUodd0iFFDHGZfMNUMPAEjjTautjabpO/h66btQzsLrFeI
         GDehI6907oOE/1D/mi9mGsgtO7UWTqJsLS1471KjE69WCVhrgE7mSIljL0SPqipstlFX
         qogxfhASt9kOpISQV4pL7ZaafN95JPcqKJYnZ4AXOgimRT+s0uzaPN411p53MP8D4534
         6M7VbhS3rIr67X7av4WtNLxPKc80sj+UDQJRfbGdqOXfQlNkiEuTkyrXl6N1BMGuVMRk
         XUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389621; x=1782994421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCNm8/UFFIh3bKnUZ6YECOpZnxUit300Bx1rdYzNR2A=;
        b=CoOMqy3PbHwZftubMFs3KAkcuy40AJrH1GeSm/MitHBGkCuRsRw2AVtvNPa0ii4T5k
         yl/rdA7IpZRb98fQia4tpW2f3eIwRYGw92IPJJErv+HgpgNfnhnx3VYLVI7PznltKwPx
         exQjyJilY8xMIZwBmoJ3smoHdit9VQWRG4a2H0TpB3ovMuOdzkAdEVxhjckCsNkBHHeX
         w/I5Qx9DoUT/F6YxCVnxqbMgfscGh7QayieLUeAEnK33aAopH63XqIyyDm4yAejz/qq/
         wvIB3Fi+IfrccseHEuCvamGL5PNTsNQ8ZufjmR8wEdGJpX/O/7ehCJFz+RxEDGiAD//P
         CCeg==
X-Gm-Message-State: AOJu0YxgxitfxfToY+q+C5F8Tejz2cXR9XpElRsAlbDPE9HmxFlE8WnL
	CwUDp17JOOEuJQkG9c9VJSxwkm0/EG1Xtop/hfdZaQgZ23N8irHMgIdtsauXbTQx
X-Gm-Gg: AfdE7clxvvXMZoDpmePC6s69HDYk6ESc5PoZrIynnq+4K0Tt0WWLVmS0NIrVbZUVaL1
	HmwtYpfMh+42EMn8k6IScTFjhwvwK4kiaIfR53aEtgCj+jSqvKmnmOKD1IC/x711aSBB4wkmGHj
	mY9m1EqiE2EAqxHFdBxwz/w0Ntm52OhgwLVhN3fv57BU8GXK5gq8gMDWO99/OITdg+Y/2V/34Zi
	4PiClQKdFW0nlFF7UbzIhp7PB/3VlBceSzjFzJhBclrCBV+9vpbXGr7y1pahEXPen+7VhuZ0RoT
	ssBHK56wBw98wJSvpgBfa6ULMzR8PatPU9bDguUPbJgkumKcrxywtVZHB0wWNuOOcsWgsTsz2gZ
	tgBRPNAM1BarsWEOEpL3ntUU505rIOBOZ1u6lXc1xj3iknxQSgOQCePkc8EOPhEfR6hykBcFokX
	eBvt+ChrERFC5WltoXg+EIddQPlx7Nh18a/sHfYEcyd2H2sBcRxQg/Qgg/Ps0x0ymXul6VtkZWE
	SOEO5pjoqHUoVtUKTtGOqd1FQL2BdrtVH+tmHh4ngHNDg8o3Gzyz8kcLfuuP5MnY3d4E8yIxFoT
	Dqk3EDZT7DSWjyExHg/G82nqsezf8tAR8m8hmW5Zkedvp1Xfb17FSAdaZP7B1IQrKm+XHYHEbA2
	Q/V3UZHp9Qg==
X-Received: by 2002:a05:600c:820d:b0:490:bcc1:4edb with SMTP id 5b1f17b1804b1-49266884b7emr30332925e9.27.1782389621185;
        Thu, 25 Jun 2026 05:13:41 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:40 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v14 01/13] transport-helper: fix memory leak of helper on disconnect
Date: Thu, 25 Jun 2026 14:13:23 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-1-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

disconnect_helper() only frees data inside of the if(data->helper)
block [1]. When the transport is disconnected without the helper
being fully started, data->name allocated in transport_helper_init()
is never freed.

Move FREE_AND_NULL(data->name) outside the conditional block so it's
always freed on disconnect.

[1]: https://lore.kernel.org/git/05fbadbae2184479c87c37675dde7bd79b3e32ab.1716465556.git.ps@pks.im/

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 80f90eb7ba..f195070788 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -266,9 +266,9 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		FREE_AND_NULL(data->name);
 		FREE_AND_NULL(data->helper);
 	}
+	FREE_AND_NULL(data->name);
 	return res;
 }
 

-- 
2.54.0
