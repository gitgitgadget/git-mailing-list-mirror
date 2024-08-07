Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37438848E
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722992750; cv=none; b=Z7uQHqGnKDIQdBiuU1LwWR8AIzO8r6r6Lryt0SBKwv8oxY3lotCGr+BdJQA8pcqlLcNFFcOTsk3pCu/Ycok0w0KUbSlbyAcU66rZwxgfMqhzV7goXSGQ0IpzNSAyBEFXdXEpF3ZFTAZS+jx0npRs8mQVIjh8md3jn4/EIfj9h7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722992750; c=relaxed/simple;
	bh=PuJVn/0oGb7DUb26eWfnKs1DtmifBQlQGyor6aI9lUE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SRI/OfVRFKp/wkwBbr+EeOqPv7csI1cha+eNWPf1sgkEEX5Px06WkD/l+/fb9UjoHzNC5NSq+8qGaASyznOTE3ha2eRwVHHhb7iFFJUs7SDKD9chVIsWktPKPZwIT63zPTAI5nRqO+M3/P2ckN2yv3644IVNcwWpZpeO38ncyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=memryx.com; spf=pass smtp.mailfrom=memryx.com; dkim=pass (2048-bit key) header.d=memryx-com.20230601.gappssmtp.com header.i=@memryx-com.20230601.gappssmtp.com header.b=obRucKYM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=memryx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memryx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=memryx-com.20230601.gappssmtp.com header.i=@memryx-com.20230601.gappssmtp.com header.b="obRucKYM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cfd1b25aaaso904661a91.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=memryx-com.20230601.gappssmtp.com; s=20230601; t=1722992748; x=1723597548; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1DvpH+mWW5sgAx2Z+WT0EDE/H09ujlsXlKo8RupKqnI=;
        b=obRucKYMkoDqt4xYyGKdiEC06sKsCyT+g6qsihwzKWIIvcU6ifMyY12JOUDj0N0abL
         oQCpr3tL7n0aHmYA3nsYDePlFTCJtotlQv5EVpyaHFRDzR6NGG23A8QTvBle5q8e7Itx
         hAiGMCBmGhkkyIsaDDJIo6zdhsSez2yJVHAJlZs7iCqz6cFPrb07O7KCfXc4HMj/5qt1
         DFqpyNgs/lxvKkK4loAubwhkX5UJIux+HXxBN8l61ozrRaoKEaiKMnomJ/fv6fr8E3RU
         LUr4dN92pciyjHk3kWVp6ZOluv5L1qNUhPRq3OLvhrfCc0xHNGqMFrztlphpkD3oiNM/
         CyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722992748; x=1723597548;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DvpH+mWW5sgAx2Z+WT0EDE/H09ujlsXlKo8RupKqnI=;
        b=Uy8dDzTsIC99yVIPlcno3VomOM1YUCMQdOdkUVbxOAOWIGkeTJ9bjE45Be2swThLZi
         uDl0YPx0R7vse6caZfx7rMAb0mPtRpYlJbi5pMy8sFiH97ECTvsX2TOhIrXmTFYdXlQy
         DwsAWR/k/Pgoa7gE4yjcpa6t8JIiIDmVU8V23syeb0UJSp2mNnA/skzi0baQ4KvPkGiV
         NuUiKOu/B9x6SL8kXa5/LjyXCpmzCCKQ3L7ceyNLgnXQY+hSbQtV8Zaq0zUokwgjKehq
         hEFdfOvN4PdacX33EjAlUP9i1bsoayG9XHEdq8VIg5VQWXB48FDoOGapeJxr/Xg1/jrn
         UU5w==
X-Gm-Message-State: AOJu0YyxSatkUQE8gkFixecN65xn6XiwAqoJlImdrNXhnj27i4VBpxmm
	KX5+oHy3iFvG+npW9c4Q3SiFUy5YMmljUNSRrG098K9WE5BzKiw1f8XBzDSjIXemPvDUug+DaF9
	NnXYdtO1wi/mhJPFBcaKjeYXW5pR2LCbFYedL2tQOud8qFQ7RXms=
X-Google-Smtp-Source: AGHT+IHoUBjczV/NK+cpwr6tlTvIrwI4uA8zF1wTti84qI6enct7ibtM2/yQhgdRGYYuze96B1OGYHW9+lVY3avC5ck=
X-Received: by 2002:a17:90b:19d0:b0:2c5:1a3:6170 with SMTP id
 98e67ed59e1d1-2cff9544afamr16415347a91.38.1722992748181; Tue, 06 Aug 2024
 18:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gene Rice <gene.rice@memryx.com>
Date: Tue, 6 Aug 2024 18:05:37 -0700
Message-ID: <CALS9TMOFmev0LzbZgxMtfkWXkvEJjAEKT8qf-vFt9yN8-o4nKw@mail.gmail.com>
Subject: %complete indicator needed on git submodule command
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

git clone has a very helpful %complete indicator that lets me know my
system has not locked up.

Unfortunately, the git submodule command has no %complete indicator.
My team has a repository that takes 5-10 minutes to complete the git
submodule command.  They warned me to just let it run, and they were
right.  I would have killed and restarted it if they didn't tell me.

Please add a %complete indicator to the git submodule command.

Thanks,
Gene
