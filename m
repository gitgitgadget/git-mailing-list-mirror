Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074119E98C
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913037; cv=none; b=kJ4SA4p7lwhvhJptjhCUHJRrGgn1oW1G+MFFs833df04qSCJDxuJYDPEgwFQHycuZHVdsRIO5BP9Hd5CVR4Cbx2hwkzudy6oh/PfWnmk8+nErrYzJ3AfHSGOcYP/7cwlHl/xBnGfv7MmQCGfVioMnXZ23BnVk1NIU4m/4Ylzl3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913037; c=relaxed/simple;
	bh=nhBiqgk3cyBzAAaFxOaF1y3pKO3X/yqZFKvMMXWufyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwxDe4uq9/+0cJyWsJIXJEiC0XaqzodtFhLaOM5HxdCfoD55vJZwSLw2E0nOBrirDOdr1fA4oOH3Q1A4Yd2A5enut1uaqXs1vdh4V250nzOyvhb49DgfcaK01Ryyvh7Qj4x38EwQm5RjxhAr29ihYeUTa+mA87QEj7aFy/NGSEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE3/MIVv; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE3/MIVv"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-890190a3579so1412818241.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759913035; x=1760517835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhBiqgk3cyBzAAaFxOaF1y3pKO3X/yqZFKvMMXWufyc=;
        b=ZE3/MIVvazXBnTxp+m0vjjNKYbTElbuNsoU6PaM5528QpalojRDy0D5zOFSUqm+WX/
         AQZxmC7P08xzKPgYQ2xDQ5xxM77qKwMgFhOK9DiqtVt14MAtLGuMZQOyByrk9JcuhrXh
         kN071b4c/2VxPBnCmIf/AaiR8IAIM+Ys5lEZ8+9+ENvz9lr7DKxR/Z3NCsGbOCRxkWIx
         Me/pIH0qEp0csHqe07ycfiVFifS48UWKNTSrNATRw540eehsYwNNX0PYNwmemVI881nk
         +7ulqrQY634lwl/z5IHMR1pPYbB3BPuayRABMeUqV6+SVgPDFwSswkYrz8i/3TRFsour
         PR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913035; x=1760517835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhBiqgk3cyBzAAaFxOaF1y3pKO3X/yqZFKvMMXWufyc=;
        b=XUuYQGiBKnU4RmCvB/tsiQFsEe+Yju8qaZULqdTjbGtG4Cj6VYL5Rs32zYr/kbV7Nx
         EuxNRmsoVN23x/amHCN1Kl1R0hRt0BIpJ+aYhvVNtlNMzZgDG0v4TWFHSTvrcvPflGZo
         5nXe070aLtkQbAGNUE8ZsCdmtwmZrjo17HkxHHfMfMmjFdedDS0M2NZx6PaVjW+CM+Kz
         89UEJnxYdwX1kXiwOeBFY8H7ilF9Yw9eki4RH2OhJ+98lBb3RB2uEV2j9iUewITDwi23
         cgr5HsbfCoM92SKsw/mFZWQy44hB8Nz3HvcRi5mXD7pKzxf+X4ppCSyG438XEfdR/Okv
         Witg==
X-Gm-Message-State: AOJu0Yxtyo3gDPXnerFSYcryECDOwRHAYB4k9Hle3CugWWYzjG6ubShj
	TgnwqOBGgTo4fdltBLXDzJnQziPguoKFX6S1BTcxSEKsEA4Y61KGPG42wmpfIYvB9sGB++5qeIk
	bNWgyeOHb4dcLmX/I/wJmQ5RHXtpNEd1xdPw2LFPBsQ==
X-Gm-Gg: ASbGncvi5ePWAK6nv2/W0gtQUhsvG8bMEm0+DUbWye7Jo6xpH/azVm5v6FPPi9e0nzj
	3pbFctIuO0sZWoEhv4CVcLhr6OowgXq1ehHCt81j5eoCbE4otJNsMXFY0hWVKNOkE+AmNXKCypz
	rF42Za2/NoohqHM/6Yb/UFaF3EnJMHmOC5nzKuzE7T/waaN/lpNiGKA4ROhA3cvzD1GQNNk3APx
	Mg2VWEuPlEYFSrWG1s5dSxguUV4iRl51lOhJB0NW7HxS71W7+k2s99TYdKochvCj53HiQQSoA==
X-Google-Smtp-Source: AGHT+IFmPA3pXzs2HcNN9hUXmXK8H6feteXKLB0AyQFnq7LFZYB13k00GRShZSfDC2Jaq3c/WkYr7qPV24+3YjL4sd0=
X-Received: by 2002:a05:6102:dcb:b0:5a3:acb7:55c5 with SMTP id
 ada2fe7eead31-5d5e23ae048mr911304137.26.1759913034977; Wed, 08 Oct 2025
 01:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFpMFfDMmvbKMNGbmqA=d_+x48kiefT_SGQ3M9m8ST9871UE2A@mail.gmail.com>
 <CAPSxiM9PPHuMfje5zvM7U_rE5TRoB+=PUGCGO_k-5ZCtvQ8Q8Q@mail.gmail.com> <CAFpMFfAGbqWe8mDN3Yw+nPmLT10RXnf-4T-a9b_WWN=-aQaWaA@mail.gmail.com>
In-Reply-To: <CAFpMFfAGbqWe8mDN3Yw+nPmLT10RXnf-4T-a9b_WWN=-aQaWaA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 8 Oct 2025 14:13:43 +0530
X-Gm-Features: AS18NWChWv7TM2NvULEcycH7KPmfAvHYlYvQnXot1U2dXNAonYyuDPsGiFnM2CE
Message-ID: <CAPSxiM_V1gxh4h-9e5iYs2RzgTUJ5yv6YaKffLQmk05GBRE6qw@mail.gmail.com>
Subject: Re: [Outreachy] Introduction - Rosemary Ajayi
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 2:09=E2=80=AFPM Okhuomon Ajayi <okhuomonajayi54@gmai=
l.com> wrote:
>
Hi Ajayi
> Thank you, I will check it out.

One very important thing at Git when replying
to email is that we do not do top-posting to email, we only do inline repli=
es.
It is very important to keep in mind.
