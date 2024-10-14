Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F71AA79A
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930024; cv=none; b=Lwmx+JjhFIDua6pcrJuMyvGcCKEzc8+3QGtQQIfHb/A68jZkAn5JwmxCnvlhrbK55X5zfkvhoFi8XerBWFiR+rj3tiTNVBG8ZZugaj7TeOPBuWOMZ55neOr+AHYTvo6U+GlNKbX+NpBleqdH0dbIOdR2dS5SjNZc22mSkmNUYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930024; c=relaxed/simple;
	bh=aE9CTvq9R9xEVMzIlN7bs0tUdyL817q5t8hT824LVtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE4Mn6O8wRZvTlnJn/7ckVBoVtvuP6mTnLWm5LYi0rKoBeUzOwp6zvnyGp/nq4K67GR/3RYHqFkkQ67Ahj1e7dYMrxVx4SDdOQNc9m0t92XIeU71FeOnaP0xtHclwsyyUX9zr1LjeCnUxp74DPKkuc88vOkF52ASF15YX1ASbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJ54BaWz; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ54BaWz"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84fe06fbdc6so980653241.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728930021; x=1729534821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Klwkb5WRxs7hFzxfzDyemiy5HMP0Hixud4NfI0IViYA=;
        b=fJ54BaWzLBSSU3NtzZHIaSYqGtAFdDITG0v6NiMQH1dtwKiP6o+NhV3SnHP5wn+qX9
         /vtz3Chtgx+w7FSBFiX+WB7HGkg45fg0UX2MLiY5vXRp/OtDNk5it77w/FV8dCnjgWG4
         50Q51b39aABXc5aA/16ofewgqYyXEri1AHiy8KT4XYsDvFeCkVyhYo+sEJadMY8QaW1b
         kuyIoHXuWjByZNlWKbmyEzSqumN3GauWoLi7YGGZfBNkktDf4QJembHbUgzzmxfCUwQ+
         c3y3mUjXihr0lOUj7gjntufgjsKZ+KUQh0BgykiF1ATMba7jNbYi/E9tDL0R3apybi5J
         l22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930021; x=1729534821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Klwkb5WRxs7hFzxfzDyemiy5HMP0Hixud4NfI0IViYA=;
        b=XS+zkImWSUmgcBbb2cpW9JMQZlBpgLM1XFdrsd80ZmzSCtLI1MHpDSc0BL6zFra43S
         /EikIqmZmuaeSbKLEtTS1iETJPa8NmWHD1MiBbwUSR+22UebjUuHhSgSVkEg01P8yY3j
         cVScZNMzaHVfV5pJ5NR43+Tm3SXQQR6GnfgJUf77CwbG4GGmm8fqXANC0UJDNlbAFhc8
         i4Ya8Shq8h8A2UFMcLxNxfJGAiWBT8GYWgCoAFokZb2gMdTBbt3dquFm8kajPg2LfY0r
         rBthY5qQYUyDNMzXFd9m3ydjIzm3/bhscw9GOGWrmlyr6CnkGuq7IgclU8e+ZOdAC0dy
         jRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRU6m63BoBj31cMQHMOYbM3ogZuFU6u5PyfR7CQZJZStBW7LcEGXwIY+SQjx1dDPpOLpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKQAk/k4XK/qPRgmJXaEPdB0TNurPv8HEDD8dFjgBcc5DDVH/
	g8cTISBNtbsFUuGXIS40nSZVAMUA+htmWhpUA0asx7tv43nVFgF6PlHoNcrIHZqj21XGL9I7GjW
	Sje9mltZWO/M8f6FVLy4qV480LwE=
X-Google-Smtp-Source: AGHT+IE0XAsijsNkgsLsZRy3S9duohVj/hQ8PLEZqXIeCns5kmj7RkBJzC8dLkB2Uc6lviKENLM0e0PPy2NPVZpgmic=
X-Received: by 2002:a05:6122:2206:b0:50c:f0c9:d995 with SMTP id
 71dfb90a1353d-50d1f4d21e1mr7972989e0c.7.1728930021257; Mon, 14 Oct 2024
 11:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <6875cb49-becc-4562-ace8-9f07848a345c@gmail.com>
In-Reply-To: <6875cb49-becc-4562-ace8-9f07848a345c@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 14 Oct 2024 18:20:09 +0000
Message-ID: <CAPSxiM_+1C3upsEzqj0reMgxT5viw5K9qKQq9=eBgVSO2MK3eA@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: phillip.wood@dunelm.org.uk
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:49=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Usman
>
> On 13/10/2024 00:09, Usman Akinyemi via GitGitGadget wrote:
> > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
> > and strtol_i() for signed integers across multiple files. This change
> > improves error handling and prevents potential integer overflow issues.
>
> This paragraph is good as it explains why you are making this change
>
> > The following files were updated:
> > - daemon.c: Update parsing of --timeout, --init-timeout, and
> >    --max-connections
> > - imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
> >    tags
> > - merge-ll.c: Enhance parsing of marker size in ll_merge and
> >    ll_merge_marker_size
>
> This information is not really needed in the commit message as it is
> shown in the diff.
>
> > This change allows for better error detection when parsing integer
> > values from command-line arguments and IMAP responses, making the code
> > more robust and secure.
>
> Great
>
> > This is a #leftoverbit discussed here:
> >   https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yNZzdA=
aa5CGTNGFE7hQ@mail.gmail.com/
> >
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> >
> > Cc: gitster@pobox.com
> > Cc: Patrick Steinhardt <ps@pks.im>
> > Cc: phillip.wood123@gmail.com
> > Cc: Christian Couder <christian.couder@gmail.com>
> > Cc: Eric Sunshine <sunshine@sunshineco.com>
> > Cc: Taylor Blau <me@ttaylorr.com>
>
> We do not tend to use Cc: footers on this list. Also note that as there
> is a blank line between the Signed-off-by: line and this paragraph the
> Signed-off-by: will be ignored by git-interpret-trailers.
>
> > ---
> >   daemon.c    | 14 +++++++++-----
> >   imap-send.c | 13 ++++++++-----
> >   merge-ll.c  |  6 ++----
> >   3 files changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/daemon.c b/daemon.c
> > index cb946e3c95f..3fdb6e83c40 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -1308,17 +1308,21 @@ int cmd_main(int argc, const char **argv)
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--timeout=3D", &v)) {
> > -                     timeout =3D atoi(v);
> > +                     if (strtoul_ui(v, 10, &timeout) < 0) {
>
> For functions that return 0 or -1 to indicate success or error
> respectively we use "if (func(args))" to check for errors.
>
> > +                             die("'%s': not a valid integer for --time=
out", v);
>
> "-1" is a valid integer but it is not a valid timeout, maybe we could
> say something like "invalid timeout '%s', expecting a non-negative intege=
r".
>
> > +                     }
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--init-timeout=3D", &v)) {
> > -                     init_timeout =3D atoi(v);
> > +                     if (strtoul_ui(v, 10, &init_timeout) < 0) {
> > +                             die("'%s': not a valid integer for --init=
-timeout", v);
>
> The comments for --timeout apply here as well
>
> > +                     }
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--max-connections=3D", &v)) {
> > -                     max_connections =3D atoi(v);
> > -                     if (max_connections < 0)
> > -                             max_connections =3D 0;            /* unli=
mited */
> > +                     if (strtol_i(v, 10, &max_connections) !=3D 0 || m=
ax_connections < 0) {
>
> This is a faithful translation but if the aim of this series is to
> detect errors then I think we want to do something like
>
>         if (strtol_i(v, 10, &max_connections))
>                 die(...)
ohh, what I understand in this part of the code is intended to set
max_connections to 0 if the value it is currently set to is invalid,
such as containing letters or being negative. Your suggestion implies
that we should return an error to indicate that letters are not
accepted.
>         if (max_connections < 0)
>                 max_connections =3D 0; /* unlimited */
>
> > +                             max_connections =3D 0;  /* unlimited */
> > +                     }
> >                       continue;
> >               }
> >               if (!strcmp(arg, "--strict-paths")) {
> > diff --git a/imap-send.c b/imap-send.c
> > index ec68a066877..33b74dfded7 100644
> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -668,12 +668,12 @@ static int parse_response_code(struct imap_store =
*ctx, struct imap_cmd_cb *cb,
> >               return RESP_BAD;
> >       }
> >       if (!strcmp("UIDVALIDITY", arg)) {
> > -             if (!(arg =3D next_arg(&s)) || !(ctx->uidvalidity =3D ato=
i(arg))) {
> > +             if (!(arg =3D next_arg(&s)) || strtol_i(arg, 10, &ctx->ui=
dvalidity) !=3D 0) {
>
> The original is checking for a zero return from atoi() which indicates
> an error or that the parsed value was zero. To do that with strtol_i()
> we need to do
>
>         || (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity)
>
> The IMAP RFC[1] specifies that UIDVALIDITY should be a non-zero,
> non-negative 32bit integer but I'm not sure we want to start change it's
> type and using strtoul_ui here.
>
> [1] https://www.rfc-editor.org/rfc/rfc3501#section-2.3.1.1
>
> >                       fprintf(stderr, "IMAP error: malformed UIDVALIDIT=
Y status\n");
> >                       return RESP_BAD;
> >               }
> >       } else if (!strcmp("UIDNEXT", arg)) {
> > -             if (!(arg =3D next_arg(&s)) || !(imap->uidnext =3D atoi(a=
rg))) {
> > +             if (!(arg =3D next_arg(&s)) || strtol_i(arg, 10, &imap->u=
idnext) !=3D 0) {
>
> The comments above apply here
>
> >                       fprintf(stderr, "IMAP error: malformed NEXTUID st=
atus\n");
> >                       return RESP_BAD;
> >               }
> > @@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *c=
tx, struct imap_cmd_cb *cb,
> >               for (; isspace((unsigned char)*p); p++);
> >               fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
> >       } else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
> > -             if (!(arg =3D next_arg(&s)) || !(ctx->uidvalidity =3D ato=
i(arg)) ||
> > -                 !(arg =3D next_arg(&s)) || !(*(int *)cb->ctx =3D atoi=
(arg))) {
> > +             if (!(arg =3D next_arg(&s)) || (strtol_i(arg, 10, &ctx->u=
idvalidity) !=3D 0) ||
> > +                     !(arg =3D next_arg(&s)) || (strtol_i(arg, 10, (in=
t *)cb->ctx) !=3D 0)) {
>
> And here
>
> >                       fprintf(stderr, "IMAP error: malformed APPENDUID =
status\n");
> >                       return RESP_BAD;
> >               }
> > @@ -773,7 +773,10 @@ static int get_cmd_result(struct imap_store *ctx, =
struct imap_cmd *tcmd)
> >                       if (!tcmd)
> >                               return DRV_OK;
> >               } else {
> > -                     tag =3D atoi(arg);
> > +                     if (strtol_i(arg, 10, &tag) !=3D 0) {
>
> To check for an error just use (strtol_i(arg, 10, &tag))
>
> > +                             fprintf(stderr, "IMAP error: malformed ta=
g %s\n", arg);
> > +                             return RESP_BAD;
>
> This matches the error below so I assume it's good.
>
> > +                     }
> >                       for (pcmdp =3D &imap->in_progress; (cmdp =3D *pcm=
dp); pcmdp =3D &cmdp->next)
> >                               if (cmdp->tag =3D=3D tag)
> >                                       goto gottag;
> > diff --git a/merge-ll.c b/merge-ll.c
> > index 8e63071922b..2bfee0f2c6b 100644
> > --- a/merge-ll.c
> > +++ b/merge-ll.c
> > @@ -427,8 +427,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_bu=
f,
> >       git_check_attr(istate, path, check);
> >       ll_driver_name =3D check->items[0].value;
> >       if (check->items[1].value) {
> > -             marker_size =3D atoi(check->items[1].value);
> > -             if (marker_size <=3D 0)
> > +             if (strtol_i(check->items[1].value, 10, &marker_size) !=
=3D 0 || marker_size <=3D 0)
>
> Here I think we want to return an error if we cannot parse the marker
> size and then set the default if the marker size is <=3D 0 like we do for
> the max_connections code in daemon.c above.
>
> >                       marker_size =3D DEFAULT_CONFLICT_MARKER_SIZE;
> >       }
> >       driver =3D find_ll_merge_driver(ll_driver_name);
> > @@ -454,8 +453,7 @@ int ll_merge_marker_size(struct index_state *istate=
, const char *path)
> >               check =3D attr_check_initl("conflict-marker-size", NULL);
> >       git_check_attr(istate, path, check);
> >       if (check->items[0].value) {
> > -             marker_size =3D atoi(check->items[0].value);
> > -             if (marker_size <=3D 0)
> > +             if (strtol_i(check->items[0].value, 10, &marker_size) !=
=3D 0 || marker_size <=3D 0)
>
> And the same here
>
> Thanks for working on this, it will be a useful improvement to our
> integer parsing. I think you've got the basic idea, it just needs a bit
> of polish
>
> Phillip
>
