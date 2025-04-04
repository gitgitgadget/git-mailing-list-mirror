Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730113D6F
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780420; cv=none; b=YeL4tBiQarfH/P0GHqV97D/QSaitMbJbBAuaY5rgyT6aHDeg8hjOe22ESoT3+tEbE+lx8KANlIezo78qBiJ3DjG4pZkhao1rEZnOlv9lIyXAKEdGfNLB9AzxkffHS9qGg/8yOmLZCylGJVN1awppOa1Z+srRC/imd7rYGgxmJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780420; c=relaxed/simple;
	bh=eGdU44pVV5fOXQBLkQe+eTKCGNSilbi+cJbcPcbJlg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foWIOnlWHIU+ZjH1QnKoFEhUiBsY8hZqG0tlNCE2O7O5vGBZDI5fGBNmJgfGkT55qxWwGHwR9n9S0ccYkGiOwASqqh3JAxRmwJ9tVnMw1nk3vBA9/TPp9NBWROGX/dq3ia8ffdiMvoiZUS2JUAsgS7Ba2/tnyXMCIzTiT3gaDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nARCXJd9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nARCXJd9"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5499bd3084aso1934571e87.0
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743780416; x=1744385216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGdU44pVV5fOXQBLkQe+eTKCGNSilbi+cJbcPcbJlg4=;
        b=nARCXJd9DM3I91JAiwyOJ/RgBbS1lWJEf/ndsbqGffdKtLhi9VY28CDkK6PervKD7l
         FYxwXuzXDFwNmBX4tw2WVNsU+EycOAtSLPS4kEGbuO1Z4tmpVvOf2fTV9HdoU+tu4Aig
         NEzj23BXcw171f4INRxVOSnUGLWAq/B8ikBu/wGm8k1ij92/TYqDArauxn9OTkejSnRY
         yVEnO9FVEyTchp84xMBCOvk5WqecqbII2J5B/lzUqWyvLG9biOW/0h7GvAKoMND6XZmg
         lyNYKQSC/Azmy8m7fFbVqdym/H0IhtEsFkV/q5yJv3wt+7rnuZXQIwq+lb3Ok4RC0Qn8
         GA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743780416; x=1744385216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGdU44pVV5fOXQBLkQe+eTKCGNSilbi+cJbcPcbJlg4=;
        b=XJOolU1BuZlSY2QHu7Osnoe50NenXTHrWYIG717ZzuMNCpTUTGIWXZBzVw9WcZix8B
         wPTjm8FMlg074AGf562mxaoScS4L7pzyryd0iHAWh8m/CEmGRKo945/kbwTFGdsvVQ1L
         9rFc7cLQ5lmtUrqc7h+oG8FfPCKm+/cr+ZQx/wJiG9AJr8oBZ+DlrKpEQQuu9kKo/UmD
         GqM+B1x9xGJmtK5ji0Yu7IVatcD8X8fiS7KtTS+yecOfhY7+o5LlDAiqmUKbNpX3uvgW
         sq6LEmNz9VnHuGBXVFZPVTUWEbijvIYeX9F/3t+ggJ/+V3oHnCDdGJZvBDPbiZojmcNs
         Mweg==
X-Gm-Message-State: AOJu0Yzcpo1IQQCfQB1Gu6gkBh3hUOUeuwukAtqcxsaLPQJjRvKLb2c0
	/RKMjgT+ejtXr+RzK6vZe9S5b09hAtKdsRePicxX0wADPYyECdw3JJBKSzAV0woieYu5RAbE0Kw
	6QAwwYt9nWFJcHeLCHv2IsTDH7w1fKHBPQutaYA==
X-Gm-Gg: ASbGncvg0Fl+Ij/kuZimdhFTPv3xTELH+PzZ2KS1UwMYMXVjG6SEugkRbNomsHgmyC0
	RJaXcvO+uvzCsWz90xFawUerdinIav21eksPPgH9PSed+af1m970753JSWRpQkMi1CRn1Kd2eji
	5sY2asQO1YhtTbuAue+rlZoJs0crf7DxXNHbRyVvJ90fr+CQGKMQPTPrQMAPQD
X-Google-Smtp-Source: AGHT+IEbjeOgOFiLSw5SkkN139/1nVeRHNo2LG/nQMpiZNckP1znDmIXHpUj+PuBeoWPGSIHtQluatXNKn4GF/leUqg=
X-Received: by 2002:a05:6512:2316:b0:545:1082:918d with SMTP id
 2adb3069b0e04-54c227dc802mr1243855e87.41.1743780416305; Fri, 04 Apr 2025
 08:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329150248.2274482-1-05ZYT30@gmail.com> <20250403154404.3459805-1-05ZYT30@gmail.com>
 <Z--_TvQ9MXgjxqOV@pks.im>
In-Reply-To: <Z--_TvQ9MXgjxqOV@pks.im>
From: Yuting Zheng <05zyt30@gmail.com>
Date: Fri, 4 Apr 2025 23:26:45 +0800
X-Gm-Features: ATxdqUEODycoLTergiHgD6ZthucDQxzdw64lRpcddqbLYiYqtYohzC8Yv5i11EA
Message-ID: <CAMvj1+qer9--SteiYM+ZLJ2evJos-MGC_RPssHDhB-FwYaWPyw@mail.gmail.com>
Subject: Re: Discussion on git-refs list Implementation and Possible Approaches
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your review!

> Another factor is the default format that these two commands use which
> differs. I would heavily lean towards using the format exposed by `git
> show-ref` because it doesn't require us to hit the ODB, and thus it is
> way more efficient. This has bitten me quite often already.

Thanks for your reminder! I will explain this output format in my next
proposal, and I agree that we should adopt the `git show-ref` format for
its superior efficiency.

> I don't think it would, both are orthogonal to one another. I don't
> think people _only_ want to format or _only_ want to filter. Quite
> often, they'll want to do both at the same time.
>

On the topic of filtering and formatting, I plan to implement these as
basic functions that work together seamlessly. In other words, the filter
and format functionalities will be integrated (without being exposed as
separate options) so that users can combine them as needed. I will
submit another email for further discussion about options.

> > 2. The performance could be worse than `git-for-each-ref`.
>
> Why is that? git-for-each-ref(1) already knows to filter and format, so
> I'd expect the performance to be roughly the same. In fact, I think we
> would be able to improve performance if we changed the default format as
> mentioned above.
>

I am concerned that iterating over all available options might introduce
additional overhead.

>
> I don't think this plan would make sense as it would mean that current
> users of git-for-each-ref(1) wouldn't be able to migrate.
>

Finally, in light of your feedback and Karthik=E2=80=99s, I have decided th=
at
Approach 1 will be my final plan.

Thanks !
Zheng Yuting
