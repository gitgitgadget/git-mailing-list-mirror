Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9913D896
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668273; cv=none; b=Oao9YFm93V88uMy42D4Wv3xAPU+lQV0KGQQfLdIOliAaeEr/jyelukK/9KeWwsgIdsqZk2Gc/0Je3DUz9mIpS+0EH85mpz9k3WriXwLnsQSUzU5XRD90JIcLo+dETFDlyyqhAJKSlue2sL1NHrFV5SYLwv0xzsU4iepP9/apWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668273; c=relaxed/simple;
	bh=Myr2tE51+aIaVrbrNvhiQo69RMRtPETE5Z+5LeaPlpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdqgUuAlh0sl9P3jGouHc33SXujaSMl5S2A1sgFoouj5a5jji3faY4SwE5jCBDqyKcI6rAW41I45W6H5R6EnJFg23SRQ5thHf6C78dkXgp41SlwtoVTjrPnSrXczvgGFg93HPeKJB5mDobSKqhT8cAVjPU5PhrYIPiOYyMvFWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ymq67zTn; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymq67zTn"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e5ef7527deso38218957b3.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729668270; x=1730273070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Myr2tE51+aIaVrbrNvhiQo69RMRtPETE5Z+5LeaPlpE=;
        b=Ymq67zTngl7EJ9RUbmubFaBGU8YGBhU4xppaIqRlfLRarR0fLlfDzNF5AhJwmTxBfV
         iYWsucAnFPFEDb6slLmevsElJfrAYRsvPCbA8B+ZO1PyRAvsOxAjeWycLov0IKprEHBt
         IPUPK53ejX+IfGOYqW/SZcb2DuPZNGSVSNVWqF8fN8v5Vkl2thuKYBeatpApd7S64a3E
         p2Pun0RjwOG3goRInJqDCLxCN0/CZlYCivCRYikoM9TPzuJ/7RdjE10Jl6v2YshxcHRO
         Hxqb0xLb5eRKykWrgCdcfRp0DVMMmJoVz9zqlNwPCWrdTzDOFIoGFcp//eLHmwPDVsDB
         XHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729668270; x=1730273070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Myr2tE51+aIaVrbrNvhiQo69RMRtPETE5Z+5LeaPlpE=;
        b=R5vWwMzb8V02rt9yuubdlNIyP05JhF0P2Qk1TetPzzjPOkt9zn7MLerXcFt5VvwPp5
         YakObQ69EGMhO8gcWh03p3dr8NQUt2KNKAsFEeVWulJydmaMJfU5fVthE9h06vSMgxpV
         oxDS5E9a17ElAZ/taTC9V+2jiLK6OKYH/AT/AB3vU06JPqyfizCaAdAAV4FkmOXzhTZn
         xipXAylMCihJMMIB3H7uHSgTxupmfTvF5MP4QftxTH3QZYKh4y3jrPvisEzKUqWL8SRJ
         hVEgZsKzDBjuFxnS4v2qxFu9nMq0iXOzfVaL9JQVjif2MqBl1sebmOFyeZ7ZlNOvCkQy
         yctw==
X-Forwarded-Encrypted: i=1; AJvYcCW7xO6nzyKymvdp1729TmudAKX17gecGVewfM8sfJ7koMnMZW3HFMEcWtUXJj3wCgpoqBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH16uc2S/tUYgrlUL5EYk7yTJq9VI7xppTm04oi26AZsAzNYzz
	RYefXKcY+gUN+MwgMhpedT0D8DvNltuT0dO0f5wYrAx2LjIHR4Zkpl0YzVXmJAP6wdYr+vlaCwE
	X/pv1LVvbuog2ABGH0SQ329L6AEkYGoXepH5Mng==
X-Google-Smtp-Source: AGHT+IH1BWXXvKMkg0u4rHd0DXnKC615UCSvpB1TCt/Ny/LR4J4+b64Qe0sX6KcDrlKeAohDhC+R/dQKpmmK8hiCA4Y=
X-Received: by 2002:a05:690c:4f03:b0:6e3:36fd:d985 with SMTP id
 00721157ae682-6e7f0e44a6dmr12046887b3.23.1729668270311; Wed, 23 Oct 2024
 00:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019163439.274656-1-kuforiji98@gmail.com> <cb88194a-15d2-4c3d-8768-189853572ac0@app.fastmail.com>
 <ZxZDFyKxTn_D7c3o@pks.im> <CAGedMteMtaOvyE2gX59bMudEUmCZw7nOh=MuDRi=7CbYm-gBDQ@mail.gmail.com>
 <ZxaySpwA7jg7c1aw@nand.local> <CAGedMtea3_65wuOc1c548TC1x=ThirB1gC8p6kTomwWf_VzDng@mail.gmail.com>
 <ZxiC06eY4mMh1Xun@pks.im>
In-Reply-To: <ZxiC06eY4mMh1Xun@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Wed, 23 Oct 2024 08:24:18 +0100
Message-ID: <CAGedMtdN8qRRALiYdCFso90ExGEm0zirnpLXuva_bc8ehsK+Xw@mail.gmail.com>
Subject: Re: [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 06:00, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Oct 22, 2024 at 06:11:17PM +0100, Seyi Chamber wrote:
> > On Mon, 21 Oct 2024 at 20:58, Taylor Blau <me@ttaylorr.com> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 06:17:06PM +0100, Seyi Chamber wrote:
> > > > Yay!
> > > >
> > > > Thank you for the feedback @Patrick Steinhardt @Kristoffer Haugsbakk
> > >
> > > Thanks, all. Let's start merging this one down.
> > >
> > > Thanks,
> > > Taylor
> >
> > Thanks, Taylor!
> >
> > I've also discovered that the test script t9101-git-svn-props.sh also
> > requires the same update done in this patch.
> > Is this test script currently being worked on? @Patrick Steinhardt
>
> Not that I'd know of. I typically double check via lore by searching for
> the relevant subsystem [1]. This only surfaces your mail and the Meson
> patch series, so at least nobody else has communicated intent to work on
> it.
>
> Patrick
>
> [1]: https://lore.kernel.org/git/?q=t9101

Thanks, Patrick.

In the future, would you prefer I still run it by you before working
on a test script,
or should I apply the same strategy you mentioned in your reply?

Regards

Seyi
