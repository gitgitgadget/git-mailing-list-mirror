Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38335AC18
	for <git@vger.kernel.org>; Fri,  1 May 2026 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662289; cv=none; b=jC9CR/yYBCfmXckCHdbBOLhwYAhLLNPL5a8rc1sxS2uY881cABD9cmIUm/5IX8qA9uCV1naUgHYmlj63AFE0pYvJwTxzlZ3bHrPcwQZWIUyoEI90UMH+SpPVt0JbEklEeXdLTUUjEtuEYMQ5VoHYQmD0ZuxlNI2RrnvhGDegx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662289; c=relaxed/simple;
	bh=Eqc54+/zLHrHDJ8IP6Jxx4ocprMA4kKKjqvYWEx8zfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuq9T5UCI0siPrkG9Hr9rrD60FVQo5KzxN4svwRc+L7yx9DGqshBp81G1zxU8KND/h4FHxj4wn2njlWKcTIQ9BqQkyHNEPeR4bG2zGO3ERwfAt8x+aWF7aj/+ZDqsLKwDZmINNndIzqRLCDOpbRPDZcbyMugUKggZdQPngdsNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AafWMUsp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AafWMUsp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso25042185e9.3
        for <git@vger.kernel.org>; Fri, 01 May 2026 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777662285; x=1778267085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfbAVT1/FHVbCtg4dcZdIi5pys8sW5oeYnSHmfpnxY8=;
        b=AafWMUspP1X/EJwbXznfLSpCh8iZofBYmflDdb0gC1d3DNjc2txVj+3gsxgY9B/UzP
         aoRnFfSHgFSuGQcn/tHdu+InoeDPzZCz4kOJ9n6s4MFGTjLRHdkaUBoDh6hEKRQ1jmsi
         eozTFUHTf4L3m/7yLblzm/9QnPhuxVRDCxjBcKD96Zyt/AFoP37jS3c9fD9hETopAJp2
         zyvGEmFjMzFVVUa6YzqjQ8b57OpCsBZOkenLc+q/D0Yk8grToxwSAE6SLViCRUae+JgD
         9/SltQxbtYMFvsOLcTZJkppZ333tiqFgyVJdA5lsiJwC/COpd4k8WRqD9j1B3kVgRL89
         3y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662285; x=1778267085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfbAVT1/FHVbCtg4dcZdIi5pys8sW5oeYnSHmfpnxY8=;
        b=RTTphXJZH1HZbqIMjLrUggL4qtiUqs1i4LyMilZxUqxuUStGtgo4GEq/wWmyZCcwtI
         ue8DaOevDGFUh4sT8PP/9fPu43fHWtfD79egeOYE9nukX8aQbyc6RJAseB00euj9jV+f
         TnsUuUiiypwtDSQAIUMM43cuWtSbV+PYXiFGxFS0ZE9EaRCefhSxNbmNrW9WUvIxZH9m
         R0Ky1n90y0+l9xJtwdwMNbVNHkela0liiJ9rR5TcfxV+b//XO9DKJFZ3dGLl55BaBsnK
         29D4gB5kSNT42Eq24swkc/rXQfYswdNKiSbMFCP66NK6mjjPoBWR3ucWNJhIHr+Up7Av
         4YTw==
X-Gm-Message-State: AOJu0Yy0qhRJHvCD6GV0CXCKxuTNHssxQxogXwQvOkgnnfhn750MP7ON
	HCFdxYQPxZULclbN8koh12miCDKZQESjgGtz8A1VTwoG7560W6FrC5WiCIvujWetaCrSrBlYAWI
	=
X-Gm-Gg: AeBDietWJZOYqF7MR5t/hIXTtomv/aF/pQVymAM6aAqxmePEuYQXdDCCjfGwgUlTZXG
	XgGF+WXjFGXyUTSl5ykp02QH6NKdMHPe6QhAk3x3JS0VZBtNiKbaIa5IQCfdtsTedY6ezbLdRlv
	sQAYtAydwiLj4wXDw7YjtSg87mAiNUCObQu2M141m55/e40kElLfkXYxZhBefW5uGhN8qaEn3EH
	abqm2FmwcCohanuHwZj51mIkBZ4zi+5oWZ6uwi4hcx5BprYkLWfHPEPUCShNFo9bmxu4vQ1aG+O
	WshHJkuSc/SwdJ1UqX8SVhzCBGS3JwFN2tOBGpdHuu6I1KaiZE+2dKruOrCbmAC3AP0ekVxgkM1
	RGGtUOJx8ixPlAQqA0NWLGrNA/07uGJMrGEGA9vgY32/Tcm4+tdk3hnNpeIMBx88ONtCjlecqvC
	ttPCIokZbi/kCH4LeEXXfEy6XIN7W5stcxN9icr7VnZu08n+1+fx2vthWM5Q==
X-Received: by 2002:a05:6000:2f83:b0:43b:8f4e:27f8 with SMTP id ffacd0b85a97d-44bb4817dc1mr998038f8f.12.1777662285283;
        Fri, 01 May 2026 12:04:45 -0700 (PDT)
Received: from localhost.localdomain ([85.121.183.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cfd2sm6475075f8f.2.2026.05.01.12.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 12:04:44 -0700 (PDT)
From: aminnimaj@gmail.com
To: git@vger.kernel.org
Cc: peff@peff.net,
	ryan.hendrickson@alum.mit.edu,
	Aliwoto <aminnimaj@gmail.com>
Subject: [PATCH 0/1] http: reject unsupported proxy URL schemes
Date: Fri,  1 May 2026 19:04:00 +0000
Message-ID: <20260501190401.1580-1-aminnimaj@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aliwoto <aminnimaj@gmail.com>

An explicit proxy URL with an unsupported scheme such as
htpp://127.0.0.1 is currently accepted and treated as an HTTP proxy.

This happens because Git parses the URL, extracts the host part, and
passes only that host to libcurl without rejecting the unsupported
scheme. As a result, the typo is silently accepted.

This patch rejects explicit unsupported proxy schemes while keeping the
existing host:port-without-scheme behavior unchanged, and adds a
regression test for the unsupported-scheme case.

Aliwoto (1):
  http: reject unsupported proxy URL schemes

 http.c                | 79 +++++++++++++++++++++++++++++--------------
 t/t5564-http-proxy.sh |  5 +++
 2 files changed, 59 insertions(+), 25 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.49.0.windows.1

