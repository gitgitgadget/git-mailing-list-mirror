Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED627A919
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647445; cv=none; b=MwhRCpQ9nf7x+X+tVJYHDktMbRORkj4TZB2UD8+gMu2j5QIVYBSfC7TLu1dN2OrtbCXC4XucxFjFjbyFeSX9t/xCsXiwcvB+7xjJNpXB+csNaEtIxSy4QrYTJMiIvGWN2yA36+pOAamGq95Q6NkyF4bZvmWp2jEWjzcTFuE1K2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647445; c=relaxed/simple;
	bh=qpU5uPtql4rqFgAS4DfTW/O2bAEE0lDH4ERX3va77N4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Qal4F8tsoPUK82/LrB1qHU79r2BXP7UgyGm9xTqagAXP0ZhiLz2mTVDqQYKljp2lClocEc+hnswVOkYj5ebM0m/AlLvKiDnlzKP8FnxuVmhQooGfEhb5CW7VVvGwvH/AUga6r3Epguk8zTY26yLuw7IQZv+Jh01cgV1wZL7vfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T89aDILw; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T89aDILw"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-635355713d9so2075934d50.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758647442; x=1759252242; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PNNIYoA31xIJ2HZLEF5IiyYupvIwB3yptgI/TJqHGw=;
        b=T89aDILw8ejN08G7Y77paCFinQL9ILsC6ghKL2+d6cdv3ICBieMga2U7kjjhKUSyYb
         waZ+Km8wT75OqKvDdWqLcbMVGDhPJHMldbFE1z5+IEuDE0ScsG0mCcdqX1dHT5L5AFIG
         L86f8FvGfWodrPGdGThYjYpqeWBcTP7feXj3/nnbR1vI23+h/AWlIqEQlOHXTc9dpESl
         PgqB6O7FgCVROx5coSad71/cX5PY+8cpSedfgVwGBNd2/4pF2LCYN+NMhKqD8HJaCSlG
         9rsbuPre/g3bk6nH5nTnVYbECYHCRVsAl4MgMIYco5YYNt/GQZhZen37dd28XtVlJNX7
         bZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758647442; x=1759252242;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PNNIYoA31xIJ2HZLEF5IiyYupvIwB3yptgI/TJqHGw=;
        b=LA/4svZMxRJ3iM14qOGv9Uj+h3IxPLtQIWVBBIAwLLKDVBdDjKqR9ASnI7TWk4QLBN
         ie/pGqanMBq6x453Sw2us3CC1lBR31aPfL1pk9J62WnvTZ/6XSm6XJ6PnNpH5dO4lWJ0
         hP1xRIcMHLdCZMS/PhurS4VKCKHs8RHory4+QFpM5MHGboeLSZWGDRIadyfjZHDPKtlg
         cdL5FH9/vdvqXhPqVlGuerEGW6sDdNafd0DIhaFp/aoMxvNulgZunXrXy3ilq1lyV5Z4
         CoJIHswjHOhes53n/CX/MJT4quFNwp//VWhp6N+ZVU+MHL3I/334c/SD4h6Wj2jrFWqW
         7c+Q==
X-Gm-Message-State: AOJu0YyGrxMNplVEk5tw93Y5mihcuDjtK6H/m0FRLd/gdM0MwUqjmS9C
	89g6F1cKZlEDVQYSLHOwQ2s9aW9YoP5L/djbOKTTuMRq2jzqMbwxlGthzP8T01hr
X-Gm-Gg: ASbGncvilOtHHIHfmXRORNLHnY91sda3j+vJpSFlT+GOCauBEeGoVpeYWm0IEfPKEQJ
	zVrnT9cI0U7l01Y0lukj1rFrNYll6ywrNZL4FWMKqyeui3VtTE7TNxxMu+l3ZER0UmjTYrn+EIF
	9FqMpnpBRaYmIyDecfN8brSnYdFWdniFVPKNt+8MqhkJNlG1Z8UTvRU0C5yuUtVFDOQby+EUiTo
	WpwMGzmOhFavbF5wClo+WpPXNa0qF+FFM1BEvzQDeJq5BgZIVhNasWHraY1QAKy7NcZGogz6VNx
	WjuQL4XsKoe3YlQwtgm2PomFcIc7gJqnvWEtprC9jDLEUexXoH4UhsjJ3rn9EyDC8l6zNWOJXiY
	2wFnSD691trdAxafKPuUsKDSSTlDGpIHfU9/vOAZUodobuSm8H1s=
X-Google-Smtp-Source: AGHT+IGA9oWqg2SAGzVoPv/uK/vtYpicRmx+0KRok/1zDiqZGscoQ64GRA2sapTQ47IKlasXBx5yTQ==
X-Received: by 2002:a53:eb91:0:b0:632:e9f0:768c with SMTP id 956f58d0204a3-6360463d061mr2121914d50.24.1758647442245;
        Tue, 23 Sep 2025 10:10:42 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:3535:152d:7414:b233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716f628csm43542047b3.25.2025.09.23.10.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 10:10:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
Date: Tue, 23 Sep 2025 13:10:30 -0400
Message-Id: <BF1B80E7-4DB9-4CDD-9C80-330C4B487DE9@gmail.com>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
In-Reply-To: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
To: Mathias Rav <m@git.strova.dk>
X-Mailer: iPhone Mail (21F90)


> Le 23 sept. 2025 =C3=A0 04:56, Mathias Rav <m@git.strova.dk> a =C3=A9crit :=


[snip]

> I described my own workflow for fixup -C above,
> and it's the only use of fixup -C I'm aware of.
>=20
> If the current behavior of keeping message from one
> and author from another is useful in someone else's
> workflow, then I'm happy to be enlightened.
>=20
> Correct author dates are certainly more nice-to-have
> than need-to-have in most git workflows, but I think
> it's worthwhile to have git go the extra mile here.

I can=E2=80=99t comment on the motivation, but :

> rebase-interactive.c            |  4 ++--
> sequencer.c                     |  5 +++--
> t/t3437-rebase-fixup-options.sh | 15 ++++++++++-----
> 3 files changed, 15 insertions(+), 9 deletions(-)

manual pages need updated also.=
