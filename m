Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA015A4CA
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707653496; cv=none; b=la8xfQmn1ZCwwgZ/PyWPoI7b94ElQhEa3YW34cadxZEqVWuo8x5VhmdG4aEjLOd52q9Fmegg3BymFCCBnBexISUShL3aMLbz9DjwsIrHOsK4DRF7vL0w6uI6tbaoPz59+XluDrKwGYAtPR22moZxcy9zQtZSuI6fvBb9KdRCqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707653496; c=relaxed/simple;
	bh=R2OQKiwNIU9HIwuxjtGSyz+lNH6nPEbG3P0shnK/WgY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dFMOpLZ6Tmr7DdNtqgluPPu59ogQI2uWWOikk7QYdJYjqN0d3ESXRHf9fDykMUdRH87N7OHIsDuONy6SuUddxHlFR/xceWLUs7y9pZjEaJsCS0ktNEx+5ypjxXH5HPnILewWS3P8Pz+z3GcYNoddsAZH2a40h//0ZZGre3BewBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlyb3Vx+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlyb3Vx+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410ad88f70dso5937395e9.2
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 04:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707653492; x=1708258292; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gGiCEWNv8B45BXvhtb0Vwd0ZH5xsux7aRXwP0tuBqk=;
        b=Hlyb3Vx+MuHDFgZpwy7WQx8bmyFpMYdq23I3OYJnh0JGYiLgQhvEtmrssDQ7/V1Z0V
         qNT6m0qSy0V5FPXvh6bWi1UBYuiPFnBTATAH5yZLGGwc/YenO+JvMb5dmdiyXfmuMcMB
         Qab31WM+KiH1n2mQhX1hyJFzXWbHQ9crYg5opAgcBCJIcC0/DLsJ12gUQvs6bXVbIGXD
         KHTgVujX/5Vi8kq3C+ePwg+WjZAjDHCluxvlgjbGJEoTRYYk7Sgex1CkLuACN/WdTc2H
         NAsOY5qSeHRqYiMu5KAD6W63jJKRW2NpIUozjSYQCHQO+DaqIw9pvlFR6goSZrHSOq3V
         lcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707653492; x=1708258292;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gGiCEWNv8B45BXvhtb0Vwd0ZH5xsux7aRXwP0tuBqk=;
        b=eBsUvMfyOu11Bw3+zQ+wWFs7gXSotT+oGdmkYJbsWVXUKleenDITajTeAuShPknIpJ
         tcAx8FyP/1UPHQh5DuSS1oSWGfv2t5ALynhRUxuEWtVIynx7W5wIMQXl+d1sB5M4G9L4
         FUBtsGw47sI46mBrK3WKYF3RrWk4eTxbCjhUWNskeJ9oRYpJ0ZNGYVGvwnkOnwKvsuMy
         jkvMShSOHJkCrkp91eHOzo7KyzgaZ3di1qVH48gAL4yhEv2eqh6NtG7iwXht+MoBD0Gz
         HgIoOroYu7TsMyx395gvE/5XnMijQd78qGveJ8+7JqGYPKGJcLqGp8kM2ONHKSibMmDU
         tKHA==
X-Gm-Message-State: AOJu0YzaHXLDTJIA++i5LQ/wJ3M3ClGAmrRZgbKgBTLXlPLY9bxf7yf6
	LRt7E7mQaZ+ZY969fj0VZoAwjHc42NaEvuDTmelafmEeMTqzXaiZWedX77Aw
X-Google-Smtp-Source: AGHT+IHmGZeogRU61IKDOh3a5Es5Lg6SVRlOBMecEbvgvg799znVFHkYYw6DfSnjUMXTRstfsiGEew==
X-Received: by 2002:a5d:668e:0:b0:33b:21bf:f0e5 with SMTP id l14-20020a5d668e000000b0033b21bff0e5mr2543117wru.0.1707653492311;
        Sun, 11 Feb 2024 04:11:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bv15-20020a0560001f0f00b0033b48190e5esm4132943wrb.67.2024.02.11.04.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:11:31 -0800 (PST)
Message-ID: <9088cc60bda0f3f0d152ddc3c22a60effa272483.1707653489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v2.git.1707653489.gitgitgadget@gmail.com>
References: <pull.1660.git.1707652357696.gitgitgadget@gmail.com>
	<pull.1660.v2.git.1707653489.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Feb 2024 12:11:29 +0000
Subject: [PATCH v2 2/2] ci(linux32): add a note about Actions that must not be
 updated
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Docker container used by the `linux32` job comes without Node.js,
and therefore the `actions/checkout` and `actions/upload-artifact`
Actions cannot be upgraded to the latest versions (because they use
Node.js).

One time too many, I accidentally tried to update them, where
`actions/checkout` at least fails immediately, but the
`actions/upload-artifact` step is only used when any test fails, and
therefore the CI run usually passes even though that Action was updated
to a version that is incompatible with the Docker container in which
this job runs.

So let's add a big fat warning, mainly for my own benefit, to avoid
running into the very same issue over and over again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index ec25f6f99de..7bacb322e4f 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -344,7 +344,7 @@ jobs:
     steps:
     - uses: actions/checkout@v4
       if: matrix.vector.jobname != 'linux32'
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v1 # cannot be upgraded because Node.js Actions aren't supported in this container
       if: matrix.vector.jobname == 'linux32'
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
@@ -359,7 +359,7 @@ jobs:
         path: ${{env.FAILED_TEST_ARTIFACTS}}
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != '' && matrix.vector.jobname == 'linux32'
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v1 # cannot be upgraded because Node.js Actions aren't supported in this container
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-- 
gitgitgadget
