Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE402253AB
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082518; cv=none; b=PvtpvkYkshT9f6im1vM7WtTfr3pmdmHSn7Z+GQtGR5fTRL/GGn9S2fW+EluPJT64K0KEQKYNhAFEW7a2tBNeiKzC6l0O4+lBard9XeOHzgODDajsncNhkJ3z4zIreJHwDWyn5arERMmVpLAV0djlvhZmXgUOY+2eyeoMEqyyaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082518; c=relaxed/simple;
	bh=n8IjHJTko6ShptKZG2oyTSHweAqwpj4Iab2HBFSNWp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZKhgPtM4cADjxsfkNVt3UKOCzXfeX61qyfgd+z176rdlqN/h9w+Trr5C1D3YeNDFsmc3C3z2S0l3IzYPQ45p6HsDkW4MICvPGIDR36NGf+9aGMReLQXXJXVXRJOqOXBiWAMjn7vb877TQUBDwJtbnvLb3yH9OhxbTAylGvZqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcJP5fmv; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcJP5fmv"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-879502274cfso8680039f.0
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752082513; x=1752687313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiCN+DXNmEuzUmRtDN+VvvwjbLvjtd+o96Mv4jayRRk=;
        b=UcJP5fmv4dUSGp3jbkYYgoSe9YxFfNlSQhv99gJhcNxaVmnulPxQqrPt5oUCZ4v87E
         +a1yI/+qUsGStJ56J7SSkWCYfTGLJpoPKIG6GrYL4XLMXj2RyQM03Y4D0C6n0A01YtGW
         A7z0+SH0cyGAOG5eQHX3YUpsPNxLk2VxKiA+Q6Rod6wzs5m9GHcJ5M6EncxD+t93O+qR
         TRfqUeYFpiym/C71TAQz7FrnPg/hvio5O9myqYUOSYuwgYlAFer2irKHs7+dGeZpB+ip
         qsiupakcsg7ot+AjmH9aLYkRWoeDqAUx2uGDIvHmUsjfMe23J0FXJNUkMcsHqDrSNmFF
         SUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752082513; x=1752687313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiCN+DXNmEuzUmRtDN+VvvwjbLvjtd+o96Mv4jayRRk=;
        b=iUoJiIMCWMVOYykU3meZxRVcqfNR50lIbm+FUqtVByaJjmKeANVPZ41pYgv8wDx8eh
         W+3oHEhxbl3V7Q6x5Gno8L5wqZXe4sMby2GMGB7pVhGNS4Xyk+whu8XamR7u4WBcX2tt
         6gNu0kNl1q2GXglC95coRy44JYG4EM9AdWvsN/X9r0UeJ277DxTaAZcvLlnPGup7tsKS
         RyEfH6JXO24KX9XkUTdHByry/h3AoE3Tv3PexgAakP3KaSKrSf/+h6Tq4NFzwmq/Qxgu
         p/Ui3xvwZxe6Tki7pMMTsGJYDWEWgoOi64I9KY70HJ7ZjjKoHwu22vKPrZ0bvo5SD5fr
         8BQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgl8rsoC+HpB4aWIcQIEZ5ftw24M1JdBFn+9mpzsi7Z60lI/ZKq2uyeFSiHkOcv8d9uQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEHpcGgwKG7v+IyQwZKCVEBSQWic4/RX1SU2XHF2YswaoJ/tO
	Zbp0WKRwBuslpPk2cEu/HoqkxnJ4SewuCqOCBYNg4qPgORxjWPqPkpYY60jGPxAF26WaxSU3NL4
	lV+mRBtQNJp+Lr+W12aMnr3eHhzpft4U=
X-Gm-Gg: ASbGncsdCxXVMEum23Lvs2Z94wESuWvpxgidhR1mUFDrLDXPywuyzvFjMIIYPpmic1e
	i4TnfgUpF2UBgZdnIlsAO343wak0osuTcNqktIHDFiQ0YWjDUdL37H1HSKW+GQeJGzELQ7qqzYx
	roo3Zy/IkB/JI1aKe9l7DAC3gKvouuqYNf6bTIomdJC+ZX/YDhOmUus4tU+CWlCjuG8SyvOquO8
	/8=
X-Google-Smtp-Source: AGHT+IFKIIXWixo2vVf0H9VjO7jcMkL6LD+QnnJRPB3oVNG87iTVADzTrGnGLI/++9SPPDuOPj6kJxTOyyy2wPAp8jY=
X-Received: by 2002:a05:6e02:3092:b0:3df:3ab2:cc7c with SMTP id
 e9e14a558f8ab-3e243fe04c6mr7770825ab.13.1752082513352; Wed, 09 Jul 2025
 10:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
 <CABPp-BH_JGbtDsne_tKBoqDr9LzL==gs0E5xyPdbqygyXs8+vA@mail.gmail.com> <492244b9-2402-4e8e-8599-8bcd5d27e2f8@gmail.com>
In-Reply-To: <492244b9-2402-4e8e-8599-8bcd5d27e2f8@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 9 Jul 2025 10:35:02 -0700
X-Gm-Features: Ac12FXxStOoZ4qSsmQj_JXe5DmQbfd_amvtCHABafjDFVEVXMD4v7kLzSggNB8E
Message-ID: <CABPp-BFO3Mx9LHPxjbdm2ayvfs2gx9nC9vJnW=zuARgCYrQzNQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 9:13=E2=80=AFAM Derrick Stolee <stolee@gmail.com> wr=
ote:
>
> On 7/8/2025 5:43 PM, Elijah Newren wrote:
> > On Tue, Jul 8, 2025 at 4:20=E2=80=AFAM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>

[...]
> >> Add a new subcommand to 'git sparse-checkout' that removes these
> >> tracked-but-sparse directories, including any excluded or ignored file=
s
> >> underneath.
> >
> > "including"?
>
> Yes. If we leave the ignored files then we have not accomplished our
> goal in deleting the sparse directories.

I understood that; my interest was more in what is being glossed over
with this word, i.e. what else would be removed.

> >> This is the most extreme method for doing this, but it works
> >> when the sparse-checkout is in cone mode and is expected to rescope
> >> based on directories, not files.
> >
> > So is this also meant for cone mode without sparse index turned on?
> > What about non-cone mode?
>
> This command die()s if not in cone mode. We can consider future
> changes that perform similar actions in non-cone mode, but I'm
> not sure if there is a valuable need in that case.

That answers the second question; what about the first -- cone mode
without a sparse index?  (Edit: you discuss that below, so I'll add
more there.)

> >> Be sure to add a --dry-run option so users can predict what will be
> >> deleted. In general, output the directories that are being removed so
> >> users can know what was removed.
> >
> > Is greater fidelity of interest when there are multiple different
> > types of files contained?  For example, "git status" lists individual
> > files within a directory, unless it find an ignored directory and then
> > it simply lists the directory.  That means we get more fidelity when
> > it's warranted, and less when it's not.  I'm not sure if that's a
> > perfect analogy, though; it may well be that we don't need the same
> > kind of fidelity that `git status` provides.  (And I'm kind of
> > guessing it isn't needed, except in error cases, but I'm just asking.)
> >
> >> Note that untracked directories remain.
> >
> > What does this mean?  If the sparse directory had an untracked
> > directory within it then it'll be left on disk, you will only clean up
> > untracked files at a depth of 1 within the sparse directory?
> >
> > Or that untracked directories not contained within a sparse directory
> > will be left alone?
>
> This second part: "untracked directories not contained within
> a sparse directory will remain". This is mostly to point out
> that we are not saying "the only directories that remain are
> tracked directories within the sparse-checkout" as that could
> remove valuable temporary directories that are covered by
> .gitignore or exclude files.

Thanks; could this be clarified in the commit message?

> >> Further, directories that
> >> contain staged changes are not deleted.
> >
> > Shouldn't those be safe to delete?  When a sparse directory has files
> > underneath it with staged changes, those roll-up into a staged
> > sparse-directory tree value, and so we should be able to delete the
> > file.
>
> This is _mostly_ an implementation detail. The sparse index will
> not represent this directory as a sparse directory, so it's not
> deleted. (see the next paragraph:)

If there are files with staged changes underneath a directory, I don't
see why the sparse index would not be able to represent that directory
as a sparse directory.

From the implementation, I'm wondering if you meant something entirely
different by this sentence and that "contain" was perhaps a misleading
word choice; in particular, did you mean that when the directory
itself has been replaced in the index with some staged file, then you
leave that staged file/directory alone?  If this was the intended
meaning, perhaps we just need some rewording to clarify the commit
message since "contain" makes me think about paths below the
directory, not another path to replace the directory.

And if neither of my guesses are what you meant by this sentence,
please do clue me in.

> >> This is a detail that is partly
> >> hidden by the implementation which relies on collapsing the index to a
> >> sparse index in-memory and only deleting directories that are listed a=
s
> >> sparse in the index. If a staged change exists, then that entry is not
> >> stored as a sparse tree entry and thus remains on-disk until committed
> >> or reset.
> > In contrast, the files under the sparse directory with unstaged
> > changes would be problematic to simply remove.
> Except that a user is only using this command when they want
> files outside of the sparse-checkout to be deleted.
>
> I'd like to find the right way to make it clear to users who
> discover this command that they are asking for the following:
>
>   "I changed my sparse-checkout and some directories that I
>    expected to be deleted are still around. Delete them as I
>    don't care about them or the files inside anymore."
>
> Some of the discussion around having a --verbose option (in
> conjunction with --dry-run) would allow for the following
> user scenario:
>
>   "I changed my sparse-checkout and some directories that I
>    expected to be deleted are still around. Which files are
>    preventing that deletion? I'd like to know what's in the
>    way so I can evaluate if those files are important to me."

Yes, and this might even be a status-like output, showing whether the
files are untracked, ignored, tracked-and-unmodified, or
tracked-and-modified.

> >> +'clean'::
> >> +       Remove all files in tracked directories that are outside of th=
e
> >> +       sparse-checkout definition.
> >
> > If literal, this sounds unsafe, particularly if run while resolving
> > merge or rebase conflicts (since those conflicts may occur in paths
> > outside the sparse checkout definition).
>
> If we are in a merge-conflict state, the directory is not
> collapsed in the sparse index..

Ah, good to know.

> >> +                                                    This subcommand r=
equires cone-mode
> >> +       sparse-checkout to be sure that we know which directories are
> >> +       both tracked and all contained paths are not in the sparse-che=
ckout.
> >> +       This command can be used to be sure the sparse index works
> >> +       efficiently.
> >
> > So...what does it do when in cone mode and the sparse index is not enab=
led?
>
> It doesn't effect the behavior, since we don't care about the on-disk
> format and instead use an in-memory sparse index to determine which
> directories to delete.
>
> There could be a benefit for users wanting to clean up extra files in
> their worktree even if they are not using a sparse index. It is less
> likely that they will discover that they are in that state if they
> are not pestered by the index expansion advice message.

Right, for cone mode without the sparse index turned on, this new
subcommand seems to be a silent no-op (other than burning some
computation time), despite the fact that the wording in the manual
might lead users to believe it will do some nice tidying for them.
When the command spends some time working but doesn't do anything and
doesn't report anything, the user might then think the command is just
buggy.  I think the command should probably either (a) do some tidying
for them, or (b) give them a warning that the command has no effect
when sparse index is not turned on.  Thoughts?

[...]
> >> +               printf("%s\n", ce->name);
> >> +               if (!clean_opts.dry_run) {
> >> +                       if (remove_dir_recursively(&full_path, 0))
> >> +                               warning_errno(_("failed to remove '%s'=
"), ce->name);
> >> +               }
> >
> > ...and then unconditionally remove the directory, as you stated in the
> > documentation for this clean option.
> >
> > I'm worried whether this is safe; if someone does a merge or rebase,
> > there could be tracked-and-modified/conflicted files outside the
> > sparse specification in the working tree.
>
> The conflicted files will not collapse to sparse directory entries.
>
> Does that ease your concern on that front?

Yes, that does ease my concerns...but it doesn't erase them.

If someone resolves the conflicted merge or rebase and commits (long
before running this `git sparse-checkout clean` command), what happens
to those paths?  Do these materialized paths persist in the worktree
after the commit?  I know they did at some point in our
implementation, and the current wording of `git sparse-checkout
reapply` in the manual certainly suggests such paths may stick around
until the user takes manual action:

           Reapply the sparsity pattern rules to paths in the working tree.
           Commands like merge or rebase can materialize paths to do their
           work (e.g. in order to show you a conflict), and other
           sparse-checkout commands might fail to sparsify an individual fi=
le
           (e.g. because it has unstaged changes or conflicts). In such cas=
es,
           it can make sense to run git sparse-checkout reapply later after
           cleaning up affected paths (e.g. resolving conflicts, undoing or
           committing changes, etc.).

Now, if these paths stick around despite being outside the sparsity
specification, users may decide to modify them.  And if they have
modified them and run your command, won't you succeed in collapsing to
a sparse directory tree?  And then wouldn't this cause unstaged
changes to be discarded?  (I know this is a rare case, because users
would probably only merge or rebase changes they made while in their
sparse-checkout, and thus conflicts would generally be limited to the
sparse-checkout, but there are at least three ways I can think of that
conflicts could be triggered outside their sparse checkout, so I think
it's a realistic scenario that we should think through.)

Throwing away unstaged changes is something that is usually gated
behind a forcing flag (e.g. `git reset --hard` or `git checkout
--force`).  I know, we currently also gate removal of untracked files
in `git clean` behind a `--force` flag as well and I'm not concerned
with throwing away untracked files with your command without a forcing
flag, but I'm just wondering if we should be more careful with
unstaged changes than with untracked files.

Perhaps everyone is fine with also throwing away unstaged changes as
part of this command.  I could be convinced of that.  But if so, that
should at least be called out rather explicitly in the commit message,
the documentation, and the tests, whereas currently your patch is
silent on anything other than untracked and ignored files.

(Or, if my memory is out-of-date about materialized paths persisting
after their conflicts are resolved and a commit happens, then it'd
probably be worth calling that out in the commit message and perhaps
also updating some wording on the reapply subcommand.)

> > Even after resolving such a merge and committing, the paths may remain
> > around until the user does a 'git sparse-checkout reapply' (I don't
> > remember details here, but our documentation for reapply certainly
> > says so), and since the file might stick around, the user may make
> > further modifications to such a file.
> >
> > ...or will the convert_to_sparse() call above fail in all these cases?
> >  If it does, should it give a better and more useful error message
> > than "failed to convert index to a sparse index" and rather e.g. "path
> > %s has modifications; please stage or revert first"?
>
> It won't fail. It just won't collapse as far.

Oh!  Based on this hint, I went and looked up the code for this; it's
from convert_to_sparse_rec(), right?  I see something interesting
there; does the present-despite-skipped checks (from 82386b44963f
(Merge branch 'en/present-despite-skipped', 2022-03-09)) cause this
collapsing to also fail for unstaged entries?  I.e. this part of
convert_to_sparse_rec():

                if (ce_stage(ce) ||
                    S_ISGITLINK(ce->ce_mode) ||
                    !(ce->ce_flags & CE_SKIP_WORKTREE))
                        can_convert =3D 0;

The `ce_stage(ce)` part of it is what prevent it from collapsing when
there are conflicts, and I think the `!(ce->ce_flags &
CE_SKIP_WORKTREE))` would prevent it from collapsing any tracked files
whatsoever, whether modified or not, due to the
present-despite-skipped checks.  Does that sound right?

In other words, perhaps your clean command as implemented really does
only handle untracked and ignored files, and if the user also has
tracked-but-unmodified or tracked-with-unstaged-changes or
tracked-with-staged-changes then this command won't actually restore
performance for them until they _also_ run `git sparse-checkout
reapply` ?

> You do make a good point that there could be extra help messages to say
> that there are uncollapsed directories (detectable by seeing a blob path
> with the skip-worktree bit on, maybe). I will think on this.

In order to detect this by the skip-worktree bit, you'd probably need
to run it as part of the present-despite-skipped checks mentioned
above (or run it before those checks clear the skip-worktree bit for
present files).
