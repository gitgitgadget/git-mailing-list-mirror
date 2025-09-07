Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443A18A6DB
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757221219; cv=none; b=ssB4DiSrGV2dYHhZVH10h6tlrrc1s7IfEyy7ZOqSAHDjg33MOaz4S6r1b/CoRVXWNVYpK2tVkp52azXrg2mnE7mmhHDC16D2obVdv8uLYsWMr/XvrK5kFCt1f7/IbhADGTKm0B2+pfD6AId9Em7/+hIlaHn/akcZ0opnvhf5T0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757221219; c=relaxed/simple;
	bh=aomnn1eOvHCL+17Dn5GF2Tip5xWoQrPYEugcByj7wJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bbZHjOlbnXwO5KiaWdNzSfD7/F1H8CB3gQnaYKT54pCwuvlyvRrwwAbI71uZOBgDPxc+nF50RUiQCVMw7FT4qzfWhaDTeTc95xFYD9qGXybH7ifrV+K8YM5jLtPMpU3nL4oHWEfF5h+shV5iNozC2pCrN/msTxZNYR8yOmNCOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF7RNdO8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF7RNdO8"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so2882337a12.0
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 22:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757221214; x=1757826014; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsW7fULBWUDZ3EgBTFAtDyOPs1ZTSe1xUZ/jg0cXb88=;
        b=hF7RNdO8/AsbVFGEQNYCIjrTPv4FERas9i7//zFeDEb5tboIlqKyYtak1/EiusSO/2
         D9xccFRFeaHtTQrHiP6KMBmAIXw/lBmkFLPhIs5zAqsdzlREn8PmqhQeFjvjXYws3+Z5
         5jb2FpNiNt1RvJrOQb0n4O6fgRK0QmotNqkjKxQzLjy4dgW08KDQDfHqmlWnp8QSYGu8
         aa7PTIfZz5AEbHwmfCWzhAc1MSUluK61cxg+PsuYBrQ5yK9B9oAXkq1QMftmCmaWy6SO
         P/IiyRVBq2YKODfdt+RhYsSAw5RZomLHCCPVqeGhz62ijeD92sZQfbo3sudggJQhrjs9
         RH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757221214; x=1757826014;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsW7fULBWUDZ3EgBTFAtDyOPs1ZTSe1xUZ/jg0cXb88=;
        b=Hcs6TproI3vO84/CvF98FvfYZOj5T61KfD3Y6MlKx5YlMz3FIjjAdPUQka4DHFIglh
         YPue8ERxqoLl8TRB0MGOKk8Sdd2DXIb3TBJ5w/OlK/ExTjKw7EU/povXZpla7/OaqpgV
         Cr7m+giDgiv1aI3GuVkDC7ccj9C+GylbCgGVu948KKwiXCrjXF3nXozpNmv1h46BPKJp
         LuhcUXUCmzAMGc1SDGxyguGrnTVvKJLW4wzJayv5/NAeixnLU7ay2/BNc3ngcJ1j6d/6
         0DtKOwEPzNGhy+8x2To/eiKAo/1dhO++9Ozu6E2/4wTSnyJ7VB6dfiLEh8rvuwz/mCE1
         Qr8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPspLH6D0JdvVQXf/hzGfKRN7/fVHtYEqUQYG44BsmqcE+iFx4nRyIkvvnOGq4RBE+3+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwifoTZ+945hZWLdGWn0h159+LcYAuojEwj2jk8AzjWDFRamWST
	lcposJGODu/08uUIjZBbDsGV2iA3MswruA+xPaorwtASriXHt99orZ3OKqrc/uWm85IJsZ0jUFt
	kIdApmZONGTEkc5Ex/Y0HXR4Z0olBcRqxFgZm
X-Gm-Gg: ASbGnctHXajfdiUS0Lf7FcfQu15mtQh2NorvDqfTkzs/mgo4unQVOjL+7yt/5dJ7ORN
	HdgKYx199vH8HI9W2BFZzZvpZAxc+wS4AdcELKU1m/kvsgF2PffGalJ72not66sb5cNMtU91Gne
	cAtCksB4wXf9xUXhmY2C9+MCoAcFmvFFJ+OJf/pu2Tbv9B5bNXPbcmYYSkk1zGw72FT9/i8TVxj
	q5z59GOLL//T1ndzwY=
X-Google-Smtp-Source: AGHT+IGZByDlybZm2WTjyjI3B54IQSYl3Lc21BmHxVn+clMSoJ6sNPaLjYhWokW2jLvtc8LImH2XEBJG0o1Pa/ZZvsY=
X-Received: by 2002:a17:90b:2d81:b0:32c:7693:1155 with SMTP id
 98e67ed59e1d1-32d43f2f29amr4529955a91.1.1757221214423; Sat, 06 Sep 2025
 22:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-3-6939cbf4a0b8@pks.im> <aLs_QZ9eBGevcGfb@fruit.crustytoothpaste.net>
In-Reply-To: <aLs_QZ9eBGevcGfb@fruit.crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 6 Sep 2025 22:00:01 -0700
X-Gm-Features: Ac12FXwIgAVCUMWIc5EvS16JQLho7IDd7G0sHC3JjQL8Hach5KaaQYfMYqynJzE
Message-ID: <CABPp-BE3L6cT9KVjQLmFfXY2+6LKwTba9uFCCdJSKhdgb2wD2Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/7] help: report on whether or not Rust is enabled
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:51=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-09-05 at 11:50:59, Patrick Steinhardt wrote:
> > diff --git a/help.c b/help.c
> > index bb20498cfd..5854dd4a7e 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -791,6 +791,12 @@ void get_version_info(struct strbuf *buf, int show=
_build_options)
> >               strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
> >               /* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
> >
> > +#if defined WITH_RUST
> > +             strbuf_addstr(buf, "rust: enabled\n");
> > +#else
> > +             strbuf_addstr(buf, "rust: disabled\n");
> > +#endif
> > +
>
> I think this is a great idea and likely to be super helpful.  Thanks for
> including it.

Agreed, this is nice attention to detail that I would have overlooked.
Much appreciated.
