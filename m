Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B817AE19
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906138; cv=none; b=gn8hfZlxWZQb7pHxJ6Hzumi1D1/DqyPVmx9pBRSAZgXNVaYKrQh22JZKNQN6dUYiCR48RotinmX/iJVy1kiFj05vW0EeuY9mmy3QOjU9PrVza499/Ft7JAmJrI/E9zXSPDjFP8Clqn2813sc8gdv9DbiXsMdWSn+nMtJbdv0O2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906138; c=relaxed/simple;
	bh=WB22HGxQ4NKiv+t9s8YW8T5rQMh6SNVGesl5XEnOZBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRV6ejw0OZv8ZzKEDCgoobkXi8TzP/f40Nb2kCTEKsGxPKe9ygRjajjVQYvA+1DSiRocwvOIK/3PzI2EX0xw/9ic/uyTlu+tvHKyyWTDvMEcP8lZhihmLVG/EWEEjfUzSd5qMhXanZE3TZxt4aSlFA2M1sisNK2xb0Wunb4RTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf5vghwD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf5vghwD"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d88edf1340so2990509a91.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725906137; x=1726510937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91bMx1ewYTW9IeWSFH3UCJChyiE8XhgSe5gVvRrFe5w=;
        b=gf5vghwDCTq6dSnnLw87sgwUigE/vxTxOkQA7eMCLTR/hSRDIJHYa+up19/DOw+jfg
         16PmJAoLgl3i46XvSwx4WUulmheIFUki/kAkjohRz1QFJWmCGaPsHOAYHXpM1lDX5SQ8
         zBXQMfF5NSjpKZJ4AmJ6V2GZ8iEkGrZAbII6b3IjDl7hwSsL+bKUJ2lftcs6Cdq7VE7u
         VQ/QjA6asuKCazkXlqIBxIXa84bRM4bE+gEJep7MStfpgEP8RUYl1vHEmlm6X1IWDIm4
         x9iiC1EGGXabszFvtkFKT0ndq7fDLrFTc3DBkfsCLmQ4QJDcwcOH/DjblYw2EH9Ob8Jg
         8HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906137; x=1726510937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91bMx1ewYTW9IeWSFH3UCJChyiE8XhgSe5gVvRrFe5w=;
        b=Wov9KZb+BUgGsYHVRgZm6coD4iFyYGUbFRF/dWkYJp7s2wbAxspaRQdgQMlFQTiFz0
         zG3NEgb2f+6RJsDsAC0RdMF1s5oy2vSbAO1x8tyOjYQeJ47UMtm5phSEx+1IMDBt/03v
         oB0J+cBZcZUFVhfAZaDXsLpSdN3LSNQN+w+B5sok32Jv2HzehIpfS99kpXfLWtYjlCAm
         6blcg/eVeXk2rQClAe/Xal/u9X6wVEVJwp5kEh9URqfdNM786BO/7mD+PgKc9a84t8kU
         MNb3TEqxWClQBmdQp5VqPZK0Tzu7VHRfoJV+gZnCMy4PClof4mUPvsdbUumx2VQUdoL0
         a+ug==
X-Forwarded-Encrypted: i=1; AJvYcCWpf8NP2ZwTbw/rSupoHnRA5mUs9hxvNM2jFu13mb8Mf/nLq2/t3CEZ3qBwsxQwAdKJWJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZbGJQnY5/XYBbW4cru1yjc7yBbn6rHSwmgteZLdgLZOOJUJN
	YrEL5OWShB/xanMGKIcz0OLnhYdioNzqpEsHbXHjQTckxfnqh5v8Gu/iYgCIBKThCzlGqAoDTLG
	WZKT86tnUlw/JzAecrnjPpmk1AWg=
X-Google-Smtp-Source: AGHT+IHI9DaIi3vKDPRbrnyFJ15fxbws6IrAtINjjieBKhKPuKDol4lhQbZtmoiqTlw53MpLiP+mriEnNCGZy7C3Qg4=
X-Received: by 2002:a17:90b:3007:b0:2d8:f0b4:9acb with SMTP id
 98e67ed59e1d1-2dad513545emr10631409a91.34.1725906136466; Mon, 09 Sep 2024
 11:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com> <xmqqzfogsrqo.fsf@gitster.g>
In-Reply-To: <xmqqzfogsrqo.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Mon, 9 Sep 2024 23:51:39 +0530
Message-ID: <CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, "Derrick Stolee [ ]" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static void apply_prefetch_refspec(struct remote *remote, struct refsp=
ec *rs)
> > +{
> > +     if (remote->prefetch_refs.nr > 0) {
> > +             int i;
> > +             for (i =3D 0; i < remote->prefetch_refs.nr; i++) {
> > +                     const char *src =3D remote->prefetch_refs.items[i=
].string;
> > +                     struct strbuf dst =3D STRBUF_INIT;
> > +
> > +                     strbuf_addf(&dst, "refs/prefetch/%s/", remote->na=
me);
> > +                     if (starts_with(src, "refs/heads/")) {
> > +                             strbuf_addstr(&dst, src + 11);
> > +                     } else if (starts_with(src, "refs/")) {
> > +                             strbuf_addstr(&dst, src + 5);
> > +                     } else {
> > +                             strbuf_addstr(&dst, src);
> > +                     }
> > +
> > +                     refspec_appendf(rs, "%s:%s", src, dst.buf);
> > +                     strbuf_release(&dst);
> > +             }
> > +     }
> > +}
> >  static void filter_prefetch_refspec(struct refspec *rs)
> >  {
> >       int i;
> > @@ -502,8 +526,11 @@ static struct ref *get_ref_map(struct remote *remo=
te,
> >       int existing_refs_populated =3D 0;
> >
> >       filter_prefetch_refspec(rs);
> > -     if (remote)
> > +     if (remote) {
> >               filter_prefetch_refspec(&remote->fetch);
> > +             if (prefetch)
> > +                     apply_prefetch_refspec(remote, rs);
> > +     }
>
> Hmph, a separate helper function with a separate loop was something
> I did not expect to see.  Looking at the filter_prefetch_refspec(),
> it already limits what it prefetched to what we usually fetch from
> the remote, and filteres out the tag namespace.  I was hoping that
> this will _extend_ that existing mechanism, as if by default we
> have prefetch refspec "!refs/tags/*", which can be replaced by the
> configuration to say "!refs/tags/* !refs/changes/*", or positive
> ones like "refs/heads/*".  The filtering semantics should be
>
>  * a refspec whose src matches negated pattern (like !refs/tags/*)
>    is rejected.
>
>  * if the prefetch_refs has *only* positive patterns, then a refspec
>    whose src does not match *any* of the pattern is rejected.
>
>  * a refspec that is not rejected is prefetched.
>
> But the above still allows what filter_prefetch_refspec() does by
> default, without any way to narrow it down, and then adds its own
> entries.
>
> This is a half-tangent, but while studying for this topic, I noticed
> that filter_prefetch_refspec() triggers O(n) loop every time a fetch
> refspec is skipped.
>
> It all comes from 2e03115d (fetch: add --prefetch option,
> 2021-04-16) but rewriting the loop to use two pointers into the
> array seemed trivial and the result seemed a bit more readable.
>
> Your "further limit the prefetched refs with configuration" feature
> would probably replace this part of the updated code:
>
> +               /* skip ones that do not store, or store in refs/tags */
> +               if (!rs->items[scan].dst ||
> +                   (rs->items[scan].src &&
> +                    starts_with(rs->items[scan].src,
> +                                ref_namespace[NAMESPACE_TAGS].ref))) {
>
> That is, instead of "skip ones that do not store, or store in refs/tags",
> filtering using the configured value (probably implemented as a helper
> function) would be used as the condition of the if statement.
>
> Thoughts?
>
>  builtin/fetch.c | 46 ++++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>
> diff --git c/builtin/fetch.c w/builtin/fetch.c
> index 693f02b958..219302ed67 100644
> --- c/builtin/fetch.c
> +++ w/builtin/fetch.c
> @@ -436,37 +436,38 @@ static void find_non_local_tags(const struct ref *r=
efs,
>
>  static void filter_prefetch_refspec(struct refspec *rs)
>  {
> -       int i;
> +       int scan, store;
>
>         if (!prefetch)
>                 return;
>
> -       for (i =3D 0; i < rs->nr; i++) {
> +       /*
> +        * scan refspec items with 'scan', and decide to either
> +        * mangle and store it in 'store', or omit it from the result.
> +        */
> +       for (scan =3D store =3D 0; scan < rs->nr; scan++, store++) {
>                 struct strbuf new_dst =3D STRBUF_INIT;
>                 char *old_dst;
>                 const char *sub =3D NULL;
>
> -               if (rs->items[i].negative)
> -                       continue;
> -               if (!rs->items[i].dst ||
> -                   (rs->items[i].src &&
> -                    starts_with(rs->items[i].src,
> -                                ref_namespace[NAMESPACE_TAGS].ref))) {
> -                       int j;
> -
> -                       free(rs->items[i].src);
> -                       free(rs->items[i].dst);
> -
> -                       for (j =3D i + 1; j < rs->nr; j++) {
> -                               rs->items[j - 1] =3D rs->items[j];
> -                               rs->raw[j - 1] =3D rs->raw[j];
> -                       }
> -                       rs->nr--;
> -                       i--;
> +               /* negative ones are kept as-is */
> +               if (rs->items[scan].negative) {
> +                       if (store !=3D scan)
> +                               rs->items[store] =3D rs->items[scan];
>                         continue;
>                 }
>
> -               old_dst =3D rs->items[i].dst;
> +               /* skip ones that do not store, or store in refs/tags */
> +               if (!rs->items[scan].dst ||
> +                   (rs->items[scan].src &&
> +                    starts_with(rs->items[scan].src,
> +                                ref_namespace[NAMESPACE_TAGS].ref))) {
> +                       refspec_item_clear(&rs->items[scan]);
> +                       store--; /* compensate for loop's auto increment =
*/
> +                       continue;
> +               }
> +
> +               old_dst =3D rs->items[scan].dst;
>                 strbuf_addstr(&new_dst, ref_namespace[NAMESPACE_PREFETCH]=
.ref);
>
>                 /*
> @@ -478,11 +479,12 @@ static void filter_prefetch_refspec(struct refspec =
*rs)
>                         sub =3D old_dst;
>                 strbuf_addstr(&new_dst, sub);
>
> -               rs->items[i].dst =3D strbuf_detach(&new_dst, NULL);
> -               rs->items[i].force =3D 1;
> +               rs->items[store].dst =3D strbuf_detach(&new_dst, NULL);
> +               rs->items[store].force =3D 1;
>
>                 free(old_dst);
>         }
> +       rs->nr =3D store;
>  }
>
>  static struct ref *get_ref_map(struct remote *remote,

How should we handle the related `remote.<remote-name>.fetch` config?
In an earlier discussion, it was discussed that =E2=80=94
`.prefetchref` should override `.fetch` completely (instead of
patching it) which makes sense to me.
At the moment my reading is that `filter_prefetch_refspec` still
filters / modifies `remote->fetch`.

```
if (remote) {
        filter_prefetch_refspec(&remote->fetch);
}
```

So we'll need to clear refspecs and re-populate perhaps?
