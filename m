Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5D424D64
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211002; cv=none; b=k5KtFEJGTgsunzYne0ln8S31I34NiSaDunrvWHA7Y8XzyAd/onFvb9FaD8qKVKQTvSJA+rVleGlsxwAF/EKSFHOT+P1c3nyXy1fFoaniAbY8PyxcRhEmnnoT06aGnl8/pUjCofvAxrZ87EEMLDR83atpU8vSxiH76NcaCK6i7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211002; c=relaxed/simple;
	bh=lg/6a3CLTyCH/mp+FMzwKspaxF1eUnQBm7QeCXWEeIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WypNNxFRjzMKC4TXoKeixYB+LT5CJ6ITtvehppNQB55bRvPHKMDdgtV1R96gOyMy+JAqot4rQbrfOfA40WOm3YgZYpuGV/NFo7N0C2ykl50FZ14RDvbQlPJ4mvr5KT9x3I2+NGgDAdWLow4azQEkFDfoZeztRzFNTSzI8mLq1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpXCPiWx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpXCPiWx"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c16794450aeso235631466b.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784210998; x=1784815798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EHpyOiSpaV9Bh596pWc3CHOYWfPRuTBH/7mgVdA3N7U=;
        b=CpXCPiWxJ/dioP5XRSaBk34vHXIJaDI62NpC/wKTYJ4/YGOGiHwU4Bxb0bl6XR+M8v
         re2riESFe61oFWBQVk2MHEakR9EB7TvAEdDBZB3Py2yge+h7e4Hw8HoBpH+G7232F7ni
         W7smqTv5gawJukAHldcUsjUtheZMaRfa9tSz0pZqwj7q+mcQM5NfK8QxFdqmuMZvc/BI
         aE8j+bCgqz1O86IT/7E7/wa4AMCrvD1QyuaNoDsSLgRYQCu0mXIfWdC5zqBWKIdbO4Zm
         U8BC0DRA7Q3buTinqFr1BaG8kVqwRQLialmdPUFDbXU7anza8xwTP0K34YIG9APKFdVt
         I5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784210998; x=1784815798;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EHpyOiSpaV9Bh596pWc3CHOYWfPRuTBH/7mgVdA3N7U=;
        b=iOqKBNCBsH1OOi0GnP+jvMXO5X5oidiXb5DN1LPEXeVEeobnndqkl7kGB8/38+hemk
         P4RER7Y36FLAGuVZDkgvCHSdquIxuVuySUscWS6BHUSFO7j3Ov+TJM+N15AeIWrSNDjE
         WuKYF/6HOUUOVHbJs45IGoT17450CYWPJgg/tdAi9ocwdXuuiTUQVrjMSbyDNNJKB72/
         m30fxniSI1UYun7BQQ27MCkiW8rvXafz7YSCoKzGOddVz/wbltQ6n3BaNkXzCOvDje6X
         rpXzU8jzHSsC1EytH5M8ZBQ9ZMYv4IVVjuDsnAFVww4NQlQmw/FZW5VOUmMeOGkReFVv
         T9Xg==
X-Gm-Message-State: AOJu0YwmXPJaAKdgVvLPcZ6hUpRcjzxmfTYW+2owaGTgfpKmnjyhiUhL
	eW6wHvtT2CAc5wB1uSE8obBtLaDUTTYm1KEOdIsVbTVPixPTs4LtOGaa5nQzc1Ng
X-Gm-Gg: AfdE7cmI3QL/lR2GYpT6966FT1MPauW/o+uostzDyckm6d//eTxbO6dbB8UmZesb41R
	slimfqGJztr/iXfY0Jz6yJm7WxtUrabfzt2xVpPTWsKZme8a1psJmu7a/omC39GzCbJvumrO59v
	drhI78P6rUeMvBc/uxRkSqbSnUhZ76jDuaAt55O87JtGIDVe2tNVNBnVYsnTYk8jlETOQNuyg2P
	VzReAFaV1tLe4FMLXzu9QBo/FZs6nWOpIukEb5qSfzO5G/JgOSnAhpv4XLvBQCvDOvfvPcFDOKz
	CBgVoi8lEB1khok30IU5jB+HnxQn7cWC/34sOZ9iSzp1FOEBRyNE1HX2l/ef5k+V4K76ZjLTHaR
	Yn4xXFCV7+PHzCZlzcNVulrZXbIIcEHyuVdanouttrnFaN2pc1vDa87ggC0KEtB6wf9In9oFZhy
	JBoqJZha/0eE2ANfwEKoq8kP+Z6aDteL5lAHVc4g88a30ioDjhV37mzQlqRM7XlUXGbZ7d0Uacy
	7V7SNqBUrUI1D3WLODnCYUzldjwTdaK154=
X-Received: by 2002:a17:906:6a22:b0:c16:e3b:7d6 with SMTP id a640c23a62f3a-c1661938c9dmr730761966b.54.1784210998148;
        Thu, 16 Jul 2026 07:09:58 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bff3sm226720966b.46.2026.07.16.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:09:57 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v6 0/2] fetch: make submodule fetch errors configurable
Date: Thu, 16 Jul 2026 17:09:52 +0300
Message-ID: <20260716140956.1023740-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715103518.526326-1-paulius.zaleckas@gmail.com>
References: <20260715103518.526326-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When fetching with --recurse-submodules, git currently exits with a
non-zero status if any submodule references an OID that is not reachable
from the submodule's remote.  This situation arises naturally when an
upstream branch is still in preparation (e.g. a topic branch in a merge
window): the local branch does not depend on the missing commit, so a
hard failure is unnecessarily disruptive.

Patch 1 fixes a pre-existing NEEDSWORK in submodule.c where a phase-1
fetch failure was recorded immediately, even when a phase-2 OID-based
retry was about to be scheduled.  After this fix the existing fatal
behaviour is preserved but the logic is now structured so that errors
are only recorded when the phase-2 retry actually fails, or when there
is no phase-2 retry to fall back on.

Patch 2 introduces fetch.submoduleErrors (fail|warn) and
--submodule-errors=(fail|warn) to let users opt into non-fatal
behaviour.  The default remains fail for full backwards compatibility.

Changes in v6:
- Clean up the fail/warn helpers to match the example Junio gave
  earlier: singular array name, plain unsigned instead of size_t
  casts

Changes in v5:
- Use test_grep instead of raw grep in the new tests (Ramsay, Junio)
- Parse and format the fail/warn values through a single name array
  shared by config, option parsing and option forwarding; values are
  now matched case-sensitively (Junio)
- Credit Jean-Noël for the v2 documentation fixes, which I forgot to
  do back then

Changes in v4:
- Forward an explicit --submodule-errors=fail to child fetches as well,
  so the command line overrides fetch.submoduleErrors=warn config in
  the per-remote children of fetch --all/--multiple (noticed by Junio)

Changes in v3:
- Report a phase-1 failure also when the gitlink commits are already
  present locally, instead of silently succeeding
- Route "Could not access submodule" through record_fetch_error() so it
  shows up in the error summary and honors the warn mode
- Forward --submodule-errors to child fetches so it takes effect for
  fetch --all/--multiple and nested submodule recursion
- Add tests for all of the above
- Documentation: don't imply git pull takes --submodule-errors, minor
  wording and placement fixes

Changes in v2:
- Fix option synopsis to use (fail|warn) instead of <fail|warn>
  (Jean-Noël)
- Add --submodule-errors documentation to Documentation/fetch-options.adoc
  (Jean-Noël)

Paulius Zaleckas (2):
  submodule: fix premature failure in recursive submodule fetch
  fetch: add fetch.submoduleErrors to make submodule fetch errors
    non-fatal

 Documentation/config/fetch.adoc  |  14 +++
 Documentation/fetch-options.adoc |   8 ++
 builtin/fetch.c                  |  70 +++++++++++++-
 submodule.c                      |  58 ++++++++---
 submodule.h                      |   7 +-
 t/t5526-fetch-submodules.sh      | 161 +++++++++++++++++++++++++++++++
 6 files changed, 301 insertions(+), 17 deletions(-)

-- 
2.54.0

