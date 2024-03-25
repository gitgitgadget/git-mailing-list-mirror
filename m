Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C5481BA
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387462; cv=none; b=qHX4jD5pA5hnVZg2vMlN5qXiRyzWPPlPQwpAcvaGouUtQikV248rkXsE/3tr+ELlBponHbSTlAvLwUJhoMRSxQWE1jWe/rGvNF/BunUydzQ7DGWKUbUw7PFQ4yOY9exhVuJgcVnTWYziKVMr3VrJw3k2H/lHn/s2HE4f+hwkIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387462; c=relaxed/simple;
	bh=Ot9Ew/5Q/UZqDmV5nnRZZZ4ZYKh3wbtWT9k0x79C2Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2IAEB/XWo8QunOkqbHe/k5x8Qd51hUTmEjZutuLlC10XxSbYE8jv62nhlA7KKqb51G5K0XV83ho7qK1q5KvPOXB2Wj9Gtn1Cybjfb37S1fNjo7pvGfSFZ+TOnqBj0S7bTyY6R8si8PNPk+cvKJaa8AiFCMcpbA1wN4JATgGuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=onXq8CLq; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="onXq8CLq"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609f4155b76so49877897b3.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387460; x=1711992260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ceu0s3e5idqiOpZEvwwRPlDJBJ5d/i4tq+E8njG6zg=;
        b=onXq8CLqgPb61QQAA6oiZNFkzQKQgx2YSa88yDhFEUJKnCTWFow/x+2yYc3S93L9Ee
         w+MpoExKcQv2ZOx6Vwr/mtJXNuc+Jct0nPPY+tFbQT0fouvaDcT7XBHkXkWGFibIEwxs
         Za8p1iZnTIv/Avz7Zh/I3DI7kRv/tyK+n4V5hRx2CLUDj9/lOFVKRzlwb+c9rNXAGq/c
         AHbR3a6qgyFBRxkIQOeJyhz6FBRfWRBS4MWvPzVOEzI7pxSdGEYglaFjfs94DETZXFoH
         GyZT2w4Pf1AqUU+vDO1jJcNDf+yDedlxnVWmvAlXcuDA/YebRiVlPPhUeAVwoLeCTkTb
         dqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387460; x=1711992260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ceu0s3e5idqiOpZEvwwRPlDJBJ5d/i4tq+E8njG6zg=;
        b=sEKQITCm/wAk6wYOzC3LooP6ijxHBlU+9YbDSn+EC9BT+DHKDHAL9j9iAthQA4tAWy
         7+cfnBdA0sX6/EH4U2FS9CPWzoWIfWMuI3bGe2OZ7OEmRhzYaMesQE4NxWvnQ4N2/Vsl
         FMlRS/hVHmq4VAW5h72IvYpngk8yhq/rzT8MmEX3z9fgrVqFOfQ5LdbSbXvdmm9vlXLp
         9MwKwKcFp4TgQ9hRTX/9NDUBnQOMcWVbSHF80KNE3HfY+fnogbH4ZdfAlx0L/CbUar4K
         ewmfGXHWI0XRvBTxyJv0XxliDKMUR5+cpXn587wzvvMrVie9sxyXqfyeDq/RfhOHKRKq
         av2Q==
X-Gm-Message-State: AOJu0YwjfqHXZhs0awBiUH8memKtkPglvQtWKb1tY3BcjZ7QdIKLBFal
	czGJH6hFC1bkPj+rJzs3YTJya4Lmit7xPNnDG1ZMZmTwuWN+dXjSHnGZsq0NOoM8DHMrtR56aW4
	5wM8=
X-Google-Smtp-Source: AGHT+IFxy+4WB97y6mgESRJonHSXdKVZRrrkqZV6nrX/ODftAKf2O+JMdt9V6Rl1VJ1Mbex59DTvCQ==
X-Received: by 2002:a81:a096:0:b0:611:2207:efb with SMTP id x144-20020a81a096000000b0061122070efbmr6987438ywg.34.1711387460135;
        Mon, 25 Mar 2024 10:24:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05620a179300b00789db88792fsm2275237qkb.90.2024.03.25.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:19 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/11] midx-write: initial commit
Message-ID: <ffa8ba18de8be68eb8dbb1e17b5bf8800f564505.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

Introduce a new empty midx-write.c source file. Similar to the
relationship between "pack-bitmap.c" and "pack-bitmap-write.c", this
source file will hold code that is specific to writing MIDX files as
opposed to reading them (the latter will remain in midx.c).

This is a preparatory step which will reduce the overall size of midx.c
and make it easier to read as we prepare for future changes to that file
(outside the immediate scope of this series).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile     | 1 +
 midx-write.c | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 midx-write.c

diff --git a/Makefile b/Makefile
index 4e255c81f2..cf44a964c0 100644
--- a/Makefile
+++ b/Makefile
@@ -1072,6 +1072,7 @@ LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += merge.o
 LIB_OBJS += midx.o
+LIB_OBJS += midx-write.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/noop.o
diff --git a/midx-write.c b/midx-write.c
new file mode 100644
index 0000000000..214179d308
--- /dev/null
+++ b/midx-write.c
@@ -0,0 +1,2 @@
+#include "git-compat-util.h"
+#include "midx.h"
-- 
2.44.0.290.g736be63234b

