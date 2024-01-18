Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3E2E652
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610617; cv=none; b=MmD+huBZ5/5whveKzq74qFC7rm1YMfJU4pcfHLOwBmZsa5I1m76D5sAGDTKl2p9RetcAYv/kuQqesrqKppSU5N3HdPX4bkczlfnQ9DyMHUfNMdiMW/pSipuMQf+POOugN7W1rIES2llWcf12p2D4O33lKCbsyA7eOn4iweeVWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610617; c=relaxed/simple;
	bh=3pmGpqAaeSfZBCxQSLZI2PlGQas/1ywF5N4zldfhkDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpM3kyFwOy24jKKoC3lMEq+IeyfOWRoa1N0LtwSJruSOkBatILmRllqWRxS0mQf2GXXYjlN62bcfIEhcNjdbCjxaiN2WZNR+M0xV0HeZGTISgzgRZjkwyDfiFB0Jktk6KUJCdD5FhmqyGdXJpW2QNxxii3P2qmlNHou3g6ARbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDFdR2CL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDFdR2CL"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6daa89a6452so99785b3a.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 12:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610616; x=1706215416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SC1Zn8lPxTHrHIDKbECXYOjdIyHE1zQKJY7I6w7J3s=;
        b=iDFdR2CLXurQRiXaE0JKYuCoz71K5TpLJvUP++mtyDBCAC9NwMF/qjANxewZKGlS5M
         6Cx3LaND+p3GvRgLI7WOnA7OCktDmMH/mqcqd7hGk8XWI2TFV9OC9jaWPpbsXzHvPj4k
         BtbwAgQ+G0E6HuMb2vMdDE6yHFV3dUfzLbxRZt+VGdDZZ7B8iL1rfpEvt8HUgapPI3Gt
         0olRHyXTkrQZCMuv4oOHT9T8gEq3mK1h55AJpu8+lePnNC0UCWZ2wMouWhwtyNDBG+iX
         W8UV2Oo67JqXVb1ZouVMKb8HUv5RjGP6XW0wZ62icJafs5ifSbcyjCmAdj1t8Lu9HXdZ
         i0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610616; x=1706215416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SC1Zn8lPxTHrHIDKbECXYOjdIyHE1zQKJY7I6w7J3s=;
        b=WPWta0ywfJqn9crYsHayAF2VwwiXzMpl5Efp8R+OvcJRoiBsvZ2Hre+2SeKYvkgmNo
         mnYPdXUItEafp8w/r4ovaFRIfY1Ou1Ok+guusI0S5yTvMxhPM7j43iHS//7jrG+uu291
         89DB/31R37lzDfXeOZLr5pZhn+zzFDeZxvSIuga77pREg3e2kTwuysw0fFNrYIModdyT
         nbPjRitm81tpGBIYZ41h2/KgEjkFo7s+DvEVcQAQBCtY0u6ZLWZE5r+alZ1Y5G8qAP71
         5evlmwyJP2q86C2yIYHrhluXlswnerGLoWmjlX2MUtwNanGwNB/Cmti80t4z0FdRbuZg
         y99g==
X-Gm-Message-State: AOJu0YzDkLYrAeRVtYPa5Azcwe1R7kLjGlheLpg7lWi3OwgZdnzoYMIP
	tLgLDkOyIl2vLFOUxhHPUx1KCdwYrSccCHP2AMeWYqh/Mc0QEzOA
X-Google-Smtp-Source: AGHT+IGDlMdkFENL4KpS7RxozFc1/npDwBz7sdZD+42dzvJTBAJyI5tczrzeUztvE78sRrVKRkADCg==
X-Received: by 2002:a05:6a20:e121:b0:199:a626:ecae with SMTP id kr33-20020a056a20e12100b00199a626ecaemr1472339pzb.60.1705610615854;
        Thu, 18 Jan 2024 12:43:35 -0800 (PST)
Received: from brittons-large-Vivobook ([2600:380:7029:85ba:9b09:b597:4ed2:ccfb])
        by smtp.gmail.com with ESMTPSA id fj2-20020a056a003a0200b006d98505dacasm3720173pfb.132.2024.01.18.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 12:43:34 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 156D3520273; Thu, 18 Jan 2024 11:43:33 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v3 0/5] completion: improvements for git-bisect
Date: Thu, 18 Jan 2024 11:43:18 -0900
Message-ID: <20240118204323.1113859-1-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CC to add: CC: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>

Relative to v2 this only changes a wrong misleading commit message.

Bring completion for bisect up to date with current features.

Britton Leo Kerin (5):
  completion: complete new old actions, start opts
  completion: git-log opts to bisect visualize
  completion: move to maintain define-before-use
  completion: custom git-bisect terms
  completion: git-bisect view recognized but not completed

 contrib/completion/git-completion.bash | 312 +++++++++++++++----------
 1 file changed, 183 insertions(+), 129 deletions(-)

Range-diff against v2:
1:  e16264bfb9 = 1:  e16264bfb9 completion: complete new old actions, start opts
2:  130abe3460 = 2:  130abe3460 completion: git-log opts to bisect visualize
3:  d659ace9c2 = 3:  d659ace9c2 completion: move to maintain define-before-use
4:  c5bee633b2 = 4:  c5bee633b2 completion: custom git-bisect terms
5:  220650f0ba ! 5:  2bd0cb26f1 completion: custom git-bisect terms
    @@ Metadata
     Author: Britton Leo Kerin <britton.kerin@gmail.com>

      ## Commit message ##
    -    completion: custom git-bisect terms
    +    completion: git-bisect view recognized but not completed
    +
    +    This allows the git-log options to be completed but avoids completion
    +    ambiguity between visualize and view.

         Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

--
2.43.0

