Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643F101E6
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753014325; cv=none; b=WcT5tKPDy/hkopvtolQ6D20q458I5dKuvi2uq/epOawp16/K6yah6l4BnbBtiCxYA6KeR4ljP7baeFdMYCKHBXI2++1vgo89x2eNNMBcLzaEqhAHtX4pBLY/bNfvYp+byyWiYlCNdBxaW6VmEHYdZn93772U99EEvU4i/JKGrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753014325; c=relaxed/simple;
	bh=1fLY1Wcd0k0nsqjEiPbavAC2Zxc7Jr+XRiVfQ0MDs14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVSj9Vf0BSpNYLwrbEvLPBjcC3tVPxPKon69lK5g1f0Hbp6P+g8GekugPMCk08JjERhsQIEgJUs56yakbLaLkRyIVlQvlEYnVafjgTfWtBGATkNLQ7uX030dd8uqjK94RL/endsarOg/SVDC5MP9PyDRUc8OwGF8RBSNU7lTBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d11Kd2tp; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d11Kd2tp"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab81d0169cso49146681cf.2
        for <git@vger.kernel.org>; Sun, 20 Jul 2025 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753014323; x=1753619123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH8WMHFMXFtFbRFwp2N68pW/3DDt13Yj7LQjVPlGtOQ=;
        b=d11Kd2tp2qRm5rqag+5muPBUKaUwHSzotnLycUQYxE8S8ciwmwZvKlQeFRs5sRemBz
         Q4EEhfkaKM55xTZLwrd8KO/Nfubtb98l+YVioSBiRuxVou/i9AbomryERNg4wEyykfPk
         8jDXVOxBxrl9Ia6JRCHJ2+qN3Zhrpf/ii45QHnKNelykYtNvWz+GJXGW7odV0yqXBuA1
         sb+U0rKreMXJBOWgadKOtKI8cWwasr24a9yRXlzFMeQ5HmTsGgKIre++U8pLVVC6QZPD
         tuzLXndkq5Ujx3+g3ytQ0m3fqhrfsRnvr8lGhCDDmZg4eomFX3bB7NdqjH2XCzne0HK+
         S/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753014323; x=1753619123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH8WMHFMXFtFbRFwp2N68pW/3DDt13Yj7LQjVPlGtOQ=;
        b=a7hbJ5afy2FQf+be2Y+GvFM8MsidSB7G/ZsT73PXq9OhmcTvw9vOvk4x9VqPZsxZj3
         6qkMZgL/wtkE0wZb+VrOYCTXuqlMmcL8OLwAJs87wDnvgXc9NObH1T8QrFMTUsYck/Ec
         GaURe2aeJvbBnWoFPB7G0qHTy/gFJT7fAUsu8MvMfp1Eia3onJXKLpo9MTiDGjF4TSYd
         kCw1gPhWPx4s3YK/pmo170LLquorz0BqNwsTNO9kFdGq3PWPE7WM/8rr/wQbebSmMqfd
         nD6NW7QpEFAx5U6XV8ZmPOamu4ZGw+VbLXi6mhq5mYEm3+M/pqjYbPK8Z1qVfAbMxJs4
         ejfA==
X-Gm-Message-State: AOJu0Yx+57XIWxFpg7YIj40W6ufHZ+yHc/FePCqTsnurS8TqCyj1ANZr
	vqAQxlitfZ+EEaDZLZDt95/bDj6+HlJtzc+qcty815GTCpskxeFxZCnkOrq/xdlmMJab0BRmest
	nESJoyyKC+m/1h928ozrIwmvKeCQIqGI=
X-Gm-Gg: ASbGnctKJCuwxMiO6fprbl2FM9MWkU9dpo2dZkK4UeVfUsp2W0VFHQu68UKUKkjIB8e
	pI5mPkzKCLExhe0ZZ98t+C8Yy9SJMjQ0uISy1S4v1UxY5lXx80Bz0Hk4aNo4M3d7GadLIb4IxJK
	BqqEK8sLpMZ8wis8IbZcyn8GcNM1VN3R4euPsNPmNRKNwBS/UjyyV0ICD8foNqrl72QGzGvwhog
	3D5plALo+XCJakhbzJm6KIOc4FD5lD2OLz9yNE=
X-Google-Smtp-Source: AGHT+IEP2nuZI15mA2n9kko2G7tQXlimFTaikD1i0kkwr8qxy8JX9DYSfXELeokuZVz99L7RpzSNXfpm9zncI8z0VoM=
X-Received: by 2002:a05:622a:52:b0:472:1d98:c6df with SMTP id
 d75a77b69052e-4ab90d12851mr253792931cf.52.1753014322979; Sun, 20 Jul 2025
 05:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
 <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
 <20250608032705.11990-2-jayatheerthkulkarni2005@gmail.com> <CALnO6CB5VezYHtp22RNihNtzLXQkP9Ly=hf0V=3A1EsTvKcFgg@mail.gmail.com>
In-Reply-To: <CALnO6CB5VezYHtp22RNihNtzLXQkP9Ly=hf0V=3A1EsTvKcFgg@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 20 Jul 2025 17:55:11 +0530
X-Gm-Features: Ac12FXwwPOOoYUq1zsthklBtOovg7T-v84FzEmqYe5GNunqZ0tSPwWMuWOrhVqI
Message-ID: <CA+rGoLfi9=h0Z86QZ2Y_HQqd+ugrMgkBzLaNSwivvkcDwmT=rg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] submodule: prevent overwriting .gitmodules entry
 on path reuse
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:20=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
>
> On Sat, Jun 7, 2025 at 11:28=E2=80=AFPM K Jayatheerth
> <jayatheerthkulkarni2005@gmail.com> wrote:
> >
> > Adding a submodule at a path that previously hosted another submodule
> > (e.g., 'child') reuses the submodule name derived from the path. If the
> > original submodule was only moved (e.g., to 'child_old') and not rename=
d,
> > this silently overwrites its configuration in .gitmodules.
> >
> > This behavior loses user configuration and causes confusion when the
> > original submodule is expected to remain intact. It assumes that the
> > path-derived name is always safe to reuse, even though the name might
> > still be in use elsewhere in the repository.
> >
> > Teach `module_add()` to check if the computed submodule name already
> > exists in the repository's submodule config, and if so, refuse the
> > operation unless the user explicitly renames or uses force to auto incr=
ement.
>
> I had to read the patch to figure out what "auto increment"
> meant=E2=80=94perhaps some accompanying docs in `git help submodule`?
>
> >
> > Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> > ---
> >  builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++++
> >  t/t7400-submodule-basic.sh  | 23 +++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 53da2116dd..9f6df833f0 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -3444,6 +3444,10 @@ static int module_add(int argc, const char **arg=
v, const char *prefix,
> >         struct add_data add_data =3D ADD_DATA_INIT;
> >         const char *ref_storage_format =3D NULL;
> >         char *to_free =3D NULL;
> > +       const struct submodule *existing;
> > +       struct strbuf buf =3D STRBUF_INIT;
> > +       int i;
> > +       char *sm_name_to_free =3D NULL;
> >         struct option options[] =3D {
> >                 OPT_STRING('b', "branch", &add_data.branch, N_("branch"=
),
> >                            N_("branch of repository to add as submodule=
")),
> > @@ -3546,6 +3550,29 @@ static int module_add(int argc, const char **arg=
v, const char *prefix,
> >         if(!add_data.sm_name)
> >                 add_data.sm_name =3D add_data.sm_path;
> >
> > +       existing =3D submodule_from_name(the_repository,
> > +                                       null_oid(the_hash_algo),
> > +                                       add_data.sm_name);
> > +
> > +       if (existing && strcmp(existing->path, add_data.sm_path)) {
> > +               if (!force) {
> > +                       die(_("submodule name '%s' already used for pat=
h '%s'"),
> > +                       add_data.sm_name, existing->path);
> > +               }
> > +
> > +               /* --force: build <name><n> until unique */
> > +               for (i =3D 1; ; i++) {
> > +                       strbuf_reset(&buf);
> > +                       strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
> > +                       if (!submodule_from_name(the_repository,
> > +                                               null_oid(the_hash_algo)=
,
> > +                                               buf.buf)) {
> > +                               break;
> > +                       }
> > +               }
>
> This isn't typically what I'd expect --force to do, personally, though
> in this case it allows me to proceed with an operation that wasn't
> allowed otherwise.
>
> Still, I wonder if a user might be confused by "I said 'child' and got
> 'child2'?"
>


Ok so while fixing the previous versions of my submissions
I got stumped at this, I found child<incremented val> to be intuitive
at that time
but I can see why it may not be intuitive too, I mean I could just
remove the previous child and add
the current data as the new child because that feels intuitive for force.
If that is something which is in the interest I could send the new
patches as soon as possible.

Thank You

- Jayatheerth
