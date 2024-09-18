Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BB18A6D3
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664891; cv=none; b=N4qtRXE29TPsF8X6HDzUkUwdaO6yRZttS0Y10+buY1sjTLGQ3yfhEqJTDbWqCJ8jw294zgOqhApYgmu0F/NFPppuwONieE4JVA8GEOEOIuUMT3p+E946Le+DfHM5URqZOLEJ/gkemkFVlJbV+uzd0/XyDfvqsCVfoIUFwz0ZHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664891; c=relaxed/simple;
	bh=+yIrzzrzmrEEOqKk6MbdbgWZw1rGKamAbC818WCJORk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+U+mB6Kpuho8+f/f2hdgr65/6ZJ00U/VkHlXHCuBP4hbSm3yo5VCb5X1iuYS6WpadRaNVdYvcQTkbL2UIdydMQZx4lna3J9oK9LgCfaCTZuzNMAv393+QUjq2RgA8MFyPihqxvHdB/EocSGyxE0Cvq86emQ0hdBoX/Ygob1WpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIJNyqdg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIJNyqdg"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c44e1cde53so1972442a12.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 06:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726664887; x=1727269687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yIrzzrzmrEEOqKk6MbdbgWZw1rGKamAbC818WCJORk=;
        b=lIJNyqdggV/Rz5Rq1yMN+nHIoTet2PI9DvIzhyzNVOpo0quWPkTeuJMn5hkVODM8iN
         yxLuZ7RWi/zUYeSZLonu8ZBO+azQ8rKYP7n6sK40B0kcPl4srlOcCKfq4uY6XenBDFGD
         6+cxzdJ0/VfOse4b1tI0QkGBs78lKxMPYliH6c1rxWElYe+AW/tOeF0UKhmAsrFMesO3
         RycWR0qbJEAbZQPZnnQBFe2xCUQdyGynDSFxzdw3j+uVf7qHP6+KHHrqP+yyWfRo4UPq
         djL1SEzcuLdBITEgj7aWi708zgbOUD80/t8D6nNOisj7HYT0CB4jCin4FfVhQ+zu2Kjj
         YPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726664887; x=1727269687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yIrzzrzmrEEOqKk6MbdbgWZw1rGKamAbC818WCJORk=;
        b=meOmhB08owhSjtVl1t9G3WuxvhtK/Dic2YuA4yA2Ox+p6YcYpaSE59wI2t/3QjRl2+
         7/7O9gGoaT/XzyXzrYp7uZMCJxFprhkKzkXuupveucyqSSIOCk5uTrxYDA32BhMWiqvG
         FtDpWkPCUCqwuLdU3qpizfq3DFnvEVH+1wyfRjVxxycH/Hrw2XJM0aJy1AgfYS7YX8ma
         ZRv70B+YdNsEoFw2WSU8i/bqn7aVJ8pCNM+HPRgLBINHxe6KXaX0UjmPS9TLfehBotnc
         xml83ICs1Pxn+UpD6qVHKmliXLXKSY/Hos8XLTCrQ8zPd6X2CXE/Dl188NxryPXve2rG
         Wkdw==
X-Gm-Message-State: AOJu0YxLYY/1TkN2x8LZb0bYvNH+6pg/N3YfUt1SugBRrHX3xi8R7ssI
	SP9ai8Hqc5Y6hjlqk+6rQzUgr0CVD+klWcp3vlT/Qqvu668UZ6KKKNKfFDBShhRuMUgdKU9pbE2
	JT2YM3pcFk80KFxk9+TpoNRoFbls=
X-Google-Smtp-Source: AGHT+IGVie/q9golsObXVWiZn5ADNy/qe3wiAfxlOEquOOhf/EgbOtR/AZ+GsRlGF8LCr8/tveqk3DKeO8PYDt2IlaI=
X-Received: by 2002:a17:907:d859:b0:a8d:555f:eeda with SMTP id
 a640c23a62f3a-a90294a9cedmr2156851566b.8.1726664887106; Wed, 18 Sep 2024
 06:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurNce+1IZ68WT+/@nand.local>
In-Reply-To: <ZurNce+1IZ68WT+/@nand.local>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 18 Sep 2024 15:07:54 +0200
Message-ID: <CAP8UFD3K6BvWs0iriG3RQP_2yY7+bc59wdwdwz9S_VLOkmU7sg@mail.gmail.com>
Subject: Re: Git / Software Freedom Conservancy status report (2024)
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 2:54=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:

> Last year we spent money ($675.96 USD) sponsoring Christian Couder to
> attend the Google Summer of Code (GSoC) 2024 Mentor Summit. According to
> my mails, Karthik Nayak also attended, but I haven't seen their expenses
> reflected in Conservancy's bookkeeping, so they may have not yet
> submitted their expenses for reimbursement.

Karthik didn't attend the GSoC Mentor Summit last year, but will
attend this year (October 4 to 6). Hariom Verma wanted to attend last
year but unfortunately he couldn't get a visa.

Also please note that the money spent to attend it is more than
covered by Google, as Google gives $500 for each mentored contributor
and also gives a generous amount for the mentors to travel to the
Mentor Summit ($1200 for me last year). It looks like those amounts
are not in the same accounting bucket though.

Anyway thanks for your great work on this report!
