Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D204517A586
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738058219; cv=none; b=YXX0IXyRgxkuJI1vzJFGTimsNmZQDBlidUmtrKul7KyFx+VG4MxJvK6ltbR+kc+g8Dt71KTDmts/oJa3GE9S0B6JV/1aBhTbmz577CnJgRDp6nMEgp9wYOLUCv8knIGMHC//SCNggDsPW4aneDBeNUIuUJJ7UAH7xUGzFqtP61Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738058219; c=relaxed/simple;
	bh=0Aa/Vl7BtondivvTeB41FB2Qh6iQmb/rFZpMjToubEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eFPLaNv702bdnpKNjP8CvwPSf+TJHPwal2W8J7mtvhQk/ZWHf3LuilaMTabPVIX9MK8VAv54ycrIczf5pUypgPPkEHUHLPA+3iFW053h2igJJ1kqe0t+Izyums3MzASeFTN2+R+DPpfL3Wq6B+JMXBer2JxmMNgx6LLT14eJ2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/QuOoxS; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/QuOoxS"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85c4e74e2baso1105967241.0
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 01:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738058216; x=1738663016; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUIq8vEmfw0nIleaeL6dDxqnMSCsfezWdhDhgmeQp/k=;
        b=E/QuOoxSSDYU1Pb9vnOxGC8SkSCzHj+X/lVNOIUkIqVCfBCg8I9oJuBkMGYWLxPe8r
         ojsCq5WhuxsSy9mBouu2LYBIvXnyBojc4Sbd8LIQo02Wjfn/YtAMSGxEWZ16sBkHLsPS
         lTJCVMCGT6AK3uyr4fdRQ2z9GsrN0IuKevaoXVkjstce64se/s/zcdTKDkCN+x1Y0UqM
         1aM5yPIdHQg+cjSibEOhGmfgGQkDBwQhkB4oSUl7gkBT90Rv5Q/kSxy+0ZEUC0uwD8ez
         XopedgLanjUbw20Wy9V7uTBXgeK72sRulADkGwRN2MphYedYBshZc48pZga7TQ8mxU3r
         OD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738058216; x=1738663016;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUIq8vEmfw0nIleaeL6dDxqnMSCsfezWdhDhgmeQp/k=;
        b=kZ1G3QIG/txPytoBb5fB9SCZBuC+dbO5zwP7JiqX8zAaMwhJHRlk/vElg2ur82VJ7M
         E6Ie3DOgB9RnqMEPQ04dzJhVii7rbHR6XE2uEId7P1km1P0PetrvCls6lgQwMqi1x378
         KBA+/FOTfC3umjFYHDRo61VuAjauYiL9a6tyFYi9yDPth84ECB194HMC8Q+M7GsQ3ziD
         0eMv52zgBPbaxDhRm4qhCQMSIXcUqVQHq/Y99WCsfE6hdscIR7ZJtZi1y5uXRVhMWhRi
         2+8/xlgy2yQEqxlbRTzDUqZiGdXxmFJCVHhL3iJpA/RYutxI21LfcMxs3EivtruWNrcc
         xq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+u1Z76innMT8SGd1WFkok/uREWccpD6u4JbFFZEMepfMi+NdP/KtpLKQSIeDQaczRGJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGdbyfvNKw2jD335TwUrR1DxTEAc3O6XnkUvQzN/2D2/aHGwqS
	ipP/9C2FOIbtIPTSXpj0v48KrBcbhc1A26YsO2J8lOVq3C0kCs4LsYKPI/G0xIXIYHMNwj54nfW
	KW7jPta8Vwdcc0F94Ao6mgfF8K+0=
X-Gm-Gg: ASbGncvknpJHFEdj/nU1dui75BEwOmZBfhs3i9mKWP58FHOR+67sgzoCyMxT6mUPCJe
	xYwcWAYdK+G++6939Lb9KJK7Eqd7v0hUGM9DpXGsVvtlqaO3JMheqFawcqnLMU93IQiTuNco=
X-Google-Smtp-Source: AGHT+IFpK0S73ncJivn5YwQbCtPeL0yMziEUsqx60JXbW1xakyIT4MXELxN2oKHW1UotgyIpb2/hOUXs2K6zadry0ZQ=
X-Received: by 2002:a05:6102:d88:b0:4b5:aa82:926d with SMTP id
 ada2fe7eead31-4b690ba90b3mr35227740137.6.1738058216598; Tue, 28 Jan 2025
 01:56:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADfRhQ7Gcv6SB5ZYwdE1HRxkeBwrEbYMu6KcKPRuxWdDH+gZMw@mail.gmail.com>
 <Z5VUxwjN4GLtZHuS@tapette.crustytoothpaste.net>
In-Reply-To: <Z5VUxwjN4GLtZHuS@tapette.crustytoothpaste.net>
From: dev oft <devoft1@gmail.com>
Date: Tue, 28 Jan 2025 04:56:45 -0500
X-Gm-Features: AWEUYZl5GlZjNMuzdtey7Cb_4-GX7vpoCru9z8GKg-zA5-1Z7gtmbQrRld4QX_k
Message-ID: <CADfRhQ4htQ9JWa4ij6b4xQXjEC=s_+gd3_o=LA4u=gNVnyWu8g@mail.gmail.com>
Subject: Re: Proposal: "GitPanel" Project Contribution
To: "brian m. carlson" <sandals@crustytoothpaste.net>, dev oft <devoft1@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Brian,

Thank you for taking the time to review my proposal for Gitpanel and
for providing such thoughtful and detailed feedback. I truly
appreciate your guidance and insights regarding the direction of my
project and its alignment (or lack thereof) with the goals of the Git
project.

I now have a clearer understanding of the Git project's approach to
maintaining forge-neutrality, and I see how prioritizing Git-hub
specific features might not align with its principles. Your suggestion
to explore support for multiple forges by developing a generic
abstraction layer is invaluable. This would undoubtedly make the
project more versatile and appealing to a broader audience.

I'll also take a closer look at tools to better understand existing
solutions and identify potential gaps that Gitpanel could address.
Your suggestion to consider the needs of both hosted and self-hosted
environments resonates with my goal of creating a widely useful and
adaptable tool.

Thank you again for your encouragement and for sharing your
perspective. I look forward to iterating on Gitpanel and exploring
ways to make it more inclusive and valuable for the larger Git
ecosystem.

Best regards,
devtracer

On Sat, Jan 25, 2025 at 4:16=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-01-25 at 19:59:17, dev oft wrote:
> > Dear Git Team,
> >
> > I am devtracer on GitHub, and I recently reached out to Git=E2=80=99s G=
itHub
> > page to contribute a project of mine to the community. During this
> > process, I had the privilege of receiving guidance from dscho, who
> > kindly explained how to open pull requests and share ideas in a
> > respectful and constructive manner. Following their advice, I=E2=80=99m
> > reaching out through this email to share my project idea and verify
> > whether any similar projects exist within the community. For
> > reference, here is a link to our prior conversation: Git Pull Request
> > #1877 https://github.com/git/git/pull/1877
> >
> > The project I am proposing is called gitpanel (a working title subject
> > to change). Gitpanel is designed to provide a built-in terminal user
> > interface (TUI) for viewing and managing Git and GitHub accounts
> > directly from the terminal. The key features include:
> > Profile Overview: Displays an ASCII-styled version of the user=E2=80=99=
s
> > GitHub profile picture (similar to Neofetch), along with their
> > username and email address.
>
> I think this sounds like an interesting project, but it's probably not
> appropriate as part of the Git project.
>
> Part of the reason is that there are many different forges, of which
> GitHub is only one, and we try not to prioritize any particular forge or
> implementation.  From the project's point of view, we consider it just
> as desirable to host your own source code using a simple HTTPS or SSH
> server, or using a self-hosted solution such as Gitolite and cgit, as it
> is to use something like GitHub, GitLab, or Codeberg.
>
> With that in mind, a lot of the functionality that you offer here is
> quite specific to GitHub.  Pull requests are not a Git feature, although
> most forges have them under some name.  Similarly, Git doesn't have the
> idea of a profile picture, or even a profile at all.
>
> So ultimately I think many people might find your project useful, but it
> wouldn't be suitable to be within the Git project itself.  As for
> similar projects, I believe there's tig, which provides a Git-related
> TUI (although I've never used it, and so can't speak to it much more
> than that).
>
> A suggestion I might make if you want your project to be more generally
> useful is to support a couple different types of forges, possibly by
> creating some sort of reusable generic abstraction layer.  For instance,
> I'm sure GitHub, GitLab, and Forgejo all have profiles, so being able to
> work with all three would be useful, and if your software also supported
> the on-premises versions of these forges, it might be useful as well to
> people in large companies and universities, which often self-host for
> various reasons.
>
> Part of the reason I suggest that is because even though I do work for
> one of the major forges (although my participation here is in my
> individual capacity), some of the open-source software I use in my
> personal or even work life is hosted on another forge (which I'm sure is
> also true for many other contributors), so being able to use the same
> tooling that works for a variety of forges is helpful.
>
> Best of luck on your project!
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
