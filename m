Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF63D7D90
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200507; cv=pass; b=g5iMmXi0A7VHyPEMW77MnSXNhw5Zpp9YWig0V9gX4ZsFavjWtdI9ixLhF2nD973ANEWx3Il/cIoKNdskB7NTYxG6XDHReJw/XPkWverafey35niiYflQvogPZVAJCL3sz2hzv/OSoVBRWMragEAzahAxy7hDeFcHloxiMHTnLBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200507; c=relaxed/simple;
	bh=QG8Q2ExeXELLJTM4TkPYGCl/8D2/0/5hVqcuRz0AkIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3+dIxynoh71r214jgXroVhmCtNzAw0eOSKao3pEXZ3ztyQok+X/PxFui2NtdLC+rrxYgh7BoDKmYopEzUMck51bprS98QeSG0MbX/p5y48qAXnkq1U8p0ixIZoNGyhmbt9EP3xYILon/m7ARadkLyn7PEh51p7EWCI9IL97tsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw9u2O06; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw9u2O06"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124899ee9d3so572047c88.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 02:21:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770200507; cv=none;
        d=google.com; s=arc-20240605;
        b=Vj185fdPalJ0ISEJjectyzO6DVwmmU1pOE0eEzAHb467RaGoGANMWMn4mLX1R/Q4pe
         rnAs+7x3CevVSNjH5Z+GlrLPxiaVtOpEcfswJgX9Qo3tGyci1EXnHd7141Q7A8kan0NT
         b+oA74xjNWoftK561MOJfvHunWT75p3KUNNGN5GHZ3h+nXReurDa5tB73yzs4aUoe3lF
         ftUYwGPLOgf+H5FJHjzLmzuyzwcEd+EHglo2A/HGg0K94HslDLoxjgjeqIgUwdW5/xoy
         27CWdtanH3Cmi/kA1ZqUWVbb2JXZ3vroVzZbMSZ2tXeirq263kcgQ2HUsawjubAEtg+1
         7onA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMHKEtp0ryAT3Imwn2j0uZVyD5GSpkLphZwm9x1VBDk=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=RFqJEkJFgWlzgVzs7K9eGUeqrPmxcK0GrwCkPu3P2sLr25cvzvyw5l+OH8yEzINjgP
         ZVzFCWlV01L9dajBOZkNlASjPi0dAzOhRx7eWVV7AA2gkffK5I8ynQej6lZsmVImFKtj
         AsgsMNYBd1lMTL1mptf2eheWpul44l4cf6fyhkQ+kV32/bgDU+rhIzDjg4VWJUz7zcuK
         Bji3AezPr/HG4QoAT1CNAubLj/44e1gNkeRqSjM+1sXz0y9nRm4Nx7ai4BJnQF9z7gUs
         y9XjLkcBtHivqx+Y33zemIqqA5+jHexfSh171u1JqCqZx8IvHtNruitA0aVdLp/gA4Vx
         2s0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200507; x=1770805307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMHKEtp0ryAT3Imwn2j0uZVyD5GSpkLphZwm9x1VBDk=;
        b=Bw9u2O068+mPagpmzkH9xEG2xRz3mwXOCsvNibVGnSmam8/tGbyQEmUztEpc/WC/EF
         T/osc9igfmuEAj7dqNdZiBIOzbhZU1Qr8E01w7BH5Cg2YnxXT6oqnVPkh4f32vbklXZ2
         1nB7WaoZh0LC6vQWCJeA3PBnb4NS+eBxcga+j2YoRM7Z45fLKFsfhAZbhdKLgRT81ehT
         YhBeAhwwgONQvLZYBNs4oURnzR/jfW5kiQpof4jwk/yqK6XXNIzyvMXKm1sr1GWyd0am
         sDnsVqAZYIVyWWWKM9gYGuihYExaBGWVxTZ5OZJiMICPDEdnjS9vNe49yJW5vP71KPoB
         D7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200507; x=1770805307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMHKEtp0ryAT3Imwn2j0uZVyD5GSpkLphZwm9x1VBDk=;
        b=PXgiUtQ0Rw2EhbGVIuYvMwGccaPyql2kyTs01N+68kAc03cXcf2FoOOOy1umc9v/rq
         kSzzHMyLJH+Y/CASDNpKCGQKk3jMMPiPSzpLXXZh+BUhrB7u57zINewRcGv3nmQhEv77
         hwPRg3CT08f/MTzEFgHnkTgWpxZxCWBbZO/SYabmQjHascJFWb4K4DeMCjhVimLGxWDQ
         N/3VTheXrOmG2MRqeaAs2Pcfzs3Hk8u3hPGIWYZyA5dwCMFItbw0FYxvBHdWuX+nn/gX
         4+TuRrgujHzXueyHduHzQXnzsiAnEGi4ywv116oRFZAoSMhFeql6clLaA4pIE1UawF/T
         O11g==
X-Gm-Message-State: AOJu0YxGY67ehjEr8d4CBBgRwuoCnuVDjNnAXzvn4vopvKgLgdcaXcmK
	YtmsXKnGDwU/BOmlAPTGII2fUqzJwrhTmYpjFhkTUHInTOBLLfua6xxJIrw+AReHfj3oYWDYCfl
	+2cXJMbaugrfh3XKJMKdIw625WLgJQ4M=
X-Gm-Gg: AZuq6aKLsvZZXaHb86GtHf5s+AJWedH6MBeeApozHGv5s1KJVZ/ejxGaU/7cUCPuQR1
	CwYo88QDY9sijQb9qq+lH4P9kJ5obPjon3l4QiwfMw5uO7SIMaF4jbnqWrHxXgWHxnr1YlZI1KD
	4yZJQUeHuU1IiDLioOcdqDg9TADJnQlSYVw79HNgN4im1T74HZbAYLsLEG5aOtxJnLFyJd+Orva
	GYn/tDiIEH919bSA8+LNnPWjXb51UtI6ghM2rxJ+Jm0vSzkvdi/HdyIu/MNZAL0bwOL9izUncyU
	Ugd0zI8c/aDyT7UpP/6vFspRzhtcUI1FkrNGNJz7VlUWSH/3sb+0f34T
X-Received: by 2002:a05:7022:6b98:b0:123:3673:8459 with SMTP id
 a92af1059eb24-126ea92ebfemr2217697c88.12.1770200506684; Wed, 04 Feb 2026
 02:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-7-christian.couder@gmail.com> <aV4v6_DFJtraLlPI@pks.im>
In-Reply-To: <aV4v6_DFJtraLlPI@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 4 Feb 2026 11:21:34 +0100
X-Gm-Features: AZwV_QjfyngxCStS6cLq4fqvRz9k9PwKkam3cGvB0OFB4yq_LucBTWf2EfH1JsE
Message-ID: <CAP8UFD2Nf4N2BUwZVtSDLH3Uu+UkGY67wmevwc4CoBN3jnqWCg@mail.gmail.com>
Subject: Re: [PATCH 6/9] list-objects-filter-options: support 'auto' mode for --filter
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Dec 23, 2025 at 12:11:10PM +0100, Christian Couder wrote:
> > In a following commit, we are going to allow passing "auto" as a
> > <filterspec> to the `--filter=3D<filterspec>` option, but only for some
> > commands. Other commands that support the `--filter=3D<filterspec>`
> > option should still die() when 'auto' is passed.
>
> Okay. I assume the idea is that the user can eventually say `git clone
> --filter=3Dauto`, and Git would automatically pick the best filter
> advertised by the remote. Sounds reasonable to me.

Yeah, that's the idea.

> > Let's set up the "list-objects-filter-options.{c,h}" infrastructure to
> > support that:
> >
> > - Add a new `unsigned int allow_auto_filter : 1;` flag to
> >   `struct list_objects_filter_options` which specifies if "auto" is
> >   accepted or not.
> > - Change gently_parse_list_objects_filter() to parse "auto" if it's
> >   accepted.
> > - Make sure we die() if "auto" is combined with another filter.
> > - Update list_objects_filter_release() to preserve the
> >   allow_auto_filter flag, as this function is often called (via
> >   opt_parse_list_objects_filter) to reset the struct before parsing a
> >   new value.
> >
> > Let's also update `list-objects-filter.c` to recognize the new
> > `LOFC_AUTO` choice. Since "auto" must be resolved to a concrete filter
> > before filtering actually begins, initializing a filter with
> > `LOFC_AUTO` is invalid and will trigger a BUG().
> >
> > Note that ideally combining "auto" with "auto" could be allowed, but in
> > practice, it's probably not worth the added code complexity. And if we
> > really want it, nothing prevents us to allow it in future work.
>
> I guess the question is what this would even mean, and I cannot think
> of any benefit to allow `--filter=3Dcombine:auto+auto`. So agreed

We could allow `--filter=3Dcombine:auto+auto` to mean the same as just
`--filter=3Dauto`. But I also don't see a benefit to allow this now.

> > If we ever want to give a meaning to combining "auto" with a different
> > filter too, nothing prevents us to do that in future work either.
>
> So basically the case where the user knows that they definitely don't
> want blobs, and in addition they want to pick the best filter advertised
> by the server? Yeah, that sounds like it could eventually be a nice
> addition.

Yeah, but I think it's also not needed for now.

> > diff --git a/list-objects-filter-options.c b/list-objects-filter-option=
s.c
> > index 7420bf81fe..f13ae5caeb 100644
> > --- a/list-objects-filter-options.c
> > +++ b/list-objects-filter-options.c
> > @@ -52,7 +54,17 @@ int gently_parse_list_objects_filter(
> >       if (filter_options->choice)
> >               BUG("filter_options already populated");
> >
> > -     if (!strcmp(arg, "blob:none")) {
> > +     if (!strcmp(arg, "auto")) {
> > +             if (!filter_options->allow_auto_filter) {
> > +                     strbuf_addstr(
> > +                             errbuf,
> > +                             _("'auto' filter not supported by this co=
mmand"));
>
> Tiny nit: the indentation looks a bit weird here.

I have changed it. Hope it's better now.

> > @@ -146,10 +158,20 @@ static int parse_combine_subfilter(
> >
> >       decoded =3D url_percent_decode(subspec->buf);
> >
> > -     result =3D has_reserved_character(subspec, errbuf) ||
> > -             gently_parse_list_objects_filter(
> > +     result =3D has_reserved_character(subspec, errbuf);
> > +     if (result)
> > +             goto cleanup;
> > +
> > +     result =3D gently_parse_list_objects_filter(
> >                       &filter_options->sub[new_index], decoded, errbuf)=
;
> > +     if (result)
> > +             goto cleanup;
> > +
> > +     result =3D (filter_options->sub[new_index].choice =3D=3D LOFC_AUT=
O);
> > +     if (result)
> > +             strbuf_addstr(errbuf, _("an 'auto' filter cannot be combi=
ned"));
>
> Nit: let's maybe also add the `goto cleanup` here. I'm not a fan of
> leaving it away for the final statement as it makes it easy to forget
> backfilling it in case this function needs to be extended in the future.

Ok, I have added the `goto cleanup`.

> > @@ -317,6 +345,7 @@ void list_objects_filter_release(
> >       struct list_objects_filter_options *filter_options)
> >  {
> >       size_t sub;
> > +     unsigned int allow_auto_filter =3D filter_options->allow_auto_fil=
ter;
> >
> >       if (!filter_options)
> >               return;
> > @@ -326,6 +355,7 @@ void list_objects_filter_release(
> >               list_objects_filter_release(&filter_options->sub[sub]);
> >       free(filter_options->sub);
> >       list_objects_filter_init(filter_options);
> > +     filter_options->allow_auto_filter =3D allow_auto_filter;
> >  }
>
> Why do we do this extra step to restore the `allow_auto_filter` option
> here? Are there any callers that reuse the filter after it has been
> released?

As you noticed below, list_objects_filter_release() doesn't just
release resources but actually resets the state. That's because the
filter options are indeed reused during command-line parsing.

In cmd_clone() a single `struct list_objects_filter_options` called
"filter_options" is declared and then pointers to it are passed to a
number of functions. In particular, opt_parse_list_objects_filter()
handles the `--no-filter` case by calling
list_objects_filter_set_no_filter() which calls
list_objects_filter_release().

So yeah, if the user runs something like `git fetch --no-filter
--filter=3Dauto`, then "filter_options" is reused when `--filter=3Dauto`
is processed, so after it has been released.

Also note that the `allow_auto_filter` field is a configuration bit
set by the command (e.g., cmd_fetch) before parsing begins. It
indicates that the command supports the 'auto' mode. It's not data
provided by users, so it doesn't change depending on which filter
related options are passed.

I have added the following to the commit message:

"Also note that the new `allow_auto_filter` flag depends on the command,
not user choices, so it should be reset to the command default when
`struct list_objects_filter_options` instances are reset."

> In any case, this function does have clearing semantics as it also knows
> to re-init the filter options. So it's somewhat misnamed and really
> should be called `list_objects_filter_clear()` according to our coding
> guidelines. That's certainly outside the scope of this patch series
> though.

Yeah, it can be done separately.
