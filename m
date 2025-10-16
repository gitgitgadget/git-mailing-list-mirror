Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD8229B12
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648820; cv=none; b=H2pYsB6oPZUC0pRL11FrDT7R4WSQhpJriVEoSeqxECdrCq9J878VHa/PlYHykvrtDsK/rWasv2iVXOxt2O+3wAsv7zK+tWWkMeOWtg2nUjvZOy/CVKH5GGfanC7JFkY/KnQO/Pd2iWRZ4tLSRoobi1+VoHsiLAR1n8a7Qe+ORSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648820; c=relaxed/simple;
	bh=AAq/h3POMbDOJBD78lxGlAZV1TKsVxZ13Cba2LtN4fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQShcKwEtsBVxqi9FgbAiJ/QoLGueEkLTi8qCbeoGEDdWiUkBXmhhrdxPvQBIDLmGsit02uUxd8vNlnvj5yFyQxvmBe4wiQdQNVB4KZLO1XKBe8ZBiDVwi//gzr0JzOMn5OVUuxQHNY8UA3iL/WdmhzROPe5ePCRxDVSC/EacHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btwyBFEV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btwyBFEV"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63994113841so2150789a12.3
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648818; x=1761253618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8kuq4hX1ZTPUpuqG/inaemuAUNfuXrNmX954xOAgC0=;
        b=btwyBFEVsO5ZLFtSy11foVYRa+oOQKye+mOrVuHFUZaTv0QCsDKj06y5BJ7yyr2ow5
         kOfx25hag3rPIt7i0ulMW4AmeZUA39X5PpPF6YtHhqdlpxC9P+f5GQrzES/ILBHlkVl+
         gUv5Y0+Fas//jxI2ncCH50LEoo5sseNoFwNHJ0089LqoCevqj9UnPxwGra+f95MysQ6q
         VMlSxzFPqf3vvZ4cL7/KAcbSwZ8P9/K5WVzpmUubniLz+5YqkbPyZBF6DJ6+z1Izf+6s
         W3M7ps/RLAWDzPnRlIa1gr9Hhf3P80kOSAfvbzzhxjbZ6ZhhGijYtRZCZQq8snWrBdnU
         vCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648818; x=1761253618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8kuq4hX1ZTPUpuqG/inaemuAUNfuXrNmX954xOAgC0=;
        b=vJdb/llVQ2q3X0YjnN7LJzmq6oRoLSDzvRcCscDrycV4f6xSGNlYe8KU7AIq5k1vnK
         Yi8wGwaSzTs7HnqKY7UcpYIBnSv2h0+DpNZmj5DS0ywz0mLcihQRplTgigL44qr4jUHc
         tuJlWW766uV2rCnu65ReQK7eiP7MtTLb2x0TdAtswzsheql9qDC3e8fmzdB5ARf9O0Vk
         226lfcXySqNEPN0hOQ7UcI5mNl0vb8RuemOnuU2GH58zz+76A5b48ZTImsd3+UONXFFL
         QJL1A1ET/D1bBw1AypZ3xELZ1i9CwWwWr0xC7E/fn4cY2otxkK/nxlZbnG91VWIn0Son
         1veA==
X-Gm-Message-State: AOJu0Yxokyi9TI1V1ZR2nHjYqN1ji2h4jmsOduilNlmYabMmXy55+4kt
	RgxUJ3O6V0OuZ5y/XcLRkhpYPTRAem8tSITrgoyEuhZENqO59th5xUhp/eZrCFqyMSTv9vCxuyg
	U84WsYtXrgfacCTXBG1vXjWu7qzokf24=
X-Gm-Gg: ASbGncsmVfIRqGmUGxhu7D1ZZQM8xuukCjnBSnWn/ZgqJRJketkv8MNgOpnaG/Y9TvD
	2Jpw3bQN2G4xQyHDHlfd4KZvTjNBpmaAVkM5bPd9iFxZc4Ha+Yvz2tUA9TY6U5OKIpcw539scT7
	4NaWJCCGzX5lFVwr0RZRaQyvocEtLbRAI2TTRx2ZUPTsaSTjIysc7xYV9uU4QaWQOTkmI6Y1xM3
	0AtqQ5K5fBJ0wy5VMZcsuh6MY1SGBDQrCrtjerZ6/JGpuBjOrUA0qt5EB+uaxIvY1FWShppjRN+
	SfxEenZuQHv8cLMeUUf9jZPZV1zb69/dNE3yLQZu
X-Google-Smtp-Source: AGHT+IHONgtODDNbv5YtZnkUroJEehLVlA4JuCdgUi3HU+36bYT/O18w5y9RJ41/zF1yTkfYiVsU117R4TuEEuA18Ro=
X-Received: by 2002:a05:6402:2551:b0:639:ff4f:4bba with SMTP id
 4fb4d7f45d1cf-63c1f631c38mr1186700a12.2.1760648817605; Thu, 16 Oct 2025
 14:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CDNRw3UcU9UM7rpkAoQsSmfdkxMKVihmoUmUOCv_fpbJw@mail.gmail.com>
 <xmqqy0pa1rth.fsf@gitster.g>
In-Reply-To: <xmqqy0pa1rth.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 16 Oct 2025 17:06:46 -0400
X-Gm-Features: AS18NWAvf3rNbeQtdHg6aHE4YElJQc5jxtnPwSj85pFsmGjuWJCYnPKVVVaGz0g
Message-ID: <CALnO6CDN6EZq6VPhUOPbO5uV09qzjsrJeU+uyvcy8BNFMqAynA@mail.gmail.com>
Subject: Re: Signed-off-by & the law
To: Junio C Hamano <gitster@pobox.com>
Cc: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > Any contributors/users with an interest in law feel like taking a stab
> > at answering "Is Git's signed-off-by legally useful" ?
> > https://law.stackexchange.com/q/111158/26698
> >
> > Having a solid reference answer is usually a good thing, if one exists.
>
> The meaning of Sign-off is left to the project that adopts the
> trailer as its own convention.  Our SubmittingPatches document
> governs our project and nothing else, and defines how we use the
> trailer (namely, you sign if you certify your patch is being
> submitted under DCO).
>
> So the confusion by original questioner is understandable.  You
> would be confused if you only see a Sign-off without project
> context and you are forced to answer what it means, because see
> above.

Thanks=E2=80=94I think I tried to convey this in a comment and did a poor j=
ob.
Let me cite this as part of an answer, perhaps.

--=20
D. Ben Knoble
