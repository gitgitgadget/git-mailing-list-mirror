Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E742DEA74
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113653; cv=none; b=qV+BA6JsGTQ8+bXqgLDYg3kBdbv8WfkVqTr2rHm2A9T7KURg6M7o8NP1FNPiIhpLLSEp7DSFX2f/HEgg6bDJefV1komk8+qqSh9TyDBTcOMUwjuXJxzt0IY2Z5/auHAxRa6a49lHoVzbQSVXaJKLt36U+MZq4MyHZfVGLY4uSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113653; c=relaxed/simple;
	bh=xXgomWElVazrS+pgGzXlQmTGODCBOPROHKOhICyfas8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7iinV/5pPYT6L7RG5V++2+fjHseLV9cBzgQQM3F7enBtKjoORyp0PBofXDQGuNCpsdwzZAS+Svhefq0mditZlibojnP10bfp1b1vMBtTKCaZHXVK2oDescv7s+nZsHnDOrpJ45oj5Kn+EDQ/2xh2F/nZsd8gbxeCecp4lj2qXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbC2vUIa; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbC2vUIa"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e6c181402so857328e87.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 05:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772113650; x=1772718450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXgomWElVazrS+pgGzXlQmTGODCBOPROHKOhICyfas8=;
        b=IbC2vUIae6COIR66kPOV5YzTAKvW/tPB9sAD/JX0A6Zcbghvc38nM04q79lTUuJx6r
         /btmOqzIqftt5aVVd5T9mjX9gsHmArV+zKlGWHmroPoJCBJdlUGsvjmd9FZCliayDlD6
         1DENz9pjRTYl4PTBKAVykRiUixyzRgAn/dXFUIQt/Qf5BMWlYBnHdVRTA1UZhhv4WOas
         ZXeorJV26gFDEELq0xBxduJhBScf6FUOq693y23pqlp6YzLEngtpb0apc8G6Ombq11jo
         9VOzvaMVU6r/eDEWPVqmXeVmArVwDoRHSBYLx0o8c50mhYB3dVRws7UuKy0V3P97EWO7
         MyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772113650; x=1772718450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXgomWElVazrS+pgGzXlQmTGODCBOPROHKOhICyfas8=;
        b=cErvpr8bP5STXKTR6OqjX1Vhj28mRtPRmpGm7RnFtv3c4NIEW4zgojkYPmHKoJF6jj
         xwqsOdweH070nFmAs6Xlbqap2PkKlvSqxidbgpCi26z914Pvy8pusOiOBu2jMDjbTLu7
         gzxpjV7t0YGqcJ5ahnn9GnS27lVxARNMtK4X8LzqXIjEBS6X+voAC+UfsWBaJ+WcDnpD
         wz6Z723G9DsovkiPtzvH/kIFnpMukCXzT8L9dcJsee8L0UopUy+iBkW6vOVSj8KNUevH
         h+f0/eGNTsl8qmy2KNI8MSpNz5KAMxlcwDpmgoUG3xQN/IQWfonYDeUWf4WG1kRg79Fw
         EjCQ==
X-Gm-Message-State: AOJu0YwJ9G3PXsl94r5DgTp17MLfQY2JW+KEA1XywKfAu35SVF5WAAZL
	SSRq2ksY6oYgvIY7QW42kuuuPAKLQi3Lc8ff2227wzvMJr4Fwm6wNGyU
X-Gm-Gg: ATEYQzy3+rcWH9OC1esI0fmmJQSG7+QoGXriPmEWzfbM1Klyj80OKg0DcWV+t8g0SL8
	yLAL4L2izUZUMd8kxtF7o86sfS5TqjYikXRbJFJXNuNvRXXV3dPhDROgt9askWdBML5OmZmHoiG
	iFne6SlGyaF7KUSoSjypLXQizasPkzYcBjZfqOCJD4KABUd+FdHOEjkNooonVeyO3dOuBf1FuPS
	EpLGn9M7dV66Ltclym+SgOOnIuxH4Jx+k7toi84JS1KJeNVfBbKKpNtDFz6eepXo2TOn2+fLVsP
	cghDx37WVP1JoTB+WmtDc3QuzHTpzLbL2mJzxP0/utKEpb4K1rrexK7m1mYwxqiFJxvNT29WSTV
	8LwD59+R2tIGSGQZmCGZrJMz/k66N5TV3yPoTodUDYp7fyY+bONg7op1RpOZH1ZUVAswjtL1oig
	f3qeE3obBiWdJySb1qB5E9GxZjZakkAhuGydK8MiokJ4QwM8h5cNsHfi8Hwu4WWr+9MBy2JGHRA
	QZOG3pYxBTIVgZM0FZYsQ==
X-Received: by 2002:a05:6512:1251:b0:59e:62b2:3fce with SMTP id 2adb3069b0e04-5a109da219fmr931481e87.25.1772113649961;
        Thu, 26 Feb 2026 05:47:29 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f3016de6sm6081741fa.38.2026.02.26.05.47.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 05:47:29 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net
Subject: Re: [PATCH v29 2/2] status: add status.compareBranches config for multiple branch comparisons
Date: Thu, 26 Feb 2026 14:47:28 +0100
Message-ID: <20260226134728.3725-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq1pi876p3.fsf@gitster.g>
References: <xmqq1pi876p3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> You do use enable_push_advice twice so that reduces repetition a
> little bit, but other than that, I am not sure if the above makes it
> easier to follow the code.

This was orginally abstracted because of feedback from someone else in this
patch. But I update it now, togethe with the rest of your feedback, thanks
for the help!


Harald
