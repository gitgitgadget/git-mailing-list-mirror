Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BE61B0439
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949270; cv=none; b=TDIK4zJxopzHAjMxM15jXk5oeoi2DrjhGrRT/bqdRf+a6jeLFUJl3f6eL/zhDfpulf6wcuDHykAbUPFPcVdb82j55if56l839cuhwjNM86uMzhzEAANHIi9ppJXtJv1WSheoXLVnZuPxHNayaoOv4sflArGxE5giukHI+PrI9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949270; c=relaxed/simple;
	bh=clV/xLivFFHmGVfWa3pGth3uj5/+1eULhXIj33FEyPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GU/DjLR8W/OguOj5sBp4kXroJrnB3Mm0D9Ehlmhx9tVE/gfqH4i8wF65aEMt/UKX6EghsZXgd9FFZAIx1B34yaJxgvOCbfNrv5/c5AL6oDACX1lxS5U50Rg6ZK1Hw/e0fHTU8XGzvpLMLrO3816Blp77YkRbeDiFd95398PXe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPSyJikI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPSyJikI"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so729877a91.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753949268; x=1754554068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcROHi6VP16mEvKZkcsPRCxJOUClBrVKyg5hqfmquas=;
        b=jPSyJikIsgZYV4a8Q1yp6X1E7piifXwl9G2TT0sYgWMf8gnFMXhM/wcmmJdrhM3Hnu
         3GLLSUG7kDyVkOexq+FxKyJLqLjGG3KXem6AbJSwcTNSTFdSHKGptfspuRjB45nCmMCD
         GZJGFZb3fRiMH9G9tR+kUGKclKanRTFmBe5xq1rVP9gGvx6VXRimp+a2VwqPhy2TxyJk
         b+PgEFYMmNpKnLq2LXlq8tUk8MWHnH2VbYE+QInCnIJcfoJKnZLggxrvp41x606MFdAf
         OiD0DJt5FERUHzTQQ4okOOKHn04K4pK8cEQa0XON4rFhiPJPkeJ5P1MXUEPZZpuJVu1D
         kskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949268; x=1754554068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcROHi6VP16mEvKZkcsPRCxJOUClBrVKyg5hqfmquas=;
        b=b0LL/Gii0XhRVtCW0HRBmYwrnzNDFLJMHX/0dmr8VH1BIeA4bXRxzDeMWXNUgvOZp6
         GWBt6xLCQX1hnRLhtb2hFNtWGNPXlQwVzGBEPlL65zLWOvQy2UWzzEibf8wuvme0+yDk
         JPMv4hF3AUIxzLwrxCBwq1wvGkpNBUmlxnommmxC4qs0Cx+p/UNJ4jshaJS5gTWvXrKt
         W3QJPRpty+58hWBCghwdVGXHFW0g/yERC+xO25zmk8Zu/bLrUKg6k4nAphWy+3aA4ixj
         hF/Gcu2csRICOECj6pPpWdGism/hXFseiT5CAtcY3PHPGaGJapjPMIsK/ZVapxhgwCFQ
         tKcQ==
X-Gm-Message-State: AOJu0YzON6Pf07MNOdfF5wKYNFkXRztY87ZbNLBlgwiKdUp2Rji7J7+U
	DmY6C1KMGqkjH/+BuXO6PJCfD6jNQYpV0qdAhJhOaYiP8FFug6iFqQLOfVBz7g==
X-Gm-Gg: ASbGnctKHjA8vpvzJ5ANwQvBbnD1VXYVjE4xLfWR+yxUgYnu6Hk6YqIjwipu5rdnENd
	LkdAL3GEWZihJZeU2PBqvBF+1a7MHsjfb1JFSwoUQCNUUrT6aH6YnF7nVng1uNyKWdsFkMqIQ1J
	NrOeCNezm9yqnWHxsl/lz8Hha685e9ZVVtO2oDCJPLZdhTqGmUUDeRlVR12iIQrajq0+3iKsbts
	S/LemQ1OVibgEyogc4qGrR+oakgNkXlAGRyZ+UkEjQY+LyYRu5TsnTPmQacQH+ttisrlqaK3Opn
	z11BHeZz0g+7VIuy4SDuoWJflnHAuadT+AWmeLTcanrcinaRqhSLC9uJjCposlrckaUvj0L/yLh
	yYXDZl49mBrHhmnnTj8cfeI/lQpj9ckWdgtT86CEyIobL5Sw9Ueybm6bRzdfN8sVfVSChHh3o
X-Google-Smtp-Source: AGHT+IHLB1E3rVsp3pgyt61bObdgbRgufA/6rZLyEFSOQRxf6dxnLYh66HDs1+KyRwHxr3BVzWurKA==
X-Received: by 2002:a17:90b:3e86:b0:31e:c630:ec93 with SMTP id 98e67ed59e1d1-31f5de41200mr9721473a91.16.1753949267905;
        Thu, 31 Jul 2025 01:07:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6b69sm1237309a91.2.2025.07.31.01.07.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Jul 2025 01:07:47 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	johannes.schindelin@gmx.de,
	mlevedahl@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v2 1/5] git-gui: remove uname_O in Makefile
Date: Thu, 31 Jul 2025 01:06:24 -0700
Message-ID: <20250731080628.27917-2-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.ge15fa7359c
In-Reply-To: <20250731080628.27917-1-carenas@gmail.com>
References: <20250730164052.15371-1-carenas@gmail.com>
 <20250731080628.27917-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Last used in ae49066 (git gui Makefile - remove Cygwin modifications,
2023-06-26), and unused since.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 315888f..a87dc06 100644
--- a/Makefile
+++ b/Makefile
@@ -11,7 +11,6 @@ GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN . $@
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
 uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
 
 SCRIPT_SH = git-gui.sh
-- 
2.50.1.475.ge15fa7359c

