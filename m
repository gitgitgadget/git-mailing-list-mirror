Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7313B5B3
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905267; cv=none; b=oxF1HFjrx3fkqmnefZHPN2es5dYsY405u5V4eNQUe2WTLVHaaUO5RwDrz8R5rNE8uKO3omcL3KAAMRRGU2xlWPyc7tc8iHXTXj2gWlQtPBI08iLndiZBEysWUmJo8XbzXaWNOYLT3e0l33pF7dKqi4BCyYW3Z9dtR5upV2XMwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905267; c=relaxed/simple;
	bh=beqLdTAXeQ8ka/VL4nkbKwC0Nk6Wy7Js0Us+/m/HDJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5VVf1pL5URiXrwO0+uqE9KuiifBWTPfZj9CAarlsLRhj5J6TrHnZziCSQzpPg3bRsvR7wvWof/D8rsD+kfDVROaJS+//OwZtjsmWgUtEngPJCIKd6udCpIgpGLaiQdNturQjs8r9HE2lK/AfUvjI5XqSII4RGMUlsIcgqlwNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=bHLno2Yx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="bHLno2Yx"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e851aebeeso29786567b3.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 18:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783905265; x=1784510065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8IGF+oJUp/h32UUkBdhW7BkEGyqQdTLT52x94nVHut4=;
        b=bHLno2YxIsQ2A7sxCTT4OKemNtYdDfW4xtpsBLZsMSjmGse8EN2BwE8/Y5fEzNjNL6
         WRTXpUMIUcxKNN1Xo0IYVJcRcFq1vOQmKqkUFyHGPWrq8SVd7G9HrlRYto2IUAyYpytS
         bi2XuHOWnsdv3eapqRrqWF55yEAFop4ykx2WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783905265; x=1784510065;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IGF+oJUp/h32UUkBdhW7BkEGyqQdTLT52x94nVHut4=;
        b=V0eoygdif8bA1A/jyH/6pEab9ygbv18Hctr33suQoJSJChT/ZlVONoS+qHgklDdher
         XAf/JuGGzLxmEhHxFnIkZFa/SmxwwDaqf/TZ+wFYrnmWP8xcqzcfuJPEvxj2up/TxlWf
         gOKIM9zgd0zp5m82KkK9C5WjB9l+NVZjjYJM1pgLiD2VCY6pASlJR2RJP0+NJ+i84YLm
         Sculw4yaVW98exkyNzSsCjzpgbfp9ryTwKtYc7TBl8fbkDQgakNMYPmJj4Uq3AjKCWl1
         AfRj3iAyDG/5AWXpUexbe/WkNT8GwXlzk9G9PLxNQALRr7wON6GYOVnMSoHHEhCJgFJG
         ciSw==
X-Gm-Message-State: AOJu0YwQdR9e7sk1f7uHRVBipqo9b9OgJUXJvEB46Ie+s5m4ynta1DD8
	qjoEvLKrpGESA7JN7ClSnlkt+E7zvDLVnuTcIixQQm/zbSs85v++H82vmBKcD7P/GeNG5Bdvh3t
	r5Lvp8ipVxQ==
X-Gm-Gg: AfdE7cmMLkqOOXzKJlmvqVTdHJItKi3zr58tppfa46Ap883FvZIUnM1NP1zU1gEwOl1
	u2nI2ncZHaEWgJaY5WHClboe1YXYlVn3etDYS9R0Zrk2FmuRq93wVxgO/mOoKJP0WsjTEVe5X6w
	sMUoYoCyQir3zwSkgvespik9AUlKqBPUZ7V1AfOcQT0PUm+EQYP+u7O1ntEZab8s+ODLdZFt0v3
	yPW7+/xwHDHVQHYJWoHVepoRYxQZd+HpPowZHF3Fb9V9UYKacHCxOnfNy8dEJ8D1YYcoQV+KTpS
	rUEoNrCF1Oy47WzDeB+CW/QbTJrEfJoKdNDfJytWrPs7LCTZ48OEuH4FS4EnujRB77XxIw2IW6e
	s7BSSv4RI7OGIfd2PLMG6SCPT3Xt96zFse8zS8+ZFJ4+vwnF8668PGDrYGVzS0kSVLHh8nHwYI3
	5081Ruh2fwVvysX9p0zydzxQ==
X-Received: by 2002:a05:690c:670e:b0:80c:550e:7dd3 with SMTP id 00721157ae682-81e900eca6cmr56809827b3.44.1783905265066;
        Sun, 12 Jul 2026 18:14:25 -0700 (PDT)
Received: from com-79390 ([12.187.141.7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be98397sm103095537b3.6.2026.07.12.18.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:14:24 -0700 (PDT)
Date: Sun, 12 Jul 2026 18:14:22 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] send-pack: introduce a `no-ref-delta` capability
Message-ID: <alQ77hSJw4VCDBl7@com-79390>
References: <alQ7U8TOWjhasaWk@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alQ7U8TOWjhasaWk@com-79390>

On Sun, Jul 12, 2026 at 06:11:47PM -0700, Taylor Blau wrote:
> This series teaches 'send-pack' to avoid writing `REF_DELTA` entries
> when the receiving end asks it to.

Hmmph. ISTM that my scripts for sending patches to the list somehow
broke the Message-ID of the cover letter, so the patches themselves are
not properly connected to this thread.

I'll investigate why that is separately, but in the meantime, the actual
patches may be found beginning here:

    https://lore.kernel.org/git/alQ7WKITYDXfiVn9@com-79390/T/#meaec3602fcf2e3c6d05f7248239c1b167a1e6ddf

Thanks,
Taylor
