Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7814685
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605592; cv=none; b=AnhZRYV1EGc71GjBj14+YiSg3yOmPqWpzMHQdbNbtR+3q/b5zJZQCuS/vlRvE/97FB0KVJUH/Q6noNRCcSmPVU/r37zhWot5ieUXoq72aFzn+XvmC7MBU0a4l11zNqwzAlS6vZxKO1E9jdBCtGMLQvScfeTzM7OfEB9FP6Bw0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605592; c=relaxed/simple;
	bh=KD/1tdUVNgNTzZVtimPMYzhPXqpdK8QK8werjeq7gec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvZXMH/NevgsslgbrJjX738jv7XNfW4uBRs+PRY6PB+5DgJCvZ46ETZKnqWgjMEITHuZufOpKcStG05R9lBIOG9brs/QMKTcK+oHvKKyE0Mdw7gY9t+E1nqLYDCVZh8YwKZVt+be7MY7DVfpSu7sekRhXrxTzpg3zmeHlO47w94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCPiopEJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCPiopEJ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a5ae2fdf4eso4726741cf.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749605589; x=1750210389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=usjjtA14kQkHPjlGWsAlyIJwtvHTOVzcjnUF5ucJVLU=;
        b=cCPiopEJwq6TdTnaXeVLGChyGqZItRWoNNKAwDeSlGCKAXULKVybfgz63HhmOKlYeQ
         8az4Ii1x70mynyX++0h0LNvexuim/5IF62C1NjrBIw7SCChp+6OtHf9ZDt+D+rE2XgTR
         YoIF6q5vL+LsCn936rOJIGqlrRIwXv3lpsbkBAu6lEqbc38/nmvwQbnpuvB2sFYUStQm
         NLSiIPGgBCIcQ4WgVZ9d6Q6O2Z3KZ52MWO/7YqrJVKlNxgaIBYElasouKXXoO+7Z5xZr
         Xd4Ejm3mB7FO0K+6d1k9XVEdnnfGHLAKXdna+8pyds8LXLkJt9Fvc+9e/dGXvcaqBkwn
         fccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749605589; x=1750210389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usjjtA14kQkHPjlGWsAlyIJwtvHTOVzcjnUF5ucJVLU=;
        b=VGhZ1F1gWGzhQT7c39eAAsRIodDSLpoTyBZfTdGqkP4Uy0q0OfJFdDW0OeYn/zGYw0
         TDQUkt1Xp6F315bLKMRTDne5wkYUo8YPZ1l0dXLrj1yB2qYhJfiYBcHPk7wVJgv/WFaI
         zZTMeEUQMF8Z/vZ/AlwuIMralJCA3AI1lET/zKxbi0NVsns1S8zrebB3LxFSIh2tqJJo
         QlEvSXpxLvt4U5OL29CyXx+lTAypkAmuxV28pU1SmlXaFcXbfb6Dfp3ey8gteEsBnQoL
         hVecnLd4CrBNtBCPUwDKkNznw38Y6gKto3JXORej7O2MZHK4E5QKQaq17xjfVAPScO5R
         u2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWObtKIXJGpV+6skApVdSdokis5msYHbaEP4mwZ05Ty4jFNeBSwgBwFk8JVyellO5YIFM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxisMjksj5ERjcA0sqADyCpNTfTT2SbqX3QzuGv7e8s7qrzTwWg
	Zd7UNPq9JRnBsdZAOripT02vyoibKcscRfLpEatFj7cFiNBSFZI8HO4uqvo+9MlosLVYYwAW2gs
	vMLMk+m0cYKMjsYtC9gUGwRmMQqim32s=
X-Gm-Gg: ASbGncuqysHMjMBVKu+qTKbphwpb5yaIJ3iaSQCebbF/LgVUxP6efISLbhtCzkIQ1bF
	Qe9gp2kFBmxk6y7HO2KnprqkZACHMj3uNymXf8EDeBfZ7H//7quUtvr0Dfl+0iaUXEoJHIPNdm2
	ApQ6j6qh0T9qx5d2N3kW+oHTw0Flpq/SMRZhct48B1MwGmV4jtWJJsmglABipY/9gHKZg/P5bpI
	jgG1+tbGiQJ1Q==
X-Google-Smtp-Source: AGHT+IFGnok17TwVjjfY5TCWeokgCtHVZB2wiw81uWclu/l6421wuxu6M9IbjdbHH1N+IDntLXw4+eLUlWcKGurtC7w=
X-Received: by 2002:ac8:5e11:0:b0:494:9d34:fca5 with SMTP id
 d75a77b69052e-4a713c6c8afmr27708701cf.13.1749605589163; Tue, 10 Jun 2025
 18:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f46443ac-eb7f-47db-8f4b-a06384e6fde5@web.de> <20250608144542.275836-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqo6uyw6h4.fsf@gitster.g>
In-Reply-To: <xmqqo6uyw6h4.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 11 Jun 2025 07:02:57 +0530
X-Gm-Features: AX0GCFsmiUbqrKYivtQoCIfEMRjqoneMa5xxm90SNfR7FCpQGVSZv24DjUnxgWM
Message-ID: <CA+rGoLdLOYGt8tsWtqWoBCct0Q5HkE_dY1X+MaSoyyfo6mCqFw@mail.gmail.com>
Subject: Re: [PATCH v2] stash: fix incorrect branch name in stash message
To: Junio C Hamano <gitster@pobox.com>
Cc: l.s.r@web.de, git@vger.kernel.org, smacdonald@kaimaging.com, 
	sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"

> > +
>
> Addition of trailing whitespace?
>
> You can avoid such mistakes in the future by enabling our sample
> pre-commit hook, which essentially does
>
>         git diff-index --check --cached $against --
>

Thank you, I needed something like this, I think I'm going to steal
this to other projects too : )

> where $against is HEAD (or an empty tree object while preparing for
> an initial commit).
>
> >       branch_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> >                                            "HEAD", 0, NULL, &flags);
> > -     if (flags & REF_ISSYMREF)
> > -             skip_prefix(branch_ref, "refs/heads/", &branch_name);
> > +
> > +     if (flags & REF_ISSYMREF) {
> > +             if (skip_prefix(branch_ref, "refs/heads/", &branch_name))
> > +                     branch_name = branch_name_buf = xstrdup(branch_name);
> > +     } else
> > +             branch_name = "(no branch)";
>
> Do we need the else clause?  The original did not have it and showed
> the "(no branch)" message without an issue, and I do not see anything
> is changed by what happens inside the other side of this if statement.
> Am I missing something?

No, that's just a random idea, I get the point I will remove that in
the new patch

>
> > @@ -1495,6 +1501,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
> >       strbuf_release(&msg);
> >       strbuf_release(&untracked_files);
> >       free_commit_list(parents);
> > +     free(branch_name_buf);
> >       return ret;
> >  }
>
> Makes sense.
>
> This is a common pattern we use with a variable whose name contains
> "to_free" (e.g., "branch_name_to_free"), but "branch_name_buf" is
> pleanty readable and easy to understand what is going on.
>
> > +test_expect_success 'stash reflog message uses superproject branch, not submodule branch' '
>
> The title looks a bit on the overly-long side.  Would
>
>     stash message records the superproject branch
>
> be sufficient?  The fact that the stash is implemented as reflog
> is invidible and irrelevant at this level, so "reflog message" is
> wasting bytes without adding any useful information.
>
> What we want to make sure is that the message records the current
> branch name, whether the project has any submodules or not, and from
> that point of view,
>
>     stash message records the correct branch name
>
> ought to be good, but not quite, because this test is trying to
> trigger a bug that was present only when there are submodules, so
> not mentioning superproject/submodule at all would not work well.
>
> Would
>
>     submodules does not affect the branch recorded in stash message
>
> work?  That is the best one I can come up with offhand.
>

Works, I will use this as is, I think this sounds good.

> > +     git init sub_project &&
> > +     (
> > +             cd sub_project &&
> > +             echo "Initial content in sub_project" >sub_file.txt &&
> > +             git add sub_file.txt &&
> > +             git commit -q -m "Initial commit in sub_project"
> > +     ) &&
>
> It is easier to debug the test script if you avoid using --quiet too
> much.  Regular "sh ./t3903-stash.sh" will squelch these output
> anyway, and they can be seen when the test script is run with "-v".
>

Ok will remove all the -q tests

> > +     git init main_project &&
> > +     (
> > +             cd main_project &&
> > +             echo "Initial content in main_project" >main_file.txt &&
> > +             git add main_file.txt &&
> > +             git commit -q -m "Initial commit in main_project" &&
> > +
> > +             git -c protocol.file.allow=always submodule add --quiet ../sub_project sub &&
> > +             git commit -q -m "Added submodule sub_project" &&
> > +
> > +             git checkout -q -b feature_main &&
>
>
> > +             cd sub &&
> > +             git checkout -q -b feature_sub &&
> > +             cd .. &&
>
> These three lines can be written more compactly as:
>
>                 git -C sub checkout -b feature_sub &&
>

True.

> > +             git checkout -q -b work_branch &&
> > +             echo "Important work to be stashed" >work_item.txt &&
> > +             git add work_item.txt &&
> > +             git stash push -q -m "custom stash for work_branch" &&
> > +
> > +             git stash list >../actual_stash_list.txt &&
> > +             grep "On work_branch: custom stash for work_branch" ../actual_stash_list.txt
> > +     )
> > +'
> > +
> >  test_done
>
> Thanks.

Will send a patch soon
Thank you again

- Jayatheerth
