Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54C23536C
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670347; cv=none; b=ZjImvcW6GnJqTQynkFc+IFRZ2GWP5jQjY1ACbDyZ29cSwhFuIUymUW3vHaEENiLrU9MfHuGHSyILsj7li/cZGSX0DAI5r98lc4QsDBp9EyPOC9l3scpIpbK2FZASMMySovClztyJpPjVcd1c1T/WdQyg7anlsxWOVYsS/GVvRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670347; c=relaxed/simple;
	bh=G7n7ps+XdGO4jMbAVE/rp5C+ccSuMdu5ATm8rMkTgYE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRfrY01FpuYSj5eKSd2tyB01O/n+FU6thLSK+43YzS77JCku3ANzvBcRzYpYFWhE76SG8wPnQ/NNhFECKkclAnx+HlqqUyWSprM9xuUmiOnipbYuq12yLjda4V4CoIIoa6KjcDwCAp2pPCK7A8It4mPgC9rbFEDxb0kEWdaXRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvWTtXRZ; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvWTtXRZ"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e7ade16082so1067452137.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750670344; x=1751275144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWlDjmdbKqse2BsEQ9v8zL84ldfZcFzi5P90jbLt9wE=;
        b=GvWTtXRZOSISSW4jcUQGDlXWM72cbUBiPca5HN5b4GjPYsmT69V62bFde0YQ9wj/eT
         KD31Go0t68Sh5KRiNrR98gcpjB9N2ZayO0A22yWXWvzojZ8VLatmGEf3eXF9i1GtiL8T
         RTAild9koIKdWkQeLH6t1dCrpdvtTU6JqAllKcN7vn/wIBVYxv0/pro9UsyooP9yqDKb
         1lDB2xqurjJCyRu0Na3WneFmhttoo12f5f4Cn/Kd5/fAEzlv+oCdQHovamBjUUzojJDC
         Ca5oxks8BWBYrnWyUvKazxwnNGn65Yg5LbB+JSQTKIyD/hqtvQNGgz1rpQlZ4TROiNsK
         Bz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750670344; x=1751275144;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWlDjmdbKqse2BsEQ9v8zL84ldfZcFzi5P90jbLt9wE=;
        b=dbBcxK3au4rNT/5nisoE9HIbhk8tZRg3mDLhmZd3EzKgmfOEF1vhhCKolZypMINAWO
         DaMwMxDk8F9CpQnpKrYLz6c4nTigawC/4/8Q0iSWIi/tB8OkvsvS4tB2AkO/1VoGzagA
         HtaNCh35T8ctHuHOlmAeSniSXZxV2VvaPx+5rW3elz3VbrrntPAJWLODa6mYzBc/EXxk
         SSQWYaX2Xy1zM3qjMi1VvG9gwahutVe1oyx0zshxEF1ALSHHfHerUKW8lV24WDjrNIqx
         gKA7TJ8e2p/9A8wmN4nP3OJgnLCQoIM2NQHOa1vCSVCTrHaLZvVeejz/pMr4W08F3210
         MGHA==
X-Forwarded-Encrypted: i=1; AJvYcCXf58kPV7qbMepkSYZBMiba0g3V0q2WE/Uk3yYn1hAueq9qPnDjyZtwTtbAiQQ63dyWD/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV8UpIgMc2X6vyf7wBTySQ2SRBf8yHs+h+1M3S2XSkgJ1eO4rC
	M6q5+MS8fow9UbGlY6HSmZLkDLNoMswWkvFFDXUgCgg+kl7oyVCBqr+NMtCX7RVwhBHnpEL71It
	ehoxk5B2XUJMSrRidbAZgAw2yAv4jMvI=
X-Gm-Gg: ASbGncvZbwzb6pMJAtVouzzVKvHckVYaCIYLVaEkFwESVrIEmImEolrskc1tTu0QOYD
	Bt+09EK3TWXkRqGnuZ7gKYiUSyQFY7f+RnZxB9Y1b6cbLLwJfaY+syZDEFtCbExQzWsiHoLwZW0
	AZjPEyKynXyCYOL//vaxy7ZZIooFcrx7rMaPeM4S1UDHNwUAhq/Ug=
X-Google-Smtp-Source: AGHT+IHYFhQuMFUuhpv3AGBJYPKJmsKSiZvd7Sevf3GLYiONVlcQ++JErEUPnpkPqJTd4U0z5+v2Mi4VKv77BAcgFtc=
X-Received: by 2002:a05:6102:4b02:b0:4e7:e4fe:ac74 with SMTP id
 ada2fe7eead31-4e9c2812f49mr6879475137.0.1750670344605; Mon, 23 Jun 2025
 02:19:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Jun 2025 02:19:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq4iwa0xzz.fsf@gitster.g>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com> <20250619225751.99699-2-lucasseikioshiro@gmail.com>
 <CAOLa=ZSgFYXEwdTyAfC2TSgVqpCSq6D1NDBwPU9cY-unX0Jx6Q@mail.gmail.com> <xmqq4iwa0xzz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Jun 2025 02:19:01 -0700
X-Gm-Features: Ac12FXzBIu_Nw9PbrfMfk_GfHXEqSrypwCSsShb_iBJ3kCnhnQk9JG_iaM7CP6E
Message-ID: <CAOLa=ZSewCtgRnuLV1GPfLccFqcnNac1AT6vG8ghOquNqXsoZQ@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	ben.knoble@gmail.com
Content-Type: multipart/mixed; boundary="000000000000026967063839b4e8"

--000000000000026967063839b4e8
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>  .gitignore          |  1 +
>>>  Makefile            |  1 +
>>>  builtin.h           |  1 +
>>>  builtin/repo-info.c | 21 +++++++++++++++++++++
>>>  git.c               |  1 +
>>>  meson.build         |  1 +
>>>  6 files changed, 26 insertions(+)
>>>  create mode 100644 builtin/repo-info.c
>>>
>>
>> Something I mentioned in the previous review, but hasn't been addressed
>> is the addition of documentation for the new command. With each patch
>> modifying the command, it would be also nice to add the respective
>> documentation.
>
> Bsdies, the lack of Documentation/repo-info.adoc causes "make check-docs"
> fail.

More so the reason, I didn't know the target also checks for missing
documentation. That is great!

--000000000000026967063839b4e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3f129cc361bccd0a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oWkhBUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDZnQy85T3h6T05FWGh2R3NCYnorOTcybWJRbCszcgpROXFhK3RqQlJI
ZDhVWmlCb0N3VGJEY1RqbFZabWdQMm51dEtmdUV6NE9kOGdWM0VxWFdIeFhwUTMyelJQRUZBCjVo
MmhUVDE4eXJSdkNERnJKTGw2L2RWVXhZam1TV1FWODVhNFpKbkRoOFJNV0hRRXJhUzA5Y0N2WVFy
R3RMVGUKNHhNd1FLZUZHbmdFMTFkN1FGZjBpR09XakJwL1dEV24xRHZjSVNvWjdSSktmL0xJamU4
ZnB6a25CemF2UXU5WQpiUmRBbmxocVk2WXBIS25JejNPeUszMENWYU5Rb0hQTnRydkZaYWpnQWM0
b2tZeHNPemFxZnFNeDhIL0d2Z0gzCjJ0NHFFL1lac1lLUHJHQnA2eENzZVd3MHFlZGNxVE0xTWpG
Z1haMTA2My9PTHBjT2gzUnd3ci9qN3RWWmVBTnAKdnkzQ0FsczhISHRhaFplMkY4ejZueThBZ3NJ
RnpuZlM3bURORUQ0R25rVUdRSWwydGlRbXZOaXQzT0VXb3VINwpmcjA3bThUeHRNY0xkQXNJRjJX
alkvL2dMSGh2WmtsaDVzdmlLNnAzY3RkNXJmNU5KTGI0Z1p3OVlCZHAwdHUyClJHT25tS251M3F1
czdYWnJxZ2ppcGZoSmNpM0xSVFhUbGhaWXdGVT0KPVRTdTAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000026967063839b4e8--
