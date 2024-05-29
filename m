Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF2B15B14B
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966275; cv=none; b=ofbwWl28L6SZcPaURyo+pLxOBCXj9N+jf5WEcTOYcmm11ban7B/HJD5lbPBqhyIrkIqZ2hyFx4hZu7Fl4MmMqShSv8jWt6020iLiDpOzM6HRCUWni3xIf41eD7DC1gDS9z1W98QVzrxDkStNSJ11EO35600ARVDSSRZjADw+THY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966275; c=relaxed/simple;
	bh=FIwyfTOl66L9GFM/9QcKKcdXgcuXw6dY7COkf2pB1tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gu5ljSaArHyCVQfoJYU09mXnsVWssHNfeLXmguF5mv650uL8tJAOUPsG0EYJnoPtU4pxCDR9FXAN4eSvlp2BAnub6lwBCvE3FvJZAwm02Sv/zyu5bYgg8JyZjZfUItcJ58k9TTldYZidDSvJQjczl7ciKGXwosVQiPM2nP07bHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEtWEHG2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEtWEHG2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f8ecafd28cso1310697b3a.3
        for <git@vger.kernel.org>; Wed, 29 May 2024 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716966271; x=1717571071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIwyfTOl66L9GFM/9QcKKcdXgcuXw6dY7COkf2pB1tc=;
        b=BEtWEHG2s9KLbzD0Jo99gjC8sxtp9T/MIgN94tTUruqWE1RaoJkpgE/WQdwHSTSU1p
         MFigXfHjuFBORWl43wncc4SvSREQ2V0dPureaROFZQpCDfNedS+tZ3IcIzWvORIjGcxK
         vfJOj7yj/SLLRWiOVsx+1YUAngBJVQykBDrf8Bh29f/rZr/dhEVLMOyazIhJH7Er83F5
         cGZ1CNNP62+pbTP3l0jEW3zYC/cVDxskIhKbzyr05U9oduMxV0q7g9nPY7VR50CrZx4q
         ODipmFLE7+lrd+sZYYSLu4b8vj1RW3mKyK1iaC0CfQju/D23Wu2WgBD8L59Z3eIwneFu
         4Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966271; x=1717571071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIwyfTOl66L9GFM/9QcKKcdXgcuXw6dY7COkf2pB1tc=;
        b=TFb37EsyKwQHUoXKSROiRmO4oVVky+Mtzmbotu+ZMOOtC2HiV3/wATaDdFBGjrtvsq
         nGFoGcQwcKkIZGBvBdDROLmRsmDx9J48bgv7LDi4rtOMxRNm4TPnihVegeNbD9m4KcQF
         gEASFp3cv3oarzJBMsRz5Z0dWIcSbUIiNUmgS9NvJYl7SGLKWhld8AREIniOixuQIGKP
         CsB94g8kBwMO5jev1AL763tqlSPd+4Dvo+ECHl6LX/JAHdJcCvEui5JaDHudK0m8rvVj
         TwEk96pgiJTCw32lHIrCdMjTsrf4e4tmzDqhrQ16dO0Xx0lCcqf69lS4Jh+AE+J6k2N4
         IvvQ==
X-Gm-Message-State: AOJu0YyC4nC63F0jfyWv9H1BV0WR0nZX8Ja1ugDakyG/VtiIXRZB451r
	Aa8cniY0UyClUGC3Aymadu4883XtVoSHBu3XLnb1aq9R4cvXgZI9OrRNYAZJZvQ=
X-Google-Smtp-Source: AGHT+IH0TOyWnxl1G1QLRMxpMmI+UYOwmPepPcF8/MGCsH3WwowOGATRq/vJUJ/tZjQspbSBpI85ig==
X-Received: by 2002:aa7:9302:0:b0:6f3:edac:d9e4 with SMTP id d2e1a72fcca58-6f8f3700476mr14197582b3a.20.1716966270709;
        Wed, 29 May 2024 00:04:30 -0700 (PDT)
Received: from Ubuntu.. ([171.51.188.185])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ea03sm7473376b3a.39.2024.05.29.00.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:04:30 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v2 0/4] t: port reftable/basics_test.c to the unit testing
Date: Wed, 29 May 2024 12:25:08 +0530
Message-ID: <20240529070341.4248-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
References: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
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
reftable/basics_test.c to the unit testing framework and improve upon
the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v2:
- Split up the second patch of the previous series into sub-patches

CI for v2: https://github.com/gitgitgadget/git/pull/1736
