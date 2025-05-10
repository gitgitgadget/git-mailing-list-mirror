Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1677A219E4
	for <git@vger.kernel.org>; Sat, 10 May 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746904401; cv=none; b=tl6O7kKX/ZF8oN2aFyGORArK+XlCnSBXUiEU6coSVKEtzUhOxJEC5ALQ14RS7lhq/S1+RzUsRA83uTCMeFITuGFPaJfIOUF0+w5yfC8VTgc33cyotN+5hCtNiw5l3oqFDJLYHGt4KBI9VuHyeX8S6mPt5Kg1G+Bps9K8Y6PBYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746904401; c=relaxed/simple;
	bh=5DRKjciymZ8ul56E+Gw5z+wAnL8K4VVD7aOaSgF8kQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BTefMw6DBrsGThJfh/scylYVEjlklmpbIQTZah/EEmvewncVPomNXVd2IjkCWWnUhTMFKKyWq3QCAxmRH+1cjS5unIqSYpEsVj2OnWeIvnbjOE7hiZSchpx59yNQ4S3OF/G1Wy8MUi0EYXNom//K8yk7++F5+tS0b7i2IsAyyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzG8KNfZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzG8KNfZ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad23db02350so119643666b.1
        for <git@vger.kernel.org>; Sat, 10 May 2025 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746904398; x=1747509198; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/6fpN4VeUXJIGa8SlXopTRso/v2Bb8otXgOzwuJHOc=;
        b=KzG8KNfZ3ist7Oj8zfZApj1RkTA4Rx2sn3pEn8QuFtvE1h00KUsFQIu6yuSoXi8MWD
         MXyJlV6r6EACqJ6hSyml58FeDCHqOuOGUX/U5qVnvsxv+HHSm29kdROMg4x0Dl3Ug8ux
         ZTycEEQZmAea1fo/95V0fNePP/hp5CPkP40/2RiccmHIPDhIAhXTFrP9gr6jFMT8+08O
         V0B7sfHpQOiRLKciH7gqIleQm+kaG+thZ6wcquXpYkj+586/wKOaQo7Z1OAFO6fZ4Ytw
         /hw8lBUNMTVrP1OeET5QFe21WQjnDwjTCGaIsLMlKs9Ouy9+lKpEwWGjQe+h1Q9dy7Ie
         9z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746904398; x=1747509198;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/6fpN4VeUXJIGa8SlXopTRso/v2Bb8otXgOzwuJHOc=;
        b=hzRBlCgHd8v5wTTpgBWtp+4eTl9p2nmeaHuaQ9l06PMeoumomVeVN/0Mi2ewknsibo
         J6kN456L39SW0sLpLs6H1kPyEKSMoYMu7VQj4ixPlg6xedw9pLtwj/YdDu8EWFGYs+tr
         hX4YbhXhn09N5/pju5uea0HDyrNpSpAst0TeGY0Gt4Yn3V8F7AtuZ21TaTfxbohe09nb
         KWCQJjMXTmG9cyZHdCwCztgxODV/LNs9sARAw5HLBtS8mDvrSJ2cImfBywgmD7Of/tK6
         X2L5MZcaDB3DvoY2MNXMTchHHNOCvh9cFqYoMBfWboEZfcUC8Nnfsat8NB6nnrEURH6k
         ZBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZttFdJIib1hdPaA1/gwCS77iJtCvl+jkPqL8zqzCHtIhhH8QAbPBAzWqDrxioJGmeSRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1w1jNzKKdS6K3Czpd8Xg6Zr4GwjeN2TmPjeAdodNBhmHg2DIH
	W8v1YcI0Pt17G/hyU71u2PyKBLZyH/g9Q99cQom95NV8KAkL0b0OUrVLcTkLn2XmLxmFWvWY2z0
	ARfiWKUoLfxSLe6FrJs71qVnYSnQ=
X-Gm-Gg: ASbGncv53DYEoBYhWP71F7eyPbT933R5dJdLnA0IzekDon+QtDH0lpMvr9pU/bxF3Fd
	HUAX/fWqItaRzBLnzEfMuNvf/OQPAfFosgMSBu+wDjA0tL2NUvOlacvDVdXO18k76YVkUfe8Owa
	IuxBp8V90rJSvj0UHKAVMDb9dN2LSs3NWifmyssxSuC987TR4xzK7seiEvPK+Gt6Dw0Zbnx3Tog
	zYt
X-Google-Smtp-Source: AGHT+IHklweZ/N/hLyoOBklIDq8AWniR45FlASNmrOdUdfUKfO1aSfrJ1HTsblKE9tgRK52sSy1tGEYhsyJkTPeptXw=
X-Received: by 2002:a17:907:2d9f:b0:ad2:4788:10b9 with SMTP id
 a640c23a62f3a-ad247881a50mr56845566b.33.1746904397945; Sat, 10 May 2025
 12:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <CALnO6CDDrd=XpkkTFYfAoiNcoG5q83Z8c+Ey4jKTBriA=M7TwQ@mail.gmail.com> <aB5iUmASx7BxgbAj@tapette.crustytoothpaste.net>
In-Reply-To: <aB5iUmASx7BxgbAj@tapette.crustytoothpaste.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 10 May 2025 15:13:06 -0400
X-Gm-Features: AX0GCFvhTinWyS4AmnE8cfIbNUggv68hn4pw5tcMHJ9qX976G8ZL5I_NP0XkThY
Message-ID: <CALnO6CAeVzh0OhjD8CkXKEydP4SNkCODfmirMYvzG8xEYXPA=Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Importing and exporting stashes to refs
To: "brian m. carlson" <sandals@crustytoothpaste.net>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 4:15=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-05-09 at 16:53:17, D. Ben Knoble wrote:
> > - Can't we "git push <remote> stash[@{n}]:<branch>" to share a stash so=
mewhere?
> > - And then, doesn't "git stash apply [--index] <arbitrary sha>" work?
> > (At which point you could presumably create a new stash, though I'll
> > admit that's cumbersome relative to dedicated export/import.)
>
> I haven't tried, but it does certainly seem plausible that you can
> import and export them in that way.
>
> > I can see how that doesn't help you quickly export a whole _chain_ of
> > stashes, so I'm not saying "this series seems like the wrong tack"
> > (far be it from me, who doesn't understand your use case, to say
> > that!). Rather, I'm confused about the inability to move a (single)
> > stash across machines.
>
> Let me explain the intended use case here.  At work, many people use
> GitHub Codespaces, which are throwaway development environments.  Since
> one's whole set of stashes cannot be imported or exported, it's hard to
> use stashes effectively in such a case, since they'd be deleted when you
> destroyed the environment.  I like stashes a lot (my personal Git
> development repository has 153), so I want to synchronize all of them
> across.
>
> The other case is people who routinely work on multiple machines.
> (Remote or throwaway development environments, like GitHub Codespaces or
> Devcontainers, are just a special case of this.)  Many of these users
> want to keep their working tree and other state across machines and lots
> of them rely on cloud syncing services, such as Dropbox, to do this,
> which often ends up corrupting the repository (as outlined in the FAQ).
> Providing a way to quickly and easily synchronize the working tree
> across systems, including any stashes, is really important to encourage
> best practices that don't result in data loss or have unpleasant
> security issues (such as untrusted local config).
>
> > Unrelated question: Can we import arbitrary refs into stashes? That
> > is, what happens if the commit structure doesn't look right? (Maybe I
> > should go read the tests and see.)
>
> That doesn't work because the commit used here has to have a fixed
> number of parents, since we need to keep track of the index and the
> working tree.  Stash commits, even the regular ones used in the reflog,
> always have to have a certain structure.
>
> If you try to do that anyway, you get this message:
>
>     % git stash import HEAD
>     error: 3bf235c35ef51d01663f2ab9665026b05b8af1dd is not a valid export=
ed stash commit
>
> I did try to avoid people accidentally destroying data.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA

You've answered all my questions, thanks!

--=20
D. Ben Knoble
