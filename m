Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912E155C88
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738354274; cv=none; b=N98vMDj5czn2bmmcb5zGzMS/Xs/K7IkZDDz6yBNXfXDi8roWHSm+kWrRHMDinrbMtjqXyS5KxsFHRZWa5/EsrZ1e+xhtE1XCGPVqfiRDoh+kzsuMIeenUt1AaTFVW4c1kp6U9TAsULowdemovBBb4xxU72UYKdbt1wGT29BaUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738354274; c=relaxed/simple;
	bh=Gdj0/hL4j2VCpPBmULNucjS+BIvqVPU5bMtWs8PdC8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8fEnUZzyMY5OJqoEx2k0x0Ii8dqD9i8H10bl/8/BobqwOE9oURPA4M6pahfmSmyLRllTG6aLTNp9BKSTMX5MC9rKN2TiuGf0TzpCpFcWMC66pDdjBU3yd1367H1GhzJLAV5jDpEMKVlsGOmPszTEIzGfWQA1T0T7kHnEeaXfXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=WdZEW0SL; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="WdZEW0SL"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f8d5e49ea1so50078eaf.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 12:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1738354271; x=1738959071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPXUIyUW34bdwcCVvwpfhR0woegJqdaCTS2vd+JlKWY=;
        b=WdZEW0SLzsNBRKiUlCDWBUjdpU6AAzYT288VRDrfMB4U4g+qnHsza9+Hm8zvZc5mXS
         qLDsZAi3grpwvi6iqn2hBgkkOmZvxcfSR/uIqspSMUIo976mMSFkaILBvrNGPRv7NX4P
         syUaStj3urQrylyFWqcCN9Vqdkd2Ph+pJIrtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738354271; x=1738959071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPXUIyUW34bdwcCVvwpfhR0woegJqdaCTS2vd+JlKWY=;
        b=TmI/aA5oLkFpUBbyOawR2nu1DKUMVGNaaSu8vaIr2G0pFHLO3Myv4uxtgHWiTp3Teb
         KIjT+t+3je92/v0DyVQoKnEQ0POedDCHz7IskLft5KzkmweesFJpkwP8UdvLm1MQ7oD9
         GcpKU+4AHRIBlBvA/L0Tu22zQiTKYnxZErf1hrnwF7gkv+c7+Ph0m+L/KzkUMhWHtor8
         aFk1OzUKFEj0Qi2jwg92o/hA0WFtLq2PKKFgyVt+5SV3GDVOp2/pUNAFbzqkkt5BNfPx
         id+X7DvSYg9MMbUGhuFI1ZSOYIGQUN2fv6YXlXpBN3s5pwLbJdEkpQ2KwWvc1n3yvdnt
         TRoA==
X-Forwarded-Encrypted: i=1; AJvYcCUGIrEQe2CFOQXYJNVeOMF4phEKxtDcj9wSb3IfZCNPo7p2Dkrjnr5OESjgNt7ka/eGopM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2kqdVqVRCE8GKRvIFfa4laOrDTTuBSVSvI93tLtzYdRpCHTa
	AUajZbgEazbQGcD5F1wMizzKgulVxMcank+4cUyFdiQLOLIZQyOCjMph27kN0afu5LNHafC6dym
	dIk20L5FIPrDBl8OL5nBg2w2kM5UVfJYpyJ8IKw==
X-Gm-Gg: ASbGncurhJTeZiMvL/k7fAWzsThRuCoRwmo9i56Qodz4ifrp7g+RkwwVNKpCR8cQ3NJ
	2p21S9FDmtMw2a5ydi8Xtt27V0s6ZFHjwQUonLMfw30EIdaWiICkmZrv2d0uPq7LpHb/BaL2u3z
	OtnH4JHnJQoq1OSALZ10HYZbo5FnSALA==
X-Google-Smtp-Source: AGHT+IGnRGHqMXGmXPApRWPAhSHQThFymevJUdi9BHPkPVHInLC36t4CazGNecuAxlc/VPvTpBLDDp6iofODI6emat8=
X-Received: by 2002:a05:6870:af93:b0:29f:de73:b4e3 with SMTP id
 586e51a60fabf-2b32eb80769mr2876956fac.0.1738354271186; Fri, 31 Jan 2025
 12:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
 <pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com> <xmqqcyg294ft.fsf@gitster.g>
 <xmqq8qqq943u.fsf@gitster.g>
In-Reply-To: <xmqq8qqq943u.fsf@gitster.g>
From: Olga Pilipenco <olga.pilipenco@shopify.com>
Date: Fri, 31 Jan 2025 13:11:00 -0700
X-Gm-Features: AWEUYZkKxsa8riyLf9nqAV0-Z2L1chtBWPvR8B7KSn3opkmykwlYcPCp9NGSoqs
Message-ID: <CAFLeGL52tKmurpAHymk42Y9DGazbK8nRdtWAoyzW85eMDxJQhQ@mail.gmail.com>
Subject: Re: [PATCH v3] worktree: detect from secondary worktree if main
 worktree is bare
To: Junio C Hamano <gitster@pobox.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 12:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Olga Pilipenco via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> +/*
> >> +* When in a secondary worktree, and when extensions.worktreeConfig
> >> +* is true, only $commondir/config and $commondir/worktrees/<id>/
> >> +* config.worktree are consulted, hence any core.bare=3Dtrue setting i=
n
> >> +* $commondir/config.worktree gets overlooked. Thus, check it manually
> >> +* to determine if the repository is bare.
> >> +*/
> >> +static int is_main_worktree_bare(struct repository *repo)
> >> +{
> >> +    int bare =3D 0;
> >> +    struct config_set cs =3D {0};
> >> +    char *worktree_config =3D xstrfmt("%s/config.worktree", repo_get_=
common_dir(repo));
> >> +
> >> +    git_configset_init(&cs);
> >> +    git_configset_add_file(&cs, worktree_config);
> >> +    git_configset_get_bool(&cs, "core.bare", &bare);
> >> +
> >> +    git_configset_clear(&cs);
> >> +    free(worktree_config);
> >> +    return bare;
> >> +}
> >
> > That is nicely described.
> >
> >>  /**
> >>   * get the main worktree
> >>   */
> >> @@ -79,16 +101,11 @@ static struct worktree *get_main_worktree(int ski=
p_reading_head)
> >>      CALLOC_ARRAY(worktree, 1);
> >>      worktree->repo =3D the_repository;
> >>      worktree->path =3D strbuf_detach(&worktree_path, NULL);
> >> -    /*
> >> -     * NEEDSWORK: If this function is called from a secondary worktre=
e and
> >> -     * config.worktree is present, is_bare_repository_cfg will reflec=
t the
> >> -     * contents of config.worktree, not the contents of the main work=
tree.
> >> -     * This means that worktree->is_bare may be set to 0 even if the =
main
> >> -     * worktree is configured to be bare.
> >> -     */
> >> -    worktree->is_bare =3D (is_bare_repository_cfg =3D=3D 1) ||
> >> -            is_bare_repository();
> >>      worktree->is_current =3D is_current_worktree(worktree);
> >> +    worktree->is_bare =3D (is_bare_repository_cfg =3D=3D 1) ||
> >> +            is_bare_repository() ||
> >> +            (!worktree->is_current && is_main_worktree_bare(the_repos=
itory));
> >
> > Is "this worktree does not have is_current bit set" equivalent to
> > "this worktree is the main one, so is_main_worktree_bare() needs to
> > be consulted"?  That linkage between "the is_current bit unset" and
> > "is the main worktree" is not obvious to me.
>
> Does the thinking behind it go like this?
>
>     We grabbed the "main" worktree object and stored it in worktree;
>     it is either our current worktree (in which case is_current is
>     true), or it is not (in which case, is_current is false).  We
>     know that the old logic failed when asking the "is it bare"
>     question from a secondary worktree.  !worktree->is_current tells
>     us that we _are_ asking the question from a secondary worktree,
>     so we need to make the extra call to check config.worktree file
>     as well in that case.
>
> Perhaps the logic is clear to those who diagnosed the problem, wrote
> the patch, and reviewed it, in which case there is no reason to
> reroll.  Perhaps it was just me to whom it was not obvious that
> the purpose of "is_current" check was not about "are we looking at
> the main worktree" but was about "if we are not in the main worktree,
> we need this extra check".
>
> Thanks.

You did a great job figuring it out and I agree it's confusing at
first, but we tried
our best to make it less confusing.
`is_current` check is actually not necessary there, but having it there sav=
es
extra unnecessary calculations, also describes & fixes the exact scenario
that didn't work (not being able to see main worktree as bare from a
secondary worktree).

Thanks for looking into that.
