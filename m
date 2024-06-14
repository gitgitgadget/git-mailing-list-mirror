Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E21922FE
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358723; cv=none; b=C+FF7/4LvQCiPB5zNoP49mxawf8ZNjzbS5YyRhpws5xgwEfdaJnsyMgyJKXg/gXOxC3lf4ncF+6nrMxfaAOMIJGTdH7BlxdeKVp5D54Tih1Ebc7i6EtEJyX8wF2tV/VAkvePMjelHTjD89Ka/7iFP6YftBp/fDavL9XzY+pwm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358723; c=relaxed/simple;
	bh=kZD8JNrX9jXxX+BSYOzHWfMFugKa66Ei33gCqR3JXcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR5y8Mgky5pRvsVDMnfuaUq3EUjzGeop6iFMSfj9PgsR17tkxZiKGDJfuDYbBm8PJEce8peuNVpREhYP3sgmCzmkgg0GfujtT4U1GZMhNECT0w9woohe1Itg476cyk4LBgdqu/8HFPOX+Mj/EK21b8U445kRq/UgDLVEBaFLQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY6Bcu1z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY6Bcu1z"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6819d785528so1530525a12.3
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718358721; x=1718963521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4QliobfXIERYWx19YZn64qU3DYSmJCoPEyLD1uQ1wU=;
        b=ZY6Bcu1zlLhODpLyyHzJhMC/fY6ZVl2wGIRuqbfFvzNpZqEFbVWw85PgJZKRklQDmQ
         jI9BkUumIE5CsWjPhByOP9E1E0lPwVvRgflLtAWM+9LR13Rc6Xirl/CUdw0BfuuClEAi
         ibFjYHPPvghoonf0aHMQ6+oD8r28AHe9SaOg7eLJHaoT5rFOskdiExmTDDLlIS9kKXxV
         Wh+JZZZvwdEURMwN/RIReMgImcpx055TDzigsneJfki0Pg6gg1d6VL+dBK6/rOYpal68
         kBkqoVIxsTCtGFBnMG3u34WmDg7pEq4GLqjTX3zfeX18Ar3qgSOhjsGZ8nEFombG4WKQ
         JwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358721; x=1718963521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4QliobfXIERYWx19YZn64qU3DYSmJCoPEyLD1uQ1wU=;
        b=k9a6pPyWuwx9tlTAHGckUpwqd4JKqmvJBcRuTy4EXo2N3boLu0k8FXt7Cj5IaVhK89
         Xc2kLw56T41WqB3+2ognUsq6ZqbryHeF2hPQ0sdSHWTEUBRWeL89v/kwjOWb5AYDAGXv
         X3Wehyy1/NtIETMyXHZMm4NANibdRj+5kQOnTbq+NrBNBEyHBnYtDPmXisUA+KQIlRGJ
         R5AvOjw8OmjH8ttUGv+teM+P8OmAWlCLfqR8/VfrMp3Jgr6prkQ5oyUnWDf9XXlzB+XZ
         flherZfNQdL5mH0rMbfe0STMKmSuWm9+b5e9gTWRJEBlHQt4sk50ZDNUV19dBoObvqDG
         uGVQ==
X-Gm-Message-State: AOJu0Yx7lVgpQuaVbRnd/weLIuDM2JABH4/tQCFup6YfCDvEzRsHQ5Y9
	mgK13BshV4oCMbTB4G2horQoebV99ydoXL3RCaYbQ3rhmO/iXeHghodUvJSlLw0=
X-Google-Smtp-Source: AGHT+IEUuldNhigFVe9k0WnkUIX4egskGbtqfxxu4z8MYFUWdX/Ziu2zp7tG1T4tl+NRPSitQulXBA==
X-Received: by 2002:a05:6a21:3942:b0:1b5:781a:61b0 with SMTP id adf61e73a8af0-1bae8451ccfmr2153491637.61.1718358720810;
        Fri, 14 Jun 2024 02:52:00 -0700 (PDT)
Received: from Ubuntu.. ([117.96.146.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f868b83afesm9230005ad.156.2024.06.14.02.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:52:00 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v4 0/7] t: port reftable/pq_test.c to the unit testing framework
Date: Fri, 14 Jun 2024 15:18:00 +0530
Message-ID: <20240614095136.12052-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240611083157.9876-1-chandrapratap3519@gmail.com>
References: <20240611083157.9876-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
testing framework written entirely in C was introduced to the Git project
aimed at simplifying testing and reducing test run times.
Currently, tests for the reftable refs-backend are performed by a custom
testing framework defined by reftable/test_framework.{c, h}. Port
reftable/pq_test.c to the unit testing framework and improve upon
the ported test.

The first two patches in the series are preparatory cleanup, the third patch
moves the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v4:
- Add a commit message for the second patch

CI/PR for v4: https://github.com/gitgitgadget/git/pull/1745

Chandra Pratap(7):
reftable: remove unncessary curly braces in reftable/pq.c
reftable: change the type of array indices to 'size_t' in
t: move reftable/pq_test.c to the unit testing framework
t-reftable-pq: make merged_iter_pqueue_check() static
t-reftable-pq: make merged_iter_pqueue_check() callable
t-reftable-pq: add test for index based comparison
t-reftable-pq: add tests for merged_iter_pqueue_top()

Makefile                     |   2 +-
reftable/pq.c                |  29 +++--------
reftable/pq.h                |   1 -
reftable/pq_test.c           |  74 ----------------------------
t/helper/test-reftable.c     |   1 -
t/unit-tests/t-reftable-pq.c | 155 +++++++++++++++++++++++++++++++++++++++++++++
6 files changed, 166 insertions(+), 96 deletions(-)

Range-diff against v3:
1:  3c333e7770 ! 1:  1873fb02ce reftable: change the type of array indices to 'size_t' in reftable/pq.c
    @@ Metadata
      ## Commit message ##
         reftable: change the type of array indices to 'size_t' in reftable/pq.c
     
    +    The variables 'i', 'j', 'k' and 'min' are used as indices for
    +    'pq->heap', which is an array. Additionally, 'pq->len' is of
    +    type 'size_t' and is often used to assign values to these
    +    variables. Hence, change the type of these variables from 'int'
    +    to 'size_t'.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
2:  bf547f705a = 2:  3cccf8266a t: move reftable/pq_test.c to the unit testing framework
3:  7dd3a2b27f = 3:  4b63849694 t-reftable-pq: make merged_iter_pqueue_check() static
4:  c803e7adfc = 4:  3698a7189f t-reftable-pq: make merged_iter_pqueue_check() callable by reference
5:  0b03f3567d = 5:  d58c8f709e t-reftable-pq: add test for index based comparison
6:  0cdfa6221e = 6:  69521f0ff7 t-reftable-pq: add tests for merged_iter_pqueue_top()
