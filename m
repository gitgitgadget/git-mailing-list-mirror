Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85941A78A
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437222; cv=none; b=fMhVXQY2AecSItpU3HFGsucyuwsBL9QWuUPOoMDdHpgz86A6f6oAQZpEnNIDI7f24/Q6xsLG8ubvfF1JBXVk2XoU3N/hzcg5y6RLiUWJO+DP0QU+NBO0BmO58pcbiWi6N+SjmbbaFLdHB6mOnMU2VgVu9NDqrW9B7xiT2xF1TdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437222; c=relaxed/simple;
	bh=0jbptgia/yPfqaWd5oMdIH8liNANmdxhACY9XNF5/Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DR8IjyD70wvZ1HJGtWXQSyT97oi/xRrX5GXYE60nx90R+UIMCyXO+/44aa8GuvckjJhOvauDn2zFxKZL14jJSO67ntFxAt9uZ32jyMFs15zvfiquoGCAUQ3nzhRCCnotH+LYxHXK5kwBAZ6moojIouO/0ntlMz3A21m1Kp+Udd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oqeKh8kq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqeKh8kq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so20532335e9.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437219; x=1787042019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f5FAJqSxl7jk1fnxTlAt2LIp8eLuTMOD/23Hn7mUqqE=;
        b=oqeKh8kqovTA91ZtYkH8u5G0ft3EhHK8JJgawt7jxBCsmzhsVCD+EwLcoc9WDiHSZB
         H1aWN54JFIuEKFZhHC01CYqx5/gbKZMl/C5fcUypshySl4h85e536fPJD7LlB20yJw38
         rTx0StPmH8Vgua+1DvbAKfGukErRXiYbE2UxDxFJXsDvY4zpjtvwZlh9vJa92KkLC19u
         Eezq0TsSWslrcHvOCSa+8zK9aNe/7vptTah8JTf3nBO+LKOkah67X9mADM5shtDdKKqj
         TGF7VBj4uaQJxqJEICcyMm9lgyORxqQdf6tCarO4nOXOgaE3BB2G1pfJD4txrIXFxLO8
         uJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437219; x=1787042019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f5FAJqSxl7jk1fnxTlAt2LIp8eLuTMOD/23Hn7mUqqE=;
        b=ps6P1KfDQikPYGCl5Bf5PZpxa6yIXVdSQ2AQxG5Qd/cY6guqgXzScNtPgslhahAlQb
         5Gp81Xkz/G+U7Hb73nbJZe9DkyGA+35T2GRJ38aNeAyn4YJTHUNo0vchxl2AlD6lPBQ7
         ifq4pcGUhASaLLGXd5U+SJ8AMMRmlELCe9A3vsL1mkY1K4xxHLDO19zFjBjuljdbPVZT
         aEYRi8K9prq2uCH29kzbEbl4oB0gD7MCGTJDIy+ghZ67y2tgshjMOAXDfcPAPbUYyUbA
         3JpSrhsjFWPIjqgTrtYfILbXrwthxuwXvBfqcD8QnxI1UJKKIS6NMj0HGffImNOwKRa9
         Nd5A==
X-Gm-Message-State: AOJu0YyiyvNwS0CbmO594u2EVZKEgcBgyd0yeCZihIv0+6GSHsvHD0+c
	lJHEJ++ft6C/Qxh6BZ1kD+98fK8GYxjJeo0NfXvSYyfdupU/vztxQMa5q2/DmQ==
X-Gm-Gg: AR+sD13s0mpqueOFYeudPp3H3D3XUGTSAsjZwCH7IAKLPcco1DZpphfxtUXXvxaqRi6
	8n+YIBcjvFqDV9zHDOeTVv2PBhxWHpAJ4dTR0JC+HH8o/EH+PmpiViqaJvv9/pw6Mi1+bz499cN
	9qi+RBrVUp5r4OWu9SOA3z8AkEyFq/iJkaIMvfCQIiwI8EMJOzFvPhED3Xp6mvy8T/uMAgfZGMA
	q1KTbdUP2wh8Z0BHMUDhLzdlB0MLivbVYFV228IblQCLlHZ1o+fKCE/RYZJkZuN76kQvR1xo4OQ
	Yxf00umGwBW/7P4y9SdZ6Ju6TcaLAYkrOsj2Bcbdj/QfOHvgO+W9G7RXM/nGQufxM5fzj1L1w4d
	LoekWC4JPJabvBprZtDIM3RfLEHUL4oEveKR6CRxXwUlc9YuFVd11fKBdkamFuOrr2/lP7OXKP2
	zQiR5lrFKXZx6Rx1kzWZsbJl1rAKWmfyIUpD2Fm2oMpnVVwgQLqnOkmRvCxhw8D6o6ssavRHdjO
	BIsLiY7lR82QD2PiLMpDiW24ycAav5GBCjMrMWa+UUZvEAz1XAxOR39tnx5OXJNyk73ohG/xT1A
	xes=
X-Received: by 2002:a05:600c:6288:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-499784605d7mr20310715e9.10.1786437219152;
        Tue, 11 Aug 2026 01:33:39 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:38 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 05/12] fast-import: use int for some bool flags
Date: Tue, 11 Aug 2026 10:33:07 +0200
Message-ID: <20260811083314.2023489-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `show_stats` and `quiet` flags are meant to be parsed and used as
boolean flags.

To easily parse them using OPT_BOOL in a following commit, let's change
their type from 'unsigned int' to just 'int'.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9fc9ebe65a..9c8edd7c89 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -182,8 +182,8 @@ static unsigned long branch_count;
 static unsigned long branch_load_count;
 static int failure;
 static FILE *pack_edges;
-static unsigned int show_stats = 1;
-static unsigned int quiet;
+static int show_stats = 1;
+static int quiet;
 static int global_argc;
 static const char **global_argv;
 static const char *global_prefix;
-- 
2.55.0.530.gdb3615d990.dirty

