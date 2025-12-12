Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB613D53C
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765576875; cv=none; b=GNTyxRTdSPYlvPirI0Rty59TsN7jAwkOlRTTloB9/rFFaP1Q5yHz+yHfofX/DHMw+fUCtcN4bBe75mgqaqlDxNXh+Mw61N2bpE5eC+wiUm1hYP9PY2etLk7Q5KJRkUxHzG5uTb2RvcImwbQlnh9Ee7FzlksOy3IX6I+p541wd1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765576875; c=relaxed/simple;
	bh=dJ9ShAF++XnscNnkLsZbDa9XHnSGg1CbzZtg6X37pzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSAGI2ytvsMSUMvNdaUiBuKfwA307tlU4wuC+EpmrCqjsbEfmqXgflISJQ179p25UUQ8dGFrjJd8ClENxCqkOnTjZc3qYEiZFxL9b70+y+4Fjkuyrd1vIrKP9RwgKySIOfh7enZyB+eVcc640T3AMx6IH0FCKTP+mjH1whUNnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEK3LX2b; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEK3LX2b"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c213f7690so486033a91.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765576873; x=1766181673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ9ShAF++XnscNnkLsZbDa9XHnSGg1CbzZtg6X37pzs=;
        b=QEK3LX2bDEfSx2IBdq/An5qqRMGSJ/R4nIxbLXZ7mGV2MJJIgC6Kc61xIJk2j9hcEa
         Jt7fVkFrstetSUgAZOkHkIcdmZP2yHb4yfHgHRDGRbXOhOLbzA0mU5bfhcwUerL4CIwO
         sNTYgrIMvdD8nADTDaOKln/FPt8DUmkCPSTsQA1xUd0VuXEyQAvuIeZMR1ESS4Fju0nd
         UwAnpDuwaF8AZ142Ba+SmtoHp02Eq0OWgkVYXoHUsJYqGziFzwv5eVkDvVyP0nlcuPGd
         TC9wEkmZeWiUhHOwufU+cEHQ560EQVreJLLUAhcpqVvlIObho7IAhT2Sbpvg9EkCApcu
         kXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765576873; x=1766181673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJ9ShAF++XnscNnkLsZbDa9XHnSGg1CbzZtg6X37pzs=;
        b=f7jrVPxQvzHprUI6y+pLlPmH7YKOVrbf65i2LPcaDLWZb2ImrwC43Przf6BQLZ0cRe
         GykXVOZndsrj9To4BH12WZe2+qqvuLRvOf5St2Ewir/P4kiP0X0rVa+kcOf5N1J2zvMC
         EoRMpLsO1io7vhq7XStxMq0ey+zrZd3SvlwnqIV6x4Vp5BB8EImVXW3W9U6zNSe0WheP
         nCCuEL1wrs4vpuHpELTK5X10lnujpSfdi8/X14IeDqwzuXdwMFS25sNvVlze0+R5epZ+
         8GWTf9HeSfUzvSjY7N2mcIC6ebuMZgRGDGBi7K8O4ukxOcp6a8GXdfyUwlUrWKEnMpsv
         QjeA==
X-Forwarded-Encrypted: i=1; AJvYcCWpOnI5r1ceo2bYgKkGpj2WoHwD1AhmdtLtNAKBDxF3dRRUyBfmIw+kCw/m82+RaaLrdzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrZpCa8IAnINBCEBAizNE5qWnFU7CX/hktsTezhLzB/669R9+
	TKEo7GZB3hZplSPgLCAEkYbL5z39MoaYQabnPVLzjCnO20f6GOFSMDnF1VFJQGY4/LY5TTWs2QU
	23joe/szi0P9DR9WT/dZQ5lLdVVX3a/g=
X-Gm-Gg: AY/fxX73X+vxKVoQ9qv+T3Q95mM2L8SECsa4EJIftZYfjINjMhQyJbrje5fH4mhENCI
	USpqvY9aq69pOK0J2wdz5bmSZDp7rtPLxIsyqhQXGMd/7n2wqLy/Y5XBfl3RKspuHTh59Y/XYv5
	OBQM9yUofBYg0Ln7pb/zu82lW7oAYCPOHKtiI6KpUXlG30F4tmHOxxw+hLtMbmShbd9orf14LGR
	5I2xiJPDsknRTzhwyZhEqdSdbBJafhVT8cAlWpC5+f2r9TLaN01U7kz96SkutYHxdMWhe7VMDIs
	LxhWRcmpuV3U/NcHHA==
X-Google-Smtp-Source: AGHT+IF12PExHuTT7pu6XEJgqK5oYJUo7Da87izYD4lSN0BUXZvoh555YU8kMA4kJ6TvP0mHvf57L0S+Pp4h1mHongA=
X-Received: by 2002:a17:90b:2ccf:b0:341:2150:4856 with SMTP id
 98e67ed59e1d1-34abd7617ebmr3282973a91.17.1765576873512; Fri, 12 Dec 2025
 14:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g> <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g> <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com> <xmqq7bvj5q8m.fsf@gitster.g>
 <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com>
 <aS80z0DxAEBLba-M@pks.im> <b3ddfaa4-526b-41e3-b12a-0fec846ac7bc@app.fastmail.com>
In-Reply-To: <b3ddfaa4-526b-41e3-b12a-0fec846ac7bc@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 12 Dec 2025 17:00:57 -0500
X-Gm-Features: AQt7F2o1yOZMv470y2GOsZVd98BeJNTB0j34OSG-5tOOZucReMLRBC03MizRcEY
Message-ID: <CALnO6CD8stoeUg97bq+PvRdErCoeHPg9PUMMq73RPo-8kdVt8A@mail.gmail.com>
Subject: Working on top of mega merges
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Git <git@vger.kernel.org>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 1:29=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, Dec 2, 2025, at 19:49, Patrick Steinhardt wrote:
> >>[snip]
>
> I haven=E2=80=99t used Jujutsu yet.

Same, however:

> I have read or heard about the =E2=80=9Cmega merge=E2=80=9D strategy in J=
ujutsu.[1]
> Being able to (this is how I imagine it could work) make a temporary
> integration branch where N branches can be edited by making edits to
> them and having all the branches be updated sounds amazing.[2][3] I have
> found myself doing temporary integration branches where I make fixes on
> top and manually cherry-picking them to the correct target afterwards.

I have done something like this once. Created a few independent
branches, wrangled an octopus merge together, and then worked on top
of that. When I wanted to commit, I did "commit --fixup" with the
appropriate branch/commit, then eventually "rebase --autosquash
--rebase-merges" or something. In that particular case, I started with
empty commits on each branch, I think.

You could probably shuffle commits (like to add a new one to a sub
branch) using "rebase --interactive=E2=80=A6" there, too, but I don't think=
 I
tried that.

Anyway, the workflow did its job, but I didn't end up with something I
think I'd try in practice very often, at least not yet. It did make me
wonder what from jj we'd need to make things smoother, though.

--=20
D. Ben Knoble
