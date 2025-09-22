Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB5EACD
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533443; cv=none; b=h+eQQdMbiV+NUwQvu+SGGvBMn4/fYysROf3zwshv9UlMslmnq1g1q8eDwiPqmYbsm2/Urh/ee6fCCGFvy9xGj8TJnkvX8ukGkAfLkTR1bacmz9xK/x5LCOUAx7dNOKZ049sc8GoX2501wPPkw9yXpd2n/LVM4EeEnVDilgyNRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533443; c=relaxed/simple;
	bh=bGk+zgT3Dani1TpYLrTJdINu/Us+ieC9zttZ5U1fYlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKRucFd7ZWLQUAE1UE5XnuzGdyUJAiZHuk+yn/TZuXsHfsNqWJ6mFRsVkO+sm5wKloPIQOCpON+S0RlO/Hqu/Rx9Y98/ZwMI/VUoTB+xbRti8wLio56lVAw6+b/xeNwkJS5LdKd9bnPq9ybYGpoEs3Otnd1BBHwii2d6j0AqS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDQitALQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDQitALQ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b78f4aa547so10977201cf.3
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 02:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758533440; x=1759138240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGk+zgT3Dani1TpYLrTJdINu/Us+ieC9zttZ5U1fYlM=;
        b=cDQitALQQgu/WHh8NcVBdrVmk9a9kJj6XkCwCpLJick1+uRUN13phvsoZdzKcJ8lif
         B1/1m/K310NVQLQ1FZmby4mW8XmnE0IBzBUViWK93uPW+mxmufZGldaj1XcHZQHk09vE
         FpQ8vt9zBrXrwKmHtjLmrcmqWnwSEoQ4esEkj0PzLK5VmIcll3hkBk9AlPi9FxSNEDuE
         /KNA11mU5L71CXnyRtkrJExRX6klXWUWZwXGbuPNzWN8o4JQZDihpzH2037OKOMW7r0p
         Mrih/e3OVmHk3Ci65fxg7/gU0KI67/nB2xcTkjFEwbGXRd9sQAMcBEmsmVQvlT2woq+I
         p1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533440; x=1759138240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGk+zgT3Dani1TpYLrTJdINu/Us+ieC9zttZ5U1fYlM=;
        b=PApqNa7q+M938kDHBar5gqCT+BWDa0rw8Mf24+Adq9Mho3PiX2KFyV7Xu0QgYdPDqi
         4z7zTsgkgyy4LRActoh2PqN2Oyt/5NTqtDK/qdcvZvzP4CqGo1HjSm/vzwsa51fylL0O
         B96EOJaHIFcKBvUjTXFJzlVpoK1Z6gxomfD8lUs7T+8iCFpGEZasqjjc2ddR+M0T9AxL
         fvxhjXcvwyHzciANWfj08IjZhLVHY71+RbTiamNcumUlLEdClw0DWbFfKgrlrceJwglP
         nrkjQk/knvk9MAWvJwruSKzt6NCYaS1z19+WMo1PNYXBCrElpngPijJ/tIHIKet3gIKy
         Xkmw==
X-Forwarded-Encrypted: i=1; AJvYcCUDjkPt7OLccSwzSdkBGUHnZ9vV+b/Pqn1CmXuwkMeGmeDLDhSNllzJWtu5iONUSYd9Xns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZr1qQHOxg1TUm6E+bPHjvrOL4ARMGi3CJZf9J9hiSY8oGKCR
	BJfyNmlKIwA6qFWOVi6aP0IBUfhg6aDKwtQ/4ejww4FaeSQQ52xnU6vPxn0ep+nJgVVW+G7QJrC
	u2U4ipueSWKOvT7fqpX08t9dbXKvxRDY1b8re4iI=
X-Gm-Gg: ASbGncvDNVZwoIsbZxssq2rmUyPBKzh/DE/H4/sthYtc/eRlwnCopbBy/WQV/IBH2DC
	wS37DXKbfSNiteFJWnD+lUgFfOyH2LOSgP93GXMYRG5nSBHImrxVbPq8erPrwKZAM+Vcq0RU3Dn
	sX3eANLG+T9poHlAkiLhsa5SK6TvwhpRYOeuY64bwGv25zLXVbX3B/VGj+3vU8BmZwDaOdCtgtu
	u6mNk9t/x+qmRvpW4HkJgOLrwDr2mJpPE4DovmfxQmHjD+fxZc=
X-Google-Smtp-Source: AGHT+IFmDvgBqBCGtSX3Lv9fGIOwET5mLXYnUPxiZDRt9xhs9Glz63JdxyW3BXp9zF57ROmj1nog43ur40VyjJmCYV8=
X-Received: by 2002:a05:6214:2262:b0:774:48fb:f8f2 with SMTP id
 6a1803df08f44-79903fc9c10mr98737896d6.0.1758533440369; Mon, 22 Sep 2025
 02:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2994140.eGJsNajkDb@alfonse> <CAPig+cTRYK+5ezmGxz0d1TwMTu1RKy7Xj05CzDE2-i14aUpSAg@mail.gmail.com>
 <92bdb432-1f6d-43d9-a93b-8cbaf3c4a7fa@kdbg.org>
In-Reply-To: <92bdb432-1f6d-43d9-a93b-8cbaf3c4a7fa@kdbg.org>
From: Eric Sunshine <ericsunshine@gmail.com>
Date: Mon, 22 Sep 2025 05:30:29 -0400
X-Gm-Features: AS18NWAATly914J6P9G115xz1GB0-Dg--kMdOnLFXc3UMSckP4GhWGArwY1zk1k
Message-ID: <CAPig+cQvjt8+3EGSj=-wP6p92402vuSg6FtU-kQ_27Ue__upsA@mail.gmail.com>
Subject: Re: [BUG] gitk assumes availability of `osascript` on macos
To: Johannes Sixt <j6t@kdbg.org>
Cc: lists@humanleg.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:37=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
> Am 20.09.25 um 21:52 schrieb Eric Sunshine:
> > On Sat, Sep 20, 2025 at 8:07=E2=80=AFAM Robert Scott <lists@humanleg.or=
g.uk> wrote:
> >> Tiny one here. On macos, gitk (tested 2.50.1) attempts to call `osascr=
ipt` so
> >> it can focus/raise the UI. But it fails hard if `osascript` isn't pres=
ent in
> >> the $PATH.
> >>
> >> There are a number of reasons `osascript` might not be available in a
> >> particular environment, e.g. if launched from inside a "pure" nix shel=
l, but
> >> seeing as it's just a quality-of-life feature it would be nice if fail=
ures to
> >> call `osascript` could just be ignored.
> >
> > A patch[*] was posted to the mailing list years ago which, I believe,
> > should fix this problem for you. Unfortunately, the patch was never
> > picked up due to the then-maintainer of Gitk being missing-in-action.
> > Perhaps the current Gitk maintainer (Cc:'d) will pick up the patch.
> >
> > [*]: https://lore.kernel.org/git/20180724065120.7664-1-sunshine@sunshin=
eco.com/
>
> I've picked up the patch:
> https://github.com/j6t/gitk/compare/master...es/ignore-osascript-failure

Thank you. Looks good to me.

> Please test and suggest improvements. Should the links in the commit
> message be redirected to lore.kernel.org?

Updating the links would not be a bad idea. Here are the updated links
if you want to amend locally:

[1]: https://lore.kernel.org/git/D295145E-7596-4409-9681-D8ADBB9EBB0C@me.co=
m/
[2]: https://lore.kernel.org/git/CABNJ2G+h3zh+=3DwLA0KHjUn8TsfhqUK1Kn-1_=3D=
6hnXVRJUPhuuA@mail.gmail.com/

Otherwise, I can resend.
