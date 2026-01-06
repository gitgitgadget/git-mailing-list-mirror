Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1C2BFC8F
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742631; cv=none; b=MnC280TCirN/WX7nTfokwkhM4T8rF9DVMee3hD2ntLrSpmtFXChloi55fpn6nxDc0WX/F7bZ2j7LuHfo/XSJSioBpD8EQydCCliF+dMM7a8+5vN5pK2U/+32ZMOlDf9HsVrX4H4nhFaDw4HDte0+25CR+za3jmNnzeFUZ8340FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742631; c=relaxed/simple;
	bh=3ODrlUUbFsgIqVrHU86D1AgvPu70tFFnjtL8dLUwdpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXTAdOhoNeY/nQvrvZVoH4nl/5JwHWL8Y7RHrkAohxVnAno21avDtPW+XUoRbTOyqkX3WbPoBThbvbond8mFOhmtf8943qF/9DRUGxJH/M7SIFMUDxEDEl5vpYD6e3H9SI4p15NQUC1dRsPRA30/GWVnZNRYuRZMtMt/rBEDVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNhbXUl7; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNhbXUl7"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-65ec86c5e70so873580eaf.3
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 15:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767742629; x=1768347429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L05yuk6MIsPPvjgzfMAshcL73CU7MdoChwBgl+P276I=;
        b=PNhbXUl7v8xH7stjotdTMvSlgDbFptAZ7cVjAQh22JApMIrnGUjTA3PrrNdCY6l2T+
         bnnUtt4EJOje6DPKm9oIMTSIJJe5naslSw5lVr+PakkAGK/SmlotNFMejYKNm3QwJOO0
         F666QZF2QMq2x6kzHpgK9S96VvgOQNtek2eQyRbUb1V1wyH2G50UKHtCADcDY9PLo/ap
         odOg08oVzEe/9+LOC/IAqPK0n2ynihcHdoQb2Upv0VUwyhJesoWxvvlKmI2/WgEsP8Jv
         u2q4KYXdyhv1VPXtHummdV4zrsuD9VDbo5EJ3Xry4k9eP3neBuHkL7JUYb/eiRY/sf1Z
         WsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742629; x=1768347429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L05yuk6MIsPPvjgzfMAshcL73CU7MdoChwBgl+P276I=;
        b=IYg1+LgFJ99fkr9BmROBNbA5YQUmUpTRjPWr4JHwlDiEmk6nxplRXyQpArXO9eFMCz
         YqFENzecJ+al1b1vSqrhvGFv7Hz1Fj5sk389pLxabvOSI+cxiJiVWDf3MiBoLgq0wVsZ
         t3GTPGSftocvmbmEDq/WnLOrC5V2rJJKJuJgb8FQqTqU0rLhkRssRNKkEywMby2DxsDG
         Exal/aemkW0bxIrRRKYV8tI7nUoKJsaon/1DlyFvQu/mb08OrQByDSz9wXYu+O+xGvGs
         9K7jbqBtt032vWprKeOnKWvbiz+ALZWOZZw5fiS6ny/evWR3dEaLQVDE+74aM06DF4/3
         sg1w==
X-Forwarded-Encrypted: i=1; AJvYcCWAKMzLf+jjgne0rl8yEI00fnmex6KeCZ8f+ukYFn43Vi6U32gigicP/pSr5WSGhWijbXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9Ris/V9IK/BemiIHI3bnU6pTT0kRqTYy00AA1Yeg6wxz+SQ3
	tDFeC4mkqA+Dp0S7HhqK1ELPnJHEoleuF1WpiOVFPEJ/MABz3ML3g9zcWZaQA9GekU7hAO+euI/
	fANoDqN8K/TQEZ0slOKg69dLkUVzRGB0=
X-Gm-Gg: AY/fxX7a0fPPcTH+7sE5mSsmVylGyO4qpAIc+XWwjZ+d05l2kLDXj5Vsog1vwqaixjq
	rIzPLnfT6bJZrCz2921WMkTFzqrJ5T/tRB3+VNQIOawHMQahzFW0XJdAGmrxMrzhG3LrSZTghhw
	SmctNpRN5GN6ueDPG7/zkbHDufuhTBEnLdSyo9131l6fferk4HSFvCvjP3fqLs9bwf8FlaiAcLm
	ZE26jx5U5YGgcYOHf+uGQigT82bz1+vIs3RU/DZm59NFsqdsUnSxpbRFWps+4b6yn6I7tnqX0AB
	eMVDJUAwRq4pY1DEcCamyBYP7LYR
X-Google-Smtp-Source: AGHT+IFaWY5FerTHW97znhAB4IEughCQP8XSvSnrQeJ4blnVnxqmXL3WRn+Zk2WRNnluLkbPyTeLbAguKSjFkLaPBDM=
X-Received: by 2002:a05:6820:1501:b0:65b:33ec:1bd4 with SMTP id
 006d021491bc7-65f54f5e553mr234034eaf.43.1767742628831; Tue, 06 Jan 2026
 15:37:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2026.git.1767035549378.gitgitgadget@gmail.com> <20260102054922.GA2580212@coredump.intra.peff.net>
In-Reply-To: <20260102054922.GA2580212@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 6 Jan 2026 15:36:57 -0800
X-Gm-Features: AQt7F2rg1W_XnIYbk0sh1pMku5eL8ydw5EgERSRcJ0y_Ll-TJLD2X8sPS5YHawE
Message-ID: <CABPp-BGqiM8fmirgdqumRNfzWediC5v_uZ9qHjntTqPqABDhnA@mail.gmail.com>
Subject: Re: [PATCH] fsck: snapshot default refs before object walk
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Matthew John Cheetham <mjcheetham@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 9:49=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Dec 29, 2025 at 07:12:29PM +0000, Elijah Newren via GitGitGadget =
wrote:
>
> > Fsck has a race when operating on live repositories; consider the
> > following simple script that writes new commits as fsck runs:
> >
> >     #!/bin/bash
> >     git fsck &
> >     PID=3D$!
> >
> >     while ps -p $PID >/dev/null; do
> >         sleep 3
> >         git commit -q --allow-empty -m "Another commit"
> >     done
> >
> > Since fsck reads refs at the beginning, walks those for connectivity,
> > and then reads the refs again at the end to check, this can cause fsck
> > to get confused and think that the new refs refer to missing commits an=
d
> > that new reflog entries are invalid.
>
> I'm not sure if this is entirely accurate. Does fsck read refs at the
> beginning? I think it walks over everything in the object database
> without regard to connectivity, marking each with the HAS_OBJ flag. And
> then we use the refs to find the reachable objects, making sure any that
> are reachable also have HAS_OBJ set (otherwise they are missing).

Oh, indeed; I got that wrong.

> So the race is really:
>
>   1. We look at all of the packs and loose objects to set HAS_OBJ.
>
>   2. Somebody else simultaneously adds a new object, which is missed by
>      our step 1, and updates a ref to point to it.
>
>   3. We look at the refs for reachability, see the new object, but
>      think it is missing because we never saw it in step 1.

Yep.

> And your fix is to snapshot the refs as a "step 0", and use that
> snapshot in step 3. So any new objects that are introduced after step 1
> will never be referenced, since we are using the snapshot values.
>
> Which makes sense as long as we assume objects are only added to the
> repository. I think we'd now have the opposite direction race:
>
>   0. We snapshot the refs.
>
>   1. Somebody else deletes a ref, and then does a pruning git-gc which
>      deletes the object it pointed to.
>
>   2. We look at all of the objects and mark them as HAS_OBJ. We do not
>      include the now-deleted object.
>
>   3. We do a connectivity check with the snapshot, and are dismayed to
>      find that the deleted object (which we believe is still referenced)
>      has gone away.
>
> I think you could argue that this is a much more preferable race,
> though. A busy server will see lots of new objects introduced and refs
> updated, and you do not want to have a stop-the-world lock that prevents
> pushes. But it is much less common to do a pruning gc, and it is
> probably OK to have a mutually exclusive lock between fsck and gc.

Indeed.  I'll add some comments to that effect.

> > This problem doesn't occur when refs are specified on the command line
> > for us to check, since we use those specified refs for both walking and
> > checking.  Using the same refs for walking and checking seems to just
> > make sense, so modify the existing code to do the same when refs aren't
> > specified.
>
> So I don't think this part is quite right either, then. We're not using
> the command-line arguments collect the set of objects in the repo. That
> still happens by walking over the odb itself. So if I do:
>
>   git fsck --no-dangling HEAD
>
> in git.git, and while it is running, do this in another terminal:
>
>   git commit --allow-empty -m foo
>
> then I get:
>
>   error: 49a90c19d0cd010ed00fbb1e4256cbefaa8b83e2: object missing
>
> even with your patch. So I think that names given on the command-line
> could benefit from this type of snapshot, because they suffer from the
> same race. You want to lock in the ref resolution (whether from
> iterating or from names on the command-line) before you start walking
> over the odb.

Good point.  I added this snapshotting in v2.

>   Side note: I do not think I have ever run fsck with refs on the
>   command-line. It is not like it saves you any time! Most of the
>   expense comes from opening up and verifying the objects in the first
>   step, not from looking at ref reachability.

Not to mention it produces spurious "dangling" object warnings,
because while the objects might be reachable, they aren't necessarily
reachable from the particular subset you specified on the command
line.  I wonder if no one ever noticed that because it's such a
useless mode; I only noticed it because you pointed out how Matthew
and I overlooked races with command-line arguments.

> And one final note on the overall direction of the patch. We are
> assuming that if we look at the refs first and then the odb second, that
> we will be getting a "fresh" view of the odb in that second step. But
> that isn't necessarily so, as we might have loaded the set of packs
> earlier in the process. I don't know if it is possible to trigger that
> during fsck or not, but certainly it is relying on a subtle assumption.
> It probably is worth calling odb_reprepare() after taking the snapshot
> to ensure we are not getting any results cached from before the snapshot
> was taken.

Will add.

> > +struct ref_snapshot {
> > +     size_t nr;
> > +     size_t name_alloc;
> > +     size_t oid_alloc;
> > +     char **refname;
> > +     struct object_id *oid;
> > +};
>
> Minor nit, but: why keep two arrays and not a single struct with both?
> After all, you even end up sticking them back in a struct at the only
> point of use:
>
> > +     if (the_refs)
> > +             for (size_t i =3D 0; i < the_refs->nr; i++) {
> > +                     struct reference ref =3D {
> > +                             .name =3D the_refs->refname[i],
> > +                             .oid =3D &the_refs->oid[i],
> > +                     };
> > +                     fsck_handle_ref(&ref, NULL);
> > +             }
>
> So this could really just be an array of "struct reference". You can't
> just hold onto the "struct reference" passed in to the snapshot_refs()
> callback (because it gets reused as we iterate), but you could do a deep
> copy.
>
> That did make me wonder a bit about the other fields in "struct
> reference" (which your snapshot just throws away). But it looks like
> fsck_handle_ref() only cares about the name and oid, so it is OK.

Junio suggested the same thing, although he also suggested we might
want to snapshot some reflog information at the same time, which then
wouldn't make sense to be using a struct reference.  Even though I'm
not implementing per-reflog snapshotting, I left a comment in the code
about it so I think it made sense to just create my own data structure
with just the name and oid.

> > @@ -999,6 +1050,19 @@ int cmd_fsck(int argc,
> >       if (check_references)
> >               fsck_refs(the_repository);
> >
> > +     /*
> > +      * Take a snapshot of the refs before walking objects to avoid lo=
oking
> > +      * at a set of refs that may be changed by the user while we are =
walking
> > +      * objects. We can still walk over new objects that are added dur=
ing the
> > +      * execution of fsck but won't miss any objects that were reachab=
le.
> > +      */
> > +     use_snapshot =3D !argc;
> > +     if (use_snapshot) {
> > +             now =3D time(NULL);
> > +             refs_for_each_rawref(get_main_ref_store(the_repository),
> > +                                  snapshot_refs, &default_refs_snapsho=
t);
> > +     }
>
> BTW, one of the reasons I started looking at this is that Coverity
> complained about this segment of code. We set use_snapshot if and only
> if we don't have any argc arguments. And then later...
>
> >       if (!argc) {
> > -             get_default_heads();
> > +             get_default_heads(use_snapshot ? &default_refs_snapshot :=
 NULL);
> >               keep_cache_objects =3D 1;
> >       }
>
> ...we enter this block only if argc is zero. So we know that
> use_snapshot will be true here, and the NULL path (and thus the fallback
> code in get_default_heads()) will never be used.
>
> That's not wrong exactly, as it's "just" dead code. But it was what led
> me to thinking about whether the case of non-zero argc would benefit
> from the snapshot, too.

Yeah, I needed to restructure this anyway to handle snapshotting
command line arguments, so I just cleaned it all up.  Thanks for
reading carefully.

> There are a few other related interesting cases, too:
>
>   - We may use the index file for connectivity, as well. It suffers from
>     the same race, and would benefit from a snapshot.

I left a couple TODO comments about this, so that those who are
interested/motivated can extend the snapshotting further.

>   - In get_default_heads() we also look at worktree HEADs. Those have
>     the same race (their normal refs we don't consider here, because
>     they were already handled by the overall ref iteration).

I handled these in my newer version, since handling them is pretty
similar to handling command line arguments.

> I know that neither of those is of particular interest to you as a bare
> server repo would have neither. And it may be OK not to handle them, if
> the complexity doesn't merit it. But it might be worth documenting the
> short-coming.

Yep, absolutely.  Thanks for reading so carefully.

> -Peff
>
> PS The other reason I looked at your patch is that I got deja vu from
>    all of this. I thought we had discussed ref snapshotting for fsck
>    before, but I couldn't find anything on the list. It may have been
>    internal GitHub discussions.

It likely was.  This was based on a patch that's in GitHub's fork of
git, which tripped up Michael Haggerty recently -- in particular, he
thought this fsck race had been "fixed", but was tripped up both by
the fact that it was a non-default option and that it was only in our
fork.  I volunteered to try to fix both issues, and heavily overhauled
the patch in v1, and will have completely rewritten the original by
v2.
