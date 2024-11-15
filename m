Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EBEA2D
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731640540; cv=none; b=FnEENhZigiw+Hb2KVtVYoit0RtgJM6cOIkOS466/65ugiXxHVl3EhU6Fez/dgJD8Nt7iLL3kCYJJ0xh/6LUzc/u9ctHfmwtn4GKtX68p7AHKjm3+G4BZYMVtnC7qUuWcsTlWkZq41VjcUH7XQK4dH+0mKPq+3l6vUsnF/T7weOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731640540; c=relaxed/simple;
	bh=deAhXpXxhxvQ2uglfSKZvwpu3CClkMijk7ZLh9CgQkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSav+paGxBI1p69KxccEWWbEZ0FQa71LDig+OVJI0yEnavzLbarM4Lrxk4LSMjtbzhrZ1+HWfj41YwMlUjVy0srKnLhgVEsHM+oC4A5F1heouZR1ffE2AZxFyn0fXouRtBlmftXO1FziYqpn2dcV0zpBuPVfa0hm+N8otaY2mmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2Oj00Sw; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2Oj00Sw"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a74522848cso2761075ab.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 19:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731640538; x=1732245338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThYwucotGvd463qCtVDp07O29xec/Ve5FpznhaUn3CU=;
        b=V2Oj00SwOb/ARPeiWsWI1y8bVunC0vaes148SiwyUJEAYJV42/86HxHXvVaUpmCXiu
         RVqo/q0OANGOxuBC6fhg+4nUlfk82DGjrFdLr/IQl8J30RNsRsgSVgxHr6kMrpRk+4kZ
         jwRUamZ/69k5fOquln1Inr4uXLnCP0mILVC5iAOt4Yn0I7sVbzpsLJIwM8F0BZVw9TAJ
         MWdtmr9b52BOQ4xhz24OTOkUcH6hMPai8GBJ1tzoczja+Xl+3LxNtfnstKVC7HPZQQv1
         lKVgpEAASouBl20Qh2b873+soac7GxMT0BqtRAPF8aBTUaRnhEZ7xUv8ioFbWEp4CRUZ
         gC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731640538; x=1732245338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThYwucotGvd463qCtVDp07O29xec/Ve5FpznhaUn3CU=;
        b=sB09OtoF/bLaEU6bdnXmRVelUny590ATfYAYva3bxjcNEg7wJFBU5RHULdRrLKqcpV
         /B88adqK2u3xKPJ6qDh+jLuk3W6hQ8S1Gc2K7M3vZfx+J0khVYkCUo3dzhDYhSk2ofTS
         DQIb4O3fv1pHawKtREcrpou8DRg/b3IykJEK1kCmoRGuPJwdQ3MBP4OEdNHpHL6HRKxE
         nzsT+3q2NVB1JuqJDNhUQfBbykK8y83obh5IBpq++TH7DlehrfyMzZP2f8dTWq7YtDMR
         9qaZ0ZpcBVuRXW8XWpA4JYi8dVre1SVZsAVymqHDmj2fE83qX0pRp9d8SfUeO9n5RVMY
         RdMA==
X-Forwarded-Encrypted: i=1; AJvYcCXz0IMXaCprOu+xSQAumuFTpFACAo/TuGwO9Bg2THcS9jsPi3iZjXb0ZkxkJpaIReuuh2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSfBbJoTi7rVyXyB+wUWpgSuG5S0eLgY68V/MXf01aI2DvONqM
	iC9S/o0MvHQpRWJFGlJ/BTLOpIaaQQG1a88kWGT1egMtS/oUPjHiIPvFqzlE/+vdCTpLifPDbAz
	nyTmiE7189JUQybJ3K5yTBp35RfNdhz9x
X-Google-Smtp-Source: AGHT+IFgdaM4L38J4sKwE1PF5UblVDrn5PXqAywCHnVgqN79Q+o2YhEDoy4CE4UV3tFhhWcQrGXRO/r4FJiSyPdAN/0=
X-Received: by 2002:a05:6602:14c8:b0:83a:c0ba:73c6 with SMTP id
 ca18e2360f4ac-83e6c31965emr139758939f.11.1731640537887; Thu, 14 Nov 2024
 19:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1824.git.1731610074707.gitgitgadget@gmail.com> <xmqqzfm149sv.fsf@gitster.g>
In-Reply-To: <xmqqzfm149sv.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 14 Nov 2024 19:15:26 -0800
Message-ID: <CABPp-BE2651h6MjPPOvmvgQAp_RrcRW3wuf4_N=DoX3EvJ-muQ@mail.gmail.com>
Subject: Re: [PATCH] fast-import: avoid making replace refs point to themselves
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 4:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Most git commands that you try to run in such a repository with a
> > self-pointing replace object will result in an error:
> >
> >     $ git log
> >     fatal: replace depth too high for object fb92ebc654641b310e7d0360d0=
a5a49316fd7264
>
> After reading up to this point, with "Most git commands", I was
> afraid that you were going to say "... but I found this command that
> fails to stop gracefully, and instead infinitely spin".
>
> If that is not a case, then I am happy ;-) but in that case probably
> "Most" -> "All" is warranted.

Some git commands are not bothered by the existence of the problematic
replace ref; e.g.:

$ git show-ref
64026eaa60e0208a00946cdd3cb41b059c6675bd refs/heads/main
fb92ebc654641b310e7d0360d0a5a49316fd7264
refs/replace/fb92ebc654641b310e7d0360d0a5a49316fd7264
fb92ebc654641b310e7d0360d0a5a49316fd7264 refs/tags/msg
14f901a95ebae912feb4805f40ef68f15b0192c2 refs/tags/test

So, it's not "all" git commands.  Maybe I should rephrase as:

"""
Some git commands will ignore such replace refs, but many will fail
with an error:

$ git log
fatal: replace depth too high for object
fb92ebc654641b310e7d0360d0a5a49316fd7264
"""

?

> > Avoid such problems by deleting replace refs that will simply end up
> > pointing to themselves at the end of our writing.  Warn the users when
> > we do so, unless they specify --quiet.
>
> This may need a bit of rephrasing.
>
> Even when they specify "--quiet", you'd refrain from creating a
> self-referencing replace entry, which makes sense, but it was not
> clear with only the above description.  I had to read the patch text
> to find it out.

Would reordering the two phrases of the last sentence do it?

"""
Avoid such problems by deleting replace refs that will simply end up
pointing to themselves at the end of our writing.  Unless users specify --q=
uiet,
warn the users when we do so.
"""

> Is it reasonable to expect that a self referencing replace entry is
> the most common thing to happen, or loops with more than one
> elements are equally plausible to happen but the self-referencing
> one is singled out by this patch because it is trivial to notice,
> unlike other forms of equally problematic loops?

Loops with more than one element are possible, but I couldn't see an
angle by which they are plausible.  In particular, I know how a user
can (and did) accidentally trigger a self-referencing replace ref (if
you're curious, see
https://github.com/newren/git-filter-repo/issues/401; it's much less
likely to trigger now due to an unrelated change to the default for
`--replace-refs`, but could still be triggered in combination with
that option).  There are many variations on their theme of "do a
change, then undo it" (in combination with the old `--replace-refs`
default), but I don't see how to either vary their testcase or come up
with some other way to get git-filter-repo to trigger a replace ref
loop with more than one element.

> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> > index 76d5c20f141..51c8228cb7b 100644
> > --- a/builtin/fast-import.c
> > +++ b/builtin/fast-import.c
> > @@ -179,6 +179,7 @@ static unsigned long branch_load_count;
> >  static int failure;
> >  static FILE *pack_edges;
> >  static unsigned int show_stats =3D 1;
> > +static unsigned int quiet;
> >  static int global_argc;
> >  static const char **global_argv;
> >  static const char *global_prefix;
> > @@ -1602,7 +1603,19 @@ static int update_branch(struct branch *b)
> >       struct ref_transaction *transaction;
> >       struct object_id old_oid;
> >       struct strbuf err =3D STRBUF_INIT;
> > -
> > +     static const char *replace_prefix =3D "refs/replace/";
> > +
> > +     if (starts_with(b->name, replace_prefix) &&
>
> Curious how the "diff" machinery decided to represent the hunk like
> this, instead of say
>
> >       struct strbuf err =3D STRBUF_INIT;
> > +     static const char *replace_prefix =3D "refs/replace/";
> >
> > +     if (starts_with(b->name, replace_prefix) &&
>
> Of course that has nothing to do with this patch or its review.

Oh, that is kinda weird.  It's not a whitespace-change issue either;
both the removed and added blank-looking lines really are blank lines.
No idea why the diff machinery does that.

> > +         !strcmp(b->name + strlen(replace_prefix),
> > +                 oid_to_hex(&b->oid))) {
> > +             if (!quiet)
> > +                     warning("Dropping %s since it would point to "
> > +                             "itself (i.e. to %s)",
> > +                             b->name, oid_to_hex(&b->oid));
> > +             refs_delete_ref(get_main_ref_store(the_repository),
> > +                             NULL, b->name, NULL, 0);
> > +             return 0;
>
> I am not sure if a warning is even warranted.  If you decide to
> replace an object A with the same object A, the result ought to be a
> no-op.  I wonder if it is makes more sense to
>
>  (1) do this unconditionally and silently, and
>  (2) when we prepare the replace_map, ignore self-referencing ones.
>
> instead.  If (2) makes sense entirely depends on the answer of an
> earlier question (i.e. "is there a reason why self-reference is more
> common than general loop?").
>
> Thanks.

Since you added more in a subsequent response, I'll go respond to that.
