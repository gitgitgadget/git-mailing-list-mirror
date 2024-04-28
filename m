Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3724B33
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343476; cv=none; b=l4jN23fQ/T3aPGy3R3S70ge8MgGTUXDvMUr2JFGh9rz+xRaevQn3BerFPMrTVkK0Iqk+UROXfYXpn+JpZyPeB/c1hjmNlqiBaANEC7T5T+/bec012lylbHKbf0n06Z78TKSbh6QYsm5/5F7E+OxYrhKVlh/mv6wgNBLmD1RH6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343476; c=relaxed/simple;
	bh=iN5EUWnfhQfCqPLThpA39n8mG1zY6X+aALSb+Ykp5Kk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rx0ineyqVFVMB0fk9uK57C/fSVSZaZgq+ZwWpdaRL/4An3MuW+DdFMqx2NnH1ZpnJfzuVbPeIv3yamRcjcU6RRV/Fd1C506dS0nJZMJcU46hEXK7RaG32LFTU03tisTalsCZA6oiyEIpLIeYEndDEELGgFrs3woIdqMimYCNsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAGS9Lui; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAGS9Lui"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343c891bca5so3107844f8f.2
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343473; x=1714948273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6AiBVs52Hi/6kNMCH42koxPIPHGce3AzF6yEOX3Vrw=;
        b=QAGS9LuiF04A+jHKuCl5kLr67uTsvIpvwf1jFj412IVtEplSY5ulsD9ibvln/T0g5t
         Nqikb9huGHTV1wNiiA8w+BFDtS0f57xLuQE8hZb9eGrcMOd51bsuC1lKue9X5FC61jOS
         Lnk2p8plhs18TitJk58EyeMcjnIXdyd7vSUaqmX3R5ua1AlZdYoFOkx5OGhsCoTAXrWH
         4lxqC9F5o2lCX1WFmlaqo/JET8PVJkUNxvW9+mJGgGYh/rfxTTvy8rPHetdZAPoiqlgZ
         E1nNRJgfawU2y/revbTibUW2fuxrl3yiK0g3n28MyfKiKJZVeEKvJG8gCd9EMMMJ56c5
         0Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343473; x=1714948273;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6AiBVs52Hi/6kNMCH42koxPIPHGce3AzF6yEOX3Vrw=;
        b=LUAaYztyb4n1NUoCSMJDeiORP69zMhfO2qO+ma7MEPUSRP89axJW+O5ZxYQiOHhfsD
         yWD73N7CDZ/D50gAIYYy4G0iMu7OpaXV8CzsN24kpi7KapGsr804UMUJRcgRH5Hv/Zh9
         HkNT4KA8uQtkfppOtwsK9O1q1jkqGgpo/wwKgnFr/gkz5zkR2mH19a3OrMldXchvhj9J
         SmPE8jAaWZwi5ssG+FQz+YSfxMuYMff4FhFozHpiIKqB5Nc/cABWlgYR/gfW95qcL8Uq
         Sxo2Q0SUgrI+uzDpMiFfOvddeDDZgQ4zCBN1VDrY5Jn7BvBNpfvNGA3bjLMtv0ItVfZn
         TKhQ==
X-Gm-Message-State: AOJu0Yx/LG8VuFEXxDelCQvBJJ1c3JrdEAaKTP2yDkUoanywYJ4wzOkP
	dukxLkX8J0PkMXd1ZHiAyGiunwqvYIMAmfj7QzI/PHOla0v7dGBc3fS59w==
X-Google-Smtp-Source: AGHT+IF/XJ/GmaAg74xbDro2EL0gu0NGbbHw4Rl6W4GsrqpGvqqJD4VicHwCTVj150QtY5xbBBF7bw==
X-Received: by 2002:adf:e950:0:b0:34a:bfdb:23f1 with SMTP id m16-20020adfe950000000b0034abfdb23f1mr6615205wrn.42.1714343472794;
        Sun, 28 Apr 2024 15:31:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d6ac4000000b0034c3d1e1391sm7929295wrw.42.2024.04.28.15.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:12 -0700 (PDT)
Message-Id: <15d355a43cbedc16f420066e50e02041c8e1626d.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:58 +0000
Subject: [PATCH 10/13] url-parse: validate all given git URLs
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

Parse all the git URLs given as input on the command line.
Die if an URL cannot be parsed.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 builtin/url-parse.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/url-parse.c b/builtin/url-parse.c
index 03030035b4f..ab996eadf38 100644
--- a/builtin/url-parse.c
+++ b/builtin/url-parse.c
@@ -101,10 +101,18 @@ static char *extract(enum url_component component, struct url_info *info)
 
 int cmd_url_parse(int argc, const char **argv, const char *prefix)
 {
+	struct url_info info;
+	int i;
+
 	argc = parse_options(argc, argv, prefix,
 		builtin_url_parse_options,
 		builtin_url_parse_usage,
 		0);
 
+	for (i = 0; i < argc; ++i) {
+		parse_or_die(argv[i], &info);
+		free(info.url);
+	}
+
 	return 0;
 }
-- 
gitgitgadget

