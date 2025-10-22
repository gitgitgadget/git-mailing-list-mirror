Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC72D2481
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159072; cv=none; b=Z4NL7aXCMBQQSlm4MyVmdpRqbQ0OHKsqFLiveWb0qHrglFvJwwsQyM9bu7njsoxRqGYWPB3GuV2KclfPi592FmXRU4H/n7hyrcodkSDbWcDTRM+fbNbWVvB1ukOGlM5G9jFNzfd/yfLutW4mhHA/Hjl6lIaUgWuBHY1L+ClBWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159072; c=relaxed/simple;
	bh=c7zHYS0aPxOwcgULMEQGFRVzR7TuPNzce7/usx3rKiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTcxArv7NXUYE4ISS4/gUAJiXrx30CTC8aKX1rh5/XL0J+a5DEv8Nh4/SCxM5248LIEHi5+oX5V5KitilimHjSGR1Q5fSpZNpGEtlVrRkW3iR9b5huQRLsVE7KcXDy2ctColpWt/IwqBCOlkddruig+YWAgLZ2boX0+NzR3oTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FweGtJCB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FweGtJCB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290c2b6a6c2so67634015ad.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761159070; x=1761763870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2BmJibt7RuBp7ck9CaYLcxRtdyx0DYj4AxYn8lPYbw=;
        b=FweGtJCBaa7Ip2p6O88+vBKPXRuN29H7FoFk3Kt4VOlaBf75NYX1RKWoieewDA/ER7
         ucdikgb6eOpAYFhMZRTMafDyxcKSStYfE1TAXtm5h0Lxgj87kgatFSC8K8Qb86mFjt2J
         KaRnMbJoOowZKoFmZ/fJK+4EAD3SE7E2HMBXCxFJQetm/g9DyWQm/bCgm/BO/KT2o7/w
         r8fCb2OZJHqZMws0TDJ8PhyM2jrm//qKa2Avpwg6HWTj0xl+TwAqsyFue39y1Ku4T7nG
         xzO8DSzBHN6CG+r1bXkSUiGIKoEiJz9RKfRr2VVa3tEJRIYlM3KRwxNsCOUOS66uCFtx
         5nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761159070; x=1761763870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2BmJibt7RuBp7ck9CaYLcxRtdyx0DYj4AxYn8lPYbw=;
        b=Eka/dRaLivHkqO4cY8F2wxFbf4t3iXl8rotC2yPJg13E3NnD0sR0VCq+lJ47H61mrx
         TH1ZNmqwLAC1AzD7Et5xJcshGjh171tcTRJQUWPnc+QNhZxdXSwDFwLEUZF4JBN10nrh
         Eo0BrmevmDJHmvzPdMfEvKGjzLr2ZCda8+4khYAp5/kTzuzKBlaooDx8ujIYaTLnSbqg
         R9Bigqeuks0oa/buxjcxhRThz/TwWGpLcwrJoJHBOm62/Qz0iwXC3v07EJPvRvaTHgtq
         EGEQBVufov0J3602vpEMiwBpktPfEKHRPsFRJ/cBMJfevItYoG8DMS9lebGT0eJ+eLgC
         8osQ==
X-Gm-Message-State: AOJu0YzqdtpEoIrseWPeoTpMzU4eu1ulFceyRDYkb4YtrhrvVw6d4kTI
	T5aeZqJsggUnYnYvPKomOAnpEdYiOeiIffhi4c7i6Sek22H0t9UsO/opqb8SFc1EIZY=
X-Gm-Gg: ASbGncsFWRJPUNrRz0HcOycdUUD/y/uSP2XNtQjDhBlDS1RJRKpBVv2BHnlLry2CgbZ
	DYk1mtL00BrDjpVFmzQgfn/uwiPb09hBbh9xr0csxkg31l3C9GMjecTF3AtPKe0IDBWR0v0h22Y
	vgFMps4es3xEOXQZduC4zKe2RSaAxB+XryH2YjCJRmvGzRVVe3rt3LpDJIPJDCPMMble4LNvqeC
	KNm3ltGk/G5AXN5jq9o+LOdY2X8enWvbzjHVEZUAgFWJZ4VMKNq/iSi/l6JTrgdKAyfTlexrdqM
	lyilu3G8bPyJccXKkKglxeSxrajZTyvRNARVzZgXVfkDOc5/Jn5KInXeNZrLHABNL/eT1mF1YnK
	h/QyZu+DOG+WSkF7HibgtTvfROivT/Kbb2YqMoKobgJ+o6ypxn0A9wKSSIh/ZSk8F3GFFZFvG+2
	wAHMbuUf9zTz43uUUccmmImCs43r1JGsg+oC+u1yHYVgbhQFwAx92cLZXr7BWKaaMpvST8VLRhW
	nz1cDOS4EYac+49VfVDKt8Nw04TbZG3zdNigXwpUx/L
X-Google-Smtp-Source: AGHT+IHBff2wNlmw8asB+ehSEpRTiNUSOecyfjw+Yi+eDV1VIOW9i+7ZgYZm6ArfQRIz5s0MCo5DxA==
X-Received: by 2002:a17:902:d2c6:b0:290:c0d7:237e with SMTP id d9443c01a7336-290caf831cdmr316371405ad.39.1761159070270;
        Wed, 22 Oct 2025 11:51:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:176:32cf:8d9c:2c8b:22d4:a7e2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2930623208bsm25691755ad.31.2025.10.22.11.51.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Oct 2025 11:51:09 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 1/3] replay: use die_for_incompatible_opt2() for option validation
Date: Thu, 23 Oct 2025 00:20:43 +0530
Message-ID: <20251022185045.29256-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022185045.29256-1-siddharthasthana31@gmail.com>
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding the --ref-action option, convert option
validation to use die_for_incompatible_opt2(). This helper provides
standardized error messages for mutually exclusive options.

The following commit introduces --ref-action which will be incompatible
with certain other options. Using die_for_incompatible_opt2() now means
that commit can cleanly add its validation using the same pattern,
keeping the validation logic consistent and maintainable.

This also aligns git-replay's option handling with how other Git commands
manage option conflicts, using the established die_for_incompatible_opt*()
helper family.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 builtin/replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 6172c8aacc..b64fc72063 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -330,9 +330,9 @@ int cmd_replay(int argc,
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	if (advance_name_opt && contained)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--advance", "--contained");
+	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
+				  contained, "--contained");
+
 	advance_name = xstrdup_or_null(advance_name_opt);
 
 	repo_init_revisions(repo, &revs, prefix);
-- 
2.51.0

