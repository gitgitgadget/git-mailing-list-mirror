Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63160D299
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649648; cv=none; b=gecl2QCwAo7tVwgh/5cKnLnywlobvlPO0SDPoIPq+/tyacvRyWcUw1NQOoQvN9vZjqzg/lHm8rZz/mRdYFVS/9wV/Mrur3kixKCwBrpVHGn9cD38NNuMDv/1gG32HzkFsrDGAZbUTf7L6FhJSeijhqkRVc89ivwddQkDYX5y9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649648; c=relaxed/simple;
	bh=c9nvi69SlOqdDrnVltMszg3KZe1aPq/slInmERaGrRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsXGnaTyIE5u1otu7AH5gotnLOhoUd7qgYRl+VMBsxW/t0fCmFhTyZEt4eATP5njFHcE3drMkDsC2jD4BLpbcDSKaKmFGwNCV2xaY8cV9aQIz9dkkeuT5KLYRhBqBCAX3Wg+VT6QnXP807YAd65ynntB11Udjr9JrbN5GW14r1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDpGURFQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDpGURFQ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade5b8aab41so662152966b.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749649644; x=1750254444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9nvi69SlOqdDrnVltMszg3KZe1aPq/slInmERaGrRw=;
        b=UDpGURFQ8VdK1ODUxHt967ihlecHadjnl7UtY6cSQSvWWrUGvzBA56WNhCHBBc6FZ6
         mTXFsh6XAoREHHUD7WHhSAiGk+Ybsp2k16quQnT1POPMo+2pf7S+auxDfD8/5TzXa9+V
         FSguBJAUINCqrcoAWTUk13LgGzmeWR80Ob2YRaOBiEL+U9bXmDAG8Gp7PchqHB6VM5NT
         vl1aJ89EBCqMfhsuUce8oGDiwL3lELscE2mipgwSx0lNrvbFEY84LaaY5uOWnYKNxudr
         G7nQlOBi84l4MM5koOhTULUCFfP87eoTXngB3Ilf9j+1bt+yGTaTo+YB4Ee4DvE1X8cX
         DRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649644; x=1750254444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9nvi69SlOqdDrnVltMszg3KZe1aPq/slInmERaGrRw=;
        b=DhI+BxgbrI0+5Uwla5oe3FboprfPrhZASGVnEbWQLfnRGeOZ5D7gP1ijSMHGw84gfb
         lfltFYMoZDN5LnHhJEMxD+WF7lAnasujvH/yVdlzykGkhy/Qp9diQNuO8ob7QI2zO1iT
         UyraVSLP0ccmINh1zBhboSHwzZ/Tm+lPrS66uH0gypuBs9c/fc8NBBSkdl/5LDZre64U
         +CwLQROkQjGbvA2Au8h0p46UpIpi1Lgz4Z2EbDLOr95IZRd16gm7QesKQiI9Y1/P+RId
         MGbxq5fKeQW1fpDDIBOonewu7VWGebbHpq7vnQfF/xHheXF3RG97BzHbZALtO9yU6XwO
         A3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV+pmTBCKxjhTbjJmIoiau6ipqLSuOLviWYGxYXv7X8LGOie2qKjh6JsHaHh/S3UTVubq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78ZPzqu/J5PrjYJ1Wt8EDme/7nF1LDepTaD8KL/LCeJlajGcj
	ZhMWy9EDFBpBaThD+h54AHlrX3l+Yl6pYw8LzzFyf7rkDBlt7dC3f3BWbUuePu58qQb+q3xvCBf
	8CFUveFGR2EGeKLi3TI/qFvdavrH+JhIRMw==
X-Gm-Gg: ASbGncvAuy8yO9qdiPxxM3Izg2tE/E8PaO1IbsHN6nNZm0EXOIMfauPFpdMp35gHTLf
	XiMRi8AmSFJ3hLJmoFF6D8yty/C1IE8VwTIPGcnx8EXX7FobL2jhio3KPrjOY5GaUnBiFDV78lg
	S/hEtUBQ3EK1kRoibBCzilrI2R3Lu1Bf1pXHQB5daMbaIktUB5sselFAa1
X-Google-Smtp-Source: AGHT+IHCs8SMcT7DZETsn9JbQ7kFKCDTOI08GY/xLnI4gsk4bgO6NRMvZ/FlOhKBrfXV44PrmR0Q17b+vUowW5jHIIE=
X-Received: by 2002:a17:907:70a:b0:adb:3272:7df5 with SMTP id
 a640c23a62f3a-ade8944a1b6mr316828966b.16.1749649644171; Wed, 11 Jun 2025
 06:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com> <20250519141259.3061550-2-christian.couder@gmail.com>
 <CAOLa=ZRnL_PLVpQrmHPMXtJd9e965B5iz8widkk5GNSDvh21Pg@mail.gmail.com>
 <CAP8UFD2XtyPD7b=sE+t9d-kyXDt4hYMqVotwz7hJZEO+5TfXGg@mail.gmail.com>
 <xmqqr00ji63l.fsf@gitster.g> <CAP8UFD25fF6OdYmP54JFyY4Znpij=MR1ifdWk+cjca5Hes739A@mail.gmail.com>
 <xmqqldqqc8kq.fsf@gitster.g>
In-Reply-To: <xmqqldqqc8kq.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 11 Jun 2025 15:47:11 +0200
X-Gm-Features: AX0GCFv51oN46HX2ITPOI1b_NsX9ntKhCCmuSUb4TymjGQLAHZjCo8NKMBVJatM
Message-ID: <CAP8UFD1mOitL5Um0cnMYKAVLKamj_Xzhp6ECwQ6_BsqZ0QUy2Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] promisor-remote: refactor to get rid of 'struct strvec'
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > I don't think it would bring a lot of benefits. Using an strmap or a
> > sorted string list might make things faster if there are a lot of
> > promisor remotes configured on the clients, but I don't think we are
> > at a point where such an optimisation is worth it.
>
> What I was getting at using common collection types instead of
> rolling your own linked list was not primarily about performance.
> They are more battle-tested and much easier to readers who are
> familiar with these existing types.

OK, I have implemented the string_list approach you suggested that
uses the nickname as the key (item->string) with a pointer to a
promisor_info structure as the data (item->util) in the v4. The
string_list is sorted when it can be useful.

Also remote_nick_find() has been renamed promisor_info_find().
