Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C612EBE7
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751116926; cv=none; b=eeOF5VPtd3LOcAgcydzXeimxWMVmigjTgG2toFoFB6jKgzPzAOmYGm6hpuUH+snlKHjIX9EwCXD5OAX1BsrKhqGx77N9m16WAZN7Ir8UH4Ro93WuMj/ybHoC8y41JVE4p23dJDbysOrLTgRuPCUZWHs8vAntwDlIUTcoR/7w8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751116926; c=relaxed/simple;
	bh=o8lQl/Xk9RvhDKoQF/eNDBzIx7+UPh0Tn2XAoqf7ajQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXZIBub5wanATaaJKDCDv8tezyryduAEFxahP6C1ETga/xFH7ICnUtJ0f+Vp+WaEXAKOwZFigme3LcGBVP34yvK0znokEe7ok/E7Z4Igddvd7paRkv8DLCvXQnGalooe6316VrS2DJ9UrEowKOh7AsfpmDcyEv7TsQGSQrQMFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT4MBV1h; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT4MBV1h"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23636167afeso3565625ad.3
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751116924; x=1751721724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCG03if+Vf5RRoCoylA+CnxXQIqjCMSKvAPEvePkEHk=;
        b=lT4MBV1hh6i8Bdr/froE9fojGbbaT/tQPrPvyYk+3OEChefLuHVSTt9CoWu1qmaleF
         bGeUiB4fxdVQr/g757hW1udXeps7lCvA9/s7wAYQb4sSPU+fzuW8gmMWmDKnZyi+DEiT
         t8xEep/pzuCHIyUbSgXhVjeqUdW/fZ+na0niKKwrTWcHWD9qSvSnhIFzAp8UVYXJMLLc
         M4cTzSvi6WbPV0mVRKyVEg4cQG7WWeb2pwEvHukrp2hWcXlKDs7D+Lq4OVAQFK0Ex/Ob
         xATeATTv5kMjK+2j8IXUqDDnNQAod3I2NCL4ZCZEJ/BMOeFe/ZXaSZ/8WtH6TSyEnXv/
         GtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751116924; x=1751721724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCG03if+Vf5RRoCoylA+CnxXQIqjCMSKvAPEvePkEHk=;
        b=bWYzIJr5FDf+Nf/flvJYAE5hMYI4/KINokELBqxLX+olCouVuhnjOhqf7Vn1CtIgAs
         zeQsEMD4HKUeAAw6gO8XeTqiA2GLi/jbBAcyz/Sl1SQJZ31pwwVetWV84nGAitTtOqJV
         Jy10dq+8VJMdVcGPiJeEFrtC8gqeUg/yUq0kL5T7DknYVMVLy+iTLGVyengZPxl93ZM1
         ScY4zYYlWQ1NEVGawXElDPN60NaSI1aMfsMN5az/8ZPhkfbgBEyGk1Br8/9vhuflmoaO
         9yHdatoyiim4+l4YmJt1+O7o4gYb+4oiz2TczL3C83B2hhsWIPUXQFeOpC2y7EZe16SL
         fBUw==
X-Gm-Message-State: AOJu0YwZpqne4V0FAEKjGomv92znUnyIQCIjlush89HkxMgeQYxhDY9b
	5b5iSGQJ1eW35uzsbmxOr0ojSnqV1nnI5pOBEXsi4eXEbJZ3WEUUaCZaP2LQioYStk/3B8Uvo/f
	W5Vp+YovohaWR96YItF8iMsH5qUbjO10huD3o
X-Gm-Gg: ASbGnctcv21F0n/ercsQRfsO8sIcIBahElaR0uxOfoupUZQO+2MEFdkvEQXDDIBujkV
	Gy9kqUSzcUk+QNtoJMpx8sTWRzV37zQWXXoJeSCbiMYZ4FGVv9+Rmw4CfPYCh4IFzISAc97n5Jn
	vekA1D1sORvOXRTQOxwVjnnoG0M9hiZWVgA7sMgRJVdBg67FyoEahLtoeUXqvbVHA1arV8Zb8g2
	0GJ2g==
X-Google-Smtp-Source: AGHT+IEP5Ubc5LhnOyyD5h5ZkHDK0dvwyEp75nQnsOBBeW1xtYYgpiavcqbi6eSYxLc73B8SvnVaWnJbZg+ARc9zsWU=
X-Received: by 2002:a17:903:11d1:b0:234:966c:a2f3 with SMTP id
 d9443c01a7336-23ac45e247fmr97824565ad.27.1751116924016; Sat, 28 Jun 2025
 06:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749343601.git.ayu.chandekar@gmail.com> <9b274efd7dfde90990ace66bfbe5f7e3b6ce30d1.1749343601.git.ayu.chandekar@gmail.com>
 <aF-asGE-cX8IpAae@ArchLinux>
In-Reply-To: <aF-asGE-cX8IpAae@ArchLinux>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 28 Jun 2025 18:51:52 +0530
X-Gm-Features: Ac12FXzQ5cEbVT7nhsV-DamoYBUJXdfoUhZ1bKVMuJUXYyCtf9A7opMubDZI6Fo
Message-ID: <CAE7as+a-uvbOGrA_QCGitWj8fsAbe88UmP4AyywxkWk=nhjihw@mail.gmail.com>
Subject: Re: [GSOC PATCH 2/2] builtin/prune: stop depending on 'the_repository'
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 1:02=E2=80=AFPM shejialuo <shejialuo@gmail.com> wro=
te:
>
> On Sun, Jun 08, 2025 at 06:36:35AM +0530, Ayush Chandekar wrote:
>
> [snip]
>
> > @@ -99,7 +98,7 @@ static int prune_object(const struct object_id *oid, =
const char *fullpath,
> >       if (st.st_mtime > expire)
> >               return 0;
> >       if (show_only || verbose) {
> > -             enum object_type type =3D oid_object_info(the_repository,=
 oid,
> > +             enum object_type type =3D oid_object_info(revs->repo, oid=
,
> >                                                       NULL);
>
> Could we simply make `NULL` in the same line by the way? The readability
> would be better.
>

Yeah, I agree, will do that.

> >               printf("%s %s\n", oid_to_hex(oid),
> >                      (type > 0) ? type_name(type) : "unknown");
> > @@ -154,7 +153,7 @@ static void remove_temporary_files(const char *path=
)
> >  int cmd_prune(int argc,
> >             const char **argv,
> >             const char *prefix,
> > -           struct repository *repo UNUSED)
> > +           struct repository *repo)
> >  {
> >       struct rev_info revs;
> >       int exclude_promisor_objects =3D 0;
> > @@ -173,19 +172,19 @@ int cmd_prune(int argc,
> >       expire =3D TIME_MAX;
> >       save_commit_buffer =3D 0;
> >       disable_replace_refs();
> > -     repo_init_revisions(the_repository, &revs, prefix);
> > +     repo_init_revisions(repo, &revs, prefix);
> >
> >       argc =3D parse_options(argc, argv, prefix, options, prune_usage, =
0);
> >
> > -     if (the_repository->repository_format_precious_objects)
> > +     if (repo->repository_format_precious_objects)
> >               die(_("cannot prune in a precious-objects repo"));
> >
> >       while (argc--) {
> >               struct object_id oid;
> >               const char *name =3D *argv++;
> >
> > -             if (!repo_get_oid(the_repository, name, &oid)) {
> > -                     struct object *object =3D parse_object_or_die(the=
_repository, &oid,
> > +             if (!repo_get_oid(repo, name, &oid)) {
> > +                     struct object *object =3D parse_object_or_die(rep=
o, &oid,
> >                                                                   name)=
;
>
> Same, could we just make `name` in the same line. There is no need for
> the newline right now as we change "the_repository" to "repo" which
> would reduce some columns.
>

Yeah, got it.

> Thanks,
> Jialuo

Thanks:)
