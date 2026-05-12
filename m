Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138947DFA3
	for <git@vger.kernel.org>; Tue, 12 May 2026 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571319; cv=none; b=IXCEb7IZmj4Ee4yUZyl9A7+A6nXKn9EjklbWnF6pOclDdg2oF29YKLRhNy2H2uhRyuahyyfGY9NA8f4ZY6dw6JkCkIhsvmIB/Kl8mBCYOc8eTZWNgO0r15dqY1m/Hq/h3/OufYE8Xq48jC+vEgb2M4DOW5Axyc2yEkVlNyGkARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571319; c=relaxed/simple;
	bh=5qiYwxOpCapzKORbIX/lh1ZCiy5sw/wbTCvW5flKzDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG6CpzUkAIr76bqEo7mXqu4HQtanO+2n0ZKZAAoXhmeDkJvDz3mCgcBql7ltQM4A8+eIFtrWg+gVNHYYvF+XZskuChpVUd4Z4DaDILenzejdq6FvZdS6EjARRezDi06TqJ3ExgqI3Bm8OBOLn4RMCIggvR3dwoTi9mnfi+aMCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUtLojry; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUtLojry"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38be5e86918so64566231fa.3
        for <git@vger.kernel.org>; Tue, 12 May 2026 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571314; x=1779176114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qiYwxOpCapzKORbIX/lh1ZCiy5sw/wbTCvW5flKzDI=;
        b=pUtLojryHzmwh2bGMPbW2m/+CJULijiwWK77rB6aaDalYMTZrBVCU0TWa2nUDRfsA2
         efOPklkSWptSI3io6+O+oqy3PNWguWbSm/lm7uBWgdxVN/cpLWxok5RtbsDfslwbFnYB
         A7jYc2qfmt1AgnjRtSAlc2CTMQ0CnrapMXHrkb5oFlUVyMRxA2keDNYjdTna1wqsYENQ
         QlpnsBjaD9Koaom7B1si3nWCDSQH3LrVsYPE0qUi9Tq6RtwmiipcWKUz9OotuJHioVXZ
         SsmLPAMhTvDT+do5hTTq/6M74biRgxbpISQ6xkWGXxZrpoesV77DpI5eqofXxXoZKGjV
         i9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571314; x=1779176114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5qiYwxOpCapzKORbIX/lh1ZCiy5sw/wbTCvW5flKzDI=;
        b=myQFKK7FxYHoEUZ5wSt5+LfHCmJI0cBHm4SIzFUnV0zDwW1y774M64kC4sMsDAnEFe
         ABqVDwpXuAucn8w4TNTrqE+29GIJrnAYfW65uzCmWWvU+EbKtvjoJmiEPFjbWrgvlYbv
         pt9ZF7AJWS5Yw1p6P9xCWv/ydUyA+LhBenycKYlnGE01QMjJC4HN4BbinlN8FuD3+Uk3
         jaTCrMJZhT4R9vOPqhBbjdPnxHQOd8SH7s+3wXd+MTeybCVr8gRJ9mMBUNySDremBuCu
         CQ1doz0oDOSmtkJ63dGRKAk0VCZwI1SgQ/JoftxyxXGsiINGnUqwfRk7nCsjOCPEG/qN
         6h2w==
X-Gm-Message-State: AOJu0Ywkb/Sit1oEe2D82Vk1RRz8KWNN6obvn26YnMtL5vH4vU9XfYBS
	RWY4QK+gVl+BWuICj2G5MKY58yWpWjOApYMwyCdQdY23sAWFJ4A4bE2M8WniANHe
X-Gm-Gg: Acq92OGmdcoVquf1el6hg//iUOncFoz4IbAlDghVNXZKUhwGJipHaGhoPvFlYyVFNVA
	ob5784vyvYTqugoxehZnpFGta72fcFMFO2Q40JOiSjVFGim8qLfTJGZYHpaUOtDzNx6ZAZX9dhs
	fL1/jP+6MjErybxUEZb44eRsdJpT7L76Cki3Cgi+daamqxeqeUvwYrlGzhdXpelMMKLhnMPLxGl
	mo+EmOTtKXGOjhPySssmTRDw++edJxS8u/rwp05RGPPjddv7Kxl+UmtkRgjZ3kydEtsCPixGsua
	nDMvwJecPJWKKSy3O3aeLr0bZSrIr4QwNHquFpwbioUi0/AdofGBNKESKeL41s2FlqJW5m7GveN
	xH4Q7+2+w7uL8H4jqulsl674UgzubCX59Avdawvw5kAzn1WkNxM9fgVfwYfb/1ApQeM2aUjTAEe
	XUjPiQlU4Gl+JbKEKWm7F8PriSryne0Cpxr60eFn3nSLNkBBzdXHdS178S+sckh6kBEfW2qmePf
	x92ypAjsZ4o7Q==
X-Received: by 2002:a05:6512:398a:b0:5a7:477f:41db with SMTP id 2adb3069b0e04-5a887ae1f69mr7958906e87.10.1778571312509;
        Tue, 12 May 2026 00:35:12 -0700 (PDT)
Received: from Mac.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a955e14csm3167678e87.43.2026.05.12.00.35.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 May 2026 00:35:11 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	j6t@kdbg.org,
	kristofferhaugsbakk@fastmail.com
Subject: [PATCH] fetch: add fetch.pruneLocalBranches config
Date: Tue, 12 May 2026 09:35:10 +0200
Message-ID: <20260512073510.63435-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.72.gbe25572957
In-Reply-To: <xmqqse7xr0t7.fsf@gitster.g>
References: <xmqqse7xr0t7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I may be misreading the above and misunderstood you, but if you mean
> that the feature now checks with remote/origin/master when I have a
> local branch that were forked from remote/origin/todo and set to
> merge new changes from there, I do not think it is a good change.

I think you are right. My latest code assumes that everyone works toward
the default branch, which is what I do 99% of the time, but yeah, it should
be more agnostic from different workflow.

I'll take another look.


Harald
