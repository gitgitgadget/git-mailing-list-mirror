Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2581E521
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233461; cv=none; b=Pd6FEKPY4gJRWqFCT84E0Pdk7SAvt/Zb26Vwo3xlpOn/SRKHFaVqlW7XGQLNidwjKIWYvRgywdnBTmToYhQoz4R/I1fJF0jNl/aU+fMDx0EI+IX5EtDI3PaSbuYnQvy98lpxEkJxcv2RYrW+tQ9s5P27gwYL2SD3JZ7GHdOdheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233461; c=relaxed/simple;
	bh=cy2HpYTSralTg848GTva4z/KxtAWDbWbGGymYVCTPfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYVoYC55BD9isIgumnFGqUAPel4l0nSk0zYsB8sSTC2cibkwcFlCjPORScrj5oOi96VaG3I9r76WPL9mboU7m9vXBjt7xjFJ+laXP84GaSPdZKlh0GKlvAm6xHlDn0UCOPmUjZXx6H1ztW917FBndtgyYqN3gBXIHlC4Et36smo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcVTwn+F; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcVTwn+F"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3beab443a63so4428294b6e.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 07:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707233459; x=1707838259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0adi98HX4Ci9dCy7gNy8af3miGt/Ev/DR765HIZVTE=;
        b=NcVTwn+FP8g3KrGytZVda20IR+qyH6I84XoJDqqjTIlOMy1bctlK0Gs/2lsgne0sGC
         68p37zxTsIWJTyvosf2u65SirfCXLKKy1r3dJs/R245rzntYbgln4XTxNcWRoNlNb5cb
         CiR0cncfmiiS6q0mq12Hj1SXABZBgXUMfSR1RV2SEw+M63FPEvrVoKvp3em6MTOIL1KP
         U5b1l8Wec6q0SRsern2eBxnuqksouLoN3Aov5/LvATDvdCZtzg0r+MLOtj/VIvjIXs7/
         6mTCxGth9IXQD9dl/8hJENOBlli1JJfHOlJO+p840a5ndeYD84jst6rn78z1hw6DFQwT
         wUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233459; x=1707838259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0adi98HX4Ci9dCy7gNy8af3miGt/Ev/DR765HIZVTE=;
        b=jUO6crbbxg34a6gfPnXIRvPJyK7Cgl0hqPv4XtBrhP3Tu/DwQEK0JwR6tyk8Cu5SZF
         zMhh7jC0EJGowja4dJ+EU46PsvCi1nelgCLbb8PMN1abia0QUqTbkqkctaEX/coE1yuD
         5VZg3qryGBWLWX9K4+09TU2zMwnjVCUgvnkFGK5SXlSGSz/0EeS/79jmHVLyuY2Em2sc
         9d97qxap8ZSQn3uPoaXJyoWgEvFOByxAPEoFJiqXksQjBOFkztwQXhExbFBex9Avy46b
         pPEJef+xihSv16R79oIvPxKp9Yr+jEiD+ZNiKvkfibWkgaA+r405F7haAKvdcwsWqpnW
         K1zA==
X-Gm-Message-State: AOJu0YwlPqtCbNHFQ6nrh3U1h2TdZGydCaSjmbGgZ4TvOg43xCKcH5Bc
	VikbYdTi6xtXx5GIQD6J4gkZjEWZp8EUqm/bh4GMCt2JgjnqeD54W9+WO2ThJwFKbh4Dwg/qQ1J
	s8Z6OrW8c36f9e2pIlzBgvWXvd/JBTY4DOKw=
X-Google-Smtp-Source: AGHT+IEKCVYyFp9tvZcriNz4MHjaVbmEHH0TnGn9dj77hh1bqT+BA1q47ruyh8aFl6odhNPpkMpppUxtiIj1rK8EpCc=
X-Received: by 2002:a05:6871:3a14:b0:219:570f:31ca with SMTP id
 pu20-20020a0568713a1400b00219570f31camr3187269oac.9.1707233459073; Tue, 06
 Feb 2024 07:30:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com> <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com> <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
 <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
In-Reply-To: <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 6 Feb 2024 16:30:32 +0100
Message-ID: <CAOLa=ZRLuy2H-r3A0BE-mS4Zm=ebhLR+SemZ3nAghEnRB5dR_A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 6, 2024 at 2:55=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Karthik
>
> On 06/02/2024 08:52, Karthik Nayak wrote:
> > On Mon, Feb 5, 2024 at 7:48=E2=80=AFPM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >> On 29/01/2024 11:35, Karthik Nayak wrote:
> >>> When the user uses an empty string pattern (""), we don't match any r=
efs
> >>> in git-for-each-ref(1). This is because in git-for-each-ref(1), we us=
e
> >>> path based matching and an empty string doesn't match any path.
> >>>
> >>> In this commit we change this behavior by making empty string pattern
> >>> match all references. This is done by introducing a new flag
> >>> `FILTER_REFS_NO_FILTER` in `ref-filter.c`, which uses the newly
> >>> introduced `refs_for_each_all_refs()` function to iterate over all th=
e
> >>> refs in the repository.
> >>
> >> It actually iterates over all the refs in the current worktree, not al=
l
> >> the refs in the repository. I have to say that I find it extremely
> >> unintuitive that "" behaves differently to not giving a pattern. I
> >> wonder if we can find a better UI here - perhaps a command line option
> >> to include pseudorefs?
> >>
> >
> > As Patrick mentioned, this was discussed a while ago and we decided to
> > move forward with the `git for-each-ref ""` syntax.
>
> Thanks I'd missed that discussion. I see that at the end of that
> discussion Junio was concerned that the proposed "" did not account for
> "refs/worktrees/$worktree/*" [1] - how has that been resolved?
>

The current implementation (merged to next) prints all the refs from the cu=
rrent
worktree and doesn't support printing from other worktrees.

    $ git worktree add ../wt-files @~10
    Preparing worktree (detached HEAD 559d5138bc)
    HEAD is now at 559d5138bc Merge branch 'jc/make-libpath-template' into =
next

    $ cd ../wt-files/
    direnv: unloading

    $ git for-each-ref "" | grep -v "refs"
    559d5138bc8b81354fd1bc3421ace614076e66de commit    HEAD
    559d5138bc8b81354fd1bc3421ace614076e66de commit    ORIG_HEAD

    $ git rebase -i @~3
    Stopped at be65f9ef88...  t/Makefile: get UNIT_TESTS list from C source=
s
    You can amend the commit now, with

      git commit --amend '-S'

    Once you are satisfied with your changes, run

      git rebase --continue

    $ git for-each-ref "" | grep -v "refs"
    be65f9ef88ff741454dcf10a0af6e384d0bf26cf commit    HEAD
    43f081b9c7dfb9c23e547ffee1778af0f30c5c4e commit    ORIG_HEAD
    be65f9ef88ff741454dcf10a0af6e384d0bf26cf commit    REBASE_HEAD
