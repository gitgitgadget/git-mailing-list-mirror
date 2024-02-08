Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3177F33
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404655; cv=none; b=e0KVsdA5OnqnYIwMar9jIlONPOOpZY27UlWFXoqadsYtpPXxd11m72sKT+m0fwUZHYwUoUcQediHqkFPylzTCqeRFbBhXt6sI2hMQDdxSgEqevIND89FbXOz/D2XoTyBAy3yJJh53NWXohaXgnDCtKdjqk7/mSABdRdHFbWsAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404655; c=relaxed/simple;
	bh=ALfeOQ7dfczxtORRmyrC075h32hZRifl0DvIrA7Zsco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOudEduYEJsRNTDvTEbmaH+TG71vbb16Of3MXlCYDFFACBZU6dcN52jXJg98PYo+lTF9GKbD6BCwh7OdhrtOE/h+wdkfwGrRPSgVRR7yBIrNKuNSOCjoIffkFoFPyCzZZhvgNerYuvAGD3fpZEEveY8/KL7Zen5AXUSY+ekd/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdqkPAQq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdqkPAQq"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so2261029a12.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 07:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707404652; x=1708009452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07ARFO88pDPOohAEB4wKaQrG8r+XRlD7IxyoAyO2Q8A=;
        b=VdqkPAQqP+WU7GUK9tGAw31AIKkADTlh+RAaicSIiVeB1ji+Qp6VpqIXpqyBfCF+uH
         0/nXKCZfexUD3dEm9DpcUq6lurHqyTqNbWl4oYN75jContGupziK60jr0NkvnLaTDcvy
         OWH3Lax0M1MXYv112873KpbaX4qVD7oncqyG2wYv0lMgOoR/Inum2DOmJjEzFJsbuV5t
         QMYzwUMs3i4qy1BFjOwLI9AbdhMnHJp9DbjYYAzMuP6wkrvjlCg7jB3E3X7BqH5hXu+A
         3hKzAcFeLjvmZAZZYW2MXUCPjhfsXd0nc2/PPAVPW1zkGOoJEBXxqOA7ZtpsCTDFHv5y
         wgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404652; x=1708009452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07ARFO88pDPOohAEB4wKaQrG8r+XRlD7IxyoAyO2Q8A=;
        b=dpQcorTTVA9pZIUUDS2WIN/JYt3ZqVpwnPTgIFaABqXWhRpBeikgwsoY2LDTwpeDJY
         qjIRyTq0bZouzifhzTkD8seH8olq7o5ALmCSoLoDFcC74L/q+NsNXC+BlHlXRkxtdniH
         g0hglKJheMtzhMY6HcpZnoahbt9WEjOAaB70Ve6RmNMXzV9QZAa1vPm8e4VaZI0VE+9O
         gUtTJzs/bKBj/wc2S1GkHgKNw8N3wCUP6fZMRq2F09ymEbiaqBnI0zUtfO3hcCBOB0Gq
         bruyITPihQBM9R6QozMHLOahkDMsx8C5cSdH0MZOgd0f/qHPYj3quyPQWxWQpIRImLXa
         mBPw==
X-Gm-Message-State: AOJu0YwthoWuVK+vLZ7J9Rj1m5xD8rGMzfPKrLJluT6ONzVwy3cQ6Pb0
	IuZmBidT0bW9fXOuY2PQaSTY88pcBTK2OSF2sFwArI1k2DzM4pNAGTQK2oH7ZBxCX+ePAkROA9E
	N3N9IxejRdGgyVWgL5hEfApyt7txf1gLmzhE=
X-Google-Smtp-Source: AGHT+IEvAKAqBQwNyr9JXGPebWNTmdECraZ+LFDb2uOEw9nPYXY77pXxHEHvZTCxsFJEfaIdsqL7Bu2420SubVzXoR0=
X-Received: by 2002:a17:906:e1a:b0:a36:5e34:3a34 with SMTP id
 l26-20020a1709060e1a00b00a365e343a34mr6874710eji.69.1707404651965; Thu, 08
 Feb 2024 07:04:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com>
 <20240201115809.1177064-4-christian.couder@gmail.com> <owlywmrgmx2j.fsf@fine.c.googlers.com>
 <CAP8UFD3D=a-3cVNpjobOdq=F5dC+aW4qYu3fXCxTnDg=GrnSwA@mail.gmail.com> <owlyr0hom257.fsf@fine.c.googlers.com>
In-Reply-To: <owlyr0hom257.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 8 Feb 2024 16:03:59 +0100
Message-ID: <CAP8UFD148VDVto3_NwQcCkRGFZ1qHHDtYTXVxV_=VsOjgqJcbg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:48=E2=80=AFPM Linus Arver <linusa@google.com> wrot=
e:
> Christian Couder <christian.couder@gmail.com> writes:

> > It actually kind of "works" when you pass blobs or trees. It looks
> > like the command just doesn't use them (except for checking that they
> > actually exist) unless options like --objects, --missing=3Dprint and
> > perhaps others are used. So yeah, the doc might need an update, but I
> > think it could be a separate issue, as it's not new and doesn't depend
> > on this small series.
>
> SG. But also, if there's a way to put invisible (developer-facing, not
> user facing) comments inside the relevant doc file it might be easy
> enough to add a to this series.

It might seem easy to add/improve some doc, but there is sometimes
bikeshedding. So I don't think making this series dependent on such a
dco update is a good thing for both that doc update and this series. I
will try to work on such a doc update soon though.

> > "quarantined objects" refers to the following doc:
> >
> > https://www.git-scm.com/docs/git-receive-pack#_quarantine_environment
> >
> > So to clarify things, the above paragraph looks like the following now:
> >
> > "When such a command is used to find the dependencies of some objects,
> > for example the dependencies of quarantined objects (see the
> > "QUARANTINE ENVIRONMENT" section in the git-receive-pack(1)
> > documentation), it would be better if the command would instead
> > consider such missing objects, especially commits, in the same way as
> > other missing objects."
>
> This reads much better, and is a good motivation to keep in the log
> message.

Ok, I have kept it in the V2 I just sent:

https://lore.kernel.org/git/20240208135055.2705260-1-christian.couder@gmail=
.com/

By the way, sorry for forgetting to use the --in-reply-to=3D... option
when I sent it.

> > Yeah, I was surprised too. I only found the following similar code in
> > list-objects-filter.c:
> >
> >     oidset_iter_init(src, &iter);
> >     while ((src_oid =3D oidset_iter_next(&iter)) !=3D NULL)
> >         oidset_insert(dest, src_oid);
> >
> > So yeah perhaps we could create such a helper function.
>
> Perhaps a NEEDSWORK comment is appropriate?

I actually added another small patch in the V2 that refactors the
existing code into a function in oidset.{c,h}.


> >> With a few more context lines, the diff looks like
> >>
> >> --8<---------------cut here---------------start------------->8---
> >>         if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid=
, &oc))
> >>                 return revs->ignore_missing ? 0 : -1;
> >>         if (!cant_be_filename)
> >>                 verify_non_filename(revs->prefix, arg);
> >>         object =3D get_reference(revs, arg, &oid, flags ^ local_flags)=
;
> >>         if (!object)
> >> -               return revs->ignore_missing ? 0 : -1;
> >> +               return (revs->ignore_missing || revs->do_not_die_on_mi=
ssing_tips) ? 0 : -1;
> >>         add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local=
_flags);
> >>         add_pending_object_with_path(revs, object, arg, oc.mode, oc.pa=
th);
> >>         free(oc.path);
> >>         return 0;
> >> --8<---------------cut here---------------end--------------->8---
> >>
> >> and it's not obvious to me why you only touched the "if (!object)" cas=
e
> >> but not the "if (get_oid_with_context(...))" case. Are there any
> >> subtleties here that would not be obvious to reviewers?
> >
> > I thought that if we can't get an oid, we cannot put anything in the
> > 'missing_commit' oidset anyway, so it might be better to error out.
>
> Ah, makes sense. This is a subtle detail, and perhaps worth keeping
> either as a comment (just above the "if (get_oid_with_context(...))"
> case) or in the log message.

I added a code comment just above the "if (get_oid_with_context(...))"
case in the V2.


> Ah, I see. I think you could add a comment like
>
>     We want to check that things work as expected both:
>
>       - when we pass only one missing tip (when $tip is ""), and:
>       - when we pass one missing tip and a tip that is not missing (when
>         $tip is "HEAD").
>
> at the top of the test case, and probably rename $obj to $missing_tip,
> and rename $tip to $existing_tip.

I have renamed the variables like you suggest and added a code comment.

> Aside: it's a bit unfortunate that the meaning of "missing" becomes
> overloaded slightly here because one could say '$tip =3D=3D ""' is a
> "missing" tip becauuse the name is not provided. Subtle. Plus there's
> some interplay with the "if (get_oid_with_context(...))" case above
> because we will (?) hit that path if we do pass in "" (empty string arg)
> as a tip to rev-list. It might be worth saying in the comments in the
> implementation, something like
>
>     The term "missing" here means the case where we could not find the ob=
ject
>     given the object_id. For example, given HEAD~1, its object id (oid)
>     could be 82335b23aa7234320d6f8055243c852e4b6a5ca3. If no real object
>     with this oid exists, it is considered missing. Providing an empty
>     string to rev-list does not touch the "missing tip" codepath.
>
> I wrote the above hastily so it may need further edits to make it
> succinct. But the point is that this definition isn't spelled out in the
> test case, which makes the "" argument for $tip that much more subtle.

I think this is related to the --missing option in general (which has
been with us for around 6 years already), not specifically to this
series, so I think it can be done separately.

> >> OK so you are using this empty string to clear the expect.raw file. If
> >> that's true then what stops us from doing this at the start of every
> >> iteration?
> >
> > I am not sure what you mean. Both:
> >
> >     git rev-list --objects --no-object-names HEAD ^$obj >expect.raw
> >
> > and:
> >
> >     >expect.raw #2
> >
> > are clearing "expect.raw" as ">expect.raw" is used in both cases.
> >
> > If we did the latter at the start of every iteration, then when we do
> > the former afterwards, we would clear "expect.raw" raw again, while
> > there is no point in clearing it twice.
>
> Yes but doing it that way would separate "set up a clean environment for
> this test case" from "find the oid of the non-missing tip" from each
> other in the same if/else stanza, which I believe helps readability.

On one hand it can help readability, but on other hand some people
interested in test performance might see it as some waste. So I prefer
not to do it for now.

> >> Also, given how most of this is identical from the loop already in t60=
22
> >> just above it, it would help to add a comment at the top of this one
> >> explaining how it's different than the one above it.
> >
> > The one I added has an extra `for tip in "" "HEAD"` loop. Anyway I
> > think I will just modify the existing test in the next version I will
> > send, as I plan to implement Junio's suggestion and there will be no
> > new option.

Actually I changed my mind and didn't modify the existing test, but I
renamed the variables as you suggested.

> Now that I have your attention (was this my plan all along? ;) ), I will
> take this opportunity to ping you directly for a review of my own patch
> series for the trailers subsystem:
> https://lore.kernel.org/git/pull.1632.v4.git.1707196348.gitgitgadget@gmai=
l.com/
> which is in its 4th iteration after many helpful comments from Junio.
> Please don't let the patch count (28) raise any alarms --- they used to
> be 10 but I broke them down into smaller steps to ease the review
> process.

I will try to take a look soon. Thanks for working on improving the
trailers subsystem!
