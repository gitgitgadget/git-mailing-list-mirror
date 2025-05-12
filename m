Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F68255F5A
	for <git@vger.kernel.org>; Mon, 12 May 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039757; cv=none; b=gVZgGvPl98g2dZvuuCOObwfJ0Bu2p2J5VdKNQva8THLGnd/Xs11nLxkAnXx+YG0wR89uvUFLADv34BTT8eZ5nNvtloGi8pTFhd2UMD7uCkMhLYAFaH1IdpuXTzGSXNRqrpCDA7JpEBWJr1eIGlMxpC7J0ubpJQrrL3dia4Vm/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039757; c=relaxed/simple;
	bh=EPLh4/ZTqQfWV74YKvfSWjxPBoR5NlmB0YvCPNpcGNE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAnJzNqERqM1zyRz4hSAnv8DkZfnTWJYhOfUbXcWrfpJjUQiC/ret4n0e1O08s5MEEAwGZCZ0DTTJJOZm3U9SqOVzlO6TPSTz/0CsXGApTdwa5CXI98PG/Vk9dqqotCNgaDQ7QgNm+cMsk+PXWPYKKgj16zHyamw73zaFw8+6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nvu/jjXM; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nvu/jjXM"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-878427f091eso1105187241.3
        for <git@vger.kernel.org>; Mon, 12 May 2025 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747039754; x=1747644554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iX3eGo+6WfkDHSvaKMDvfZL1h9ZLKJxbJGLkIQ7gOI8=;
        b=Nvu/jjXM7plXhWx8wWYnK9sfa6pgO4AjQ7VYJyxCj/rl6Q/ZkQIKlEL1t5aCEWu2jp
         kuZEMpcavQFWs+qNdBoRWFstM6Mo2AgL1LhsqW0jyprerXZbjnPYMmoNYrnOKVAgNG2e
         qtk6HG0y9117kV6Qn3zY2SjTU9RKMyO+989EmBeZnoA0cVSK6amgRkhqWVCaVD0o5KUZ
         9vAgG6sYVCaD8y2Y4SiJTGXRDc0XCD0AZjUWNA/0DStehseB1aZH4YFZiX4pkT5AB1ZW
         Tz2E+ejLKgPu40CYdDeoXuQiW/fGuMMPGOoWiVY2m2iuKlvjEmi398SHp2w3e+9waD9a
         qb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747039754; x=1747644554;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iX3eGo+6WfkDHSvaKMDvfZL1h9ZLKJxbJGLkIQ7gOI8=;
        b=cLNFSPGOU+kFBaZS2Q/ytB9SM20RlUsxpcNaY5V877OOPiLqToC44mz2LtFwsMHcJR
         WIpMgYUigG1BycKDdJqEZNQOH0RhSIOYMQzqLiBHHfZUANskmeZxjpJUEFixi1Y7EiBm
         yJ6PkYDvgudRpPBzaRbF7U/SbeYbYKeBlGuLHVQz55q8hOE0r+ezkiB1pr2bQ8OYtcLD
         3FSc3gFYhJ5OqwNWOOzZuXrLzEyWCoYy7bRsRsQhh3Tcnyvhvd0gnuN3TvGOM+7DujjZ
         6WOWhyHdesw7/Y57zVfT9K5TL2piFnU+lsTDBuNTgmpOQG/70L859iHxIb49pBtKdg63
         ih4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWK+PHekTPtczlLBj8B9WPz3AK3HYTm8WWy9A7huixIx8XPrv+XySV12i+6k48YU/ZRxls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36C1Tf40cyCbtdiN9bKR5Bdfc7DZLEjbrz+LPVWvp8odmNH9x
	pN754hzx+E/tKnpAVWBCSkCHQJXHlTrKvZODGWiuplT1ciH7cmtumxWpEVIGdzdoSo1VUphTYi9
	ubu3k14oHJNB9/fMMMnNAwdRT3yk=
X-Gm-Gg: ASbGncvd84U15eYxZ2enJ0SQeOV26HwMR7T4NoY8+WwoDBGasTBw5CP/2GAs/2EUkNr
	hwl/jh+JDx/g9Qa3YfnfYAb5cJvefVwk+ddUzbw3o8+ESevQvlZLyKfXkt98xKDN42ABgKMDdyr
	wSj7Cbf9DuKXp5xMiyP/Ek+g9zidQeuE0TQLg1lhLsiqEQUzxtWH4LryY/+rSH4hv/Ox15EWaKk
	FC1bw==
X-Google-Smtp-Source: AGHT+IGAhxmLyzy0FW/4FxPQqKVvqD154TUronHYHbKHOY32kObMvZsdNS7VQeXdSOpobj2QkoF9NPSf2QQGuwCGAec=
X-Received: by 2002:a67:e7cc:0:b0:4c1:85d9:5641 with SMTP id
 ada2fe7eead31-4deed370764mr10110307137.11.1747039754422; Mon, 12 May 2025
 01:49:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 May 2025 03:49:13 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 May 2025 03:49:13 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 May 2025 03:49:13 -0500
X-Gm-Features: AX0GCFvYnI02Mjb3tDbZt4KdP864JP63ZbDEr2jZHMUMFqMt-9OfDo3gYrFdft0
Message-ID: <CAOLa=ZRwGVdv-rJ+XtRyFfiqnqcwNZ5i-tWo+z11e5p1r_37xA@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 0/2] json-writer: describe the jw_* functions
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000f8a5670634ec6320"

--000000000000f8a5670634ec6320
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

Hey Lucas,

> Hi!
>
> Given that my GSoC project will need the json-writer module for serializing
> JSON data, I studied this module and I thought it would be a nice contribution
> to make it a little more clear on how to use it. This will be helpful for me and
> I hope that it will also be for anyone who want to write JSON inside Git.
>
> The main difference in this v2 is the second commit which provides an
> overview on how to use the functions of this module, telling which one should
> be used for each use case. Perhaps only this usage overview is enough, but I'm
> open for suggestions!
>

It would be nice if you could reply in-line to previous versions or link
the same here, to help navigate through the older versions :)

> PS: this is the first patchset that I'm sending after being approved in GSoC, so
> this is also the first one with Mentored-by :-)
>
> Lucas Seiki Oshiro (2):
>   json-writer: add docstrings to jw_* functions
>   json-writer: describe the usage of jw_* functions
>
>  json-writer.h | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
>
> --
> 2.39.5 (Apple Git-154)

--000000000000f8a5670634ec6320
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4440cd334e1cc054_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1naHRnUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1hoREFDVXBSWXVSLzhkQzEwcWEwMjdPYXVOdmtSTApKRjExcC9YTVNC
L0JSNTJuUHROMmx0Z3ZnQ3Brc3lrWWdySC9ranRWcll4NUN5dVdCZ29Md2VoNTFjbGRTSFlnCkIx
OXA4d0pZek5UY21PWUJaMVlBamJEVE9NSzdsOU4wRGI4dC8rMEFFNUZrQk9pTTNtdHVqUHFmUUVT
UndsWkUKbXFoNVI1QWZ0U1BJQmVJblN2dC9HR2lETE1waVdzSi9xbnpHWHZwMTYxbWcrU3pBRmZI
bWs2U3FVa3ExZEJxaQpiSUNJK0orWXNFMS95S21EUFE0b3diVXZabk5UelVweW53dGxkaWRIQjZC
dGNJd0FoaXlib3V4OFljcE9TTmF3CkljSkRtVWlDUThKc010K2dXWUdET2lNTmF4YXBveENvY0dy
OXVmSTZYeTZRQzczbENiZlBMTWx3ZW5YeWNVNFMKMy8rU2FvVUtKZ2Fuanh2ejh4aURkVEp2V0k4
anp5VmxXY3VONFRjRTNGaHpEcDN6VStxR256RDlDSWtPRndDegozcXgrb1ArQXJEdFFaNmZuTmlp
c1dCRnN6eEhHQVlZZDF0K05FamlTM3h1Q0dneW5MaVgvK0cwdi9PK1JIbi9wCklaVlJWV1JuZmZv
Zm1ESmZFQVFzWndsRUIwUXJMVXhrN3dEc3JvVT0KPW1lYmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f8a5670634ec6320--
