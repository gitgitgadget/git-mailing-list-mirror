Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E946B4
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065148; cv=none; b=iM0urDzqc471Jkv6zw9wf47olVLnrTmSE8meIo6vRpxI2ttagg15FvPvNpUHfUpIWmY5t7Z3FhYGiior2UZMQ0vIX8ro4/uzl+wKBqQx/3B8R31aCCBkp6/Mfn9gIzFps9aRAiksY6UJd1DncxhncbdaYRoDOoDXIAU0faoqWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065148; c=relaxed/simple;
	bh=93OF4h/FZ6OiAOGTTXWXhYVQf8xa6nNeSTdc5/wKb48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncRr0iVhVuV1iFsazx9STxzbIV2wmDY9QKZr7KPIwpyL2eAW2No0d60UVTQTAFbmek6ASg7T4MJIusx7j7g4qtkKstKS5TE7OPLQfOi0OoJwd91VX0lhzJ27DKX4OzXacWwM5/OernMt0BEvL+GL60Xu1lV4kJd6vwp0m1gOqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/mVFQGv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/mVFQGv"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51008c86ecbso1494719e87.2
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 18:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065144; x=1706669944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAffiJIUaPI6hy37bihoxnCdgLGu1yr3O8VKY8TdU5w=;
        b=J/mVFQGv2KKUUsjf767pulaoJkoq4nICqczw9W2Er0+LjYgK7VFX4zyxqgA0JCUE5H
         ZpL79aAWttr+kJwonbvwWqScSoYh7rrwWLsWiny2yj3JdvyemaVT68ET0OnvB5zGbDLk
         +TPnvLep+8jiaD6zyBEgZV0vo5NIRsfWchTctt1usOH9i1ttukTxKGOEKStzddTGsdzF
         EhDF0fhA0QjCNNAI9lxa7iIAsCHvmNYnS2JQ6VMS6zesa73lKPXzIehXRoqoT9zHxhUo
         bMNqMKumkp3qEHEohNEfV3ncAGv/hpIdmHrQK1Nqu+I/u8kkA0KKs4OQJEMlNRqY3lkN
         RNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065144; x=1706669944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAffiJIUaPI6hy37bihoxnCdgLGu1yr3O8VKY8TdU5w=;
        b=dymDISkm3lPXfkO35Oaiacb0BOha9rTKFAtIi9fHxW27U2sTXlEvUqVyGTaxiZaY9m
         R/sjId2/XibS8yVBfhxgDYSLnIticefp/PRNuvQFgN7tr0BjUCZP21zSUCEgJHCFb2hN
         ko1HZKT+RiLnyLHVvFhMP2VkPKcyfI41pvW1QFnGxKOLdaYuY3HgIFKUBzQwnwQOoOfO
         zSbB+KONuEHxps1EZV+oR+ZO3Alok0nUSjGxF0LNmyQkHRVrF2np52b2vfjvh3EzVUq3
         f7gxbroreNZcrn6mXAEzC+RwQoRuUVM9FmkZjAaA3yRS6vZH81t/zKaccbmswkavirhW
         V7GA==
X-Gm-Message-State: AOJu0YxJruoe7p7dLthl1krdqUhU+lnwrXBFrmi4rztJlZfBXy+zIUwO
	m8hBD0O3wrMOKvr6Tm9owjw74ejPdbFv/thSmzVJgep7fWp/z2idehPh8stncKVTXTLtCZeJ56A
	HvkeLexjlisyh6y3B5ROMB1Ni3TE=
X-Google-Smtp-Source: AGHT+IHYK40Cu0GKSUAEhvcxN/ApXn6MdQU4RGdoZPAjhOz0KOiPzbyrnP5Q1C36gBe8QDjKKREYpG+C3OegZ/Y4cUU=
X-Received: by 2002:a05:6512:4cb:b0:510:d7f:8c9b with SMTP id
 w11-20020a05651204cb00b005100d7f8c9bmr390837lfq.6.1706065144209; Tue, 23 Jan
 2024 18:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
 <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
 <20240122213410.GA811766@coredump.intra.peff.net> <xmqq1qa9rqji.fsf@gitster.g>
 <20240122215954.GA813833@coredump.intra.peff.net>
In-Reply-To: <20240122215954.GA813833@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 23 Jan 2024 18:58:51 -0800
Message-ID: <CABPp-BHcdn3+mbPJk8LZvMjPWZ4s-xdUyevrMbgbT4yQpJ_umA@mail.gmail.com>
Subject: Re: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?UmHDumwgTsO6w7FleiBkZSBBcmVuYXMgQ29yb25hZG8=?= <raulnac@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 1:59=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 22, 2024 at 01:45:05PM -0800, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > PS I hadn't realized that --exclude-per-directory had been marked as
> > >    deprecated. I do agree with e750951e74 (ls-files: guide folks to
> > >    --exclude-standard over other --exclude* options, 2023-01-13) in i=
ts
> > >    goal of guiding people to the easiest option, but I don't know tha=
t
> > >    there has been any discussion about removing the other ones.

I'm not aware of any discussion either.  I certainly had no plans to remove=
 it.

> > I do not think there is any value in _removing_ the perfectly well
> > working --exclude* options, even though I think --exclude-standard
> > should be what users and scriptors should be using if they want to
> > emulate what Git does internally.
>
> Yeah, mostly I was surprised that e750951e74 used as strong a word as
> "deprecated".

Well, here's what I was thinking.  First, based on wikipedia's
definition of deprecated:

```
In several fields, especially computing, deprecation is the
discouragement of use of some terminology, feature, design, or
practice, typically because it has been superseded or is no longer
considered efficient or safe, without completely removing it or
prohibiting its use. Typically, deprecated materials are not
completely removed to ensure legacy compatibility or back up practice
in case new methods are not functional in an odd scenario.

It can also imply that a feature, design, or practice will be removed
or discontinued entirely in the future.
```

Since "can also imply" !=3D "does also imply", and based on the commit
message of 491a7575f (particularly the part that quotes dcf0c16ef1,
both of which were prior work that informed the under discussion
e750951e74), I thought the use of deprecated was perfectly applicable
here.
