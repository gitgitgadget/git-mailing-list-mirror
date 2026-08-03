Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473A2931D0
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735371; cv=pass; b=U84cM9QGakrRs4q8ZuHWpHTlRLTEAWGlY+6xQ+lfyFph0O4e38uor62tsXrxVbvTDe1VIbDKFAAmv0zoUm/JHBxY7m2flbUh1AoNZl0sDkSQ3GqGY0wV7oS9OvwHfAli2W6rRtvOmexgnk9xXu56UVwpdnxaVH3W3jI3+11t1BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735371; c=relaxed/simple;
	bh=mmwRH+YZRIJAdgdIBILvQJASlcCNrdQgaY4Y3CCt9/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ByvdZZKX0rT5sYjzqqHQJwcNE5GPcrHk3q4QknwoKhc5QtLP6/XcOPReKAs3lb9kRUhxpcg0InrESgCqr2hAGMyTCI9IP2sXqY8VMaQfpDK1i2hsftwg1wu63vd9ORMv0txYTS1b0jbe02jjI3Q56MgS1odbPZgcjpOtNNYUvSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxpVcLhL; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxpVcLhL"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2653500a12.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 22:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785735370; cv=none;
        d=google.com; s=arc-20260327;
        b=bn9LD1WOF2MwQVMNQ2r2qHdRGly3y7TC9rs76iPJPoiPY8SgjLtAOwPQo8cIHq5cY4
         I4fkgz6VJ5G5xdpVeXc/mNebCUFZlJUK+EbrixIT8FlGV5v+JvlijiGfOvmVijyA3lm8
         CFe8t5sespMbNC9f6WGhmR1psr2KTw8RhiC0ruEwk/XDa7tp04WhqlTZS7dyCWas/zOl
         mX8s3K0ziBmphJVd4ctHKDtByUEFH4pRjksbA5Ss3amZ7sH98HR8p8pJM0a4RCJ1Jp6R
         3gO6JE+WCbVVLMzGJEAcOxRFJIGb/8DRzNtJmPRAeyNmh3LUoEz2yCQfZMhSDiFVQjln
         a29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Wk7IJS+4lOKdcwGvJxA7Mbnw3M9fzJ7OVWyDBaAs0Y0=;
        fh=uj3hgKb4TAgx4sCrmGNog0/CK864RvhBgwmK7GAyT5E=;
        b=GxrA+bMEMnFzus7Q7fQyR5AXGVKYjfO2Y1PCog6PP/RWjThZe8edlZ0RTOkk1msTzy
         Jj6EHFDk4CKyn3JKGHnmLb87SAygIEzLzvb/DdVh/+JeN1IMtKoHEQxCTkYblfjxP0fg
         korfNtxz9CzVIfZJFdhtu4wMfnRNLJaeNarOVIMRTzTQy29bXPEQiGK/0jLL5LpjD/0t
         XCMEfSuitOnrEb5Y8UhnDMMO0rYxsZ5MyyRIPmhujEcy1iP6xN6gZATqkStMdW1nUNuV
         ixhjOgSkvbCQILwR/c9T0umgTySm2/R4sDQ6DDpNCLzoS1WL/7AZQHuOg5nLbdO0jWbP
         qMhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785735370; x=1786340170; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wk7IJS+4lOKdcwGvJxA7Mbnw3M9fzJ7OVWyDBaAs0Y0=;
        b=lxpVcLhL9Yt0xVWkWyyAQ5u/b32+wanIz6X/2a1siw5XvRrK4dAQEi4Bp6JBrkOr8k
         q248xj+VPrNBW/uuEa71dRgDNfpc86DfFebX3MZ4+OUrJG+2NdRFsmHHmM4UhAQkjHFM
         MQPrtiLtAS9dyNX43m9su/YM0c8h3+st4Buq/OhIFY2JZg+lH18cNOBd5kUGdsAK9+fS
         sP5HKh4Uo5C7b2W2TTO9QQUntr+DZUF4PYaFoA0OAJ6WfcEhVNzuiLftVcZJYM2rpH1r
         AmtLFJ+mH3Aqz1qLUQRxsiT1mrv1fX8fD9AokwL3dcEx2sA9wg95D9r8GOKayqlFAFCM
         gvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785735370; x=1786340170;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wk7IJS+4lOKdcwGvJxA7Mbnw3M9fzJ7OVWyDBaAs0Y0=;
        b=Lqkh3ranWrHy2uZqYZR0xht9xWgbnUYQI/BwPtzGAQH1BuhZ+RWQFef4B0Ge+xW4xn
         X8AR2jeB0HP6joRocZojZQhYdauSjc/88vUdsypaPTV0kCqqPypcKoL0+saHGsOktXFF
         kTFFvFAjnPrfRFjjoJupt9pUtORA/bqkHW6veJhBhQPOOIbdAZUEL2VFO/PG9mWKqNLc
         3kTwuls0/GuZFy9M17S2Qy6dlH/UU585bxeTh0zH3CkhJ/3jRC2ODUW9FVNLWmv38zhx
         V3MmO2vsmfCWCBzPq1fg5LVqnbUL5Bu7w/BHxV4AwtFxuDP0AnyAuOLRlc6MIXT6ckLK
         Iw8Q==
X-Gm-Message-State: AOJu0YyCflxUMnlo/KgdKu8T7jO5X9zDPQ5HN6+69R7lWbLx1w5E/1qT
	A+7ZZ/V8T+bZuIod2SWK8TSt0+L9+SlpIm9D8v/F/g5Gt7CTDbaEeqjVUKneZ2em/chUOTXqmCH
	ZnrBnec4gBhCJbOcKc08z1FL9fmB4E5iwfYWl
X-Gm-Gg: AR+sD10pGUnaqbe3S5HmryIsOi2X8lJ1oNT46euFsYmxV+hVPfcJZ5WOUHkgBWgvpzw
	zpZ5qLB8rTs7nYS9GJmfcRSNJpV/MVRo2Pg5ZnD9vWAdAYmZrIKK7YqtdU06AfvMqmcJmYlUgEd
	subCruguXl6mbFhLkSjVv3bwStBkTBIWti47gFUUEI2f23IoNjP/yQLDeykAIRusmVkpbLe0G8I
	jdO7l/d12oynWCg1EP2uCB0qtg26LVURj384qr+Aq9MPSi+1NLr0vhXvMwt3QOkufOy3J3+qint
	4ieqqQ2DG2QMb2ECt3xeiCLjl+Ip7ahqtM62Rizx9Q5akIYXWBFRMWC5lsqQq/xdcxNEGu9GLFc
	jcuD5ZvpC4LN1cVIQ5PPuVb2+uREYIQ==
X-Received: by 2002:a05:6a21:2c15:b0:3bf:bfd0:2a11 with SMTP id
 adf61e73a8af0-3c92a8a5adcmr9107911637.43.1785735369795; Sun, 02 Aug 2026
 22:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 3 Aug 2026 07:35:58 +0200
X-Gm-Features: AUfX_mzyXtUwmYd2GdZNtl__b3skMmNF-wUUi_OT8_WgkOB-BpO7OHKa59jwrKI
Message-ID: <CAP8UFD3huzOo76ZyJesf3=AcbwW=pJKpQQUZSD_Tohhd4vFV2g@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 137
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Bruno Brito <bruno@git-tower.com>, Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

The 137th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/07/31/edition-137/

Thanks a lot to Bruno Brito who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/856
