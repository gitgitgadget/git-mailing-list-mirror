Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA81F951
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984796; cv=none; b=EizTh2tUstxm9SrUtTdkUgxmmpbZabe4lZ5V6csuknadb03BEZ/0qfoaW975hmJOINnFqzdaogJsMyFiVrWehU07/xi9V/klzIZpNjIMbejk4fAmLZU3pFtHA+EKM+6ES9fHAc4vjlZ93wZa/vjXpunYvEgr0fetOacPk9irNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984796; c=relaxed/simple;
	bh=izZ1shifX4tZDxj/4FyqMfamgQCCWYDNrA2wfgV03iY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmpgVRAntRZCduIOjXhUnQTIdqKMkFV4TAe1JNWG+70D5kIwItlgRImPi1V6zwzmGqqrGEzNa8KePhPIUoXQnWG0YNHjCQl+ZWIOC7x3k290mSoDPxNdGHM40HDDctzV5dTVfKQ+NV2BwO4x3rmmW7J96iTGKJMW2y/2AdtyHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPVa1y1g; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPVa1y1g"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093d565310so177792a34.2
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721984793; x=1722589593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=izZ1shifX4tZDxj/4FyqMfamgQCCWYDNrA2wfgV03iY=;
        b=fPVa1y1g3Fjf9zLKhjiRMy5Ll3atzDkNkogsvCbzGFxK6S4CEBEFOhx4K+gVnrd9m1
         skWj3bMvFcnsYb30tItWOqCvs17rvoatdjNL6ed8GMS85Nyh05R/X6+bZMQkF3REvq9G
         t0HGLMvtokhsEev1zQ/UD0kcf4m9Brfv7QmsQ0ORHpcPJhhx47QEbGVPQIBztSKgDGKw
         oIqFy4gItCR/kqIc5LO7ggk1qExz1Md3JxlH5+NHuGKIxpYPq7sA/0ZhMbFwBESVEW4E
         Lbj4OTcjwLhwWAMDTiidtV3STjaYsU48nmG7QGtV8aXxHqObeZ2gD5SzpQcz/1FXw9vN
         nnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984793; x=1722589593;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izZ1shifX4tZDxj/4FyqMfamgQCCWYDNrA2wfgV03iY=;
        b=L/waVvvGu+3YtcpB88JD09HthBaO1eyC0CrZcGam7m/3/VV8bg2IcWUXq54OwB4KY3
         Nh6ZqEwvm1fDBvfr7zMVWijBHGXCKYQPuhr5qCvI62F6i6uI8rfYYfbEdaBT42xrIImq
         AFAokh1vY1Q5x+BmBtrxCFFop0nNsuEWUZMJptyRv3K5GTCkLXhmKw3pYZvY7EBJzaVw
         u4IynK7W2tU6imiNDN3uFZn264BxZrCKDKEcc43UQpsY8Ob3szjbiqcsz59T6e2HZWN3
         xZeePQACL3ein7B6ldbWjugy/BugE7TF6TMOtmYD2Jr7+81hF61dQDQp3KXgjqCku+Gs
         NGCg==
X-Forwarded-Encrypted: i=1; AJvYcCXYjgh1uAyKJabmjT9GR6HLlRlQkx2v3wTSCvj5u0fy+XheudKPiwIcKN7hrDfLZBX8kaE044hijptjNbAnH+geStQM
X-Gm-Message-State: AOJu0YzZhs/38rgHbP/NaHNIFzYvLghNbUcLf+3k7WGiVq3HT12hZ3ww
	fTKSDUMXWo3klebaReFc7Qk8rEKPzDtWjrl1HP0JuHlT4s9JXOmJifA7VMBQ4xKcLUZ+sv00jHs
	R0BX+I8tMFtL3tHLrPx/XJ8xLjqM=
X-Google-Smtp-Source: AGHT+IHyc5tgO1FDDy4oKQnw7u+v8PfiHo9/WAFd4SZ3BUWosGDGac68oaipSrJvWwYJ9nlyGHyYu+IqwIUYPdWoL+0=
X-Received: by 2002:a05:6870:280c:b0:259:8b4e:e71a with SMTP id
 586e51a60fabf-264a0f7491emr5933671fac.46.1721984793599; Fri, 26 Jul 2024
 02:06:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 02:06:32 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240724144957.3033840-4-toon@iotcl.com>
References: <20240722080705.2614195-1-toon@iotcl.com> <20240724144957.3033840-1-toon@iotcl.com>
 <20240724144957.3033840-4-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jul 2024 02:06:32 -0700
Message-ID: <CAOLa=ZQ5bvWuBVC7FuT6+C2tB9FXr0mmexvBycRwUf6Ak_c_rA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fetch: use bundle URIs when having creationToken heuristic
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000ee8243061e22d334"

--000000000000ee8243061e22d334
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> At the moment, bundle URIs are only used by git-clone(1). For a clone
> the use of bundle URI is trivial, because the repository is empty so
> downloading bundles will never result in downloading objects that are in
> the repository already.
>
> For git-fetch(1), this more complicated to use bundle URI. We want to

Nit: s/this/it is/

> avoid downloading bundles that only contains objects that are in the
> local repository already.
>
> One way to achieve this is possible when the "creationToken" heuristic
> is used for bundle URIs. We attempt to download and unbundle the minimum

This first sentence reads a bit weird. Perhaps, "One way to achieve
this is to restrict the usage of bundle URIs to the 'creationToken'
heuristic for git-fetch(1)."?

> number of bundles by creationToken in decreasing order. If we fail to
> unbundle (after a successful download) then move to the next
> non-downloaded bundle and attempt downloading. Once we succeed in
> applying a bundle, move to the previous unapplied bundle and attempt to
> unbundle it again. At the end the highest applied creationToken is
> written to `fetch.bundleCreationToken` in the git-config. The next time
> bundles are advertised by the server, bundles with a lower creationToken
> value are ignored. This was already implemented by
> 7903efb717 (bundle-uri: download in creationToken order, 2023-01-31) in
> fetch_bundles_by_token().
>
> Using the creationToken heuristic is optional, but without it the client
> has no idea which bundles are new, how to sort them, and which only have
> objects the client already has.
>
> With this knowledge, make git-fetch(1) use bundle URIs from the server,
> but only when the creationToken heuristic is used.
>

I would say that apart from all this it is also worth noting that bundle
URIs are still opt-in from the client side.

Rest of the patch looks good to me.

Thanks

[snip]

--000000000000ee8243061e22d334
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ea147a6d744de867_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1halp4Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2IvQy80K2VwT09Pd3BLc1JkdGpzdW92dXgzMjNERQo3am1ZYkJ4SjFV
ZWVGRjVJd1k3WGVia3dPT3AyUW9PV0ZVUkVoeVl3Z3lzdGkvWmdWUW50djh6SGd3MHZMb3Q1CkVK
bUFMaHVEOUZMZGhCQVEwVTRVckFHWkZFeTZLN2FVUXNmQVAzRkJnbXh2eDlaQTB1MXR6ZGZETHpz
dnA0cXAKMEk3ZnBKRDVQWHdaKzNvRVlSOVkrU2ZYZFlMZzFmbnpPeU9BTk5wakdkVEFmMlpIQzI3
QXI3VlZYMkNvWW1HMwpnejdIU2F2QWUrUkFLcU5qaXlzUnh6NTFBMmoyR1JLOUdMVE9OTzZITXFP
a2MwMytRRlJibUVGNW9lZmN1TmNnClg3Mjc4Wk91N2VDU1NnRUJ6TUlTQW1vUC82RzdZNENScUFw
QlZ0eHd1eUFFTWJ6azRMcTJIOXp5cjA0SktRSkIKczdXUENUb3k1Y2pRSUZsK0ZiVTZ6czdIUGRv
Y2M5NEdnQ0FHSExuaURGZUgyTC9ITXNzdjFYNEtxSDQ2TFhMbgoycHZ5a0lZNzJjZmRzTjcrTFh1
MlpKcVB2MFk3UE5mQk5ZZnZiWGhreElBNlI0MVBIeHhzR0ZJdEpYWUduY2JDClpEcTdFWjA4RmY2
WnVseGJZTSs1bU9acm55QktIZDI3NXJ2SDFOOD0KPWVXMkQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ee8243061e22d334--
