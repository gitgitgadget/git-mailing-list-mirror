Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C034261585
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855908; cv=none; b=H2NHl1juGmpz1lbL/JSW21YnBFR/rggmpT/ldcGrG6geGlPdww9BL67l1BNLvoBYas/EHO8HF6mibxe0zAb4a9r3ss6R36dTpzura5NOFnNC4L7NKZGG4rG+YcaelBdknpQ7zur+7yzo6ACpUExxnYXNeETrHSyFyy00Xmphdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855908; c=relaxed/simple;
	bh=RrvE5otFHTdKFxvIHy4JzoJSqYoL2IsnY/6ySHndAio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBDmwOUKVM8poADIQJ01ag9N8L1Z0vTR3BtRk5NKQKQjUhE7bZTMuV+Buecb8Z8rAZHvt9bkPuCIXQUwOczPXDeH8tCS0QsH2wCMXJt60/HH+i8/0eNMbIiZvwo6AC2XbV6yvQ2bXJ1THAZotyuUb/501yWqHnjNAC5i3tOF0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keVRI1iX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keVRI1iX"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so2451809a12.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855905; x=1751460705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRxZKmAW771ruiYZR24KMnfjcrIv/eDag1i+RCYUu/g=;
        b=keVRI1iXbKcuop+1GQVfsxuoCQERtkjjuRkbGD7IAU3eHjRK7hl03JfL5CdZJbskdh
         8CHB6MsiJuRHctHnlAvj91mKijltsasLSMRIvzOE9+jtUqDTxOLS7DxULSyoCxE5kqLD
         DZiQ15FcBBR9SblCwui9Ean6jb8h8s0ORMR2DLnkuJg0F+KSNvrWdV6qB0kOGbA3X3YS
         oiFSmmGH2X0QDzZpfcFBe9UKlr8t1E++0n8rRybhBtLtqjoU1pU2pM9AT3WcztkglkYp
         V0YgRr9a4KAkwtLZu99gbcnY3JSdJtCRk/TpT/R9aZrAo2w5TvvgqZ9+rQNTafdrjHO0
         Wj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855905; x=1751460705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRxZKmAW771ruiYZR24KMnfjcrIv/eDag1i+RCYUu/g=;
        b=GE1MCIwH3g6R/zTBdav7xUDiVlA9X1wdQdTPMeH/egWTWR/5dIJ/4dk+uoIOHniFUI
         720AN2cw331K4pWE2+OmpSihFXRQnoHv34AJCpf+Zi3XKu0DBI/T7EIYWSJActAEsipG
         xKVOedT/G5GsBLFlopd83HVT27Y5pNzQWmcY2jx/8vvVpADR1hdI9/rHDSeo8F7HfPKZ
         SmjiMbfHdBAiFBYYCfdnZW7FL7/bydySvRSLnVJLUnrirO5OAESBvUC7TkTiQ7F1i/NQ
         HEv+1h6mP0mEXhSPOzkv3e9SxiLTKvqpCd2MJmG2Z6/QxlIrnt1wCfptBad/yrw+/ZIW
         OZcQ==
X-Gm-Message-State: AOJu0YwT3lAgJjKPd46NHn3GJ1Ne642uvViBaIc1ebN9x1GRQV0k8lE0
	3vdZy6iH/5e5GiXeKIPwj1K9hLcH6C2Mb4GmXsGXJLrRFhZZ7McV0uAaR8tLIxNrdB+ipKhfCD0
	Bt+CuqJ+CcRvG+6qbNfVU8XLyBansaOE=
X-Gm-Gg: ASbGnctxpJgdi5I7Gx9W+qYLahU/QN7/9fN1au6TxdrMq0oWI8jgAhGKMG3Amga8/ak
	Y+sLGWvAqaNngzqiBXmLotMN+NSTgZpW15p56Pd7EtUDn73cWuMakTHfT6Fx9LQSww/lPACmae5
	k7/ztcFOGpWfYTJfCO4IVb3u31vDKpQbRH+YE9CEO6LwUnVQ==
X-Google-Smtp-Source: AGHT+IHGdG1Xc14ytZaHckabkzsBs6aDGm2axrYO1guu9EKZyqwTsr7jAOSkfbxZriS9psUL+t1lKGr3viuUWnXljV4=
X-Received: by 2002:a17:907:96aa:b0:acb:5c83:25b with SMTP id
 a640c23a62f3a-ae0bebe8f00mr300895966b.7.1750855904632; Wed, 25 Jun 2025
 05:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com> <20250611134506.2975856-3-christian.couder@gmail.com>
 <CAOLa=ZSAU4vfNNvcmpVrEavYWss_txVwfutY5ZZLzvVmv5wPdA@mail.gmail.com>
In-Reply-To: <CAOLa=ZSAU4vfNNvcmpVrEavYWss_txVwfutY5ZZLzvVmv5wPdA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 25 Jun 2025 14:51:32 +0200
X-Gm-Features: Ac12FXzSmiIUWK6_56Wz_emYJJ7ZhjSrRmVJe9Xuz-XLj6ck0RuZ0gOfSWLeSsE
Message-ID: <CAP8UFD3-ayeLMiU+kF_4bF-XnBDT1xuWHzq4eLts9by0WikEhA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] promisor-remote: allow a server to advertise more fields
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 2:15=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

[...]

> > +     git -C server remote add otherLop "https://invalid.invalid"  &&
> > +     git -C server config remote.otherLop.token "fooBar" &&
> > +     git -C server config remote.otherLop.stuff "baz" &&
> > +     git -C server config remote.otherLop.partialCloneFilter "blob:lim=
it=3D10k" &&
> > +     test_when_finished "git -C server remote remove otherLop" &&
> > +     test_config -C server promisor.sendFields "partialCloneFilter, to=
ken" &&
>
> What about testing only 'comma' separated and only 'space' separated
> fields, since we support those too.

I think it would only test the following 2 lines from fields_from_config():

string_list_split_in_place(fields_list, fields, ", ", -1);
string_list_remove_empty_items(fields_list, 0);

which should be already tested separately in some string_list C tests.

So I don't think it's worth it.

Thanks.
