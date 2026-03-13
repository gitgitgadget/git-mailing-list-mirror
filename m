Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A23CD8DE
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430404; cv=none; b=asR2fpB2XUifQHWWaqGrkTCiUQ2Owcmqez8T3E5n5Tlnijc5Dzdad4b72VB+0bxGE9H5OZx3i1gy1GWADaYaDoH1AQmFqO4dVc3QJiA1yrusWpS6K8ryx1zMycm99QZ56PklcZkIsmtLG66b5GXLvL6kfZ9NC5cxT6HFu6WO0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430404; c=relaxed/simple;
	bh=RVS3hFEUT6clvjYkP4wOwkkSCSFYuJU7azuqVZQ+wJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OC+NXDrZP8WfMeghvX6kWFdPzk2OL4qVg7RjNE5yY4vFp6esnDhKmc2o0A2tTqX5X7lNV70JuIuPk7Qc5aaGQvAC4iTwcrdozgfh++9MHQY6LyYZs4WDxlEf8JPM592vVK6U4BPJotZ3ns/K+xdFOr/Fnx6g0Gle59qvYl86bm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL/6j3D2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL/6j3D2"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a2f92fab4so23184861fa.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773430401; x=1774035201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/Y79CtS47szoamjCqK+e+yGIbP1aNpfio17xa4mLZQ=;
        b=BL/6j3D2VTOjZg9VjpiEWpt3UDB5rmEIRUygJSZNOS39sH0/Z5NBzU/rCDIdpa5xHu
         x/dbKNQNq4BmFpn83aTZVAPaVbN43hLN4MC0ULKvlZfC5y+SYL7YTtd0bv4zqdx8Mzo/
         BbUtTBxIHSe6jYE2DwtN3fG9haGKDxHsP+riBlq7mKf9DfzSZVLD6OreQelfTzWdbkox
         OTd/bvmVFsSWFbSvHiYwnvmoBw54jUkitPzWWYZYIml5iibp3gI/R7jgAKLqnHsGgZUQ
         vmEuUEjJmpXpwqOE6YNerUAiVMKm5MQ7/HRt/hez7ccof0BqeZPxvxQO7OOues/iuy0a
         6Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430401; x=1774035201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/Y79CtS47szoamjCqK+e+yGIbP1aNpfio17xa4mLZQ=;
        b=W5NWiYEUlafqWCv5TcQknLSivjPNap3KtBYYBA0cLsg0n7AuIC5VQ9WmfHSQO5tGEK
         VkJ7KLJPsoEFPAAt372uMBRcLLi1f4PkkQVy4mW+vixxzFGdPMdkOBuzt27tlZRabyuC
         rN/AV5oYZnmZRljZOuXWSVdFtxhWEbIePcfSg20bfMUoSbLOBF0Q9+ojR5pdN5f4mHv7
         fQeKy1wAo/n60DyIVJXPQBC/FJbJd1IW8WKc1KAyYFSqr96o+cmEZ7MafnGy8HZ+BJhu
         0pDLdbRFqOMsgC2icXo5Fg8O4fraIpIjN1ma5/doI4R2SlHEatJeny4az2ELCLqWH+WJ
         RCAQ==
X-Gm-Message-State: AOJu0YwLMBdzHBdF9LWo6DRwT9MtOnmuOg3nLf4Z3vPctwkfkbekc/sC
	2RtpVaGofQWXmPiP9ZL/ucN/5gwuTcuMcvTMQofBxdkxDnkNjpfe7e9SzQqb1A==
X-Gm-Gg: ATEYQzxww4oTYM+ChtcG6BnKBi5z7/yrYutAoyAkIs0CRvsfvKBfrnefoU4pvv4UUT/
	aPDy9cnWR1E5Y5uSoy267ylXNrT4GqkzE/WwACs/eZnnqa1R7hoRFINI+0Q0mUc18nXiDdYviKH
	OJQMjXqdvpflsklK1qZrgMZNHFnZSf8u2QO4qCT5CiK3ahw4LSp/4x720heE2+CobTqf6eRNnY0
	IcRoiYoSSsFMsCkXGs9u6Nt3pu1pwdZP7dgcuYdltT8+d/UdyMIXXCDnE7yhFIGqx6XGbAxpbVe
	11Nb7dYbbTJ28L/Kpf/AanPnom2ePTwCxNtSNFrQC0/q/x48QeXDwiknC3zS72JRHBhSBvckixf
	1AOgfVhnu6AwIzpE23Ew2tYrr+egrUuFP8TFJjk03RhHEQw1fDxGWFVYEHJ+eOnyqcORUW1U0gk
	HAzW43DcsIE75dZ7oQJIH+Ob/Tdc2MyIq6NkqeCGoAphIEcBW8M83QmQhFxSSZvGxv/9iWiy+Pw
	sTvOLwjLfkGeO0o
X-Received: by 2002:a05:651c:20db:20b0:38a:7a70:8702 with SMTP id 38308e7fff4ca-38a896994e4mr11395901fa.11.1773430401257;
        Fri, 13 Mar 2026 12:33:21 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a8c8979d8sm5317681fa.40.2026.03.13.12.33.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Mar 2026 12:33:20 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Fri, 13 Mar 2026 20:33:20 +0100
Message-ID: <20260313193320.42832-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqv7ez6455.fsf@gitster.g>
References: <xmqqv7ez6455.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Almost all of the above is now stale, as we no longer call this the
> "autostash" feature.  It turned into a project to vastly improve the
> "checkout --merge" option, so the proposed log message needs to be
> revamped to match.

My feeling is that this feature will drift far away from what I initially
needed. I have never used 'checkout -m' but stash->checkout-unstash is a
pattern I use a lot.

I wonder with how complicated this might turn out, if it would be better to
have this as a separate feature called autostash (mirroring the same
feature from git pull rebase which I have enabled).

Harald
