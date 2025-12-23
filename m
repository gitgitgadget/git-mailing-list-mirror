Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB73B2AA
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489768; cv=none; b=KJvMT+TYmUfEFNQwGMJGxIj5JlJPORrt3V4vs0N1uGjscX2w51JDrlFVaVfD+3gNRwDmvQSTLfvLfG8YxEuWArZJdU9Z0wWV/EwYvJi8xkhOgLhgf4ULwgphPFHfea/YhKwOIEMfb49fkYRbIfB6UKJkgMBD9ScWEA5dIEeFoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489768; c=relaxed/simple;
	bh=NZUNXQs7OXJmFMuHC0PDsIP68EyHryjo81szKJDI2aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9F72QvfxSuf73FzoS8+tXk/CmooEGno3KGu5khTvXQzs9h8bwLxJjxOFymf5QGIPsebgP1ZpRWGml3PDPr8FzlT54JE1Uhi8l39W0WzADw7Utqug2TsGcQ9A8lTEpV4u/GBPf8xPMcI8xhUywdzOsTjmQQ3tBERJuwBWE96Sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bm+13dUA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm+13dUA"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37b983fbd45so37840581fa.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766489764; x=1767094564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hTbLdyHz7ea/mk7bgO+r8K7akgy3v9J+PTm/OerA+8=;
        b=Bm+13dUAcqn4KUOeIEa0E+PgSVIyzzhoUdVI3YSPSJ85prTpN56wvV74bj5Ben4LkM
         5fwQ5Im7XkOvAvOn6hKwy5JA86UIJmOQbiAo4FlIoiac4B1vhW3Pc/GA80WV1ZXW4jD6
         W0MI0FNqlT+OahkyT5evav6DtsHGLpXd3Id0pBzWknEknvKL5vbCpqpJzCmPNH6NO0u9
         36bAe7/70BfoYkbN2R3R4oSWnca1Erd92fni1q8flt8Mw6sss01R9hCCAzXcinRDvWQf
         ikVdIUpnq8NMYOyV1tHqcgI1md0dZD9z26u2naMsWyXxJXJ+pe/yZW9Nck28gMH8NkHy
         757A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766489764; x=1767094564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4hTbLdyHz7ea/mk7bgO+r8K7akgy3v9J+PTm/OerA+8=;
        b=RYlIyq14EPaQyYBNeMqz9QLvBCVLeRGeZAi6rD5viNMoskxy5R8B3ez3vc6ZmgR339
         dvbfN/XfFPwtbWcqCRtHIzPWv4HKkGpLS8qfo0Z3VKDj8TnNcRySBSTlIDREr+D3CA6Y
         jKLP/Mc4DqiVouOMYjyv6vP3ErF3eJhwJw0kKXy2ulu8zcG/tpBbwELEdbn8kV6dngZ0
         fk+bKEF8P+7QMb0+c/VOVwtALMxjuvPYN6QV+6zgcB+ZESPCo/p607aqBH3a3CIiZzTv
         aT9zJIPah2v/I5qO7g+Zm8zk30GIuVwKrwL68ZwnnEl72tUVfv6ZX49li0CYBuErf8yA
         +Nig==
X-Gm-Message-State: AOJu0YzbqjpxNfD2tF5vTLPe5RPmFuCTNmViW3ioBDY6pBYRBAzf1Bl0
	3XWBBDQ6mw7vzn32d3o6aZVTh8GIWT5AnYXeEOVEAWZtd8596geD6Tx8
X-Gm-Gg: AY/fxX67FNVxPm8eRJejE6N0gYu3vkfx8q83Jl3BKdsJIzUzyz8swYQtZ0gdK6C9Hkr
	6wG6N3h516i4jQv0ws4lekPQHZyJv2Cmk7NyynuQzAJEpWQSWVCFCuIBOCWpu6iS7pA8lvPcTCJ
	iYPCTuHMcn1gv9vNb7dpEsBbrVjEVrEZxllNtb+r6b+pYaQ90el1D71ITpR5s7vVqVqlPddX0AA
	EOPggcyqGvW4UfE9SEHJvYsyjN3coO1SbT04RALD18EfnjmQVVPcqjGyxbU+85Snqbdyf80wGZ2
	vmA3pAF6sWexw81CnTcG394QsCdAbMnvugZhtaW1ed8C888NzidUCjjhO/S/zartTsyekE6oNN+
	hjDFpk55zgH8/zM5b8NqtgGFmjSyoRmmd9HERL3oZJngC7lyKYunPotjNbyZjyABxHWctBIeUTn
	+sLMVp4JSAiFwmtzo5i4pf5nNkY2Oerks/ZcQjVOgBuqbcD98WfV3Depzos9ZJR1II0mKLglp/K
	/fbLvMrrA==
X-Google-Smtp-Source: AGHT+IFVCLPgnEKi7jwGrag2CzXAlBEdvLAzymGlKczKpfy0AHzTD3CPk0iqo0QmdRBUxNmIbBN1mQ==
X-Received: by 2002:a05:651c:549:b0:37b:9b58:dcfb with SMTP id 38308e7fff4ca-38121568e47mr49479511fa.7.1766489763685;
        Tue, 23 Dec 2025 03:36:03 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812250098bsm33205221fa.12.2025.12.23.03.36.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 03:36:03 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Tue, 23 Dec 2025 12:36:02 +0100
Message-Id: <20251223113602.63000-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251223102422.36853-1-haraldnordgren@gmail.com>
References: <20251223102422.36853-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Adding another comment to my own thread to reply to Junio C Hamano)

> branch.<name>.merge + branch.<name>.remote
> that defines where you pull from is one thing to compare with.  To
> learn the other, the destination of a push of this branch, would
> involve poking at remote.pushdefault, branch.<name>.pushRemote,
> branch.<name>.remote to find out which remote repository it goes,
> and then remote.<remote>.push to find out where this branch goes,
> but the helper functions to learn all that are already available.

When a new branch is created it has no push settings:

	git checkout -b ahead_of_main_status__tmp2

	git push
	fatal: The current branch ahead_of_main_status__tmp2 has no upstream branch.
	To push the current branch and set the remote as upstream, use

    	git push --set-upstream origin ahead_of_main_status__tmp2

	To have this happen automatically for branches without a tracking
	upstream, see 'push.autoSetupRemote' in 'git help config'.

Once the users runs that suggested command

	git push --set-upstream origin ahead_of_main_status__tmp2

then the 'branch.<name>.merge' and 'branch.<name>.remote' no longer hold the reference to "upstream/HEAD".

For sure, it would be great to re-use previous logic for this, but can it really be done without new logic?

Harald
