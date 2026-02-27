Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C58368965
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173523; cv=none; b=BTEyMwmMpzk5i/zOwzzWoifRrIWPayoCSU/F0O0MY/jrcd5xmNeq0HjYmTt16S6uaMw9l4xxMpzN9cu6KFEu+7kTXWxKYeUMwP+lILXe7SQwKY919HUR61xn3yecBkUb+JlD36/7uqLcuCCo9mIAm8BWihv6LrPP+5oQ9Xu5oTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173523; c=relaxed/simple;
	bh=MWuUmblZt1BxzG9TE1aASpaDoJU/Qm/lvde/ymOB5Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uH1R9qSKNU7IqQP9naZFlItN6fdJhdOGS9qgd/cmeqo2cWHQQTxwzLaHsc/m7U9sLiFOEQSqXCMdBLheEsWPADxF8XK4xpxhb7ulwAVT61W99Z1IV8PeD7fdXTadDhGQN21oyHE052nHax7zv5Eaj7dc4Rm4Lg8DdP9cZau50Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGFR/6Xi; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGFR/6Xi"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6e72d7a4d7so1026275a12.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 22:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772173521; x=1772778321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWuUmblZt1BxzG9TE1aASpaDoJU/Qm/lvde/ymOB5Ls=;
        b=EGFR/6XiwVJYh/XthJVIo5WGZoJ+XJf52lRKnRCSNoWApPJwFnJppUGm+xuzRyFbnS
         OF/2HoU5CRHbjuksiAu8ESBobt11nD7k/vyeBq+S6V2QPQct0Yh1LUkRh756xVxVjECM
         0fP5fGWoHCBDzlb1Tf8CbX5jgIfRi5kHBozxUyvcQOaDjK6BZhC8xiaJ+BB0jdya7zXO
         daSO7cR4jC53KVaIQyLc80CWtD0Qo7umtnpa35h73PwS9+Jq1Cpg9ZCYX9MXY0gAt1LZ
         k4c5vM4iuqj+jvhaVsnE+ZEQfJbW2ClUF77ogE3RhyPWXSCiWUJKseieMhALmUO0aKH8
         sNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173521; x=1772778321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWuUmblZt1BxzG9TE1aASpaDoJU/Qm/lvde/ymOB5Ls=;
        b=N/Z0xGifnTnpJxIMALeoj8F80GeCUFdfPw9FUUhL5hHGO+jGAoUS0Kn3CmSgEGdMJU
         gIYTNBo8Slp+bO+FH/jdCvjwd+eYSBGQXPLQZMLwyDirFQICHtLpQVDhgvEdfl/hSOi1
         68r7HIUmCeOHAyWWJQ3tkUe3UkoeL/j2Qyr/QwSyIxmtxvomEfczit/9pqNo7EMvFAEJ
         oI8255YToNaRGrhnrji61DvGMdQUWFLCPQD6gCC7Sxs22Tpe02z6/0uHIsGofNMEB1ob
         19qmVu9phWsB921LKomAYCxAFUGIN3To+ViZtOpJ3By+oonBe04GaNDp5jgNfGhi7AAs
         w13A==
X-Gm-Message-State: AOJu0YxhEfH773O0d1DLGkYo2I9usw9TPZduW1D1TSdlWhf6JZcAUPZR
	TtObnA68RvPjXs1fnp1q052zS880pRaxxhQPRTYpLeRSrDA9sDyk/inlHmzcTg==
X-Gm-Gg: ATEYQzyyCkI2A7SsYGr+7X/d5CVbftGTSo9fVeLFEBCok0xXyVwz4cNf6zyoGWJGzlj
	Pa4Lx5DXiXazRuz6HiTxQICX2ff+BNjXTMVeVImdZVN87nzcmTfPT3VSsWb/N8t4sl+XEv5QWVr
	FqGfJvmlMNVokeNrWRu+ks4A5gWSmh0a5uyY2FMCEFvwqR5lMTxzwuPbo7BwRGxDW+hB8JF/ZVj
	4p8toJCdqiki//1jZJ+cCsKwZ3NZuKRMMXHZzIB8DMR6zhIyTawP5On+VTRCAu44xupQwB7MAlu
	WWOuxu4+Z7fjq9NmsgAB7ls5QxZSZJp/DO5usVfknBNNspoUeJPF/ShK1Y2uC3CdDmdiwF7mEQu
	QOo/MHh3F2kgGqHTb6S6XuLLW0+UwHyIYKd7zADvtBWDNF9H1oqctxbYjVDRTgvPoOgcxpOwLhf
	QCgtv0XfzBvfnjCbMkZkAXeOjNDh3tYPqhCM6S5j4M6gcaOEzlZS16LzcBxzYqQWJVOY3OFdy1N
	aDJLpEBCW5c65lIv/bP
X-Received: by 2002:a17:902:da8f:b0:2ad:a9a9:4bde with SMTP id d9443c01a7336-2ae2e4b55f6mr17699275ad.40.1772173521344;
        Thu, 26 Feb 2026 22:25:21 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f8206sm40651305ad.90.2026.02.26.22.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:25:20 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH] fsmonitor-watchman: fix variable reference and remove redundant code
Date: Thu, 26 Feb 2026 23:25:02 -0700
Message-ID: <20260227062502.6995-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260208060359.50233-1-github@paulisageek.com>
References: <20260208060359.50233-1-github@paulisageek.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Friendly ping on this patch. Happy to address any feedback.

Thanks,
Paul
