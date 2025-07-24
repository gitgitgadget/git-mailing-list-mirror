Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13AE2367D3
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395249; cv=none; b=uiKTmJUpL+rdCdSAwdWKjJuSJCOFibb4HxDhlnDOTtkyKSYIuNz/aVwOExGF/+HRXrud5Z3Ifh7jCVw6oohex76X6bOggh5ymJxsVIC1BUx3sPFNK8CduHcm0C+kGRePuKfmUxrGRWB9/u1+6LZLe05UzGBL8khuwHPbQ/TPXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395249; c=relaxed/simple;
	bh=aEvXErt8CwSN9llc/yHRGWX8jAyKLOZFSEukCHhXmLQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfffooA48X9nlKv23DIJNFqvauOMP2HMcv+MM/HiJSYhuwt8BRIvZs84Ym+FQ0dSOHx83xPRjUGNU8qET1NPPjvYtp5g0YLmqZnob9z2gNwvmh0P7s8RCtTui/I3EdP4/U3sm7zszbwBYkJHVTesUTUL4XTcGD+avtJ5dPuB8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBNT0b6I; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBNT0b6I"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e80d19c7ebso1003822137.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753395247; x=1754000047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lGP0CyJxPjxnBZqSuvDpEsJWtqiJuZhX+QdYp4eoEgY=;
        b=JBNT0b6IUVk574S0cfHiZ1xVSN1S7UCXrhQad4mqhBNLhWmgSgiV3HSW7cwP6QY5pM
         D5d1oQnOOJxbKH8o8QuFHPi4JOz/ZXIQsZr9/e3wBazQptba3ZzeZTDT2y2zqAKQBcLa
         VhUB7rVn0sHeSSXiOu1Gze/dO85M7etB4uxDsPuQXVBu9utqT3Rx8mpZScY4OmViFles
         31G0X+RKWuzH+GwEF2UwnBN+YcZXdA4G+qVD+rN8/4gqZ3ylh3Sc2N8D1is0Ipjd2HTv
         StostSxOeTBCnPxGUSGqWiFQ6VO8HKua8IzSc/4nOVI1pt3BtEHW/o8lSOFdHGqlkvLS
         VEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753395247; x=1754000047;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGP0CyJxPjxnBZqSuvDpEsJWtqiJuZhX+QdYp4eoEgY=;
        b=DFwcR1JdZuHGmqzjK1fEQubpqbr/+yH5V0cTOpU3R9pPrcUwIWTiR3LmAKtSCQSyG9
         8ofT58GLXozDeAj1yYC4ognZBTIo97gmY/mH4ycF7rr0dG4kcfbigxYndDmP4ST2K3uD
         A7FVsR/+NQTdixU0ICSWmjIJ/L2Yj9dKzeP73Ih1Kl+UtAOBlpo6aZGNp/5GB9ERasRm
         A1xpRsLJZybsyywdyo24OMZTDOBoPHGeK60UOSQ4yXn2WBlhoNKE0kObYEp0Coyn93u3
         fQJToP2FMb1RT+JcCanSPWbA52JeuJ0P8L3ObXokULjXcpXCrttK3kv8g0bOQ5qVYq1J
         mmiQ==
X-Gm-Message-State: AOJu0YxbnGcHPU7mMzbEp1E2keDlMmz/0EjnkNrE3PfCWuO3dIR9aWjW
	vvi1MRMuU5d4JnqoGtivlYUpFd3hPv6xQZZPU1VHBZpbm1FuDp6GBfvQDB4w+dXFaEIKAJjATRO
	QJrnrDDUPX3AvRvQk08hSTOK1YKdlvOc=
X-Gm-Gg: ASbGnctu4zyN88I7K4kzDxN3QaQzRPe1D/l9W1N65NMF8UjY8QjQCXdqNScY2FvTdqL
	KxWRPKNQLglziUwBKGaeeyVrqAhG7k8GIASPMtBZgXcbP1JlIslGL4ZASpDaLTJAXKC2l604NxS
	Qh1Xn3u1r2TnIUCkuMr134S4eHzieu4eY5V1bQrViuAVXDdzqzaumSL25dlVB0BRkE8fY8kURAH
	k8FGURQEmKeKrlNBI+I4oeTVuS5FHe+nK8uUXbHOh6vDYFQ6XkY
X-Google-Smtp-Source: AGHT+IGH0AOg1BkL3zoIY7TLcqxbDU2YNcQyLww5ie/yikiR0Rv5Gn6y+Oxdey2BAutGE1nkxpneTk5oX9nd1YjW4Xg=
X-Received: by 2002:a05:6102:e10:b0:4e4:f503:6675 with SMTP id
 ada2fe7eead31-4fa15195167mr4760531137.18.1753395246659; Thu, 24 Jul 2025
 15:14:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Jul 2025 00:14:06 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Jul 2025 00:14:06 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy0sdh529.fsf@gitster.g>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
 <20250724-kn-small-cleanups-v1-2-0c70f591de3e@gmail.com> <xmqqy0sdh529.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Jul 2025 00:14:06 +0200
X-Gm-Features: Ac12FXyFzKjFvzQElgiT4Zk2DHDJN0iSRzXu5SjuAfIs8Qdl5ith0g0piUUp-eI
Message-ID: <CAOLa=ZRvyBK9vVz4+OhLUgAyktdVTb44VC=e8KQNB6BszJ0ixA@mail.gmail.com>
Subject: Re: [PATCH 2/5] for-each-ref: fix documentation argument ordering
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d418a7063ab42461"

--000000000000d418a7063ab42461
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Improve the 'git-for-each-ref(1)' documentation with two corrections:
>>
>> 1. Add parentheses around `--exclude=<pattern>` to indicate this option
>>    can be repeated as a complete unit.
>>
>> 2. Move `--stdin | <pattern> ...` to the end, after all flags, since
>>    `<pattern>` is a positional argument that should appear last in the
>>    argument list.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-for-each-ref.adoc | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
>> index ae61ba642a..a170de4209 100644
>> --- a/Documentation/git-for-each-ref.adoc
>> +++ b/Documentation/git-for-each-ref.adoc
>> @@ -10,11 +10,11 @@ SYNOPSIS
>>  [verse]
>>  'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
>>  		   [(--sort=<key>)...] [--format=<format>]
>> -		   [--include-root-refs] [ --stdin | <pattern>... ]
>> -		   [--points-at=<object>]
>> +		   [--include-root-refs] [--points-at=<object>]
>>  		   [--merged[=<object>]] [--no-merged[=<object>]]
>>  		   [--contains[=<object>]] [--no-contains[=<object>]]
>> -		   [--exclude=<pattern> ...] [--start-after=<marker>]
>> +		   [(--exclude=<pattern>)...] [--start-after=<marker>]
>> +           [ --stdin | <pattern>... ]
>
> Shouldn't the last line align with the others?

Indeed, I blotched it up somehow. Will add it locally and wait a ~day
before sending in a new version.

--000000000000d418a7063ab42461
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: be69d2d29ddf2ed_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pQ3NDd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meE02Qy85azNYTVZkdTlrSTVXZVJVS3h3cVcyd3RuUwpzWW5xUnlOSWlt
eFN1UldCbjdYWXYrbnZweGl3V1YvV0Z5a1RpdHNrWDRKRFpaQWtvL1pVcFNCODN2ZFFDWGJ0CjNj
eFZ0TGdMcHNLeGcvQzRjbDJONmNyZHdnT1lIRWFuMWxvTWhINDlaYXF4TkpxTG8xc2oyRGYzOXJ0
SSt6aG0KU3ZJTTEvd282eWRrcVlXbis5b1FGMzhGWFJsWjRDZ1hyS29yVFAwNjBVbGNBUnBDRStn
VGYrTlIyR2ZWSmk2YgpvOC9rS1RwQmd1WHkzN0pFRDlKUnMwNmJJOXBPVHlYK3JUWEg2Q0hrSm4r
N0ptVDdPQlkzVjQ1VnVFM1RTRmx2CklDdnRQbDByNGJFRk1hQXZWb2JxUUtWcU5CVWtwUVNlWkdl
Q3ZyOWt2akpvUXpLbW1mVFl6d2RKV3kzTVZUMXcKTEF2OU40VDRIOFVGRUF0dFlid0cwdjNOQTkr
bTk2aVR2U2YwMUxwTzJFUk1EOHNuNlpRSmgyZzVJa0p5Qkh6WQovRW9yMzN4WFgxeFJLTVZzaE54
RFVFUStQWSthcmkrQmIwL1prSjF6ZkdXcTFGdkNjaVY4OGJTRnJWUWx1U3Z6CktUU0lGaVBGczd6
WnB1cXY1a09HMzlnQWNSU2ZpYXg3U1YzcTJ2TT0KPW5hdWQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d418a7063ab42461--
