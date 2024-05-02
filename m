Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7D173335
	for <git@vger.kernel.org>; Thu,  2 May 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674889; cv=none; b=Ro7sAHR5Sf7jSGOUwResR3exd7LknqyibU8OMvOTMUOG8ysRacT5Y2+QKvzdJWKExVW2bDJzFGYTGiu7jCsIlM4XRBgSK3AXFC/l1TLyTIoL4pyxTvwpZMHBpbiFWIAA7qBfXIn6A7uZhTEtv3xj2nfAy8IYTV9+wW9lYSXs7KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674889; c=relaxed/simple;
	bh=Hf3DZVkpRV3wvBuKpt42a0U6BJNB5SeapuP0BgLVJJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB7O0wF/kUMNyWI+QhEtTmw0aRKWCxKvr2ZjnZh23uQE7In+SUnUW/cf587Z3hTe/ToSY97IbHxo2p00047HidogXPXJeiZIVfZpMgONjym/o6pgV10SyWdQd2vmhM5pIkFz5D2OfmO6Bo0gdLWqZnLD7S0L3gBw92Cfi5CSZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EASi9OAz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EASi9OAz"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso1536804e87.1
        for <git@vger.kernel.org>; Thu, 02 May 2024 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714674885; x=1715279685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFBXqb5vdGRuiz8xN5trgMrj1ik0xh5o0tarDxHuKx0=;
        b=EASi9OAzOtsPuodwzCBxxnWPpoQQXD96DSvHjiF26ovUd9w/BOOkMeheNG9muHoSnL
         eDKDCzY6701O0ViYbWkr0unlRkdXrRA4GLsQyBCOo7yHlK1xYCkDPhtIB2kxIinXnOpv
         7VDj5uD1jBhmfPJaJGFUsMMVukHk75f6720EkdulhTATS9Yx7PfI7WmL5Tz9crIvRfHg
         HqVDl8RkN/yrN/ifHc/3b3MhnACutAc9Hd3QRk7DphiDucYLNSnn3MPT5P85unhFQH4K
         utnaH7qEj0O6B7WG13GijrOiAYoZF+dBTJbil0k23vifZQlOR31psxqIKtbUBq0jN1Lp
         2tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674885; x=1715279685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFBXqb5vdGRuiz8xN5trgMrj1ik0xh5o0tarDxHuKx0=;
        b=QpRFveZwQEPjMxZQ3zB4c90MqGjINUd7b8aNNMrJoOfmaLZWeb5pmWlsrECTnjHdLm
         1Pml5sQykr0FaGkstBPXtdYCxt05ebvjZgwEAn7cGKXJeQN4yGLynZ6Ls+SnI8DHBpkN
         82ouwPJ5ck3w0mXk20kSIR8uAepB2rqmJoT5j191eB+m7R0eZ4I2PfdMQkEjWHN8orL5
         CjVFeXdZFlU1z6FSKrgKSbdlIfl2rQuV/EOexWxGLpWPhQFpyUEXLTcda8KFJ+wUgvGE
         AcZVfCvQzIKjdywbgbmLJ6OFfdc2MtsrbqNxd+m9qVFLiiFkR5HAJlREliQuS6iv1mO1
         90OA==
X-Forwarded-Encrypted: i=1; AJvYcCVlZZ6P3NdfF1dwR/rLuptt7PjajuVk/E8+gi/gkgNXVeKVZibnSoE0mfnZBlCz0Mt9h69tkc/jfteJwBbKCwPfU6PJ
X-Gm-Message-State: AOJu0YxXrKmh8Y1COGDY0fYqBKS+WJTuPFlWCE+03F2BY6TrPLMcBbIR
	DEEmPb63anlM1nws5OmF4Ka3bakNlqx2gGOesP8ud90p9zWlgBSkWQpGAejkHoyxuv/mHflSuZq
	Q2IqFGRAdqKdr3QCcO3YJq6cjPWg=
X-Google-Smtp-Source: AGHT+IH7HXmgqvdHKe8ULz48sDKHbaMOYhcgcHhTwGMNVjIRIAs/u26oGgyLKpPWvp9FQJUdt3emfSic1Zs2RqpS950=
X-Received: by 2002:a05:6512:786:b0:51b:de3a:33ac with SMTP id
 x6-20020a056512078600b0051bde3a33acmr410059lfr.59.1714674885178; Thu, 02 May
 2024 11:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
 <20240501220030.GA1442509@coredump.intra.peff.net> <ZjLfcCxjLq4o7hpw@nand.local>
 <ZjPOd83r+tkmsv3o@nand.local> <xmqqfrv0ds7f.fsf@gitster.g>
In-Reply-To: <xmqqfrv0ds7f.fsf@gitster.g>
From: Dhruva Krishnamurthy <dhruvakm@gmail.com>
Date: Thu, 2 May 2024 11:34:08 -0700
Message-ID: <CAKOHPAnoER5nNrTK=7O6UP11ri3Cx_fxFP5PjMeYgOsYOQNXBg@mail.gmail.com>
Subject: Re: using tree as attribute source is slow, was Re: Help troubleshoot
 performance regression cloning with depth: git 2.44 vs git 2.42
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 10:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Instead, this patch changes the behavior to only fallback to "HEAD" in
> > bare repositories from check-attr, but leaves pack-objects, archive, an=
d
> > all other builtins alone.
>
> I thought the whole point of the exercise was to allow server-side
> (which typically is bare and cannot use anything from the working
> tree) to pay attention to the attributes.  This patch rips that out
> and piles even more new and unproven code on top?  I am not sure.

Yes, I am particularly interested in bare repositories (server/hosting side=
).
