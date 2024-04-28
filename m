Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6124B33
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343473; cv=none; b=E5ko1t/65Jn1XBbJ/PxEukQM3IoSuCD0uJ4Fb5s7HY5UvRBWGTWmUvy3rpoUWw90CP/ELk5eq0+qB+uYGulVwXhep8s7tDE5qJtWN1TyFfuUJ2QbfheR5K1zLI8uHd2hKid0VdzTdELD+S3D59S8jq5LqfaJjPUTknB6uOEjkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343473; c=relaxed/simple;
	bh=nhPC/OVyEJnhdpdQA8wfXn6c1YSIdXh+KJCi1cvtJCQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZoBe6M9Ft1RpjdViCNBciM0yBFtF4WebmTKrg9GUN3P6RU/sWbM0h3Cl7RntulFUvEW0S5E55ZLtEOp3WaYlD7EQFAkfbdOKLyoZ4nSSl2N5Hxp+s6LXYTDdYG8k/w/pxmnqJecPPMtwfM5RpIwkIMxsWP0dkI1F7SNgKTAkX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvK9f2Vp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvK9f2Vp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34c90082dd7so1435950f8f.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343470; x=1714948270; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/Iybmms7U4YfPv6VSfCySdUklGSldkATf01Kvk/SdQ=;
        b=hvK9f2VpoF9UFnPvRhNa4Q5e4uXt/iamUM2TBlogG6IkTTimpwM3gvJMiaeuuaFXWU
         CtIX6+AtQkwMFBSM33aekvAPAoXoQoWMXeiJxrah0uJ/Zb9Ml6WcxKP4AAe/8jD158mb
         WpSIhcEI4Gi34lKWTejrR9CkheOMONpg+Twig+rHlNS1GZAt3xb+AaTeJB8ovpElZ1sw
         DMfdy1k+0uxTvfW6PupNov6MmiDJwkwABEgHaWOCIf4nVxK/k7/laHVjW1PmMEH+egp+
         Dna9Ce+mPnQxwbptW9ISMMJ3qrxB3tsrpeNP1ijfWroqKYrBAOOI1wuad5xlieotdFn8
         y5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343470; x=1714948270;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/Iybmms7U4YfPv6VSfCySdUklGSldkATf01Kvk/SdQ=;
        b=e9stz1UuTrGqW8GdHUlT24oMjoMEmB65E04yKmnXa++AlqXnVz5XXMnRQRev3gMowO
         FG58Phhdgmfv3IjG7XbRp+LbH92yuqQJaWr+Do44o28JSsHzJO56o24mPSj9yqaxeSRe
         3SPlqlPRxQV17scho5zmUsLFce02aKFd2D/hFYgq8VlyK7XAK2cJFGkr4Pa4ofHpw/qR
         gOX6X7e0fnh/6CxPd5iGg7hbPPZW+6UVQMQ5NzRdXCGxqxYprzgPNdtSfQqTQGoDtaC9
         pQvyie8RW7PHntLCQ5c2+6DJY80ZiWNdj+l3zYzR6BKvJXpYENj5dQrMMY2YxRS9NraZ
         XJ1A==
X-Gm-Message-State: AOJu0YxiJMFw64BBnlr4oIvkjt+MuQmdrqe5bjDD4tm1lbFN3DakgVem
	68ifVEvTq0KZP5PnjFaxiEMBTSoW3DVWa6hFGDoeaPyyzb692cGmV3R6Kw==
X-Google-Smtp-Source: AGHT+IHzn3ojuGUAaCl2494dQiO+bMvox0zMVkOfgiO8Sws/Q+u9d2s6k3Uev2ifEjfXu+dx38AcfQ==
X-Received: by 2002:a05:6000:11d0:b0:34d:118f:21ee with SMTP id i16-20020a05600011d000b0034d118f21eemr799666wrx.28.1714343469685;
        Sun, 28 Apr 2024 15:31:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6286000000b0034c124b80f7sm9562216wru.61.2024.04.28.15.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:09 -0700 (PDT)
Message-Id: <eb9ef8a17bd123b2611d5df0fab4364fbff4b277.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:55 +0000
Subject: [PATCH 07/13] url-parse: define string to component converter fn
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Converts a git URL component name to its corresponding
enumeration value so that it can be conveniently used
internally by the url-parse command.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 builtin/url-parse.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/url-parse.c b/builtin/url-parse.c
index b8ac46dcdeb..15923460a78 100644
--- a/builtin/url-parse.c
+++ b/builtin/url-parse.c
@@ -32,6 +32,23 @@ static void parse_or_die(const char *url, struct url_info *info)
 	}
 }
 
+static enum url_component get_component_or_die(const char *arg)
+{
+	if (!strcmp("path", arg))
+		return URL_PATH;
+	if (!strcmp("host", arg))
+		return URL_HOST;
+	if (!strcmp("protocol", arg))
+		return URL_PROTOCOL;
+	if (!strcmp("user", arg))
+		return URL_USER;
+	if (!strcmp("password", arg))
+		return URL_PASSWORD;
+	if (!strcmp("port", arg))
+		return URL_PORT;
+	die("invalid git URL component '%s'", arg);
+}
+
 static char *extract(enum url_component component, struct url_info *info)
 {
 	size_t offset, length;
-- 
gitgitgadget

