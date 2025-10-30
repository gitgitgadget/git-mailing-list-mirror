Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3919354715
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821998; cv=none; b=rTNh/fHIxhlurbykTDy0ZOTgMHyRE+bIqleods+sDaCPHd+3muNMg4K2xC5ZY32jo2ueBYJbCYnrPMlXc8tXTemfxp5ASHaXmL7AvStKNDRkr1ysYkCQPn/Tolpp9SqStTPTIgSRfFjfh1dLAbHcgLhUMeWtCA/TjlEm6rC72fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821998; c=relaxed/simple;
	bh=2Nmq2qRrs2r/SL0J4nT/0RX2V39d9+lXWuz72cpsJGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfucQzDMO97kJlNeWgi4Bn/jseEMCPTtLd0PmIIyhT78X2CXxcq+btmPPrfRIjppb7Gy5pm9kjeZyVZlOD38D8qgLqyR+i84YrYnTb2ZPH23RWJEd9qZLzleHgYtZwrDDArJS1UqZrxfFe4lcjDqcoVckU4CbnCPOKfjG6vle94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvCQs1ja; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvCQs1ja"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cea3f34ebso644767a12.0
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821996; x=1762426796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es0mATvth9nd6som0yFI5DvkCAmV0RHaVDsCTzJ3488=;
        b=fvCQs1jaz9gARCTA3z+fylZtxlwvZ6QgNO82Oqt1ua10kGRlwncFrwxD6knDwLDOcE
         ykTGmxDUA4fm7DzvcHGGb14mc1gNTbh/zFu0gHzpwoAPxPRnNhFBf510PVVZv1z8mDsh
         FcBi7G2KHChq+RvlXdPjDczac0WCRnXvrRo4ChVBsAKJQMDP45W4HVylK9U220RvMaGO
         EVc5ZZFxrfN4kCuVgNBRvN/mjgxxRqGTUvJ7WLunUeNKrg7ibQjpDcrWodD7Srgj6zgJ
         NM8u6haik8wOS+Uw8DoPa0i4wCyNPRIQSyf7CgBJliN943hF+ZPJxGLAwW4UQ3tUj27E
         DD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821996; x=1762426796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=es0mATvth9nd6som0yFI5DvkCAmV0RHaVDsCTzJ3488=;
        b=jTY0qQWofZ5XFffYb8KErz7NByar2d6+E/ij3C7VnZ4b8yYYZCTPA/NwTf1nndu4O7
         MrxdJUjEHvtcyJNrXo6DHvLR5gluh+uALp8VMMPzPzNUUh2BFl4ZjlbbLl4w9TingXHe
         0WpAVVeZIgbJulenQ6rGWQuqqNyv4pRK5cZcubD3q5Msbj3Q5/3IqRUYp9kTU4JKxXH0
         XcYbMZCBUejSSV8+i75PdAFZFjSEI2EFWSZk36jDOrD8zR2q7umN97HmrNGfSFz1QeLE
         zMQf782SHu5YuQEvDsWnIyF2zaHL7eSpXeUpQyRhx7ZHcTJJ8szOzdEjUE3YwveRoH44
         sI3w==
X-Gm-Message-State: AOJu0YyQldCsD/vP4g8Nk7SMJcvU8yc4hYr4U97JomOsC2swoc3AKPEa
	Lk9OLtG+LYqOhFeZofcsg/BT9v6gwWr4vhjApIDbVOXHTgXPF5bhgfDMtQftizX6sYpRpdC98je
	LGZmtbLiTS7Zqv1+cIXiGDmidIimZ1tw=
X-Gm-Gg: ASbGncszG4zRowmLClfqGfXO+EbXBxPSYB68gfsGg0DRxjLlb7NeUkK7rqUNkSptlrY
	9V6lnkI44hPtuR+NzSnYg8gvobaVxzvCRVXg5hRnluOIHTh+a9qmhqbBASMQpAjusJJ9ZJOCY8x
	/V2nZ/h1ZvZCU+xtxQRZ6YTtf74xULI7q7KljYS5EKltMxkv0jI8pMea9Ex6hngX+KmBl/hcuee
	C/OenXA6PU+1RyVSppVt8dQnu24fog6mk7wusHf9K13AGh6O9pVtBafYBS/MKlHVGPP2tXExKY=
X-Google-Smtp-Source: AGHT+IGKoRCdRVs4RXPK3kzB9z0gRrfeboFz1+pjeNK3Z0YKU3h8AZNLnOFN9cmxfhH7B6Bhq3KigHa1Mm5lQN81pjA=
X-Received: by 2002:a17:902:d4c8:b0:28a:8ae7:4034 with SMTP id
 d9443c01a7336-294edc26f99mr33110945ad.25.1761821995812; Thu, 30 Oct 2025
 03:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L9anYu4LKWGDKrwzBBytMunJ3UjTehNN9m2DigG8yCNHA@mail.gmail.com>
 <CAP8UFD0a+RxQ-pPWrmwOYhBic6Oy9C1NeA7EmEyj2KYYDyS4QA@mail.gmail.com>
In-Reply-To: <CAP8UFD0a+RxQ-pPWrmwOYhBic6Oy9C1NeA7EmEyj2KYYDyS4QA@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 30 Oct 2025 11:59:57 +0100
X-Gm-Features: AWmQ_bnXlF3pLctBrR6Jl-HOFREdhQx8c101vIB_1iFq5N1aZinoPGwpI9WceGw
Message-ID: <CAD=f0L8=eBJjj77xBw7m7WcQf80sYbF-X1wbFc9ToC9F0AWVAQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BOutreachy=5D=5BProposal=5D=3A_Refactor_in_order_to_redu?=
	=?UTF-8?Q?ce_Git=E2=80=99s_global_state?=
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Oct 2025 at 16:51, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Wed, Oct 29, 2025 at 2:18=E2=80=AFAM Bello Olamide <belkid98@gmail.com=
> wrote:
> >
> > Hello,
> > This is my proposal for the project
> > "Refactor in order to reduce Git=E2=80=99s global state" for the 2025 O=
utreachy
> > Internship program.
>
> Thanks for this proposal.
>
> [...]
>
> > From a high level overview, environment.[ch] exposes some global
> > variables that reflect a per-repository state and examples of such incl=
ude
> > git_work_tree_cfg, is_bare_repository_cfg, and core.* settings and func=
tions
> > which also depend on `the_repository` such as have_git_dir(),
> > is_bare_repository().
> > After a brief study of some related work done on the project,
> > it is important to understand the purpose of the identified global vari=
able
> > and how it is used across the code base, observing how it relates with =
other
> > subsystems and moving it to the `struct repository` or `struct
> > repo-settings` if its
> > use is repository specific, or specify an appropriate context based on =
its scope
> > and use this context in the accessor functions.
> > For example in [1], Patrick Steinhardt observes that `core.hooksPath`
> > is repository specific and is stored in the global variable `git_hooks_=
path`.
> > The variable is then moved into local scope in the repo-settings
> > struct and a new
> > accessor function `repo_settings_get_hooks_path()` is written and used =
to
> > set the `hooks_path` of the repo specific struct which the path subsyst=
em
> > reads from.
> > Similarly in [2], `core.sharedRepository` is tracked via the global var=
iables
> > `the_shared_repository ` and `need_shared_repository`. These are then
> > moved into the repo-settings struct, with new accessors functions
> > written to modify them,
> > and calls to the accessors in the path subsystem are then modified to
> > replace the old
> > accessors which modify the global variables.
>
> Nit: the above paragraph looks very big. Maybe it could be split a bit.

Okay I will do that, thank you
>
> > I also studied [3], [4] by Ayush Chandeker,] and [5] by John Cai to bro=
aden my
> > understanding of the project.
>
> Are there some cases where strategies other than writing new accessors
> functions were used?

Yes there were cases where the functions were adapted to use
exactly what it needs down the call chain rather than writing new
accessor functions.
An example is
https://public-inbox.org/git/20250306-b4-pks-objects-without-the-repository=
-v2-1-f3465327be69@pks.im/#Z31csum-file.h
where the global variable `the_hash_algo` is replaced with an explicit para=
meter
`const struct git_hash_algo *algo` in low-level functions such as
`static struct hashfile *hashfd_internal()` and the call sites adapted
to use r->hash_algo
or the_repository->hash_algo in places where the subsystem has not gotten r=
id of
`the-repository`.

This is also a strategy that can be used to replace global variables.
>
> Are there pieces of work on this that were started but not finished?
> Are you planning to finish them?
>
> What are the roadblocks that were faced when working on this?
>

Yes. There were pieces of work that were started but not finished which I p=
lan
to finish.
As an example, the patch
https://lore.kernel.org/git/20250309153321.254844-1-ayu.chandekar@gmail.com=
/
attempts to move the `git_attributes_file` global variable to the
`struct repository`.
However because the global variable is used by the attributes subsystem and
a single repository can have more than one set of attributes, that is
the work-tree attributes
and the index attributes, placing the variable into a repository
instance and passing it
around in the call chain will not be appropriate. Also most of the
functions in the attributes
subsystem pass the `index_state` as a parameter and not the repository.
This is because an index knows its repository but a repository only knows i=
ts
primary index. Therefore each repository for an index will need to be known
from the index.

As Junio pointed out in the discussion on the thread:
"As the attribute system is all about giving extra information on the
paths that appear in the index and in the working tree, it may make
sense for the API to go from the index state which is about the
index and the working tree to access the attributes, rather than
from the repository structure, which controls a lot wider concept
and moving anything and everything there will easily and quickly
make it a messy kitchen sink."

So Given that the `index_state` struct has a repo member, we can move
'git_attributes_file' into the repo struct but access it through the
`index_state`.
By doing that we know the index truly owns the attributes.

There is also `is_bare_repository_cfg` as seen in
https://lore.kernel.org/git/pull.1826.git.git.1730926082.gitgitgadget@gmail=
.com/
I have only skimmed through the discussions and patches to understand why i=
t
was not finished.
But I will do an in depth study to understand why it was not completed and =
what
it takes to finish it.

> > 3. Review Existing Patch and Define Criteria (December 16 - January 9, =
2026):
> > -------------------------------------------------------------
> > - Thoroughly examine the existing patch series submitted to the mailing
> >     list  to understand;
> >     * What criteria makes a global variable a suitable candidate to be
> >        moved to the `struct repository` or `struct repo-settings`
> >     * What appropriate context it should be moved into based on its
> >        interactions with other subsystems.
> >     * If remaining a global variable is the best approach in its case.
> > - This information can be gotten by paying attention to the discussions
> > in the patches and also engaging with my mentors and the Git community.
>
> Are you sure that it will be possible to define clear criteria?

Yes it will be possible to define clear criteria per global variable.
For example, from my brief study of previous work, if the variable value is=
:

1. meant to be different for different repositories, it is a candidate
to move, if not then it is left
    as is, like the case of `local_repo_env[]`.

2. used during early startup, it cannot be moved blindly but will need
a closer inspection
    and refactoring of the startup code as is the case with
`have_git_dir()` noted by Patrick and
    Shejialuo in
    https://lore.kernel.org/git/20250305104650.238392-1-ayu.chandekar@gmail=
.com/.

Its relationship with other subsystems is also a criteria to define
such as the case of
`git_attributes_file mentioned` above

Thanks
