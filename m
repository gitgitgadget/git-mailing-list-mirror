Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1573C2777
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029518; cv=none; b=RdrZ/gsaR7WgnBV7QsriflRckusB0u1yvCnyR1mFiQDUEUDpUCxGUZJ5//lJrh/BWt8pGJsJbo1XCibfKZMvn+xkF3kWRxvJYNjCzrv58D4nobV/xFZb8P/V8qOsKzzBWnnu+XcH59RkIS1fOm8MYyUuI3urSDKlcXJ3RUjPTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029518; c=relaxed/simple;
	bh=ybf0XRPB6fGoYcQWEAjIRJsRXBy407C2wSdjBILB0Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKZdhVUN725hvSn7BqXGomLEcjEC6B+3D1BIslr9LcqQmJSYb5UqHI6/AUoYmsGSbjb8PGPsa5PoJ6+xPEW6YThBtKFDcGtHNkVMwQ31fPuG+2qobY+X/kM4LC+fVD96hB0zbPnScFcTg7Hwj3Ea077reFs6Y++xcuXJzy6sZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYtHjXSk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYtHjXSk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so5867805e9.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029514; x=1784634314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=XYtHjXSk63VJ841MOPNCdjMqzMRQ71kfOqPYeCjUrcnlUrGU8KWsZVq4SVqnzeqjey
         bjy1Hxqms7ZcqPyypYduH+A6qJp2NHBYiX6+0xGtTbm1xgFx91C+75sD2i2MGHqzCSfB
         fbMZcu+r5z63ao7K2J/uu0219lW28sSGJ1m7HkzULmBQm1odOH4cxE8ENRbnp5fwRKaB
         7nIip6bGlWxyvldMTnw/9QxLIsTlP5xGS8O36V8qH3EIyc4JdIUwFWLi2EJo7AlObvqM
         jpfuyrGWJqW3nuVZi0Rfs7ksXKFdWDApIGYn7o/rX5f3QkCqLV++WjD5IY94NJctzZNH
         Umjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029514; x=1784634314;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL6y/at/qZ1hM3e3LquL/YeKXpvxJqFCpAqasseW+Dw=;
        b=enQkpX5pEhnYjEdYL1y8MYa691u51fsesQVsipi0qgRKD83hKRKbgwHBgkit3rx4vR
         2nbmziGf1cj1FfwB5c43Kf7Fp/3R+41Y7AeNM/yOtInOfwv0wdVpc7as7iflDNHLE2mr
         e7lzWhrNb/DEN5Eo9NCcoCl2EiQhve6iM8jvQ2Ex46t4Aw6j4fNjcCcFc0a886ltGrZR
         g5MQUOvFZlbjwYjruQfTo2WNNjlkma0ZpMyMW0D/c4/Tl7BuMemy6RGS2n5xg74RsHgh
         vuNmqnnKyD9v0PJkmFJbCDQXcqSkCLUHNYLOsnw3IImiwsVoXBhm8PxIQeBcNVpwtAQs
         82wA==
X-Forwarded-Encrypted: i=1; AHgh+RrEm5meUHz4DesK1bhu1RWSu48mVV52Lf2SNSbMFj2FWKwJiXz1iCeoLnA/XeoXSS9y8j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymMbYo1CXrTHpaA4cZ7fxZOxE06qTDTVKjTkOQZIHvbZiFD+nW
	bv6BSp9BJIA2BwvECEVBYM3jFdHcFzFvxKbxm3Zd+cDrqNM++DMH+pyz
X-Gm-Gg: AfdE7ck3UVAJHC5mL5H3640xZYqhGmYQ4K+4cNpNtL+aT5pzSpRwxd1RcyZnYalquxU
	kJERn8oytafdwY9pXrVXZakpZIuizzu18XhemxAUYGu7x0TR7WhLKeCb++hdjaoAE50PL4XjVxU
	0+guHTiRzKj+yUzHlj8dKqFKARvs5nOOv5vd1nsz5WpqXN26CCqdR3W8y/AhFwlwLy7g4RoqO3/
	CNmTJBz6PvWcjP7t9CB5fx/fJdNdY6cn33IKakpME4OV4Za6AhwXnklW5Z4FdHVg+2AsM3r7XWx
	W3lp+V+C9drJ170plruF8gTVzIkdnY7ypPyrbnOK3Ydn7JpHH7vm4xj8Ajcv+rajyN+8PyYHxxx
	JAtoOI6QLHRuo8tPnIEkd4WYXewhNArJhLFGwpPJFNyho6ZunANxcUhTmcsEDk1NEpEZ7if2/FY
	/DXXpS8aAIDwplUP+SpyPCbL5B6GiN32HeP4YbW6zBfMhZ91Z1CTZA9e/R2vbeynpYAbjiE0V5W
	K0Ka/Rv3uWnkniRFnq3c6g+mHYDVu2/US4hsGt5ACFMa5mNPRy400gKXmJEIe+G8csBlqL2VAh4
	i5TkFRMOxdN1kM5iW0O3yefowSvoTmNnAqyC82LBFF2G7CrshBInpJx+gowAIo6eO0efZAjSgyd
	fUmH+oMr9yEhhjt4z7APX
X-Received: by 2002:a05:600c:4693:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493f882993fmr131208655e9.31.1784029514102;
        Tue, 14 Jul 2026 04:45:14 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:13 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v17 01/13] transport-helper: fix memory leak of helper on disconnect
Date: Tue, 14 Jul 2026 13:44:57 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-1-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

disconnect_helper() only frees data inside of the if(data->helper) block
[1]. When the transport is disconnected without the helper being fully
started, data->name allocated in transport_helper_init()
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
