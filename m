Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE9287518
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766099005; cv=none; b=hO4cjK4BfeEpz54UF1sWfjkZV5HO3ZwntlqhvA8lO4JfCWD5bt/8tQ6EWLYgGdnRd+g6dpL2mDOPXujJR4sUKDYDyF/qcm5UQw6mldTi7KwvDBpluvBtqLVV9C3AlaCEU0sBIeYoD6kFeZ4gz5TG77paMXRUPArDoUjCBAmjXbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766099005; c=relaxed/simple;
	bh=rGj2H/RVIqWgesJ0g/v/a9Q9MLJUHZ4N8M5eIPdVge8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njTQ/oajja7qMaWKI4+6ho1GDOmWKvmHFI3NcB1cqzrv0nEJg5G3nVk3DFBUUr38UHmBbP52hYuegtqkq2MUR7hBynbJMwVVk+jgq6CfCunj325QvTL+qQ1Ya9xxHhSVvl9/XYLL6xU3i4FdJ4lyr9vY2VAylUHaB8lidbNHBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT0N9Bav; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT0N9Bav"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34abc7da414so1046700a91.0
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 15:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766099003; x=1766703803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxRLfXSVt7UVlO1gEaYb1lyqgYiVuQ6tzqikWm5GtnQ=;
        b=RT0N9Bav+gz/gO3JEqc0lEpdWnvb3kCgoJ8pPzH3eQXO67JYbhb+5cS7N+HAbK+Igw
         /OXMJoFobePq1j2IYmSJh4dIhsi+1HZ8JdiL5I6Ax7oJZ6AK0jq2EWVjCHEv12L4OTrZ
         CwuZ+jLHr+Tj8xFmYNi9RyoDeSY7Fr3bd6NjGhsMLnzRltjZrAKWHCtVJbg4Q8e//DV4
         LoZZ30r0JoIRIJMu90iVa03t9vWI2lhAoXr71JI9fPmCtlKNjLF15RELs6Xo32eotzAh
         QEX89Rb/AY7kmpJJp2osZxbJHOeoKiCDzGt6p2Qu8gwB5hqSOjEkrTOv8JZQIkIBoYPR
         dNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766099003; x=1766703803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SxRLfXSVt7UVlO1gEaYb1lyqgYiVuQ6tzqikWm5GtnQ=;
        b=hium/2fH0UzSrYpU14agBFayPkBHhvymS3p5md9e5zd+i48v/VYp/iKaDyxQR8tTSm
         v/vAwQzkS/U/QkiSmMY57ofzlTvzjFz0zn8gkgY7yWqb7YvebSIfMmCksSXheYySWUIf
         /xRNtSeXst6hXZ+4wlQAMHCGNsyVvbrx0j5Y2IRpIwufErBTMmDQ8128hjzSUXFEiHdm
         W+HMfKQ8CV3h+lCU+5b41MhBm2DWw3A+kKez1gD+NQ+D4ULy3AAizdfyibJudyC3SR2b
         KBY77n67PpQINERDWcveXkGfJZ8XMMuPWuEz2aOD5rhDrLivltarbQgO2RCI/YIWR2/A
         mU/Q==
X-Gm-Message-State: AOJu0YxrrKxKoK2ZsuL9KGrPbL9hUQZMjE5vD8Wf3B1LxdixZ8NvI7ip
	hj6SHSf5h/tTi9JMkAbxURV8ih4SrrJ77U564uddHA3dlphGwkbXZgZltwiuoQNc7UyHpl3UiCW
	u3AwR10e+kaqWHHt7CXBluX0f/ef65WI=
X-Gm-Gg: AY/fxX6tDoCIq6MmemtC7Mm82XBWMANx7sj/lUeRIFK+FmHvpLnBh1QGKhCK/pp2EoX
	ItHw6ezvS2YfbMpXrGxHG0ZNaGOz8YLwLRAiWEvVvSEmqGYMDaHg1aiwBgdQaW9Qw0AuisAlP6D
	a1cCn53LqfeoOFFBW8QFxGrfiBL0akhR8DUm5UAF9+/ZxlrX/tK05kCc2McYrIMThcxieSEUFVe
	5JRolAKLLb/qjFEi1JboqZPj/CMzVpekqaENHSjNRI4x/PskUsdvWWOy95S8pjMZzMIoeprVUBx
	kkD/SDc=
X-Google-Smtp-Source: AGHT+IEYwADsgRMWZHnKV4oYS8hox9uM+iMue1w0pEuIia3Kzt9O8ZvVrD3IzFXiMt6aTaqyPcVenUkI97a0C1g6lC8=
X-Received: by 2002:a17:90b:134d:b0:34c:aba2:dd95 with SMTP id
 98e67ed59e1d1-34e921c700emr749720a91.26.1766099003365; Thu, 18 Dec 2025
 15:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM0PR02MB44500013C2F28CBBD99A113EB3A1A@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <CALnO6CBt7Z9bRhOzci8S+QndYUQUEszYHxfqHqiHkTXQ67ptsg@mail.gmail.com> <AM0PR02MB44504189178BAD0CB6FA71C7B3AFA@AM0PR02MB4450.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB44504189178BAD0CB6FA71C7B3AFA@AM0PR02MB4450.eurprd02.prod.outlook.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 18 Dec 2025 18:03:12 -0500
X-Gm-Features: AQt7F2rj2mYVlPZyY2qkCoXjhQtCuKhHyVnH2xtxJYXDrCUtYTZPcPjVCrCz2z0
Message-ID: <CALnO6CBEYaOrqiWTe1HVH=0qEHa=M0CrYwtW68Pe9bMSiXG-5g@mail.gmail.com>
Subject: Re: Color remote repository part of a remote branch "pink" instead of
 red. I.E: [Feature Request] Mixed coloring for remote refs in git log --graph --all
To: Skybuck Flying <skybuck2000@hotmail.com>
Cc: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Back on list; please keep it CC'd]

On Sat, Dec 13, 2025 at 7:35=E2=80=AFAM Skybuck Flying <skybuck2000@hotmail=
.com> wrote:
>
> On Thu, Dec 11, 2025 at 4:46=E2=80=AFAM Skybuck Flying <skybuck2000@hotma=
il.com> wrote:
> >
> > git log --graph --all would show something like:
> >
> > X:\Vite\Repository\LocalControl>git log --graph --all
> > * commit c2234c6162cae9e7bfe5013a76b6c381092046fb (origin/Branch/Featur=
e/Delphi/SystemPromptUpdateForTestingUsingFreePascalCompiler, Repository/Br=
anch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePascalCompiler)
> > | Author: Skybuck Flying <skybuck2000@hotmail.com>
> > | Date:   Thu Dec 11 10:15:51 2025 +0100
> > |
> > |     SystemPrompt.md +FPC testing, +common/types uses.
> > |
> > |     SystemPrompt.md updated for:
> > |     + Use FPCUnit for testing with Free Pascal Compiler.
> > |     + Special directives for common/types imports/uses clausules.
> >
> > origin is a remote (the github remote)
> > Repository is also a remote (locally on my disk).
> >
> > Both branches are in red:
> > origin/Branch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePasca=
lCompiler
> > Repository/Branch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreeP=
ascalCompiler
> >
> > There is the possibility when creating branches in all kinds of ways of=
 accidently naming it the same as the remote, so it's not really a remote, =
but it's just some kind of branch name with happens to have the same remote=
 name.
> >
> > Maybe these remote branch names are just one string and the difference =
don't matter or maybe it does matter, I think it does matter, if it does ma=
tter/stored differently then the idea is to:
> >
> > Allow mixed colors in these remote branches.
> >
> > So the origin part becomes pink.
> > So the Repository part becomes pink.
>
> "
> Perhaps try configuring color.decorate.branch or color.decorate.remoteBra=
nch?
> "
>
> Hi,
>
> I haven't tried yet, the AI said it colors everything ? (in other words s=
eperate/mixed colors not possible ?) hmmm..

Indeed, it seems I misread your use case. I don't know of a way to
color the "remote" in remote-tracking branches (partly probably
because that remote prefix can be changed by changing the fetch
refspec). Sorry!

--=20
D. Ben Knoble
