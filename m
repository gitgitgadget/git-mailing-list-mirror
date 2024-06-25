Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F9135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337048; cv=none; b=d5pJSrmcni9U+cQm4jSo68iTsy2qkD9wLZhEOtfMEn+237hdfPtm69IdXLf0GjjvcQYA7EZK/QLguw7LcARYaxLAUWTDVSE/XR4QdU7aB5GXjvmolt+YWhKJIfAqJkBYIugpoovSzxvwN6SEtk4rXmYAMcZLSCY/HO92TH+RXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337048; c=relaxed/simple;
	bh=+e/5oKwd5wCqLCvzPn6RFt9z4kNeFZ2wBE/04hqPKbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0vgZj3qvjtuEyx+TA5wY4wL7JN2VtjCyr06/OJFHFnUq3wUiXjK+NSpr2iarDw2g2o+GamYmc9Gy0cLBDar+4U2vh6Vl23AxvD0/mH/fSqd33zShl9GbID5c6HIuQNjPMVYlz7z4mOPWIFTSiY2lu3D6aodzChUtRDvj0JvN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1UkOsfs; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1UkOsfs"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7ebc67365e3so222171039f.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719337046; x=1719941846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rq0MhXCDnr8uKPQb/FWKl3o1nAlurKa4irAZvR9KpCc=;
        b=B1UkOsfsTTYl8nyeUmWhZ4yWUfOoHKOqp9Au7diXBjSmbLZH5y143YIA1EbFVpg+xM
         msx0Rp+ZHrqxkR5ojK5h8Eh9V+9JKnhtfuPg4UQn/rbljbNlpyFUD+xsjitlzopoPWBo
         cRT7oR425vjsfdq6nJ7vxu9cOkhxW1lXKFEdGeDY8OgQ7GVSJXktTf6CWo5PpQFV9OkK
         o8bNgigH3qOKla3RRbLp6S7epejgBoZOD1pbDQY3Sy6wbV9syUaP+p6g4nNxeTWkCZ+p
         17UObRz4Kt7Y+uMVjF3cqnUipnRFntVuSRBQ5OT2PgZEufLzT7EKS6lJgBTNueK0Jwug
         F/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337046; x=1719941846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rq0MhXCDnr8uKPQb/FWKl3o1nAlurKa4irAZvR9KpCc=;
        b=ktCx7syYT+WrJjEgmzFeOtHsVWa/Mnh04TM6IQoRVLyveFLLMcV/qLPok4sFWnNp7Y
         rPk31hVbEw6n8Sawt25odQOnOFd8c6U0maYTz+cbBJ5uDy0+mlD3wGyJUYXKPIe4x5Qb
         PADdwsd11H3TzYHnSO9B5lbfObKW+CdMZaHkimuf03H/ggP5EPam6U9FdvImAvDw0cT1
         WpXhzjKWFT+f1KufRB0Rt8M2i0PSTVP6GN9SsmbcQ4JUQnkmbgVs390hQa5iBMBC1frB
         u4ylZOSThaYXgT4u/04td4n9sMPfS/o85danaCuyINoVKDkQ2MeoOuhvMAKhZyTD30tc
         F/nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI9lJUtGOelEAabzLDCSI1tvuE0IG7K3rC1qmYsQcYooXYL6AbGkM+30+P4csfbie8ZKMpxm4tdC6eIAOHd2hq20+I
X-Gm-Message-State: AOJu0YxW6pkNapIiv2ijWIeaN/X5yGUdEkViPH8OY7SYETKBHekRx1Bk
	MExUtCfVzUK5QS04z0auz88b29iuv5O2JtO+yx2yAJBbd9NK340vdZAly2DaU+tgfqg3KqFjXFy
	I4aaqVO9fpQOu6/0sXGbwK6EUPs8=
X-Google-Smtp-Source: AGHT+IF96ri7HJJ6mIjlUQe3I06mqMpLdkmYc3vieW2vH+WN5c+00r8eCzzBjzJJAjkU1PzVTPiemgiXgChFCK9baAY=
X-Received: by 2002:a05:6602:1585:b0:7eb:7ebd:1f93 with SMTP id
 ca18e2360f4ac-7f3a7535ecemr957055339f.13.1719337045790; Tue, 25 Jun 2024
 10:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614102439.GA222287@coredump.intra.peff.net> <20240614104203.GK222445@coredump.intra.peff.net>
In-Reply-To: <20240614104203.GK222445@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Jun 2024 10:37:14 -0700
Message-ID: <CABPp-BHdVp+4s7QN0xiXFzoimtDwMPbb4Gw=Kb5MsBoY+SNLvA@mail.gmail.com>
Subject: Re: [PATCH 11/11] remote: drop checks for zero-url case
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 4:12=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> Now that the previous commit removed the possibility that a "struct
> remote" will ever have zero url fields, we can drop a number of
> redundant checks and untriggerable code paths.

Ooh, nice.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Note for reviewers: the hunk in builtin/push.c is funny. The original
> code was:
>
>   if (url->nr) {
>         for (i =3D 0; i < url->nr; i++) {
>                 do this
>         }
>   } else {
>     do that
>   }
>
> And I removed the "do that" part along with the if/else to become:
>
>   for (i =3D 0; i < url->nr; i++) {
>         do this
>   }
>
>
> But because "this" and "that" were so similar, and because the
> indentation of "this" in the loop was now the same of the old "that",
> the diff makes it look like I dropped the first half of the conditional.

Thanks for adding this comment; was very helpful while reviewing.

>  builtin/archive.c          |  2 --
>  builtin/ls-remote.c        |  2 --
>  builtin/push.c             | 13 ++-----------
>  builtin/remote.c           | 13 +++----------
>  t/helper/test-bundle-uri.c |  2 --
>  transport.c                | 17 +++++++----------
>  6 files changed, 12 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/archive.c b/builtin/archive.c
> index 0d9aff7e6f..7234607aaa 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -31,8 +31,6 @@ static int run_remote_archiver(int argc, const char **a=
rgv,
>         struct packet_reader reader;
>
>         _remote =3D remote_get(remote);
> -       if (!_remote->url.nr)
> -               die(_("git archive: Remote with no URL"));
>         transport =3D transport_get(_remote, _remote->url.v[0]);
>         transport_connect(transport, "git-upload-archive", exec, fd);
>
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 4c04dbbf19..8f3a64d838 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -109,8 +109,6 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
>                         die("bad repository '%s'", dest);
>                 die("No remote configured to list refs from.");
>         }
> -       if (!remote->url.nr)
> -               die("remote %s has no configured URL", dest);
>
>         if (get_url) {
>                 printf("%s\n", remote->url.v[0]);
> diff --git a/builtin/push.c b/builtin/push.c
> index 00d99af1a8..8260c6e46a 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -438,18 +438,9 @@ static int do_push(int flags,
>         }
>         errs =3D 0;
>         url =3D push_url_of_remote(remote);
> -       if (url->nr) {
> -               for (i =3D 0; i < url->nr; i++) {
> -                       struct transport *transport =3D
> -                               transport_get(remote, url->v[i]);
> -                       if (flags & TRANSPORT_PUSH_OPTIONS)
> -                               transport->push_options =3D push_options;
> -                       if (push_with_options(transport, push_refspec, fl=
ags))
> -                               errs++;
> -               }
> -       } else {
> +       for (i =3D 0; i < url->nr; i++) {
>                 struct transport *transport =3D
> -                       transport_get(remote, NULL);
> +                       transport_get(remote, url->v[i]);
>                 if (flags & TRANSPORT_PUSH_OPTIONS)
>                         transport->push_options =3D push_options;
>                 if (push_with_options(transport, push_refspec, flags))
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 06c09ed060..c5c94d4dbd 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1002,8 +1002,7 @@ static int get_remote_ref_states(const char *name,
>                 struct transport *transport;
>                 const struct ref *remote_refs;
>
> -               transport =3D transport_get(states->remote, states->remot=
e->url.nr > 0 ?
> -                       states->remote->url.v[0] : NULL);
> +               transport =3D transport_get(states->remote, states->remot=
e->url.v[0]);
>                 remote_refs =3D transport_get_remote_refs(transport, NULL=
);
>
>                 states->queried =3D 1;
> @@ -1294,8 +1293,7 @@ static int show(int argc, const char **argv, const =
char *prefix)
>                 get_remote_ref_states(*argv, &info.states, query_flag);
>
>                 printf_ln(_("* remote %s"), *argv);
> -               printf_ln(_("  Fetch URL: %s"), info.states.remote->url.n=
r > 0 ?
> -                      info.states.remote->url.v[0] : _("(no URL)"));
> +               printf_ln(_("  Fetch URL: %s"), info.states.remote->url.v=
[0]);
>                 url =3D push_url_of_remote(info.states.remote);
>                 for (i =3D 0; i < url->nr; i++)
>                         /*
> @@ -1440,10 +1438,7 @@ static int prune_remote(const char *remote, int dr=
y_run)
>         }
>
>         printf_ln(_("Pruning %s"), remote);
> -       printf_ln(_("URL: %s"),
> -                 states.remote->url.nr
> -                 ? states.remote->url.v[0]
> -                 : _("(no URL)"));
> +       printf_ln(_("URL: %s"), states.remote->url.v[0]);
>
>         for_each_string_list_item(item, &states.stale)
>                 string_list_append(&refs_to_prune, item->util);
> @@ -1632,8 +1627,6 @@ static int get_url(int argc, const char **argv, con=
st char *prefix)
>         }
>
>         url =3D push_mode ? push_url_of_remote(remote) : &remote->url;
> -       if (!url->nr)
> -               die(_("no URLs configured for remote '%s'"), remotename);
>
>         if (all_mode) {
>                 for (i =3D 0; i < url->nr; i++)
> diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
> index 3285dd962e..0c5fa723d8 100644
> --- a/t/helper/test-bundle-uri.c
> +++ b/t/helper/test-bundle-uri.c
> @@ -88,8 +88,6 @@ static int cmd_ls_remote(int argc, const char **argv)
>                         die(_("bad repository '%s'"), dest);
>                 die(_("no remote configured to get bundle URIs from"));
>         }
> -       if (!remote->url.nr)
> -               die(_("remote '%s' has no configured URL"), dest);
>
>         transport =3D transport_get(remote, NULL);
>         if (transport_get_remote_bundle_uri(transport) < 0) {
> diff --git a/transport.c b/transport.c
> index eba92eb7e0..a324045240 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1112,6 +1112,7 @@ static struct transport_vtable builtin_smart_vtable=
 =3D {
>  struct transport *transport_get(struct remote *remote, const char *url)
>  {
>         const char *helper;
> +       const char *p;
>         struct transport *ret =3D xcalloc(1, sizeof(*ret));
>
>         ret->progress =3D isatty(2);
> @@ -1127,19 +1128,15 @@ struct transport *transport_get(struct remote *re=
mote, const char *url)
>         ret->remote =3D remote;
>         helper =3D remote->foreign_vcs;
>
> -       if (!url && remote->url.nr)
> +       if (!url)
>                 url =3D remote->url.v[0];
>         ret->url =3D url;
>
> -       /* maybe it is a foreign URL? */
> -       if (url) {
> -               const char *p =3D url;
> -
> -               while (is_urlschemechar(p =3D=3D url, *p))
> -                       p++;
> -               if (starts_with(p, "::"))
> -                       helper =3D xstrndup(url, p - url);
> -       }
> +       p =3D url;
> +       while (is_urlschemechar(p =3D=3D url, *p))
> +               p++;
> +       if (starts_with(p, "::"))
> +               helper =3D xstrndup(url, p - url);
>
>         if (helper) {
>                 transport_helper_init(ret, helper);
> --
> 2.45.2.937.g0bcb3c087a

So, after reading the first 8 patches, I only kinda skimmed 9 and 10,
thinking "I don't really care about these remote helper things and
don't have an opinion on them -- besides, I'm sure Peff is picking
something reasonable", but I'm always a fan of code simplifications
like this patch.  It makes it tempting to go back and read those last
two patches a little closer.  Almost tempting enough, in fact.  ;-)
