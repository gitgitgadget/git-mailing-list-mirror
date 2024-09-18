Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79318950C
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665815; cv=none; b=hL/F05PPr1Q1R8rMEYqZ0m3EWV1rTMzkxNlQkdFWTTdO6BiRDFMfx3VYZgahCk9jYPmX3a4/AfdLB7CDlJzI78guDER2RlIAXsgq6Oe+NWIfyXXITqTi00qsbiY/jAhDTtzBbQSDNxPvnaXu0pAyH4UecvTlnhhSEKiUD3xS+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665815; c=relaxed/simple;
	bh=ig3TK6NcdTgTJP+RNlbyb7fb+Tv9EIXJRlppSJHab20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaU4wLmmO8G0p6Rb9eGWYAxv+YPvrMJcEgjsaxnH8F9an7vnQ3anM2/EPs4dg5xkPUIJs42Zm2nZdbG9yoixIyjafu78KOY7umSdKWVWDZDMoeSSK9GXOLVVfqyGi++Uch4m02jJ13IGmb/LEw4SyiuuvSsoKw5K239X18LgIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9OZAS2m; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9OZAS2m"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so74301381fa.3
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726665811; x=1727270611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig3TK6NcdTgTJP+RNlbyb7fb+Tv9EIXJRlppSJHab20=;
        b=A9OZAS2mUqr2Iwx/38RWKXmSo+SZ+WDDz9m6wbfHfgPLl9puCjKY/Rjjz++iYiWwWt
         HTA4iWH2s6xKkdbYMY18cIKybLVLmqqn3ZWqf0kx9bkliTqfSCmSn147GvmjTsoEKej9
         QfCI693f4vXVnlCPtJ9drEvKq7rrrQ1Ny9Q75XKt9/r4HQKZ9zvl2NTvZGVJXZ1OUk6X
         zGG7vne2H7mGeUnwUmPGWewmMpHZDkasXz1+lql7lzDf+rWmIVhSpV8SK1nNVhg6O7Vs
         0TKhLyC8+jgQU0HznyLtBGAXq8Gxd7ZsOewnpZn96qyyj9wi6ZbYaVvwrocnR0ozWC54
         d74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665811; x=1727270611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ig3TK6NcdTgTJP+RNlbyb7fb+Tv9EIXJRlppSJHab20=;
        b=KaI/B+qwrsm2NK2HZDMuQrhiBVWdfnsImwhlH7+dvMf1g+t4mVoMd70Vn0ue4e6+sF
         e9GhQRZ6VgH1xPFI3AKEL1nWod0337m0Le6HjhKza+re01Qp+mYlvSxdMT0GGt0AI+tN
         /wW1mqXgtEnaHGfvZFc3UYieztuOpxI1wua84VHtneKt0pDEH0Dn09lfCV1alYz+fRRU
         uaZguD3O07AjIk5DCBOvtM+DIIWtsa3x3LfbAJBqwdwiBgIDlD9RekAga/3MvAyHAx/M
         6XPyVwFeLCLO7Eyj6mWkLiG7GxYR2eJhzErby0dqnijQ2bb1Ai26ckLrWdIyZIUMWVcG
         xqZg==
X-Gm-Message-State: AOJu0Yy2CZkJR1K0dUBQqplwdJsq+QOuKy4OFHTX3Y3j1EO+qcqk6O4W
	0KJt3xm5ru0jEOPPLYE9KprOk8FqzShzgM1FTXjik9FApvWgaB8hBcb6Pl7VbyBnT1bo5cHzQZZ
	mD+6XbSEDFijZ7NKt/MimoVpk2mkCZdZ2
X-Google-Smtp-Source: AGHT+IEnYXDitXm1PSeJbCszh7sl/CzfI4MRFV7voxgfwIACpSjqFuqSM9sLwjsn2xd3cxm9MLECyNz/1c/qmKFRrws=
X-Received: by 2002:ac2:4bd0:0:b0:530:e323:b1cd with SMTP id
 2adb3069b0e04-53678fe64f6mr13312785e87.40.1726665810709; Wed, 18 Sep 2024
 06:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZurNce+1IZ68WT+/@nand.local> <CAP8UFD3K6BvWs0iriG3RQP_2yY7+bc59wdwdwz9S_VLOkmU7sg@mail.gmail.com>
 <ZurSnxWRByacTUCW@nand.local>
In-Reply-To: <ZurSnxWRByacTUCW@nand.local>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 18 Sep 2024 15:23:18 +0200
Message-ID: <CAP8UFD1Aqn33TsRNj94T+iwDsMHPkgH9RyvYhzCR3_YeXkzdHA@mail.gmail.com>
Subject: Re: Git / Software Freedom Conservancy status report (2024)
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 3:16=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Sep 18, 2024 at 03:07:54PM +0200, Christian Couder wrote:
> > On Wed, Sep 18, 2024 at 2:54=E2=80=AFPM Taylor Blau <me@ttaylorr.com> w=
rote:
> >
> > > Last year we spent money ($675.96 USD) sponsoring Christian Couder to
> > > attend the Google Summer of Code (GSoC) 2024 Mentor Summit. According=
 to
> > > my mails, Karthik Nayak also attended, but I haven't seen their expen=
ses
> > > reflected in Conservancy's bookkeeping, so they may have not yet
> > > submitted their expenses for reimbursement.
> >
> > Karthik didn't attend the GSoC Mentor Summit last year, but will
> > attend this year (October 4 to 6). Hariom Verma wanted to attend last
> > year but unfortunately he couldn't get a visa.
>
> Got it!
>
> > Also please note that the money spent to attend it is more than
> > covered by Google, as Google gives $500 for each mentored contributor
> > and also gives a generous amount for the mentors to travel to the
> > Mentor Summit ($1200 for me last year). It looks like those amounts
> > are not in the same accounting bucket though.
>
> I imagine that they have either not sent that money to us yet or
> Conservnacy hasn't recorded it quite yet.

You mean that it hasn't been recorded for this year or last year or both?

On Nov 18 last year, the Conservancy told us the following:

"Note that at present we have received a lump-sum ACH from Google for
all our GSoC projects, and are still awaiting a per-project breakdown
of the funds from them. Assuming all is in order, the travel funds
from Google should be $1200 per traveler."

So I don't know when or if Google eventually sent them a per-project
breakdown of the funds. Maybe we could ask the Conservancy if they
eventually did send it?
