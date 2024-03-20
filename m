Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EAD86254
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972321; cv=none; b=NNuCOxFSbmoZPp9Qo0yn62PmrE4PZzRr+CLH9h148RFDFVb5Zz2Ec9hwhAVmLqjXcRTeGikTYTu66b+nlSi4DcfO9Je7KAn3QYtCdks4NltPLYTkIHhfz2pj4HVHMDFOUX9ukxeqhadcyX8F+8/eRqzAfWXWKq1SJ6PbpAWWq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972321; c=relaxed/simple;
	bh=UGQhRTNH8wyA/+xrPiYdgBrCrsGpM/PiIXYqNTW1j/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQq1nSCujH+oPqQcaBGZmBYUpRD7wxtsOWYhxI5GnDF6zUKdJHvrExVePCx8B8ipbc7IGdy2adcjrBP+L+PJ3khFDuxd/AW9EUW7VdFcirgxsihnbNuLXa+rd9V64BG9XlbNWH/cCeo14//db1IAhK1fMZy92yFErySc+8XeMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jXnyKzKu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jXnyKzKu"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789e4a4d3a5so23311985a.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972318; x=1711577118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PvGvme5CaClZ6b5U8qhZpTMjLwlyclTgikKQP5cqWQ=;
        b=jXnyKzKuOyULDm+x1a4lHu7SAB4DqzA+ybmwQMpe7kUiHu32mvvkRT8LimJnL46Hy6
         cCemwHNJhpnPXhOaudzWiDI/Ysg0xu02OSOzkaEZkEAjiUrCavIPIHRY8ocN5ylpa4NB
         Nl1oM+wQi2D6yMGYY42cWvVmUY8iy387nP08zeF4fZjXPd9aYbuD1VNV5iSN2ado3X1i
         BR1vqDkyP5HVclfTtAQXS6WUX8tfpGvQie82/fAd1VNDyc+j59BDkQ1hSTgY2BepMJ5u
         KS/o/Qln+K65n4rFSd0p+d9U1Hc9B3HfkTcUWzLOIIslRf7rF1DFaIUWVt4F86n9SNRy
         lmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972318; x=1711577118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PvGvme5CaClZ6b5U8qhZpTMjLwlyclTgikKQP5cqWQ=;
        b=JBZFjkN7Pp5L4SnIpXdZeMoGvOhaN/2s4YPSRURjdn+0lh7ldhElp7jrTnRykeiPq2
         FF1rVs8ZcT0i2ldt7M9GnQRZVJBVLMY8plN8TGdCzk0KsQLFeASMv7OOpTjgqOY41mDt
         Y8wZho1o/Rz+dxtu6r1NgHhVXzKHOSZhybwYHYepp0yyWIcfZmNNPMgj8vBIgfJL6Eel
         JBdtkaYtTZVOz3KS8VtG2EHXjeVr3t+9Jbb/npQ+B6mFMSDRF0kw2jkS2BXD8jZzZSAm
         0PKbSbCa9fR1XNIHmeRWEOf4DCvnDQcdTW5fPB7gSt/OxCYeZVqEwXMpW3KwN8/BjF7r
         q4wA==
X-Gm-Message-State: AOJu0Yzf7TgfhuxVKh807J5CPtO9Ev4ADf67XYwaHyJlBFKB5y2uQjHu
	qXhaTtwEUO1T8JltEJynvFhTD2OAKDRsp+aAgmfykh4noSgsis5zHNRAe49/bKJlhAHFngWh1C/
	UD1M=
X-Google-Smtp-Source: AGHT+IG4LtlIdwfOXQj1OqJ3hfdyDe/GXNU48r5oz5To5t1iLfG2DLnBbrpr2oLcIrbl2VYy3XtPLg==
X-Received: by 2002:a05:620a:4053:b0:78a:76b:a90f with SMTP id i19-20020a05620a405300b0078a076ba90fmr4229629qko.33.1710972318331;
        Wed, 20 Mar 2024 15:05:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k13-20020ae9f10d000000b0078a0dda6d35sm2443978qkg.107.2024.03.20.15.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:18 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/24] pseudo-merge.ch: initial commit
Message-ID: <c6f9170af0fad0f2b0c2062f43b211b12a362642.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Add a new (empty) header file to contain the implementation for
selecting, reading, and applying pseudo-merge bitmaps.

For now this header and its corresponding implementation are left
empty, but they will evolve over the course of subsequent commit(s).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile       | 1 +
 pseudo-merge.c | 2 ++
 pseudo-merge.h | 6 ++++++
 3 files changed, 9 insertions(+)
 create mode 100644 pseudo-merge.c
 create mode 100644 pseudo-merge.h

diff --git a/Makefile b/Makefile
index 4e255c81f22..fd050bd9d68 100644
--- a/Makefile
+++ b/Makefile
@@ -1114,6 +1114,7 @@ LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
 LIB_OBJS += protocol-caps.o
 LIB_OBJS += prune-packed.o
+LIB_OBJS += pseudo-merge.o
 LIB_OBJS += quote.o
 LIB_OBJS += range-diff.o
 LIB_OBJS += reachable.o
diff --git a/pseudo-merge.c b/pseudo-merge.c
new file mode 100644
index 00000000000..37e037ba272
--- /dev/null
+++ b/pseudo-merge.c
@@ -0,0 +1,2 @@
+#include "git-compat-util.h"
+#include "pseudo-merge.h"
diff --git a/pseudo-merge.h b/pseudo-merge.h
new file mode 100644
index 00000000000..cab8ff6960a
--- /dev/null
+++ b/pseudo-merge.h
@@ -0,0 +1,6 @@
+#ifndef PSEUDO_MERGE_H
+#define PSEUDO_MERGE_H
+
+#include "git-compat-util.h"
+
+#endif
-- 
2.44.0.303.g1dc5e5b124c

