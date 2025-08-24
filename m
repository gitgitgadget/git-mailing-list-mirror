Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4922FF37
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756062423; cv=none; b=re3R/RSYslk+lUxPU+HeuCoQvv7E3+0r71qosJf16VT8w0ovQRgofASXno3+ge3tzIU0Qq0b1WVPSqK+9cxLsfnmDmldKHeRrYZF4iSr3CdzBK0k05Tg/EabdzV+7yK28yfYKcc2B8SzdZj4TKMfgPeu/Zaib/9aGORpSn6G4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756062423; c=relaxed/simple;
	bh=YRms1ZmxHxqVgDylsk6+DrYXSBKqHqMBAUmUksnqBm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YS85gXtNM8z/RD0efS8ULRzpcW0g3IDewWglTa5IwyrEaFSF5uU99LZi+Rx7eLmBUHILxRtOuxQkMNuuXy3NtWwK7lEP+RRXda0dfidHdyyvbUep7/UQOovEkIrpNhMND64FuccI2ECikMBcq19BQOBouOzNAEbUo5yLmsE2W9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tilo6+dn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tilo6+dn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so29669955e9.3
        for <git@vger.kernel.org>; Sun, 24 Aug 2025 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756062420; x=1756667220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpR1IRl+jq/lKyMsUa0VMnDEg++4FGIFgm/6O4hi2YY=;
        b=Tilo6+dnwDO9HaLMCqjlaIJ1HB187FEYs1kLLhARlLoiCsaRpLuVjjJCzBp1Z4GGY9
         o2GUYu8mvUWM8aMxkGerIvOU7Lx9x79RjXl+vqeLTczjs6+n9YZo+XnSmxkB4JTSmSCc
         I4Tz2e6KjvRqFmpCTMEEwXXOryOjwv6Mj5gAZr+ebwGfUC974sj6xkl0HC/9wu4bvUdK
         BANmzYUsdqvusFxo2UMwasfcxjAY/n1hC8dr8iRlRMyykfJPzN+iJPQBp89JvOpxY9Qe
         k8M6i3O/rRqUllLBxhcHBxadJZS2ysjv1WgJe5b6IoPDv0TTxwN+o2Rq7ds0rUTDUHoY
         eXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756062420; x=1756667220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpR1IRl+jq/lKyMsUa0VMnDEg++4FGIFgm/6O4hi2YY=;
        b=dALePJGgTWlKybFEa7BntqvnV5j3b2yzPP9iXtVqPWqk2aoDrSLZ5i97q46LyEYSh6
         F0xigWPOVhpc5s8iu5WN4ThywlMiczJV+e2b1EPzLY1hSnSkJa1VloJXa2CauJYlWKzg
         0ttGmY+BWZ782IqYBe7BZR33y3lk5pPig4LJBICnQcPctozmYGvnaJd6psBpXw2l02ez
         vBIgcYjAf7Q7B/VtreQfc5OTvWLRZNgNfyLf5rEzMCTnUdSBYZzbzo/TvwFtma5rh/3t
         bKX60LHcx5btTBoI5A/eldxS0ommjEWTdxzX4iYK5isn9W/8b2GdC9SW3mt+2In4kmy4
         vfbA==
X-Gm-Message-State: AOJu0YwEhjfKHRC+2lVqyj7n1k6t8ujgCXMNWsQlOkAhPWg3ij92vn8j
	4HeADPUwWUKK+mxvC8sHOoL4VDatVOyUEbF074kbo2mTZFkI8PAIwVRI6SwBjg==
X-Gm-Gg: ASbGncut/RRmHwH7ygAkFOI7WgbZhI/NWbJoNglGKWiMBZCUGi4SaIfIwPzLfJxddma
	OOtvHkJl8ZdK58Ab0Zbirw/K1+JFOaXzygQjA9DBE79OO/OKyBNDsgUvmEO6XxDBhO/voIQsrIf
	lOO0wFt6fA2ghVP6hpKeINB/LC5MeUTLx1mD+l/c8RsRL/2y8uzeWcCbybHJKWsoKn/jCd6ZRFL
	NHEt6NL5dNJ8RAjY8ndHEGQM4x8rNmh0lpo4WW8nGMFhb4Ihjc15bk+oqy/8+MN4+GaYkUxReVj
	2UweDinCnIUY+sb1QdWu+xmVjC8Dxwj/IAKnE/MgrKQYPnvyK93LnA89RPdzv1juNcm8AhZZZ/P
	TTXPQXUn7GBEZ+bIArhqJQlle3fSPDCoBA20w0CXzIRAs2FSjvVvi
X-Google-Smtp-Source: AGHT+IEUBj+R6iL7v41efszS+Y2pjtGg7TRWX2CvdjNWN9Hm936sA8aeEnW81uQEjscpkLvr+1WfHg==
X-Received: by 2002:a05:600c:450a:b0:459:dfde:3359 with SMTP id 5b1f17b1804b1-45b517d9bd1mr72189415e9.32.1756062419756;
        Sun, 24 Aug 2025 12:06:59 -0700 (PDT)
Received: from localhost (78-131-14-231.pool.digikabel.hu. [78.131.14.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5744e9b1sm78543255e9.11.2025.08.24.12.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 12:06:59 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/4] line-log: initialize diff queue in process_ranges_ordinary_commit()
Date: Sun, 24 Aug 2025 21:06:43 +0200
Message-ID: <20250824190644.2573279-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.51.0.433.g1a66b3fb12
In-Reply-To: <20250824190644.2573279-1-szeder.dev@gmail.com>
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

process_ranges_ordinary_commit() uses a local diff queue variable,
which it leaves uninitialized before passing its address to
queue_diffs().  This is not an issue, because at the end of that
function the contents of an other diff queue is moved into it by
simply overwriting whatever is in there, i.e. without reading any
uninitialized memory.

Still, seeing the uninitialized diff queue being passed around scared
me more than once, so out of caution let's make sure that it's
initialized.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index b2a31ae956..71fa857ee8 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1182,7 +1182,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 					  struct line_log_data *range)
 {
 	struct commit *parent = NULL;
-	struct diff_queue_struct queue;
+	struct diff_queue_struct queue = DIFF_QUEUE_INIT;
 	struct line_log_data *parent_range;
 	int changed;
 
-- 
2.51.0.433.g1a66b3fb12

