Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4D3E169E
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389633; cv=none; b=YZecDx/efkcxfgAlW1EOAUsWYcrgmBzXhnmOIkwRA7YFW+LmXc0y1Eh0yb7MuHR5lLxwl8pV5pPrfeszwblQaOzdIiyFUQPP3HyJF+hJ1IsRwvlbX8gjX4LY7nTqxyw6M4JAtidf4TzpxlrtTnUgoSXuUKH88gxMbFAMwF6cRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389633; c=relaxed/simple;
	bh=f62EsdEPNQVwUF5wYtG52yVBWaV+IstMQ7Ww8cGc7OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrbge83wwncSyoJDVqcGiHwC+U9Zb7JwzQUP/BiTRkZDjaexeDXIQzGj7W9QfSf916EyQOQTL1J4PwHeqFo5fUku6D91bAaqVZKfEXTTX3rsDpMt+xxnftgDP8pBzWGolegtCkqHgbxZfDMY+r147qDn+wSfJHFDsoCaDmRGFqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXHTgTr4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXHTgTr4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso7912845e9.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389630; x=1782994430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3v/SfigXrEZaFnqWWaSZ2dI2i2jGUaGemExufyYqqU=;
        b=NXHTgTr4rkNODfu6ytTxokmdpl6ZJmiT7FwP65M+TY6AMnW5WdOflZ1x1g+lL5w8nM
         DK/x8FPtKeTeLdzHkaDxsYZqo60pSk77CEfE78B2woehgF3inffiJ1fCiqr3ZjJl3Xs6
         S0AETzmWgiL5MYX9i/23zLPRbrHPjrg8SwANY5gxcym8QSxdtoeSskfvHUjkqJWqMxoi
         xLC56UmTWLmLLm7Mt2LKiXx4/sA0Am/LsPEFBqMzPLFdQkiKOgROujlOyY7dbQ/Y2g8I
         HeVVPtiMfpl6I9+114qCb+xMJA8VLuOckzlwk5FX3e764iX7FypirfNEU89HcgO8dUOR
         aVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389630; x=1782994430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3v/SfigXrEZaFnqWWaSZ2dI2i2jGUaGemExufyYqqU=;
        b=apPeXKxgg02JbrVN1DXBLBqXadA0wJ4c5vY2W1O17uZyuTssOIGRhv1Nji2lcb7I1F
         47xJJlxDmm7KTJRAuFkP4PkGEhsyXi9VdoVZmcqz61lXtpeTqURRZC7zr7NC4PCn9Kec
         ug3zVBWr2HrDyLzP2vCV/CQlAuJAMR3tMMqBCbCuKVOWR9YZb54f6mPlNKx0hlep3uVI
         gOEbu5OrNcmU9x1dfb6flX5STCcbAgRBZjnuWBKaTXrsNlesBSVU9tpSbt2UJac4reDi
         R9C46FNr1IyXCRg2XHgTZ8JnaqQ1PudjPLx/gv30uuMf1/cn/xSfCvvemssOhf/qLqau
         Fy7A==
X-Gm-Message-State: AOJu0YwdKWDTQVsHpIslu6L8VC2zus2bjcweaw2FP54CPwLVLy/tmouC
	WZt+ePzdUbfVi6qdtwUDDPN27pvBW7G8iFP0PObEGQMyvV0Ls2IxrHYlWlRqTzsP
X-Gm-Gg: AfdE7cki5BGV7Rn5LyycFWZZA22Uz/wvVT9RwO3DwLzqm4oBLWs0gLmRo8d4jsKgHIS
	ANSEvhP8IG5bjg/tRCkQMfMyFGkuvZ3roA2QFXSbfoVIMDFdxicaFdPBYETzoEO1hFa3M1e2ztL
	Datn+MzQZQy6R+kkdFf0JdtrwLEO8mff/RxaVM7sDI9D3Xd62Lk0yHsDw0P6pXHRJfkKv4TbA2T
	Crtou0CIChGECoSXBu2YjwIQwAd+uu5HUrEHtgWOr9/r381EY+B5HOGdIzB2716+QmxUQO0C8nd
	suhbxLYwQRtbMcWnjlk6lhe7RJWd9T9jfvMsBc0IT3pIeFeL84W9fEYabTr3tar/Dakk1xDU+ZK
	osM91XR0Z3hkem9pr/IViZjmgM13JDzPH+mrJ5OxV1Vh+xcy3qFsxPpju/o+4KSJm80ZCYLRl40
	i7FX7k3xci+K+YuHjjZBJCk2AlZfgq/Rc21DUDoCQEx68e1r8eiA4Lmo7bR8gSwaydYSCvBXk5F
	R7qtCYQ95BHkRIO27a6ub1q4OMqtO2lAxxe/FOvGIu6ZRngH6Jwwq7Amq5lv42GhVucvra1TfSf
	X7za/t11Je25Dh2UQn9hR8OmLGQvZKzv3N4CEIqj8sy6Q8cdINyQ3oYTg/+5xHAAyPIOT7cO/uv
	i0wXupq7CKquFPJhz5G8j
X-Received: by 2002:a05:600c:4e0e:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-49266424176mr32525925e9.16.1782389630187;
        Thu, 25 Jun 2026 05:13:50 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:49 -0700 (PDT)
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
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH GSoC v14 09/13] serve: advertise object-info feature
Date: Thu, 25 Jun 2026 14:13:31 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-9-09f7ffe21a53@gmail.com>
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

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 serve.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index 49a6e39b1d..2b07d922b3 100644
--- a/serve.c
+++ b/serve.c
@@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	/* Currently only size is supported */
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 

-- 
2.54.0
