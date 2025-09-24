Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804C15C0
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758679736; cv=none; b=nS6wKEYWnp7C/fbuqub6I18ZuZsaYRjojW8AghSVmGxL9HsRHr1e9N0H7U3jbwo5w/60kwiYb0opoK4h46TNzK3ILbBqyEpkSJPGgwT6I9l9ES/3kia5Pz/nfc062mnA85vGFYuytWE6hWBXfD+PxMi/a2uMSSjCuPHQEtQCSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758679736; c=relaxed/simple;
	bh=aZJ88XEbSEsWzcis73jZanhRxfBm4VwkCGovzSf0y9Q=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Q8uvbcRLx+9QdTI2HCZS9p96SCHVBCt3x3+dEm2JV4nCRgwOFIPCwOQfRnM2nGi2Ym/OQ01Rw78/78Slgl2r5LrqBGDMB3tZdfCRct/8Cp5ZeWFCIom2jvpefg7cYMk2wpxfd4aho8jSUZLYcAk8pKfVy9qesZGrwpN2exZZ+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIA7cy5F; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIA7cy5F"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d601859f5so49588397b3.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758679734; x=1759284534; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkSi2gjWCQ9iFxCAKATepuImV5kSbsucCJ2V4zkUCms=;
        b=iIA7cy5Fvn2MIter27SwGQkC+IMQ8OKga8sCdlGGj+JJbw+fcoqyODZPIZQjdi238o
         ZUjvURMO209PkxGvq2e1sVhY5coCiAB97D25K8rXw4RG06huxratK9na5140OiI6zLES
         MfASXAkSyISyjwPg9wAkd+Zls+5siWMBWqPyPuECPvoW98n9VmxiYjhJEtP6O40qwyLo
         ARRVK9kbbcCi7bbti48lpXIAvO5eVqF6X7cVeorGX9gjIceRRXvXH9Yzl6IJXm8FH6N7
         IH+TMSWrwahsS82uVyd65oUByDIdUGo4nnMOJYmDiP9KVmbS8BghqXVVUPEYFvJjn02Z
         nNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758679734; x=1759284534;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkSi2gjWCQ9iFxCAKATepuImV5kSbsucCJ2V4zkUCms=;
        b=BDG2x8pKXzcOgqi8fNA7oAJ3EcbWHwULXVo8oVUGxAe9teMOy7NDAzCkiwwvgTAiih
         EZC5lC2GW2n1hcNG0rSDz6RKH47GpT+5iybdkEZmDC6hzNFPUYmLikCW0lCvCgX3WdBI
         L2O13oZnl7HYWHhZmPOkncMLTARln22ds8SQQc4POR5feJ6kQnIPSHpBpyz3VLUfGleH
         CpoAZ3np/dLK8RdHGwp0eGV3OaJa8jCP3oHJiZ9p4qh1nRcZfg4NavVi+XbvzufwU64T
         UDA6TYK+23dvbphSDlJM6VbRuEf5j86/T24T52e6IF/C3B6mFTo6vJMv+nYBwsJX3s/B
         t3fw==
X-Forwarded-Encrypted: i=1; AJvYcCWjbrt103krSo41Ig/T0oW7P5Q4qM1F5fAei9FxBJI1uqiRbG+ROnwWsLh/J8CnItJpQvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+J4M1pixXau7pM4iifV9KFA068PsXuw1cOx6e+6lq+/lII6RH
	CQPNGXISLkpY9Fk25xdiF8u6+sc1jiF9tr/7qDiV5AsIq7ZRM0EJvGmw
X-Gm-Gg: ASbGnctELV+FZe/iKPLPKQ1r9sIBRHPnB8N6a92jL6fc5mi4VRBQusRWZsX5jjwv8++
	r/SKd/LVdpGoObuCjmlAn9WoJud3bB8RSItR4S2o0KQ6Vh0l+MQVg2isCW/sQb8Vj+mQDgfBVfz
	qcRAhb0bx1V8obTcvAhkJhFsYHBUTbBQhA1WcRMC7AZQ/CtansTUVW9MivCBhjSx4ZqcHJhpSi7
	1YgFEDjjQWB645MmOilK7v9zdrNHrxyWwYW0o2LGVjYzth+OJ/ItGtaAiH/RSmwyjpd6O4LjqZ7
	wnND9uquWmk81lPhERrz8P+L/nLUsu54mTl5wz6T87ze4aYekSQXkA/3Lx5pwAW8F4Boq5uGqki
	mbyNWkBcUkByOFmJvAvy7JUHi51bhYtVm5H/kbyTbTBIe/yaluJY=
X-Google-Smtp-Source: AGHT+IHBfFUmkayn1ALLCIR7I1Kikk2Eu9NNFmD5gyXp832i6tmX9kefco2Bd9OzvCvy27obiMeJhA==
X-Received: by 2002:a05:690c:368c:b0:731:1bc7:7838 with SMTP id 00721157ae682-758a5394210mr42258327b3.37.1758679733720;
        Tue, 23 Sep 2025 19:08:53 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:3535:152d:7414:b233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7397188ce91sm45133477b3.54.2025.09.23.19.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 19:08:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: format-patch: why are the Range-diff: and Interdiff: headers translated?
Date: Tue, 23 Sep 2025 22:08:42 -0400
Message-Id: <43606056-D212-408C-8E53-0B082ED1BF55@gmail.com>
References: <20250924004133.GA1142438@coredump.intra.peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
In-Reply-To: <20250924004133.GA1142438@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (21F90)


> Le 23 sept. 2025 =C3=A0 20:42, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
> =EF=BB=BFOn Tue, Sep 23, 2025 at 09:59:55PM +0200, Kristoffer Haugsbakk wr=
ote:
>=20
>> I=E2=80=99m not concerned about machine-readability.  My thought was that=

>> localization/l10n of this software was intended for the user themselves.
>> And also that users might, without intending to do so necessarily, end
>> up using localized output in contexts where they do want English
>> strings, like on an English-language mailing list.  Even though they
>> might prefer Spanish (from my Colombian example) when using Git
>> themselves.
>>=20
>> But there might for all I know be Colombian/Latin American patch mailing
>> lists where localization like this works great.
>>=20
>> I=E2=80=99m not really in the natural target group for l10n Git.  I might=
 be
>> totally missing all the use-cases here.
>=20
> I'm not a user of the l10n stuff either, so you can take my opinion with
> a grain of salt. But it seems obvious to me that "the language I am most
> comfortable using" and "the language for the project I am contributing
> to" might not necessarily be the same.

Yep. My own patches have probably come in with French titles here because I s=
et LANG that way.

> I'm not sure how well gettext supports this use case, though. The first
> one should obviously come from LANG, etc. If we added a hypothetical
> format.lang config option, is there a way to tell gettext to translate a
> string using a language string provided per-call, rather than from the
> environment?
>=20
> I don't know that anybody is really even asking for this, so I'm not
> proposing to spend a lot of effort on it. But the thread made me wonder
> what is even possible/easy to do here.

I=E2=80=99m not asking at the moment, since it hasn=E2=80=99t bothered anyon=
e. If it does and there=E2=80=99s a need to do something else, I=E2=80=99ll f=
ix my workflow (opting in to such new config or otherwise, as the case may b=
e). =20=
