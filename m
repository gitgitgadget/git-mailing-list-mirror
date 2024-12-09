Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E22374EA
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732337; cv=none; b=FU/bU7O5CMAwp+LuXUim/ps+19Kv39LyyasusYHZwI1tZromsC6lrtYJbgv4hvfL6ZtpXSj+QIvrXn0Gv3eQjbXzSgLWo5qbblxpCXSk3ccyC3zB5FoVNWntC+KnI2gQoozTrK4ZztboRrcuj1DtBGKnhyAnaR8lYOPOfpAbTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732337; c=relaxed/simple;
	bh=RlwmQPVXpUZAFILuZUOJ94l5MY/N1J/ml0O+WTY9SRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+PvTD+uBNrkvzIlf/qZGy0FrB0O/Br9Z5Zng214JYu6IXAhububfr+K2ImO4Yb6/lN90fhINLUe+OH8jr1igQuW6MFImPDwu34LlnrhK1JBs6YBifS9K8f33NPFzKnvMHWBQ4ylxlCe9UepMwAB21p4DQoZy+8EtMX88g6OjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=aYdlxkiR; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="aYdlxkiR"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e39779a268bso3558902276.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 00:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1733732335; x=1734337135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arz4u5hlcd2bpjp5x1VtCLfNOS4D93dkGTaIdHGLlOg=;
        b=aYdlxkiR/DjL+eyEMVwQ5L+sR6zaqOtTS7fS83IlV8n/RX7gXcdAKYXSGR/iBlPl0d
         Y8RgiV6c7nDhkBdK5s4KqMTUsdN8JP0+C8sEG8ImwE8IdBGbKP/bJbTQkntlm7CKnMV5
         krKmuLqMb9RyrGvA7Lxvkjq8mqiH4Ze7ukY0ieAWEPYnaCuKxAhXWZ1Ln9OF+naAPm3/
         9yWXmk1xMrsBnse3fytDU8q/Mo36aL7k/uNBteWIWMYsx9F+LuSTTo14D9x6jvnD/lcc
         s8eSCuQ3U1/kN5v4HfDXP8W4BBQAkfqiig3CUdTakiIE6PDDlrR5yBh6SQj4E5INay8K
         hEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733732335; x=1734337135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arz4u5hlcd2bpjp5x1VtCLfNOS4D93dkGTaIdHGLlOg=;
        b=glAob3qaOJi3rvYpWKCqLLRllHJ7iZNB2XDsRIFsaGcD8O9GBw39ykEGIt8CwO69TG
         7ebJWqJVHSkO4Orf3hooItGU4X3u9sUwzma1tM7FszJ2LJSUx7MS8W+4ZZbq0SRPVFnh
         6K72JvWw/z8kZ++clNGT5gV2siUaGo2ZdI2jo/Ewdg2viq+BCyQIzBfWYLG2bSjA9R5C
         mH10mvnB42toB+EADxR/felJt5f1YQHZD2iasKZveisYa9VmHK3PNZpERoSfHm2KZfLB
         Ogcz39Bs+xlg+CtTirqnsLSBJhxRBYNnaI0G7mO/HzhVyiTY4gH+cylE1kkB2Ggdpv9B
         dKxA==
X-Gm-Message-State: AOJu0Yy8Zibf3P692lMBOsTLObghkl4khUtXNMNV9/QrIWbs+y4MTf9G
	LTVS+UDC4yFbrGtjHChrptIJ6JW19MbJSfCyNntkZKDBwAmn1LJm62ioUR4Giskz+g6ZstnICH4
	WGyt24YWg+ExpMvLGCPcjk0KAU48DPl7agYNFiNfYM3QTNqqAc+lC
X-Gm-Gg: ASbGncvaoqqSmYhnUwTMhEtArPbOEHtBDYsJW0jHMMLx6XTUqGJOUIOv4XyOquDOSAL
	kVDjedVtFANesa2u0KEfj/as8LvH/ephl
X-Google-Smtp-Source: AGHT+IExWgsr89C8tqq82CxxMWJRx8A0p76VJtV2ZBWzdhWKIuY+C2EhzKsMd03oKWm45UPfnggYaPlyVFJ/3ziuYt0=
X-Received: by 2002:a05:6902:2293:b0:e29:39fa:3b0c with SMTP id
 3f1490d57ef6-e3a0a7da45amr9624011276.11.1733732334709; Mon, 09 Dec 2024
 00:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACfnds=++C75pg8ojn5sJzjKzLcgnyPxgR2c6pOPCRmf2rDKvQ@mail.gmail.com>
 <CACfnds=J=Q+viagTEoiQ3edUxU8GSY_s7=biGUGY4NKbQpsTvw@mail.gmail.com> <CAARMkVGYOKb0H3pmUdcDWTs2p3hZZMX0dsdU1rT=Hg5a6M7Z6g@mail.gmail.com>
In-Reply-To: <CAARMkVGYOKb0H3pmUdcDWTs2p3hZZMX0dsdU1rT=Hg5a6M7Z6g@mail.gmail.com>
From: Shubham Kanodia <skanodia@atlassian.com>
Date: Mon, 9 Dec 2024 13:48:43 +0530
Message-ID: <CAARMkVGxduJZnxBAK9smL4JnBcUZ44tOsH7m-WgSa3ymtATt1w@mail.gmail.com>
Subject: Re: git add -p is slow for sparse checkout
To: Manoraj K <mkenchugonde@atlassian.com>, stolee@gmail.com
Cc: git@vger.kernel.org, Victor Chan <vchan@atlassian.com>, 
	Shrey Somaiya <ssomaiya@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:13=E2=80=AFPM Shubham Kanodia <skanodia@atlassian.=
com> wrote:
>
> On Fri, Dec 6, 2024 at 9:53=E2=80=AFAM Manoraj K <mkenchugonde@atlassian.=
com> wrote:
> >
> > ++ CC
> >
> > On Fri, Dec 6, 2024 at 9:16=E2=80=AFAM Manoraj K <mkenchugonde@atlassia=
n.com> wrote:
> > >
> > > Hi team,
> > >
> > > I am currently on a sparse checkout repository, and it looks like the
> > > `git add=E2=80=94p` command is much slower than in a full checkout re=
pository.
> > >
> > > When run, the `git add=E2=80=94p` command expands to the full index a=
nd takes
> > > more time to start showing the patch.
> > >
> > > Also, we have git trace2 enabled, and the timings of the subcommands
> > > gave us an indication that the `git apply=E2=80=94-cached` subcommand=
 is
> > > taking way too long, with an average P50 of 3000ms against 300ms in
> > > the full checkout repository. The other notable spikes are in `git
> > > diff-files --color` (180ms vs 80ms) and `git diff-files --no-color`
> > > (180ms vs 80ms).
> > >
> > > I am really interested in understanding why `git add -p` expands to a
> > > full index, which I believe is the issue with start-up regression.
> > > Also, would be great to understand the difference in performance of
> > > the subcommands.
>
> I started tracing execution of `git add -p`, it seems that `git add
> -p` seems to require a
> full index whereas a regular `git add` does not, because `git add -p`
> ends up calling
>  `do_read_index` in `read_cache.c`.
>
>
> `do_read_index` seems to then call `prepare_repo_settings` that resets
> the value of
> `istate->repo.settings.command_requires_full_index` to `1`, even though
> `istate->repo.settings.command_requires_full_index` passed to
> `do_read_index` was
> initially `0` for `git add -p`.
>
> ```
> int do_read_index(struct index_state *istate, const char *path, int must_=
exist)
> {
> ....
> /*
> * If the command explicitly requires a full index, force it
> * to be full. Otherwise, correct the sparsity based on repository
> * settings and other properties of the index (if necessary).
> */
> prepare_repo_settings(istate->repo);
> ```
>
> The comment here seems confusing to me =E2=80=94 it seems like the intent=
 here
> was to preserve
> sparseness when as possible, but `prepare_repo_settings` seemsto do a
> blanket reset =E2=80=94
>
> ```
> void prepare_repo_settings(struct repository *r)
> {
> ....
> /*
> * This setting guards all index reads to require a full index
> * over a sparse index. After suitable guards are placed in the
> * codebase around uses of the index, this setting will be
> * removed.
> */
> r->settings.command_requires_full_index =3D 1;
> ```
>
> Retaining the original setting seems to fix the problem and makes `git
> add -p` fast,
> however I don't know if there's a reason why it wasn't already done this =
way.
>
> ```
> read-cache.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 01d0b3ad22..92f7561a88 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2339,7 +2339,12 @@ int do_read_index(struct index_state *istate,
> const char *path, int must_exist)
> * to be full. Otherwise, correct the sparsity based on repository
> * settings and other properties of the index (if necessary).
> */
> + int previous_full_index_setting =3D
> + istate->repo->settings.command_requires_full_index;
> +
> prepare_repo_settings(istate->repo);
> + istate->repo->settings.command_requires_full_index =3D
> previous_full_index_setting;
> +
> if (istate->repo->settings.command_requires_full_index)
> ensure_full_index(istate);
> else
> ```

Adding Derick =E2=80=94 in case you know if indeed a non-sparse index is
necessary for `git add -p` or if this could just have been an
oversight given support for sparse checkouts was added progressively
to git.

--=20
Regards,
Shubham Kanodia
