Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58C2D7398
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 23:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201440; cv=none; b=PmaNVLfv9tOAqQooRksvrwPpHMO5ydavKqj3GiVqOQqFPJHG3M/VfWjlL+4k/YR1FVRrrGN/q6l0LxJdKSk638CFxD8sGnMnlBxcISAGlC94uogboIOaDZzTyqn0qB2IeZJnzWlyRwqEuTCzT0F6t2/CRIJSEiM5gJf7obg0ZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201440; c=relaxed/simple;
	bh=FvpuA3y2++ANelndgRqdcmOhvDgqse1z21CNjelLpdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AB761J/0bk8xmMgfc6UnJmmbFBviGHob3eCpsGR6RkHNPkrSdjwNYclC394QLyLONBI6tcn4x+PwUScsvFKFXnWnG7bNlyzR8WUSk3ReZtzzGctbQbzpNzWWFFKrOiXn9hV2qbhuuh3HP4iMmVl7VOnHJe60C8KicRHH/IEieXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pov06WZF; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pov06WZF"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-949031532f9so18239639f.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 15:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764201437; x=1764806237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QXjsCMCq4ROJ0Hir8LtaO/RtHM6kBKwBjrjpDOpIhU=;
        b=Pov06WZFZvppw9EjH2841d8L8tzrMwatZzsWnL6u+6V2kiAj8RUiYQHkDjAvgR4PLa
         4Ub+9hP2b38mMXIbxHytXZoH6w7i5mT4s8fLDw1u361vw1UHgyCRog65rQTmYW6dnn7K
         z5WvF8myIgajG8Mr2SubRZ+P+2O+N6pjK+FCmjjBb6a6HrMuNc/BULi5z7kbO/4XY3Ud
         +M7Beu1Rpghx+TVvgvbjti+rQHNYGp3Cc8qR5VJKqO0/iQyXNjtaYbXVQJGDmD63oYwp
         hevGFoPy9SROPDSJZ5bZb1f3ChvwtY0fQOL82vUhByJXyscenZAstek29xKrjqiyrJBB
         a8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764201437; x=1764806237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QXjsCMCq4ROJ0Hir8LtaO/RtHM6kBKwBjrjpDOpIhU=;
        b=fPpUC28vuSU6EPyVtHwmkQZZxrmzaVx1kBuX0sCI5yBNPx3Wd/QloCXKZVWLY1xxNS
         PeORzAGXA3viFgDF8mkUG4RRNW7rkuhFixT2pGI1WBFoCiiDhhHfZ+yERfp4heo8cQsP
         6qI+k2QEismupuU9gwUWfJQCE0k0Yl7FXIloFHVGzxa84xznxyujqwxwP/9ByUH51ffD
         QA8RFelIk/9h9+z9hxBq12m9G57lxt/VgaXDTZf4lGTuufZX+vDkKnDEEmgnydNfup0z
         cZFRhzFfupVD5hlF6xfR5yDrWI1AANnzngec/UEQLuDJJQlIbB0DfKesrZIe7Ca+2Rh/
         DISg==
X-Forwarded-Encrypted: i=1; AJvYcCW1gn13IAJnmAIVEPVJJ6Xd9wsn2lAiBLUsBZvm4zBMmjkL6zHdMYEVrE2/GPc0cnC/ms4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA7tyeNilHaYvlghvj6H4CM1wD8XlXmuNTQMnZdoR+FkO8Hbiw
	WaBt730qJOgLvY0IdTrZU4VByXb8JjwFzmdGkjCfEOlZTsGN/42Xlh6ifDUsfe1pI1CMRUfj9Z0
	26tp/wDxhSOQbXFaHj5i7bZbScTL31jA=
X-Gm-Gg: ASbGncuk3azmRu0MX4lBG6nEXX7vM4ECVuXtA7zuaHvFC2OksoBc6HH0/ZAJ3QP+fQo
	v4C1gl8QBl8zZpEFVl0p9BXJ2egIG/8r8WcZEROKElAa+80ebwpNGt9baXCsuCywgNWhkQi/ruw
	KtkyA9Xweva44IXmuSe9HYxRCC7SLveSJCciG36l4IA+ko1IAfoGZ/BkYxlIldkqwUjyjLe1AGX
	hjMLYrMk2vgD3QWeYoP/t+0xg7YaHx2P+a2TFFYwTs6RdJXkJHEs0Oem4QzGjESl/dUQSNX8/7E
	xe2HMY1jEi9EHkHsdNLmlFAB07hY
X-Google-Smtp-Source: AGHT+IHsLFrBiCklh9FaLOiZaqage7ndwFDd9pvvEt/w8mFTOHXeIgAGc04PWJ81bi84z61VL6EamRiaLnczm2IN/Bg=
X-Received: by 2002:a02:a482:0:b0:5b7:1bb7:db25 with SMTP id
 8926c6da1cb9f-5b9659b3f6cmr14506913173.4.1764201437485; Wed, 26 Nov 2025
 15:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com> <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
 <CABPp-BEF1RVs7n4xf6ihyPUmxrhgpG6VEpZLrX=MTgcBWBRbfA@mail.gmail.com>
 <xmqq3460ocv7.fsf@gitster.g> <xmqq3460mr3c.fsf@gitster.g> <CABPp-BHcCX8LDccRoarsqNO=YVr7a8gp67oc87b7taAmjch4dQ@mail.gmail.com>
 <xmqqy0nsl741.fsf@gitster.g>
In-Reply-To: <xmqqy0nsl741.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 26 Nov 2025 15:57:06 -0800
X-Gm-Features: AWmQ_bl9SY0ZM7ZY7ph07Ng180LJSWPkZU5Vs4tbDDDwBLZgGuo8RQXoSJu-J_o
Message-ID: <CABPp-BESM4PC+QVXZ-X_Y0m3PrSQGuc-jfB2pCJ+hXy0Gi-T5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com, ps@pks.im, karthik.188@gmail.com, 
	code@khaugsbakk.name, rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, 
	johncai86@gmail.com, johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 3:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > =3D=3D Example command lines from your proposal =3D=3D
> >
> >    git replay --rebase main feature~3..feature
> >
> > This command to me would suggest that main is being rebased, but it
> > isn't -- it rebases feature~3..feature onto main while updating
> > feature to point at the result.  I find the "--rebase main" part of
> > this command line confusing.
> >
> >    git replay --cherry-pick main feature~3..feature
> >
> > This command to me would suggest that main is being cherry-picked, but
> > it isn't -- it cherry-picks feature~3..feature onto main while
> > updating main to point at the result.  Again, I find the
> > "--cherry-pick main" part of this command line confusing.
>
> That only tells us that if you want to help users by limiting the
> vocabulary to a single set (i.e. both command names, and mode names
> used in replay), you'd need to make sure you have the order of
> <branch> and <range> given to the replay command in logical order,
> in line with the option name, no?  Of course, if you want to say
> "cherry-pick", cherry-picked range would have to come near the
> option flag that says "cherry-pick", naturally.

--advance and --onto are flags that require an argument -- in this
case, "main".  So, now you're suggesting more than renaming, in
particular some bigger refactoring such as making these flags now
require the <range> rather than the <base>.  Let's follow that path a
bit further...

Does your proposal assume that <range> is simple, such as
"feature~3..feature" above (i.e. something that an argument parser
would view as a single argument)?  What if the <range> were "^main
feature1 feature2"?  Or ""^$COMMIT --ancestry-path --branches"?  (I
don't see how to have the option parser easily be able to stuff the
arguments to "--rebase ^$COMMIT --ancestry-path --branches" into a
range variable that eats all of "^$COMMIT --ancestry-path
--branches".)  While I use simple ranges to describe the feature, I
specifically built the command to be able to do things like those
other two examples and use it for those.  Those more complicated
examples are things the rebase command just can't do.

Also, just like `git log` allows `git log [<options>] [<revision
range>]`, I wanted git replay to allow `git replay [<options>]
[<revision range>]`.  Instead of doing magic to get an implicit
revision range as rebase does (and with rather limited options because
of that magic), suddenly people can use what they've learned from `git
log` in another place.  But that piece of knowledge only really
transfers if we do similarly to `git log`, i.e. the revision range
comes after other options.

Perhaps one way to avoid the first problem above is to make
`--onto/--advance/--rebase/--cherry-pick" stop requiring (or
accepting) an argument and turn them into simple mode toggles, and
then make both <base> and <range> be positional arguments, with some
well-defined ordering.  However, if <base> comes before <revision>
then we still have the same problem as my previous email, whereas if
it comes after, then we weaken or destroy the connection to `git log`
I made above.  Maybe the connection to `git log` isn't that important.
What I think is important either way, though, is if we use positional
arguments for both things instead of making (at least one) an option,
then I feel we are copying one of the designs of `git rebase` that
makes it hard for even me to use: I hate that it uses multiple
positional arguments to define the operation; despite using the
command heavily for 16-17 years and sending in lots of patches to
improve it, I still can't remember the order of those positional
arguments and have to look it up again when teaching others.  Maybe
that's a personal shortcoming, but I would really rather that either
<base> or <revision> was an option flag.
