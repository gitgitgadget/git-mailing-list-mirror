Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1B3C4B9A
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686422; cv=none; b=RGc2sLOeBFe3OwX5ItxyiN7KompIeZEpVLhonBPM4Ip0TP7csAH1EJs9q+Njztxle5QN58MyyE5+IAQJYpFKZTj7dbXIDrTA4HLZj9mT+hbcOlnU82zFNM1LhHyY25wQ7G/tM4Z7VNVF9UYZc2efXPxLKCgv5xVz+H45b9jrJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686422; c=relaxed/simple;
	bh=+zLo9CewiMTcGMYpjU8m0R2YFd1cWMBpegWPKMU47FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FY+cvRfvqV86LI+djYTtpboOsMoMlStUgIp2f6WUv0iZ3XAEz17h676p9XDr9mzHb+OxCzDTuTbrDXijnWAJlZ4jhMLu4Z3xyWDA2muV5LHu3jGup4kBFbwTDx9GOUGUHUAPUylNlpTET2wKpssnWQCiku+Ud0HbUWmtBYkP+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f04pbLT7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f04pbLT7"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15b509c323so130416266b.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783686420; x=1784291220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qSsg6T2KEuDgGe84ulcMMvsnXtpX3ybGUJg9pKd669Y=;
        b=f04pbLT78F68FrKjO7+8qYxp0zTal4B2iQmFz2splDsoA7WNbLs7RDBaYnfby0kam5
         LlHWhDoSygweK6XaMV0jjkCYjrePHRBJq3ofb8BZusc/LFkTq+chKD59r4KfFpkKYP1h
         KexthLPDR/XS12TY4tobphCh3esYZ5+aWjt0bzarjP4V2/HOFQSSExqnSvEYYWZX3Gzs
         hQCcKLFiG+gGYZ2HNinqfXYPOmbI/JJpJG2LvlF3XsP3lDouKgNbUkpYksHMpAF/t3YR
         V6NHLtGYCfDPkdzgXlfJhFGomqRXIWq9S0Lre7gAoYiZcKBCrjzHfyGQHmIpKvkVQO4S
         8ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783686420; x=1784291220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qSsg6T2KEuDgGe84ulcMMvsnXtpX3ybGUJg9pKd669Y=;
        b=g8W1+xm9+Q/Kr01b87loJi0DSIrVAD0Weg5w8q/+0M+XulQjVgGnXIvXw3xCVLqf6m
         Is9oi/xzTMlCtF8Y35Ov6Dv0BQU87WSPEOTNnnKI38dAuO78/NNTyKQ+Jm6ZMdi0a05t
         UPzfU1zoSiwIhiS9cv6fgsl7Z5xx26DpRXpqO8lnGq03UPEfTI77OMM/g/yhB0EnFmse
         NoQZYx7lW94A9SxfqIZlEzxiRBBv/a3i3aEavNQHktDFIRiHeMiHUWRWIkGEPNHbRPAv
         karg+3PX7KVNWSQKFvA+0SwOUa6Tc9owtHHXn/4Iuo9ihydpofQIjQBbnSiKDA4SriSx
         wnFA==
X-Gm-Message-State: AOJu0YzzwBLwSjZYNuLL15vUBWEbVty33IKxJ/hHeXct6hAK89Ma6BNS
	b7e3S2//NrZuQ6L6o5pzNG3BW15Yw6IDNe5PwwTElkKjW4ZiSHhL48q6K52PlA==
X-Gm-Gg: AfdE7ck/a3wFbjfrdLZdLznhpsMakl1+jhjqQeY9utZOliHqLJFAzhzkur3/BUV0mDV
	dCaRNChbPDWCOrJ7WI18GUlxDHv253m6KjcuTwLuKIxAFw2dIfaTp2EEas5u5vHJNZKk8OxN7CL
	3JcqF/ZSHAdvo5dE2vcVpsbqv+d+NagRc+1uNOGmnAbLmhDFTuy1T8iNHc1FyXbCsTkFFLWVqYN
	ZgEcLsmTt3lQ6O8Z01HP8vZplqTXTce+5BiWy7EO+caAgJQI4SuBOVkbg62u7YPbUSHW0bA3j48
	taqjxUtxnAEIv8ZEYVHDN+3RHCsSNHT9Vmo7JMQkhcnKBXd0QBIbgDDEJWCiho9RbgMLCBTUBfL
	KyVBYfoSm/tEhwfwyafihFa2hAghwsW3XKe9zJDpGs4GFxWJj0JMWlF1+xtZqFFpCcw2oPiAV2K
	1zHRU/fa5rfI9l+gHdvrrkjqEi5p5dpFDBt0qCkcFdSshEn09r7ib4nld1ngbZZ39mbO3+2PyTV
	yT84u1AyrfacU0HQzw/Puia/h+84hoXZzn5gsip1F0ECw==
X-Received: by 2002:a17:907:d041:b0:c15:d608:f112 with SMTP id a640c23a62f3a-c15d608f600mr511554866b.58.1783686419442;
        Fri, 10 Jul 2026 05:26:59 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ce1b374asm405212966b.60.2026.07.10.05.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:26:58 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v3 0/2] fetch: make submodule fetch errors configurable
Date: Fri, 10 Jul 2026 15:26:51 +0300
Message-ID: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
- Add --submodule-errors documentation to Documentation/fetch-options.adoc

Paulius Zaleckas (2):
  submodule: fix premature failure in recursive submodule fetch
  fetch: add fetch.submoduleErrors to make submodule fetch errors
    non-fatal

 Documentation/config/fetch.adoc  |  14 +++
 Documentation/fetch-options.adoc |   8 ++
 builtin/fetch.c                  |  41 ++++++++-
 submodule.c                      |  58 ++++++++----
 submodule.h                      |   7 +-
 t/t5526-fetch-submodules.sh      | 148 +++++++++++++++++++++++++++++++
 6 files changed, 259 insertions(+), 17 deletions(-)

-- 
2.54.0

