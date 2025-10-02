Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBA5278754
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759372256; cv=none; b=cTrmfW+NNJdOR5hVDFYB2n4JLnFF9/oZAQmfp2RAcpJ7C7zWFEavZKLvaaReKggJnz6o8UktiKPC7uF8T6qJb6gHu8Ar8Scok2OFj58KB84+RWemOcevrPMaWNyX9fRW0zR2+5jdW0/PTr47e7mNnaACUpbUyncp7p5YKQijMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759372256; c=relaxed/simple;
	bh=7p7e9Fn8aS73yJd8qdslnErz4YawjtSYEB0Pwq5/cs4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=iPKwdTqR9qqcMn8ByRZdC76+zJ2+2RDfBc4rzdbMhP9QHDy0JzazxL6sGapnBcA4k92rdRyU10Lckc29ySlqfmyEfaNBUabYgSSNfXmwEQNNWo/yZ1NQc31kBZCDwFEcqbLieviy4G6xZtsyWsCwZn5RN1xKbC421+KQkg9fnfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsE1M5K3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsE1M5K3"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d605c6501so6340427b3.3
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 19:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759372254; x=1759977054; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tH0YR4TWXOx6DK6Bss2vvIFa+tfhIULMEBVsPnV4ZE=;
        b=nsE1M5K3i4RIwFcec6J5AQGq44u8QRRMF6Sd8aZtaNJ35bfjknDhGLvwFQW58meEN+
         +IHpTw5plIn0YKD9uzOHQv1v5OdX6TNVqXiXLAt0mjEPpsw6Lu/UJV8hpLngkh831q8t
         YDobRvJrfj6My3gYqYb6OklGLjiha+K2XzhCGvrKpRgfO7tI6JN5fNm4gqmwCm3fue5D
         UcANV74PjcnoYP3//ilLZbrbBtIyIYM0uJNU2jhSIphniiganXtoGyS3zAVdLjFJ7Cmm
         Gu+5mpV+eLcWYvMzvzy4qTTdRQ5UNpgrqI73lotJMLvh9o5voOtKSjP58N+M22mccYDn
         nA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759372254; x=1759977054;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tH0YR4TWXOx6DK6Bss2vvIFa+tfhIULMEBVsPnV4ZE=;
        b=NLOzg9Z534tRj3qK6D3vppj4hnF3bKfqmB3VZots6HCtM99NsrNDVVrU3E8NdRuZvO
         bkXf5CGPP6UgQ16aDxaul2CZLwVSMsJwF84mOLkTIC76YDSNlTMBR/56oaiJ9EeFDI6m
         5HcSK5lLnKwwWYECFzvXvZHg2QVR0n5b9A5gikSEtDPHADHdSgNAtquLS6LihwyCyNVH
         wVXw3qabYk0OIRDWGODbLXbwi5/Lz032rvPf0cArwds4SefSfNcsfXnPRurzZsqvLHvg
         DldEwKmcJQqm+pRLGka35KZ3Vro2T8649ARvF1mVM38SMqFNptGx/91I7FIJRDY8ZPHX
         ZAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4VbucjdocWUN9LZU9At3YZMicJR9Gj8XBHNTgtTn5WeeocT+Qj5ADhPs3LaHn3fTPAkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7A9zLd2d+NJQixuZXOvczSPcFPTsjG/JejQ+9nXDLZiFkQY3
	iYEQ/7JB9XI3zF/M7+6X4HSrfXGTkF4WTZarCVLrYc2cbdLeo0l1To7A
X-Gm-Gg: ASbGnctzk7lTsFbfW/+3ExKx374DOMnyqHynQT7U9BxUaDMT69jTFit66X5mMmYaDlK
	OQFemCiKN0duziNYTsNZ6Zx8MBbgJYBScqqqq1NeFaLZhSW7xzdDtDObysBzOlAeTcOzE5VLD/y
	x2bEWzCHiSpdQWv3Nr6yo1b+cZ5DK+E2TmhzHsyToJ2RiGkob+0aDoECiUrzIVO068ZpeKHM7q6
	G85IEvjbiduCav6mJw6nA8b9asZh9UGt/kV+vBwMDTa+GnuX4LG+OVXXknXDza1TW6sH9oo7t2Z
	4mldhZ5Jm5uWDw9ib+6pIiN+e7GLiQmqktOXjphlTkCaWFhhr3qMo8OJ4C0fdpsEaim/1TpjwwV
	kb9ycWvWznTJYJz4Z4nR3wxYN0ruwL8DzFRFwla2vi20Nd4axNbd5jz3ARAfYKwyTpz6bESdp1U
	V/BE05YBHhPw==
X-Google-Smtp-Source: AGHT+IHtWgOf29shIKur9rbSHxccOutQlwjfEQfOt3Chn6qRZ4BMrQFwP1BC7wSXxOTMf6ByquAVEA==
X-Received: by 2002:a05:690c:6813:b0:720:bb3:ec14 with SMTP id 00721157ae682-77f6f2c23f7mr90717637b3.25.1759372253451;
        Wed, 01 Oct 2025 19:30:53 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:45e0:b917:39c0:e808])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81c303d1sm4527227b3.20.2025.10.01.19.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 19:30:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
Date: Wed, 1 Oct 2025 22:30:42 -0400
Message-Id: <41F7B31F-1CED-4A74-A69C-1C3D61B10A42@gmail.com>
References: <aN26C68pxi-eJgn8@fruit.crustytoothpaste.net>
Cc: Chuck Wolber <chuck@wolber.net>,
 Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <aN26C68pxi-eJgn8@fruit.crustytoothpaste.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: iPhone Mail (21F90)


> Le 1 oct. 2025 =C3=A0 19:44, brian m. carlson <sandals@crustytoothpaste.ne=
t> a =C3=A9crit :
>=20
> =EF=BB=BFOn 2025-10-01 at 18:59:31, Chuck Wolber wrote:
>=20
>> AI is not going away, and we need to find a way to use it productively
>> _without_ losing our sense of self-reliance. If we fail to develop this a=
bility
>> when AI is hardly more skilled than an above average intern, full of hubr=
is and
>> zero real world experience, imagine how unqualified we will be when AI be=
comes
>> competent enough to manipulate and mislead us?
>=20
> I think you assume LLMs can have intelligence.  They are glorified
> prediction engines, effectively fancy Markov chains.  In some cases,
> that can be useful and valuable and we can do interesting things with
> them, but they cannot actually have intelligence, creativity or reason.
>=20
> And LLMs already manipulate and mislead people.  They have been
> implicated in goading teenagers to suicide or leading people into
> conspiracy theories.  Some LLMs espouse racist, anti-Semitic, or
> otherwise hateful views.  That's a good reason to be wary of them and
> how they're incorporated to our lives, at least until such a time that
> they have appropriate safety measures and regulation in place (if that
> ever happens).

A tangent, and one I=E2=80=99m happy to continue but off-list (I=E2=80=99m h=
appy to continue publicly, but this is not the forum): I=E2=80=99d encourage=
 folks to give the LLMentalist Effect [1] a read. Regardless of where you fa=
ll on =E2=80=9Cintelligence vs stochastic parrot,=E2=80=9D I think you=E2=80=
=99ll find some interesting conclusions.

[1]: https://softwarecrisis.dev/letters/llmentalist=
