Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC5D29E
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943855; cv=none; b=hEDKIb2ICTfCISoFunbML3wpcnJ+CJlo8e/Jf/AcX/INCG9oiFhjEWWfgsr5bGVdowSnsJ4rpdBujkBrLdXfg2p3gD7Fw8+6TjgINMcj5neIHaGUUmoaLkm1RhBJgiGxHB7jfnnyoG6ldG9rDSAPbEAd71nmXkQm1uAQvEF6tXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943855; c=relaxed/simple;
	bh=cL3aOVfxxbt4zlsBsUTUTzlLvWttpf0Hw/ysFezuahM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq3PxAimMykNrxOBhulof/NYyT2vSbFyAiQodosF3DA5+SUV8k+jrbuBgAsowuhS2Hh4+yyIMlnQ4y20+vRjEAZRwMNGf7YMfutUr+RFKkUBEIWPg2/aaf5Kgx+3kJEHBFc4AJHTfHq1svvVD43QFRB1blehMvUX+1JqwAX0aZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpzwk/XC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpzwk/XC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2b1cd446fso53837655ad.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713943854; x=1714548654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cRHkc+coJ/gKZ6K8Wis3Go/U9gQCqDF64ll2PosxBw=;
        b=dpzwk/XCA3ei+meuz6iXOoYpr30aTjYzu1yEp4xQnNTspJyKQQeMNEgtyvUUqwUxzS
         w9JqTOtlb8EU9LWcJ+pkWyNCzbXG60fmBh+yCUjkPkf8OQ1UvArR3lSVGfcr2cD4N1bL
         Ef+PbyLyDa3a4Gwrorbuh8rbRUudDbHWP1lVJ7qAobaFhDYjgqm75hH+NG1IEWtdi8V5
         +z+NStYg5MyWEsO3/ADJ6q3n53gbhMx9nzcL+2gKXGjnaGuklUcymbMTiVpXAOk2yGhK
         BCkiCX2iaQPWcnn3qeZmJYtVA0NRciNqLd+gdJ0LXgeK/DOzuWFEnKPayKdbWJcz4xBE
         Csgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713943854; x=1714548654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cRHkc+coJ/gKZ6K8Wis3Go/U9gQCqDF64ll2PosxBw=;
        b=jm3/oIfb9dY7pm2PYagPJt5A4B+0ZJHR9haNk2UKSOkZXP2I6vAnImqPingVf60GPO
         WTenzClp8tZa6a8Kh9qLC7+NahO5dd0+dFa7cyduIyIsz35G3DJmMI7ohOP9n/oMUKGW
         po4buN+lLvS+ymGT1EUBkGmznbQnY0JYutUAinuVMALGkpivrFErLRABBQPEfSnbQMcq
         1MtlGsWhIzE2yvmmiHYLOlh2IwgTIBp+Ygx8QN/gsSM401dX4FoMVJu9H/F5N3wq7qTn
         vXF+razefrGc2RdSbYdQNVVNQcMRD7Fg8U6YkINv7K9oby+DRbb/nNLl7q0K1V1L7iWh
         UltA==
X-Gm-Message-State: AOJu0YxCQC2ugwBF302ZB+pGwrtmgwxPW6Vn0TLTN11VI3bt6M0OxmNy
	ijJvmZfyBAzYt3dDTH8ieRYz1nPcv+vG0283YiGmjZ1wSf9dm9A/QpzR0g==
X-Google-Smtp-Source: AGHT+IFIwJDF01aV1sl3GG7lEsGLVJFfN+pHyna1dQ/ky3YVts0Hz+fued2iR0U1C/HzFOojomERKw==
X-Received: by 2002:a17:902:ea08:b0:1e3:d8ae:df34 with SMTP id s8-20020a170902ea0800b001e3d8aedf34mr2090957plg.11.1713943853680;
        Wed, 24 Apr 2024 00:30:53 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902dac100b001e0ea5c910dsm11266455plx.18.2024.04.24.00.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 00:30:52 -0700 (PDT)
From: Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v2 7/7] builtin/reflog: introduce subcommand to list reflogs
Date: Wed, 24 Apr 2024 15:30:47 +0800
Message-ID: <20240424073047.53755-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.43.0.rc1.4.g79da3975.dirty
In-Reply-To: <d7b9cff4c360147e65df17316533fba0b4f2ab7d.1708418805.git.ps@pks.im>
References: <d7b9cff4c360147e65df17316533fba0b4f2ab7d.1708418805.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> wrote:

+#define BUILTIN_REFLOG_LIST_USAGE \
+	N_("git reflog list")

Doesn't seem to need a translation here?

Thanks.
