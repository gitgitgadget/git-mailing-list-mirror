Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0083E8C6A
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173486; cv=none; b=dcsLBfKIqoHv9LTSZQv+mkTWpWUnARDEovPaUwU+6RlaGbzl+UxqNAftATfAImo1nZGP8qjE4lZi444jsvBxWNoFsCM8wNuCN/v274zMSBqzG2F1UIwqhHZDlEcBf1ITnmy9PvfMtDkPpz+zD9GUXfrShWzRndRTAWXlCgVT2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173486; c=relaxed/simple;
	bh=SimSezPDUX3sWC+meBWBAnslS8/egIYa67DAQbmHWxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh3Si+QvYlawroMIfkps6WBI0gJJvaBaeL4a9v/71E3VKvSVCaan4UoLi4XzILswtRRimTaxSPaqSsnZUqw9q4zQMTKTs4bYXFDFruTsKLpMb6Ln+8QryS2oQFkP1DI+HvdEY7+muRGqB4WhSXVpGDD17bgpIyDcd8cdQKYXggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQda6dUg; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQda6dUg"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-66f747175d8so7653938eaf.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173483; x=1773778283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=aQda6dUgk+T+1KiGNt/odZysd5+n5nadLeBUZNmaBHCSmhw1VPE9DjiailLkn3XY1v
         70eopWuQs4zlJf+QQ7H8z0IudECZZgWy/IlTh2tN43/ACak8AhV0Slo6apRs/W48vjOK
         iCn3ERcftfVXk7zGxSC/mzsgiZUuQe1VeOEMvXWdfs37DfLcFTpRzlQq+AJ1WgGDP92V
         4oI0dK1yYkHjGaC8sa89SaA7DMIxQC70QSFJik6+jc3Ki1BrIZTehnytfQ9xJ+8BJhVH
         XL8jCGaNNghdmOl+VnOGWI2EWPHZFDHr6JDCbAztzoGxPgC1hb7AopuULcgQ9Z50xLKJ
         5eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173483; x=1773778283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=UOwPlIlWLoLj3nLv09EcrABxzwectBweBEikmcfLJlbaME+VCh4mNsHVtt5EHGnRX+
         uJeVIFjuWjYICZrFjffUlgnHUjJT4ltBC/8JsKbHS76ypDfWujd6UXV+6YKhkB12tNxW
         39WwvMwxRYtTdNSeOrGPMT11FgUyXBwKrzUbsIb00wAVvdFPtqd2+Cuw2cvSUy4JhPR4
         apW4oC1Gah8clhNeALXn5SppZVQb5JiU5Rjsxm2hIeP35JjvayMgQhnYtspzj2vROZZJ
         jVKpLyPL6IRKrYRAiLCf5g7AFsYtQuU2gly5G0OXieRj5ZbkI8GE6snmbYb9hIW2p45g
         Mmew==
X-Gm-Message-State: AOJu0Yyt15VtFINP7GaRlEgordhk03gID3p1vvBfrCltWd7+uASoWkRC
	eR5OGGJkP83aqkJAtqUDnRK+LcuwYCVW36o5p/H78jX81ItA7bTJYRPFdGFyaQ==
X-Gm-Gg: ATEYQzxbv33E9bPMozcwOIacWW0bhg3LylLGf0GQ3Ckd/V3YDUEKhYd9Gi4zSR0dJeS
	ksoRBf2vmEgDtSKppzex/7ylOUeWJxx4entSpc7qn28moYATxIaCy4AvprAvAt8U4VmI6+cJRtR
	VIW0fgV78nO5j7PkmlPbE427yo6QRWBi6i/lNjFnw9q41NfcUqLeHuyliK04E7N50TcBifuACfg
	TcgK8G9sNYP0swnwz95uTEEVlUBMYsPse7TwGd73gzVS6nbEvlbNCCOwERetVRnE2FWkcm2BoyJ
	ZsOLFsXsuhyx0/Gfoeksi5KAXtqMr4uwlA1tcvjP/h4iBkmi1Dk/8aJQ5PyK8e4XQRvVkkiYm4n
	meFS3QuU7rg0ig1Wb0IEVwJQ0sgZnQpq8UFjEFzs0LxaF1dfnQmQZ2yCNmQx/1QAkwoPrHMeRn4
	8PvpgPexiMHeQZhH4gJtzIkI/K6uYZecA=
X-Received: by 2002:a05:6820:991:b0:67b:c4bd:2a97 with SMTP id 006d021491bc7-67bc88ae4acmr62998eaf.20.1773173482988;
        Tue, 10 Mar 2026 13:11:22 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bacd85dd6sm6221066eaf.11.2026.03.10.13.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:11:22 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/3] commit: remove unused forward declaration
Date: Tue, 10 Mar 2026 15:11:14 -0500
Message-ID: <20260310201116.1130160-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260310201116.1130160-1-jltobler@gmail.com>
References: <20260306205359.1723254-1-jltobler@gmail.com>
 <20260310201116.1130160-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 6206089cbd (commit: write commits for both hashes, 2023-10-01),
`sign_with_header()` was removed, but its forward declaration in
"commit.h" was left. Remove the unused declaration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 commit.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit.h b/commit.h
index 1635de418b..f0c38cb444 100644
--- a/commit.h
+++ b/commit.h
@@ -390,8 +390,6 @@ LAST_ARG_MUST_BE_NULL
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook, const char *name, ...);
 
-/* Sign a commit or tag buffer, storing the result in a header. */
-int sign_with_header(struct strbuf *buf, const char *keyid);
 /* Parse the signature out of a header. */
 int parse_buffer_signed_by_header(const char *buffer,
 				  unsigned long size,
-- 
2.53.0.381.g628a66ccf6

