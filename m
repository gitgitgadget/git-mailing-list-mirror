Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD92A212FB0
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437788; cv=none; b=bz+Onb+KW+hPGj3+PuVQqDXqSuPAs/uSxSS59aP83caW6ilQz0u03gHik6u9z5UvduQ4UZJkzTggFPu5vx8ipdc/AX/+YHEy7T5h6N8lRUBnBxiTRW1fSGUVB/7Jiskhqyx2vfYj3cHwzzbFCmZ7S+SapLE2zDh1EN+o0RU7bWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437788; c=relaxed/simple;
	bh=xaA13XGwKNTT4s6soCKrD+o88soU8JqiCcXGz4k8vt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PWsGuVCQH0MQx/8UG7hbovBVkbMhdpfbclz5v2Tu6xTuJvOWbiKCHbwuRXFu+gZgCZpSl0x59dutF6GKdO57l7JsPOn4LlE2SdXP/a9scLnEhBT09y/gA5F41Wwz9fOX3d4cDozpXQv8x0apXlmSDFkVy65k2c0zHBTvLek6VIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZomVHJN8; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZomVHJN8"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e6b81408b9fso1956238276.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743437786; x=1744042586; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agQXrnkIl4L2FVJTWD3wrsoE++J6whPIqpI0Yy81z+0=;
        b=ZomVHJN8/fCcwDmDQtomslRZ5WhuIALryx9GiojX6T2GGrQ37z4Y1sQdwohZ5mgpAh
         kqeqkH1yYtjcndojfNUlvp71i8LiKT4rhXs3ZQzYk7RnTLRaXYN5jAB4nDRnLkz3MBaK
         qSzCsUAFKOvNv8H1Hp/LrcMRaBVOlikFCgcqwNetLUAHpCiBXlPLN1Wyp3hvL8NGIay4
         l0p9mhMkqwjB+5pr3DFsfT4Vo/IrBh2c75kKm7B/9AWRfup0/6kg5WpwHy+x1U8IhytH
         +41FCTT0VksWq7ETveLsZUKEdgmStOJfMO+WGeVsQNQRXTHPjVwjHPr2mfQmv+dJZlFm
         UaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743437786; x=1744042586;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agQXrnkIl4L2FVJTWD3wrsoE++J6whPIqpI0Yy81z+0=;
        b=o6SaLzRUcvT03HXozkHmindFdYn4R9Wxst7g9qwAKQx0Jxc3HcxBrp6di94vuuld0Q
         02E0eHlvF750wgrhzo7kSPqam050ftKvpNzzdKXt5TP99/qTL3wKadcgfGEX7VIy32gq
         DsjYykltAIQtexCqs9hhMATbo5y69vrUyPnkj3HNRJ5GeCw2KzazEbY1KHYYmLb6yR96
         RDOAzP5Lx8OH3fUfBiR3Mu+cHtmHX0DYK+QBQ7oKWSePpfNn5TdABgvokH9Ao9SozLZN
         MI0S5O6hyQJUyHorCl1UsO4/fvWW1HJK5YEjCfeMKmD78YP4JpMh5mPg8lGTD/0uPbW4
         YuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoB6A0SNkdo3CGDhrwajMopFbK9Bmi8w4WEOhokKzE0xqOG1Fc+OD8+PvfcwWz+ft9qNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3azl2ugQgLksuwD9vI8DemqRL/4y3AcjjLtVbCXNqbRtLMlyD
	Q06Y9o6RTznHCOt1QRwg5am7C4/dQW3ZBxM9g2XlCFAv8TpUvo+U7e7MZHOrFKJ//YIJJoe7Q1H
	61g8tHkbSGkDuvcQgHAMis8rLEGc=
X-Gm-Gg: ASbGnctZco1kqh8Ee4klmYJB9EiC7dc8hdiQUZWVL16GoLxZ3d5XL0JxEN+Uk5BHBol
	YBzG0SYyE/rhOV1ItrM4PZlPoEpL9Cs0ijpZlnXdEV1yhTaJB42aPd5wPyOrbB1T2Rh9o9RbIiP
	fDx8NvalLPE64eMQksuSNIR9D0
X-Google-Smtp-Source: AGHT+IEHBX/j0016inv9/Gu6ygZNCpyBvfzgrsNFta4vzJ2Avoil5acIQdoT7CkgxVrL3+GeIayDkmsedibikDLLMYo=
X-Received: by 2002:a05:6902:1688:b0:e63:cf48:3b7c with SMTP id
 3f1490d57ef6-e6b8392875emr13560976276.21.1743437785621; Mon, 31 Mar 2025
 09:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1869.git.1740861011509.gitgitgadget@gmail.com> <CADJmAEg6M=FJcndQQ45odztyAq8jATonEwXjrkuoZuZ=WXh7vQ@mail.gmail.com>
In-Reply-To: <CADJmAEg6M=FJcndQQ45odztyAq8jATonEwXjrkuoZuZ=WXh7vQ@mail.gmail.com>
From: John Giorshev <john.giorshev1@gmail.com>
Date: Mon, 31 Mar 2025 12:16:15 -0400
X-Gm-Features: AQ5f1Jo_o_GVB_xfA6yHciRbJ3p4jF2jdcWpJ3ngtQS5GCRQdndkPujXdBwHU-g
Message-ID: <CADJmAEjLevd+vx=7rChd26Qf9Az8Qz96hyE3KJZFXikbkBQj8w@mail.gmail.com>
Subject: Re: [PREVIEW] add --must-filter option for fetch and clone
To: Jeff King <peff@peff.net>, jonathantanmy@google.com, gitster@pobox.com, 
	bmwill@google.com, pclouds@gmail.com, lilinchao@oschina.cn, 
	sbeller@google.com, dstolee@microsoft.com, tboegi@web.de, ps@pks.im, 
	toon@iotcl.com, robert@coup.net.nz, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:10=E2=80=AFPM John Giorshev <john.giorshev1@gmai=
l.com> wrote:
>
> cc'ing reviewers. thanks.
>
> context:
>  - https://stackoverflow.com/q/79413099/15534181
>  - https://public-inbox.org/git/20250225013227.GB752084@coredump.intra.pe=
ff.net/
>
> On Sat, Mar 1, 2025 at 3:30=E2=80=AFPM John Giorshev via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: John Giorshev <john.giorshev1@gmail.com>
> >
> > Signed-off-by: John Giorshev <john.giorshev1@gmail.com>
> > ---
> >     add --must-filter, give error on filter not supported instead of wa=
rn
> >
> >     from:
> >     https://public-inbox.org/git/20250225013227.GB752084@coredump.intra=
.peff.net/
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1869%=
2Fjagprog5%2Fmaster-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1869/jag=
prog5/master-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1869
> >
> >  builtin/clone.c          |  6 ++++++
> >  builtin/fetch.c          |  7 ++++++-
> >  fetch-pack.c             |  8 ++++++--
> >  fetch-pack.h             |  1 +
> >  t/t0410-partial-clone.sh | 17 +++++++++++++++++
> >  transport.c              |  1 +
> >  transport.h              |  1 +
> >  7 files changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index f9a2ecbe9cc..7000b0ecd36 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -887,6 +887,7 @@ int cmd_clone(int argc,
> >         enum ref_storage_format ref_storage_format =3D REF_STORAGE_FORM=
AT_UNKNOWN;
> >         const int do_not_override_repo_unix_permissions =3D -1;
> >         int option_reject_shallow =3D -1; /* unspecified */
> > +       int must_filter =3D 0;
> >         int deepen =3D 0;
> >         char *option_template =3D NULL, *option_depth =3D NULL, *option=
_since =3D NULL;
> >         char *option_origin =3D NULL;
> > @@ -915,6 +916,8 @@ int cmd_clone(int argc,
> >                          N_("force progress reporting")),
> >                 OPT_BOOL(0, "reject-shallow", &option_reject_shallow,
> >                          N_("don't clone shallow repository")),
> > +               OPT_BOOL(0, "must-filter", &must_filter,
> > +                        N_("error on filter not supported by server"))=
,
> >                 OPT_BOOL('n', "no-checkout", &option_no_checkout,
> >                          N_("don't create a checkout")),
> >                 OPT_BOOL(0, "bare", &option_bare, N_("create a bare rep=
ository")),
> > @@ -1333,6 +1336,9 @@ int cmd_clone(int argc,
> >         transport_set_verbosity(transport, option_verbosity, option_pro=
gress);
> >         transport->family =3D family;
> >         transport->cloning =3D 1;
> > +       if (transport->smart_options) {
> > +               transport->smart_options->must_filter =3D must_filter;
> > +       }
> >
> >         if (is_bundle) {
> >                 struct bundle_header header =3D BUNDLE_HEADER_INIT;
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 1c740d5aac3..1f3cdf53148 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -84,7 +84,7 @@ static int prune_tags =3D -1; /* unspecified */
> >
> >  static int append, dry_run, force, keep, update_head_ok;
> >  static int write_fetch_head =3D 1;
> > -static int verbosity, deepen_relative, set_upstream, refetch;
> > +static int verbosity, deepen_relative, set_upstream, refetch, must_fil=
ter;
> >  static int progress =3D -1;
> >  static int tags =3D TAGS_DEFAULT, update_shallow, deepen;
> >  static int atomic_fetch;
> > @@ -1508,6 +1508,9 @@ static struct transport *prepare_transport(struct=
 remote *remote, int deepen)
> >         transport =3D transport_get(remote, NULL);
> >         transport_set_verbosity(transport, verbosity, progress);
> >         transport->family =3D family;
> > +       if (transport->smart_options) {
> > +               transport->smart_options->must_filter =3D must_filter;
> > +       }
> >         if (upload_pack)
> >                 set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack=
);
> >         if (keep)
> > @@ -2322,6 +2325,8 @@ int cmd_fetch(int argc,
> >                          N_("append to .git/FETCH_HEAD instead of overw=
riting")),
> >                 OPT_BOOL(0, "atomic", &atomic_fetch,
> >                          N_("use atomic transaction to update reference=
s")),
> > +               OPT_BOOL(0, "must-filter", &must_filter,
> > +                        N_("error on filter not supported by server"))=
,
> >                 OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
> >                            N_("path to upload pack on remote end")),
> >                 OPT__FORCE(&force, N_("force overwrite of local referen=
ce"), 0),
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 1ed5e11dd56..0cf59c1bc82 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -319,9 +319,13 @@ static void send_filter(struct fetch_pack_args *ar=
gs,
> >                         trace2_data_string("fetch", the_repository,
> >                                            "filter/effective", spec);
> >                 } else {
> > -                       warning("filtering not recognized by server, ig=
noring");
> > -                       trace2_data_string("fetch", the_repository,
> > +                       if (args->must_filter) {
> > +                               die("filtering not recognized by server=
");
> > +                       } else {
> > +                               warning("filtering not recognized by se=
rver, ignoring");
> > +                               trace2_data_string("fetch", the_reposit=
ory,
> >                                            "filter/unsupported", spec);
> > +                       }
> >                 }
> >         } else {
> >                 trace2_data_string("fetch", the_repository,
> > diff --git a/fetch-pack.h b/fetch-pack.h
> > index 9d3470366f8..01ab94fc24b 100644
> > --- a/fetch-pack.h
> > +++ b/fetch-pack.h
> > @@ -40,6 +40,7 @@ struct fetch_pack_args {
> >         unsigned cloning:1;
> >         unsigned update_shallow:1;
> >         unsigned reject_shallow_remote:1;
> > +       unsigned must_filter:1;
> >         unsigned deepen:1;
> >         unsigned refetch:1;
> >
> > diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> > index 2a5bdbeeb87..0166c491ca5 100755
> > --- a/t/t0410-partial-clone.sh
> > +++ b/t/t0410-partial-clone.sh
> > @@ -48,6 +48,23 @@ test_expect_success 'convert shallow clone to partia=
l clone' '
> >         test_cmp_config -C client 1 core.repositoryformatversion
> >  '
> >
> > +test_expect_failure 'must filter clone' '
> > +       rm -fr server client &&
> > +       test_create_repo server &&
> > +       test_commit -C server my_commit 1 &&
> > +       test_commit -C server my_commit2 1 &&
> > +       git clone --filter=3D"blob:none" --must-filter "file://$(pwd)/s=
erver" client
> > +'
> > +
> > +test_expect_failure 'must filter fetch' '
> > +       rm -fr server client &&
> > +       test_create_repo server &&
> > +       test_commit -C server my_commit 1 &&
> > +       test_commit -C server my_commit2 1 &&
> > +       git clone --depth=3D1 "file://$(pwd)/server" client &&
> > +       git -C client fetch --unshallow --filter=3D"blob:none" --must-f=
ilter
> > +'
> > +
> >  test_expect_success DEFAULT_REPO_FORMAT 'convert to partial clone with=
 noop extension' '
> >         rm -fr server client &&
> >         test_create_repo server &&
> > diff --git a/transport.c b/transport.c
> > index 6c2801bcbd9..0543821399d 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -450,6 +450,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
> >         args.quiet =3D (transport->verbose < 0);
> >         args.no_progress =3D !transport->progress;
> >         args.depth =3D data->options.depth;
> > +       args.must_filter =3D data->options.must_filter;
> >         args.deepen_since =3D data->options.deepen_since;
> >         args.deepen_not =3D data->options.deepen_not;
> >         args.deepen_relative =3D data->options.deepen_relative;
> > diff --git a/transport.h b/transport.h
> > index 44100fa9b7f..0ffc8d273ab 100644
> > --- a/transport.h
> > +++ b/transport.h
> > @@ -16,6 +16,7 @@ struct git_transport_options {
> >         unsigned reject_shallow : 1;
> >         unsigned deepen_relative : 1;
> >         unsigned refetch : 1;
> > +       unsigned must_filter : 1;
> >
> >         /* see documentation of corresponding flag in fetch-pack.h */
> >         unsigned from_promisor : 1;
> >
> > base-commit: a554262210b4a2ee6fa2d594e1f09f5830888c56
> > --
> > gitgitgadget
