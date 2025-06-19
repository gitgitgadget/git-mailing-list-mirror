Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340321B8F5
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335493; cv=none; b=Xjac0fykOe2jFG5MWBvGdFgMSEnNP3MOCmXRWu6gb7fqVvGMSiXd2pxMItkr65bj0oP7JshKAmY4vd4GxWTuwPaIpPBkuPlxW4+EyQ2KILrMHv0qVjhYpRJyzCyDn0Y4RN2PAaoHLDf26VMRcgZtdf4+XifCGJj61uSIOmFwUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335493; c=relaxed/simple;
	bh=+QH6+SgykicBjzV7LdWetyqr+cFer5hVqXeyNho/gOM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCJQK59cRYg9Qi0PN0sWtgU5BZP0ec+oiKXMT0bEA1KFjTZqgDjf1aABg5I1m/pI8hXx+y1BYDLaeJ4MmRXKFY285+xo8IA6yC88fjiLhN00sFyG98aek92oTeT7Ci3xnESvu0IVFmb2BMMl7eyFeXU9ULB7WtPd75q6z5IZxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vth5PKjU; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vth5PKjU"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-525da75d902so206353e0c.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335489; x=1750940289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NW1JdyozEhLFPYhgHFcPPkF+V6NuwfhHB/R6Ix0HKTI=;
        b=Vth5PKjUrDQXi9dONhwx+0buEYkCpT/a6JCQi8bqISWjqc+enICdrZAAljNS/LBPw6
         NYLdUnA3m+QoltQ2xi8VETlVTBwjLpyaPq8B0bGljwVpWodLD6j+b2/iKmA5IAJ39a0c
         aDGs5XSaDxd1uGkwiIRS59mA/1zvr/dD/tVRiPs8mU2MeNZmWXCHaRIHdDkSbr1LfWxj
         e3i8ZSe6S65lR3ORR8U9v+7YqhkbakcA40DhmlvARqTMFAqMibhVByGCg7l6CoxE9QfG
         r4Tl1m1vUUG3MULbNw86sTxz4fg6T5TPcS6HbkLPJzEkUSMEns23PKoQtrIMjQQii3fd
         0ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335489; x=1750940289;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NW1JdyozEhLFPYhgHFcPPkF+V6NuwfhHB/R6Ix0HKTI=;
        b=QjnZfkcYNX3WqHTf2Gj+FrBCmxJHk2kDwi2tOtKaMUlM9ZJlcSMh/zRviwSwpQb5QZ
         frVtXeiJzR1UeVSosZxOPAcEoYObvW6Phi28g+CWraBJn2DzZwwYOzk/Q1/pupkp84Se
         7b2QqltCWq/GXHUIoffW3NdSmkhjOIJQNyBkYQfmHpbMm+jUbfh2BSHGQZTpo7HX9udl
         SM/lpoiu3Z8TkkQ8jU1S/wmXkR9FZp+rFazm7qiaK4JH8vRoGQ9mh+8uSkWe3lUFL5cu
         lHEyBozOiJH7srp3/SA9wS6UcCNKFMfzSn9Bbi16DCoYNev8Ll1daEaKLMPNP/Utenua
         ZULw==
X-Forwarded-Encrypted: i=1; AJvYcCWNHLu1y/JWMP48+iAswrJAhmUsWtczxi/vuqWtseiQ0FN8RCuZVTbMq/esKH87xN9uK1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye5yHhUiMHB1xACxIowlZcOStyeRDkwdxfzrVX74928/CNWB0+
	Ne6sUr1K+cuci0qW6PV5NSZx6UasIFkfvQQrDFM2zHF1gdBFj/acBILri0rXZue0rhe32kgWjEm
	Ta/R7loICli55KsrNenHgcMsCl5oIngLwmp4IeBphmA==
X-Gm-Gg: ASbGncvUKmfHKMy0/6PfqWn2lvVdhVs7wjxj3eyDoQEZ3dmzVxk46tZ4j1VJ4ydI7Sq
	JM2z9PllQxSUy6vny1F+Z4mW0UFoJ7yI+LXcQeNuO6pWb/nNJoUqMO2mWZNkpw8ZFk1KUufA4d9
	Jg4qh7tZxFqVf86rwUpGPgmqcVYuW76WRPdcZbwYHa
X-Google-Smtp-Source: AGHT+IG8ElhLy4Br22JKxaLwF5Iaff5JzK1tP/Q/i053JG4prwu0fT7BQe/RvI5N6qISZyPL52BJ1zBxKX97i0UZVms=
X-Received: by 2002:a05:6122:251d:b0:530:6538:cb12 with SMTP id
 71dfb90a1353d-53149c59675mr15208553e0c.11.1750335488404; Thu, 19 Jun 2025
 05:18:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Jun 2025 07:18:07 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250611134506.2975856-1-christian.couder@gmail.com>
References: <20250519141259.3061550-1-christian.couder@gmail.com> <20250611134506.2975856-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 07:18:07 -0500
X-Gm-Features: Ac12FXwpVLpicJlqoToo3QedeKF3-qIJkWirXgBqimnWnviOPzRTe47Z3W8aOTo
Message-ID: <CAOLa=ZT9c-4Wb3H8D_7TcUteyuyDLgZZAWFkg-CWHLOLoYOBvQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Make the "promisor-remote" capability support more fields
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000066b200637ebbddf"

--000000000000066b200637ebbddf
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

> The "promisor-remote" capability can only be used to pass the names
> and URLs of the promisor remotes from the server to the client. After
> that the client can use this information to decide if it accepts the
> remotes or not.
>
> It would be nice if the server could pass more fields about its
> remotes and if the client could use that additional information to
> decide about the remotes by comparing it with its local information
> about the remotes.
>
> This patch series implements this by adding the "promisor.sendFields"
> on the server side and the "promisor.checkFields" on the client side.
>
> For example, if "promisor.sendFields" is set to "partialCloneFilter",
> and the server has the remote "foo" configured like this:
>
> [remote "foo"]
>         url = file:///tmp/foo.git
> 	partialCloneFilter = blob:none
>
> then "name=foo,url=file:///tmp/foo.git,partialCloneFilter=blob:none"
> will be sent by the server for this remote.
>
> All the information passed through the "promisor-remote" capability is
> still only used to decide if the remotes are accepted or not. The
> client doesn't store it and doesn't use it for any other purpose.
>
> Note that the filter mechanism already exists for a long time and this
> series doesn't change how it works. For example, it has already been
> possible for a long time to have different repos using the same
> promisor remote with different filters. See the existing partial clone
> documentation (like "Documentation/technical/partial-clone.adoc") for
> more information on partial clone.
>
> The fields that can be passed are limited to "partialCloneFilter" and
> "token".
>
> On the technical side, we get rid of 'struct strvec' and we use
> 'struct promisor_info' to store the data and 'struct string_list' to
> store the 'struct promisor_info' instances instead. This matches the
> latest suggestion from Junio.
>
> This work is part of the "LOP" effort documented in:
>
>   Documentation/technical/large-object-promisors.adoc
>
> See that doc for more information on the broader context.
>

I've left some small nits, but mostly this version looks good to me.
I don't specifically see a need for re-roll, but will leave it up to
you!

[snip]

Thanks,
- Karthik

--000000000000066b200637ebbddf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 397ef57e20a05374_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oVC8vNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVE1Qy85M0ZKaVJoY3FyK3NmWTgzOHdvcE9YMUp6OQpIeTdxbURGbXBY
MythSWh5S0lOMS9tU0RydCtTTXQ0TnlESHcxTlBmMStLS0pyYlZMZWRNdHBUcWdnTHRxejhTCm5V
ZG9ndjY1S3Q1WU5zNkh4OThMaGlMZThZc240Qkg3UnRSenJEWFprd1dsNFNtdnNLM3Z0NzJwT0l2
SHNWT2IKTG9lMlVKODVLWkFZZ2swNytGbDluSWNzRFk2dUJoaHdYMHhIcG1KekNBWEdWcjhRaE9N
c0g0bWlWZkVpR0E1cQpBMExnRkoxUU9tcnZwUzBvdnJlZGtiUGNML2JCUCt6VGRqN25KQlpNV3ZZ
THhaQ2RuUFFEalphZXVuVWl6NUxGClptS0VxVkpTNGQybmtZa1lScVJGdGl5dytocjNlUTI2KzVT
aVpOL1FvTjdONVdLV3BDa3JiVnhiY3E0RzJTcTAKeWFIb2ZKb0k2Ni8ram1iQm1ZTjZxM2JFWkJm
ZFhTMXhDVXNTQ3ZQdnVOK0dXbUp1MFQxVm9zcUkzNXhBVzRSMQpVM1FrOGhMUUthSm5lNFZtNm5R
WVNEL1dKTmhJelFUNmxjYW1RbzdOUjVmbGJUQlBxQ04yaWJXT21vZ3BEQnA0Cmh1UThVZEVtK2NH
b0VadHAzK3pORUNwQi9iNFFMdC9ZUkNaREUvYz0KPXZFWTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000066b200637ebbddf--
