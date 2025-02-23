Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A9A95C
	for <git@vger.kernel.org>; Sun, 23 Feb 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740332232; cv=none; b=mQ9eNyz6whbNBWu72k1VuXyejdTTfPt+fZLpiKqfdkpsXC2qJhCmr195/8EVz/6kBP5FkZDqGLEqHpKNLjJUG7OGNZV7P1B7SN2BuQCpZV3Uwm14cMI4X2Z+5FwnSBMmox6O8VUGrPjjDiToOf9IYeMFn2L44ldJ167pNcQ7hLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740332232; c=relaxed/simple;
	bh=RSnNvKwx1cdPZAxunBxSWDw/jGmzwRdH7qei40cADkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSXaqoRlqbUUcPk9j1tU0JCNpRf3g3oT6L3Z3XzNTg9fJOregA7HoBD6HbmBGMWaAiYyOxPJpgekC8cU8xwAKKKT08LgdxP1jTw1rA/qOWXdmiZqLzqk59YXqB9AMgp/IrdiiuqQlFM/q1IJJBexwbSwmQVskYss8lEiSYEHuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiG7eAa3; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiG7eAa3"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso7537690a91.2
        for <git@vger.kernel.org>; Sun, 23 Feb 2025 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740332230; x=1740937030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07xx3+J+c9MsNr6SmtYgKkpnDEVju31YMKAaKHaId60=;
        b=CiG7eAa3SKa8gCY3vN/J+56ZChqEUCgngGxVI9sw8jGvuvstN7LGZIoiqqJR3fRVhw
         2gHpRFm7Zr8hqF0jVxXs9RPVYeGp4KK00/Bm6LMR2U02W0JSKO3bO98G7fpbnP08fV0v
         8h9uiRAtaUKBo/MzRUKamHHQhN6/RWw0RLQPCU57umSBU1JPp7Zf0vrvpjuEu6n7K7RC
         pEPNnMWoJpj/dfgXFZRgqZb1Ba1BtzS2fe3tHuRW3JywVHhN7tdUuUmCmW5O4P5vAZ8m
         N6PYZVoDcUFheJMPGfHRuCfmfou0Vss0CN4aVXS427FXgnw51HjkrNLV5MNIHl1JdJBP
         JNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740332230; x=1740937030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07xx3+J+c9MsNr6SmtYgKkpnDEVju31YMKAaKHaId60=;
        b=mqEHT2dIMtZl8d2MOyK3VC5d0s76kolXmj1w/qZSlJLWELqSkn6q5yztTqkjCtrUuw
         R+Q6Ze2APFl9hz2iYqP/hoeRWSQ69frF7kq2P2c2Ye7DY5eMbtYCHoAU1O4uRyVZ9buw
         9zOjIkdkR3rMM9GWxldh4jvfF1XxUIcXvjZZQhpsYOHcqWEUWn49BN5pLFYryT2rgRhe
         JsZ43Bn8heQLYXBxaRhdUU82BmSFc8bGWxiKw90xjP/Wn8ezz27cOZRHlsMx4Xa1dNGi
         qDCXY+ZnvXSOXgaLHRpLNtnnv0qJuhrYC1pY7OIe2XZ1IOjIsLIH0pC1cbqf5ipG32Gu
         R8tw==
X-Gm-Message-State: AOJu0YwNcrb0KpjbRGB3dO0oVBtioyAutKIlOpn/mMkuyVrs8qWUdV72
	SIzxAESoqJThVU90KVDkUXqqNjP7gt6IyH7M+tFEZtJgy25TN8LJ
X-Gm-Gg: ASbGnct13jNm3HQUd09QrAkFq1xfDkxuXGFCekLQ2wLaPWx4Qxi+hgmFzFv05RNmOgC
	ExOdJl4/2mrq+2snxQCALAJDxIPex2vPibXZjCkTZZtD3ZsmmkOPIxtyj7Xuk0dq/2ucA4k3yQK
	eGKvZSJhqADPZvMUqcbNt7L9XESIU9yxcgjNumazx3XV3difEXTcNl/uwnVdJTnp+WWD+d+hCKv
	OkZ6bt/oZzVvs6/Ra8fkbuvx1KRsxOmI5j2IKC2YZjepkMQerWINRqHlcoipua5c3bXRs8gyJnw
	xh/K3pKY1ABgtnQ1vduJXjqqhU6Be5NGDk8pcHYdrppz1O4VGqQoD0CRTg==
X-Google-Smtp-Source: AGHT+IHQvUpCjY6AD/s2uEc25pSi9xV+C9z96/z/eiH+8mwFUarUj2hq+TdZmVaKDEA28fZJBa1UyQ==
X-Received: by 2002:a05:6a21:33a4:b0:1ee:ef0b:7bf7 with SMTP id adf61e73a8af0-1eef3cd4693mr18067538637.19.1740332229934;
        Sun, 23 Feb 2025 09:37:09 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. ([2406:da1e:bcc:8000:7a73:581c:1722:8d2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326b5ef448sm15158280b3a.173.2025.02.23.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 09:37:09 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jelly.zhao.42@gmail.com,
	karthik.188@gmail.com,
	newren@gmail.com,
	ps@pks.im
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
Date: Sun, 23 Feb 2025 17:36:28 +0000
Message-ID: <20250223173629.16489-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqq34g7cjf2.fsf@gitster.g>
References: <xmqq34g7cjf2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for clarifying. Now I can see the concern on whether the whole bunch 
of things worth it; it's a trade-off between cleanness and robustness of the 
codebase and it's very common due to some coding conventions (e.g. error 
handling) in C. Maybe in this case we should just leave the working code work.

Now I'd like to ask for your advice on this issue, which I may be supposed to 
do before sending any actual patches, should I push forward this patchset 
further or pick another microproject?

Thanks.
