Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0F18870C
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605870; cv=none; b=acBQeqvnV+fe1rLk6iJppVwEOlXiFYo5nUgyIushIhNfkx0/VDD7SxI7vUPfD/saziqLhIeUbJEKqXPuFqVxpp7X/oDWrAm5yU6bdzDuxBjh3P/puZlDAr76ffhu74jd/CxYCUqu2ecF9bIB8ZgG6HmeUZqblnmebas4uMceu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605870; c=relaxed/simple;
	bh=i+JvLVUVqOezJWzLXC5lWt5F1eQEiAzM4MqqtaP/XkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUQBZz7WyBym4lXt6zMw+TglTBk8t56EVeptT+zOZXca9+6CkgCZ+P2VHkWmAML7erzQ/OPeuqW43oeijGuyePQXd97ACEkHeGESi7rCz9Ng9dkNdpXKXl/adZBaBK+SxtmLGmAD0YM91ECZrkY5qpfw7vi3sy7yoGhplSxxhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj4izPAG; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj4izPAG"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b5e49615aso250278539f.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745605868; x=1746210668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLBVlG/+ZcMDW4Jlr28BnfFi/EaZfGOTtzTedVChoVs=;
        b=Lj4izPAGafRhheJi8ChifSLvK5VN9eFUOZb6BKcJfaPpPqOsSRDBST++PoUBUuRPJ7
         8+WN6e6SSRwYnQHiIbbxboYgsATaWgycNpxb+GsRPK2B8S7u9jXaK16L7yNBy6GyVDsH
         DNUJE1P4m56R1E4ggVYod7iuM+VB0dwTdCThxN1kffR9EnHCO3O6JBQA+jlPaAGFZvI3
         mXmDZQ3T3ylnXZZYQNsHgV8uaawxBMAwvCoGio1pkZLJPvAmZLbPPGbsGDbds5wuLYii
         fk0UnLwx3XQJQNiIc/BYU+r2bPu2k3sJ42zwcWPmuKkekrvyFs2ZLvLfMKcZzOPWSrSg
         DN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745605868; x=1746210668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLBVlG/+ZcMDW4Jlr28BnfFi/EaZfGOTtzTedVChoVs=;
        b=hsqUksitEQ3sjWctfCUf7xquKa3+t6Yx55UBUYIEQIvinFEUX/EhacZ/o1t/iybfjD
         w1YkCO38dJwPoAHW7rcY+jU1ZnByLY7SKaTHmsDadxJ0WeUTUeoovR+yOORy0JaGK8L+
         ydbS7g14UrqU4G2klg90cF/7U8/B58NIMCs6ACakI+V9UDNZ7ZebKI556SA+9Jq6EOmp
         ELWeQJoiJO+gAxfvjRvRvkI7SfqCksBlz14NWlYa/dQIhdzzppQK88F9LTbCgY2b7N6+
         FkeTwusbfPRGihR27X1EklYWAmbKkZ5MpMhstcRFaWWeb7iMOwz1Rr2OgSDQUK08oMPU
         t2wg==
X-Gm-Message-State: AOJu0YxN6Dgj0e1ep/WSFeZNG6l7zh3W/Ycyvz5byBon2olfFdEt1PQg
	HkhRbQzjgiINTSK5gDpCA7foepuUU2RCmWNhvFvMSQygUiKhgyfQQL7rrjJg6sdI4aASLK9CgCd
	IiZiSot+tSKCl9FUhisZ9M2oq1lM=
X-Gm-Gg: ASbGncukk/ut/vM7w2Bjhxa2aryapiKvT0/F/5C3q9TzI9dOGSclbYSw43tseDx9Sdk
	RLpc47/kwn2Xt0aosAUAFhOiqKMmg5y0VOwK4gtAvNPe2FQHnLjbpVmWSjDt2CxEFHAbuEQvJGI
	kvNob5t4SjSVrREy2Dmtf40rbnvDzaH0ky/pGAft2hr3vOG2kkqWwuuVex
X-Google-Smtp-Source: AGHT+IGhAbv1sxxGDKZBAEQL3iEICNNmJlruk3FoeQw+yU3nQr8tXQ3SMSa/Ecvhuj8Kr1iKzaVF1j2r2wybqRikqLA=
X-Received: by 2002:a92:cd8a:0:b0:3d8:1dc7:ca7a with SMTP id
 e9e14a558f8ab-3d93b3a6a82mr37669415ab.5.1745605867683; Fri, 25 Apr 2025
 11:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+ODqj2s68nPWzd1KHH3vUm3SiFHuf2b=+hmNuWesi-bo3c8_g@mail.gmail.com>
In-Reply-To: <CA+ODqj2s68nPWzd1KHH3vUm3SiFHuf2b=+hmNuWesi-bo3c8_g@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 25 Apr 2025 11:30:56 -0700
X-Gm-Features: ATxdqUGkutCKdJL-CjkGyHWve2T_1hpTPowdjkhHdjjYpgvm3jNiS7lEVXRRAjU
Message-ID: <CABPp-BFiLURYmELQ1omyPJ+49cVxk1h4rPYj42zMwGUW-NUUGQ@mail.gmail.com>
Subject: Re: bug report - BUG: builtin/pack-objects.c:4310: should_include_obj
 should only be called on existing objects
To: Nik Garza <nikolas@applied.co>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:15=E2=80=AFAM Nik Garza <nikolas@applied.co> wro=
te:
>
> reporting the attached bug:

We prefer the bug be included inline rather than attached.  However,
from the reported error:

ERROR: Failed to fetch git tags from origin!
    Stdout:
    Stderr:
BUG: builtin/pack-objects.c:4310: should_include_obj should only be
called on existing objects
error: pack-objects died of signal 6
fatal: could not finish pack-objects to repack local links
fatal: index-pack failed

A couple quick checks shows:

$ git grep "should_include_obj should only be called on existing objects"
builtin/pack-objects.c:         BUG("should_include_obj should only be
called on existing objects");
$ git log --pretty=3Dreference -S"should_include_obj should only be
called on existing objects" builtin/pack-objects.c
c08589efdc5 (index-pack: repack local links into promisor packs, 2024-11-01=
)

which was a commit that was released as part of v2.48.0, and as you
said, this started happening after you upgraded from 2.47 -> 2.49.
Cc'ing the author of that commit for his comments.
