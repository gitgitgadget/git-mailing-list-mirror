Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D921CC44
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054829; cv=none; b=CM5xmZf9c26+kC7F425hR61CQwpyvveDyWlzmsoeSQbNr3pStpcihvkZgXC2kOY7SGfIYHFO5gYD0s0n4AMWSNZSYiDm9Nq5gk37XXgjdnl3X/7mjA+ohIVqHdxLngEm7Bs+t3EH6g7MGVS9znh3ZL/3HAV781v+5Y7ROPFjla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054829; c=relaxed/simple;
	bh=5g9B5/6QaedRnpQUGJ7zCFVnFJ7bsT3MNNub6MqaWO8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEP+xXAxzbvCEqc0AzrryVnIQ+UuB5ZwZAGFYZsnuouX47GqTO8PGCV2OmBpOzDuw/QUGnZ3zbJ/DoEkDAMhrZBQAwyCVbXF3M26gxZg3xSgokxiH8YZijwuYZOK6TOZaYJFAtkfXeX4nLuUPeIn0ihZgKen3iVsBxu7k+XTCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ+xH1tm; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ+xH1tm"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87f13aba2ccso881343241.3
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 02:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752054827; x=1752659627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=63VdT54HbDnYO4sr3mzD4i5yTZs/kPSKf0s+Vw5soMs=;
        b=HZ+xH1tmB4oaPtYExsr/REiS3C8NLYv4arCvoY2w92tvkCgzD9nnAiQY+lVitZPTww
         uGsoXr17qqr7lwgMtmPhEIJBpFGCtRLIqtUsdh+Ib6EQvCIbRKLZakuaj7cx2W5bBV57
         /GZ71Cop6zfvEy0+Ot3jvq/ccUjyFGQcVZdA4zzVInBU7HEI67drm0bh52GndjeYFx2C
         q8QlLlxBdl6IQogLAMzNtpblq1tDmAaD3CQuRi5nHcZZQBTSpLyE7uIEdXtL2568LWCC
         mcSG19gMFcWJ6ZeF75i2ri8CDaXfhmTMcaoWHewZESsrzsxRHS4j1tNrHlhCVszxClMx
         0Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752054827; x=1752659627;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63VdT54HbDnYO4sr3mzD4i5yTZs/kPSKf0s+Vw5soMs=;
        b=p5UiTokKFG5e5pgGOwrWiZDZm3X2qFkbMTn54kHHijELrdOrcPZxniPkSM4bcGNyVz
         6vZWRmpDvxQT+EsUKdIZu3gAxDc2GkDe+zoFEyHhsh6+nJj3ZZ/xxWRaBaUXHXJq/wyw
         8sRlcOigFw6YridQSCTEQ8TB/4wrDjLaLxGupMh3a9M5fx4HMV++jEpGXUtt+7qdHXy1
         5O8Qb+NTHBJAZ5DDVDmFsvZgJdE4JoOPDcpqvV/C5DV3zuPUpYq8B7nwgqfiDB+Bzvbn
         wJq1jBlGeIfg+sfQQKOUO82ZTVNGPHGEr95v1ZQ7e4rZDFYT4A606kAMxJylNWPwj2GJ
         wT5Q==
X-Gm-Message-State: AOJu0YxSz+Dz+GFaDbvaY+T7rNzAzRxq3DDV0CCqxHDFbWdo5t5Cg8fa
	A3BarZbBQEllj6IblBzwKo4m41PjGMaDervZhd3oQNHW0DMWH674UsYG+9lazCH7o9U5Ml62S9b
	tqrzbh0WGmp/RUHNGeWmIMuW/RuwvJlA=
X-Gm-Gg: ASbGncs+SjMADaAutJKXU8+zCWkqkwHOHUGnKxqDtG1Qh0L2gFK7hQDZrsZXGmCGsbl
	yVsVIfkPfpspC+iZuV4yMLtA47i5fo4PY64DfqujfXl/5Nu8Q4Cyphhd0RnfFw7/A7fwB03Omhw
	AUiugAeqdeoM2nqO6L3zL9u9z2izIkBWvWwwPEfXyviKNSSvd+qqAYqk5ZWGf8ufk8vw39r9lR5
	qEBrQ==
X-Google-Smtp-Source: AGHT+IF3ZDURPj8vZCm9CS4MtN+isXCwqwyYWjxsRAxMYrEcwoe1FRovT/PNBj0HGbdWbzEWIIEOAlhCa7VOp1XmXkE=
X-Received: by 2002:a05:6102:3a09:b0:4e9:add0:2828 with SMTP id
 ada2fe7eead31-4f54146aec1mr837105137.1.1752054826988; Wed, 09 Jul 2025
 02:53:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Jul 2025 02:53:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Jul 2025 02:53:46 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq4ivmv3a0.fsf@gitster.g>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
 <20250708-306-git-for-each-ref-pagination-v3-4-8cfba1080be4@gmail.com> <xmqq4ivmv3a0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Jul 2025 02:53:46 -0700
X-Gm-Features: Ac12FXz7CbH8gT5swBetDMAWnjb1IgkXwCCtY0Kqu7onSs5U60UwLnfawYVG6dY
Message-ID: <CAOLa=ZRZaoqZfT_o1nxuMXc8gPdAiDwYF1sQD1zmnfm4CpvsXA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] for-each-ref: introduce a '--start-after' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="00000000000097136006397c0d19"

--00000000000097136006397c0d19
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The `git-for-each-ref(1)` command is used to iterate over references
>> present in a repository. In large repositories with millions of
>> references, it would be optimal to paginate this output such that we
>> can start iteration from a given reference. This would avoid having to
>> iterate over all references from the beginning each time when paginating
>> through results.
>>
>> The previous commit added 'seek' functionality to the reference
>> backends. Utilize this and expose a '--start-after' option in
>> 'git-for-each-ref(1)'. When used, the reference iteration seeks to the
>> lexicographically next reference and iterates from there onward.
>>
>> This enables efficient pagination workflows like:
>>     git for-each-ref --count=100
>>     git for-each-ref --count=100 --start-after=refs/heads/branch-100
>>     git for-each-ref --count=100 --start-after=refs/heads/branch-200
>
> It is a bit hard to understand how this leads to "efficient
> pagination" unless the reader is told what the calling script does
> after the first call before making the second call.  It remembers
> the last output from the Nth call and prepares the N+1th call by
> using that last output entry.
>
> But that probably belongs to the end-user facing documentation, not
> in the log message.
>

I added a small line in the commit message to clarify this. I'm not sure
this belongs in the user facing documentation. Mostly I see this in the
commit message to explain the intention behind adding the flag. The
documentation already mentions how the flag can be used, so we should be
good there.

>> +--start-after::
>
> `--start-after=<marker>`::
>

Oops. Thanks

>> +    Allows paginating the output by skipping references up to and including the
>> +    specified marker. When paging, it should be noted that references may be
>> +    deleted, modified or added between invocations. Output will only yield those
>> +    references which follow the marker lexicographically. If the marker does not
>> +    exist, output begins from the first reference that would come after it
>> +    alphabetically.
>
> It is true that the first entry shown would be what would come
> immediately _after_ the given <marker>, whether the marker does or
> does not exist.  So "If the marker does not exist, output begins..."
> -> "Output begins ..."
>
> Other than that, looked pretty good to me.
>

Good point, will amend this.

> Thanks, will queue.

Thank you for the review. I'll add the changes locally and push a new
version after a day or two.

--00000000000097136006397c0d19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1ae18f4dff332581_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1odVBDZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMi8xQy85S204dklpV2c0cVlzVGY3MHZsYmdRQkVxSQp5dUxNaElnRmRx
WlpMU1FoT1ZZcDM0MmJsb2VRR1FrZjYzUk1DRUVXOTNKeDR4cVliQjgwdStuQ1JVUWVpSUdaCnRO
Z0xybFR2MmJKN3dsMjlkSVZyT21nOVZHYmZYSWl1OG1OaUdWTVIzVWQva21rZFpOWG5NcTZjU2l1
OGtSUmkKeExnK0pLZ3FlUGpBRGROSmYrZVdlQ3RxY1VyYlcxMm5WN1ovTUZOcXdBTVdPMHRCWWVM
Z25uUkhQV2x2bzJwcQpBa3g0WTk4Y09vT29hRUFGWUlCQ3FRQjFIamEzNzVDZjMvb2NMVjJMaUV5
QmVlK3daTjRkU1o1R3ZpYytYRTQrCkFlQ1dIb0VPSnAwdDFIQUZzVDdzdFVQR2ZYTVFKb2hLTXdi
V2R3M09WV2tqeU9GYVEwVGhoRTErSjNlV1htZW8KMnM1NkpiNlkwMjFNY0JtUTdnMnkwWkQ0Zm1D
aHUyckVrbE5rRnNvRjc1RUFqN0tlRzh3c2ZqcUNHRytwdDB3bgpLV2J1dUJQak5aVzNyckk1dk5T
L3BBbDRNNkFVZTZ3Q3B2WHoyOXpoa05TMGkwMkdHRGNoVjNHYkNtaTZ2VE5ZCkRYQlUrN1JkQXIr
cTVhNWtJcXZGMmtxOGVkVjUzd1FiZk55U1FHUT0KPXBYbE4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000097136006397c0d19--
