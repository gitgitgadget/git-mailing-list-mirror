Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B01E507
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004201; cv=none; b=KqKsQBNz8Uk6hJJ61g4CpPvCfYP4DCMEqJCMUx5sAVP/F8hhD6/19qZ879km0Y6x7fe9QzG9OswtgwFmh96cfrQtlxSCIm1z+pP6KWHLl7kmozvCxJON1+SYiIC3hlVmu1r4C0BTCcIP7PT8EOrW+FvH9tTABPUhSB1vl+PX28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004201; c=relaxed/simple;
	bh=2mRo4Cl2SqKqdjA7LqDRrk/TMB+jbj2pFU83LH4kN2A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cuWkK+NoF1BZpr2L3bK2bLB2KncvxIFxXUTBlkyVH6/PoW2wIZfGZm5iP5MaNSIMMu+BK2aVZhlArFKet1wdPVA4BDKpMSmm7XhKFoyWhZgbNXrU6CM37/BoH6O3z2yAcPxgkwuUMo4IP7LDTc8aKZJFe0c6kbtWKF/x+72AIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1fB9cxS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1fB9cxS"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44665605f3so497134166b.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712004198; x=1712608998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fBQhd8agA3k1Uu3KS6gA4zhHtDoE2sj4bQ/hS7ZApUY=;
        b=a1fB9cxSOMTfQ05NRCTwXWu+QLiAAIRQ7M3P2BP9c2hSyaOVVY/Cpv3qZWL07HMXce
         CJxZVP+pPK9lvKcTlVInTh4mpEVy6MghxcNJ3PVHa1tGj8UvhY4vJRplOzShlRXvM1RN
         q6TOUGiCv1c6Wi2zf892GoS1hHjDVOy3+6J5lAQspW1TneVulb50hLprMlWXm4OqJHMG
         LmBgcOA72JeAFsc8yoiqLNbjtkKX1rOojI+3KCMWP33biCQ2VCnIfLWdK+eDpPW6R6qi
         8JRPm9uqNwXgHBJ6NKFbS03aP+0rLC/TRk2AC8o4aOlLiwYvANhWDy0xPaGhwLxoUuhL
         KEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712004198; x=1712608998;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBQhd8agA3k1Uu3KS6gA4zhHtDoE2sj4bQ/hS7ZApUY=;
        b=gdtyb+cSd9kh7Tm27vnioQLXgGHU+sintOUpPKLx8bo1lR/hC0xyVjwvBP1zxjl+8N
         I0S0oN6MmwKUQRj0pyEw1aezgZwByZ34Nl2uuuAf0mP2dC95lKFQ1FDcNRBZOPV/ou84
         67sD3CtfLqTDZWr+65Q1R/GnO/1PBDGhRmf4BqAi4icqY6k0uDwZM0LtWi79wOTaMFvR
         p6kOAIfUxXOSRu5H7ZA31N/IrPBZuEFPw60ilOP+3/9bdhui4jflPjLiLHHSVi6yzfIn
         W8rLvOohBvQmDaP0umpKzglr6nHCkdQKHDgiS3StzwObuNkLSmqNHH9qZP0Xnhr0KALt
         LHPw==
X-Gm-Message-State: AOJu0Yw/RDZ8PFeirltsT8yCjKniKTkDFa4Zp4rMHv0ZqRc5nNjyRW8K
	L4SDKR1PXWp7uvacK6XJfcYm3DxeP/+4AE2GQKZex3zzi4ftrmyrdoak7XEGt2OGhHnwvOUrQ4r
	5ojIW5cnsyxG38gxhyuAl1WRLiFSODvQEBlS2mA==
X-Google-Smtp-Source: AGHT+IGaqfUiUXuSqr3tGkxTAhnrtXxwh9rpTJ39599Rdrbm9G/2xSAlmpyWlwMwJVqrMzmPaOdhHgAD2tWLKxQoOe0=
X-Received: by 2002:a17:906:3a97:b0:a46:966b:ebfe with SMTP id
 y23-20020a1709063a9700b00a46966bebfemr6047696ejd.46.1712004197845; Mon, 01
 Apr 2024 13:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M Hickford <mirth.hickford@gmail.com>
Date: Mon, 1 Apr 2024 21:42:29 +0100
Message-ID: <CAGJzqsmOu-2kcOOAoXWkk3W=RQkdTE_AgZiY6Cj10_DdEnUVGQ@mail.gmail.com>
Subject: Debian packaging for git-credential-libsecret
To: Git Mailing List <git@vger.kernel.org>
Cc: vit.kabele@sysgo.com, jrnieder@gmail.com, Anders Kaseorg <andersk@mit.edu>, 
	debian-devel@lists.debian.org
Content-Type: text/plain; charset="UTF-8"

Hi. It'd be great to package Git credential helper
git-credential-libsecret in Debian. There's a patch prepared, but it
needs the attention of a Debian developer. Is anyone here able to
help?  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=878599

Kind regards
-M
