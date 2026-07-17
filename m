Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91042370D7B
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300747; cv=none; b=k53CsAoS3tvgOJr/Rr0d+BA3iNc9AydzMfEftsD4TOFty9QbjYGa9XkDRP9MBJ0AzeyHsFTNZFLoOtt58ZOugAHLM2XxZdU9jW696vAu9AYlprbkj6cSaIpUTnZDH0u4LOyqhlnI3hCT6vGALREd9NZNIkAhzHBRWDr5XJEB7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300747; c=relaxed/simple;
	bh=7R5lPx1h9vPMbKIqpPhCO21OWUdtq1b/9pV8dY/N2JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2XiFJ3BDvSMMprgb/9YBb8Oo/TjwDKUdO50i0C6nUqJUPviH0ErFyH/emoIXhNI16VKEf93Ug3LRE+IB6Ezj6S8uH15QBqzF4KDUdcMfgcFav8fp68ts+2Sy5DSyxxc6+EThmSv8VQvdxMVi3afpOVqLqARyZZbUE5NHIhiVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHj7aIBQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHj7aIBQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so407385e9.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300741; x=1784905541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1WWvImKuevgwQO7wSsxmfyADqWZ9fs366ywo6QqDaRc=;
        b=IHj7aIBQzO6AfErt08bh1GDZEPL8tzw9MF+64r3uf0Irez/SufbP/Ih87dCef7az9X
         UJiSV2Ct/+cUugdF3z8EUKGFacU7JimbeKOD7lF6m/KpHkvKgTEaX2DLV0edxgsE+yKi
         rNOmHit6kB8gsVOAFqwRNLOf3ROv1W949WClogSLHxs5gLBBUL0Z/rXQrYa7rW9JKQaA
         oJCiq58ZpG0WpR6e4bh74LWdKiiJIttz0b+QDYoR4hFXnTSH6rOSAlOxOeLk1fW1xg9l
         fIzaa7IgoOefDHvexvzA/JsKv1PLTqQAqjmhpy7LvcajNarhz9HmGYkHaN5KCwRdwpW0
         GEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300741; x=1784905541;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WWvImKuevgwQO7wSsxmfyADqWZ9fs366ywo6QqDaRc=;
        b=Cf7Fxq08TuICW7UYpZjTNWqaxLCPp+wVCxJryj0bkfCkuM+2pC2MFC73A/cTtzJ0Iu
         HxOYpH3pgbDyPtiVE/Yk9TMVYnPZvniC03CW8uRuvbLiRkwBdkovgvwvq4tN9q1PDxny
         fN7ihGxehsr6web8X+Y8eQH9usnQep0kBDeYy3cHB+LJrS8tFPyxXtfQg2H3fBwGRQrz
         cgLwoQDGpE/WhbuCTU8zDpGVI6OqYGyHORQdHkF7qGK5tOErICdnNdqq9nmR5W9+tgLq
         7Iny3S0uWy/Flc8FP7m4bhLrJ9T4dwjUCi2ciNLby/Td6zYJCfUkjR/lKiQxTLUjzb4E
         k6JQ==
X-Gm-Message-State: AOJu0Yyn86GF/V3cSpGblCZSH8d8naGiF2OTsPMr3YaF0zcigJdyX6V3
	d9smCN8UngryBr3cZK/JUDHantEvNWWKu0sc1AeZsrbdFBWSmzRVQwo015wmeZd3
X-Gm-Gg: AfdE7cm52lCekvfqVi7qEgjMMj/19TGCsqGrXKaIR69wJjSaXRpSdn6jVHqYSscrlSj
	6I3E+MCQWgc97Nli/n9T7sXzLNQmaaQQEkGDliNXzKqLEAcfh7Bnpr0vZzyxIDlt8U4TObKUbOR
	CQq9m06Ts7uWljM1dD3/KJJ+7i2+Url8ncZHBdSPV7uff4SDYU6Ik0/vWRF3JKCPkSMP+XmROZ1
	wInNgyoce13IP1aie7eBGdju3NhjGHnoJugmKsyGKVua61HD7EgHRpn0ENBOX5bebkZ1SJAyfi0
	avG5ZQ+u9ASKpfoxRvuMiQamb2DYNT8pP93vapstJQNoI0E/SkWH3WPCEXymJsFdGghMI41wxC0
	66OxGXXgXvYZyB2jh+kTFqimygaNVZfuXKn7XF99Vy8cy2HsWqAk6Nw0PkqAQmDoENUug/01bmX
	gua/IBgXZnsPlzzExX55lEK+gqE+MJX0OJd4ZNerv5bEuFP2/mlssdAsqmUXtD0m/yAoRi9JP6n
	YGSEJPCKY0Mzkaa+xdZ0CW7D7iU0EC/8WNU6905JltMxcVvt8Zw8N913LBGkEiJ50g3xkOskB5D
	tN2WxGOqiYctFWyUIY1Qnzybon+84V9y
X-Received: by 2002:a05:600c:5493:b0:493:f80c:5455 with SMTP id 5b1f17b1804b1-4954a3d0cb1mr36675025e9.5.1784300740825;
        Fri, 17 Jul 2026 08:05:40 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:40 -0700 (PDT)
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
Subject: [PATCH GSoC v19 10/13] serve: advertise object-info feature
Date: Fri, 17 Jul 2026 17:05:20 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-10-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
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
provide, advertise supported object-info features. This allows a client
to decide whether to query the server for object-info or fetch as a
fallback.

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
