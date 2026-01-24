Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873EE3EBF3F
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769244639; cv=none; b=BQxGBaR2xqB3aUeRog64qdd4NtDFsNezxahLrYkRNQJ+3gMc/q7ehI91c2wTNuujmuOQU4LYUgukYq0S/uFp3jQaSPICHD22vk5OmZptTVAD+BuC1gP0hHpdYDg3e9OoyE1deVq/xMXX1/+DCeNQ6gUtzkB2IbNKnUnD9mCXxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769244639; c=relaxed/simple;
	bh=Ze1tp0ufY9y+ZE81F+iiuK2hHUxwgOblUZUG6lIaVsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kImi7jofIu8vnS/GFeNrHNJm2Ny/sEHWivvpUMoBLEok3hFFj+ph6/C5tbzdmIiapDc0drmB5zL+y0c29CuEsN52urvsR1v4gqklgPsjHNw2H+MYnf2kIKZSqBcnerNXwkT8fRZrMIBG6CZOklZnKtkxaAHOKabuE/XrVw4gqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaAUtyfl; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaAUtyfl"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dd7bfeb8aso3823094e87.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 00:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769244637; x=1769849437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze1tp0ufY9y+ZE81F+iiuK2hHUxwgOblUZUG6lIaVsA=;
        b=ZaAUtyfl1eKuEZpLRZZONVWC4j5y5IaLSfMUyN7XKWHrBUYf3JdWFc8w9Cf5yG/pg5
         2bQbvhovKMn27aJyykm0gW7nw9mvn4CZrbdJ4vzOH167+ARDZGP8vKLzXIEC3C6DdA7e
         RoaxKuxM7fkeegTASyQGhh8M55F/jkTM51kU1emtF/4lkS7eFoB4oHBXDYGGsJtZ919s
         e4UEOy7R21fTF1ip7Ux9dowMMbXEwrVi+6Hs7hFiuv8bO79C20yIXQFn+FIXCSrYzCQ0
         U9uBHInePQctQfOudzvR03g70BANn/5+T1E0hKCbhWOuazB5fWtMdxbyljGCk8SNzsG8
         ENyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769244637; x=1769849437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ze1tp0ufY9y+ZE81F+iiuK2hHUxwgOblUZUG6lIaVsA=;
        b=WLi8lMTw5ZBa4M4u2ceg72F8OaNUwrZMnNAQsPxlNc8fjBM8qnHyGREbuqqNZbUUD5
         X+jp/Kv8DN8gHOSYwpBqRzVZ6rxDe02a4sMAaWhVv6jeEWKflQwNlXLi92IRwGdoOjzH
         GuOy+RVjWkxeizG4x5QZO060/UGfxx4bxjOFLIlmPrBS1qVp+K532hXvBAMymJiVjEyo
         /Ei7nwK9dp3chrLfs+CWCYZT2DEeR0RzM8SKC5FmXn7WI6xNArox7ulTUnSSeYAhELBW
         a3j3VJ2EtUElvCM139YXRfQXnrK7JUsci3Qs2DN6YtLQNrW+a0grFewywcmVKzH3TLMa
         j0RQ==
X-Gm-Message-State: AOJu0YyIuudjKlyDlKQDkgTr70BkQzifM4UsntlvpCzS97IGyWLipzZ3
	zFwKncA1H9it+d94OKUVam3SK1tXMYdUJFiD5cZPk2a1Z2LthPjZ7CsS
X-Gm-Gg: AZuq6aLJ6DKvovRwUhNwJYDs+zwhP8YwQ6P6hKtcyfQfZKSzDEtaVIqWDFt0iOP+VLj
	gNBCZpPI8aaB3hjUU34NL+gBuvRAgKy7adlth9yfGIv/wyugUdvw3vOOA5c4WlGipjNqF0CsecX
	2Cz5Z843ubTyMRQ2cZi31DxZR+aSj4cBINCbBcE6M6tUUwYQ8F+YOf3QDnVERN9B6lNhk9da//p
	NezFWX3vtzw4Ss+g2qkbyiB7wd7YeoHQLfm75xqYi09QrDXCL1qSpxVXACTtjaVqKMJvGrWDWPV
	K0+rRVT242igpFOIKOCD/gt3Op53IXd87y/OYcrPb18ij+6lnKSVg4GSyu5tpZ3JsIUgBA+lykM
	O6GeQTRn3l6jG+kNuVztesHRs3SLvsINEOKqAmjp/YDCZ2ebKDGp/HFvcYE6YD1kZS/W1HbeZNb
	xGpC+c/i7XR8L4UT+CQPvWMmHveMhnn5pvAE7RdZNdT9OwtA1L0firoJoJE4L7sctlcHrvVeeAv
	tQmE5guTA==
X-Received: by 2002:a05:6512:61c9:20b0:59d:e5ab:49af with SMTP id 2adb3069b0e04-59de5ab49efmr1350135e87.30.1769244636441;
        Sat, 24 Jan 2026 00:50:36 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de491fd0bsm1254445e87.74.2026.01.24.00.50.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Jan 2026 00:50:35 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for multiple branch comparisons
Date: Sat, 24 Jan 2026 09:50:34 +0100
Message-ID: <20260124085034.8730-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122230656.GA2125611@coredump.intra.peff.net>
References: <20260122230656.GA2125611@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I can apply the changes from these three messages, but I don't really
know the side-effects of it. Should I do it and submit a patch?

I noticed that it still won't work with tags (although it starts working
with 'origin' which then defaults to origin/HEAD). I can imagine we need a
few more tests on top of that.


Harald
