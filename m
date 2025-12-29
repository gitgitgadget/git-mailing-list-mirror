Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77BC259CBD
	for <git@vger.kernel.org>; Mon, 29 Dec 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767010656; cv=none; b=ih1G8mcgYe+b/Vdkqa88p8NsfJ7dx5Y8Lijsd8MsOCg+QnS8icTz0XRfPyGX+OscbggTDxvMtu15IvcGM+jefX8hawojaPHVwHcbfZjsOqEPoOo7eLZoDg0hq9uO8QGOvG/oHFMdBjpQnTaPoomfyu9d7tEVpqBHMwgWMHxLtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767010656; c=relaxed/simple;
	bh=ngP6BLAQpSoMWSlYtxcZXn4CHP/AEtpxIyeyekaum8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLJogaAQbkYgwDoseZwOVkk8GsitjVOwkONP3/2pKyTaX7H3rJnqoQ6CNbp9axVO/UcGF8d4VytPEDOzvo19TcQv/1BWRaRDVDWRSYDZ16MA8oNPwIUrb8V1ecNkYPf9sNJTXH+0OUbriK4k2IsCwKc+7eJfP7n5lSYVrdbd9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDirHtLO; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDirHtLO"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37bac34346dso66777401fa.2
        for <git@vger.kernel.org>; Mon, 29 Dec 2025 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767010653; x=1767615453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngP6BLAQpSoMWSlYtxcZXn4CHP/AEtpxIyeyekaum8k=;
        b=LDirHtLO4UU1CjWt/Rk4sROQAYJpDwtuT8q/uZ/eF3F1AQDISlZncI8ZiRiajPPlsN
         xJoLgNSMdhUHqw3jNlFw8Fr5sO4YtOgv2yxIyDGR0biHlb7aIhmDqUNfa6aR25phMlq6
         fZjiAw5VQ98Uo3szmdQw6ZiceOvWyGgewRrwC3h82vxpnvFm+j1rOcAhdQIIO+nF+QZL
         /gQt+GUq+bmhc03sCcg+fiou/DJFYtUidcISG8Ok3U05hPcXmiIix+Npo+B9T8y4FBAo
         kFYZRMhsD5f5CCi9yCzbyEuAmK3AcQbwDo4r9rwidIDy0Vi5TTbYsyyFhzyfhoitT23H
         HSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767010653; x=1767615453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngP6BLAQpSoMWSlYtxcZXn4CHP/AEtpxIyeyekaum8k=;
        b=TGBxHcQ49bewopAyYMD0eoD70owwQmC7XTx5FJ00oJdsUIKhR7KhCMCTkA0KW4yql8
         vFQIsZPaIpUfSTJ1wPZRgrPmUUdA6QP0XK7FCicsa3z7aboktKivdZud9Ed2nehckSTi
         80glq6M5vvsEsXn19ivrbRkGeNBYt+2Xc0Tmd7ZhvGUiwKjkjsxIT18rCWGCGTXqp/Vu
         b3aXf31Hwpc+d8TB8+g0eyDkyLELxgPf2YgU+5yE8Ui3MpElYneYhClbWMC6lsx8wc0A
         C0mTEVgbHaHCtMs81e/6bFo/kK4wQKqB7VkoRWqW5RLvDptjTtV2NUyw+Zl4iSC0yUL+
         EQmA==
X-Forwarded-Encrypted: i=1; AJvYcCWU+vpBvNhbsglGZJf6h4sUZ7usjHdI98hN0MU2ERZ9BjBQSPKKQg5b915f397J9/GZwkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aTwVifT9jiv+2I4x44Bs0fehxyWi7W/y8mZOl+6X0CSa2NJn
	CYIycmP1Vm40ehE98sv4aCMnqtH9psMbTkPJoI5X4rYc9/+Ue8os3oYH
X-Gm-Gg: AY/fxX77jFN+pOc2/iH8lfDW9jV7ttvmxIuULDN35CFgWJxdA8yKs5lus41VtpkC6Cz
	RdN8R71F9/TV73ZB4LRAq5YDq+n36b5fqQZP9pr1B7WvqoZ360CHkPSzA0Q6vODe7U/oUWJyrRN
	thNHPPc95tJ0nYMwkLQeoHqb7/auO0Jl3bZTLWxfLo+gpGObxPlHn6+IfWfCjlbZq7vs1o2Y9pD
	6hZHDy8SC46Py6rTM1/fb8fjGZpwyMU7LJ3MZqQdiD+r0cB4tBpf+bUD/bSz6S9OIscn/mU2Z1l
	Z3LY4tIXoGLrV1Bwe0LI/wiZdDItZhw4PE54ac13XB156XpPaWiyIma3aNRK6MCSbPoUUObzo7r
	6sSntyiuW8mvtfP7O6rmbZg0CaZHsPvnwxKHQNSk9lRC5DuPL0sNs0P7vdp+P3Se6UVv0H2zZ2J
	ZX0jfJ2Mc1c+dZ1GchUy2cZUCHZLYI4TlkPd3fMfbp2GvKL5FXBYHjiFjzxzW+O7f3WOUeV8g=
X-Google-Smtp-Source: AGHT+IEodIR4SGEnLw3zSnPBkLrOZ8IysQOFqYStQzahuBwFQWwXGYIcCkOpFuPMmlSeEWPkFPCouA==
X-Received: by 2002:a05:651c:146f:b0:37a:2c11:2c5c with SMTP id 38308e7fff4ca-3812166cf67mr85032691fa.37.1767010652752;
        Mon, 29 Dec 2025 04:17:32 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812262b2c0sm86366411fa.27.2025.12.29.04.17.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Dec 2025 04:17:32 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	sandals@crustytoothpaste.net,
	ychin.macvim@gmail.com
Subject: Triangular workflows
Date: Mon, 29 Dec 2025 13:17:31 +0100
Message-Id: <20251229121731.90086-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <B70285B3-5197-404C-AA4D-AA3E6FEEE321@gmail.com>
References: <B70285B3-5197-404C-AA4D-AA3E6FEEE321@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ben!

That would be very nice, thanks!


Harald
