Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DAB137C55
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236534; cv=none; b=JHRT8ELNUf23xuk14aqpHy1uHlKxH4azcpq7QP7G+U6SIWedLm3+Wqx+DmGuLZ4g8tSBEEHXTLCwrpoBXPYlRpMoa3cKrjbv1b5ErjTvdTJipviYIFnxLaCsP9lXV9Ql8ildDvlexofPoHVZD5S2IlsawHH5Mp1Xp00hYlfrR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236534; c=relaxed/simple;
	bh=g3mcr9oNJA2YWVKdqdh6JD9CfQ682VkR8dwEEitGi70=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X8b7tPKotY7SOxnjXtNg52N56T9AVqVLNBJXTYHyUn+AdaeEv3UrNNphlVWe29Ewwp1IfnXWBOloElQGX6mpVyB13Zog3w/0S76tSQWlWQudacF28yVzJeiF6uaRh3Ozqkc/oyntt837XpG7gx5YfoVlwu3Bvc3rphYEuubqlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToQb/fuI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToQb/fuI"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34dc129accaso2381828f8f.0
        for <git@vger.kernel.org>; Mon, 20 May 2024 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716236531; x=1716841331; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3TcY6SNGMN9D4Tqo4JhzJB1VLG5CDwDx+Tm37TVHyE=;
        b=ToQb/fuI2CsTXnYwiF15U7p1qoGE7ZYoHHz6UUZkw6/vUaL5Ou6Bouu3w3O86MYXVu
         w2ThAnBetSGVzC8xvFvX/R+dvlNKY4wfkg3un/K+e0PAsnbuJY/MnT2hCMcp4gkaVSgH
         uYkgcQzUSok9dayKf2VrM0yN4JgVaQ+JZTinl/gcN4KAnGf8h00BTIFZylwzuklrLq+0
         NvBTk2cYvoXtbzvgW32J1LNyDaIx7fp00VabziyOy8yRiZspqXL6PEvUsbbZHXV3cOsg
         NeH4DShb6lmjczVfCaKbm/XQWN812WqpU1sOjwLf1jOproI61/C5BpZoyD9jq7NILk6D
         awPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716236531; x=1716841331;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3TcY6SNGMN9D4Tqo4JhzJB1VLG5CDwDx+Tm37TVHyE=;
        b=ubCcvT+gApyNnAsEGEMEAazmbTnWK7V2y7V51/OmXC5UHHvVZIoYYK4xsQvU7t4PB0
         B4pzf0VS8GlVVBbHR7JyRnMcbgRazdAzjxEyaqUnNLar1MDjibhXtijf1daXZGe3+ZPg
         AJnC+GikB1Z/srw5UkZu+3bOWFuk89B/h5jCTSWAOpLnkpP840F3UQKKG5MPKm25GL1G
         19coa74T3/AIgZYf1vXPFM1AvGJRiJClLRMIfzFnkKNP3qZuNPeZynnoNvYrybNNYqA/
         60e840MrneS672gvk3xrPm/h5jBdRPhOnB/NfrjgBZrrxeSuA9BKGkmSPkvQ76iEpfn2
         Zd2Q==
X-Gm-Message-State: AOJu0YxKlY+n9QTxI/gOEJrR7W04ejnZKtD6+gStYrWRV0oBzQ2u5eiK
	l6nKw87Wi7LMJ/6TLGf1VeEbwAJFA7WA/RcvcMFwJC6QCjspH/Vd4yo9EA==
X-Google-Smtp-Source: AGHT+IElSFlZDF7szQVcGWliButOO7e8P+7xNRe5hQcNS2ZAlLfITOfK45gyaldPINPep70TbUn/ZA==
X-Received: by 2002:a5d:53c5:0:b0:349:fc93:1dc with SMTP id ffacd0b85a97d-3504a632dcamr21586598f8f.8.1716236530842;
        Mon, 20 May 2024 13:22:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfb9sm29813499f8f.68.2024.05.20.13.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:22:09 -0700 (PDT)
Message-Id: <961dfc35f426388d660cca4e92f43e169819886a.1716236526.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 20:22:01 +0000
Subject: [PATCH v3 2/6] init: use the correct path of the templates directory
 again
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In df93e407f06 (init: refactor the template directory discovery into its
own function, 2024-03-29), I refactored the way the templates directory
is discovered.

The refactoring was faithful, but missed a reference in the `Makefile`
where the `DEFAULT_GIT_TEMPLATE_DIR` constant is defined. As a
consequence, Git v2.45.1 and friends will always use the hard-coded path
`/usr/share/git-core/templates`.

Let's fix that by defining the `DEFAULT_GIT_TEMPLATE_DIR` when building
`setup.o`, where that constant is actually used.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 093829ae283..4b1502ba2c6 100644
--- a/Makefile
+++ b/Makefile
@@ -2751,7 +2751,7 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
 
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
-builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
+setup.sp setup.s setup.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
 config.sp config.s config.o: GIT-PREFIX
-- 
gitgitgadget

