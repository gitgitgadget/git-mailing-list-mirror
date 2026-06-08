Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1C35E1DF
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780957899; cv=pass; b=dDaBEEykUA8H19MI/tthYi7TU1wpU+/Sv7zsRYP/jM12SsK7cdxA00FmDv3jyKVU3a7eN565AJl8BWzlkTxpsYP0GULoirgM6XmgNjTT2o+YoOuGrt75V1ylFlqpM2kJDsIJTacMh6NlaAoyoC1i/KTkTXCYwnFiloPIq20wHog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780957899; c=relaxed/simple;
	bh=9+VrH+HLVLjKFXyKEmaCyqVPQNo/D0A5nSnGEf0A1ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKeunto3FwZxvA31Xl6DdAEOes4eULEPLTEBCBuJ3Cc0gYLr526xH3RfdeWyVF4pNAtw+ZyA7ElUr8xgW8pBzSvrfGPbRS0txr9axVchVW4vRgMcd88l06GDJ6nIwPPONirLCezJzTiziiY9qJ0YUP0xdZMk9bd2q5GH9H6ZUDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIbt5bvo; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIbt5bvo"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-396bed274b9so41150181fa.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 15:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780957895; cv=none;
        d=google.com; s=arc-20240605;
        b=J9sGN97urQKto0oeoBRE9uDOBPmBhTpVyk4XbXCT3DP4BGce6UjVjqydhZUSElEIz8
         vVb3gUA3vF/u9gYOiGBBYFgzVyy7mDBZOELIdtnRwsg3AcHDqjQyYLPTKYaJw7Wace6l
         fBrO0fH20OZcelFQE0mV0RjQRyUqzmq2ubHAIVsJOdWFvqnZU943KHVhgwfY6DerELsc
         KYdX/8BZDcaliI1vXoyVfgfExom2c4ojCtpr62WfnZYerccJDMKzVb+yG+d17m0F4DqR
         Ug990kHfXE21QEaGBLmHueFq80OHQZisFQSMifsNQSaphQD2s8OFCIRuihXwhArJY2EA
         64Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BAx5N8+S/YkE6bnvjVhB71aoJLHQz/l4JPaEmo3Gt8g=;
        fh=2GNm5k5kgWB8cPHZ/JEch+O7eLGcEVkhdxzQRfh/7vc=;
        b=aYdLlyUOW3fJ/1fyN0rZfg/XRqOAbKXUEw7ho/foazUyEYlwNTBVv16ELxEvAfPREC
         yJoK7Df3VZ6N1cCY+R3vpgqrP9ZHKyFQ4QwMMXo4cAv3LLmdFC/k9xE4Vu8HMmK7CToJ
         17mQPvyrVQNKW6KaPlj8LNFWZFueQxecva48mkiNntpPICoSIq22klT8nS1mcYYKIsrn
         lGBhsffPkYufO/0LbeWT0v+wkBOh2Mj4i4echyAfkNE71V/buMe03azDl63XonZtQetN
         wzVeOK55u+ViplQr7p+Kjv2cCUniheMavX8GBf0ATOQjoAnuZzb0VOKzTKNRj24SH69L
         14GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780957895; x=1781562695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAx5N8+S/YkE6bnvjVhB71aoJLHQz/l4JPaEmo3Gt8g=;
        b=SIbt5bvonsKQoNPPRBUb2Xs/3pvrbgNvdOKyPQ6EfCGjf254IZ/tJhXh70fNUGo6jV
         766vi3seaXEfI8LfQlxJnXK0DmRtF5C+LNlhfIbTR+W0E/KDmgDH2TYGVv19e6geaPGm
         UpElvalOPledLRi8U7OYV6rsN56x/V4ut6XZzWR1FxG80Hc0mYPuPhTFhGjbVkIjMScu
         7IMuUVfOUUN8/3I3EBZp2XS4vok8m4VTx3gLK/xaU0LmtZ6t2Vc8VtWDSho5o5k9mvqE
         Rn80xiM+JlEWc48636CRdgCGcD8/I2W7rxqw1X4zqAATJjuj69ehcnRNblcIfvG50d2+
         JdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780957895; x=1781562695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BAx5N8+S/YkE6bnvjVhB71aoJLHQz/l4JPaEmo3Gt8g=;
        b=oRS//MBDagF8bBSMmjIHO3I1Yu285nt0O9QpATgj5UiT+T45GVyN15wVLm2ylHpw/9
         I/yOn8hi7zSg1UMO47ixdoDiyOiZP+LtmMM9inLUvT1iKcr6SUhv3tFi2XpquGFxPDdj
         Yynb4ybApJSTjt5vBqjNCa+bA2YaNbXQehzqRZpQErmfsBVZvxMClw9Ms1r9Hx6yykDl
         /TkcH+YHRi29eXp3MgQRQ1xFt+eV15v0bzwx7F2+s1/hKJ6HZZIQKcviUCYOgrp2XkDq
         dTLyErYGMpZ5Hu3NHHfDcIwsVmKz9VuuOzbfdl3sTJ7HhODMB3eiPdxi4NygXMJ61G/D
         SHuw==
X-Gm-Message-State: AOJu0YzHwCJl4F+BePI+medIwfMRqgP3M80mJqMdnToCWMzNGrzoMr4v
	h0nFilEw4nKUJtKQmNvNDEV8C+VR97AgDeAlKiezBd0BkrBhU0cFVtj+EYVf2oibQJaLXwzOTm2
	g3Rm1Klgo1HfRkyC+AU84Kzd0p8fOlW8=
X-Gm-Gg: Acq92OFB4JUyFscQiivP0nPLBdTSmQKZVUu2RtO3awGbapwEAT6MC03za4GmBYHS3DX
	cMPurDMApcemEVW4ssjiXorfN2M/3LmDNi947f/JjGGCZIWJ26v004iZZt260oiZg7wk45nfgeF
	L3KF2Syz8AFf2u4i25kh3vATWFizNSPFTKbnLZ4L/+I029trraAG85kE+jarwJZHssNVo91eFnj
	yz2OgIrwNVg2sQH/pa4slL9KgDGGOIK0m2JMStozDI8kxcLeNLu/l5p7HNzRGf/wNHhu2hfYQ37
	3AsjSHCcU5N3xNPiaDcBbwIf6MvSnbB4cbgoP5V9Ual6bRTc0xBtA1A90p59agiWcc3D8rVZFXr
	cpXAChEJIoLwEdwVzrJD/3vjvKfkJDbs=
X-Received: by 2002:a2e:a813:0:b0:394:5c9a:f31b with SMTP id
 38308e7fff4ca-396d08e4aa3mr49286791fa.17.1780957895294; Mon, 08 Jun 2026
 15:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com>
 <CAOLa=ZS_U+u43SV9ELSEU6AT7rzEQ44BuHPAi1BAHEGQAnPoPw@mail.gmail.com>
In-Reply-To: <CAOLa=ZS_U+u43SV9ELSEU6AT7rzEQ44BuHPAi1BAHEGQAnPoPw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 18:30:58 -0400
X-Gm-Features: AVVi8CeuxHQhvs_JLzR7DZ7SdV2I24GvYzNGW0qmgFj1v_2NTgB52HgZpbaPCt4
Message-ID: <CAJ-ks9me7GjLwvQqJK21jPyYvUJWoV-HAMhPGPsLDDNdNZVzOg@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: reuse --contains traversal results
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 2:18=E2=80=AFPM Karthik Nayak <karthik.188@gmail.com=
> wrote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> > git branch and git for-each-ref call repo_is_descendant_of() for each
> > candidate selected by --contains or --no-contains. Each call starts a
> > new graph walk, so refs with shared history repeatedly traverse the sam=
e
> > commits.
> >
> > ffc4b8012d (tag: speed up --contains calculation, 2011-06-11) introduce=
d
> > the tag traversal that caches positive and negative answers across
> > candidates. ee2bd06b0f (ref-filter: implement '--contains' option,
> > 2015-07-07) preserved the branch and tag implementations when ref-filte=
r
> > learned --contains. 008ed7df930 (tag.c: use the correct algorithm for
> > the '--contains' option, 2015-10-18) noted that they should be unified.
> >
>
> Nicely explained. We should've merged this long ago, so this is a
> worthwhile change.
>
> > Use the memoized traversal for every ref-filter contains check and
> > remove the implementation selector. The cache records answers for one
> > fixed target list, so document that callers must clear it before
> > changing the list.
> >
> > The memoized depth-first walk assumes acyclic ancestry, but replacement
> > refs can create cycles. Track commits while they are on the walk. If a
> > cycle is found, discard partial cache entries and use
> > repo_is_descendant_of() for that candidate.
> >
> > The branch and for-each-ref path passed repo_is_descendant_of() through
> > a Boolean interface. In configurations where it returned -1 for missing
> > ancestry, ref-filter treated the error as "contains". The memoized path
> > instead fails when ancestry cannot be parsed, as git tag already did.
> > During review of the 2018 reachability series, making parse failures
> > fatal was explicitly deferred because that series was intended to
> > preserve behavior. Unifying the implementations now makes all callers
> > fail consistently instead of preserving that accidental Boolean
> > interpretation.
> >
> > The added p1500 case uses up to 8,192 packed refs along one first-paren=
t
> > history. It improves from 0.68 to 0.03 seconds.
> >
> > On a checkout with 62,174 remote-tracking refs, I ran:
> >
> >     hyperfine --warmup 0 --runs 3 \
> >         --command-name parent \
> >         '"$parent" branch -r --contains c78ae85f3ce7e >/dev/null' \
> >         --command-name this-commit \
> >         '"$this" branch -r --contains c78ae85f3ce7e >/dev/null'
> >
> > The results were:
> >
> >              parent       this commit
> >   elapsed    104.365 s     467.7 ms
> >   user        93.702 s     220.2 ms
> >   system       0.723 s     182.7 ms
> >
> > The wall-time standard deviations were 11.356 seconds and 133.8
> > milliseconds, respectively, for a 223x speedup. Both commands produced
> > output with SHA-256
> > 2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.
> >
> > Both revisions were rebuilt with the default -O2 flags using Apple clan=
g
> > 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6) with a
> > 16-core Apple M4 Max (12 performance and four efficiency cores) and 128
> > GB RAM.
> >
> > Link: https://lore.kernel.org/git/1445163904-24611-1-git-send-email-Kar=
thik.188@gmail.com/
> > Link: https://lore.kernel.org/git/20180723204112.233274-1-jonathantanmy=
@google.com/
> > Link: https://lore.kernel.org/git/24424e55-7fa8-d05b-bc39-e14b4d5abcb6@=
gmail.com/
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  builtin/tag.c                  |  1 -
> >  commit-reach.c                 | 45 +++++++++++++++++++++++++++++++---=
--------
> >  commit-reach.h                 | 15 ++++++++++----
> >  ref-filter.c                   |  6 ++++--
> >  ref-filter.h                   |  7 +++----
> >  t/helper/test-reach.c          | 10 ++--------
> >  t/perf/p1500-graph-walks.sh    | 24 +++++++++++++++++++++-
> >  t/t6301-for-each-ref-errors.sh | 18 +++++++++++++++++
> >  t/t6302-for-each-ref-filter.sh | 21 ++++++++++++++++++++
> >  t/t6600-test-reach.sh          |  6 ++----
> >  10 files changed, 117 insertions(+), 36 deletions(-)
> >
> > diff --git a/builtin/tag.c b/builtin/tag.c
> > index d51c2e3349..9f34d948d4 100644
> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > @@ -71,7 +71,6 @@ static int list_tags(struct ref_filter *filter, struc=
t ref_sorting *sorting,
> >
> >       if (verify_ref_format(format))
> >               die(_("unable to parse format string"));
> > -     filter->with_commit_tag_algo =3D 1;
>
> We were selectively using the algo for `git tag`, like mentioned I guess
> we'll entirely remove `with_commit_tag_algo` below somewhere
>
> >       filter_and_format_refs(filter, FILTER_REFS_TAGS, sorting, format)=
;
> >
> >       free(to_free);
> > diff --git a/commit-reach.c b/commit-reach.c
> > index 9b3ea46d6f..6e599a3670 100644
> > --- a/commit-reach.c
> > +++ b/commit-reach.c
> > @@ -6,7 +6,6 @@
> >  #include "decorate.h"
> >  #include "hex.h"
> >  #include "prio-queue.h"
> > -#include "ref-filter.h"
> >  #include "revision.h"
> >  #include "tag.h"
> >  #include "commit-reach.h"
> > @@ -708,7 +707,8 @@ static int in_commit_list(const struct commit_list =
*want, struct commit *c)
> >
> >  /*
> >   * Test whether the candidate is contained in the list.
> > - * Do not recurse to find out, though, but return -1 if inconclusive.
> > + * Do not recurse to find out, though, but return CONTAINS_UNKNOWN if
> > + * inconclusive.
>
> Okay so the code does return CONTAINS_UNKNOWN which is an enum beginning
> at 0, so this makes sense.
>
> >   */
> >  static enum contains_result contains_test(struct commit *candidate,
> >                                         const struct commit_list *want,
> > @@ -743,9 +743,9 @@ static void push_to_contains_stack(struct commit *c=
andidate, struct contains_sta
> >       contains_stack->contains_stack[contains_stack->nr++].parents =3D =
candidate->parents;
> >  }
> >
> > -static enum contains_result contains_tag_algo(struct commit *candidate=
,
> > -                                           const struct commit_list *w=
ant,
> > -                                           struct contains_cache *cach=
e)
> > +static enum contains_result contains_algo(struct commit *candidate,
> > +                                       struct commit_list *want,
> > +                                       struct contains_cache *cache)
> >  {
> >       struct contains_stack contains_stack =3D { 0, 0, NULL };
> >       enum contains_result result;
> > @@ -765,6 +765,7 @@ static enum contains_result contains_tag_algo(struc=
t commit *candidate,
> >       if (result !=3D CONTAINS_UNKNOWN)
> >               return result;
> >
> > +     *contains_cache_at(cache, candidate) =3D CONTAINS_IN_PROGRESS;
> >       push_to_contains_stack(candidate, &contains_stack);
> >       while (contains_stack.nr) {
> >               struct contains_stack_entry *entry =3D &contains_stack.co=
ntains_stack[contains_stack.nr - 1];
> > @@ -776,8 +777,8 @@ static enum contains_result contains_tag_algo(struc=
t commit *candidate,
> >                       contains_stack.nr--;
> >               }
> >               /*
> > -              * If we just popped the stack, parents->item has been ma=
rked,
> > -              * therefore contains_test will return a meaningful yes/n=
o.
> > +              * A parent may have just been popped and marked, or may =
still
> > +              * be active when replacement refs create a cycle.
> >                */
> >               else switch (contains_test(parents->item, want, cache, cu=
toff)) {
> >               case CONTAINS_YES:
> > @@ -787,21 +788,41 @@ static enum contains_result contains_tag_algo(str=
uct commit *candidate,
> >               case CONTAINS_NO:
> >                       entry->parents =3D parents->next;
> >                       break;
> > +             case CONTAINS_IN_PROGRESS:
> > +                     /*
> > +                      * Partial negative answers are not safe across a=
 cycle.
> > +                      * Discard them and use the cycle-safe reachabili=
ty walk.
> > +                      */
> > +                     goto cycle;
> >
>
> If I understand this correctly, we now use CONTAINS_IN_PROGRESS to
> showcase a commit for which we still don't have a result. Since any
> commit with UNKNOWN will start a recursive search through its parents.
>
> So with this if we encounter a CONTAINS_IN_PROGRESS while recursion,
> this would indicate that we hit a cyclic graph and so go to the fallback
> of using repo_is_descendant_of(). So this avoids an infinite recursion
> in such instances. Makes sense.
>
> >               case CONTAINS_UNKNOWN:
> > +                     *contains_cache_at(cache, parents->item) =3D
> > +                             CONTAINS_IN_PROGRESS;
> >                       push_to_contains_stack(parents->item, &contains_s=
tack);
> >                       break;
> >               }
> >       }
> >       free(contains_stack.contains_stack);
> >       return contains_test(candidate, want, cache, cutoff);
> > +
> > +cycle:
> > +     free(contains_stack.contains_stack);
> > +     clear_contains_cache(cache);
> > +     init_contains_cache(cache);
> > +
> > +     result =3D repo_is_descendant_of(the_repository, candidate, want)=
;
> > +     if (result < 0)
> > +             exit(128);
> > +     *contains_cache_at(cache, candidate) =3D
> > +             result ? CONTAINS_YES : CONTAINS_NO;
> > +     return result ? CONTAINS_YES : CONTAINS_NO;
> >  }
> >
> > -int commit_contains(struct ref_filter *filter, struct commit *commit,
> > -                 struct commit_list *list, struct contains_cache *cach=
e)
> > +int commit_contains(struct commit *commit, struct commit_list *list,
> > +                 struct contains_cache *cache)
> >  {
> > -     if (filter->with_commit_tag_algo)
> > -             return contains_tag_algo(commit, list, cache) =3D=3D CONT=
AINS_YES;
> > -     return repo_is_descendant_of(the_repository, commit, list);
> > +     if (!list)
> > +             return 1;
> > +     return contains_algo(commit, list, cache) =3D=3D CONTAINS_YES;
> >  }
> >
> >  int can_all_from_reach_with_flag(struct object_array *from,
> > diff --git a/commit-reach.h b/commit-reach.h
> > index 3f3a563d8a..144dc56275 100644
> > --- a/commit-reach.h
> > +++ b/commit-reach.h
> > @@ -5,7 +5,6 @@
> >  #include "commit-slab.h"
> >
> >  struct commit_list;
> > -struct ref_filter;
> >  struct object_id;
> >  struct object_array;
> >
> > @@ -73,13 +72,21 @@ int ref_newer(const struct object_id *new_oid, cons=
t struct object_id *old_oid);
> >  enum contains_result {
> >       CONTAINS_UNKNOWN =3D 0,
> >       CONTAINS_NO,
> > -     CONTAINS_YES
> > +     CONTAINS_YES,
> > +     CONTAINS_IN_PROGRESS
> >  };
> >
> >  define_commit_slab(contains_cache, enum contains_result);
> >
> > -int commit_contains(struct ref_filter *filter, struct commit *commit,
> > -                 struct commit_list *list, struct contains_cache *cach=
e);
> > +/*
> > + * Return whether "commit" is a descendant of any commit in "list". An=
 empty
> > + * list matches.
> > + *
> > + * "cache" records answers for one fixed "list". Clear it before chang=
ing the
> > + * list.
> > + */
> > +int commit_contains(struct commit *commit, struct commit_list *list,
> > +                 struct contains_cache *cache);
> >
> >  /*
> >   * Determine if every commit in 'from' can reach at least one commit
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 1da4c0e60d..7788147959 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -2991,11 +2991,13 @@ static struct ref_array_item *apply_ref_filter(=
const struct reference *ref,
> >                       return NULL;
> >               /* We perform the filtering for the '--contains' option..=
. */
> >               if (filter->with_commit &&
> > -                 !commit_contains(filter, commit, filter->with_commit,=
 &filter->internal.contains_cache))
> > +                 !commit_contains(commit, filter->with_commit,
> > +                                  &filter->internal.contains_cache))
> >                       return NULL;
> >               /* ...or for the `--no-contains' option */
> >               if (filter->no_commit &&
> > -                 commit_contains(filter, commit, filter->no_commit, &f=
ilter->internal.no_contains_cache))
> > +                 commit_contains(commit, filter->no_commit,
> > +                                 &filter->internal.no_contains_cache))
> >                       return NULL;
> >       }
> >
> > diff --git a/ref-filter.h b/ref-filter.h
> > index 120221b47f..9e14afca9c 100644
> > --- a/ref-filter.h
> > +++ b/ref-filter.h
> > @@ -73,10 +73,9 @@ struct ref_filter {
> >       struct commit_list *reachable_from;
> >       struct commit_list *unreachable_from;
> >
> > -     unsigned int with_commit_tag_algo : 1,
> > -             match_as_path : 1,
> > -             ignore_case : 1,
> > -             detached : 1;
> > +     unsigned int match_as_path : 1,
> > +                  ignore_case : 1,
> > +                  detached : 1;
> >       unsigned int kind,
> >               lines;
> >       int abbrev,
>
> Nit: With the changes above. I do wish it was split into two commits.
> 1. Fix cyclic recursions in the algo.
> 2. Use the algo for all filter types.

Makes sense. I split v2 accordingly. The first patch now fixes the
existing git tag --contains traversal and tests that path directly.
The second patch then uses the traversal for the other ref-filter
callers.

>
> > diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
> > index 5d86a96c17..82235f713e 100644
> > --- a/t/helper/test-reach.c
> > +++ b/t/helper/test-reach.c
> > @@ -6,7 +6,6 @@
> >  #include "gettext.h"
> >  #include "hex.h"
> >  #include "object-name.h"
> > -#include "ref-filter.h"
> >  #include "setup.h"
> >  #include "string-list.h"
> >  #include "tag.h"
> > @@ -138,16 +137,11 @@ int cmd__reach(int ac, const char **av)
> >
> >               printf("%s(X,_,_,0,0):%d\n", av[1], can_all_from_reach_wi=
th_flag(&X_obj, 2, 4, 0, 0));
> >       } else if (!strcmp(av[1], "commit_contains")) {
> > -             struct ref_filter filter =3D REF_FILTER_INIT;
> >               struct contains_cache cache;
> >               init_contains_cache(&cache);
> >
> > -             if (ac > 2 && !strcmp(av[2], "--tag"))
> > -                     filter.with_commit_tag_algo =3D 1;
> > -             else
> > -                     filter.with_commit_tag_algo =3D 0;
> > -
> > -             printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter=
, A, X, &cache));
> > +             printf("%s(_,A,X,_):%d\n", av[1],
> > +                    commit_contains(A, X, &cache));
> >               clear_contains_cache(&cache);
> >       } else if (!strcmp(av[1], "get_reachable_subset")) {
> >               const int reachable_flag =3D 1;
>
> Makes sense.
>
> > diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
> > index 5b23ce5db9..ac68fdbacd 100755
> > --- a/t/perf/p1500-graph-walks.sh
> > +++ b/t/perf/p1500-graph-walks.sh
> > @@ -5,6 +5,8 @@ test_description=3D'Commit walk performance tests'
> >
> >  test_perf_large_repo
> >
> > +contains_ref_limit=3D8192
> > +
> >  test_expect_success 'setup' '
> >       git for-each-ref --format=3D"%(refname)" "refs/heads/*" "refs/tag=
s/*" >allrefs &&
> >       sort -r allrefs | head -n 50 >refs &&
> > @@ -32,10 +34,25 @@ test_expect_success 'setup' '
> >               echo "X:$line" >>test-tool-tags || return 1
> >       done &&
> >
> > +     git rev-list --first-parent --max-count=3D$contains_ref_limit HEA=
D >contains-commits &&
> > +     contains_ref_count=3D$(wc -l <contains-commits) &&
> > +     test "$contains_ref_count" -gt 0 &&
> > +     contains_base=3D$(tail -n 1 contains-commits) &&
> > +     export contains_base &&
> > +     awk "{
> > +             printf \"update refs/contains-perf/%04d %s\\n\", NR, \$1
> > +     }" contains-commits |
> > +             git update-ref --stdin &&
> > +     git pack-refs --include "refs/contains-perf/*" &&
> > +
> >       commit=3D$(git commit-tree $(git rev-parse HEAD^{tree})) &&
> >       git update-ref refs/heads/disjoint-base $commit &&
> >
> > -     git commit-graph write --reachable
> > +     git commit-graph write --reachable &&
> > +
> > +     git for-each-ref --contains=3D"$contains_base" \
> > +             refs/contains-perf/ >actual &&
> > +     test_line_count =3D $contains_ref_count actual
>
> Shouldn't this be a separate test and not a part of the setup?
>
> >  '
> >
> >  test_perf 'ahead-behind counts: git for-each-ref' '
> > @@ -62,6 +79,11 @@ test_perf 'contains: git tag --merged' '
> >       xargs git tag --merged=3DHEAD <tags
> >  '
> >
> > +test_perf 'contains: git for-each-ref --contains' '
> > +     git for-each-ref --contains=3D"$contains_base" \
> > +             refs/contains-perf/ >/dev/null
> > +'
> > +
>
> Ah! we also have this, so perhaps moving the `test_line_count` here and
> dropping it above would be better.

Makes sense! Done in v2.

>
> >  test_perf 'is-base check: test-tool reach (refs)' '
> >       test-tool reach get_branch_base_for_tip <test-tool-refs
> >  '
> > diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-erro=
rs.sh
> > index e06feb06e9..169cc70c23 100755
> > --- a/t/t6301-for-each-ref-errors.sh
> > +++ b/t/t6301-for-each-ref-errors.sh
> > @@ -52,6 +52,24 @@ test_expect_success 'Missing objects are reported co=
rrectly' '
> >       test_must_be_empty brief-err
> >  '
> >
> > +test_expect_success 'missing ancestors are reported by contains filter=
s' '
> > +     test_when_finished "git update-ref -d refs/heads/missing-parent" =
&&
> > +     {
> > +             echo "tree $(git rev-parse HEAD^{tree})" &&
> > +             echo "parent $MISSING" &&
> > +             git cat-file commit HEAD |
> > +                     sed -n -e "/^author /p" -e "/^committer /p" &&
> > +             echo &&
> > +             echo "missing parent"
> > +     } > commit &&
> > +     broken=3D$(git hash-object -t commit -w commit) &&
> > +     git update-ref refs/heads/missing-parent "$broken" &&
> > +     test_must_fail git for-each-ref --contains=3DHEAD \
> > +             refs/heads/missing-parent >out 2>err &&
> > +     test_must_be_empty out &&
> > +     test_grep "unable to parse commit $MISSING" err
> > +'
> > +
> >  test_expect_success 'ahead-behind requires an argument' '
> >       test_must_fail git for-each-ref \
> >               --format=3D"%(ahead-behind)" 2>err &&
> > diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filt=
er.sh
> > index 7f060d97bf..423505d1fb 100755
> > --- a/t/t6302-for-each-ref-filter.sh
> > +++ b/t/t6302-for-each-ref-filter.sh
> > @@ -177,6 +177,27 @@ test_expect_success 'filtering with --contains and=
 --no-contains' '
> >       test_cmp expect actual
> >  '
> >
> > +test_expect_success 'contains handles cyclic replacement histories' '
> > +     one=3D$(git rev-parse one) &&
> > +     three=3D$(git rev-parse three) &&
> > +     test_when_finished "
> > +             git replace -d $one
> > +             git replace -d $three
> > +             git tag -d cycle-a cycle-b
> > +     " &&
> > +     git tag cycle-a "$one" &&
> > +     git tag cycle-b "$three" &&
> > +     git replace --graft "$one" "$three" two &&
> > +     git replace --graft "$three" "$one" &&
> > +     cat >expect <<-\EOF &&
> > +     refs/tags/cycle-a
> > +     refs/tags/cycle-b
> > +     EOF
> > +     git for-each-ref --format=3D"%(refname)" --contains=3Dtwo \
> > +             "refs/tags/cycle-*" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> >  test_expect_success '%(color) must fail' '
> >       test_must_fail git for-each-ref --format=3D"%(color)%(refname)"
> >  '
> > diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> > index b5b314e570..1ecc2571c2 100755
> > --- a/t/t6600-test-reach.sh
> > +++ b/t/t6600-test-reach.sh
> > @@ -286,8 +286,7 @@ test_expect_success 'commit_contains:hit' '
> >       X:commit-9-3
> >       EOF
> >       echo "commit_contains(_,A,X,_):1" >expect &&
> > -     test_all_modes commit_contains &&
> > -     test_all_modes commit_contains --tag
> > +     test_all_modes commit_contains
> >  '
> >
> >  test_expect_success 'commit_contains:miss' '
> > @@ -303,8 +302,7 @@ test_expect_success 'commit_contains:miss' '
> >       X:commit-9-3
> >       EOF
> >       echo "commit_contains(_,A,X,_):0" >expect &&
> > -     test_all_modes commit_contains &&
> > -     test_all_modes commit_contains --tag
> > +     test_all_modes commit_contains
> >  '
> >
> >  test_expect_success 'rev-list: basic topo-order' '
> >
> > ---
> > base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
> > change-id: 20260607-ref-filter-memoized-contains-7cb6b3bccad1
> >
> > Best regards,
> > --
> > Tamir Duberstein <tamird@gmail.com>
>
> Overall the patch looks great. The perf improvements are also very
> welcome. Some small nits from me.

Thanks a lot for the review!
