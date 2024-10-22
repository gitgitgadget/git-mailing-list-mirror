Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597619C540
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607602; cv=none; b=evZJAV3VncBf+ei7FFvVKz8dhGyTokxu5XkqPLLK71hEJ4nYRljEW2ZEMT6ZxFLaOF+sEaqFoxIMwpF/KRZf7B7Yh6pYpiwfEwgUtlIpW4f7KU8s73Ls5F8wyTPnavdtVxWT7VqdI3y0Js7meYS576QfknCvnE5BRaUOt+JmtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607602; c=relaxed/simple;
	bh=PGfl/pcWsn+tNVGBwE5hWKTq0mJT0sFFL3iDBEJl5w4=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=Cn+XVK5T15QRcIHKwbTmbvXPNsIoW7OdiHjSXB3Nxk6EL3+ARNl4MalCGW7FDnm6QQ0J50jNq6X/Gphv9WMlucBM25KfbgOvAosd35XCIwwhnQJ/0fNgMbQNri/KutX9Ab5oDhR9ocMA2OlFEEwsZY267IaONpcbjDT3PtKyfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHWE4EbD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHWE4EbD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so56992665e9.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729607599; x=1730212399; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGfl/pcWsn+tNVGBwE5hWKTq0mJT0sFFL3iDBEJl5w4=;
        b=kHWE4EbDcwb/f6yIEIX+uKBQvKiCWRsd0S1dTbNopxqA1zxiwtuzA8a+FRiRTkaXvI
         HhupC5fj4hD0lxYQIlJj+d+pOhcOUaUkXBWaOz0DkDc1nseNNYqJgS2VY/5fMnuWhvmq
         6Ix6JYnFBwfvcS3f8Za+Xsh3oRPvmTiHt58qTlWMnF3IDmJpw+o21fm+kU3CVRl/1odI
         R7Z/LEZbrCJbmz2HY4H4AqvDPGK6UuIayrcwDT/Quxo3fGAxcNfuSnsRIsn4H5kcKnuI
         PHLoRq8alThrTIjHWROQLnuifpx0pc6fGR2CGJmqJktPh8YrTybYlZN0ewTfXCdjh68D
         /bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607599; x=1730212399;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGfl/pcWsn+tNVGBwE5hWKTq0mJT0sFFL3iDBEJl5w4=;
        b=biKRsS0KrQl9B1Q33Gp9h+wJ+5CqdKLxJ8laF4LwdDu5V3vd7ws0Dvjj1jfgNgz8Or
         ExbROvvTysX5rgtw6TDojsE7CQjm085wimxsNUUB6kuBpTZU6WcOmd4q156hVsluYXBo
         a2CUY/fOR4/j/xQ7d0FoqZPLut1eJ8G2kZRfOoi+e3JOdkd2t3h5gMSJY9kNdfSaPD9X
         nSJZv1DOleHG4LW/zWi1097jInWV4JbT29AcHB/zx3u2O2MEM8a3P+Ec1R/lMUzOdNtr
         ZmfISzEGzhY7nvHqgK9p/kD9h1PuQ7PKcrT96rOVao/Q5C+Cuk8/4VsGEOykgtVJqYL+
         AWTg==
X-Forwarded-Encrypted: i=1; AJvYcCX9iqnWvrOv4A1yFkckVFUveOvR0YJqEne+0SkX4nj0LAW+oLXPC0q73uK+HWvUgmxnWQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yworc7lnfvtPqfDQYtxi4wRe8yosttl/1lA6T0H9N5AtiBEQ3HN
	8JhPLksd7E5YI38PUhlBUip5VdnQ407s1hCkkUNlmHOCcx30+WoD
X-Google-Smtp-Source: AGHT+IGJR7E3GUkMUY0+ckqeb4vmkgwC0hDvzyNPNJykhz4gZYUuXmPJ/7ZGsCbk5X7Uiq5xrffTXQ==
X-Received: by 2002:adf:f84f:0:b0:37d:48ec:547 with SMTP id ffacd0b85a97d-37ef216a3c7mr1904450f8f.29.1729607599076;
        Tue, 22 Oct 2024 07:33:19 -0700 (PDT)
Received: from smtpclient.apple ([105.112.228.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b944f0sm6803611f8f.77.2024.10.22.07.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2024 07:33:18 -0700 (PDT)
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [Outreachy][RFC]: Final Applications expectations.
Message-Id: <C2266BE0-0C69-482A-85EF-854B2812BE81@gmail.com>
Date: Tue, 22 Oct 2024 15:33:07 +0100
Cc: christian.couder@gmail.com,
 git@vger.kernel.org,
 usmanakinyemi202@gmail.com
To: ps@pks.im
X-Mailer: Apple Mail (2.3776.700.51)

Hello Patrick, Usman

Thanks for the clarification and feedback.

