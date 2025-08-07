Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C09461
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754529843; cv=none; b=PImUPlmk+ntzVuIhWdSJS0bJhLktE7DS8z0gJSRlNracSiLC1fF8hmKVkXjyzhqWeWKt7h7E0Yn9+UGLC64XyaBPcVJkFICEhyptwKkTco6Hd0euD6Afjd5Fxe82tMD0AZiCAqjX759Oaq1IIccSX3ZkVQ6p284TY+IHjMxKDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754529843; c=relaxed/simple;
	bh=AMoieM6ARa9v7r+f73xmQTYGYyyWwvI2r7SntX5GehA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BCjxr62/DdH/l74/wX1Ftc+CWjMqosDUJDBsU9jFzSv8kg6V7s02dz4XhIyLcUXCnKxmq7khKzWK/kJZjt8Toft8yNRQqWJcmOuSDkqYU1HsakPXRRJPWJtcxnMnqXwCxeeFjlkEgddPrf7zJXbWLLFIBvV4q9WLmROKUXi4mNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtJsCEM1; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtJsCEM1"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b4233f86067so315607a12.0
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754529841; x=1755134641; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KEGEpZXCvrKvt5/KxgDIse3ZfOucbFjlrZSIGy3Gjg=;
        b=YtJsCEM1BY3iqHLrMBV4YKq4u35pFSfuTCgU3NhIZPgFtUUDdzGi2DEfhjYhBDy4q6
         d8UABMaGZx/BZ/EARrr8BKYpEFJJnZwxsSlnelqG2h6gP4Na6gfbD4FIHK6ItucMIxg5
         fyn3nH+TsGOgPgEVuE6cG4kXdursq89I53dh443oRpQrbL+9TX4m0l1b3J+PDaqH40u9
         rbV6HKZhVH+w/bnrHclAKuvNfqMesOacHRD+bVRbmxfviAcEjMz2nBqlJCdgprSmfVZX
         sQPvmvSkGtcnyGmNHIL/TawAlQW36WlbP2GXEo5BGzoPEDZtU+UBOuYFNYR6+/kXS64X
         TAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754529841; x=1755134641;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KEGEpZXCvrKvt5/KxgDIse3ZfOucbFjlrZSIGy3Gjg=;
        b=Q/+TSdGrY4dMFN6L0a9yY/+tfIYg6k5cSaZHBocBx2kzb+/fk2fnMZaAl574zjsOHM
         /yDDudJT6fzTdunl8JyoeFxyMxZ2waur35D2vJKixULXr69oFdDp3loY1pYcl1zVFklv
         zof7CXhfMXi7rXDkbosxwGxflfktIZ7QvF+EqPDGHFnSVCCti7JcqdtTS/wS9TmzpLre
         FB3T54Mk6JHYiYXZmUPidaD22Qv2RhyeuvqeMgfkd50RlsE5rHR8Yt0FeCLUPkGb6R/T
         UWx2Ts8mHzd2X6KV4pKRZqPctCS/1Br+dlu1zTkQY7fdm5u/Mi1jwxrBkAv8271gGHs0
         9c/w==
X-Gm-Message-State: AOJu0YyTTr5GVvgogtpnRl2xiT4u0EYiNXPgKqDUU194+XyTIo+rswaz
	fCK6CiXAwtT9wYg3RWH6U0PcaZa7lXIOm9mj5EnANnm+4XIjObgNfwDZ
X-Gm-Gg: ASbGncseCemYArt2tJaj34ilrePQTiRfFVfu9udzJrXwlFC5fXu0TfdlilBuJmmEwYU
	qIRiWCqwxLty6uH2G2inOBrcan6kkPUUdY2EmiqGpIxLCZekNGiNNgpZzDcYtGvVtbqCsb2xajO
	dGgVSxDGwWBql8+fC2res8cDDXVx3BiXYs2VTalcr2Z0Gk4+PTpQT9B+mknkRgece9FJUDardtC
	v6DS2GNgbatfr+kWyGmjXbV5oC0nwSYyQscAE4ZBfy69KOXbyrPtp46pW066hhPMyUxTEb0Z8by
	tU5+EnR4neVKhdfvPjD4/877n6ojbBvYE8aRjnpSv7lk08JqRulzigco2LZzFP/sCVjJlVwI6w5
	KWAI1i8Kq3k0hxfNCyMqVYPCvsOis+YGacLhGVSQCeKuUxvDdot0nH1jk4nw=
X-Google-Smtp-Source: AGHT+IHBWK68s062OxGIqXlQylvM0PVu5S3pwxDtondmtQmTVwqaGc1uSptIHAIqO3Utk18yWQOP0w==
X-Received: by 2002:a17:902:ce82:b0:234:1e11:95a3 with SMTP id d9443c01a7336-242b06df98bmr26844415ad.13.1754529841346;
        Wed, 06 Aug 2025 18:24:01 -0700 (PDT)
Received: from smtpclient.apple (n058152109064.netvigator.com. [58.152.109.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5bbsm168336735ad.128.2025.08.06.18.23.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Aug 2025 18:24:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] diff: ensure consistent diff behavior with ignore
 options
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqikj0uze2.fsf@gitster.g>
Date: Thu, 7 Aug 2025 09:23:45 +0800
Cc: git@vger.kernel.org,
 hi@arnes.space,
 michal@isc.org,
 peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E4D0147-A4DC-4906-9627-A92CE34A4754@gmail.com>
References: <20250803145155.57894-1-yldhome2d2@gmail.com>
 <20250806123306.25532-1-yldhome2d2@gmail.com> <xmqqikj0uze2.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> The code looks much easier to reason about than the previous rounds.
>=20
> A few comments about the design.
>=20
> - Are there other possible values that might fit in this "optimize"
>   member, and what kind of behaviour would they trigger, that we
>   can envision?  I do not think of any and that is why the "enum
>   diff_optimize" member in the diff_options structure smells more
>   like a "bool dry_run".

I was thinking about DIFF_OPT_BUFFER , but "bool dry_run" would be good
enough for now.

>=20
>   By the way, giving a member "diff_" prefix when the enclosing
>   struct is clearly about "diff" by having a name "diff_options" is
>   often a waste of readers' time.

Good advice, field name should avoid overlapping with struct name.

>=20
> - It is unclear why the dry-run need to imply 0-line context.

I was thinking about matching ignored regex in `quick_consume()`, in =
which
case we only need to match regex for changes rather than context, so I =
set
ctxlen to zero. But anyway more `if` reduce both readability and =
maintainability,
so I won=E2=80=99t set ctxlen in the next version.

>=20
> - diff_flush_patch_quietly() would be a better name for
>   diff_flush_patch_quiet().

Understand, I suppose the idea behind this is to stick to proper grammar =
as
much as possible when choosing names.

>=20
> On to the details.
>=20
>> diff --git a/diff.c b/diff.c
>> index dca87e164f..5254ef9373 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2444,6 +2444,15 @@ static int fn_out_consume(void *priv, char =
*line, unsigned long len)
>> return 0;
>> }
>>=20
>> +static int quick_consume(void *priv, char *line, unsigned long len)
>> +{
>> + struct emit_callback *ecbdata =3D priv;
>> + struct diff_options *o =3D ecbdata->opt;
>> +
>> + o->found_changes =3D 1;
>> + return 1;
>> +}
>=20
> OK, as a non-zero return value from consume callbacks is supposed
> to signal an error and causes xdiff_outf() an early return, this
> serves as a short-cut.  One downside is that we cannot truly notice
> and signal an error to our callers, as we will see in a later hunk.

I want to think about how to solve this problem later, but I believe I =
shouldn=E2=80=99t
address it in this patch.

Thanks,
Lidong

