Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612371FF7D5
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088015; cv=none; b=LBZGDehN51Dl5KXnLuhiVoodrZ3E/1Q+a4bhmyBzjZaGcAHp8VeCVla3DfBBZv7haC0rN35JPnnF33NYUiTIkpuSTOYMMbUvuNVS1espmO4hWv3QFc/zz44vhLwH5mG3hraD91NvedQxIlpy7iEBmV/pOh8h9exbwWuuOG2htz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088015; c=relaxed/simple;
	bh=q+vi2o/BRetHpdyPCla7PMCBQXEHfoqPrtYAE7uFrcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWMrCYzKWLlYVhHnHDIShWWuWNARWBIb/So7VTIW1SQnMpyLKPTZ8sLan4jIX/bj/kEhxm4yR+LjDJ/nJgfAc1WkhU/Xg6R2soMAIlrqsOrBLfE/Ilt0sb7v3aCVH0lmelM/PwXjpSRWFV0/YL01OvLlZWCwdmGewOIyJOavnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaSQnjzz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaSQnjzz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bcf9612f4so825665e9.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 03:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741088011; x=1741692811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ktuv+L9G6FfpnvIBw/suZ0PDVtCodL8tXV7UbGwGZqc=;
        b=MaSQnjzz3e+RBk913ghaan5V6ahcdhjrBiHOfFHveeX8Jx6GYQM3GL+HoWr2v0a88k
         UbZ5O7B/Iagc5EqWvhJEoWOEBvmnYbVvIDCbe9H8jBTyn6f+W/pK06IdMCgSXANOTIup
         A4uEUaTwQ+ZpxEqKh2i/lsSfauS0cp/n27rFMiqjL+Thw0/nkNyF8w7UXtRIi1p05IUO
         cqXWGYGJdJlqTLNXtnCzCbUltkJl1kav7ePohMQorfS/o0hXKPvjFIQGuVgBPSzRTaI8
         ERY/avIXFJpi11P8k/llU0muwVcu92yVyfOX7X3LfRnJAtCzEf1Zsu6Z/Qi+Rj1mkk/Q
         y7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741088011; x=1741692811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ktuv+L9G6FfpnvIBw/suZ0PDVtCodL8tXV7UbGwGZqc=;
        b=q8JGNWhwBAbsfY6HYQCrZLm1zJvjI9aOIUUr6hbUBLXVUimc0d3k6ORh3icsSTcjAo
         96ZiCTqDoIgcaZAjDccLBLHfETKBkictGdy6ghtJLslHoJ4oIrJbUwHraKRJbHfY7JzP
         smqxp5VQcwqPfMLIIkP7droQaJP/YCdSRKEloByjzTdTokI1sFjlJYsGdH/JE934V5ry
         nEeNPpwxOXlTZ/Iqz0aLtgESDwNO3QQemu2qJ/FkJ5ak0VvL3CQJGk9PyhbiwLqEF+cS
         DN7IxG3L615MqhIbzj+PQu9hhn5eJhHt5NRaVfD05af5jH0C3nYpta2oAm+0LtOUDcjB
         tOVg==
X-Gm-Message-State: AOJu0Yzv7ztNWJ4yZvGcIm8iPD9vsXUSfrcwCwsO5h6zLqZve8MiOIFe
	tQlJOapv9WvxPAK8LCj6jpMlKcwZRpKMQX15yKx2SE5m8SAFZejGsEBaVIo97Gs=
X-Gm-Gg: ASbGnct1Z2x+DwjRygiFDpkWckuvFUdIhGkXRbA+r6WCa9+XO4qAzhl352saMbhMBEm
	oT3hWisXDna6ILOj+rvNdXLpV/xtBRgORUIfBsk68EnQZnHOgOvvGSeRoOWGFMKIIwf+V7XGllZ
	uE9a+0TFcDJzYnmVkOkhWQmeaFAhJvlZKIyuxZOON0I+01z1fZ2vJ744nhOm8C8BqoCQ8+IZ8fH
	FJkls0VW3kf8nuOGT8+chHuXt9mf6fERSYCFPx1twTmfLksBiGLoL4dxPswuiLsM8zMOjPbhOkO
	LapoIFHgDUbxJF0t+L0wqpxqZ13pqZ5OhNYYwYbCNWun3zGJJ/R2z69iTqE=
X-Google-Smtp-Source: AGHT+IH/77qviQjWxv0BcLRsEZD6DcFYGkToK+Cmg1FUU6EMtCa96BvadNBMm5L2AsjjUzFAbpJcyg==
X-Received: by 2002:a05:600c:138e:b0:439:9a43:dd62 with SMTP id 5b1f17b1804b1-43ba675a8fbmr117243115e9.24.1741088011026;
        Tue, 04 Mar 2025 03:33:31 -0800 (PST)
Received: from localhost.localdomain ([154.118.41.125])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e47b7d12sm17764128f8f.58.2025.03.04.03.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:33:30 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 0/2] t/unit-tests: convert unit-tests to use clar
Date: Tue,  4 Mar 2025 12:33:21 +0100
Message-ID: <20250304113323.10564-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series transitions a couple more of our existing unit
test files to the Clar testing framework. This change is part of our
ongoing effort to standardize our testing framework to enhance
maintainability.

Thanks
Seyi

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Pillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

Seyi Kuforiji (2):
  t/unit-tests: convert trailer test to use clar
  t/unit-tests: convert urlmatch-normalization test to clar

 Makefile                                      |   4 +-
 t/meson.build                                 |   4 +-
 t/unit-tests/t-trailer.c                      | 317 -----------------
 t/unit-tests/u-trailer.c                      | 320 ++++++++++++++++++
 ...alization.c => u-urlmatch-normalization.c} |  60 +---
 5 files changed, 342 insertions(+), 363 deletions(-)
 delete mode 100644 t/unit-tests/t-trailer.c
 create mode 100644 t/unit-tests/u-trailer.c
 rename t/unit-tests/{t-urlmatch-normalization.c => u-urlmatch-normalization.c} (84%)

-- 
2.47.0.86.g15030f9556

