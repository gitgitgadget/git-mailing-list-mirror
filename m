Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265FA1A4E6F
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725325569; cv=none; b=oNkVveOjiDX5k/XEV8Jg8Z4RZyTY51NMIAYGN4o/AL3MM2EbiK3gTzMh80rPRLq9V57+8uBtNmwa7EyNXhr3aO6QD+gpqQ7Vh8RhyOO6wqatPJS7uw1tdmJuBLh6eH9zBulx7kxKDdORqshz10twcWmiRkrcF4Kv4X08d2UcVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725325569; c=relaxed/simple;
	bh=DZAcFhvCl09GHaWhN9kAGD7RbnBjcPGS04hTwylqklM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQX3EUyDYnO8CtCz9JOrXC+C0lESZ/QqojPVH/SQdMvhnnIZ6yTvke8QJHRab0IiRTv1rZF/R3RsIw5Qlk7P2eI+b/Vn8+XkROJXGkjSE76X2/JMXfZgRfcrQ96pNwfLckyXLhD9kLSTD0VMOsOs7gAdBgOS8t9LSY5cCDoOqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivKLFlJr; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivKLFlJr"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3df02c407c4so2764678b6e.1
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 18:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725325567; x=1725930367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0i5cWb4vnPduCyw4P9tlGSS4J3MEe9UoUm76R4YEO4s=;
        b=ivKLFlJrbqM4/2GOgScrfnO29xjZhSeD75LJhYat1eULtvzeMctwc5K+Jklkpt4u16
         WkDyQvn9HZUFAxnA1488/FTZbOEVMCVhlTodN7JYZ9+xC3blqc3rWQukeJXLw6Kz3VZy
         bLTvZ2v10shwz7JuVKIC/Uu5XRMArwfTujnaHrVZwq1MT2hbFyB1nChfK3ka16049cvl
         +7CtiuAmomcpV5ytHV5R/duWUmJbDF+4S6v+6NFJoyXMU7QZylNRuyKT8driixt3/SJ8
         ehtkEiphHV5P9CuOCVhDmLgRmnDH1VlvEOdjAJhJ0MJqCxpLhzNTb+uWI0SFXuWQGZoZ
         nJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725325567; x=1725930367;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i5cWb4vnPduCyw4P9tlGSS4J3MEe9UoUm76R4YEO4s=;
        b=oL/FQjkTXtNdsIFFQIEoSWFAhHMybTRgKNpxNNb5Luwv55uv5fh90W3VTC4nxwFzIQ
         Q51TpF3fbpRsVrjLQHvyH8ktlScpHD7YI8/wtR27CGcB/sQs/hGTbjza22g9rpnwGWSS
         +t9zlWxpkMDHj2QrMR+PlkssVGYpsRBJ1SmfxEd7rTDWv9zt7P0hRUHpAsWnfFMqSeVV
         6n7QZheKwcyrTnkczcEBwNdCk0S4T1YjwmLRhFQjHl+khSKT7llHtxj2MZuCxt5zpdYK
         bJLzSgCXkoFFcXRakXeZwk7CSn5ZbGVL8btBZqhIqyvq0tp2ehv9s1C7+LLOb5ihaREZ
         bisg==
X-Gm-Message-State: AOJu0YzTNaD9gYJp+z5zblT4zEnyfgzn0147XPpxQjb+MFFgY/v4YH4w
	wAh0Su6djH07EhnkD/J96wuHE4JmVF6y+UJvtDh3YJ64A8pqcrMc35/Rmg==
X-Google-Smtp-Source: AGHT+IEfKRWuuEK4MPKMA1Qbcdy6UVSWxy/TUm5BUzacJPxy4zCAa32h45ed0k3fkysPCYS8poZ5zQ==
X-Received: by 2002:a05:6808:1922:b0:3d5:802c:9056 with SMTP id 5614622812f47-3df21eeab7fmr7813872b6e.2.1725325566854;
        Mon, 02 Sep 2024 18:06:06 -0700 (PDT)
Received: from epic96565.epic.com (syn-075-135-086-025.res.spectrum.com. [75.135.86.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117d9e60sm2143518b6e.29.2024.09.02.18.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:06:06 -0700 (PDT)
From: Sean Allred <allred.sean@gmail.com>
To: sideshowbarker <mike@w3.org>
Cc: git@vger.kernel.org
Subject: Re: Problem: git Notes not discoverable (+proposed solutions)
In-Reply-To: <Zp89ntYaeFUumaTO@w3.org> (sideshowbarker's message of "Tue, 23
	Jul 2024 14:20:30 +0900")
References: <Zp89ntYaeFUumaTO@w3.org>
Date: Mon, 02 Sep 2024 20:06:05 -0500
Message-ID: <m0wmjto8aq.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I agree that git-notes is an under-utilized idea. There's a lot of
potential to add context where it matters.

sideshowbarker <mike@w3.org> writes:
> I=E2=80=99d be 100% happy to do the work of writing a patch to implement =
a solution
> (a git behavior change) for this =E2=80=94 if I could get confirmation th=
at the git
> maintainers would actually be open to reviewing such a patch.

Best way to determine that in my experience is to just propose some kind
of patch -- especially if the actual change is simple even if
controversial.

> As far as what the change would be: I realize this has been brought up
> before =E2=80=94 but it seems the obvious solutions are to =E2=80=9Cjust=
=E2=80=9D change git so:
>
> - Proposed solution #1: git auto-fetches all Notes when a repo is first c=
loned,
>   and then auto re-fetches them again for every =E2=80=9Cgit fetch=E2=80=
=9D or=E2=80=9Cgit pull=E2=80=9D.
>
>   I think that auto-fetching-of-Notes would ideally be the _default_ git
>   behavior =E2=80=94 but short of that, at least a new [notes] _option_ f=
or enabling
>   that behavior would help. That would seem somewhat more =E2=80=9Capproa=
chable=E2=80=9D to
>   than =E2=80=9Cgit config --add remote.origin.fetch '+refs/notes/*:refs/=
notes/*'=E2=80=9D.

This would certainly be the most turnkey approach -- but what could go
wrong here? I can think of at least one potential danger: that your own
notes would be wiped out on fetch if you don't remember to push them
first. Laying out the risks involved with each approach would help the
conversation by showing the effort you've put into the design.

It's my understanding that the git-notes feature is considered a little
under-baked to 'turn on' more broadly like this. There are simply too
many sharp edges:

- the 'push before fetch' footgun I mentioned above
- merge conflict resolution workflow for the notes themselves
- no 'set-and-forget' way to maintain multiple notes from multiple users

off the top of my head.

> - Proposed solution #2: git checks if a clone lacks Notes vs remote, and =
emits:
>
>   > Your clone is behind the origin remote by N notes. To fetch the notes
>   > from the origin remote, run =E2=80=9Cgit fetch origin 'refs/notes/*:r=
efs/notes/*'=E2=80=9D

This is less controversial than turning it on by default, but IMO if
it's not good enough to turn on by default, we shouldn't encourage its
use so prevalently.

> For both cases, https://github.com/sideshowbarker/git-gloss/ was used for
> adding the Notes. That=E2=80=99s a specialized tool I wrote myself, for a=
dding
> GitHub-related Notes which look like this:
>
>   Author: https://github.com/Jon4t4n =F0=9F=94=B0
>   Commit: https://github.com/SerenityOS/serenity/commit/9812031a02
>   Pull-request: https://github.com/SerenityOS/serenity/pull/20140
>   Issue: https://github.com/SerenityOS/serenity/issues/19937
>   Reviewed-by: https://github.com/AtkinsSJ =E2=9C=85
>   Reviewed-by: https://github.com/nico

Very interesting -- my systems use case for git-notes is very similar,
albeit for our in-house bug tracker. Clearly it's a good idea! ;-)

I'd love to see git-notes adopted more broadly, but I think there are
some real problems to solve first. If others have their own thoughts/
gripes, I'd love to see such a list of deficiencies turned into a design
and development plan. I'm no Git maintainer, but I would happy to
provide what review I can.

--=20
Sean Allred

P.S. Sorry for the duplicate email, sideshowbarker; mu4e not-so-recently
changed its default keybindings and I have STILL not recovered from
this, apparently.
