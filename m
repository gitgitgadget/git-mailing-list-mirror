Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCB45006
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598310; cv=none; b=CtG1uF34geBSE3Jx2LaXJWx3Lv/4C0YeYhkuF5evEJ9NTs91KX2+3sKR2FC2sPhg5x3QC6aMPLfF5NwStUS8PAPa8g0pdjS8gBpOT879fTGpnjsTVypWgQvaAG0m31Vk2PvEJO9yOfTEUwAZxtvOq4lR8aVQvP34LZt5WLwmRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598310; c=relaxed/simple;
	bh=Q+zdoCc1YsH0YIjIz4muep1w5wDTNw9K4GAPSTL9ov4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIzvZMZ5KGxn+RalN5j3q7qlZwLGsgiBvsBiWyCYR/HREeJDIleRN3I9lPcRwE5EdhmDjAMQGMu+ULaCAyzAdyBwl3kr16PmLvBBIYXFjzpLJNnviec7GjRF41Y4qcXz1Bv4AlomCuQdIWHlbMqvgxppBPjpMSnHvAyKTK+ZM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejgy3cBk; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejgy3cBk"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51114557c77so1858378e87.0
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 23:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706598306; x=1707203106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifL8w/ji4PrLxfLrvdzhp6VHPJPKpVPeInX2MjTUbOY=;
        b=ejgy3cBkeDsbfdQW09FeJL0p4+M4Rb45EElh10a+5IQVgBfASvJ2GoZpv1jlze7v/K
         UWLAjpx/0Hm5Ch1sArGxSRqy+N6DHG/Gw/ABZZ5QQym+uMNyrGYpRrxA3m7CW2ePqiko
         yg77hJlLJzQVoATQ7fknKN6/Ful7wZcdwa8BFK0c8VgqqIuwSkUXKDP99uOlrTPhgQTC
         5OyE46zz24YP3jCMNu0bJgMbNJXAcAB8eVOBJfs3AbBi4xGOGo0D2BcT5nXlCouTRakf
         m9js1oDBzP1SQY4UYzTiiT8OWHeSddy5H7vPujHe1qkKAz8z3LcrnGxytiTbUg2cXhyJ
         k8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706598306; x=1707203106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifL8w/ji4PrLxfLrvdzhp6VHPJPKpVPeInX2MjTUbOY=;
        b=fSPM0Lw/nM6tRTzuBRG342aU1Pqc0DS4ETzynFwaX9CVkcbieoi4f2r97YII1nhD7y
         e6H9FpTJvAltdiC9oIPwElxzMATMQikMNI3xvphniGpGFhRVzc1jyoaFzgh/unFhORRD
         nOZFjB/ag3rhuilmuZgKJMpqV2W8j2odoZDLG9xakGrcbHpzPvsjw3ZIGy39CUA0dwvY
         OMgnbt2kAMPz5WJx5H/9DKgN9YCB7Qg8/Soe+SamMsYE+SHzoM7cGoK06N6R+9fpXg+0
         tqRlJV6nQR3du0TLmx2Ye4EaPsYqRYM7JII7SJpRIZzCDm3rcGthqZ6/xQjL0bu/V7Rf
         2hyQ==
X-Gm-Message-State: AOJu0Yx1qVHJXCMMQzB5319p6aPQMYqPnHHsBKpYp1o00kHY9ipSEBnI
	ADZOB6uzupQDrenheBYvFtKQi37GcwEHwwNcQIQ/fn3wYNWxKB3PERxYhuKdsPKcpLwb+Y216uc
	WvJOlKPQ06+I961iWWTMrpyrUkJn8ma1H
X-Google-Smtp-Source: AGHT+IHp3MhlZuuim6Oc+CmzKLvs4e5vS1f0CGKAM9PjSb+DmCHq93v7akn0kPBOFXVLnjNv/NU5BrCHy8Orbi+iscI=
X-Received: by 2002:ac2:514a:0:b0:510:1904:3cf7 with SMTP id
 q10-20020ac2514a000000b0051019043cf7mr4462380lfd.56.1706598305964; Mon, 29
 Jan 2024 23:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 29 Jan 2024 23:04:53 -0800
Message-ID: <CABPp-BFPe_RrX5ZHo7-mMHHS96j_O+1wiEwGC5+zGPP5h+686Q@mail.gmail.com>
Subject: Re: [PATCH] merge-tree: accept 3 trees as arguments
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:18=E2=80=AFAM Johannes Schindelin via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When specifying a merge base explicitly, there is actually no good
> reason why the inputs need to be commits: that's only needed if the
> merge base has to be deduced from the commit graph.
>
> This commit is best viewed with `--color-moved
> --color-moved-ws=3Dallow-indentation-change`.

Makes sense.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     merge-tree: accept 3 trees as arguments
>
>     I was asked to implement this at $dayjob and it seems like a feature
>     that might be useful to other users, too.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1647%2F=
dscho%2Fallow-merge-tree-to-accept-3-trees-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1647/dscho=
/allow-merge-tree-to-accept-3-trees-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1647
>
>  Documentation/git-merge-tree.txt |  5 +++-
>  builtin/merge-tree.c             | 42 +++++++++++++++++++-------------
>  t/t4301-merge-tree-write-tree.sh |  8 ++++++
>  3 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index b50acace3bc..214e30c70ba 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -64,10 +64,13 @@ OPTIONS
>         share no common history.  This flag can be given to override that
>         check and make the merge proceed anyway.
>
> ---merge-base=3D<commit>::
> +--merge-base=3D<tree-ish>::

A very minor point, but any chance we can just use `<tree>`, like
git-restore does?  I've never liked the '-ish' that we use as it seems
to throw users, and I think they understand that they can use a commit
or a tag where a tree is expected

>         Instead of finding the merge-bases for <branch1> and <branch2>,
>         specify a merge-base for the merge, and specifying multiple bases=
 is
>         currently not supported. This option is incompatible with `--stdi=
n`.
> ++
> +As the merge-base is provided directly, <branch1> and <branch2> do not n=
eed
> +o specify commits; it is sufficient if they specify trees.
>
>  [[OUTPUT]]
>  OUTPUT
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 3bdec53fbe5..cbd8e15af6d 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -429,35 +429,43 @@ static int real_merge(struct merge_tree_options *o,
>         struct merge_options opt;
>
>         copy_merge_options(&opt, &o->merge_options);
> -       parent1 =3D get_merge_parent(branch1);
> -       if (!parent1)
> -               help_unknown_ref(branch1, "merge-tree",
> -                                _("not something we can merge"));
> -
> -       parent2 =3D get_merge_parent(branch2);
> -       if (!parent2)
> -               help_unknown_ref(branch2, "merge-tree",
> -                                _("not something we can merge"));
> -
>         opt.show_rename_progress =3D 0;
>
>         opt.branch1 =3D branch1;
>         opt.branch2 =3D branch2;

If branch1 and branch2 refer to trees, then when users hit conflicts
they'll see e.g.

<<<<<<< aaaaaaa
  somecode();
=3D=3D=3D=3D=3D=3D=3D
  othercode();
>>>>>>> bbbbbbb

but aaaaaaa and bbbbbbb are not commits that they can find.  They may
discover how to show the contents of the tree objects (most users I
run into seem to be unaware that hashes in git can refer to anything
other than commits), but they certainly won't get any context from
git-log as they might hope.

The other places in the code that deal directly with merging trees,
git-am and git-merge-recursive, both provide specially overridden
values for both branch1 and branch2.  (They probably ought to do
something with opt->ancestor as well, but that's been the single ugly
edge case problem that is solely responsible for merge-recursive not
having been fully replaced by merge-ort yet and I haven't wanted to go
back and mess with it.)

That raises the question: if the user passes trees in, should we
require helpful names be provided as additional parameters?  Or are
the usecases such that we don't expect callers to have any useful
information about where these trees come from and these suboptimal
conflicts are the best we can do?
