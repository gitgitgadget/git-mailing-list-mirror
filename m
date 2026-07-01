Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A047F2FF
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908334; cv=none; b=cN6/+QGb8j5UUY5fHqAawjScOlwP0e6e59aF+HVsHRZLVFBDdDYN3H95kOEVKtIG+gpIkKFQbtx/Xxx1+aoaB8vSarosJdvEAYSSpfRKtAQCDRsGSU8q1nEZjdru6znT5aPMW+jTatRDCf+aMOHoMP7M3wz5w6y0/HxTxV6P61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908334; c=relaxed/simple;
	bh=r9pJlkMXqrQxmjlea3VGw9fE/nPm96wklcNLv9EQKkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gm6QP74qgkG6k187pVljJVzz/uIW1nXhlTVzt7OptJJoWB5Adlk/lEQ/2e/ugEefl3gbrbKEyGl+5ly1uAl+ySP6h8lS6xtzsiYKihoVJ33+yF9JZulyUMvKqGuA+y9Trsss5Z69ygZ16ZKTf9QpFM/Df2cNIPPM+gJtm14JMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElpAGz5p; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElpAGz5p"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47248615e4dso564672f8f.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908331; x=1783513131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdwllSGukEFZq3ZNGpF1h3lg23VcAS0sOUMqwWhtdOI=;
        b=ElpAGz5pm4GTB4Q82w9jhiKgIe7A/3gm7BFsG9JiPE0+nwF/8pl/glMzHv6guA3C8L
         T0yYUrTDN8QITOEI0BCxujpAXrIjz3kPI0+OFwMTtx08Cvo1KsjiV7Sn20vP3s4PjZAC
         eUVqENHrRiqk5KkZqW6hNFUqAhsp8ivphbdARk6iLmx7LNc3lcDcaEWTWu24ffMK0AXN
         l44WHZtwpD/G7vDd8E2Dm+bndXmYcXOUIyb7GujxG0XLsYCPBPLiwWrtL8QfCYZw5C92
         m5AnMzF4DnvC4nlviTriPkWpIDWGNEMbPPIsCD5KCFiNaoPc3oQ7+bX10oyrVwA1VyVv
         VNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908331; x=1783513131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gdwllSGukEFZq3ZNGpF1h3lg23VcAS0sOUMqwWhtdOI=;
        b=qaFgWmMorh4mNFCy0Eej3AbnxWIAwtnarJFuHZxM9jhtdD37F9TRCWJ7zOGgvNUFqV
         oFPzDQFOX2WJ9W47gJ0db+47DavFow+dOBja6eetzlJ/qmScGUMA7K9K4TluCMlLAdS1
         /pLvTbKXq7lGoPzpJOMWy/npkCn2xzMmtHm+pR+ETenzoWJAVtHKI5ieCZIfCp8Jy5Ou
         qHJAtFsDMf3uHwR6RtFDMyTith+cuDcQnjy5H1hkSXicnMHev2R1ApBodutNttG7YOzk
         8JY0P4uHdYMKSkkdsVooAeuOWLLQ88XPkITQGT1tcQpeUJdELp1SDGNIfDmzxcmx/l+L
         UAjg==
X-Gm-Message-State: AOJu0Yzkwm12whosVoFF3lRnQcODXrLGdm+LzOhd0uSRGwcebIL+zEGa
	fWShBIOCYqfjeO+OfYv/QPc5H6IngJhfa4tYsx7EjENjpl+D9Q7nnuPtUZhrH1j1
X-Gm-Gg: AfdE7claI+SBF5Pp1V+B8SRjeq0z+IT1rf/Bu9wktPkrqsR3etXFNt0MC8HwXlwX093
	O2BBnwJCtJAIvckeYKAf803W5gLv7MGJAg+peQ1sLubaJfLBtwXn9USx11c1144bfS7AScj+ObL
	6d5qnvHPrFxdTzzBsvFdagHkuF1fLEYNQg84xY0RGaJhs1K+AyTSE44FSoUuPmCIOtc+G9b8hGV
	4sgVgwpqycsMAUY1jIFKlssNe6M5pflba+oXaSBGTnIdvLmsOBo2s+roQqqm63H6CI51EbTSsWV
	ALgdm/NADdQfoZHmL4XSiF05MztZgn7fYbMTaajYyPxnzEh1bYueyUH6YGRyN03jaa1tQUPPfYF
	YT45jGEnwnBRpdW728efKkYt65IP9WPfHGBAcI9KacCpH23neItpA7gymsH20U6W7gwvUyp3mPD
	oxni5arOrDARnJ7uWeYYoXhCMYbo3hWx1rfe69zotr7i+IfBxm8mlZN9Q1rLX8cMTmvgqQ/WMqv
	113qNJlnuHMKNw4+U1spP9ZKROgfsbvBCjLdTZnFgS2b2i+Et4U+iZBWBeAkot5JuL3gNOvMij6
	Z0PJnPH/KFsgrQ3Cfom2Crh98xkP4LQ/Be0z14rhlN/eEFwOR39HItkBORCH3VbXDEzoJivv93H
	kmamxBRyRJg==
X-Received: by 2002:a05:600c:3588:b0:492:59fe:4a15 with SMTP id 5b1f17b1804b1-493c2b84695mr17082155e9.24.1782908331118;
        Wed, 01 Jul 2026 05:18:51 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:50 -0700 (PDT)
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
Subject: [PATCH GSoC v15 01/13] transport-helper: fix memory leak of helper on disconnect
Date: Wed,  1 Jul 2026 14:18:35 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-1-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

`disconnect_helper()` only frees data inside of the `if(data->helper)`
block [1]. When the transport is disconnected without the helper
being fully started, `data->name` allocated in `transport_helper_init()`
is never freed.

Move `FREE_AND_NULL(data->name)` outside the conditional block so it's
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
