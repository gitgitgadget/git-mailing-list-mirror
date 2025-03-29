Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCD3597B
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743242058; cv=none; b=NYor/9Z7t/gkm92VW6j2Dz78lG6xcmrt+Y9gAjYuq+3/80nySt7YGqObS/+fHOe5Jzysc03sUny6cR/IfSVk1xjspJuEhfs0F46Fqtxi1TRl1llMZCByitWH/jdIzXwqtwaCd6aGf05l4ANyo+4dNPjoM2SZcnhOg0WiERTYyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743242058; c=relaxed/simple;
	bh=Rbtl5iGkz3fGYZi3EnwZvatQ5Coe8Ost+x9/+WX80nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWbWlMoyj+p2AnY2f8RgP+qACryLKyO5HQ6DsD/kgUGByswwp8kI52K5D5Ge3cxeu8z/FSjsEix+27+7bfvMFKpZaI5HAP9jUgldq1fVxId4kMqAdS//Rz2gyGxpZN/TBxQnNmlSmUqJGCFhcJhXnLrOGKTXJgydxnj1cVvNr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Siw2oUsA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Siw2oUsA"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso3937964a91.3
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743242056; x=1743846856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIs4YEZfNtsCt9b6yqGK4nPOQQ3DZgw+GLh8EeZ/dqQ=;
        b=Siw2oUsA7mAdst5TzMcPVUs4TShYkInf1EF74XdCs1ZkUCfOaRNIFXqZYnZ0eqIfSY
         ZGjcLwLpiY5VPvPqrOGicyVE5HvnSF5BgiH+qtScJJMDrqZCnze2pOUmCBsbS68wKDAq
         ggVC+rBxecy0bmUbn05n9j8/8OKOO9O2w8k5i0jDqlvG8CBM9bMmcJC5e74DepZy6yQy
         ZuFVj65qYX0NGS7t7I/b/yJMJBAa9YliWKSJXQHSaMpaR4dV2mHRpPrzZVXXsVgHD9po
         SbMil0SOz5bSIzsmPTJlGFCj8nLEqsXfD0j6VtrO5I1/7+1t/cacU9N94N29fZ/wIUDG
         jbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743242056; x=1743846856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIs4YEZfNtsCt9b6yqGK4nPOQQ3DZgw+GLh8EeZ/dqQ=;
        b=SZdf3QO6ZSNXDdUUhd40fL+thkHK5t2AT/1subhtD0gbeSSFoTaLWDIdFYEBvJjHfA
         OTj8lz5KulLEtYf90EJJK6g2vrFjKz3CGjX/ZxiD1NDMd2Cop3PpahyXqCO3ZhLAvd3J
         /RP/3SirV5GGQ93ZxnNpo8dABcZVuRQRZluORgpBrroCP3Q4R3tzVt5DMvqFWhXKAUEI
         FRa7de4yIQnTKOkpfcfeas8KT3OFKR2SRhfet5Jve05nOhnqoEawQoZ2Jbm3n96EYZtv
         tZ85YR1Hw4BYFP+Vg6Lu7uUbBjqQ2f0e2iEuN+ROqQ4mr8GpKeVq8Fmsf8Y6zsnS6igV
         eIBA==
X-Gm-Message-State: AOJu0YyABA8kVBtARARwUKPpJG2A1ANC4eUrfNppmRfEt6rmWN5/bKVf
	znsZ0kDv3A/0GWTZxO+9F7KJZ7XhmNFD16bRXHFx1+GfLbrn+CeQrDe+EHup4AM/jR7CXOSs82m
	9xlYwWW6UWWsjbkIZWS+wLmuRMNu8Z3cdk/g=
X-Gm-Gg: ASbGnctu34QLAABTHnYP8IUdTyb8yF0wB6xEl9Qn+xy9MyTlRxZm3pTCjCMgyZY8PW8
	x4331QimUmW/QXOYoNfbvQi4DtlAmRZvbb42arNsq8YAj51LhThlGry7kuGpQAZxb272BJxesW9
	+D3JeLyhQjq3ai5X0VYcGlnTqgCHo=
X-Google-Smtp-Source: AGHT+IH8LINBCmm/y+Le636JBSkIHNawgGcu4yc97IwfUlMjB1S6EjWO4Xdg0l53KZsoFRgMOye99UU6GHrDDw3hXPw=
X-Received: by 2002:a17:90b:1dd0:b0:2ff:7b28:a51a with SMTP id
 98e67ed59e1d1-305320b171cmr4439200a91.17.1743242056458; Sat, 29 Mar 2025
 02:54:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326052602.265989-1-ayu.chandekar@gmail.com> <Z-ae2l6fkurPNuPe@ArchLinux>
In-Reply-To: <Z-ae2l6fkurPNuPe@ArchLinux>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 29 Mar 2025 15:24:05 +0530
X-Gm-Features: AQ5f1JpDiEdxi2yRCHrl0ZD2iuielJ9xP9Jypkr5snPoe-URmL9YLgxTXWzNzd8
Message-ID: <CAE7as+b8qZFEcaH9eJcQnuhZOSW+hfAMiPUBXNPj9x1L7rcXVg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D_=5BPROPOSAL_V1=5D=3A_Refactoring_in_order_to_re?=
	=?UTF-8?Q?duce_Git=E2=80=99s_global_state?=
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	christian.couder@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > This project aims to refactor Git=E2=80=99s environment handling by rel=
ocating
> > these global variables into appropriate local contexts primarily into
> > `struct repository` and `struct repo_settings`. This change will not
>
> I think we could just improve this statement better. Some global
> variables may only apply to one subsystem or two subsystems. In such
> situations, we may just put the global variable into their own context
> but not the "struct repository" or "struct repo_settings".

Right, I was generalizing in my statement, but I agree that some
global variables
may belong in subsystem-specific contexts rather than `struct repository` o=
r
`struct repo_settings`. I'll make sure to account for that distinction
in my proposal
and implementation.

> >
> > Proposed Plan:
> > --------------
> >
> > I have been reviewing global variables across the codebase to understan=
d their
> > dependencies and impact. To do this, I examined `config.c` and cross-re=
ferenced
> > it with `environment.c` to see how these variables are currently manage=
d. The
> > goal of this project is to eliminate global variables by moving their
> > configurations into repository-specific settings. This involves:
> >
> > -   Identifying all occurrences of these global variables.
> >
> > -   Removing dependencies on `the_repository`.
> >
> > -   Updating function signatures to pass `struct repository` explicitly=
.
> >
>
> When reading this, I feel a little wired because I think in [1], you
> have already realized that we should move some global variables to some
> specific subsystems.
>
> [1] https://public-inbox.org/git/20250310151048.69825-1-ayu.chandekar@gma=
il.com/
>

I see your point. I was generalizing again, but I=E2=80=99ll make sure to
clarify this distinction
in my proposal. Thanks for pointing it out!

> > -   Replacing global variable references with repository-scoped configu=
rations.
> >
> > Instead of adding all variables directly into `repo_settings`, we can g=
roup
> > related variables into specialized structs (e.g., `performance_config`,
> > `behaviour_config`, `whitespace_config`) and embed these within `repo_s=
ettings`.
> > This approach ensures a more modular and maintainable design while keep=
ing
> > `repo_settings` manageable.
> >
> > I have also created a diagram explaining this structure in [10].
> >
> > With this approach, I can structure the patch series by grouping the re=
factoring
> > of related variables within specific structs. This will help maintain a=
 clean and
> > organized codebase while also making the development and review process=
 more
> > systematic and efficient.
> >
>
> Yes, it's a good idea to use sub-structure to make the code be cleaner.
> However, from my own experience when being a GSoC student, we should not
> consider about this due to that we will over-engineer this.
>
> You need a lot of time and effort to convince the community why the
> design is good and why we should put this variable into this
> sub-structure.
>
> Instead, you'd better focus on which variables you want to remove
> firstly. And how do you try to remove them with some simple steps. This
> would make you more concentrate on the jobs you need to do and reduce
> the risk.
>

That makes sense. My intent was to provide a structured approach, but
I could see how it
it may introduce unnecessary complexity at this stage. I'll focus on
identifying and managing
the global variables before considering additional structuring. I
think this is something which
can be done at the end of the project. That is, once all the variables
are handled, they can
then be set into specific structures, if needed.

> > One key challenge is determining which variables should be part of
> > `repo_settings` and which should remain separate. While working on the =
patch to
> > refactor access to `core.attributesfile`, I received feedback from Juni=
o that not
> > all global variables should be blindly moved into the `repo_settings` s=
truct.
> > This reinforced the need to carefully assess which variables belong in =
`repo_settings`
> > and which should be handled differently.
> >
>
> Yes, this is correct. I somehow think whether we should put this
> paragraph into Pre-GSoC part? I think that you have found this when
> adding a patch to remove one global variable. And thus by communicating
> with the community, you have further understood that the requirement and
> the detail of this project.

Yep, since I encountered this while working on the patch, it fits well
in the Pre-GSoC section.
Moving it there would better show how I learned more about the
project's scope through
community feedback.

>
> And in your plan, you should just say that we need to do this. Would
> this be better?
>
So, I should remove all the categorization stuff and just say that I
would focus on
each variable, discuss in the community whether it should belong in the str=
uct
repo_settings/repo or not while sending patches?
I felt that keeping it general might seem vague, but that's the nature
of the project. Every variable
is unique and would need a different approach and outlining the
approach of each variable
in the proposal is not very feasible, as these decisions need to
happen collaboratively through
discussions in the community.

Should I still mention that once the project is complete, we could
consider structuring related
stuff if the community sees value in it.

> > This plan is flexible and may be refined through multiple iterations as=
 I receive
> > feedback from the community and reviewers.
> >
> > Timeline:
> > ---------
> >
> > Pre-GSOC:
> > (Until 8 May)
> > -     Explore the codebase more, focusing on environment-related code p=
aths.
> > -     Document how each global variable is used and how it can be moved=
 to
> >       repository settings.
> > -     Study Git=E2=80=99s Coding Guidelines and the Pro Git Book to ali=
gn with best practices.
> >
> > ----------
> >
> > Community Bonding:
> > (May 8 - June 1)
> > -     Engage with mentors to discuss different environment variables, t=
heir
> >       dependencies, and the best approach for refactoring.
> > -     Finalize an implementation plan based on discussions.
> > -     Since I will be on summer vacation, I can start coding early and =
make progress
> >       on the project.
> >
> > ----------
> >
> > Coding Period:
> > (June 2 - August 25)
> > -     Refactor global variables, replacing them with repository-scoped
> >       configurations.
> > -     Modify function signatures to pass `struct repository` explicitly=
 instead
> >       of relying on `the_repository`.
> > -     Categorize variables into specialized structs to improve modulari=
ty and
> >       maintainability.
>
> As I have said, this is a high-risk task. Categorization needs many
> iterations. And we may do this after GSoC.

Yep, will update that.

Thanks for your review, again:)

Ayush
