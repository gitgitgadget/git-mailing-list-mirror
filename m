Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7932E8B71
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737993; cv=none; b=mFRvknmikwnAY7TeXB6zVS16fZPG527uHqAWHYd3cTYO9cHA4CPQ7X1lVvbKowUmw+PiZxwki0g+pYN7031ZnFWLMP8jZhoQzk/GJgWeND3dKP4+BERgAsaDar687LOnKgv++0FypXosJsibV/45D4NVB6JgBRhcReeFwmG5b74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737993; c=relaxed/simple;
	bh=a2v8wtQ9LyeQcWjVr/yleXFyJkBAsrqimZyneyrc29o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEDQdnWxgm0YCcYRZfYJ8t15t56ceP40ZJNE9QohE+50Sd2n3OE5xfLLLaPtb2LVzve4MSGxIVVncSqsbGHxLiasi+ySe7vtNSBYGJaL4/dlJwareBEB+6L/ZNZgObXI+vlogx0UojV0cuE1iLWrEtK4IdDqZCeqwYrEjLOKfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8y2FtUH; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8y2FtUH"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9412edb5defso383277241.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 14:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767737990; x=1768342790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2v8wtQ9LyeQcWjVr/yleXFyJkBAsrqimZyneyrc29o=;
        b=C8y2FtUHxnxrId5inK94Wm7GrFyNofbC3WOAmXBVTTV3etHjSUwuIrgbnZPEhBRz6K
         WBKxcGxJpBxDaK4fv7FGwAwOkgmeytF7YqvkNSYZv74zelrvijZGkRM6mMVl2RRKgTT7
         mmeaDxtyr3vb2K8brxW1LrT2zQTCjS6Vtk3u5gAiUatoUmPgdLa0xtjtaqZxZRmJ7x5W
         d+WHOOIn4QsUMEfdiOUqgDtShVP3w6Az8T60qa2DP41g8Bje4Mta/tYVnDU04cRbfm7a
         dCzGXswKIRAGlx3jFMuf2c5uY5jwuCHTeKRcMKmH7Kr64N4G97c3lPMNsogicHqhMDrs
         PFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767737990; x=1768342790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a2v8wtQ9LyeQcWjVr/yleXFyJkBAsrqimZyneyrc29o=;
        b=OzZHcs2HxnkxLspy+PPc7FNXDY8W3OSvis9IUTOUO8GFhpQMArwktPrIYtkGfonzEb
         c+n+L4H6yShSAXceGEvB/VkoZMGsNlQFr2l1H9xQCuNgFuwcQAEmj8VakA8JOtiT9v6L
         yPMiUHs+I1LK9vnK+ep8j5gXYyPHyxff8N62U9qkLN39LhOBk51jf4JpJhkmZATugE0o
         lQ9U+Qw89iX5jbTM4TPP8EMYg7y8eWXtQRUsC28vFXGy9fdWdn/GMWtznwM0HV4GuBcv
         GUV9YEbAbu5vyGpUlVJgDjL+plTFns9NAqbAppxMhtXKoageNMggmp5mo5HcR+Zs1EvE
         iUoQ==
X-Gm-Message-State: AOJu0Yz8W3GFOfTNidA/PXiAdZnRpdDZ82SMoWHbAnjE9xKu4gBjfhMn
	7eDvu1wGZhQs8iOvy8B1tzWfwCGyWjQX90pGMs5toPlc273P9tsJtXHqbMNPf8tfOYBNkuDnEvh
	Jm2ULZDbY72qEM81f6vNcq5o6x7tNp81l8WP5wOo=
X-Gm-Gg: AY/fxX6CbjZEcLm+Pz5E8dP0EEVNoP79Qtrt8Q/IDV7h4tL1bo0DMveGE/kgBW8mknq
	VBufzzpSygWQ193sEY/JonJ7wqn2OLKnGCveM+1PK2o6TeE96Il/tbvnlAJLig49KIA2D2ma/ok
	k9Bco5NUk5YgBBrK8zJfCgbFbT3CM/ZZOKsy33WZe7/EvqtbcIJDSPGl07bk70BnElSlgtN8Hsd
	vMR02Ve6E+TG5aWHdJYHV3TO9Kes1fZKLc2QIIkWS8tqzyCJzf0Bo3za5A5krhgKVH7JLn+ceXR
	xPzKsw==
X-Google-Smtp-Source: AGHT+IHE4LJKxdYEdgGWXw61i2KB2tpkkei2ZoIO9NHtw+GGNyNqA73ofQbULuMtF4IlrcNvPvssdeJsYVeXukiNXjs=
X-Received: by 2002:a05:6102:dc9:b0:51f:66fc:53b8 with SMTP id
 ada2fe7eead31-5ecb692ea6emr132864137.25.1767737990106; Tue, 06 Jan 2026
 14:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVz5kf6eLsMZ6WQQ@Adekunles-MacBook-Air.local> <54e48ac4-7151-4378-b95f-8f22279d6761@gmail.com>
 <CADYq+fafH-cwc7Ego1fDdNRgSnrOeGzCz_vCqszajVYEx1FV-w@mail.gmail.com>
In-Reply-To: <CADYq+fafH-cwc7Ego1fDdNRgSnrOeGzCz_vCqszajVYEx1FV-w@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 6 Jan 2026 23:19:50 +0100
X-Gm-Features: AQt7F2pGQj6uWZOyh46kWM1j_o9_3dHROgFaVCeWHHFnZMY6t8Lfz47-aEAyH9s
Message-ID: <CADYq+fZDyJWzuJ_DZUc0-uEXJnJc-3mjg=xecaRZ+XqOF1zd1w@mail.gmail.com>
Subject: Re: [GSoC PATCH v6] add -p: show user's hunk decision when selecting hunks
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:02=E2=80=AFPM Samuel Abraham
<abrahamadekunle50@gmail.com> wrote:
>
> On Tue, Jan 6, 2026 at 5:10=E2=80=AFPM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> >
> > Hi Abraham
>
> Hello Phillip,
>
> >
> > On 06/01/2026 12:01, Abraham Samuel Adekunle wrote:
> > > When a user is interactively deciding which hunks to use or skip for
> > > staging, unstaging, stashing etc, there is no way to know the
> > > decision previously chosen for a hunk when navigating through the
> > > previous and next hunks using K/J respectively.
> > >
> > > Improve the UI to explicitly show if a user has previously decided to
> > > use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> > > This will improve clarity and aid the navigation process for the
> > > user.
> >
> > I like the idea of telling the user if the hunk is currently selected
> > but say "(previous decision: use)" makes the prompt rather long (some o=
f
> > the prompts in the tests below are 80 characters long). I wonder if we
> > can find a more compact notation. "(currently selected)" is a bit
> > shorter and takes us under 80 characters but is still longer than I'd
> > like - maybe someone reading this will have a better suggestion.
>
> Thank you for the review
> So I previously used selected/deselected. But Junio was not okay with tho=
se
> choice of words because they did not clearly tell If the user selected
> to skip or
> or selected to use the hunk.
>
> But how about
>
> Stage this mode change (you chose: use) [y,n,q,a,d%s,?]?
> Stage this mode change (you chose: skip) [y,n,q,a,d%s,?]?
> Stage this deletion (you chose: use) [y,n,q,a,d%sm,?]?
>
> or
> Stage this mode change (choice: use) [y,n,q,a,d%s,?]?
> Stage this mode change (choice: skip)[y,n,q,a,d%s,?]?
> Stage this deletion (choice: skip)" [y,n,q,a,d%sm,?]?
>
> or
> Stage this mode change (use: yes) [y,n,q,a,d%s,?]?
> Stage this mode change (use: no) [y,n,q,a,d%s,?]?
> Stage this deletion (use: no) [y,n,q,a,d%sm,?]?
>

Also "(you chose yes)" i think is an option also.
Stage this mode change (you chose yes) [y,n,q,a,d%s,?]?
Stage this mode change (you chose no) [y,n,q,a,d%s,?]?
Stage this deletion (you chose no) [y,n,q,a,d%sm,?]?

Abraham.
