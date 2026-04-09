Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23017A2EA
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775770158; cv=none; b=dnqzrCh+kVebwt5IAgRGb2C8hZfzEPPXYD8clR2ILiUKJuxgPZ3a5DflOPMH+cnK7a/H/PcU2mgpapROtoVVUNBMYCXnXplGVgnW/d1lwoacKBRxQAoGmhH7+fIg7amHcJQqYABdxm5J4mBkDAjtAQ0BbVLFZXRsi+7LobZlELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775770158; c=relaxed/simple;
	bh=IvwP6EedVT9AcaVqNqxEAiuirUEWfR7nHT5u6FwuR3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnM9NrW+hOUkHdm3j4ehbe8blN6pQXvWqaOr9qqMTaYujjKSKK+8pS7Tx3dwYmrCZo8qZ9sAPdCgtB7h8BsDEKQkon4JfWRzJw0FBhkAxRf8MikLK8mvk4s5/XvQ+dhjyb4YKHB/FDXkkFglHXofqZZdY/QTwmk2LfWw4HpB2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsHY/VdP; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsHY/VdP"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38dd575bca3so13711861fa.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775770155; x=1776374955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvwP6EedVT9AcaVqNqxEAiuirUEWfR7nHT5u6FwuR3A=;
        b=YsHY/VdPaW9WZj00mgNfXb45ryOEUwMs/cpvUmuWyKhoYiyPuan2to0gwb+BR8GrVN
         QHpXKIxwaSp+8i+t9XhtGGD+5NZF7x0n1vKH+PtOW/pyqz7gmpq3vAR3npHjDn75TQ66
         8EP+gIGN3brcuoWhbgTtoDV0j16B7vq2az5XLKkdACeSb8eIJuXmLyQtSWr/OZUzuk8H
         xo4aoIruOk9urF7yRVRmU1FwjNzI/Anal25m6whuLLegppm12CYDqwwRaWL3JFEAXjVw
         QmnILC96ywuGVbIoexW7F5tfxHM+eMoSjCaXFWsv6x7a3BQ9+HAJYOSpHekSEaazT0Du
         +80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775770155; x=1776374955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IvwP6EedVT9AcaVqNqxEAiuirUEWfR7nHT5u6FwuR3A=;
        b=EPiuEJ8R0K69fGvwHXUKNjfT7hZGU7uDCgu1RraqNURHyp+jnYKpvYEwaa9FCtt88h
         oaqEeyx2Ctoa76Xxhox6sOh3i4y+gImxbRUXd+KxKCGpX9WAnosDUYPc9Ee0L2C52YHj
         vB/kCvYVJOl+LFQ+P0wa3RX0CycFjwW+x9K2RQL1y4X2OR8e3JDxzZked5sxi9dbA1Oi
         cVD+XPpUtcZOxasH2Hz8cVAbpRmr2DGl9fJCNIJly4KmGiT4ZCgikQIB69p9MYGvPIK0
         FnnrofiQKbzCMHMOPrbpkQfE+bn1GN2/ghlp88jYaBfdthzTAg+ZotiEry2pQ+TLCPhJ
         Y/JA==
X-Gm-Message-State: AOJu0YycZu14CiVpJJKzfV0anC46f+7bPHOt19Ec5wGYi/isI4RYbPbv
	ZKkAkbZJbjY0PVHAvLlY0T0RrKa5N/1NV8xL/55ZYtpMjgd64OYctN9M
X-Gm-Gg: AeBDiet0qlbmKd4JjPo2eSL68vn0Yk/Fm2pI4PUsyGltbicnlrjPkQ5Q68MPFXn19+H
	yG8vR3Cbn4aCBrcDtYPkzeO/WnXDHd1liNXGLFbRvnU7M+5qR8WNo05VI7XpSF2MfcvKFeIhWI3
	R2uscRywVHrtvooagWsENphmBE8SIggqcHWZLfOIF0xGT2rIoQ8k950yXPguX1Ewp2c8ybJbgBs
	6wV59K1FGsbo8p0nzbNNMQN4r+M0UumlPfzrGiMKwHpZUb60UaFFvgijv74C5EuNDs8U9dU0WUB
	mJWP4wy08XLM7KtWIYyMjeZdr2jFeM0BSC8QeO08SvGt8Y4trLyZCg03Q0r4uixpj/hat/NlTE6
	pNYXiCEVdJ+yg2lIRuCHPPI2UkwDn2TLQTXp6oU0o8biInoZ0+DgcZ2G9UU+FxFQBhprm2NRhKa
	/+eA9jrR8jXSOfoXQmuSsqWXjdjTRlVj4rFOltYZwbBIFDKmu8+yL/FmS3WnoGD+N/YhoYktPhE
	o1KgUKCUu/meeqB
X-Received: by 2002:a05:6512:308d:b0:5a2:9b96:528b with SMTP id 2adb3069b0e04-5a3f0883178mr144611e87.20.1775770155051;
        Thu, 09 Apr 2026 14:29:15 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eee94a38sm174115e87.36.2026.04.09.14.29.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 14:29:14 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu,  9 Apr 2026 23:29:13 +0200
Message-ID: <20260409212913.20127-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqbjfst21y.fsf@gitster.g>
References: <xmqqbjfst21y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In other words, you were not consistently trying the version of Git
you just built?

I was, but the difference here is the this logic calls another instance of
Git halfway through, and I didn't realize until today that that other
instance ended up being the system Git instead. So technically, I was only
half-using it -- but accident.

Maybe I should consider installing it globally on my machine, via PATH or
otherwise!


Harald
