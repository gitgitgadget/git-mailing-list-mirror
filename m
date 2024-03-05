Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E916F12881F
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673125; cv=none; b=on89Z/GMejgoCXUPEWGWJIGFVqiyhnROXNbtsrQhhjKHDapgd4hY3gNpiTvDw9NVBrHSbGYUE+y0UDVWLrpQWCtBuI9+Oja2lBZdzYyssfFPWYDnN1Hp/2aPdXNxRmNujscpXU75fnjsNjcVZpKtN//s5wA5IJKuT9d0hinIfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673125; c=relaxed/simple;
	bh=eZHWWAb9sSocxxiQCil4MXC1m3/Zuoh60jwj9sWaL/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=s17I35erjnPFgWXWss69QIhrEJvHoOE7QCeZVVChhzucgqmfQZqCyDWy2iBo1IwWyqiyYbdrUYAR5yQOZwrrr8uo729KXQSY2j7Y6TecuyUibx6B15CLSckW02XQigldrjVQDkCEOLVKVoIpfjVGfKh1kApKsENG3PvKpIdTylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OcY5xwPt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OcY5xwPt"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609ccbcee7bso15658677b3.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 13:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709673123; x=1710277923; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ikUepAnI++Onfw7vhAzRnEewLTNeghl488NxpRsMfE=;
        b=OcY5xwPtLVPsHLEYusXUHMCd2MuDxm0CacaEKqp1bp09YEvHSJxD+xivrnc0yb80km
         2ZFl3Tjied15gHHPMY4jJT5yG8VLRnhEgWWtVzOXF2evm2O+I8/5rg7MhqwK480d5v5X
         CzdOgI+LMwTdXN4/L171KR7ferWFjsOkl5LuC+lDIC3zcKGooE2RedSkfdn0b8I35zW8
         NwME+vHM14gibaqgPNgfGXHvPJ9WFTOdwEkt3v7ysjK/p1n2sN2Cn5L5fAVUrljfeYBi
         6tGePjtmM/QYx1n/B2sBMKMXF6pLSTjTi3NYNWTbntlZFAAncoYA/YQyso8e5JR/RUFV
         Emsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673123; x=1710277923;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ikUepAnI++Onfw7vhAzRnEewLTNeghl488NxpRsMfE=;
        b=rbddXAHE8DHaR66IfU7eqTAWGwDaIgzlw0SdYk1NLiI/VVWeOCMmA+8iPKIURXWRYz
         9Xxt5iTi2PSXpDGDTgdSR9zw+PdCiSuSI7SAmorTRs9ZN9E1eeZ8S6AqqYMcRP/G6Z/Z
         EAx9y51SbFWWK8YZ9tbAL3xH/UIrH+8Cixi/rp/4GpGm17BqbQn/wvacAt/dTVkTx+og
         +4CnmYxyjamWXsOat4lrAyajOKqijxyRjhJwJw8JTtONMWJ7QlkQ2gq6Wlr3yVk6yB6r
         drRXiCd0lKcq5fyOt4ch3a+n5nxAtAaWAimpxGttWfkgoeaDAtbIRvgHJH7CC5SDNUKl
         vU/A==
X-Gm-Message-State: AOJu0YzH/eQmC4m4x1KQTQRc1FvZliu3TVW+CVctifSDMiGs8JA97Ae/
	J5yderd+t0vwTLdxdt2XSEW9KkIftfSXaF4lZN6QPyMRJBQM8kIc2H13E6nkehKejDlKT3XdtaA
	sFXcnbuKawpx6gEWblaH806OnbMpklCUBIHyWNu71UKjAlSDs7nv/+0uGNl8LA2LXQzUvyOWhiD
	81MiKA5d9+FfcDD5icX1dYMrP966mABSd4gUucAIE=
X-Google-Smtp-Source: AGHT+IG+uierof5pmwwh2UX6TCH2pmpV8O/7TS0d1Httpmg/ALSI2pHcDZr+WqvjFJQ3/kjZEBIgBQzA5uxEBg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:f9ac:5d54:eb54:107])
 (user=steadmon job=sendgmr) by 2002:a81:9950:0:b0:609:4d6f:7c0b with SMTP id
 q77-20020a819950000000b006094d6f7c0bmr2970409ywg.4.1709673122795; Tue, 05 Mar
 2024 13:12:02 -0800 (PST)
Date: Tue,  5 Mar 2024 13:11:58 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <cover.1709673020.git.steadmon@google.com>
Subject: [PATCH 0/2] fuzz: build fuzzers by default on Linux
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Increase our protection against fuzzer bit-rot by making sure we can
link the fuzz test executables on Linux. Patch 1 is a small CI config
improvement to fix compiler feature detection. Patch 2 is the Makefile /
config.mak.uname change to add the executables to `make all` on Linux.


Josh Steadmon (2):
  ci: also define CXX environment variable
  fuzz: link fuzz programs with `make all` on Linux

 .github/workflows/main.yml | 12 ++++++++++++
 Makefile                   | 14 +++++++++++---
 config.mak.uname           |  1 +
 3 files changed, 24 insertions(+), 3 deletions(-)


base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
-- 
2.44.0.278.ge034bb2e1d-goog

