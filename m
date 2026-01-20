Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F003D6682
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902606; cv=none; b=I5YMuWjk+zOnYzkFt3z/Qd1/1pyJkDhIYDyOrJb+SJOkUW/V2WcL+LGDEONLOYcJPXC/VQQCQkshiouZNbYE7N9RbigQOJv9ddRy9CTNuhxW7tvD1AHGMZLlBTN8HJuqH4ZjA9FNrA84EZ2woedLmnDwEaTUq+YMGkKe7L5MRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902606; c=relaxed/simple;
	bh=e5EYm6+juujf8WdFrmed54fX2ccUd3hxWezHkjtEE/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsBo24y69iwyZulr6ZTM9nExWEVINvv1sTkzw5q4hmVYdCuK/vdCZXQCopAFGhE6k81wQvU2ldUsGprqubb21CmPH8911QF5EkMani8IuuabajW5/wPqytHz991U5uQC2mIrFmYChPw2ZGEKCJ2r/BWfjgMT0GE0MNkB4f7527s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfxzXk7G; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfxzXk7G"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b710d46ceso5292038e87.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768902599; x=1769507399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iNPUUKgUu7PrXUyK6xRKlAxDqcyyLrdx6R0ns5aXgY=;
        b=lfxzXk7GB9DoAbiCw9NV/LGHI0h+VNj0AAugIYr2Kqg9xz8g9pGVY1kKfCYO5ln0LK
         2Zgua4QbfUVEGxzHjALKsNHsWcc0ZCSZe9H99D0PRFbXk/kJtjNE8ATzk0Tw5hPSaT17
         CcywNlJf0Ud3BxB1T58Drxj0r7SmxFgUT6qgaEhZIjtwz3JMStDlnxHe1iQYkdfuBrRq
         eifaZVBKff62TI9CaOZUtYw5Fi8+XeZC12QmgnIxp1O5groNYIiGHwrCOGa+KItlNZ8w
         mEThZkoN4pvmn1nn3GHjDOeFb9kP9ixwTSN7XgH+ljp/b/B2QXZNFFFdIdQTx7ZOfjZq
         eaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902599; x=1769507399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6iNPUUKgUu7PrXUyK6xRKlAxDqcyyLrdx6R0ns5aXgY=;
        b=Ur1K6XS2J8BoXxz5SKrLyN7U2bWa579oYPe8ulm7RCKTLnbDSyrF02u0GwOAyNdTqL
         Wb+7xKPYFCS6m3oW1qTOL6bUUy59d47zsAQMyHBRT71ftOAKi+lm559hkfGtpMHLPYnQ
         DBHFb7DRUWOo3UWt9IQhcaXO9Sa2fWWvobXKiEM743a4JabekCHMSy/EniuORt4+OCW5
         0XJoaQpfapfP3nIdmaizvYiZzB5kT7kqXclkCLTShd24gJQ52d9IRL9m9FP4zdemo2Ac
         077m5wo+8iIn6VtzGmBny8haPTo4Gl6E7hmuXCp7eLN9L3PHrHo4tlbNlYDLjIBU6h8o
         IAyw==
X-Gm-Message-State: AOJu0YywccUJrlJv6D2lkK6BQRSN7kjLW2qOO01yPZp+6jHApOqXjW9B
	6S7A8dp1PlkW0GcOZwUoUPg7hm+ZMEc7urAVSbZ2ElLBt/u7H+YKr88i
X-Gm-Gg: AZuq6aKncuV4Q7Gh1j1rl+s39GVxJpvxOBUqsQX0iaXPb0qr/K/pYAmRYtVup0w+ikU
	xbBBSxqv78BaHE3e0dL44XyqYXGfLUDtk92BQS2hPs8noXkJSLRUNNzM79ebi5HU7EyFHbg5zgr
	qsYEmHvViXOgfoEUBI5AgeU7G/NOqC7uvJUtO6B9gjfQWyemxEbKrR1A03NNYAC4i/yEY06/XU1
	jjVzgsW+cEqc8Em6EPhmHL6apvnlDSYPcDNThrLs6v52xDOmV9qlrCTjAtjXJfk/n1cHyd3cE94
	SBZObDilQpANo3ACUpOw3d/FYfCfKieXo/KfflGN+W/GHJNLQTf7L1Zuvy2IBH7R/Wz7cfl/bhn
	N9X1PjTN7U8LrhOjcGQACpaZouGAp1Sc8a+sAzfFTRwep3+mGC8Dw2J7z5JREDoETNjNbNIRlZu
	Z9RJfB+vOJK1GSh9Rra6EDc8wcso+0fCD/Auo9MntVsapHRTDSN4ZzKIIKCNcWlyGqs3V8OBzNj
	VOQ
X-Received: by 2002:a05:6512:2397:b0:59d:4a12:5f9 with SMTP id 2adb3069b0e04-59dc8f11ca2mr614658e87.3.1768902598968;
        Tue, 20 Jan 2026 01:49:58 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33f01asm4082327e87.13.2026.01.20.01.49.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jan 2026 01:49:58 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Memory leak
Date: Tue, 20 Jan 2026 10:49:57 +0100
Message-ID: <20260120094957.28855-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119051406.GA1115353@coredump.intra.peff.net>
References: <20260119051406.GA1115353@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is due to some memory-management hackery in e291c75a95 (remote.c:
> add branch_get_push, 2015-05-21). The good news is that not only is it
> not too hard to untangle this, but it is closely related to leaks you
> are seeing on your topic.
> 
> I'll post a series in a moment fixing both.

This seems to not have helped my memory leak. I squashed and applied your
commits on top of my work as a separate pull request on GitHub, the CI leak
tests are still failing:

https://github.com/git/git/pull/2170


Harald
