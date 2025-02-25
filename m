Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08DC2571CD
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468912; cv=none; b=b7zxDtusvuGOjieMCbotcWV1T0syTsQxz5nRbbKErYOQom1BC48LyByZyBNWLIbMBbGvKLKhWAIBHT1Ek6oWlYViKiXqYMabNVVTcDPLE7D78kqiZQ6aNMO6GKwn+JiQC1XwcMlLnyqJZTHVpMOOyerJMNyzQByuGTJA1rXUcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468912; c=relaxed/simple;
	bh=BwSvuWV5RBH3uX13edEO05c182NQD7/OldTEDk+fDwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlE8toJekYkw62mRQGlHgQwXop6gu/BqPtjm9pVrtZNOdKKiFOjXKOHRTyq2WrX379ym8cwPbINIVq1gZWW7K3gQcMiYNP4dFP5ODg6LqEqASW7Y51wsNSrFfcxaPFURHQZ0vjFoOtdsCV8vWZloPB6dmIqWzwt06zyAuSYRzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZv83WiV; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZv83WiV"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso145335639f.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 23:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740468909; x=1741073709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY3i47SgVgqjXUx9YQGVrdsXAL3jKkVvLJSWAai5J8g=;
        b=GZv83WiVuUKEwY/sEZKZ9UncNuQWSI2XRqDSxkkMJOF5Btt/Ax90FHJQQgcl8J1j3l
         OxtIf9SxEDhvrRUhuVY8FKRV6FO1nSOOk+dbIH4+1LkFfV8MZ1ytmoZ+u5nyo/S25DKD
         1VDaxzU3XioAfIVxrHaDXkHVhgSk7wc3dRMthmQs+pLYrIRvCWhG6u3JGiBLVbsl+fFV
         rauLQiQhCOGYtQUOUB6xP/hEO+CW6PLiafr+xH9YrMm6WZgkXh+4QOK2criJH+WbmtnW
         TZxGSdT+1/go+f9L2Qbl0WO63pEJNnI50JpxC+oUknhO1IT6HHwr5d6FVIJ/xDylwOGW
         lK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740468909; x=1741073709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uY3i47SgVgqjXUx9YQGVrdsXAL3jKkVvLJSWAai5J8g=;
        b=J7IWD/z46r6tefUhl8sOybFEUr600DI3MYGZzF8tt8Clea98IC3T5Dp8hXLmjiOXH8
         otdRrT3SBICx7MyP0BMvuzxPdt76jD6TYIz0V8RfpGSGdG99BxcdO8FxIU5FRxpLCV7a
         5dgO1yT4TQjUlD3QMskSLUp0CCVxHM8DCsxFKeVc6MJbieNlfnYcL/qcrdKWPu66bnr/
         XRBc6ECHL6aHAyT5V98CN2Ffb9aO0fsPYfYU+MtgPBNTK63YKs4Dom9jVoW8PkJnXtjI
         o3Bygg7mt+qowIdP1fuMHKU6/iomqkOjY6H0i+2lOr5cxsQ7fhuzNB2Ud83aZil2eQFX
         wFFA==
X-Forwarded-Encrypted: i=1; AJvYcCWQt+ehOT68AvsFhDI5/dUpsXmU0fJVijIHTFLrhC+t58R0QHLznulHeotKJoK9pv/aYR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvPTvxLd8DmEARlFrrOfxHJ/v6i0zBA1EO1d9aiGvv4RyV9U8w
	OCYuoyTSHfTYoKwSYSHz4L/OU0XowfhLI27wq4e9LHbgcNErbgIdUymrssGy3D2U8+xPiDmOgvE
	MinoXC0pbYsbSj6rtB3konG2EH8s=
X-Gm-Gg: ASbGncvodts3WfkKEV/NU2X3rUJryy9OYVU7ucRoKGQ9ojX0aGic1LkoERy9BxQhFBU
	zIdOWlk9QSetLeqyWaCWJlBgIj+ZilfO/bWz3LLQwMOIrROp0hr9ccbv3LkcdjvMh3VGSoVR2zP
	RebIPYg+2hosfp1yNi7f+exoY9srrrruH6DU4sG/k=
X-Google-Smtp-Source: AGHT+IHEsUwazW/FOG1aIBc/vn0Uk2q+9L4rFOoEexbf8LKqVlmPrcwu54aQXML0hZt8evuWE7zZtMsVsNHSMANsZ9Q=
X-Received: by 2002:a05:6e02:1785:b0:3d1:4b97:4f2d with SMTP id
 e9e14a558f8ab-3d2cb429f66mr144553695ab.5.1740468909301; Mon, 24 Feb 2025
 23:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210430232537.1131641-1-lukeshu@lukeshu.com> <20250224142744.279643-1-christian.couder@gmail.com>
 <xmqq1pvn6zvg.fsf@gitster.g>
In-Reply-To: <xmqq1pvn6zvg.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Feb 2025 23:35:00 -0800
X-Gm-Features: AWEUYZkPjf2sNSGRw3dRwv_s1GxlpaTcGVX2E9yMHQYqyr0vEcrgnAMgJJLgYMw
Message-ID: <CABPp-BHOvCWd6mMg0WdR4O5TfZS7TWtRCQCYPLnGpo5+jNHy5w@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] fast-export, fast-import: add support for signed-commits
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Luke Shumaker <lukeshu@lukeshu.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:01=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Luke Shumaker sent the first 4 versions of this series in April 2021,
> > but it looks like he stopped before it got merged. Let's finish
> > polishing it.
>
> Nice to see an old topic resurrected.
>
> > fast-export has an existing --signed-tags=3D option that controls how t=
o
> > handle tag signatures.  However, there is no equivalent for commit
> > signatures; it just silently strips the signature out of the commit
> > (analogously to --signed-tags=3Dstrip).
> >
> > So implement a --signed-commits=3D flag in fast-export, and implement
> > the receiving side of it in fast-import.
>
> Nice.
>
> I haven't thought about this topic obviously for a looooong time,
> but I wonder we may want to have an option, which is independent
> from these --signed-tags/--signed-commits options addressed here,
> that allows the person who performed the import to attest to the
> result by adding their own signature on tags and commits, whether
> these tags and commits were originally signed or not.

For what it's worth, this has been requested multiple times of
git-filter-repo, so there is some desire for this feature.

> Obviously totally independent, orthogonal, and outside of the scope
> of this topic.

Agreed.
