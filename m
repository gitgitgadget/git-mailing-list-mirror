Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B91239E9A
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424067; cv=none; b=f8cn7H+zVqGxMI0ur8xReJlRv+SWFfSC1axhL9ClWi+3QtS0ayx8YHxJngRRnixa6EYdy8uyyZkYuMQyzWLG7tyGKgamOBRSerWbEywa3xHl3bZ6rsKXQ9WCwh8UHRjU/FwTNDRt/QZXNDOKRdoZAlPkHSUkJCmYzuJQosFrwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424067; c=relaxed/simple;
	bh=oeebH3u3LzBsfgs+TqgbrRgnCv8zF+Znoh4/LblPIv0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=jlzHaV3lN7AMku3E0sfnEa6S6uoopqeR5j5LAbiV0OpdeuIdjwxX57D1MRbwNb6zB/IOTSgEltAZzUxUCWn4s8sYXEKNw5ovKgCjgzguhgjr/arw8xGAHS0TUzyRXqmNoEVRbJ32QiuLch8mY9IX1uvtIYFHCbuMSnVHp6IAGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mor6Mu7Y; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mor6Mu7Y"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-73b4e3d0756so14839487b3.3
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759424064; x=1760028864; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6Nm8okrfdkJq8ECxBi1ZJoOMEnig9nyNx17vV4EpGo=;
        b=Mor6Mu7YDhGiO3k7GEc8TqpDGyjxFbbc9eX4b39BdTTDa0kXXnk4hVBxbhf0xW0WJn
         Ujzf6nyYo/wLnBPEq4ehUw7Em8JKcpljKVGDhuDPJQNRcvOAzJWOc/UJ0vEoMQet8T0Q
         WMN4KLrAW9DnEgGI891lPe0EZ50o/69DywM94GngkCNLbZknEcN3JqjsCPSxrbA1pdAj
         /B4G2SIEC4Oga7id8rYS6WpHwByzqWhRViunrqk85ihveuh3jX7HZ1rI2CdbaX7hgLOh
         OVqU0roVdzpC84UKblTyLf//dWzffxdh1Ct5elQtEIE9s6HrLk0e59NHvZDUbO44Hsig
         5kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424064; x=1760028864;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6Nm8okrfdkJq8ECxBi1ZJoOMEnig9nyNx17vV4EpGo=;
        b=edC0S7SZRW6OlHnYG6VAaSzUNroCLICTwq2hKFODOyWq0xkRT7QcOEs5m4ZDbG/Cmx
         vMXtZWmryFj5+a2M1Zubvy8S6vs0GQ4+yuy1xgpTXqk607oSAo+7LDN7SQ/brWFYnPDB
         zNH0Ff7cpxBYcilvR+cgch6zSOFZthUYJp+DSOj8l2l3w3rGEkDC88TLqYpRILiC0s/h
         /L8TJoHh3Ncz6nJi6ytXeniTyZJil5Xb2YEWTuDpD5sbLxO9ZxwSIzAK1PAIrYEBM2D8
         P4j5E3l4j/qG2owzsLkWt5+SNbQ4/w8/VopsjjCYIRF0GsCevMy5/996vMdAizH7Kk6P
         Np/w==
X-Forwarded-Encrypted: i=1; AJvYcCUeha5TWbwi2W2raHoTdLi24wqnPrLGatLUiU2m8NZGxw2uTBkujiCpMhQ+VjC11Hha1N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUGYtHehaPFA4YRbMd04KNLOgep0XaBUzurt580J15R7f8jTl
	mW5WEQcrIrhKRotXdMrZLaKNQCIKXCNFTqVEuzbKo5XxrHtul6cW9QDOQjFi+T8T
X-Gm-Gg: ASbGnctyJs7YoumR8pYVqHjlhR7UjU7t3ovSrnhwjyp9kAg8xjIQ7sEsKpUT3lJb8MB
	EXPYAlKnyI0QNfe09b/jDAvAEqBjRcHIvUcPR7GXiEntlQH/+r/rlbvkIBsuFXo8QnBtpJRJWw8
	c0zRfoR2ImJOPA7XDXTlgZXBJ8kTeWzbbGOMWAuRPxi4GcVw9uAQNJp4zvsXC/vhiCwd6OChEd8
	0AwJ+jQXJQgAaozcAi2bTpkCFZRleO9700iGJpnXyiljWpG3fOD68NS45jhhhob0gI8sFLTF6mv
	xKFFGbAAscOP0hbivVclgHAah+GkeLchfiMrOq8+4qB7Qw4FfQlRgRJ+yYBxbnE77pfaiHu8A2g
	rg6hkUr64UtblDIt72ahjZ/QosmYHtEbnLl8a0HXahxMIX9jyAl/TClvRxWiE1T+301Fcs2Bwuk
	M=
X-Google-Smtp-Source: AGHT+IHyys4DYsG6hPWB/AQ9Lj66q/JjyJ2/QcIBk4lcVrky1tGw2l2kO8i0ageeCIN8tFOCbhrkeA==
X-Received: by 2002:a05:690e:2504:20b0:635:4ecf:bdca with SMTP id 956f58d0204a3-63b6ff24ebfmr10080209d50.44.1759424064310;
        Thu, 02 Oct 2025 09:54:24 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:f1f9:be9d:3ccc:ffd9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b846ca862sm878708d50.32.2025.10.02.09.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 09:54:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: When should we release Git 3.0?
Date: Thu, 2 Oct 2025 12:54:13 -0400
Message-Id: <D59D0576-63C9-4144-B49E-54D43A80E0B0@gmail.com>
References: <aN5-n_ArhQqaQZgt@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,
 Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
In-Reply-To: <aN5-n_ArhQqaQZgt@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 2 oct. 2025 =C3=A0 09:33, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Wed, Oct 01, 2025 at 12:04:38PM -0400, Taylor Blau wrote:
>>=20
>>=20
>> So my feeling here is that we should take into account not just the
>> readiness of the underlying Git implementation used by hosting providers
>> in the Git ecosystem, but also the readiness of the hosting providers
>> themselves to do the work necessary to facilitate that transition
>> outside of their Git implementation.
>=20
> We definitely should take into account the readiness. But what I think
> we'll need is a roadmap from impacted Git implementations and hosting
> providers so that we can answer the question when they plan to have
> SHA256 support ready.
>=20
> Without such a roadmap it's basically impossible for us to set up any
> realistic date. In that case, we only have one of two options:
>=20
>  - We just wait until eventually everyone has SHA256 support. This has
>    the effect that there is no pressure on anybody, and thus it is more
>    likely than not that it'll just never happen.
>=20
>  - We set a strict, "uninformed" deadline that may be too ambitious and
>    unrealistic.

This seems like a false dichotomy to me. Of course we can forever debate opt=
ions to go forward, too, so at some point we must have a decision :)

Anyway, what about establishing a strong but adjustable (=E2=80=9Cproposed=E2=
=80=9D) timeline now, based on informed opinions from folks who have already=
 provided estimates of what=E2=80=99s required? Then we can shop around for i=
nput on the proposed deadline while still taking into account new informatio=
n.=20

It also provides impetus: =E2=80=9Csans input, we will go forward with the p=
roposal, so let us know if you need more time=E2=80=9D might motivate folks t=
o firm up their own timelines and provide said input.

> Once we have roadmaps, we should set a strict deadline that takes them
> into account. Any hosting provider or implementation of Git that doesn't
> provide a roadmap will not be taken into account in our planning.

Btw, I=E2=80=99ve often wondered since I see representatives from GitHub/Git=
Lab (and JGit/Gerrit to a lesser extent) often prominently identified as suc=
h: do we have folks from GitTea/SourceHut/other smaller forges around on the=
 mailing list to weigh in? I assume we=E2=80=99d also like to include their i=
nput.=
