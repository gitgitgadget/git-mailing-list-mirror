Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B882E62B4
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743734450; cv=none; b=E5RPmRhBHDWK9K2SqSIR/61CYPUJbs73Ewe/ik9HpCuIeRvTtKqbWKf7omTt9EhlI7dyrzMzWAUZw5uGfxhTL2fxEgRF7EziMH0P593r2agtdUtW+W9EhbmicGim2QW2N+uXtqzNfkrDcgpdwiFP8plCo9mi2M/WuiLXt0f4Fss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743734450; c=relaxed/simple;
	bh=qKpf1DQQ/MsWX32jiY5OQpbxaV0fIbwRT0/PxvwLJfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHP3bAqMxgPQovkuMMpRO+fcrq6kN74jzGpd5gne6jgW3z/kJfa80u/tIqXVSjLTFVmTM2RuoOj7yX0oKP31vHnM3fapioVNXP62EWUk6RucQ+sSTiLcM3E2wQ5rbYCNsu85mn2zOZ5QH1m5wcGCWdOI+zg6HAXtJCK8u3ztixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jiksm+w/; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jiksm+w/"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d439dc0548so5654565ab.3
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743734448; x=1744339248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8FXPBDIwVhLb7+6KEJhCRI+fqrR92FyIieiGrXWfaI=;
        b=Jiksm+w/CbxO5uYjimsde9/Oeks9zixIj/8WnbsLKlo3WNH0sp5CudR/IeG+WRboTu
         /EUA1Bhjme6ovOUxFlz7CRpw6/S3plb0WR3BepAVVkIMv29hBY5j9rAqc9iGwMhVo7xW
         ewWgpySL5YvH/eXg6+oC97hhCyFklu94JxfqyKTJGur0moeYfOw31WJfrZN9cFbZ3ZRL
         dLPdwQxjDRsaJ/zK1PPfxJ0SkJ0clDY6dSiBtGeq2Lq3Zz5YfiMq29DxAIJM9ZQ3dyD6
         3rblznkhI9uYInejq5Z/Do44qerGZCZDSJQTWs6rFHMemZZeaVSmMhPSiM86CkTgctne
         6Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743734448; x=1744339248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8FXPBDIwVhLb7+6KEJhCRI+fqrR92FyIieiGrXWfaI=;
        b=oF9XBZlXUAUo/tat5L9xY0hCSZH3Z0EgsBvU2tdB624ze7J7haI5k6mMLjeKjgjR4e
         /pV2Zscaqm0ikZ0uDMXU+fTg+RPxPY8tUhSKrpw79vFAugFzUi03j4IVQjfFAGAhSA56
         zA24K6oeFrJ7wltnO2QoNzXAt9wZMwNTK+sr7/awua8EG07pXbz0j5S+R5YsUFFqxrNu
         lNiAWMPKu9EAyrIA/HJo7xl0wpt/ofvWlQsf1KGcY+sy7YqLE9+Wrx4AFg9HwI7vOG/t
         Rwb44iFYFPpv4/Eh2uwFTytxYcmG/mmCLINc3UncwL0Dt9AEGbQxXg8Q/AOxNj2Dv78g
         EzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4qb3i/4izeO+0s31giN/urvHVy8/x4DRIPkN/uOX393k7sTM1/qbGhA8TE7nJaoNmLfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMSI5UjE0OuxNTwfZ3fvGqRm5F1WHeEUudjPzwlaQUV/9ReKx
	TJ+rll73ktN7WO6ZR2sMIpeS0WCr2qZVqRpILp00ru4nGl+uLHOTWHVaYEtgK0yAIWVzIHx1CEv
	hjP9LTeuDU6Dcx6g0aY8CO46AIk8=
X-Gm-Gg: ASbGncuo7IlKgR7NzHRdmJ5UD/o2CaOy41kwP6zZkLPPIJgd2+Xz6fTncunKx24SQT4
	PdC/9wOZ5eztP/LC/kip104mPualqX6B+tGLmeHCFIo3u6beT6KD7BtCJKchTXy2UnlXEzGkDyN
	n1tJ8cIFYTC5N69UEPncuBhm0eNzsR4j225kF0ONy2QsJdR71G0AdyF7NDCkU=
X-Google-Smtp-Source: AGHT+IE/3Yc09u1xmcpMPtqdAY5ICSHlI3fIZIWozFrmU3EFZWxBWub1x3s9Rm1bO4S7MEsgS2smgB0NcMATQyIiWxE=
X-Received: by 2002:a05:6e02:12e6:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3d6e3f740f2mr23026455ab.18.1743734447921; Thu, 03 Apr 2025
 19:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev> <CABPp-BECTrVp9X6bVmzU8LEeYsC3KbzeJvAaDPN+FgZz_uEhmA@mail.gmail.com>
In-Reply-To: <CABPp-BECTrVp9X6bVmzU8LEeYsC3KbzeJvAaDPN+FgZz_uEhmA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Apr 2025 19:40:36 -0700
X-Gm-Features: AQ5f1JqGzkFi-NxLisiGenHmXCOYPf_uVQBfQS3Le3620BjIlZJWpPZVTtGGXbY
Message-ID: <CABPp-BFYoZ1cuUMJPhWhtgntS0D-E=ZF+8_KS7gC+ShXjTrEDg@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Martin von Zweigbergk <martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 7:28=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Thu, Apr 3, 2025 at 9:40=E2=80=AFAM Remo Senekowitsch <remo@buenzli.de=
v> wrote:
> >
> > On Thu Apr 3, 2025 at 5:39 PM CEST, Elijah Newren wrote:
> > > On Wed, Apr 2, 2025 at 11:48=E2=80=AFAM Martin von Zweigbergk
> > > <martinvonz@google.com> wrote:
> > >>
> > >> There are many benefits to having a change id even if it's just
> > >> local. I mentioned some in my email to this mailing list in [1].
> > >> For example, it enables
> > >> `git rebase main <change ID>; git switch <change ID>` without
> > >> requiring the user to look up the hash of the rewritten commit.
> > >
> > > But <change ID> isn't unique, right?  The whole point of having the
> > > change ID is to preserve it despite edits (e.g. rebase, commit
> > > --amend, cherry-pick), meaning that you end up with multiple commits
> > > with the same <change ID>.
> > >
> > > Why would this work?
> > >
> > > And if it does work, isn't it expensive since you'd need to walk
> > > history to find it?  Or do you keep an extra lookup table on the side
> > > somewhere?
> >
> > For rebase and commit --amend, the way Jujutsu deals with those is that
> > all descendants are immediately rebased on top of the new commit, and
> > refs to those descendants are updated as well. That means, the old
> > version of the patch with the same change-id becomes unreachable. So,
> > at least most of the time, the change-id is indeed unique.
> >
> > This doesn't work for cherry-pick, more on that below.
> >
> > Some of these features are not in Git yet, at least not to my knowledge=
.
> > That means getting the full benefit of change-ids with Git itself
> > would indeed require some more work. I know of rebase.updateRefs
> > and rebase.rebaseMerges, which move the Git experience closer to
> > Jujutsu, but don't go all the way. AFAIK it's not possible with Git to
> > automatically rebase --update-refs all descendants of a commit that is
> > amended or rebased.
>
> Correct; that doesn't exist currently.
>
> > Jujutsu does keep a separate index of change-ids, yes.
>
> Thanks.
>
> > >> There is a design doc [2] about the impact on Gerrit and how to
> > >> handle various cases where the client doesn't understand the
> > >> `change-id` header. That also includes some discussion about
> > >> whether cherry-picking should preserve the change id or create a
> > >> new one. I think there is a lot of value in having a
> > >> standardized header regardless of what we decide about
> > >> cherry-picks.
> > >
> > > cherry-pick & rebase preserve author name, email & time, while
> > > creating a new committer name, email, & time.  To me, the change-id i=
s
> > > about the authorship, and since these commands already preserve
> > > authorship, it'd seem weird to me to have cherry-pick not preserve th=
e
> > > change-id by default.
> >
> > I'd say Jujutsu, Gerrit and GitButler think of a change-id as associate=
d
> > with a unit of review. (Although it will naturally support reviewing
> > sets of patches as well.) Usually only one person will push commits wit=
h
> > the same change-id, just like people don't usually force-push over each
> > others branches. But that's mostly about avoiding logistical problems.
> > When an employee leaves a company or is on vacation, it can be perfectl=
y
> > reasonable for someone else to take over their work. In that case, it
> > would be appropriate to preserve the change-id, even though authorship
> > has changed, because the history of code review on that patch should
> > stay associated with the new version.
> >
> > Cherry-picking on the other hand often represents a separate unit of
> > review. That review may revolve around whether it makes sense to
> > backport a bugfix at all or any additional changes that may have been
> > necessary to make the bugfix work in the different, older codebase.
>
> I've worked with many projects hosted in Gerrit, and they all had a
> very different view of change-ids than what you've espoused here.
> They cherry-picked changes to other branches, fully expecting the
> change-id to be kept the same.  They often checked to verify that
> important fixes had been backported to all the relevant LTS branches
> by looking for the change-id.  So, we'd typically have N+1 commits
> sharing the same change-id, all reachable from existing branches,
> where N is the number of LTS versions still supported at the time (and
> the +1 comes from the main branch development).
>
> > As mentioned above, there's also the issue that preserving the change-i=
d
> > on cherry-pick likely results in duplicates. For Jujutsu, it would be
> > nice it this was avoided. But it's not infeasible to deal with that
> > either.
> >
> > For Gerrit, it would be important to be able to track a change across
> > cherry-picks somehow, since that is a feature they already have. If Git
> > decides to preserve the change-id on cherry-pick, there's no problem
> > for Gerrit. Alternatives include storing a separate cherry-picked-from
> > header or enabling the -x flag on cherry-pick by default.
>
> Cherry-picked-from trailers can be nice when it exists, but much more
> frequently than one would want it provides a dead-end.  People will
> cherry-pick a commit that was local-only, or only found in some
> security-embargoed repository, and you'd end up with dead ends.  You
> also occasionally get chains: E cherry-picked from D, which was
> cherry-picked from C, which was cherry-picked from B, etc.  And more
> complex structures are possible.  And maybe part of that chain was a
> local-only commit or some commit from a security-embargoed repository
> that you don't have access to.  Then folks get to write scripts and
> try to deduce relationships from those trailers (e.g. hey, these two
> commits both claim they were cherry-picked from the same non-existent
> commit, and this other commit was a cherry-pick of one of these two,
> so they're a representation of the same logical change on these
> different LTS branches).  It makes it a hassle to try to determine
> which LTS branches have the appropriate fixes backported and applied.
> I've done it, but I thought this problem was logically the point of
> change-ids as found in Gerrit, honestly (well, that and its byzantine
> push to refs/for/$BRANCH stuff so it could automagically determine
> which CR that your push was supposed to be correlated with instead of
> just letting you specify via a real refname in your push command).
> While I understand that having nearly-unique change-ids let you use
> change-ids interchangably with commits, that seems like a questionable
> benefit over being able to actually track which logical changes are
> the same and have been applied to which LTS branches.  I fully realize
> folks may disagree...but if we're suggesting commands like `git switch
> <change-id>` which can only possibly be meaningful if <change-id> is
> unique across all branches, then what are we supposed to do for the
> many projects which use change-ids for LTS backport tracking?  What
> does `git switch <change-id>` (and any other command where you attempt
> to use a non-unique change-id in place of a unique commit identifier)
> do for them?

One possible simple solution here is just to treat change-ids (or
there abbreviations) kind of like abbreviated hashes -- they aren't
guaranteed to be unique.  If the user specifies a change-id and there
are multiple branches with such a change-id, we provide the user an
error much like we do for abbreviated hashes.

Is that what folks have in mind?  If so, I'll be happy to drop my
reservations about this aspect.
