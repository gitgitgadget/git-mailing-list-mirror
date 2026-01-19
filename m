Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFB2DCF74
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835058; cv=none; b=tX7hi1zzs5b+Pdmix8RG+ve09qUfN8FS9SbgU+WO+rIQv4WuZi2usI4/2Ezb94qyrpKUOWt7cl79Q6/cvRPiIBhfvnqkNio572E7e3TwvIBLx1+67Rz4gnW8K3dV5J0xiUPnWbtSe5ERTHJGQPYmTnfE4y7rseqSgYfrBwOsPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835058; c=relaxed/simple;
	bh=9VOlCv3coMfvg1nwI9o8dYh6IX4h8FXC9mu0Qn4iR0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrWoGVW6gwKAPNUCVSCVKbvhLQfXmdu71I6FBJ4yP9cgzLXpmfJNBNbnRBUPry7pjbWTCdxZ6aGFCaabDzpOTL3tB/xIwJt0YDfsoZXBznK1wEpRM9g1BtM/J32N0yH1Lh5y1itqi4q9CzXYi2GiFqivE4E0zFJ4YZg/Q3758i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHuSouDw; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHuSouDw"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b67388c9cso5435004e87.2
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 07:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768835055; x=1769439855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VOlCv3coMfvg1nwI9o8dYh6IX4h8FXC9mu0Qn4iR0U=;
        b=ZHuSouDwkT6+VadE9k55MGLw3lDpuUpNYN9yI1gHHMZ9ZeifXraWNBbMTK69/n/H50
         hWZK9+0MfKox6hzYdb1MP8RDUmGYe+3heQL/JGToB7gsP+UrzQmQRyAd+ofr5EPRyz+N
         wJakFZKNuHG+MvQZwKUUX2hr9nCefE6SmrUAoWgYh4Jzd1znkAfbdtJKEPj409/unPWy
         6EiHoAzVm6k+bL7NAmxyrHV4VRXu8jne8LQEhCT/OXlE10R/BPk4/7izfQ6uwJEnev40
         FUsHiAReJ8imD8mSbzp4x1ptvjhzRJJHiyIMeN6ks5DSy7+LUmsmDXqcFIrJIkEbkJTQ
         67Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768835055; x=1769439855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9VOlCv3coMfvg1nwI9o8dYh6IX4h8FXC9mu0Qn4iR0U=;
        b=rzkOzpzgt3cUgv79eSqSFKJlfLkTzu9WxH/6kYSYu9qQVNA02Dob5YR44IYMfz/aLS
         TXPvtDcKDsbqAX2GFBe7PmNHPFnF+EKPlAvsWp4N3nbv5Tgi9g72y6qrtlCSbRqkTALZ
         9DGukopa1Jn0v4GfpHBd7D6GNt3mONDjb4Kys1U/BOJqSzMHN74EcmfhvJruP3ddiAmC
         9EY86yGo9hnTyfvuKSQTodOdwEtc+LFJnBExZu7V6i/TdsH0fYBHv1yEWHvJMJJnONzt
         PraNMjK2O9Ds5It9Zq5FYkvWNDFcSYXhU1RRYf4XUkJQ1xriYkII9Rs5r0cJntcd9Lqc
         d2yQ==
X-Gm-Message-State: AOJu0YzqRs8srzJVALWMJQ/2SquhHKICJ7GozNE4yioYe+U/FEHdIwPN
	kO7jRbn56qcwJJEnynF1KVmgafON93Pk6NuXIgNwtmcMz/KP3qTicQOJ
X-Gm-Gg: AY/fxX7b4/g8HNXMeyIGnbiWcDJZfnYm6pkAXiThTCeAo2QMZXmuCHieurUirzlP50B
	RomJq6RyeghQLbb1dUPVVvlInSZRk9dongN/NJNe/pYf/fFSkLE4yV6hvWTS6eTALynl3qy5iSD
	ovI5UUOl3rzlcK112pq+OqBrCf+atQW9U68GN5wkFaS80K6ggDpqJI8KhQU2gOwzHcpgDh9aJJg
	xb7lKEN1COq2GFlL8cNGSWeDMGre76uDQ/05rr/DyazXYdOUzICpQw8chlEFb0jpmB1sygrtsvD
	kaqf+0dCXTdetyxl7JZ7g6agI1QPMcvNsiQcXqHLgHszhIaY9x0G119doDh7G1WmaIErXjFZMqH
	53DPO3IjHNNVWg1jDdg6+oEQj0MKEpPBpTt1T7hC7T8/FKdFspx/VBx33UEBcmSM5nNHZ3o0ZfJ
	NNFLWYYENOhiU0WM0j9NZeKcIyPJTa1maqWBVUSWiYEMqtVHXAiPDvAQMXbybL6IfMlDW84HuZY
	u38NzFO1w==
X-Received: by 2002:a05:6512:3e18:b0:59b:83fc:e584 with SMTP id 2adb3069b0e04-59baeef7ad6mr3680885e87.30.1768835055016;
        Mon, 19 Jan 2026 07:04:15 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf33eb76sm3465210e87.10.2026.01.19.07.04.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jan 2026 07:04:14 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	haraldnordgren@gmail.com
Subject: Triangular workflow
Date: Mon, 19 Jan 2026 16:04:13 +0100
Message-ID: <20260119150413.37807-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119051858.GA1991308@coredump.intra.peff.net>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks a lot Jeff!

Would be nice to get this merged ASAP, so I can continue the work on my
feature without the memory leak there.


Harald
