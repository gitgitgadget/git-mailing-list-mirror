Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6A2E3716
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754010043; cv=none; b=OaDgV1N8FU54IEH6ENMbnPFnQQwKY1vKDJ9jIxsrl1fcZIj7RRF5q++at1+OQMviPzV2QLCuDjaaKvS0nGYMZPVm8BHrZnHon12ltv3Pf32695Q7VqkwME41gtJnc8M+ehNR6wAPlaZD0a4xVQgnOx0fMBwfuwzGsfpAonBSVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754010043; c=relaxed/simple;
	bh=4Ox9yxG0l1C9oduVmpVZGcQ7I4PLdDurdlqs+ufkDJc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EAfm3EN2v/7V78dFxJ2u4kWZqRyIbbVBjweMx1CsKROsuMMxJbQYClMpNpv7jLqyzc0UHytdWaw3j0u4caQoqfsQdg6a80KwRjnibuF1IA3JBQRULJmjiQhg84hNSec5TlNdnOpfHoALXs6ljisc9u5ZMzVKdMLkYOHhXXEWG2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBlWPxkl; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBlWPxkl"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31e41cfa631so1449615a91.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754010041; x=1754614841; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ox9yxG0l1C9oduVmpVZGcQ7I4PLdDurdlqs+ufkDJc=;
        b=UBlWPxklC3tmJo3iAdLspqrf+LOB+Ey98qhsWzHYvrMTMu5PzHeNNydOcAL8s+bHOY
         2MTKB+RUH7xSSudMgzWjwrweLQ/eXTEytKKGGn8VmzoeaSLA337+N2QqjCabqdhSeObT
         cfoZSbO8k9trNcSZRz1VOVrJM88SRvcpg3eWN5Xt0qVt6eDV0Dh1Pwg8pAt1Ly3uPyiH
         dfQ1uXAlf+FMJLvOW/qEe24ArdMxCEYz4bg53xcPb8qc0+FHajVTgf6L+t0Rs2VIXbkC
         FJmxuClnLZGWWyOBFrmhp5Xttc53pwuzZbaT/iy54yozgy1lLM4QzDZiB+uu1NNDFC0z
         wgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754010041; x=1754614841;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ox9yxG0l1C9oduVmpVZGcQ7I4PLdDurdlqs+ufkDJc=;
        b=g0aN7z8jxEQBzDH2eIAKkTsX5fYQ7eYOnD/IreKRq+xCmYJN9i40J/vg6qpTvmVhcb
         0fWgM5OWFzgPCiot/p+lskBUdJmWOiGMwCHHBQVZKoZEZA3fG1+4nvBl7YYGM2/z/3nJ
         zXZxqTPWmxO8P0tS3SPpL0SoUc0+DGLEdOD5it+Qz2IDdC0lAZGPdz8DjlucY0Iammk8
         u8jOusKjAorjSn/nTdmrzs52phcEbnXtr0onDfMLSLzxnAzWtyAVU/2YW1/oMEHk1z5K
         USGfe1uNnNDN66T6gglMJE2IFzJDR14xWJtclMOCaSsTQ4OWoCiyog9EcoAigibVLj6C
         7LKA==
X-Gm-Message-State: AOJu0Yy1YIegdAvJEUkSz3jpy+MzBhpeCetoaL1wnsvKuuI81sJy2enF
	aWfOtBnKpF0C1qE1lmZXo06R/yVqou6UHkMSfnXrKJeVHaSZfJNpzy6J
X-Gm-Gg: ASbGnctRom5F158kqHrQaqwcXbFZvMU+TCSJuWxjpvPH3S1qMIGdQL4tc8JUMaFSzjT
	2qM2oO0COfDwqwV3oZB+hraxWlVT9hzrW+cm6VHl/EGwFPt928CG55ur6pF+0RJfxLyoTVf2UiP
	4oqmSHZrMukHtVEaV4qpqzreouBJfHS4HPKKtFOeh58yrlhyo2d3CVjHsb/1JdQJeUturRaw5rv
	lG1Pt6RP52685IgEOLwFWP/yfbPB4ok15w17UwLyYSA+5604Ao9qp5tqcFllbSTv/Rx31DB0urL
	ZbYKpkDCASpx3XYewQUk08cOt37sgqK7WPxsVb2Cb+C5lqEtiFxwfr9w892poB/EC9eqGxX7qDY
	Esws0iwqu9gJ4hQeOnCd1Py0bwG5JPmPmkXnTbkNIhuH8cktfsrhfTFQ=
X-Google-Smtp-Source: AGHT+IHwyqwPTn1U19fw1QBRxjXSKg8xVHp1HK/9DLpLpdw51mNhvpZ+S7GQ4q/8iG1WJOyKt6rjXQ==
X-Received: by 2002:a17:90b:528b:b0:311:ad7f:329c with SMTP id 98e67ed59e1d1-31f5de4251cmr14950290a91.18.1754010041044;
        Thu, 31 Jul 2025 18:00:41 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8c1d:9856:3844:bdd1:13d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6ea6sm3085212a91.19.2025.07.31.18.00.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2025 18:00:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Draft of Git Rev News edition 125
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAP8UFD1gp0mT42e+UtbXLy=HCmVThNd_g4WbWBNTShgzCPtqJA@mail.gmail.com>
Date: Thu, 31 Jul 2025 22:00:22 -0300
Cc: git <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>,
 Jakub Narebski <jnareb@gmail.com>,
 Markus Jansen <mja@jansen-preisler.de>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
 Taylor Blau <me@ttaylorr.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Bruno Brito <bruno@git-tower.com>,
 Aditya Garg <gargaditya08@live.com>,
 Julian Swagemakers <julian@swagemakers.org>,
 M Hickford <mirth.hickford@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Erik Huelsmann <ehuels@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yao Zi <ziyao@disroot.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Patrick Steinhardt <ps@pks.im>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Message-Id: <1AFC4D27-9D07-4332-BC57-387D2B2D11E7@gmail.com>
References: <CAP8UFD1gp0mT42e+UtbXLy=HCmVThNd_g4WbWBNTShgzCPtqJA@mail.gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

> 20 years ago: Meet the new maintainer..

Wow, it seems like yesterday that the rev news about the 20 years of Git
was published. Even though I already knew that Linus was the maintainer
for only a few months, those "20 years anniversary" news make me really
feel what it actually means, and how young Git was when Junio became its
maintainer.

The Rev News edition 122 was the one to thank Linus for giving us Git,
but now it's the time to thank Junio for maintaining Git since then :-)

