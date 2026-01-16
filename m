Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DD28C009
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598835; cv=none; b=B+MGYiC0/Wa37LEZ9bOvtKr9HcIKKJbN70R61givuUYsaIs37LYK6KI8KT+Iuw2UfTNrOVlFu+dr1hSej10kbIBy5ELg7chcXqpkUsGkVmogMXh4rqKjUprdPJESSRol/pGVtpnQ25RyF0yoE7VD989SxuTcqErIIdIzJ30x6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598835; c=relaxed/simple;
	bh=iblIaNq1ESBmFCWkQYEZO/GF6622kyJN1m7QnM+yAMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ua5n7vrWH2Fb1A7svBz8gaT5v5SHOOijZUBaC8uD9814bop2d/RoC5YsDdkY3dGmAim6bemu62/uKofH8YlbLY6ctiH3WFMEIozgEPKfjmJMtxQxSsbGL4yXHsWOI4IQVaK616iCVYUZMP1ssZ1g9NnB7S57GQNG55yR+r8ztW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGex/ZmU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGex/ZmU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so9595895e9.3
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598832; x=1769203632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VUirNvP1yzH8cbVB0w9sokLsOmDUXxggl6vb+JhJMo=;
        b=gGex/ZmUFTOXqSrMqpVu/LOZJhw0NXTNRjdwUvQZzmhtOJsz+xI9hqS4CcFMNME7pA
         ayl6UeqF/yTTsHkA6uzD773YwAsAMHNfhMAxTT7x8eZ3Yq7ZoLiOBMLt8eJeJY5voWj+
         +z6pjO0/QZ8FgyZi0cEVRrIBqrtsoxyfw8BDHzwASh/tsc+ujGYnWKKJQrhUgTAyj5qC
         oPfITdL+38m/gQ9VtlTDhND0Yqw3GU3sTQWpqvFTMqAjBaUeUZ8y7kbqfEd8NR46oOwi
         xCBpoQlhSWiBSsItqsH5zDW4aA3Vl06GsfFULENTipx5c+/L8ZYeJ0MvrEtIA3np+PnK
         N4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598832; x=1769203632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/VUirNvP1yzH8cbVB0w9sokLsOmDUXxggl6vb+JhJMo=;
        b=GeAhTZUGHE0LvNmTYbbFLpYZ5bQFOmL8Fsxyy3dcfYNulZijqdhQONrA5vykgJw1U8
         HWIWLuSOCV+kDCfS+ZOZ37zuV42j1o92t2Qc/Cz9VXGrtA5RVe+pA7AX2yp494fgSwCN
         QLw9JGzJBxl7zTO1DcaY7tYDNXGg2bzAMTUcf/lLVVfbiy63C6frNoutdANQw6khchHM
         08DTD0AeV4aBAqNUIdEiz408nN7Ge/bMR6lp+yB81cDj0vZEotQ2iXd5FGs9PNLpXjDD
         DWUYOKvKH4ciRFP0us2uzpbeh90jjamUMjFrzBZEGBjp/I+D4PTOuCTIDjbh8hbCEiPk
         USGw==
X-Gm-Message-State: AOJu0YwYYtT40kkJ59lfP3gkSxwbJiOY/+f+NwAu3ezkKzR3QQ887HNy
	7t7mheLOB/hbnWV2T1/IQTykLZkMtqxdOdtdB3gQt4taXzVgAnd11+Gq
X-Gm-Gg: AY/fxX4APorT2hoSslLyElRz76J3rB1qEBSheYK6zRiDkVsxheKOMbgR7RiBNiofQzb
	ldO4fJhtIzoviQ1+MkDxkfWu0pxARb3LKUsfkR6WRme4Y6QmUzOoj3B7Pps+zkvSukCAGweyAM6
	K/aSRa5004hb7NSAYtT6o319qLp2P7A+smf2THVwV8LLfgq/4iJyhAot38MzJfofxZVfcYucf6V
	Ah6uMf9OyMY2QFnv8SupHTRB2/lt4gvK/A2tMxO59vCLFZFs4YxlUuo9g6Ln6RCSlP6NHT/7gBk
	LGzl/NDKWp44MZxo7V3PvcgHKYjkY3FGNAi4SlZrJamtebfKxKBOO+uxhUushL3s6g173c0LpSC
	5onRFL31IV3S0V8iFv6aaOnSgUzHoaOygj8W0fG81r87yvhYXV6AVol2pyQkRZquD9H07fZanca
	NoGlw437Am4r1KHA5CRY1R0NTxWFXfZA==
X-Received: by 2002:a05:600c:4695:b0:477:b734:8c52 with SMTP id 5b1f17b1804b1-4801e2fec26mr58535975e9.14.1768598831755;
        Fri, 16 Jan 2026 13:27:11 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1edb:411c:5531:1628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm23382025e9.16.2026.01.16.13.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:27:11 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 16 Jan 2026 22:27:06 +0100
Subject: [PATCH v2 1/7] refs: drop unnecessary header includes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-1-925a0e9c7f32@gmail.com>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
In-Reply-To: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Elijah Newren <newren@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=iblIaNq1ESBmFCWkQYEZO/GF6622kyJN1m7QnM+yAMM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlqrSxS6qsbwgmM7YiYsTJFoDazTDaJfIMSo
 MP2dCX2WtibSokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpaq0sAAoJED7VnySO
 Rox/KUcL/1pQpY/Vjkc3Eg6LyGowj0nnrM2BGxRnNXYLDQkqmmV/JjzNc0pkiq6bqdyQdw7S/AH
 BP1ZctoBJx3kj7hA6xaKBD1NjFPlzBCrpxXls0DrsKO/fZwnrb4BGzpX4x7tLplatMU1zVQ+Fj+
 41h9czhRbZAPsoZxfyLDuJtmwY8WqWSu0fQUO193EDG/7yYS7idqnLG23kxgSizOdkbF/hzbM5q
 2iXLPyD9tEsvREuO8yrf0El3XyokTP2sKoscSjrE1yCvC4TySF57TTarGqrMinprkZO3a3Otdwz
 CGan9wzTlspljcG0pHU08bskrp5O0AekZ2UgT3AZahXEVAPEcaKF7K6rTkyEYlqymICj6Dm9TuM
 MvHq4J6G4XZLKZpzI/FsOPKiBtkNscgVmHJNHdiB8r3fIpdvDhnRsJuCUEcLZYVkMFlrL7mFnqA
 /jfae21eCD405Bn56tfH/uBRmC4H4l6fKsK05E+fHxzXFFO4CdZfWnQkQIwT0coQ01H7F8l8W75
 vQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'sigchain.h' header isn't being used and can be removed.

Similarly, 'run-command.h' serves no direct purpose here. While it gets pulled in transitively through 'hook.h', we can still drop the explicit include for clarity.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs.c b/refs.c
index e06e0cb072..965b232a06 100644
--- a/refs.c
+++ b/refs.c
@@ -15,7 +15,6 @@
 #include "iterator.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
-#include "run-command.h"
 #include "hook.h"
 #include "object-name.h"
 #include "odb.h"
@@ -26,7 +25,6 @@
 #include "strvec.h"
 #include "repo-settings.h"
 #include "setup.h"
-#include "sigchain.h"
 #include "date.h"
 #include "commit.h"
 #include "wildmatch.h"

-- 
2.51.2

