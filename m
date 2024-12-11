Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585391DE2A0
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938584; cv=none; b=fGFAvfjALHlNIY6cMMsAg26SeiRGuECdFUegHkSiRYO8FignlW1RhjCGnlz67l/YW7iXGBiBmU8PtyJABUf++bCNdCokMT4G1uDJxO1EAVmfnf64mmUjZqmYe5MzMwSGqpVYmbWWvl1cXTOowo91ikqA7foIW+rrgvQ34oR3Auw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938584; c=relaxed/simple;
	bh=ScuEM1QM8+c4tzvIXxjG4prMwGbOjFWTpNIx2QL2qpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maZR3903Oi2mZw6+5F25tAMmGFrOLWSbRVPERIsCSpMLeJ2OsWv202iydgGNYzt3X0UGI94hSynoUIoxt4sqKKIilFu41ZuF3ptu9gPenZLIBQbSxuPTh0mYIOsGJN0soAd4XInJbSxvHwNXfqCXezGlQEZCrfOeTdths4Bo9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtopRKkG; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtopRKkG"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb9101419cso235913b6e.0
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 09:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733938582; x=1734543382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDaLFwDbhhUL8ZzZtQqfLw0rhH/bKKlt0kn/emuiozc=;
        b=BtopRKkGD/SKt5DfQTRY7TtoRPoz+90FR+vGExBopFFYGtkD4JCIxryfkrQPyyOqy9
         cP4rFWRgv+vvvRpirrvKmCOPxNHYDr3D/WdSb7zEdMhlbccg0D4ob0qtT1Lrqat8vScv
         +nhxYmmuSBZhqsydcArmseQsMoFH5YkhU+lVpnusrdVDya5gTw8P64/ppcPqNZ/SacYd
         h6Tkiq85or19ofyBlcJ6Xuw9OPFsItI0jv0ViPt9jgasj32pywX52dtBkWupVmQRH3Qr
         3ChtQ+7SzWOkTW4YoscfDnqqdZeIE4EaBTDqn+P9cyLCWWnVZV1Dtd4EfT0WeuRPPaGB
         GXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733938582; x=1734543382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDaLFwDbhhUL8ZzZtQqfLw0rhH/bKKlt0kn/emuiozc=;
        b=oiPNgUvFZkzYAstRNCDzcb+Uf+e+zXyAzyRo9wzboJXCVRzn+wqmhdpgsNL2/kHXs0
         3mXYUVL8/rZBw/ehfN2x4WqJblO/wGSHE/qKItw8gQgH8YYmr+WTbxgJ+O4vhEtKvj/v
         gOPb0cGRR/w1STnXQ4ZEp8QTNzs9xonp9CWGmBegKqhjw5per4goV6AwpakSyIMrbuHD
         xCfYGVbfmT+ka+RQ8b2PSEPWdtd5c22YIo36ZEdJLxVr/2lkUmSp7ktaT9/CxaP4TnTF
         7lAi81mVT7RLLmrxrhucj8HkkhEuIk4Wzcx/GlsiqmQTCPIgrOhH7WEZmBegdnFR3PHT
         wbbQ==
X-Gm-Message-State: AOJu0YwbKdGOt8pPEtyoxWuz5LNqm1S0ZK2BNzxkSzZiR05MH5PeTXpP
	RQ6MQ2m4bf6oorOZbajogwCEYQBAxV7WdQ/r/TZUdg/0KFeH64tvwXB7AA==
X-Gm-Gg: ASbGnct3GSoSRZCrLDpFXezeQJa7/mU8wuvITnJ9jwSqT2PAM/ushah5xu2K4ZY51oC
	pAuXrhUvXuo8JIqzYZQHoU0OC6PRWMaNJ4HyKyyoiVw/T0n3Nhg7BPIZtWo4U53ahtEp8YfHZWO
	w1MG452uwpYtODYnvo9/5GatbHqE8zJcd3IZJiLALdC/QHagcOzlsMn6vBX1iENQODkf2ytve3c
	FFaO6x+0BPfn/fSBXVuerg21I+0TiLCdYmbpSZvcMEJI+0=
X-Google-Smtp-Source: AGHT+IHppU3Tl5AXoTbONQ9885BzPhpZq2X8cdF2sYjUF3Inz/5rYZFiUPF2X5HnDWVAInYVjGis2g==
X-Received: by 2002:a05:6808:f12:b0:3e7:b9be:5267 with SMTP id 5614622812f47-3eb93f95eb4mr334092b6e.6.1733938580871;
        Wed, 11 Dec 2024 09:36:20 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3eb6a78d1adsm1075725b6e.16.2024.12.11.09.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 09:36:20 -0800 (PST)
Date: Wed, 11 Dec 2024 11:34:10 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org
Subject: Re: branch description as a note?
Message-ID: <ldbhbymjanp5xg4suatp2bgbnk3etkgxqivytpqzyqkmsiuotk@hnro3pu2zqtj>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>

On 24/12/11 11:39AM, Bence Ferdinandy wrote:

> Now my problem with the description being a local configuration, is that
> I often work on patches on two different computers. I can easily share my patch
> notes with myself, but not the branch description. If these could be pushed and
> fetched like a note, I think that would open up some other nice possibilities
> as well, like having a standard place for MR/PR messages for forges, sharing
> proposed merge commit messages, maybe other things.

Recently I have started using branch descriptions to store MR/PR
messages and using a script to sync it with a forge over its web API.
This has got me thinking along the same lines. It would be nice if these
descriptions could be part of repository tree is some manner to more
easily facilitate distribution.

> For my personal issue of sharing branch descriptions with myself, I could
> probably just make up a convention for myself, say using refs/notes/branches,
> but it would be nice to have this built in, instead of the local config branch
> description.
> 
> From usage perspective I could imagine a new `--branch` flag for notes, which
> would tell `git notes` to operate on notes attached to branches instead of
> specific commits, probably stored under refs/notes/branches by default. Maybe
> add an `--edit-branch-note` to `git branch`. And of course have the option to
> use this note instead of the description configuration wherever it makes sense.
> 
> What do you think?

One problem I see with notes is they all live in a single notes tree and
are associated with individual commits. Therefore, I'm not quite sure
how a specific note could be correlated with a branch without having a
separate notes tree for each branch. Maybe the notes mechanism could be
extended to also support storing notes associated directly with a
reference in its tree? That might allow for notes to follow a reference
as it gets updated.

-Justin
