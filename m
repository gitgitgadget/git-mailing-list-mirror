Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBE72612
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754151262; cv=none; b=sA3pLo8tFXLTjfFMpWEWEjVv3az8owI1ft1A/tAwCzd7j1sGLo3LI0V4/AacFVGbJeY1X8Dlgm3WpJV6GEXKxvA20BnLa1V1f9CuZoeF4im4CQIcnJAZkUFm/hA+4oDRQRXJ7IURX4UGfDEm/epvG4PIrbqHLyHBVk2OKJ+IUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754151262; c=relaxed/simple;
	bh=kPurcfjxZEtDUzdtyVXPUfHmq3opj9nkQI307LMf924=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+yfyDuT72EVgqD3EdPh63RTyOzDLTJhjg0qlJxgHQox5PWGk7YtBF7zw7sW34DJ3+3NDDUfnSEGYRSI7D18Y6wtS0iXbxM2XtuznUEc4eSm79J6mP/WNzN87pSo57nTbkwD32o7xyJmU7uxiJbmB5hNO8gyfvLdiLoIkg6ny+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0KnHoHK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0KnHoHK"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so3871288a12.2
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754151259; x=1754756059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6YJbn17rB0igGa3lekdqNc1HqR0q0PCTw9vXsLmX4c=;
        b=i0KnHoHKb3YCs7J3sM+YhG6rCHpwT+hkEL6STf8QlzS+sv3bi1ix31XEwOkFz0lCAx
         FxJM4XIMYeKAKRvaVjC9bLHsnWa+zRkafrC/jyZqKS+MqV1Hmz7XCST9b00hSVC0JBCb
         D/IzqzSfyAnX0pGFL7Pe0j7Xo0NJ2RjUEeoCiq/42aX+vJE2k32nctmc6xC5AOt19WVk
         QZIdj5oHBEuFwmqyS5AGwGBqySkHO2QudvHToyivY4cPzAOfdpYi0JU94HS3tUOyAfg8
         nx59Fj6PhFriOTfX4jgkW6OoFNWjWrGwaqWeNY9T+6lOueq57InxBDThAWcPKYOMy8s1
         KvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754151259; x=1754756059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6YJbn17rB0igGa3lekdqNc1HqR0q0PCTw9vXsLmX4c=;
        b=d+yKL3I78iPQG6gFMFyyyZnKDCo+qhfYSK6wMWECea+FoIhvnGyynByJvN6cKjXng8
         EF2pEG5ONuUpweso/0YcDLCocn6wSdYwkVoBJG7q7azR7bJvvIb/hB/SsZ5aLe2NBxTb
         m/lRGQtKO4uzF1NhVTJ1oAWnxzNZUZrdO0APpnA6ae64bsFhEUi91lYXtuvJ7PPTnG6i
         l+jDzU0V1jAAKmQLxzd/D4Z9PuV99I0+pSXsoZUR+XLtRgL4xWEE8rfViK0rcy704oS5
         XX4ANPql0OzIueI7HtdHY/Gqfg7FKw/x6eC61dV5x6oP7oMhocgFBkx80g09fKowc6ER
         c8Nw==
X-Gm-Message-State: AOJu0YzUB+IkoJ/umeLS6TSRWcqKCzIw380cC+mgDFe7lVkv0CX6EOsk
	rBDgYqVZZ428jqIkrwNlB3BzF11aeLMDYXfcMJ1efrRWS6e5WEWskscVN5Im13MDDOmJGVbIKkh
	2KBd5W81EAyvzsmf8zNomjunS6wtFu/+zBQ==
X-Gm-Gg: ASbGnctz43pseLTfDHspidb/Eb1gvNb2EXYTeb6D0nsvqwW20EclQBDlYl8/gPfCvMj
	EvVGYhQxdvThVS7e32KQkRho6uzhjYoYEQPNs0tR/MhZQShZNE6PoTVZALOLplOIJLLR9qQnbo4
	PU9D9wZt0+13giNM+tJ9eh4jCUIOOBEDbo33NLnSbGgszLnr9U2hOn+NnFq0e9mm/ypBF0TVQZU
	6dFBbSomnfpU4wnv6aSKIiNc7uRgKG4YpOx/xsrDw==
X-Google-Smtp-Source: AGHT+IEbPl7ZYIVOwIlVYcjvN9hzkwBGMkO92UzlT8R2EtbrZGRXYWHIa7OOaQ4qt5fmhRuIJBCK/MxhoeeUKBKbAls=
X-Received: by 2002:a17:907:1c12:b0:ae0:34d4:28a5 with SMTP id
 a640c23a62f3a-af93fd6a710mr409358666b.0.1754151258798; Sat, 02 Aug 2025
 09:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
 <xmqqv7nezdw2.fsf@gitster.g> <CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
In-Reply-To: <CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 2 Aug 2025 12:14:07 -0400
X-Gm-Features: Ac12FXy-AsE1iDwtQhkD49hYSsu7J76RCj66K6mW5qSnPQycE0XfJRHLIDr5ZMY
Message-ID: <CALnO6CDgjmDd9kBCLzjb=JS6Rqg33aXesjthr_Q=HCA-ru2k6g@mail.gmail.com>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
To: Junio C Hamano <gitster@pobox.com>
Cc: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 5:49=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Sat, Jul 26, 2025 at 8:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> >
> > > With Git 2.48.1, I observe the following behavior:
> > >
> > > - "git ls-files :^:Documentation/RelNotes | grep Rel" yields
> > > "RelNotes", as expected
> >
> > It is deliberately confusing to spell ":(exclude)" as ":^:".
>
> What makes you say that? It's documented in "git help revisions":

Er, that's "git help glossary" for the quotes below=E2=80=94woops!

>
>            A pathspec that begins with a colon : has special meaning. In =
the
>            short form, the leading colon : is followed by zero or more "m=
agic
>            signature" letters (which optionally is terminated by another =
colon
>            :), and the remainder is the pattern to match against the path=
.
>
> and
>
>            exclude
>                After a path matches any non-exclude pathspec, it will be =
run
>                through all exclude pathspecs (magic signature: ! or its s=
ynonym
>                ^).
>

--=20
D. Ben Knoble
