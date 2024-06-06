Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD513B7A9
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660634; cv=none; b=Pj3/2BW5EPXsuowzHsrUsWqDLBZORRet68mD1aqF45RjQLdU+Y8boEDheGatEE/CfphthYoGjn5ZygO3f8BckK1uCNQNLFpEAM157uKgJpcl7i8GUSVJ+97KwLcxtnBzNz57YQiLii7PHHaqEtmt6W1/vZdOJzTBmcOeGxCeycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660634; c=relaxed/simple;
	bh=Hy9ajnrbh+wuSvyjThhvlUxbrgbZPktgE2ZdYiBm8wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBLFHf2GnN7g2NnPCqzk+Meys2nn9DuNHK0L7a0yjyVCZ0CDTQ1HZGWwzu4/XzP4Ag8Y6ZWkUCrlUCH2EsaWsAWYJb2eR7eAdNAULoqG52sDsQMlLNSl4E3Rlg2aKqApF+cxfYiKSAf6C4xX8ga1YJEduaw2xSO5rXKqLF6kRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnF5yF2/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnF5yF2/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f480624d0dso6508055ad.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 00:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717660632; x=1718265432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy9ajnrbh+wuSvyjThhvlUxbrgbZPktgE2ZdYiBm8wo=;
        b=fnF5yF2/Jhjl4tqn70xAAFILLFXz1BVzogOxQYN0TBB7bbRO2jEqichdz0J/Y+l0Ag
         A9SO/5uFe/6Vf+tCNcr7M4LLfYP8EwRfWRWJnH4DNpGpqb5ROdeN6izk/tQvogmCU+0g
         yrCF0HHD0pCZ/ygRaPlvcrD4Lx1ZyYuRtoHZ0FUGPQJKrECOowl2ewJC6hA8DZD8vnlR
         uUhTfru+R31pYXtfFxjNyZwNT5w5n6/cpHB80x3lCWn9au7esHcGdmESmVTjs7YWjOFX
         hmIELUN0Boti9pal+X0J3YvVdcJMPKGmOzQpnYC5w7z4gPgL+5GKptdHfqZIfuDEr4dF
         +XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660632; x=1718265432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hy9ajnrbh+wuSvyjThhvlUxbrgbZPktgE2ZdYiBm8wo=;
        b=ROP0m/rAHRBpJ2BelClcyGeFJrCLW3AakFZtQXGBAJqWlvtTTjeH8vN6fzTEAwmv95
         U/+I8iAc7M3Db2R1cEDz8U4QXWXAkSjTSv5PWysYhbONXwfZD2/Oawtcp2sKRUHoGuwm
         6cnVd9Yu5Pw5VC8Xenwyvgdl/knfJnxDPPtratE12Fpbghw2rjrQwNLRq7g+pIJtNj6l
         IkAcpbA2rNQ7iOXUoRd6kNZQKcRjFZG73At1ICx5TPCGsa1I3id4zYTmLH6p6Evxl6tl
         08usfrhz6UOPFXO7ZFUDJ5H+IRIlbUH9MYNVtCBTlbrKWQNIrr4/kIeQpGnfFYYL6lWF
         ozRg==
X-Gm-Message-State: AOJu0YyTC+OjqJhHUsN15TI65mHWVVox+OLrFUc4St7drBtCM/hvDpOk
	0Q3wI4T99qku3mk88CelvebwkTDoO6kdPdO5OuRTaP4+eg8fHlFSIF5mC1i+
X-Google-Smtp-Source: AGHT+IGVCdJCEG6JLD2kfk4qwTQEbOSFln8PK96XaED0WZF+w0UBhlOJTe+76tcGox0H9kJLXogwTA==
X-Received: by 2002:a17:902:e547:b0:1f6:677b:ea1b with SMTP id d9443c01a7336-1f6a5a0f741mr63359125ad.24.1717660631869;
        Thu, 06 Jun 2024 00:57:11 -0700 (PDT)
Received: from Ubuntu.. ([27.61.69.112])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd7ed6b2sm8192415ad.246.2024.06.06.00.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:57:10 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH 0/6] t: port reftable/pq_test.c to the unit testing
Date: Thu,  6 Jun 2024 13:10:44 +0530
Message-ID: <20240606075601.6989-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
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

The first patch in the series is preparatory cleanup, the second patch
moves the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

CI/PR: https://github.com/gitgitgadget/git/pull/1745

Chandra Pratap (6):
reftable: clean up reftable/pq.c
t: move reftable/pq_test.c to the unit testing framework
t-reftable-pq: make merged_iter_pqueue_check() static
t-reftable-pq: make merged_iter_pqueue_check() callable
t-reftable-pq: add test for index based comparison
t-reftable-pq: add tests for merged_iter_pqueue_top()

