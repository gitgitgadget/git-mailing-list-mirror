Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE31E98FD
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738100703; cv=none; b=Gf6MwgIzg60LUxF1WbGAJhuhzyHm3xw9fzP5G5R0lKoPQdQ1oDChGiZYt/yNnXTXyfRlrEcIzr8cH9GxVXK2ENoS2w8fXXF5Y9PmGTkuv+JSAflv4CPybb9gU1GJH8C7P5k6n/XW+qoaXGiWG6W4l86TvXAUA82NM3jL7Pm4JWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738100703; c=relaxed/simple;
	bh=8ZdSJbl9tqEsZtQPBLTYUnsoFF0Z9SDvg2PNEQIyHYI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=R6XBuDnU4f8W6pR4vJRLqtAQoHNqtn2kOBps6kOekI+shi4vthdPUaQUxIJZob/eI7Lbv//xIljWHBbgrkh/fwreiozb4G84Jj7IkPgG6dkpdfHir1IS+CmnE6RrYQulu/TNaLNvWePH15JEfJUjun/u/vUov5n4df+a62r//pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=iR1nDFjm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="iR1nDFjm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2161d4b820bso11382405ad.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1738100701; x=1738705501; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4LsFo6KdPyWNE2MffzccY+J47boNPmKbkJol4+ErzA=;
        b=iR1nDFjmQAtCIrOrkyxr0qI1NSzfmHyDm1ZVTNgrmSmBR0VQZNO7PxeJ5Hyf7FVZ3j
         IiDvfoB0hi+Je76s78WHbMU+zjAWBGr8tn1UCnkEH3zfJIabvPuOvS6FcWBfZ7BO4CVk
         t2cga3soYj6JDtsiBOnPSpGaeV3zUcpNbeCa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738100701; x=1738705501;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4LsFo6KdPyWNE2MffzccY+J47boNPmKbkJol4+ErzA=;
        b=KAkxwEsafVH/001pkarptX/1UlxH2MzGBiUlzs7B+pX5jdgbme9A5Ew/ABomXx+WCb
         Pw3Vk48r/+6eRbAdBi6bseSp9CrWVbQ1398kdrdJ04oj/JvEOi9YBAWXgRuzTLQihHw1
         dOCda/fW92EUsR6vaZEILbW0wvnUakCClI8PrUALPHagSK1tnSsvg/nGqy0sWrbDLJ2p
         ftIklukAmm9BquC6ASl/BSF5PNkV2zlpovgC/VivvwUnRFFCjgiadkalPR6oKuRTjSCf
         ltxjFxLnyeXEb3m133KxXIqYia+GTB/ZzrsV0L+bHnzwoHPbW2jq+as6RBRCKiKapynY
         OGjg==
X-Forwarded-Encrypted: i=1; AJvYcCWrNoNI8KbSwxHQ/lH0y7Sn1i++WbvOuBbQAGWBf0DR0yBisnFHLS8+Zpl6F7Z8Vt5BNtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmJAboZrN1Qh1JCLKJWY0GTgjjxlO9bBGo36fpXMIe/eomTaz
	Hemjwo0stasAkkpwkmiBHM2Y1DJDm4XofpGy5ikcrLZXQ7S8gJSE6p/VjX9vse0=
X-Gm-Gg: ASbGncv24HySno5L1V6w6or08gOa9WI0kWRrXpXcZMzm5O6IHxHiKG5ushnRkC2Uivp
	ZFmKS+LgvhSSAwZtv+7YVR5P969SsS+xgyO73Yyphck4345wwznK4OB2gHq66mV39dEMSpMbHXW
	3FrGXUUwK7wDM+MjgOJusoNuyv9xb1BeMabdT8tNfCVTnDs6GjmPrHlAakUOxuGb1MJL4czf6Xx
	NxF+W9dFlV2aKm77Tx1mCDlz+kZBE2tEvziAffmH5v+zH2Z38GLEhgvGOKO/Wxpz/UxjEtBJJmr
	jmwOeE9HFA4S8aQWXVejpLP/NnUEhLan40DeB/alVaZg71sDj3U=
X-Google-Smtp-Source: AGHT+IH6kPpahYcbLGeoT5UQHtKdkkkFatrY4mzOC+gPrb5cysvJdHMO8swwy9cKI08e1bVW2WL3Og==
X-Received: by 2002:a17:902:cec9:b0:21d:cdb7:876c with SMTP id d9443c01a7336-21dd7c43c92mr4330325ad.3.1738100699037;
        Tue, 28 Jan 2025 13:44:59 -0800 (PST)
Received: from smtpclient.apple ([2604:3d09:1c88:400:68e6:a0b4:7dfa:e89d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c9fdsm87493395ad.4.2025.01.28.13.44.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2025 13:44:58 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v2] worktree: detect from secondary worktree if main
 worktree is bare
From: Olga Pilipenco <olga.pilipenco@shopify.com>
In-Reply-To: <CAPig+cRpKKpVHT8x6nOx1KNjWR=hywz-nHZga9fhiXMXD7KOSw@mail.gmail.com>
Date: Tue, 28 Jan 2025 14:44:47 -0700
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <116C27A8-EF7B-42E1-9606-815FDA3CF94C@shopify.com>
References: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
 <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
 <CAPig+cRpKKpVHT8x6nOx1KNjWR=hywz-nHZga9fhiXMXD7KOSw@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)

Thank you for the review, I totally understand the delay in the review =
process and appreciate your time spent on this.

> On Jan 19, 2025, at 3:30=E2=80=AFPM, Eric Sunshine =
<sunshine@sunshineco.com> wrote:
>=20
> On Thu, Jan 16, 2025 at 4:35=E2=80=AFPM Olga Pilipenco via =
GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Setup:
>> 1. Have a bare repo with core.bare =3D true in config.worktree
>> 2. Create a new worktree
>>=20
>> Behavior:
>> =46rom the secondary worktree the main worktree appears as non-bare.
>>=20
>> Expected:
>> =46rom the secondary worktree the main worktree should appear as =
bare.
>>=20
>> Why current behavior is not good?
>> If the main worktree is detected as not bare it doesn't allow
>> checking out the branch of the main worktree. There are possibly
>> other problems associated with that behavior.
>>=20
>> Why is it happening?
>> While we're inside the secondary worktree we don't initialize the =
main
>> worktree's repository with its configuration.
>=20
> Okay, this is clearly a very real problem and explains this comment
> added by f3534c98e4 (worktree: update is_bare heuristics, 2019-04-19):
>=20
>    NEEDSWORK: If this function is called from a secondary worktree and
>    config.worktree is present, is_bare_repository_cfg will reflect the
>    contents of config.worktree, not the contents of the main worktree.
>    This means that worktree->is_bare may be set to 0 even if the main
>    worktree is configured to be bare.
>=20
> (Aside: I recall reading this comment when Jonathan added it but
> wasn't able to dig into it at the time to really understand it, and
> never got back around to it. Now, after studying your patch, I
> understand what it was about.
>=20
>> How is it fixed?
>> Load actual configs of the main worktree. Also, skip the config =
loading
>> step if we're already inside the current worktree because in that =
case we
>> rely on is_bare_repository() to return the correct result.
>=20
> I found that I had to dig around a bit to fully understand the problem
> expressed by this commit message. Perhaps adding a bit more detail
> would help? Here's my attempt at rewriting the above (also in a way
> which is more idiomatic to this project):
>=20
>    When extensions.worktreeConfig is true and the main worktree is
>    bare -- that is, its config.worktree file contains core.bare=3Dtrue
>    -- commands run from secondary worktrees incorrectly see the main
>    worktree as not bare. As such, those commands incorrectly think
>    that the repository's default branch (typically "main" or
>    "master") is checked out in the bare repository even though it's
>    not. This makes it impossible, for instance, to checkout or delete
>    the default branch from a secondary worktree, among other
>    shortcomings.
>=20
>    This problem occurs because, when extensions.worktreeConfig is
>    true, commands run in secondary worktrees only consult
>    $commondir/config and $commondir/worktrees/<id>/config.worktree,
>    thus they never see the main worktree's core.bare=3Dtrue setting in
>    $commondir/config.worktree.
>=20
>    Fix this problem by consulting the main worktree's config.worktree
>    file when checking whether it is bare. (This extra work is
>    performed only when running from a secondary worktree.)


Wow, your explanation is so much better than mine.Thank you for =
=E2=80=9Ctranslating" it for the world :) I=E2=80=99m still trying to =
get used to the terminology used in this codebase.
I=E2=80=99ll steal your description for sure (if you don=E2=80=99t =
mind).

>=20
>> Other solutions considered:
>> Alternatively, instead of incorrectly always using
>> `the_repository` as the main worktree's repository, we can detect
>> and load the actual repository of the main worktree and then use
>> that repository's `is_bare` value extracted from correct configs.
>> However, this approach is a bit riskier and could also affect
>> performance. Since we had the assignment `worktree->repo =3D
>> the_repository` for a long time already, I decided it's safe to
>> keep it as it is for now; it can be still fixed separately from
>> this change.
>=20
> I found this paragraph somewhat confusing because it seems to conflate
> a repository (i.e. the shared object database) with the `struct
> repository` type, and the configuration which happens to get loaded
> and stored (as one of *many* members) of the repository structure. I
> had to read it several times to understand that this was talking about
> instantiating a separate `struct repository` initialized from the main
> worktree configuration. I agree that doing so would likely be overkill
> and could impact performance negatively. I understand that you added
> this paragraph because SubmittingPatches suggests to do so, but I
> think it can probably be omitted in this case unless it can be
> rewritten to be more clear (but even then I doubt it is necessary to
> keep it).

Trust me, it took me a while to wrap my head around `struct repository` =
as well.
I agree if the explanation is too confusing and doesn=E2=80=99t bring =
any value, it can be omitted.

>=20
>> Real life use case:
>> 1. Have a bare repo
>> 2. Create a worktree from the bare repo
>> 3. In the secondary worktree enable sparse-checkout - this enables
>> extensions.worktreeConfig and keeps core.bare=3Dtrue setting in
>> config.worktree of the bare worktree
>> 4. The secondary worktree or any other non-bare worktree created
>> won't be able to use branch main (not even once), but it should be
>> able to.
>=20
> This is mostly repeating what was said earlier, thus probably isn't
> adding any value to the commit message. I'd probably drop it.

I agree, your improved description captures this scenario perfectly.

>=20
>> Signed-off-by: Olga Pilipenco <olga.pilipenco@shopify.com>
>> ---
>>    Changes since v1:
>>=20
>>     * no code changes
>>     * rebased with maint
>>     * CC added
>=20
> Sorry. I've had your v1 sitting in my ever-increasingly-large backlog
> of patches to look at, but have been extra busy the last many months
> and never managed to get to it.

Totally understand. Thanks again for getting to it eventually.

>=20
>>    Existing broken functionality forces our project to use hacks on =
bare
>>    repo that we'd like to avoid. I would really appreciate reviews of =
this
>>    patch to move closer towards fixing the issue. This is my first
>>    contribution to git/git, I apologize if I got lost in the =
instructions,
>>    but I tried my best to follow the rules.
>=20
> Your submission is fine. Unfortunately, the project has a lack of
> reviewers but no lack of submitters, so sometimes patches get
> overlooked or simply buried.
>=20
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> @@ -410,6 +410,20 @@ test_expect_success 'bare main worktree has HEAD =
at branch deleted by secondary
>> +test_expect_success 'secondary worktree can switch to main if common =
dir is bare worktree' '
>=20
> The use of "common dir" is a bit confusing. Also, this patch is fixing
> the more general problem that secondary worktrees think that the bare
> main worktree has a branch checked out. So, perhaps a better title
> would be:
>=20
>    secondary worktrees recognize core.bare=3Dtrue in main =
config.worktree
>=20
> or something?

Sounds good, will update.

>=20
>> +       test_when_finished "rm -rf bare_repo non_bare_repo =
secondary_worktree" &&
>> +       git init -b main non_bare_repo &&
>> +       test_commit -C non_bare_repo x &&
>> +
>> +       git clone --bare non_bare_repo bare_repo &&
>> +       git -C bare_repo config extensions.worktreeConfig true &&
>> +       git -C bare_repo config unset core.bare &&
>> +       git -C bare_repo config --worktree core.bare true &&
>> +
>> +       git -C bare_repo worktree add ../secondary_worktree &&
>> +       git -C secondary_worktree checkout main
>> +'
>=20
> Very straightforward and exactly what I expected to see once I
> understood the problem.
>=20
>> diff --git a/worktree.c b/worktree.c
>> @@ -65,6 +65,28 @@ static int is_current_worktree(struct worktree =
*wt)
>> +static int is_bare_git_dir(const char *git_dir)
>=20
> Nit: I wonder if a name such as is_main_worktree_bare() would clue
> readers in a bit more?

I was about to explain how I wanted this function to be more generic and =
handle all sorts of bare and non-bare cases - whether it=E2=80=99s the =
main worktree or not. However, after seeing your comments and after =
revisiting the code, I realized that generalization doesn=E2=80=99t =
really provide much benefit here. It is much clearer if we're explicit =
that the bare check in this case is only performed on the main worktree. =
I=E2=80=99ll update it in the next version.

>=20
>> +{
>> +       int bare =3D 0;
>> +       struct config_set cs =3D { { 0 } };
>=20
> This is not your fault since this construct is used elsewhere in this
> file (from which I presume you copied it), but project consensus is
> that using the notation `{{0}}` to work around a complaint from the
> Apple compiler (and only the Apple compiler) should be avoided, and
> that `{0}` is preferred. So, if you reroll, changing this to `{0}` may
> make other reviewers happy (or you can leave it as is to be consistent
> with existing precedence in this file; I don't feel strongly about
> it).

I=E2=80=99ll fix it, sounds like a good reason.

>=20
>> +       char *config_file;
>> +       char *worktree_config_file;
>> +
>> +       config_file =3D xstrfmt("%s/config", git_dir);
>> +       worktree_config_file =3D xstrfmt("%s/config.worktree",  =
git_dir);
>> +
>> +       git_configset_init(&cs);
>> +       git_configset_add_file(&cs, config_file);
>> +       git_configset_add_file(&cs, worktree_config_file);
>=20
> Genuine question: I haven't thought too deeply about it, but do we
> gain anything by loading $commondir/config here -- which is shared by
> the main worktree and all secondary worktrees -- considering that it
> was already loaded and consulted by the earlier is-bare check before
> this function was even called?

This function determines if a worktree is bare or not. I want this logic =
to work even when it=E2=80=99s called from a different context and not =
rely on other is-bare checks (that are a bit confusing tbh).

>=20
>> +       git_configset_get_bool(&cs, "core.bare", &bare);
>> +
>> +       git_configset_clear(&cs);
>> +       free(config_file);
>> +       free(worktree_config_file);
>> +       return bare;
>=20
> Everything gets cleaned up correctly. Good.
>=20
>> @@ -77,18 +99,16 @@ static struct worktree *get_main_worktree(int =
skip_reading_head)
>> +       /*
>> +        * NEEDSWORK: the_repository is not always main worktree's =
repository
>> +       */
>>        worktree->repo =3D the_repository;
>>        worktree->path =3D strbuf_detach(&worktree_path, NULL);
>=20
> I found this new NEEDSWORK comment rather confusing the first several
> times I read the patch. It wasn't until I finally realized that the
> reference to `the_repository` here is the same reference to
> `the_repository` in the commit message -- which confused me, as well
> -- that I understood what this was trying to say. The actual problem,
> of course, is that the _configuration_ stored in `the_repository` is
> the secondary worktree's configuration, not the main worktree's
> configuration. Considering that this patch addresses that problem, I'd
> probably just drop this new comment altogether (unless, perhaps, you
> rewrite it to talk about the _configuration_ stored in
> `the_repository`).

This `the_repository` structure is soooo confusing, took me a while to =
figure out what it is! I would feel guilty not mentioning that under =
some circumstances `the_repository` assigned here could be not actual =
configuration of the worktree object. I don=E2=80=99t know if that will =
ever matter or not, but I find this assignment kinda =E2=80=9Cstinky=E2=80=
=9D and want everyone to know about it. I don=E2=80=99t want to change =
this assignment in this patch because it didn=E2=80=99t bring any harm =
so far. I=E2=80=99ll try again to rephrase this comment, just to give a =
heads up in case someone experiences =E2=80=9Cweird=E2=80=9D behaviour =
in this area (same way the previous NEEDSWORK comment gave me ideas why =
my workflow didn=E2=80=99t work and inspired me to try to fix it).

>=20
>> -       /*
>> -        * NEEDSWORK: If this function is called from a secondary =
worktree and
>> -        * config.worktree is present, is_bare_repository_cfg will =
reflect the
>> -        * contents of config.worktree, not the contents of the main =
worktree.
>> -        * This means that worktree->is_bare may be set to 0 even if =
the main
>> -        * worktree is configured to be bare.
>> -        */
>> -       worktree->is_bare =3D (is_bare_repository_cfg =3D=3D 1) ||
>> -               is_bare_repository();
>>        worktree->is_current =3D is_current_worktree(worktree);
>> +       worktree->is_bare =3D (is_bare_repository_cfg =3D=3D 1) ||
>> +               is_bare_repository() ||
>> +               (!worktree->is_current && =
is_bare_git_dir(repo_get_common_dir(the_repository)));
>=20
> This is performing the expensive check only if the earlier checks left
> the question unanswered. Good.

Thanks for the review. I=E2=80=99ll incorporate the changes in my next =
version and hopefully it will be good to go :tada:
I hope I responded to all the comments, it=E2=80=99s a bit =
nerve-wrecking to contribute for the first time (so many rules and =
instructions!) :)

