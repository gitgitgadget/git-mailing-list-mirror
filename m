Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9C1D1E89
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311444; cv=none; b=VHGvbBJtMbd3GE3snInphBojwvCgihgbFaRhQNWiYj5pOLW9edp9erBF7+hiKAyS+dWogt9umuvVP63uWjFHYie+LhI27DnlgxvF2H3utboyx8ItyQ4kaPWx9F2tJeWGWjvrX8pwthJPImBet/t6i1lFJEKtu9BKHhFYF8AtwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311444; c=relaxed/simple;
	bh=BY8Ph1F9yu+GaZbx+MwJwj9V0clnXyT2YJJnPWUQ/zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tY3jzjpVwwegqm+c2ae9Ol71nD6wYNHBw9m7d04kX2L8iyOTS325U66SohWPuTPuSquVhBN0NxnvTwhLf2ZUtQC9Z28f2bs5vFPRXrFhMx9/Sz88rpfxGxO/ZChfhxL4RswlEFjlW+KxNpEkyBoDJOvbkVaCLpjA8Ccgj0ZqDYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckfzVc7K; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckfzVc7K"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso2730795a12.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728311442; x=1728916242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDj8Z314aDMl876usGB5+YAk8P9pyt4g3tHdqFfT0Xk=;
        b=ckfzVc7Kfi272DeSMZ8hJk6LsvmdPcN8NzqG1r1aWVQVU6CLvql8Hyj0sfb9ZQ2XpW
         2SAyLCtHbLCzkCGC2QzclUnimRzZ8XJYu5P+jwFa16V2Pt3vHRYXdb9zvHUKXNdjRynr
         oRBM8byuB/xf6dNcgrZOjjYGyLHmptMOUCwdFgkxO0AQa00Sw2bvyZzdQoIvK1jKHE2O
         YgZQi7sSoe7pB0d2gCNnCQeQirvrM40V37hwn8tlFcYBnJEe7rDSa0MoFmyWP5xC8qHw
         7QmL3ka1P+g+bNPvXEKkeQnlBGZA3Io55pikCr0Gt7uHj9cj0g1LPgHV8tPxcu+w+pfK
         SNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311442; x=1728916242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDj8Z314aDMl876usGB5+YAk8P9pyt4g3tHdqFfT0Xk=;
        b=qkZqDbcsjE2yFwGgVqbTyODQ9JlTKHWIda7qLGf+SP70uFNQxmZY4YueU+uIrQNe1w
         9YWc8RcJE+lWo7JbzkXMQfyT8u3062/Kv3eLglNRMa8Lk2DLGwqghw6CjNbiTiEq1ZK/
         DRgBghZW0sB5z2fXKcUxfh/t9Zgvl5pEjIR1tVFWx1I9aMuPSdZtrrCYonX5AGdVRuWU
         OAnXKKdE0+UYYTMM4h1g/jpDNKkgniG/dx1QBl2b6ylbqsHwZpSyDCxcArX+qYLl6rD7
         2/oyNFTmMWiXDyeP+KYAOiXU7l71FMiQ9BN7g7h/Lx/iL0MpJLMRHuZCQ6CKnxUbo0ij
         kwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkDxbg8p6NeEnPNbR9Qdne9CK9iN0ytovnz758SYsvn2Bn16xkbOj0NSnRdE042CA6Kzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF+Yd5a1Sq1imoAte13g56Gc6AoSQo4ttxJ3Kvvlv/hLhrXQ2n
	j6KXTzdaQg0vj2I5LgY2NdQ6gN5bAzLB5gARBrmGg2e1Fc/7fRMp6QSkJ7YTj/uSx0q8NN7J+72
	AAjaRKb8HjB2tr2nUgVnEJGIyzxmLtnzty4I=
X-Google-Smtp-Source: AGHT+IHTxSr2Hrp60McT9wWJw1wx+PUWqNzIu79R8Z6mdlmcAXX4Pde+5U9lmuVnCUIrEhPLMcck4fyt9ReWQa/t0Jw=
X-Received: by 2002:a17:90b:294:b0:2c8:e888:26a2 with SMTP id
 98e67ed59e1d1-2e1e6224842mr15275882a91.13.1728311442184; Mon, 07 Oct 2024
 07:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1782.v2.git.1726409329993.gitgitgadget@gmail.com>
 <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com> <xmqqfrpqxduu.fsf@gitster.g>
In-Reply-To: <xmqqfrpqxduu.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Mon, 7 Oct 2024 20:00:05 +0530
Message-ID: <CAG=Um+0Jd2QYrtRNMaCmAiBguJUnHszMF_poY-cA1wKC1krJOA@mail.gmail.com>
Subject: Re: [PATCH v3] remote: introduce config to set prefetch refs
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, "Derrick Stolee [ ]" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good. Submitted a patch at:
https://lore.kernel.org/git/pull.1782.v4.git.1728073292874.gitgitgadget@gma=
il.com/

Which seems to be detached from this thread now =E2=80=94 perhaps because I
re-wrote the commit message.
Or perhaps I'm reading the threads wrong. Apologies for the break.

On Tue, Sep 24, 2024 at 2:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Shubham Kanodia <shubham.kanodia10@gmail.com>
> >
> > This commit introduces a new configuration option, ...
>
> The usual way to compose a log message of this project is to
>
>  - Give an observation on how the current system work in the present
>    tense (so no need to say "Currently X is Y", just "X is Y"), and
>    discuss what you perceive as a problem in it.
>
>  - Propose a solution (optional---often, problem description
>    trivially leads to an obvious solution in reader's minds).
>
>  - Give commands to the codebase to "become like so".
>
> in this order.
>
> To those who have been intimately following the discussion, it often
> is understandable without some of the above, but we are not writing
> for those who review the patches.  We are primarily writing for future
> readers of "git log" who are not aware of the review discussion we
> have on list, so we should give something to prepare them by setting
> the stage and stating the objective first, before going into how the
> patch solved it.
>
> > diff --git a/Documentation/config/remote.txt b/Documentation/config/rem=
ote.txt
> > index 8efc53e836d..b04ee0c4c22 100644
> > --- a/Documentation/config/remote.txt
> > +++ b/Documentation/config/remote.txt
> > @@ -33,6 +33,11 @@ remote.<name>.fetch::
> >       The default set of "refspec" for linkgit:git-fetch[1]. See
> >       linkgit:git-fetch[1].
> >
> > +remote.<name>.prefetchref::
> > +    Specify the refs to be prefetched when fetching from this remote.
> > +    The value is a space-separated list of ref patterns (e.g., "refs/h=
eads/master !refs/heads/develop*").
> > +    This can be used to optimize fetch operations by specifying exactl=
y which refs should be prefetched.
>
> Overly long lines.
>
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index b2b5aee5bf2..16c8a31c2e1 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -38,6 +38,7 @@
> >  #include "trace.h"
> >  #include "trace2.h"
> >  #include "bundle-uri.h"
> > +#include "wildmatch.h"
>
> The match done by the wildmatch function is a way too loose to be
> used in the context of parsing and matching the src half of an
> refspec_item (e.g. a globbing refspec element can have at most one
> asterisk in it, but wildmatch does not have any sanity check to
> ensure it).  The refspec logic to accept a fetch refspec
> "refs/heads/*:refs/remotes/origin/*" and rewrite a ref the remote
> side advertised as refs/heads/foo into refs/remotes/origin/foo, the
> remote-tracking ref on the local side, is in
> remote.c:match_name_with_pattern(), and it does not use wildmatch.
>
> > +static int matches_prefetch_refs(const char *refname, const struct str=
ing_list *prefetch_refs)
> > +{
> > +     int i;
> > +     int has_positive =3D 0;
> > +     int matched_positive =3D 0;
> > +     int matched_negative =3D 0;
> > +
> > +     for (i =3D 0; i < prefetch_refs->nr; i++) {
>
> Just FYI, in modern Git codebase, loop control variable 'i' can be
> declared in the initialization part of the for() statement, i.e.
>
>     for (int i =3D 0; i < ...) {
>
> which might make it easier to see that there are three variables of
> importance to determine the outcome of the computation (and 'i' is
> merely a loop counter).
>
> > +             const char *pattern =3D prefetch_refs->items[i].string;
> > +             int is_negative =3D (*pattern =3D=3D '!');
> > +
> > +             if (is_negative)
> > +                     pattern++;
> > +             else
> > +                     has_positive =3D 1;
> > +
> > +             if (wildmatch(pattern, refname, 0) =3D=3D 0) {
> > +                     if (is_negative)
> > +                             matched_negative =3D 1;
> > +                     else
> > +                             matched_positive =3D 1;
> > +             }
> > +     }
>
> I suspect that the function can be exposed to external callers as-is,
> possibly after renaming it to make it clear that the helper function
> is about refspec.  Then you can call it from the code below in stead
> of wildmatch(), by passing the pattern as "key", and the refname as
> "name", with NULL for both "value" and "result", I think.
>
> > +
> > +     if (!has_positive)
> > +             return !matched_negative;
> > +
> > +     return matched_positive && !matched_negative;
> > +}
>
> And the implementation of the logic looks correct.  If the pattern
> says "!A !B !C" (I don't want any of these), we only care that none
> of these negative patterns trigger, but if the pattern has even one
> positive one "X Y !A !B !C" (it must match X or Y, but it must not
> match any of the A B C), we also make sure it matched at least one
> positive pattern.
>
> > +static void ref_remove(struct ref **head, struct ref *to_remove)
> > +{
> > +     struct ref **pp, *p;
> > +
> > +     for (pp =3D head; (p =3D *pp) !=3D NULL; pp =3D &p->next) {
> > +             if (p =3D=3D to_remove) {
> > +                     *pp =3D p->next;
> > +                     return;
> > +             }
> > +     }
> > +}
>
> We remote from a linked list of "struct ref" one such element
> to_remove.  OK.
>
> > @@ -610,6 +655,22 @@ static struct ref *get_ref_map(struct remote *remo=
te,
> >       else
> >               ref_map =3D apply_negative_refspecs(ref_map, &remote->fet=
ch);
> >
> > +     /**
> > +      * Filter out advertised refs that we don't want to fetch during
> > +      * prefetch if a prefetchref config is set
> > +      */
> > +     if (prefetch && remote->prefetch_refs.nr) {
> > +             struct ref *ref, *next;
> > +             for (ref =3D ref_map; ref; ref =3D next) {
> > +                     next =3D ref->next;
> > +
> > +                     if (!matches_prefetch_refs(ref->name, &remote->pr=
efetch_refs)) {
> > +                                     ref_remove(&ref_map, ref);
> > +                                     free_one_ref(ref);
>
> It is curious why such an overly deep indentation is used only in
> this if() statement.
>
> It is good that you made sure we do not leak the ref that we
> removed, but it looks verly inefficient to repeatedly call
> ref_remove (the function becomes more inefficient as the loop
> progresses as it is more costly to remove later elements on a
> linearly linked list).
>
> Wouldn't it be more efficient to iterate over the original list, sift
> each element into "surviving" and "discarded" bin as we go?  Something
> along the lines of ...
>
>         struct ref *new_list =3D NULL, **tail =3D &new_list;
>
>         while (ref_map) {
>                 struct ref *ref =3D ref_map;
>
>                 ref_map =3D ref_map->next;
>                 ref->next =3D NULL;
>
>                 if (matches(...)) {
>                         *tail =3D ref;
>                         tail =3D &ref->next;
>                 } else {
>                         free_one_ref(ref);
>                 }
>         }
>         ref_map =3D new_list;
>
> ..., which I imitated code structure of ref_remove_duplicates().
>
> >       ref_map =3D ref_remove_duplicates(ref_map);
>
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > index abae7a97546..054f1f06f95 100755
> > --- a/t/t7900-maintenance.sh
> > +++ b/t/t7900-maintenance.sh
>
> Avoid overly long lines in the test script, too.
>
> In any case, I very much agree with you that get_ref_map().is the
> best place to add this logic to.  Looking much better.
>
> Thanks.
