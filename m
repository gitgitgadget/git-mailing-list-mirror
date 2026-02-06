Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5E247291
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342441; cv=none; b=W8+vTRC7tYfN3HHdj9+yEk0Q6P1YJDygq/he8fkkqbmzE3HCcDowUbRn0oriW5JjxHUkYoMBlo1sVpXer6P7OHdkNZFLI1+zQ6mACvvVCx5IWNvwut5I9Pd6T98mILmfiAcgVMqknkyVGVEL5Uvy39iNApCFPOZ1xgtszrTcG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342441; c=relaxed/simple;
	bh=mBc3UL0aqF773pi6HhSda58CW46cY5787XMxr78x5HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9ziBXaoJlfOjMWA2IrccNhEyWTMcbZaVShU9vATVAg8qQl2RxTjs4Y82Rw6xaKV16aeZNGNwsBTn8MU4FjVXYrtYaRfYeSgUXNzdzXzmX7FSUb5ywKh1kfDufknG1TAwyN8upC5MTVIYbYTEBAEaSRYMFiY2Ok1pdHVxbHTEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuT+pF59; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuT+pF59"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9694so2001908c88.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 17:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770342440; x=1770947240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfGBPgxN6wmyCCPoBckFjI/IQWBd18FlGVKIV80Pdxs=;
        b=FuT+pF599LiFJdgAuMsUsO0I3cPLDj6RsnYxjuSCnR26XiGoX6nh+a18Ro318Ph7S0
         CeaGKdt4tTwuV4qgx2zideXh2jKSiEAMuzsHdvIb1+B9GZU9coXHmwoeBsEl8ofANw1e
         7XQ8JAvmsj+katt7GmBBS81AAcyshRQmsXMcJXmcOPm9AwCYsrzKH33EggAl+3TP0MiM
         yjGeoZd7kSJMV40UuFcx3vEFc+8zot0ydauSYSip7cG0Z64yBTVLiSm2+oKvWjRxVrXR
         VMSsFHtv80+S/xTLaH/YRAF2sKVTztYrUKkq2esohJDX31X2d81CgYOub8r+Jsneo5P+
         4T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770342440; x=1770947240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YfGBPgxN6wmyCCPoBckFjI/IQWBd18FlGVKIV80Pdxs=;
        b=MQZ0ntWnw5cWfjhxlVSjWlzv4KbUGpPmlm5AvPysboVNNOfuDxijqgbfXPGAbAZGLD
         EfYJkOd+DD4ojsrvWya7EtDLmmehYl1G+umWbE0eapzgmH6usjPOF9VQa0tC8JuwhwPm
         UJByyBdhUZmEwY+FdBGg+/YqFbsX03vM+0+TF8+03lyFYotjixCjDfcEYUp4IF+s4J+e
         FFKwoWnhpqqa80lt+QCCAB8P0J7Yx4uyxCZPSIU9bRM8RVaF3143UqHFehEIfCXQD/ym
         liqTCvKH23XIsXOAylZBkkxByAhiwOQu7/9puWvh+F9IorInfBPkzwj6G2jC2uWzr2y8
         aVFQ==
X-Gm-Message-State: AOJu0YyYT2jAUtC/mYoN/APXpyHnP080JalIKn+csEicLLW8M1KyZJcQ
	j3tvxVxZywJwbtfJPAFamENfSbE7t9scTK1AqEwX+vGOscWMvJg29o8Gf3NTiw==
X-Gm-Gg: AZuq6aLdRXKG98DqgSgO1xYXv2uStz8gerJA7+34nIU5kbCe9YS+R5mRTy8a+nJL+nW
	TcY+rCg1cvr6u67VGfsmZlx+xk2fhIGJfBhhVlYO4zdwRHnJ5I8noC9fU5WqYRgVYTcRUONbVjV
	EGIFRMmJNQMin8ZiCPoPLMlxDE/MtxZw4sOxfHnbMp/GfGcCdJNdDyw1VruEytyYFtF2GmA6Zhs
	w8xMYDVFRLkB9dvCz8QDPjcNISWbzkLBsoKBiCX6sfmPbPoL8Zm+LtiKKBqZ9dSYqJu3N4E2U5p
	Jmx89Q90a5vMIArI8+neBh2EyD3XdKn+pLN16ilzvAWGzCmzBMzTsAsP4dVgyc+5lHi/Cnc+H3c
	x5o9XB0fszQqJlUB0jN2NBLX1r4yJ+1MNUQWKTszF4h4srYFGN/LtRpWij2wTxqVXaEgtvVhjXs
	Ai2lkY9jOvihdaw/Q3tvf0nX1BHK0oatGDU8c=
X-Received: by 2002:a05:7022:920:b0:119:e56b:9592 with SMTP id a92af1059eb24-12704002820mr514994c88.23.1770342439921;
        Thu, 05 Feb 2026 17:47:19 -0800 (PST)
Received: from localhost.localdomain ([2601:646:8081:3770::996e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d94cesm739878c88.3.2026.02.05.17.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 17:47:19 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>
Subject: [PATCH v2 2/2] gpg-interface: remove an unnecessary NULL initialization
Date: Thu,  5 Feb 2026 17:46:10 -0800
Message-ID: <8d188ce1b8994f0108b49a4cad8af425b09504fd.1770342268.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a53fd33b5696487f941faace90f51153555ce8f4.1770342268.git.collin.funk1@gmail.com>
References: <a53fd33b5696487f941faace90f51153555ce8f4.1770342268.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We assign this variable unconditionally, so we do not need to assign it
to NULL where it is declared.

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 377c0cf49f..87fb6605fb 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -398,7 +398,7 @@ static void parse_ssh_output(struct signature_check *sigc)
 {
 	const char *line, *principal, *search;
 	char *to_free;
-	const char *key = NULL;
+	const char *key;
 
 	/*
 	 * ssh-keygen output should be:
-- 
2.53.0

