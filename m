Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672681F09A8
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766029117; cv=none; b=WKAd7sB3nk2uGWtdAgifL5muHerUWAftEKtgpsdAJ57KrB82ah8vrFbGmMHb4U6N/1sKyVoXOwP8wa2kMQ9a7b+5doFQiTzVnTZctldGFPS/qiTRNMXi7Uyx9ZO4ovJ4TiO8ypNc7R+KcKWffbpUafBeP4+MWYSdHd/33Jls7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766029117; c=relaxed/simple;
	bh=tumr52075ruPcfKVMs8m/00Vg6Hi2JLCR6R/OwmpZFo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=t6L8OAVXnLzST6o+dQbctOfDYHe4+UJRyxWFhItgLqg2x8DBkdaGMEnTPaCG8mMCXXOLtRzfLzn1L81wgH3MNTaAPL53cDTyWScZ8LkbJXFb3MWI7Rme7WE/WyYZwRtmT35atEaomSml6KGTsPKPp41lZqZy6pQdlWUM98CBhac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np96Q8he; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np96Q8he"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78a6a7654a4so1163337b3.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 19:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766029115; x=1766633915; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tumr52075ruPcfKVMs8m/00Vg6Hi2JLCR6R/OwmpZFo=;
        b=Np96Q8heyvUAXyUIL4/EscEs8qclQMYhh84ZRnWLf8/Kz8ZWC5calXwXyfbLQoF+2+
         bazt6p6Gv35EE0WsaJvXezbzdf4Grw3efVAZxFBwZy2uh/LMc9hvxZApixtVJyYnpLsQ
         /xkbucaYoTHH3fLfltb5mGQEjo2sgO/LFQZwIH+z9egDfuSXU2OjOv2nvBsJmBpy1SQQ
         aqGhoLZThCRIM8N0etX8uNH4oMXqC3fJb6uxPZcIS9aemsFfLzMyeNe1MHGd9BN2qsQE
         anaTlk7y9wYmVkx1oBiItUBupDqC4uSbLlM5xNq8HbKwXxvy5OSJgVvpwN13lY+zPJHI
         sryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766029115; x=1766633915;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tumr52075ruPcfKVMs8m/00Vg6Hi2JLCR6R/OwmpZFo=;
        b=TSSnsDSEcuT2rWfkxv56Orn7kvfN0Q6jUlEY7hEE5obyaPKOQlEFbcX9+ILyY0eu8L
         dsDKxE5J0D6/RlmHvq3ZK9A0olTWFFeqJuiMH6GyFQNQZvrIvhDnhMFaz9v+zMghfTfc
         s9J1gKwAZp3FqnZgVoAjOMRNwmlDNM09vp/LPzgmS349LViE7qXwzfExCMginQlBls/R
         JWfsJ1y/yNnNO9lQGRMpoRoNx9GKcG4tx7f8YhDcZUZW9vrylQzwSx88a2+Zca/RBUwh
         ru9DJYU9eaM4zKuFrUv4fV08YhpKSGCj0jaeNActYSQNJoByLVB80Iu/9HCwY/aIy94x
         q7xg==
X-Gm-Message-State: AOJu0Yz+oKObMyOdyEVZJ8nnchNULG9cmmnD8xnWGmrQQmBxEtrMRDzo
	9l3S40yoE4IQPAZpp/6C7x6K2sKjUxcMlr/zt9TpLjqZ637t1Ct1gaAtn3r8Bg==
X-Gm-Gg: AY/fxX5ZOuoTMCSjKbhSfJsb0Oxf7cSaLFn9bRX4a9VE3qPZ5Wc/6lV+INCR4Oq38Bp
	1hzTjAv9MhJIPls5iOFg9hlELl/IVioBwR+qO9Q14HTDy7XZYCKGPI6BxJp0HFKyIjN73nhesRG
	2Ys2uI2W+IL7W3ulB6jSS4y8w4bK7xQHq8JvBygHWnhJasZ69+HOSHBZlp5O83BbZMluuXpLTl9
	AWOinMvIp1uR3qdvKLd9rjUu9ElD3+91mVKk9dTMV1bllZDHq9sdf7TFjYRpv1B2yXAiIId9Wl0
	CKhU5wLDQoiLs3/7iTLWy8cPPS4YaeSdWJqSsCCUKj3pUv7OJ0ogvvTQ9giHjvvloK1reX8QlPK
	+E2HWok8+dqBiSG6aAfg0QMb1/DhbQBIAqRES67iZZqA4UB2JsIpWeAg7T5s9f0eZo5uGXJsQ1Y
	E7PYEJn6/KnuNWZwCwQWRSzE01v3ocH+k/3rxz+KE=
X-Google-Smtp-Source: AGHT+IHeVD5qrqsRQfFVGAxQRSDVTcRJyLhTmljZA6HIDBZZRif0iWNaKje1oHBc1vSJm48THCPurA==
X-Received: by 2002:a05:690c:5207:20b0:787:e533:6202 with SMTP id 00721157ae682-78e66e7500bmr132098887b3.51.1766029114975;
        Wed, 17 Dec 2025 19:38:34 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:5982:24ab:62e1:eea6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fa6f28709sm4047817b3.10.2025.12.17.19.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 19:38:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] lockfile: add PID file for debugging stale locks
Date: Wed, 17 Dec 2025 22:38:24 -0500
Message-Id: <211B172F-303C-48F6-9B2E-ABF6DDBCA662@gmail.com>
References: <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
 Jeff King <peff@peff.net>,
 "Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
 Paulo Casaretto <pcasaretto@gmail.com>
In-Reply-To: <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 17 d=C3=A9c. 2025 =C3=A0 13:59, Paulo Casaretto via GitGitGadget <gitgi=
tgadget@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Paulo Casaretto <pcasaretto@gmail.com>
>=20
> When a lock file is held, it can be helpful to know which process owns
> it, especially when debugging stale locks left behind by crashed
> processes. Add an optional feature that creates a companion PID file
> alongside each lock file, containing the PID of the lock holder.
>=20
> For a lock file "foo.lock", the PID file is named "foo.pid.lock". The
> file uses a simple key-value format ("pid <value>") following the same
> pattern as Git object headers, making it extensible for future metadata.
>=20
> The PID file is created when a lock is acquired (if enabled), and
> automatically cleaned up when the lock is released (via commit or
> rollback). The file is registered as a tempfile so it gets cleaned up
> by signal and atexit handlers if the process terminates abnormally.

Do we also release locks when the process terminates abnormally? If not, thi=
s info would be lost during a crash, which I assume is when it would be very=
 useful =F0=9F=A4=94 I haven=E2=80=99t looked, just curiously wondering.=20=
