Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563F35E950
	for <git@vger.kernel.org>; Thu,  7 May 2026 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184677; cv=none; b=sD7pzfCVoAai8IBUPSqMA2kFcASiHAal37YWNwye25FGi+wT512kRNV+rloY1qPJZaP5B8YivO0QCrMQ1L38CykndAMlDXJ7pgrSXrcsX+Bp3UqSTEoKkitM8/Sh491JSJyhtx9IX/MpILNNKb5c9qFHf+r+WP+flOWysfrz/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184677; c=relaxed/simple;
	bh=DNvyxzDKUKsOEf5yagCkv4UMLY3nU2/RH1DbUCNaFVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4zxveYfXNUFMiPsEerV06zhC597ZDEwVJSfdi3tjwsSj9Vg0sdqiAE5G0BuTwd4bDO/KMkEgag/e7Qa4TZJY2oYsOb64zUlBQsgZrc4H0LJ6WtctWYobp9ZFML2R0kybrkZE2OHqAqH1gUZfPgqReY9Fgq3CwjHI13ErtRCWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaAJuFQo; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaAJuFQo"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a877510541so1248181e87.2
        for <git@vger.kernel.org>; Thu, 07 May 2026 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778184674; x=1778789474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNvyxzDKUKsOEf5yagCkv4UMLY3nU2/RH1DbUCNaFVM=;
        b=BaAJuFQolHvdTlx9yHDJJB9+rXnBqp/FF2d/LltbWRFktEt8MHTiRuJNtWbC35+M0M
         uClwdp3KUtvmTG9HH4bvKsWuLrZA0ORzw/yDQshHCpEmueRCXyGJGFvDtezCyww28vDS
         LSLjhXxo1py8zqjONh+BN+akypcehTOvQVUFJaIi/CcgCtwPamaqtYirt50O9V29eaBV
         cxH3lZVdlu5fnFe5hAtA6abA/g9XVgNMTwNwsqsS+1hd+krXTk1PrYFoj42TeHuwo0dT
         I9JksnYzzUs9qLjKn8eOKT+0VLAZtjUKoKl/57uL+v0LMHke+tdP9DYvwXGvS0x54li4
         NdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184674; x=1778789474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DNvyxzDKUKsOEf5yagCkv4UMLY3nU2/RH1DbUCNaFVM=;
        b=PL4d60ALOLO075WaZjhhqltyr9qsOv9JdGH//3pXyi26l2XGAjMoovgb8CidBBupBw
         nG0wVGt1tLEEfXPn6K76ZBDOOrWIe3iAwPsG1tJ/4LGP9KMKtqMsYqUZa75NkF4uwyuz
         BjAlRcTlS81YPU9Tr3D/3MjyCjjxSxhtbFD3qIuy590ObBWG+/hluMMUtMbHiOdNXa/X
         tqSzj+y7Cw9m1yXLdEcmLaZtagfZ2bFCDzeONPkQtbVzalKvspqsnee79Is7XfP/r3H/
         C3955/axNaJ2k3/qBkf9Ixuflw/E/ilohxa4cae1dPKp8TWC60kXw0bU+FOvPq3Z/GJL
         AuGA==
X-Forwarded-Encrypted: i=1; AFNElJ//LgcKBRV7QyK0tVsZY8t2HwlW/z7sGIDs4aBsagW5BR+o0zzgGkSztFR+74xHaJ4k3wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/bDvayvyH2Pxf4EeYjT5dJnbrUpISm90fFZKgfAfvP/H/96kP
	HDTze7uTWBXUT4oZmZkHo4beOz9gIgxm+sgnOwVg/9UWcVNTY19DWz/goJk0qSaK
X-Gm-Gg: AeBDievmsWwSK3Qjsf6283+gKYouDsQOOBKlnzf6x9LtCnuzGz8A7xut5nQdTH6Cw+N
	IkkvWjypGT//8h5l9V3GDdLY92/4HD8hDgHAi/88ByFsGuBVNTul9lh3pcJsfKKqQr6zhxzbyfW
	IWDOg332Xeghvfd22aqGj5XZ8eF8V3L/DiCvo7xWhjjC7/nxhQ1/GpBZMJk71+psQhjNLvLiIgX
	ujTQg7h0Ql32DHMOgda3bANDV97YlNgktZXtWm6rz+UBR60MW8tGRoFdyDB4/5Sz1RG8bl32uYU
	cCSLgr6w515uIwIO7g9opkFq0SbqMfzVVTeJfXLmDggci9ZntYw3xMQKlIpH6HRAZ2vM571mo2d
	mCKW4jeUr7MIsxAOhJqeTIA0e0P5qXqooRZ5pHrPUR04rrbi5tKDoOyv/pVsWhxoY4g8RvgzhmU
	CgMVrwmiV/VypKDLZq/KUlQl5VIdMy1rwFx15C9DIjAwSanvuG1fsLn1O7OLk1g0soOjxpkO42k
	WY0cXKcCauLjYl/
X-Received: by 2002:a05:6512:33c9:b0:5a2:a13e:9082 with SMTP id 2adb3069b0e04-5a887ceb775mr3344032e87.35.1778184673973;
        Thu, 07 May 2026 13:11:13 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a4808bcfsm180848e87.48.2026.05.07.13.11.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 May 2026 13:11:13 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitgitgadget@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood123@gmail.com
Subject: [PATCH v16 0/5] checkout: 'autostash' for branch switching
Date: Thu,  7 May 2026 22:11:12 +0200
Message-ID: <20260507201112.41110-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.6.g690242d89b
In-Reply-To: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
References: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Is this ready to be merged?


Harald
