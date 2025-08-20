Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB71F4174
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698149; cv=none; b=d61rno/4YTFu5X4Zy+Lvc5d0c91uYGr+rZCpIL9tRnTRAWGun1+rg+k5vRKDuRpzjSbs27jX4OfZWHtWgcLPuhCQp5cxy6IEDtFQfE7ZgNJ869sdO+beaxGQSD0S16yyNUWqWC1O9138QzphegVjytBO7Ho6ei83tEHr6Q+sDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698149; c=relaxed/simple;
	bh=oaCInsfpaVAU3RwgBki9OD1+cv7ChQxvyCfCGjS+Y4Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=eaVWilXXCGXQE9pVlkf1vbNltkRRfDF7P1Q5y8Uk8Db1BOcBnFIbN1xXOXwWxw54QOat8KPBocAbWGiJ7PcamCHrxO5a2klsXCdynz6Mna636SC99B7KPHFcWAU/Ms4gqWJxTEsUOj2z4iOr6Uc5Q341ZPJ6GitZy956ghJDNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od+phUyY; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od+phUyY"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-50f8ad2176eso3820816137.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755698147; x=1756302947; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtjecCmwSHMjmakPYOBlZnblhgClxQ3DlOv6VtlsDfo=;
        b=Od+phUyYQU3TYYS05CxeTcLcuLqe4jI8Y21ibZHKvslRXbP7k94dGYDZVKTNQpi7wK
         YvWQOgsVn+t6H9B1NA/wD2RG8oShNN3SDWZ3JiZNG30A/5yPE6CNpI44PNbFgvGozAAY
         Dcc4xEFkEJnLo8H+3JRJFmES77gEL4u+FbZLowJC/R5cw4bBmP1jtZeOl3syZLM4XlyO
         xJ3e4fK6ZNmUJyYlcdWTSC/FCMVZP/lNe8wyE0Z8xttNg01o44nNqiOgSMA2FINUQ+CY
         Zeuq1n0aoHBREcARUNfRuyUvbyDwihU0VGtmVu59uezJiqA3yNrCD4TLyQYCcJRuktTs
         /MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755698147; x=1756302947;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtjecCmwSHMjmakPYOBlZnblhgClxQ3DlOv6VtlsDfo=;
        b=d7IqYLQpXffWces/QUjS2Q3Ka3ITnyvoPHlbLA5ip/Vg2NRJSof5u6h9FF2liBAXxR
         gXmoIyBVR2L53Qnn3+JegNh2IRoYqviKtOR6HDSwGDN0VuSQV6U3MDYXHH9vPc7GOlWE
         m6j5/hHUYqoiQahY+7zers0LtSRfI2dHVVE9jkh8A5/0U5vnZkR3/4hlFHyNhgroTOXn
         VKF8xg9wS8g78Pr8I7befirQAoT/cDe7IjULeYTzjQHkL5GAQjmdXXuMg3iIaslp9EO+
         E7LPdK6FpGBAowc4Xkp0gye0yH2JHZ4/1g/ustBXK3WLgOoEVpiskeGC4pGKxnSzhmT/
         mF4w==
X-Forwarded-Encrypted: i=1; AJvYcCX/1EHOHbzp7/+Bpzl16HXNS2JghMjpbMq7fw7SMUmfq6kwb9s0SYmJIr2W+TdB522EcUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhBirmHSlmvqBo1IDgiWrnEKTb0eUl6EeOQDPsIwk8BA97pErD
	m3mSrz5s6rihdWUFyKBFgj6Kd686N+PNG2AinsNp79+02BXo93XtMeHNOSR0DYaWd1lqVwEM50i
	Jd1UQ3+LVZX0SyzCRDhuyI3aiQaIZioaX0A==
X-Gm-Gg: ASbGncvy0BlmEacNG8NZbON5+fsjCY5DvAjgxRoNjJ33RDqWMUp8cqYn5NWYGt4/hNL
	RCKPrF1Zyo6J8T8UXlgnh/d7l3pr/6o4l+cXSeKjoUKezuwn0/9jlEt2WFbBCWm2uJqlQzuri5b
	ZfTSq4KLK4kwRK8XHSTtJDpCVFGc6xsniLc0/C21WtuWHOsTx2i5BVMoPsFjEuT/LUxuramSN/l
	eQFLU6AU5C+PIdK
X-Google-Smtp-Source: AGHT+IEqmGS37GFScfZaffgCDj3Q4BS8GgfBupWyi5dtqFADZYu+THElJk1hugyB8/nYTzT7Ab+EW97ALK0tB3Rx0M4=
X-Received: by 2002:a05:6102:358d:b0:4f3:36bc:554e with SMTP id
 ada2fe7eead31-51a50c81da1mr949409137.16.1755698146913; Wed, 20 Aug 2025
 06:55:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:55:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 06:55:46 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Aug 2025 06:55:46 -0700
X-Gm-Features: Ac12FXzxGX9GK-GQJVq6x4y1sNImwLJ1XNySiIEqenDr2mlMnX_0XF-2og2c488
Message-ID: <CAOLa=ZS9n6cnrH5OOQL+7ZTjAqxLdkBOSHhQShkRTtJ5jr+_RQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] packfile: carve out a new packfile store
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000061a4e7063ccc5451"

--00000000000061a4e7063ccc5451
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> information about a object database's packfiles is currently distributed
> across two different structures:
>
>   - `struct packed_git` contains the `next` pointer as well as the
>     `mru_head`, both of which serve to store the list of packfiles.
>
>   - `struct object_database` contains several fields that relate to the
>     packfiles.
>
> So we don't really have a central data structure that tracks our
> packfiles, and consequently responsibilities aren't always clear cut.
> A consequence for the upcoming pluggable object databases is that this
> makes it very hard to move management of packfiles from the object
> database level down into the object database source.
>
> This patch series introduces a new `struct packfile_store`, which is
> about to become the single source of truth for managing packfiles, and
> carves out the packfile store subsystem.
>
> This is the first step to make packfiles work with pluggable object
> databases. Next steps will be to:
>
>   - Move the `struct packed_git::next` and `struct packed::mru_head`
>     pointers into the packfile store so that `struct packed_git` only
>     tracks a single packfile.
>
>   - Push the `struct packfile_store` down one level so that it's not
>     hosted by the object database anymore, but instead by the object
>     database source.
>
> Thanks!
>
> Patrick
>

Hello Patrick,

I took some time to read through your patches and comment on them. I
only had some small nits.

Overall they look good to me, but I must say I don't know much about
this part of the codebase.

Thanks,
Karthik

[snip]

--00000000000061a4e7063ccc5451
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cd89b963cdd1b29b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbDArQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMk5IQy9zRVhVMWxQdEIwRWVicHZ2UTZvM1k5WXF0cgo1dlljU0l3NFZm
dGpCS1FvbkFVK1NKek9WempVcEZXbFdYRWR2TzRldkZQREw5NEtPQS9JZUdTdUxJekJxWGQ0CmUz
OGRsTzIza2pIdUFKVEh5MjdsMXZtUndpT0dITGgxRTZDemtxQm5wdUhPNDNIQXVHNkNIcjJITEJR
RkxhdmQKUGVwZ2V2N1FhVEdzY3Q0L1ZaVWw0QVVPdkNFVXZ2MUtnMWhBUU9GSlVKY0dXcENOak9a
d2oyM3I4YXpPWHRDZwptNDlyRkVIUjlhTGNUYTZVQ3pMMytQaWI3cXBGRWN0UFRpZzdESHF3ZmdY
THVWcTNuYzVCV3ltQlhLZm1oV2pvClhhMVZjeXhmZFhGYm5QUHk1Y00wNnBPZlIrY1M1R2xpNk5C
L1dkWmtlanIvVnFic29COWJvUmV1K0tWOFgzWDAKOXMxaFptUUVvRHY5K1VrSmRRc2lKUGxoTmR6
cG9IdVNMRjE5RFJUU2Y2M21pMmpSOXpndStTU1JEK0FYZnNlagpaTER5RlhlbVNpVHQ3N0w0TXJv
VG9oK1l0blAzQkRUTFNlQWV2NGlJOEY4WjRBd1JZcE9ZdmNNcTEvR1NBYkJFClhRUTI1RlE0Wkhp
UGtJTnZqbDljcjVodVl0MFVISkRDZkduOHlXbz0KPTgvRDEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000061a4e7063ccc5451--
