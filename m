Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5422F3A4
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936511; cv=none; b=EmsJWqNNF6jqe1Ap9xqEpba0lz5RbROlRVui1QsaVt2Zk7UdUEALTZ/ACKHx4hs6lZ5hfLKPr2YjDZAEs/AQt6q2jYGEjodt2vSexiz72vCDpV4HsPBbItmgBROdvhubOJQC+hXUIvjPp8wucz8OBjTWEA343NK8jyECSuSDFVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936511; c=relaxed/simple;
	bh=03/iBnETHqKNIYo9SavHPo92ZmbIVDv4n7xWWH3oUXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmunquHfXdehXk/Sk7BfX438pFg88Z2o5SBnS6RbEn8y6njtp1xy+FB3EpwNqHpcOFtU7AquIrz9ySCqA73YaFwpCAzlvW8ylGl2hmbVWauM4yNYjiGidLmR6EFOgOQSnT4yzVW+umB0tw8ldUG3rAK2PmTVhTLGLjYICLLh7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVlFRtUk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVlFRtUk"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e549be93d5eso11783892276.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736936509; x=1737541309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enWaYvRl6UVRVnvi1hZ47+PsqlyB7KklLr9ma7iUaNM=;
        b=AVlFRtUkdFWzXMQ641MMoCDuoKyd0GKQQpkBL8ubkjdVY7ZQZsCAOsTtuNrfn6k+TA
         /2BJfXgNbjXzUhhQlDR9uOazadx7fKVPP8SIgWcTOoTKUoIQ0Fp1cz7VJfqrNiT0zZgP
         mTzX1YsTof9uHzEhUj5tRTnAPvw+vnnbHucNQDlOADSKRwMTceY53itGJnl1DhFzYzaD
         xjMu03pJG6FPpirq1KHP43EPKp2jPpOgizd1gInzEJjiuPPPv3jWrJQFyvma3QOGaiGb
         6brdDBkRhm+s8ALg/cbufmYROgT9PPTO7ej8NUIpAzzI4OABzxS264/i0W2fVjs2ppp1
         bmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736936509; x=1737541309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enWaYvRl6UVRVnvi1hZ47+PsqlyB7KklLr9ma7iUaNM=;
        b=mrj+lxCtpVogW0VBWTNIvtmFWx1k76kZHHtxF3jyKdIP62VeGdMdH0TqA008bYcAy7
         G9XzIrY3CYKKzSIHOlngsZCEbaugHjW8bzuOyn+xUMO+lU4eiXva222JEJZKY5RMMvVW
         Vr1aDawXd+8WzM+9ylpMf79+PYDgZi1PFq46LC54tj3sS4xgzOs9CyOYLtKtDunaqtFj
         2/73CA8TW6aeO3uLHTbjBjqQLe/tuXMhj+pEBHmH0vlHHrKA28am2mkv6hx/Vs0ojF48
         X2KVfX2Kw+8KM0YezOdrKZ8KDB+uBq9W6E/mt8LiiZYZNVAW0yH4xn7fcd+VN0R4eNmu
         /bkA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ESNa/w9xqYb+vjrM+s5NBg2NujQDM4cjXjfbH53OHRR+Zc6h2QLET7gBwfiKONX3Eps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxctY08FubptdQVciGnGhfCxEIDx8Yo2S2h/oGdTkw/ciiox+ap
	sJVxNReDypMwd8gmXD67UdGDP3X+ufmLAeLknMAwPpsGhNOpNKCSyZhksCuKHTgPnBrrBTHRKZ3
	lF8bPd2EVYh+AKmwYOlp9oZRJJxrzD0P1Zwo=
X-Gm-Gg: ASbGnctg+gD84lFOouHko4J2p60ezaxuIo09s8yLFqAHBHtJG2ns073pa32vPKuOU51
	DY0ezWcW/mJ7eGiJOpDbcbgvFBF5v5knPPT/TCw==
X-Google-Smtp-Source: AGHT+IGJYLaoqYWk49iRDLo/1Vx+QRdb+hc/k84TfF5TFUo4T4tamBPFYDk0OgMLV63NRVWIh1ZTYLbWstbimd7EY7U=
X-Received: by 2002:a05:6902:2384:b0:e57:4ff4:f86e with SMTP id
 3f1490d57ef6-e574ff4fa6amr9916124276.19.1736936508977; Wed, 15 Jan 2025
 02:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1852.git.1736933815236.gitgitgadget@gmail.com> <1c220376-4b4b-425f-9797-abd1728aacc2@app.fastmail.com>
In-Reply-To: <1c220376-4b4b-425f-9797-abd1728aacc2@app.fastmail.com>
From: Chris Howlett <chowlett09@gmail.com>
Date: Wed, 15 Jan 2025 10:21:38 +0000
X-Gm-Features: AbW1kvYms_AjKHaY8zLL6j39l-0idlYVWFhJfHhRujE-B2qtyLfoldzJuMrQM1o
Message-ID: <CAJVagJ=3uxcCpEivkpW5_HTxdL9Sa9Ymqm1iJQHUJ+=9XneLSg@mail.gmail.com>
Subject: Re: [PATCH] help: add prompt-yes setting for autocorrect
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 at 09:51, Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Wed, Jan 15, 2025, at 10:36, Chris Howlett via GitGitGadget wrote:
> > From: Chris Howlett <chowlett09@gmail.com>
> >
> > The help.autocorrect functionality is really useful, saving frustration
> > when a dev fat-fingers a command, and git has a pretty good idea what
> > was originally intended. The config settings are a nice selection, with
> > "prompt" asking the user to confirm that they want to run the assumed
> > command.
> >
> > However, with "prompt", the choice defaults to "No" - that is, hitting
> > return will _not_ run the command. For me at least, if git is confident
> > it knows which command I wanted, it's usually right, and the golden pat=
h
> > would be to run the command.
> >
> > Therefore this patch adds "prompt-yes" as a counterpart config setting
> > for help.autocorrect, which does the same as "prompt", but defaults to
> > "Yes" - hitting return will run the assumed command.
> >
> > I have not added any tests because the test suite doesn't have any test=
s
> > (that I could find) for the "prompt" behaviour - I'm assuming this is
> > because it's hard/impossible to simulate the interactive terminal promp=
t
> >
> > Signed-off-by: Chris Howlett <chowlett09@gmail.com>
>
> This seems to conflict with the patch =E2=80=9Chelp: interpret boolean st=
ring
> values for help.autocorrect=E2=80=9D which is in `seen`.  The latest vers=
ion (I
> don=E2=80=99t know what version is applied right now):
>
> https://lore.kernel.org/git/pull.1869.v4.git.git.1736760824201.gitgitgadg=
et@gmail.com/

That's unsurprising, as I was inspired to add this option after
reading that committer's blog post on help.autocorrect -
https://blog.gitbutler.com/why-is-git-autocorrect-too-fast-for-formula-one-=
drivers/

I'm happy to wait for their patch to be merged, then rebase and rework
against it, if that seems the most sensible option? Presumably I'll
have to monitor the mailing list to learn when that happens? This is
my first patch to git, so I'm not sure of process.
