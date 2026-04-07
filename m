Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674B3A6B83
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562788; cv=none; b=ia6H3JFJCJOP3VSbDlPcvJr5wEacIuKY2IL+2sTapwztY6EYXSpGk1xwuhb/QxjEAV9jSp06aqyT/Su42/7mLd0aZdoGIjvvNCPFzQo6gvfbNU8KgmR+t///mnSIbLbXjaucdOu1KjxQz0/9vQ6iiv5DXOsQJh50Ko/cPtqK4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562788; c=relaxed/simple;
	bh=ZkcNX9mSKtu3byVR3kRl+1XHQdotV3L2VtMmIbdLbMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toJOiPNoCSAGTM9QSBo2hST/CpfK7Zgen5+9K0126nuYAm4VtW7h4RebrjwQLwEqO530CVgOYBgEnPF0wUpud+HJp0sd3vPDipWEeoEcl4+Sma82xyA+UR2oQvho/VkVAHbHgiAIvi/qF0gQM91GbdmkTOJfUK94E8jkZauiFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmfZLfzQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmfZLfzQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d029f346eso4224068f8f.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562785; x=1776167585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2mP/RNv9L657zTHfEL9Pv+5f2VUH/fISXjq0NL0Pzc=;
        b=AmfZLfzQrblxYol84jirxWkDIqVsjO2HTJFCBBIrV7uedWwf1nsCvWbwTaGil4uCYd
         V33hCvu1yyzhrr2rqjS3nykK4OUu0BPwDzRbsuByq3nZLXw7gRE+DsDIDKB1lf241lby
         cBiJp0WXtRo9fNx9z/NvMIFBKjtcfWtz/LTds0xVf+IjqHQjG+BoRa+Z0SxMoRjAoc4C
         0jGQ+2FuDq95F/T9ZEUmTSe8qaOl+d27R9GRwoRurwLbCdXvf6DBaIqLjxCWwJ+8oxxP
         u0hwIrGvbmltOMBaTht/Mx6pMi1dC+Uo+9Q8s+vXHpKWtRWecU3VbahSkGhNTyTkTqql
         y/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562785; x=1776167585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x2mP/RNv9L657zTHfEL9Pv+5f2VUH/fISXjq0NL0Pzc=;
        b=nqe7yiJ4oCeVUA++q/uCjBx3hjyynZWca2uQQScTv+g7BYgz4dOv+gXMU1yE0SCr+8
         shYLKM3yQgORWI4Zykbkld6/6u4yAkPrmt+5I9CeJQ+we10Rpkf4EykDS0/txuQ5XiHG
         GMsVyjp0Z0Qf1X+C8EUOuzJBGo5MxcrhrHfAxWu2/r/qdxaMlza1S4ZAddFz0HjSXJiz
         K4X1iwFWH69u/Qdz5Be08zbdvm+0TfUvYbHUzCtYp8e1j+2eZe1pyD2QxxTuLBknuiBj
         jXETReIrgXtGrojcxEflGG4gYPYeWwK6CURbs19TyJpKLJnNc1eS5t6mI2Sai2BsI6lp
         xgIg==
X-Gm-Message-State: AOJu0Yzk0eFVFoYz6HMS+9/3OxSqEkz9XYt3TnPnN2WGBUidYIe8SlHP
	UuZ+oZMg++XTrA/78UXfkb2e3eXNwFbW1xeqZSDy+Whd+N1huh/Hg5Tyf9w2FA==
X-Gm-Gg: AeBDieuxEdqK9tPyCWVXGBsLDcDvosL1OF92Aeg6ZitbT1f+BC+r8UES3OyJvMpHctL
	m6gda88MlABnglC5ENMQglXNuZtd7ytvJqGlywofR5wplqgOzbHvkTCz/s7jLxYIsGe3EJASp9C
	Dhgxy9CCOdCVjCGP5e8lEUtVAeTXY4sQGgPHIuFnYAn8bJ2Ed1cbLljusFdwxvitcXwzWXosQMx
	/pz+BIUY0a5alKw9ryd2xrkCyCcEh2i/e/sCqeSOFpirLT2b1PTrAL9Pq3puS4jw2I1H4Iu6hHi
	LmbJR0aB26k+qbUN5pCbI3Ltg+crR8iOzyfz1sc34n2RBSYmzNy6hlwr9ofvcbJ5oVxDZZi+06Z
	w8dIME+t5ecxQJSFJ9xn1XOpJ+ro1ikx6yXx7xLbcCd3iMk0kqlGlu/e/LuTV83+NTRyjeM2Rk7
	QQImFEj8gzcwr7q9C4xLi7gahkfsTziKtNoGq0vR/OjMB3NfYQU+BYCofQJHvy5wXv5xCuWxBep
	UrUFCkQLFiFpPRF5hSLO7sZ+8jwxh+6V4Xxp8r8VykoHhtJmQ==
X-Received: by 2002:a05:6000:2887:b0:439:ae2a:755e with SMTP id ffacd0b85a97d-43d292dab2dmr23364171f8f.23.1775562784599;
        Tue, 07 Apr 2026 04:53:04 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:03 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 03/10] promisor-remote: clarify that a remote is ignored
Date: Tue,  7 Apr 2026 13:52:36 +0200
Message-ID: <20260407115243.358642-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In should_accept_remote() and parse_one_advertised_remote(), when a
remote is ignored, we tell users why it is ignored in a warning, but we
don't tell them that the remote is actually ignored.

Let's clarify that, so users have a better idea of what's actually
happening.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 6c935f855a..8e062ec160 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -670,15 +670,16 @@ static int should_accept_remote(enum accept_promisor accept,
 		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
 
 	if (!remote_url || !*remote_url) {
-		warning(_("no or empty URL advertised for remote '%s'"), remote_name);
+		warning(_("no or empty URL advertised for remote '%s', "
+			  "ignoring this remote"), remote_name);
 		return 0;
 	}
 
 	if (!strcmp(p->url, remote_url))
 		return all_fields_match(advertised, config_info, p);
 
-	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
-		remote_name, p->url, remote_url);
+	warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
+		  "ignoring this remote"), remote_name, p->url, remote_url);
 
 	return 0;
 }
@@ -722,8 +723,8 @@ static struct promisor_info *parse_one_advertised_remote(const char *remote_info
 	string_list_clear(&elem_list, 0);
 
 	if (!info->name || !info->url) {
-		warning(_("server advertised a promisor remote without a name or URL: %s"),
-			remote_info);
+		warning(_("server advertised a promisor remote without a name or URL: '%s', "
+			  "ignoring this remote"), remote_info);
 		promisor_info_free(info);
 		return NULL;
 	}
-- 
2.54.0.rc0.114.g05d466edb8

