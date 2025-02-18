Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2D234973
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878978; cv=none; b=cs1eRPPmRVzuVbJEZXh5v4eKU+ubRSRyNZjMS5bwHPUxVU3yb+9fSUo+mP9HwC1EiN9oXzT9YgvUd3JVWOmKo7+Uu8qEvSWmIraKdtLef4g31s1S5XlZeUtQUMge5TMw6OyguJmXCJ8wh5tq8i/FJcTRDfKd9B/LQcokjktZBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878978; c=relaxed/simple;
	bh=5Yp/fsbhh3lTrXSj/eJcWSaj4ehIiT+l4AhfEsf5Pps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyCqMnnI3K3OWVZI4WAwSEbPabYpGWt8LVBWwuQj21Q2kk7s+yyu2o27rhQYPsx7uC+xvuYs0WxMqCZmZL5/gc4pvA2HBCSVDLZE58x0suppFyBJisBoWcinG/ob3ZYrc5QLii0tc7pWVG9yfm2PbVWnBNWmu9yqWAWfFAfxblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuLXnZN4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuLXnZN4"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e05717755bso3142611a12.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 03:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739878975; x=1740483775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6eRR0z6mDdFiVYmE3x0pTlwPLmy4jegKopwsxaBCPo=;
        b=KuLXnZN4dp5I9Ubt9ErolQRy1q7TXAMPkmj92XmuI6AUpao7YmzTKjobXwY6uF0hn/
         UXZncnU6F0kBNTOZxfOIf0hcvuXvfb5HsCppF5s6RuHzpq3zl1hqgaqNc2JopfW1yrAD
         5Q8aSOm3cB8y85/Mk3fHzEzHip0uuWHvpCiARoLdqBc1EJjG9NUtv1iY4bmGm4W6Lpgh
         4aRot/fHk4g0pOV7mVDgmlqwDVRmWsIkZgVUdcjp6az4W7eQOuY6CJIf+jWs/0xniUtF
         NSRt9oRGVC19Z7sJ21Cd8nlmqmoIDVxWB30VHoTy3kzQoc+cAbhHuCuZrF59VOuzPx9L
         An9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739878975; x=1740483775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6eRR0z6mDdFiVYmE3x0pTlwPLmy4jegKopwsxaBCPo=;
        b=TyTeKVN8dCkU6SNgN4jAXrQcxX2WfTxWdXRiktswEvru3XWY1q4HlR7Sghv0FP11IV
         tPNklQgDrnIgOoYQhFtQ44EVczulp/cYBeK726tmochn8xNTKio/84K4p/2FrMlDfmfv
         JsOmsoDamVn92yZ9Ya8YbtSIjXlvcOeY+B1Cjpl6cM8vmUVbuwSh+FGGuIZ+R8x/Hrh0
         4YAd0qnDOl9tptDpJNlRMm75YEfLDkd5t8ay/MGMfS4SFKn3qeaG8+QkAy8bD8hZVgTr
         TxOZfSFuKP7kUsU1VRaf9M4WR7x/rd3+LnIIvvLq8o3Iqo2CESCiTQKMwO7AwTAKsrNO
         A6sQ==
X-Gm-Message-State: AOJu0YzAD+8qXM+Ddy8ix0lLEpbyeDj0I/Xob0N1Cf54PMQCxBxT1rxx
	kkqKnrM5bFpiZmKtXTC6UGCVMYySd8mzYhzWG6ovwV6z95oTZ6oGn/76LiWbheNFvvqGstMih1y
	6mACnjpi4gl+kZ5AnQyUafiudELc=
X-Gm-Gg: ASbGnct7vHNsQ8U95KQNYl/R1WhIpOyLLAwJ0kEv9i8b9mSElTQx/FZsOC6n4aIB3bX
	qeBuGIopmTbHxPGkIa1b2bNJ1+C4Bqrppat/ONj1lYRYxWlsMY8iM5tb+kH5BPHcJ4bYN4Tu/GD
	U=
X-Google-Smtp-Source: AGHT+IE77JHMyPzS/o6ZPnpnSO2XxVwN1YlEiI8aWtE2ThjhBCdD6ei+D/H0qZkdOmyYUx9e0El1lGE7R/Ymun2VhhI=
X-Received: by 2002:a05:6402:42d6:b0:5dc:c9ce:b022 with SMTP id
 4fb4d7f45d1cf-5e03608c94cmr13123506a12.9.1739878973920; Tue, 18 Feb 2025
 03:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com> <20250127151701.2321341-4-christian.couder@gmail.com>
 <Z5tZpmmNpjC5-uFH@pks.im>
In-Reply-To: <Z5tZpmmNpjC5-uFH@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Feb 2025 12:42:41 +0100
X-Gm-Features: AWEUYZlXi0dGeMr-dJ3W7VOCrwDhQZUBQtWbSRd72DEPgkQfaAiXQBCOwjhMX7Q
Message-ID: <CAP8UFD2dWCz29Q6yFbsUsQirxD0A1Tm086SHTczZRWJvwtDkRQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] version: make redact_non_printables() non-static
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	"Randall S . Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 11:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Jan 27, 2025 at 04:16:58PM +0100, Christian Couder wrote:
> > As we are going to reuse redact_non_printables() outside "version.c",
> > let's make it non-static.
>
> Missing the DCO.

Thanks for spotting this.

> > diff --git a/version.h b/version.h
> > index 7c62e80577..fcc1816685 100644
> > --- a/version.h
> > +++ b/version.h
> > @@ -4,7 +4,15 @@
> >  extern const char git_version_string[];
> >  extern const char git_built_from_commit_string[];
> >
> > +struct strbuf;
> > +
> >  const char *git_user_agent(void);
> >  const char *git_user_agent_sanitized(void);
> >
> > +/*
> > + * Trim and replace each character with ascii code below 32 or above
> > + * 127 (included) using a dot '.' character.
> > +*/
> > +void redact_non_printables(struct strbuf *buf);
>
> Is this header really the right spot though? If I want to redact
> characters I certainly wouldn't be looking at "version.h" for that
> functionality.

In previous versions of this series, I wanted to put this in the
strbuf API but it appeared not to be a good idea.

Anyway, now I think that this patch is not needed, thanks to a comment
you made about the following patch. So we don't need to find a good
place for it for now.
