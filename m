Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE52FE066
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765391270; cv=none; b=hhN/OV8RlQ7LolCo7QwUkPM9+k2owhzFchgTg/0+dmcPBxnX/RPHyDE6fopZSSprooP1APYnSoarGT7s9m/pbHKxzT58+7OWqntZKg9O2rRaPG2NtW2zvJ3q4Rq1onTu8UtragvrVGKnvgBKznSYvk88weNuQlVPQS+aF8wgRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765391270; c=relaxed/simple;
	bh=S5YL+zLL3O04are/sTZlTEmOADr9J35lDxWydG024jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVlWcV2YoxJx1/+68hve775u5vTrYkcqA0QCz7tedg29eykyLvam6u1x7/xX2YogPprkxMXVDwuiT32BAUYaz2Z8dZ9LSxvGH+v9qTMdCUMEQArzhzYkFvyCr74Oeo3LfmXSwAQPyZ4sMscFyy0xPd55Y/Pw4d4mWZr778vWTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccGUZ6QG; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccGUZ6QG"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6597a87048bso78177eaf.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 10:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765391267; x=1765996067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/4/k8bawiiQgtGmuvaXPkHG5oi76FDy5N17mPeQEhc=;
        b=ccGUZ6QGTD35FePnZlPO7SKoa4NYXEvspfOxVOhIMTUMi3Dim8iQhabv/QXz/P2Lxc
         nTRkOB6ibd36T0UVOJ9Kb4fR0xPFWQqXCVT/R7czd+imQQiEq/tT78k1AqrZrt+F1Zj/
         sZsfqT7JI1VvoONPsWAC0J49hjnz4vkHGC1DBXkrBQTfFltVG8trl0zncLroDIW8v9DJ
         TGRJ9+WkqRzftnCA7BQwZKfx9VIErHREDNJHol/4XU3vEBitkB5HoTD71UgYP8Lrj3b7
         R8g8KavMY9MUHPUxMOCwE/DJw4H8zHsEFgYJtJtUJmSiq4TfBzaFEkK1s3iRYLAdJi09
         mNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765391267; x=1765996067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w/4/k8bawiiQgtGmuvaXPkHG5oi76FDy5N17mPeQEhc=;
        b=CUl35AQzqqwo9/kGxcEpyVQH/sPBEI0bjpm4resvOAKudzjDu3KvQx2NuDqkJapgVW
         JMd6qH6tZaA5u/XgS5tROXfUGmZWhz132Ukv4LMXGx7R/wrrgbDE6xy5OoSjUhGHLuIG
         kbmcUBepqOLvaogS1/LWZ/ihcgZZ6PpYgye4GlZNau6LdhwKqP6fh1I9ZsAKdh5yeQwW
         7YNj3RpsRVjwSQbpd5MHhaTLiJc0zIbhbFZuZNu1uPQY1vwA0rQdEsp83BuyBJl5IWqc
         FZng8/YnluvPXKiBtiWMXx30U2kfG8M804yiKRPrEn1VnwCqHucu+8HRQdlH5jpQJ/XH
         lMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCURsyf/oOJEivKIj98VmkhwhcNxzP/dVAlv4O+0VKbRh3fBpnJBcdmCsFYWf9CG6nDgONk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVzn8KY6cLWKm0KguYoGnW63s+7be4zeqO4vj6SjT32pLJ+Fj
	b4kHaGT7Mo9vHoo+w4uQFeTAZKJN8VfrNr9YHhzEbPtm29Eh75T6ljWN3sJzmKvhZRWBoGx08dj
	oi/zFg40X/2gDRt1drvHE7Wwseh8knzA=
X-Gm-Gg: ASbGnctr4wH8+gU9GWWKks2mlUDGfsf9SSF7acmaZo2uaCJ+H61+eLbxu1aOE7vVZQR
	MPtqSU5HSo0iJUwM13faR+V9B9jY4qYTPpd6HSsp6br8yvS9mzoDWp/aZCF0jdaWqRNeyvYwPkV
	TdOnaAmq61IAI933PKjsHRrHUH97449TNrqywMOBhctAREj8D6m1d+rXviLARVnI+Ape7WnRy9N
	QADKTd+s8Mn8Wrr5gXDejpKvOxcZtWIaVP5LjRJjlfna4zXQjVMORRxd7z7Jbbp8dfHju1xkf3F
	GBahhR7/n48EmSBC1aZQU5skXjPM
X-Google-Smtp-Source: AGHT+IEkI03d3meqLg8LfPKrgm3EvXXcY/x0w0guiYF/Y9ybehwjoQ1jXwLAj5j6qMEqu/qv95A/29cj1rqQoTb8R+M=
X-Received: by 2002:a05:6820:5086:b0:659:9a49:8e38 with SMTP id
 006d021491bc7-65b3474323cmr172042eaf.42.1765391267476; Wed, 10 Dec 2025
 10:27:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev> <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com> <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <CANiSa6hwaQ2zLsvw=uiJNgfVYAVp2RyQtgVeTevZ5NO5p2Xmgg@mail.gmail.com>
In-Reply-To: <CANiSa6hwaQ2zLsvw=uiJNgfVYAVp2RyQtgVeTevZ5NO5p2Xmgg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 10 Dec 2025 10:27:36 -0800
X-Gm-Features: AQt7F2rfRdXW1Z1qvPqwWhemxQfAIDXFhmhyM3sm3vX35M51ugYC-neQ5-RuLX8
Message-ID: <CABPp-BEs_Q5eGYugogm=Msu-acS3uTj5Oo0xTUnWay9OXBKqXg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Martin von Zweigbergk <martinvonz@gmail.com>
Cc: Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 8:52=E2=80=AFAM Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>
> On Wed, Dec 10, 2025 at 2:38=E2=80=AFAM Matthias Beyer <mail@beyermatthia=
s.de> wrote:
> >
> > Am Wed, Dec 10, 2025 at 09:58:13AM +0000, schrieb Phillip Wood:
> > > Hi Matthias
> > >
> > > On 03/12/2025 18:18, Matthias Beyer wrote:
> > > > Am Wed, Sep 17, 2025 at 10:12:31PM +0200, schrieb SZEDER G=C3=A1bor=
:
> > > >
> > > > > Let's suppose I have this piece of history, I'm on 'branch2', and=
 I
> > > > > drop commit B.  Which commits will be rewritten and which branche=
s
> > > > > will be repointed?
> > > > >
> > > > >     A---B---C---D   branch1
> > > > >              \   \
> > > > >               \   E---F   branch2
> > > > >                \       \
> > > > >                 \       G---H---I   branch3
> > > > >                  \
> > > > >                   J---K---L   branch4
> > > > >
> > > >
> > > > Just speaking as a user here, but my expectation in this scenario w=
ould
> > > > be that rewriting B would be denied by default here, as branch{1..4=
}
> > > > would be rewritten although I am at branch2.
> > > >
> > > > In the scenario at hand, I would expect that I can only rewrite G, =
H, I
> > > > while on branch 3 and J, K, L while on branch4 (without passing som=
e
> > > > extra flags for "yes, please also rewrite the other branches").
> > >
> > > Is that because you have branches that you don't want to rewrite beca=
use
> > > they've been merged upstream or is there another reason?
>
> I think that's a common reason even if it's not Matthias's reason.
> Perhaps one way of doing it would be to have a configurable set of ref
> patterns that are considered immutable. That's similar to what jj
> does, though we use a more general language for selecting revisions
> for it (https://docs.jj-vcs.dev/latest/config/#set-of-immutable-commits).
> I think that has been well received. As you might expect, the set of
> immutable revisions are respected by all commands.

I like the idea of a set of immutable revisions...but wouldn't that
result in the request to drop commit B in the graph above being met
with an error rather than with a single branch being rewritten?
