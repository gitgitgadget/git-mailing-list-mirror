Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BF2E36E0
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754615231; cv=none; b=soDhvBb7VJNTMLFvzRl2a2l+boTK7RKbRudEYhV3JkuL6jOjkuoa5938BetnTkQFIi2lSaLaDIp+8+/KxZKU7v9sS/Kwa1nEBuy5xefbP5qGpRvKAFZqlRkHHNEG/D2lWnhJgBfjb1hSC73+pyQ7uo4Wz2nTO8r+rQ+fCa4uA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754615231; c=relaxed/simple;
	bh=wioJykWEGIIjJqViCUc/3MDzWpwPKKMbXZr3Ooczylc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXxT6AX/lnZOXzT8Jyep1jk5BOFZOifmbRvkpAxagI0i2Cbne83VSv8Cg2jLnm/ik03cowp4BYUioCm0piTd/2gj5gXmFGf4Kzh5YOpfTRs8xuYQH00Xbjenyijf/95yNTwVKsQwpobVHoTbPumVckMMvbjkOsiLawPLmOtV6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANg6/egG; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANg6/egG"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so2098800a91.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 18:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754615229; x=1755220029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSrFpb3WgF5qIDb1tXCqfrVSTVytsOSiuHaYxcOCg0w=;
        b=ANg6/egGhoPUFNcPdgamkOe1mqATefLLw8u0ouF0PHfcbQDK6dlGKLRxhsqVbelNpk
         yLloTQrahAQyc8RwX/hCT/ecZnaT5XuX8zabyvUXVt3iF4l9ufcNYHCHgJ/x0UuTtoDR
         lb5fjlejAlgO5geqvMme8p3aV5ewduRzbXxvPByoI4acohvtyBijVm6ootaRHasNBx3H
         xR9g3Y3WSxGdVEE+g1Hsyex8KW3yR9/PoGdRqd7IkZ57lnjUwsY5llzwfOZPvZwVSE0q
         Ipf7L0Dg01HUv2Nr3KvUQTcZh2uVBrrEy6cqsNaI8shs4NSri8KQHs25kMAlHMvvfUlZ
         pOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754615229; x=1755220029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSrFpb3WgF5qIDb1tXCqfrVSTVytsOSiuHaYxcOCg0w=;
        b=c96ysYRDOGxQF+KnbHptVtHYB3B0Fjv8vLY/QK4O4EPbiNrkvPC0RkwRXVhy35CfDf
         dnes27fZpPTeoTI70TmfYXqBknWJvYl4GwES4FJQpq1dRo5m+nQ7MUN/y13eOOWRePF4
         w/a6y1UhpR5CzlFyy6noWoMsDP802RwoKjV4WB+/asVDJCdmjK3iBbGhbjDFzApuaUOy
         cuUJMSLdsk1qiXxz/3ixg0BG6HHR8V0hNO7GvMgpaHvod0ifs6k87EN61j+Hbk4DhuXM
         hnm5o0AuKDBrw9ahh445nq2eGOYbaFl5+f9PL5gdwocjcWeQGi3duyIVaFk/Vxp9qo4z
         Zwow==
X-Gm-Message-State: AOJu0YyuSNY/ZQBF4z0XbJ18e8+2Hsc/RWGnauxn/nDxhE60tGKjpzBt
	YrxNYRUzoRyQASCRcWPJZr/0YqnWDBxDbG3kEh98Hr6D2bjp/SobFgy9MTR/+5tUCSI=
X-Gm-Gg: ASbGnct8v/iJeQMOONCvlS4WbImEm7MVEk8OplYeVaAJq/TpP0IvWmStS62RsMm+t/U
	yDDXdpsDueiU/6gsRuJF/WBqGEgrb96aAoFqe8FnDpHmOFi+t5UlvwDo6s5/ImTBHjQzmEtRIDU
	5JD8yzcZTOUlyXFxveXZWLlKgpQEHgllJLNTeAKbrDHv6/SFMbPQ/JJsjJjB2j6R2nJJzi2recC
	F7i7EELhAWT7RbpR4C2bZMxxbzQObO+xChTOgbWNJJAvyhRsJhPj3b/pq7OKggpUO0q3TLlVYSY
	BHyDu15oW4nCGgfyTJ/Q0LoseOK7pZrPUbl9XaAaEgY4nOof4mZVEhWLAFXmQORm5TJ4aR1mYf7
	Reh54QrfCgG5FlxOTRNN9Nqxjb9175zgrvXzCU77YCBnBbIR61lg=
X-Google-Smtp-Source: AGHT+IETIpe6y6PyuKLkVgpW0MHCFKYd9L5xczh0l/o59gvvAzuHiwc+3nVJY0D/CZ198nbQo8b7dA==
X-Received: by 2002:a17:90b:2252:b0:31f:1a3e:fe31 with SMTP id 98e67ed59e1d1-321839fc0ecmr1736404a91.11.1754615228554;
        Thu, 07 Aug 2025 18:07:08 -0700 (PDT)
Received: from archlinux.tail6959dd.ts.net ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612596d3sm6610391a91.19.2025.08.07.18.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 18:07:08 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: usmanakinyemi202@gmail.com,
	ben.knoble@gmail.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v6 3/3] t5304: move `prune -h` test from t1517
Date: Fri,  8 Aug 2025 06:36:51 +0530
Message-ID: <20250808010651.591906-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808010651.591906-1-usmanakinyemi202@gmail.com>
References: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
 <20250808010651.591906-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t1517 is now focused on testing subcommands outside a repository.
Move the in-repo `-h` test for `prune` to t5304, which covers
this command.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 -------
 t/t5304-prune.sh        | 5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 4eba3f486d..3dc602872a 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -107,13 +107,6 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 	test_grep "^error: remote-curl" actual
 '
 
-test_expect_success 'prune does not crash with -h' '
-	test_expect_code 129 git prune -h >usage &&
-	test_grep "[Uu]sage: git prune " usage &&
-	test_expect_code 129 nongit git prune -h >usage &&
-	test_grep "[Uu]sage: git prune " usage
-'
-
 for cmd in $(git --list-cmds=main)
 do
 	cmd=${cmd%.*} # strip .sh, .perl, etc.
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 1f1f664871..2be7cd30de 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -364,4 +364,9 @@ test_expect_success 'gc.recentObjectsHook' '
 	git cat-file -p $BLOB
 '
 
+test_expect_success 'prune does not crash with -h' '
+	test_expect_code 129 git prune -h >usage &&
+	test_grep "[Uu]sage: git prune " usage
+'
+
 test_done
-- 
2.50.1

