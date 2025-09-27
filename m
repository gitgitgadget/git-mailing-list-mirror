Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA181F63D9
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758945117; cv=none; b=bM5SGCqr3iIQtZXRE1NZaLO2VWyvMA+USTHH/wVTLR0GY5aT2XHvK8M2lBmUUULTn9jAwAmvyXJZfnb7sF4AMgdHnl2NGLHskrdH3EmXK5bp9keuFUNbigF9MH8dR0HxCbpIGDzUFXaw6Et4lvS8nK42yq54y7ZbGZQGsaYBSNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758945117; c=relaxed/simple;
	bh=rwixZ5310GB1yWYMUco5cwCkSGj+L7ibVrC8UHnHRN4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jAZYLN4kPPuKyzKmjqeCYh0+dvMwxOtWLPjHq6ZVtTCQFhxXQ79tBen/UjgMezhnzbqlv9HJDVpqYp0CFHt3Yg8+OpgUp5Lu2gIcRGkxMHriMfUXuPHwBXdrlRqJSxAj3IyD++FAJZT0q7m84KMQDHMu0PfjoPhWvay48fOVA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKHzwu6H; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKHzwu6H"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2587949b3a.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758945115; x=1759549915; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxoFNfmxJNaO8HV39KBL3+UwvUgT52a9pCMuGP/Z+2I=;
        b=XKHzwu6Hxbe8dE6L6OmZahAtYRl/SIAte7Q5w6Lql3aUDVw7ASIaIYN2J3BfoGsPlI
         0WF4Nwk2o+TftesYrAcyDScSjDq2Bl/2MQQHrMQqJMZORgnwllXPxlNBWZ/2crTmNBYQ
         8IF+wctcSkryM+l2ZFfHVkBrN1wpOXX4/NiQoQheevD4MWh5a7UO1oQyMRpB6V2Pfeh5
         5KnmhqVNW2lvcrYk9yCixu0VHpnuBNv0vHAxdO3ZyCMcWz+Vighq+xtGXz6iYKt70IwE
         KphvbLvrkQU6vfon1dON0VRzfeu3ez5NROf0bYc8pCJgLbtyBxEnZAhmT6+OTQAkcfNY
         t+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758945115; x=1759549915;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxoFNfmxJNaO8HV39KBL3+UwvUgT52a9pCMuGP/Z+2I=;
        b=ANijo2IiapeBfDtDWJCqEyn0mQhPeopNgMknsiyvYUdsDpkT01Vn9X15DhYnRBNyRl
         /zpVhbt7XDwQ2Un+CLRjoSnvhrQ6FwsZfQqoQrYAaAJHcZAgGHqEXL/jd7cSU+i+LIaU
         mQ1S4OtK8M/8bftPTjE9OmGPigN2Zz18NaXOy/3gg4ZBfrmna+a72KKWue1+C3fiAj+6
         v0yVxy96vK9KvN7ii+pZGWRuqShg4uLrocaXXwBadKvmlUNFJb+QMzHTe/outJNhPDsi
         xSNbm4RtMQitR9bgBkC8ZL5m4yBG8hRvy89f+dJYBB0ubn+rGUiMAojPP6IOlZIC34ov
         wU2Q==
X-Gm-Message-State: AOJu0YxSzUZUy/npbC4Kf9jpXJ7qYtwspdKDXC629KjsDQE5rTh3VY6J
	MuHisER0ktYJjN6jC6YCzM16OaeLn6ch9TvSN0KpIT6T33ph7b7fSzRbEBktQvDa
X-Gm-Gg: ASbGncvcaWcDUMYDnC/Md0RTmVJZqnm2WQfHg+N3WeSAlulNVyBIREPu9T9RQA3Uwf1
	vskUbyeJMjcu63J9PXyyh9zfLuxm7pKqYesqFhdovvDgEWW4vheb6gotoR2hkAH0lsZvDcQCFlU
	GFfEIFYzBwaeXEWG0JplBwC2UhEUo7nWkLTlT7mp+y4suyEDmhLAXoBOEsqD+zdQtXO8Jrm1JgL
	1CC+/UxDr9barauIPfUb0LU2RsBwsPTOvZgEg63alskGkvyhqbQKVw+rWI4p4eVVImScV2QL55m
	Su+T4atYNG3hxUZkzZoKjBapYwMcWcIGlSh8ytCyiU7LLIUJpHQ97UVLH8ouXghimjQQZPH7aym
	VMV5hWynRqCmB7ZCBtS8iz2oVNIiwjlK+SGGK
X-Google-Smtp-Source: AGHT+IGoStMv/5fHalJVQX+QH1u6F8VaQrzuccqJjqvNN/nAYokCuZWk1QpsEiF98VK+ozQTWQLYyQ==
X-Received: by 2002:a05:6a20:2595:b0:262:a640:68a0 with SMTP id adf61e73a8af0-2e7d437aa57mr9869294637.30.1758945114894;
        Fri, 26 Sep 2025 20:51:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.218.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239596dsm5579602b3a.9.2025.09.26.20.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 20:51:54 -0700 (PDT)
Message-Id: <d7810781fc3af1902c99cccbd50853dd630a0080.1758945111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
References: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
	<pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
From: "ionnss via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Sep 2025 03:51:49 +0000
Subject: [PATCH v3 1/3] po: fix escaped underscores in README.md
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
Cc: Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    ions <zara.leonardo@gmail.com>,
    ionnss <zara.leonardo@gmail.com>

From: ionnss <zara.leonardo@gmail.com>

Remove unnecessary backslashes from language code examples.
The underscores in "ll\_CC" and "zh\_CN" don't need escaping
in Markdown.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
 po/README.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/README.md b/po/README.md
index ec08aa24ad..d7757bed4e 100644
--- a/po/README.md
+++ b/po/README.md
@@ -13,9 +13,9 @@ We will use XX as an alias to refer to the language translation code in
 the following paragraphs, for example we use "po/XX.po" to refer to the
 translation file for a specific language. But this doesn't mean that
 the language code has only two letters. The language code can be in one
-of two forms: "ll" or "ll\_CC". Here "ll" is the ISO 639 two-letter
+of two forms: "ll" or "ll_CC". Here "ll" is the ISO 639 two-letter
 language code and "CC" is the ISO 3166 two-letter code for country names
-and subdivisions. For example: "de" for German language code, "zh\_CN"
+and subdivisions. For example: "de" for German language code, "zh_CN"
 for Simplified Chinese language code.
 
 
@@ -126,7 +126,7 @@ you add a translation for the first time by running:
 make po-init PO_FILE=po/XX.po
 ```
 
-where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
+where XX is the locale, e.g. "de", "is", "pt_BR", "zh_CN", etc.
 
 The newly generated message file "po/XX.po" is based on the core pot
 file "po/git-core.pot", so it contains only a minimal set of messages
-- 
gitgitgadget

