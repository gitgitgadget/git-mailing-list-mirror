Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496212AD00
	for <git@vger.kernel.org>; Thu, 23 May 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493024; cv=none; b=OL9Okxm5/dOriey3twjD/UynYuT9mm4rbELRGel82lvrouKpVRxf5O/12KeWtbNdIUrb3NYzSdZEL6snkv+4wJKv6WReaOn/criAa4gR2zQVoFMQqzxOND9uBfz10rldxtnQtzhm5Awq32fORKramYjcPmukOJ/l08K+34kaWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493024; c=relaxed/simple;
	bh=4XLIIAdeS/hpTq17B0qksIGgGHOyS7k/liI3x7qgs5s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Xj1LsJTAPbVJURsxKxWwnwVrgGLWeO8L+nR47pnBNILB/Ci/nbHFSwqDuB/sR+v+efefJK3IuVAERgH2LDcfpoTiUi1sSM2EcL/vlMzFL4GrcRvu/nEXh7LqmQP1fxTeoNAApMM1kDijF13fvKUHkhfWTa3MWgNvv8gmehm2Q6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gsa.gov; spf=pass smtp.mailfrom=gsa.gov; dkim=pass (1024-bit key) header.d=gsa.gov header.i=@gsa.gov header.b=OZjrfSd7; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gsa.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gsa.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gsa.gov header.i=@gsa.gov header.b="OZjrfSd7"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48a39a0b6ddso19075137.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gsa.gov; s=google; t=1716493021; x=1717097821; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4XLIIAdeS/hpTq17B0qksIGgGHOyS7k/liI3x7qgs5s=;
        b=OZjrfSd78/KSSWRKIzVduMLr6r18qDdb3KAIzWcAEfOath9hCNuLiNXfZkfIjj6Ahk
         hzkXFaMpLTiyQjnacbZU9db+YI0XDpmGiWF9SzH3fnsrfrbmMFIlnRhjHPTHBlaWMNq1
         r2wCeHKpvAXNWXjGXHN7IWOa5JwBVUnFHICWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716493021; x=1717097821;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4XLIIAdeS/hpTq17B0qksIGgGHOyS7k/liI3x7qgs5s=;
        b=LB4577FhGSTjfuAlSYHqmx2X1EhrdAfdTk6c8ZJfgDy/wTpJF1FV7t1ySigiIYm0Nl
         LHrSRN5xQxmGmyWT5vpHL/baq3Vk2/UhC/NhhZXbxVtHJrMEzt8yZDYJI19SkBIQy5+U
         +YegllxuKQ0RuhXxM4DrO2hG0TEH2BBv7oJCpR2r/1d7yixcZLiRcPRUifEfk5YCgKMN
         1zBWtJERyw7ufp/TBM4agvHbEVbIKHWjDWk8TxqjXNmgqWofhXUJGbLoYv40bpBuUIOz
         YXDPNP1fz6m07ccg9TrUG6WSPxAcg9KtGaIC/kFkRalnzDyuz06S6FAvk9A1n4/UIbw5
         uccg==
X-Gm-Message-State: AOJu0YyTxmzfahzE95tKTVidzQSaVkPMSnCI2aCwyVH2CLEqDxUP09Vr
	4u5JzULimGnIMiHPBIevzO4v8u2YgoyRJ/6ZwX8y/voGLXDYzLbG0FojICGQYjP/EyhKR46VV6q
	15VCXroTPQeh1RzvwuICivbUcOwSgyVHdgmLqjQq3RKTZs9oLPw0XXg==
X-Google-Smtp-Source: AGHT+IH8+zjUebgDSrMRH4D9e/PCJoqqI6ApI+WSPH4qbys4XVBimmwKcgADAQJesq51rs0Q1hjFHnS2/f7SYqhUN8s=
X-Received: by 2002:a05:6102:212d:b0:47e:f4cf:841f with SMTP id
 ada2fe7eead31-48a38506d18mr448245137.4.1716493020769; Thu, 23 May 2024
 12:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mark Boyd - Q2AAAA <mark.boyd@gsa.gov>
Date: Thu, 23 May 2024 15:36:49 -0400
Message-ID: <CABBKgan9hLme+9WTNNVrZXxqO4-VRGiC3RLQgfKFUHAy3QZvDA@mail.gmail.com>
Subject: Inaccurate documentation for core.hooksPath?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

This documentation says that git only looks for hooks in the
configured core.hooksPath:
https://github.com/git/git/blob/master/Documentation/config/core.txt#L499-L504

However, in my testing, git will run both hooks located in the
core.hooksPath directory and in the local git repo hooks directory
(.git/hooks by default). Observation of this behavior is documented in
https://github.com/cloud-gov/caulking/issues/37.

Is the behavior I'm seeing the actually expected behavior of git? Or
are we somehow relying on an edge-case or buggy behavior?

Thanks,
Mark
