Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD991224891
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110939; cv=none; b=tB1IgqxjGIdNc2ud2n3mrR+DNEZKjZ9EjCYXM48HlOkt+3hxGglor2jffJghmlMTcoqT6HcMHe3yOhXpEKkFYhloy8GfZqI+XaOy1WWktrzZ/Gz+6sUX3b4EQeVDenFJi98lib+HzQI1oLu3L8hBowMnVwaFr4ujd7DpBlT7NMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110939; c=relaxed/simple;
	bh=6q3SjDloWL53WFvyyXlXT5osRY1w+7688NAc/VXKNto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFex6nSPIDS1BiCPucu5V2HhdfuaHo1U3JBZ8d6sLeAhVCBLE1Z2tu8vDiVWDB4qFzwhtqM2JNg/fqWphPwF4kzjtZcfnVD6qfoXpzvoTP/aAiqTACNEFqJB6yEjaZ41cEE1N6Szlm6b5vSpd6hlfZQiKJhNTz/4J4jeQK0SOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzwsFoAT; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzwsFoAT"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-594270ec7f9so11062368e87.3
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 08:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767110936; x=1767715736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q3SjDloWL53WFvyyXlXT5osRY1w+7688NAc/VXKNto=;
        b=PzwsFoATqQTE92psZ1b9YsOrWjHGegkgL4lRTatqTA4M4tUgCmogMe9bT9u1w0fkTz
         HM2A7GkvnC5D9JGNiqvHI/MRBWlvN5P7Y3m6GZlzKAAd+IL8Ws1/5uvQ41IYl4RfyN+J
         QN0I07CpSEWsqPYC6EcpFOgigRY9Htv9YVWGCYH68f3ZcgQ0Rwsn7R6TSeTLpFY168LC
         xhe7f7QBGUbyymFl0efm1hehTsqMHCflZ2aDeNloLXXwUIFJWVUsUZmwzr5FSZkdjV3Y
         TlHJskmZKn//yqWrEUr7EJIUTXO4vNezFxdnj3HPxqErbcCjyeKqizgI2jzMO72Acp+h
         kGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767110936; x=1767715736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6q3SjDloWL53WFvyyXlXT5osRY1w+7688NAc/VXKNto=;
        b=ujDkVQr71FXhtIxMhkH9SpiCDDnDl4g0YFp8Uz0ZaDkWOP0AQUWjSg+fnNMZ8wSOxy
         2vz6+8qt63Z/Il1dTsKeRLl8cXeT/XICNQSkZu9vFW/hL60Qgt+m9a9MR+HqBEjcd3/L
         V3il8W/29oOJHXalAjWvayoMyLqpqpDE9EdIe+qwWCd2O6n8uPeie2ttQ5yIhB3eZqF+
         heAHwg1qiirjPu+7RZZrUkOFdz3eqpr1TCdDmJC62y9/mTcbC8gk8lh0jPMtBaA+1RZR
         +Vd7iQB0lBJFFGXhZRHFn2Xe6cwOgnA/I5Wl37afd2rt5oR9LKjV8tFlPERboCU85bZY
         9MbA==
X-Forwarded-Encrypted: i=1; AJvYcCVHKoMF2XovMm1nt8BB8mVJvrUm1EmGx94EjA6UJlLrpN2HzsgSN8sRzBj6rx4/0HRkuLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxl+RdbjXJJZrUSrpvrUVi6Y1BZXP1A1opaE/I07kfk5PD4/tK
	YXNvgznWnKRKZvDy+XZrP9eVxH4tukGsFgGtjhlsvUozME6Vna4dlg+O
X-Gm-Gg: AY/fxX6sLrHVVe7DP6ndhEPxYnF2dJIh3mpgj+8frVzQQpxzuAI7XZ91tnKZjuzRnB/
	KmIMZ1wN1M51bvr1slw3UgUiCK8P0soNB292zPDyHSx/QwS3iEvOVAplzQ8HVhCjmHAbMp713sF
	DgU/gVcQIvVV6XpCsAXQHKeBp88jxuPkQ5YVLPRAE9+FpdupB8xYyAMaf3apcFfHDh//E5BZ8FM
	U4r290lut0WC4Ry2KxuQQ4S3NV20GQRn8esRavH3Q/qqkc6leZCJ1+pMdesbwHR3ylZlWHYDcWa
	pgruI/xlxhLSpYsDqx+1T6I709A+jwioPVKBduNQvpXoyeKOEvbVJXZu9WeEtIypu5XzyPpE/t9
	OSRHFxwvceBuqdErwCXXn5kKiQ5Pd+5dP7HXtjvVwlqWM2uQoVVH7g/z10LWyfCWDsnSYA2mpxv
	qvI7so7P9XTjL6vNzBa7OPRMr9q5dRy8QP9bQqZy8/IYIqoYHjuH7Q3heXn95bxAO66EfpDoI=
X-Google-Smtp-Source: AGHT+IGXtR+cpB1SGZ9TWVR2Oxa4fmNHz7oH8a5O7Oo5aOgzC8gk3LLFdH1z+5NfOkHi6CNquanVEg==
X-Received: by 2002:a05:6512:2388:b0:59a:1357:e449 with SMTP id 2adb3069b0e04-59a17d5a573mr10928872e87.42.1767110935651;
        Tue, 30 Dec 2025 08:08:55 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5db1sm10477330e87.18.2025.12.30.08.08.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Dec 2025 08:08:55 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	sandals@crustytoothpaste.net,
	ychin.macvim@gmail.com
Subject: Re: Code review?
Date: Tue, 30 Dec 2025 17:08:54 +0100
Message-Id: <20251230160854.42862-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqbjjijt2u.fsf@gitster.g>
References: <xmqqbjjijt2u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

I found a way now to eliminate the config variable, and instead uses the
push branch when it's different from the tracking branch.

Let me know what you think.


Harald
