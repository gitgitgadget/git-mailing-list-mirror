Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01578156F55
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248834; cv=none; b=hyaX8COC2jn+x8mjxxa31Wnc6s1OLJU7cZcFM5I7O/wohIIP+4/98OzSn6kjOKD4rG3YsQityw0C8woFwr7upYTmi7P7GHbNDXEHPVBxFkMeh3k6ySJ5OWe6MDohNYFl7xtoB7qpsW9M3Ew9571E4iU2teJd8/AzZcDIeyCYqjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248834; c=relaxed/simple;
	bh=bNu9lhzb6G7Qu12VOkDGbqqnTA0v6eFMvUYuqn8+d4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3D77z7+jJ5o3YzfLlTNckzI+ZHFcB7B+JbjB4ouXx9JT3NmfvmkI0JgSBhpgVcA4ykRRVQ8iIGRWnYg2ho1/Cqmmy+G4RnejZ8GnEgNuLMtGsiN5LE2xBTjyYiDj2Eug6CEM1a0oLh79bUTOiaNqMKRg7igTOG1JcvWY3FvRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eodrPJmZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eodrPJmZ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71b00a97734so1353799b3a.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 00:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727248831; x=1727853631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUyHtmRLlUF/eIsowMlqpWdbrBGtpAvFH838V1EwH2g=;
        b=eodrPJmZRLniG1FKrNHOp0XB2l9Kfm+ZqAS3JsiyWFUmDdO7CzoBTiuq0uljhIaZpt
         KPBZ3M+HAj/jEA5Gc6R9+hwcWV27xyoBds/5BjVorZgvk3ICB4+vDkanYlZsNShAaw5y
         P7bUiXob2QiiYvz9fCmgOgDPEeBtkFmA47HU/7di1hUTzvgKgADc1QEM2M6pAJEwN+Qh
         sTux/wSIPHoOV7tSg0MgwN8MO9mdqYsmKZfJHTmlBkdMI8rtvY02oRvqeyFDqNaxNftd
         cNNR0i86sIgjPjgGwusHVm3CvK3TFBb8k9A+Fo6DjQSeiNhe/84y9EvdmgysMLzXIsXR
         V85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727248831; x=1727853631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUyHtmRLlUF/eIsowMlqpWdbrBGtpAvFH838V1EwH2g=;
        b=e706xqAAofZx63bZ6mW8AsqZ4GE7hwBsAwPMAAZDEx2SC5iBDFoaKtHjzggfO/Fya0
         aCnR9pyIOKbmWrofR1OoiFo6G6a7RDwgVD/lqhlru8jcPx1PbLOv/VOG1fBFJqX5QBa+
         y6auR8f3ZJmBRoPsCsIosfIF5OCT8bxBC4yaRzHILBvk7fMFq3D6Mh5EF2qrq61ZWWNb
         LEy6rdgxKip2ZezMl7CCUEQoOAHyLxNh3S4Vuf2i+nxv2wWYTSnvbVdMobY53H1afYdU
         XhOMnrrk3hNEoBmRx2w8xO91sSvE2WMPnznfBeG22db3DrKLkvqHonflIlv+LgomC643
         EBYw==
X-Gm-Message-State: AOJu0Yz4MtDT1zYP56knbbcQIk5wfjrVLNCCSHjGAABSu/m8lOpYULfh
	amTNohhBtoypAZ4jOPzr2ck8GTCqSJQXM7jRJklkphnBXVcv+AoHqIm78bNcfL4dY5y7bYQ4GcE
	k
X-Google-Smtp-Source: AGHT+IGw/mvHt7/5oGGR4SPEnGzzCJPIetwX+yBGq7Hg5Kjqtc/hAP4HcVHMbdxk3TlFjO7NfIhk9Q==
X-Received: by 2002:a05:6a00:1410:b0:710:4d3a:2d92 with SMTP id d2e1a72fcca58-71b0aa938e6mr3251441b3a.4.1727248830692;
        Wed, 25 Sep 2024 00:20:30 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc938e25sm2185838b3a.131.2024.09.25.00.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 00:20:30 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 0/2] repack: pack everything into promisor packfile in partial repos
Date: Wed, 25 Sep 2024 15:20:19 +0800
Message-ID: <20240925072021.77078-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested by Jonathan[1], there are number of ways to fix this issue.
We have already explored some of them in this thread, and so far none of them
is satisfiable. Calvin and I tried to address the problem from fetch-pack side
and rev-list side. But the fix either consumes too much CPU power or results
in inefficient bandwidth use.

So let's attack the problem from repack side. The goal is to prevent repack
from discarding local objects, previously it is done by carefully
separating promisor objects and normal objects in rev-list.
The implementation is flawed and no solution have been found so far.
Instead, we can get ride of rev-list and just pack everything into promisor
files. This way, no objects would be lost.

By using 'repack everything', repacking requires less work and we are not
using more bandwidth. The only downside is normal objects packing does not
benefiting from the history and path based delta calculation. Majority of
objects in a partial repo is promisor objects, so the impact of worse normal
objects repacking is negligible.

[1] https://lore.kernel.org/git/20240813004508.2768102-1-jonathantanmy@google.com/

Han Young (2):
  repack: pack everything into promisor packfile in partial repos
  t0410: adapt tests to repack changes

 builtin/repack.c         | 258 ++++++++++++++++++++++-----------------
 t/t0410-partial-clone.sh |  68 +----------
 2 files changed, 145 insertions(+), 181 deletions(-)

-- 
2.46.0

