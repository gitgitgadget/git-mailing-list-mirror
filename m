Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC22261390
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855976; cv=none; b=X/uCkymAEuIertcr3FEZUDCtklSo8HtvXPQKBzbuPoqETf0R3s6PgN5FgQJZjQezFShOS1lFbc8hdLYngKSrUgdRfc+yGw3+syJurNaBfhsCQz8reEhGDTYM9f6zxWGVIY6kDCUtE8qat3hxMq5KKqWKA53wmDQ+Wgg6suR9CD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855976; c=relaxed/simple;
	bh=W0ZFrpzj+xp5uQjjvQeDr6dQru9qaVzbcnmwjQQNWmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAMO2+QFBYxC6jwPBt87ejhgMCcN3o6iuxEeJ4Mk+jaWOxrMbR1gPea8w5YLsknbqbuZvb81I4YL9ixii6iq5tZQKsyG2O4LEHjHbZFCH/XwRQ0/zcy2YlH1Jt7KolO6BRAHmITaykN83Y8Qrnvp8a8S4PsvNVq5mMTwJA6osNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKV26cn3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKV26cn3"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adb2e9fd208so274240066b.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855973; x=1751460773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=102DHRfy7zcBs/OvhHKOw8dODjbWQfpOlGqS3z2dYDA=;
        b=jKV26cn3rNn/nkNvyH5fZfOZOoS273Nu+ZI3GQOQ5UmxzddK7lb+ZKfxntBVYh+/GR
         Qjqk3X/5K1jwbH1zuASxecvhIZGYnd91F3TX+pX/TJR1/WJ4u5PWU/r7AFTXemhn9Bbu
         VbG5FEjVu27n22Fi30KGgjZhz1TTLz4Y4nhUinbs5zETMQUc8R5auVu3ySABsU1uy4MR
         WyWTVdNSFIS1y/D0/5lkdk1AY4kNaWF25WZ0yuDB73GFaJUpXYOfMMie43SGWT68M9d+
         +Clx9e4yvCO8WBlfDeq+NZcejbPMNBPrLgKKspjX8tcE8o1+XnlWmgTYdZFeWkxWWhO1
         mpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855973; x=1751460773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=102DHRfy7zcBs/OvhHKOw8dODjbWQfpOlGqS3z2dYDA=;
        b=EGdXwWgD0nfe8j7HyUx/z1S03BaCg0RlVuPn395Z1XtsbcCJhP4kWgqbsrq+E1+7zM
         TainnLyG220oUebXvHFqVv6Y16MF0NXHqvaLdn694a1sw/tsJLlB/sjSEUceIdvo2OX0
         FYdpiCPmQff4zP9L6WEVl8FsrUa8n6vrHP2bsls1XRjNnaf/gfvZtSPqC3CFrWf9//57
         ID/MzodcDfPC8Su5O1hU+6mNN64HxCd52BvxoLHDur3fHJWCLmA+n2aORW5f27hBXOYB
         thcT4NTFVTihsv+1IGngjVOWLO24M3Vl0UbK4ym3wUf1RX6GRq4eHZEuV6bplEsNDjUX
         8nyA==
X-Gm-Message-State: AOJu0YwUPhMeUAkgotnYs6SO5IX4PIY0tqjT4R+V9EBjY/fUpkDhfiyK
	i+2MEztwkOWlxzO620pEQq3qEE6aMDamlTLB+kCwed+ULSJK+iQi/ig+pLu0JEaXdRL6WQTlbhb
	fhvRz4ZYndS9A/sGUXTio/LLhr/DvZsM=
X-Gm-Gg: ASbGncv0KbA0Y8B828M5mB5yd/YtWQ5QN4asbSg57z323KfbGRUPadJduXOUDpDC3/h
	D0BNBI+I+9tQTMhrE5TnY9xs4PZF9iXY9cFr0+x7FOmSGCeBZECa2NIbvILAbxmjRkuropRmisE
	NMEWXUqWAdamD3K9iYOPY1vGjc/dkLTJKwWRJNYCbSKlydkg==
X-Google-Smtp-Source: AGHT+IF/wzXyVIUDXKud5VFbY0We5wIWLXpImidiqCUDtN49g/biwcJ8wz5dtIAkNePMm8EaTVqtGuaWH409mWK7BNA=
X-Received: by 2002:a17:907:9622:b0:add:ede0:b9d4 with SMTP id
 a640c23a62f3a-ae0beca03f0mr300891866b.0.1750855973007; Wed, 25 Jun 2025
 05:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com> <20250611134506.2975856-2-christian.couder@gmail.com>
 <2z3uanklsfnrgxmiqjt2innv2diownbpwtgcj67bi7udwjdqpg@ackusinuz7c6>
In-Reply-To: <2z3uanklsfnrgxmiqjt2innv2diownbpwtgcj67bi7udwjdqpg@ackusinuz7c6>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 25 Jun 2025 14:52:40 +0200
X-Gm-Features: Ac12FXxHgSAEJpEywrcNvNyvTFg-7fNVV_DFJmg8ZwIKBu52EA9pjK6n1SXoq5s
Message-ID: <CAP8UFD1LxX966Cd__AUg=trOWPc6-2K55-diarEU4Z69zLNtgg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] promisor-remote: refactor to get rid of 'struct strvec'
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 9:43=E2=80=AFPM Justin Tobler <jltobler@gmail.com> =
wrote:
>
> On 25/06/11 03:45PM, Christian Couder wrote:

> > It will only store promisor remote information in its members. For now
> > it has only a 'name' member for the promisor remote name and an 'url'
> > member for its URL. We will use use a 'struct string_list' to store
>
> s/use use/use/

Fixed in v5.

[...]

> > @@ -340,47 +372,36 @@ char *promisor_remote_info(struct repository *rep=
o)
> >  {
> >       struct strbuf sb =3D STRBUF_INIT;
> >       int advertise_promisors =3D 0;
> > -     struct strvec names =3D STRVEC_INIT;
> > -     struct strvec urls =3D STRVEC_INIT;
> > +     struct string_list config_info =3D STRING_LIST_INIT_NODUP;
>
> nit: Ok in this context, "config_info" is specific to the list of
> promisor_info not just generic git configuration. Something like
> "promisor_info_list" would be a bit more explicit, but I don't feel
> super strongly.

Yeah, it's not generic config, but it's still config, and I think
that's important to help understand what the code does when it uses
it, so we should keep "config" somehow in this variable name. For now
I haven't changed it.

> > +     struct string_list_item *item;
> >
> >       git_config_get_bool("promisor.advertise", &advertise_promisors);
> >
> >       if (!advertise_promisors)
> >               return NULL;
> >
> > -     promisor_info_vecs(repo, &names, &urls);
> > +     promisor_config_info_list(repo, &config_info);
> >
> > -     if (!names.nr)
> > +     if (!config_info.nr)
> >               return NULL;
> >
> > -     for (size_t i =3D 0; i < names.nr; i++) {
> > -             if (i)
> > +     for_each_string_list_item(item, &config_info) {
> > +             struct promisor_info *p =3D item->util;
> > +
> > +             if (item !=3D config_info.items)
> >                       strbuf_addch(&sb, ';');
>
> Out of curiousity, is it invalid for the trailing promisor remote entry
> to end with a ';'? It would be simpler if each entry could just end with
> a semi-colon.

It would work but it's not really valid.

In "Documentation/gitprotocol-v2.adoc" which specifies the protocol,
most of the time when different items are transmitted together they
are separated by SP like:

item1 SP item2 SP item3 LF

and there is no SP before the LF.

For the "promisor-remote", we need something more complex but for
consistency I think it makes sense to not repeat separators at the
end, in the same way as SP are not repeated before LF.

> > -     if (!strcmp(urls->v[i], remote_url))
> > +     if (!p->url)
> > +             BUG("bad config_info (invalid URL) for remote '%s'",
> > +                 remote_name);
>
> Ok just to clarify, it is invalid for a promisor remote to not have a
> URL specified. If so, it might be better to say "empty URL" or something
> along those lines.

Yeah, in v5 it's now "URL is NULL" instead of "invalid URL".

Thanks.
