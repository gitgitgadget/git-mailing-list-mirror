Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209217CD
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711060826; cv=none; b=CIOtvHUOU44rixq1+zJS8N5xcafT2A5W17C5tQUCQxa00j62wxYs3RfhaesYJ2RTB4a6lXfogW/6sjpjeU8Rk8RcoWq0RvwmL04NV7RqR4LF1A9ZYmb2DXbmecpTz5V5JAMyvQoRZANATg6h2FWHzlK4IChZBG1QGXeCXKYbepw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711060826; c=relaxed/simple;
	bh=VJIF5meFWE7Fg/1Gsf+o5Ow+XVN2Q5G+1dd2X+H+wlI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lWhraEQ86EpaVk+Zfzq/PU4T5LSRWJcDeC7njWmA7C8dsX7Xsn6mB/pY//IXvd/QkHlHHRWYsa9BjOtKsxjibwUDZN/lLDK9Qs/XBIvpuhFoQu3dWkJaFszMWLXfM1l7eI7fKsZ20JUmVwO100jpC7RZkoW4IIYIKAYylg0cqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JODWp0fO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JODWp0fO"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ff53528ceso891807f8f.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 15:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711060822; x=1711665622; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIZyJ/hofVbeu1GReQb5fgigxMBucHrxc0j68laoQwY=;
        b=JODWp0fOVEunuiP49MruuQqPSx9ceiBl4oR8vmP4NwpHJVFZQS2EiWjxvTyXnwAKCz
         DuFY1EQIiwBvbPPXjkTwBApZXc1Jcnt21bqc8Q+BYhgJ/eKIensSxGNiRJpdU7NnnqqJ
         tox57FgMznVCagM8vlZVgi1posgnziPncWmN51JnWw9UJJG9geGjvHPiffI2idohbfaC
         GIPLJjhToS1wkDWY1C3YFuVn4JLAztWHM/LWfwO5E7RPUm/tN1+jUtvhpSiz+SO9F56Y
         jKqffiYlyr2OCnAW+PDKxPHL2T9TGPhEVz9+IqkDYehcdifwNgUQve2psHtk6nZaNwn0
         9Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711060822; x=1711665622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIZyJ/hofVbeu1GReQb5fgigxMBucHrxc0j68laoQwY=;
        b=TsTr5ngIYh7NlIc0iFJvPqWouYzj2u7eYyxxqpWttUja7PXNwjMoUyGSX9APpDn3dZ
         OXT0/9dbwJd1/DPKjFToIMqZefqtiFOv0QfOW6EHBs/6yY6PD2X6t3ZgE6P71KDtt2jh
         bSU+PsWC+hkDeLWsvnTgoK2rN4/jWD2aOTUk34UKJppeSUWocR/zsQvRD9YpPTa4Wb7x
         9DuWRvHq3x67HOUf2CMlYTsTtwPHMww67p/6lhJaw7/8/qX+AluS0WPV/zQWqPsAQ4Gb
         9JyI3A22smLMeKguxP7dD0v1v1m7DA7dtpzn/3BOqXGwRz5uDcOdxnhWFBn9BXMb7qx4
         Uf4A==
X-Gm-Message-State: AOJu0YzKZK298DiwBusMalAXQ1a0fGICLbVVg0xN2dFcP4u7IZM3T5AE
	ozHCiQqF60KXfoRyqDFUy52ho41kdgQf3PV0cSZgl7uUJ1OhNMDDNpQsRtAy
X-Google-Smtp-Source: AGHT+IETrcZNQqXw8J9W5bLt+I8tGgfAh/AuMbw+IIZRvbb+2sDm3dFQfff1HHC1HhEF2kT4e2Jl1Q==
X-Received: by 2002:a5d:4d0e:0:b0:341:a60a:2d17 with SMTP id z14-20020a5d4d0e000000b00341a60a2d17mr317061wrt.8.1711060821935;
        Thu, 21 Mar 2024 15:40:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6-20020a056000156600b0033b7ce8b496sm613607wrz.108.2024.03.21.15.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:40:21 -0700 (PDT)
Message-ID: <cb6b152e5c86ab14165e072ac20dfa865b5f3aaa.1711060820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
	<pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 Mar 2024 22:40:17 +0000
Subject: [PATCH v2 1/3] reftable/stack: add env to disable autocompaction
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

In future tests it will be neccesary to create repositories with a set
number of tables. To make this easier, introduce the
`GIT_TEST_REFTABLE_NO_AUTOCOMPACTION` environment variable that, when
set, disables autocompaction of reftables.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 reftable/stack.c  | 2 +-
 reftable/system.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index b64e55648aa..2370d93d13b 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -681,7 +681,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 	if (err)
 		goto done;
 
-	if (!add->stack->disable_auto_compact)
+	if (!add->stack->disable_auto_compact && !git_env_bool("GIT_TEST_REFTABLE_NO_AUTOCOMPACTION", 0))
 		err = reftable_stack_auto_compact(add->stack);
 
 done:
diff --git a/reftable/system.h b/reftable/system.h
index 6b74a815143..ec08b728177 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -15,6 +15,7 @@ license that can be found in the LICENSE file or at
 #include "strbuf.h"
 #include "hash-ll.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
+#include "parse.h"
 
 int hash_size(uint32_t id);
 
-- 
gitgitgadget

