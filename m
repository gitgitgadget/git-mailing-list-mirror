Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C82313526
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770202674; cv=pass; b=H2SVb2LCtwi+E8VWgNUY0DFhn/nsQ+6Tw7QlGslwCA8R75CYxYih2HzNUeAUm5oerygYduc4cs4AzPZIECKnxR3UK0i21MdHuNEmtLC0ShOxqnLwI7HcOjqXHnfDoLndCO2PXTds182AN6BD7ThSjZSWbSJ7plTXlnPyEUuw5b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770202674; c=relaxed/simple;
	bh=AwhygTrTIAgVa1N1ZRNud3o1zvuZF5HinsIcu7Xvgks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tt4XhtKH63Rstuad6t3SJYti0Mk4zi9VnEPuSXJDL3q1vdXhWOjLLPh2NOBaqGJF5NIHoVdWsRfav5ftaFbcz8nWT7AlTU2oC8PfzmNiG4WK6lfbVAvvvo2lXf2vKOH6gZOMmhr9EIdhylZ3NHr0HNtHPm8bRWxMGbzS3q9/41o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5SIcDzu; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5SIcDzu"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124566b6693so6028452c88.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 02:57:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770202674; cv=none;
        d=google.com; s=arc-20240605;
        b=bx5a4hKCjB4Ll4UEZdjAiXaQwroRFItojTkcvWJybyEmiv8LkIvdOMchpEDQD9YCOG
         xsHY/l0Ofy1kZl+3DQlhP6rbUqx8anyEjUc1MqQlposkL2suzQrJsYW5EM07771gX/IC
         jYDcMfPipj7xDh2OCz61FgHDfVOucfgVqRJOyaaheWJFDGBVtY+9vPYQD5rIiVI4KClO
         Q8Et4aKX0qlljutv2Omu51GlG/I6OJPqCsrFwrUlISl2GTJ6WFxDxBG32L44HPrNreva
         IXSr0lMOWFdiD2XGuy+iCpAYPAlnjuQb6iHcMAIGWN0JFe3bA6TIlSUgDi4al0q9LDrd
         txuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PlKn0d9XSOXoTnQmexH5QRiFrM8eZ0DCng2E7Yp0VXw=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=TR26MerRDJO3KsEmc0R0qXUy1UgM8BWw8n5aIpfYm2Dj2GFAOEK6gWwyIoH5SPI76c
         v2pg0zZ5eQLVM/zMzCePBJDoCnBVl3BxmJ4FijW42DSFv4nuYsSAqiVebciyQXJOQ2bi
         L5n8C0/oRtDy57mi+/RKOJv/hBkMwNAt0lycSX9vuDAtQqZEbKehpPGQcujSycmz35cW
         /D4LJMUCwmVgp0hzSMNctPsI2AB6mY6c4Wd7n0awfTFYondOhtJMSV9xUfZtT6yzL4CU
         3x9ui0LxEhciL1N+FNq0GYB4xhheBlQgPaTtfQFJjV/2R/77KqT4cYWq+xOBupQzU4Ae
         yZCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770202674; x=1770807474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlKn0d9XSOXoTnQmexH5QRiFrM8eZ0DCng2E7Yp0VXw=;
        b=h5SIcDzulKG/n1EJfF0Isyd13ygoKow4ty3Ugu2k+N7jEBJCO0J2NmzyLazD7CQRKE
         FAee+OC2qcRzNhsD+mE4jfBVxLaZEIddpsTxfA/ArkYD4XSECEORxJScsnMuA+vT4cJp
         gpmeWPLFfMmFthup5nh3W2HdgdHbyPoAoTbccCIQrNMiwErDPkOiJlck3RLIwK2EMY0+
         1WJxm6VujDAtBqDKkry6oGjMFfalhk921yLXh1hFBHuue1ugjxF70tq57QYHzJVMwObH
         SrUfZGirn/tiPR42w1ZbcbH6cvqb1MegikPJu0jTwihY4eQ1ZUPrF+KE1JAjY46k2hgh
         iaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770202674; x=1770807474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlKn0d9XSOXoTnQmexH5QRiFrM8eZ0DCng2E7Yp0VXw=;
        b=TE7sMbI21TjjvZCRAHdr7cKs0cUyhpg54M7+h5pINTvBYBb6LFSSBZdDzAnyF5s42I
         iH/svMitxJWuE2Y87QJw3J+PsIOFDl9aPuXUK/4/lP06FJvJ8rj6Afxb2yg28tZD6vxT
         bgU+P3jfb5RH0qiBFctbiWlbmWFW2BUrY2oYtYIfcAkJ2e/6F6dGQhS/FPf2l/9SnMYR
         8pFsPBrGSRZpBiHeriPK7dLQp12zPlCp+8ggmchfREm9doyqvsP7i5PuJapmbb24Ialn
         +DLcAZsn7syzINj3P2Z2L3vNfmZEpwvKcT5+9R7FHZmbHkFFJy6eaCsSJ0C8neVIHXJJ
         YF2g==
X-Gm-Message-State: AOJu0Yyw/VhoLLMCu2m5CpYJp9WeO8PmFlTebWcUcqMj0l387YYbHz9y
	W3jt8ETnUE/0UDRCLlbf0gJYWjqAXM9mB6CLJOnYxncM3r/n5KJcpLhay/98rOJW7oSleHiri6i
	JlIXAr8OWQzijRa0c8aNVkX0R0dBDs2w=
X-Gm-Gg: AZuq6aIYLDzQQLZBTpUhbqlBqhTwB848CEdkXqngEJlmhf55liqpSGenLms465FLd8X
	Hmb9Sjedyg01efwtLYYROcb+yil65THe/+Kt+0+sYvo3IEI7J2XWYekGHd6e4s51HHuqN7Mq7rz
	fHB44isXDttvZ6+wn4HY3ApKRzGsOoCILeGmfK5KIT2zOIPzFDEUkpC1kdYHoLoEQxCYwNo9t3w
	42r6LWePr/Yvy0vxXyv1MlitOMuEDfclFTywqN8DiyBzh1ryblooRQcxDiVc3IVskx4hq2cApss
	PcWi7yarzADyoRnY+bSrRzRk+PWqSfpPTYsUqgwmCd6vOrF06znfU5zR
X-Received: by 2002:a05:7022:f83:b0:123:3462:3758 with SMTP id
 a92af1059eb24-126f47c46d4mr907825c88.28.1770202673685; Wed, 04 Feb 2026
 02:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-9-christian.couder@gmail.com> <aV4v9WhL95Gcqr2t@pks.im>
In-Reply-To: <aV4v9WhL95Gcqr2t@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 4 Feb 2026 11:57:42 +0100
X-Gm-Features: AZwV_QgWmktdjTV5gquZNuwEF-jiuSO13k7vnWxbxQKN8pDO-GFgFwx2ZNXXjvE
Message-ID: <CAP8UFD1za=FowTWBqjanyRFANKBsc-+LOcbSsuBzjeiK8T_fkw@mail.gmail.com>
Subject: Re: [PATCH 8/9] promisor-remote: keep advertised filter in memory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Dec 23, 2025 at 12:11:12PM +0100, Christian Couder wrote:
> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index 8d6d2d7b76..d5f3223cd0 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -837,6 +838,7 @@ static void filter_promisor_remote(struct repositor=
y *repo,
> >       struct store_info *store_info =3D NULL;
> >       struct string_list_item *item;
> >       bool reload_config =3D false;
> > +     struct string_list captured_filters =3D STRING_LIST_INIT_DUP;
> >
> >       if (!repo_config_get_string_tmp(the_repository, "promisor.acceptf=
romserver", &accept_str)) {
> >               if (!*accept_str || !strcasecmp("None", accept_str))
>
> Nit: I found the "captured" terminology to be somewhat confusing. Can we
> maybe rename this to `advertised_filters` to clarify?

Well "advertised_filter" is already used and I think it might be
confusing to use a very similar name, so for now until we find a
better name, I kept "captured" in v2 even if it's not the best.

What about using `server_filters`?

> > @@ -935,3 +963,23 @@ void mark_promisor_remotes_as_accepted(struct repo=
sitory *r, const char *remotes
> >
> >       string_list_clear(&accepted_remotes, 0);
> >  }
> > +
> > +char *promisor_remote_construct_filter(struct repository *repo)
> > +{
> > +     struct string_list advertised_filters =3D STRING_LIST_INIT_NODUP;
> > +     struct promisor_remote *r;
> > +     char *result;
> > +
> > +     promisor_remote_init(repo);
> > +
> > +     for (r =3D repo->promisor_remote_config->promisors; r; r =3D r->n=
ext) {
> > +             if (r->accepted && r->advertised_filter)
> > +                     string_list_append(&advertised_filters, r->advert=
ised_filter);
>
> Would we ever accept a promisor remote that _doesn't_ have an advertised
> filter? If not, should we maybe `BUG()` in case the advertised filter
> has not been set?

I think it should be fine to accept a promisor remote without an
advertised filter. The server might prefer to not advertise filters
because it thinks that the client should determine the best filter
based on the client needs. That's how it works now.
