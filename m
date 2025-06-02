Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AE11DB125
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860542; cv=none; b=nZb06XRVVNdbW0dZR6FiePROwmR7nbw5uJ0X/x5D4sp3mzHR+aWqmOvMuwrntRR/gjBOA9Nt3jo8LVbWaqFY1VTemBn1bY/E3jZNP0BLBhs3+IbtlU/x3jV4CWgrOesgvupkKhGEw6zlkpx3dxOZDChW1mr1o8aW3t7Ew8x0SCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860542; c=relaxed/simple;
	bh=Xu/HtFgnqtZO+2nRhT/3kdBFJSZEjkQy6XPeW15HrL4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdQfHxjwSjyuDmighxaVeXeP6lfla5vI1g8rfUJ5ga0e3Gk0do36MmEAByxQ3TCeV9nNhvEoTu1jxDvgaQo9rRF7oksgYxU0xZK2B0nalWuBa3VeTO61oKbmE100GEW7ow7dNsSwd0z8nkWg6QaJ+nXqKzO8GFm0zY5LFUl927w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIwov3NJ; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIwov3NJ"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e45cfc3a26so3103384137.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748860539; x=1749465339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu/HtFgnqtZO+2nRhT/3kdBFJSZEjkQy6XPeW15HrL4=;
        b=ZIwov3NJO+CCtluHXIhFXh7OVK4D7ItGw08sodxrrfCOXPEvHEhpw9TWEjj20woWPN
         4DcAneyBa/rdQoC/+BoTef04sxVtQt40/WdUtdJXY1RwST7CgXMFsAiUmyoMRdlmRF5c
         5hvedaMIW1yTNZ95eY2m39DPEaqcoKAr/4Io8CvbkCev5whUm/boLplUGrVJTJUhaK7S
         mA4E886mq44nBgEVy4DGZNKT7J8laW+gUYgcUJyL3+ovcv9JweupwLYdTGo0UWm5NLZG
         mZjZKxdqfrHjdujC/uzOY3Yl6fLkPuWXZpWRKJPKakBmNGoz6pud3Su5FtpSUru8VjK+
         vsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748860539; x=1749465339;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu/HtFgnqtZO+2nRhT/3kdBFJSZEjkQy6XPeW15HrL4=;
        b=iJgAt9nIV5TUKoo2uaS7mtN638sLHHUU9g4aLPVYjx3vTKFqe/XN+9M0nV1YU+1W+L
         tyS3h8NFU5wzTtZzr/jByw4J39OzxVtmY1ZFJtMFYfyTWgQF9HZ9ZDFR8OF8Y+X6Cm8S
         8uK7VH0fmvASzh9IhhLcfb59zsvyjlIfw7zdEkMVBE3n7hkyyRBb6p+wfOPwspZ9/3Id
         gLGJ8rG2734XbsGCk51DEuvnCcZNC+7R8z1RctjhJ8WTkvdj2o5IThpFAQujpUVh6p8F
         W0kkDE3oEG7cdGEuWXwjWYEv8ncjIbIKbK6BxmVozGxHapf3ALH54VYtHjYf003cfZ2J
         Nx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYPdgZ7nPpIVaIKgmsrbhTWlprhK6SZ291bTzHEbVOWLBdKz/cVuVdiawXl2CLuJycbUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21dwy1eNpIYaD/tI1mGifcyVYMUqkw8f8ss03typ9YIQAY+xA
	TZzYDfRlSlMD7cBAxsULDkH8NgiET6Amt/8nU9mBOuJWudBBDpVLeJUtqz8u4UQJP74jZV4ifcv
	SuejR+UKi8haE+2jAehIc38gJoqLllxGo2Du6
X-Gm-Gg: ASbGncv9xQK7Cv9UOKhnSC1Gx86BAHgxSVETvJxA7hGSxNu/daiWr6P0Mv/sKNyFACA
	Wzn53RKR3JK20KylTzCkSwyHeTHAZbs255eeSVC4ixIH35zdzCksIxhhtLiEV4mXEuv7Z8Yfr4c
	eF7nQLSr7v7HicZALJO/Cr8tmxX/5O1kqC/py823bH/kbkItwJ9UZPbsSDNqut+baipkM=
X-Google-Smtp-Source: AGHT+IE0uygYy8362TdLKoomt91hJSt5mkfEfvtst6WkOH3Mdde7pi0CNJfa3IQML3mSLH3N2ZhoHYFf/nNE3uj+Bjg=
X-Received: by 2002:a05:6102:b12:b0:4e2:a235:24d1 with SMTP id
 ada2fe7eead31-4e6e4acb476mr8801807137.4.1748860539365; Mon, 02 Jun 2025
 03:35:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 05:35:38 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 05:35:38 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-1-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-1-587d44252dcb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Jun 2025 05:35:38 -0500
X-Gm-Features: AX0GCFsMUIY6DOi3a7insQeBwv1lSUuiS0tZYw400M2KKTetkaCRkV9dy16uld4
Message-ID: <CAOLa=ZSy5XoKJ2OaKv3DukY9ko-pkpa2zHLQneLwq=9+wJnYWg@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] builtin/gc: use designated field initializers
 for maintenance tasks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, david asraf <dasraf9@gmail.com>, 
	Emily Shaffer <nasamuffin@google.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003605cd0636945385"

--0000000000003605cd0636945385
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Convert the array of maintenance tasks to use designated field
> initializers. This makes it easier to add more fields to the struct
> without having to modify all tasks.
>

I was wondering why we don't catch missing field initializers when not
using designators. Seems like we explicitly set
'-Wno-missing-field-initializers'. Perhaps something to slowly tackle
over time.

The patch looks good.

[snip]

--0000000000003605cd0636945385
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1d65ce7a62a18f61_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nOWZuZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXJOQy85U0pKRXNPNFF3RG84Wi9NRUpWSmY4bldaLwoyOWJLcjk0Rk9z
UFZiM3Bwbkg5RlJ1aGRRUGpyRnRtdVpRNVk4OStxNE1FSmtkcHIzMWZLV1NidnNRSkF0OFlSClpN
Z3ozYzM1enN6VHdUOW1yeEZpOGZrQjdGVDlOWlBPVERhV2V1ZmRPNlVFN1FLeGkxOFBDWENPSWRR
eGxGUisKZlpnVW1JQ1Q3dUFEcTR2Rnp2QnJ1V05pZnZRdnl3SzR6dlQ5QXZwQzl3YWpmeEJVZkFB
QzZrcDJnQk1GalE2OApvc1FRMzJsZm5sZUhnZmlJakxVWVVrTzJYS2NOUXc4M1FrMUxrOHBMUzdQ
aktPQ1I4WnhmZjFFVU16MEFZUUk0CmY4SEk4UHFKUlh4VHUxSDVVSmwrc2hHWVJLd0J0NmhjMG5p
eEd5ek1XNWp2NDF4S2s5MFZDdDc3ZnBSeGxwOHIKaHBwK0daM0RsSlprOWVOcGtSdkd0WERCNnU5
eG05MVZzL0pJY3BhTnRWNWE3Mk9ERlBQZGJVWDdjQ1g0emIvMwpaMlZHdnkySVVFSExPanBIUjRV
dlIreWVKa1N6OVVSeEFKWnl6c2hvckVTbTZKUElNU0o5SHRGRnRUNDVldmJjCkZUek5uVkdDb3dK
Z0xGdk8xS2tHUEppckFlZWJZNzFjdkQ2SHRyMD0KPThsOEYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003605cd0636945385--
