Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5B2BF00B
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454541; cv=none; b=U2nj2i2QMiIABy8B7428Zmbn1uZ6PP9oAvdb4NP8lVj07RuBQ+KVwA0hhTKdXMfyldOORwPeK3OmFJLVkWNKO15ca/XTVnO6UiZnWjx5aOvbW/oxuC1Tq3jihG9iKYsA7pC7GkGiUY76nZykurETU3WNrCVQl11jQOFw6lsI5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454541; c=relaxed/simple;
	bh=hUQhNog4VhUUeKTczUplSnjEx5xI4hB1csVQQXVHF+U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GA/SlO2kCMi8yjU4uAAjfhB/cYDABzZsaSfnpFE2ikZDdUMRzrSitJY2GmBwCiZHVCVRzHcc/EdNejWTosLG7CyYP7mrcdZ3C+BjenW7PKbr6lsvzxzb2ExBAT45kmXESolE6rjOTbwa6c7MHFjLn7UioQSYbsBRKQQQ7X/HbAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URA/e6wJ; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URA/e6wJ"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-89019079fbeso1336332241.2
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454539; x=1761059339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKG51n95juYZd6i4fJErJ9JWWrOh/a/SQUxzU3fCFAU=;
        b=URA/e6wJ6TJwi8XRY2DxuSv7Vd7M8Hc7OC9zDsIgjyYtITlwMEW7FPk3t1a/ehUrD/
         X3c392bwG6Q4a3Pk9Nmz4oTZv1W7PkWg/lh+y6Amr+SJrZh8aSssABeS1mZK1cvSlrKa
         2yxyYwMlIWCgN9Kg0+nuInAJJOyDGd2FsRxUDCFU78rhSLKhRVBQkfRsf5L9aJW5XYis
         VyHdANRBRlNsQhkrNXLMpl2kfhGDZRek9sh6tsI17wClyoPnuMnb6yI1Vijv/UJwt4fg
         iv5gB5nEv7MAMhO9jqOI+ot5k6dgShoF5nryw9jHuY+h+74cFxMJole3EHISVnZ5hciV
         FBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454539; x=1761059339;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKG51n95juYZd6i4fJErJ9JWWrOh/a/SQUxzU3fCFAU=;
        b=YD26UV8UEPNrMPlCrkDqYmRLLVwL893uA5sS7CrxS5JKQ/bwKRlQmwGyljt/KUFKOa
         mJDO0zPYkvY2gHjm2SU2UG8xTyHIRVwX7gapZcyXbw5As7vU1pNabnkew8WckrFJctd8
         FNn6d1RVm0+r2x2Cy8iliSOhtZKAmAXSYm3wrnYIW6cJQhphGcN+3O/bZ1ypzm/F0M1L
         eK/NpKOKtCgw9rposmpUiy7LVC7FAfiUuGYYWKI/gBKzoiEQxf2GbI7B3kpQwbEXAW8b
         ZDPHAnhdbQSwr80QggNVJAwxsTj9huGTsfeoY632aIcsKoG7eLNeb7UMO7jDY8yzxi8B
         hXJA==
X-Gm-Message-State: AOJu0YxWZrcJ+I/Fkbpr++5ETZlX4txeZ7I0toYK4HZ4gcKyHvmkwPv8
	0UaSyL1OIhjJzw2QagxFBg5O+jOLvd/j3BiSTYSWHVATdBp42TuHPdWz8hNyVl3Cnn2XTimT2k9
	gemeVurLA5Z/dxo6abfvWssyBMFWSL9Zyn1Rl
X-Gm-Gg: ASbGncvqUKtq9UyYVmW9Cpm7hhsabevdOKWVfVv9SiysxVgfNGhc00Rf7kQgnEWjMO7
	Nx/iFfKBnntGmVGtMI5xiCC1qzsf2/fI8PaHttUw04SpinBNPbDKApst/DaHnKavtxsGXBaI9/R
	ElJuA2fK5Ei1QPuTrspJAtQU6IPlV6wKAcu7BJYXZEJjcvwVaoa6Zn5upwmOyNvjyTQqvpnu9nv
	aKeCaMlnOJJoU8QkK/eHpaX8lFo+Q0NFi8D4Na936n0/oo6pvRVN8qfTYCOgiCq97pmr7s=
X-Google-Smtp-Source: AGHT+IE/hnmgw7OIxMl0kSua189bjSlk4JLmzdLaIVmzjnWPln3n5fxj0pYuAzzgkxRt3wGojYiGqY1kaqHnkKefsM4=
X-Received: by 2002:a05:6122:1e0a:b0:54a:71f6:900f with SMTP id
 71dfb90a1353d-554b890bc9dmr8464154e0c.0.1760454538616; Tue, 14 Oct 2025
 08:08:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 11:08:56 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 11:08:56 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh5w250lw.fsf@gitster.g>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
 <aOjsjpE1vuFUXXbh@pks.im> <xmqqwm4y538p.fsf@gitster.g> <xmqqh5w250lw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 11:08:56 -0400
X-Gm-Features: AS18NWDunQ58PU2dBojboZ6Pxg9taNr1wW9zC-_2QaSiPkAsYwqkqnSS0H9YGBU
Message-ID: <CAOLa=ZTRG=x5PofmSSfHhJ3Lig2NjhU8buVWAXU=aKom2PDsDg@mail.gmail.com>
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006afe6b06411fc3e1"

--0000000000006afe6b06411fc3e1
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Perhaps "--check-" followed by a word specific to what we are trying
>> to achieve (e.g., if we are trying to see if auto-compaction is
>> necessary, "--check-for-auto" "check for auto compaction")?  I
>> dunno.
>
> After reading what you did in the previou step, I am reasonably sure
> "required" is a wrong word to use, with or without other words like
> "check".  Semantically it is similar to the should_pack_refs() check
> that we use for pack-refs even before "optimize" came.  We expect it
> to answer this question cheaply: are we better off if we repacked,
> or can we go on without repacking for now?  It is not about "are we
> performing so poorly that we MUST optimize now?"

I agree '--required' isn't the best name, and like we discussed
'--dry-run' wouldn't be either since that would imply that the work is
being done but not persisted.

I was leaning towards '--check', which is simple. But It might be nicer
to be verbose here and simply add something like '--is-worthwhile'.

Being verbose here is okay, since it will only be used sparingly and
specifically by those who require such a use case.

--0000000000006afe6b06411fc3e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 56dc22e61591c923_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdVo0Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHdEQy8wWDdVN1ZPVG85cXV3NEJZeFh4ZXB2bEM5Mwo2UmYzMGFhTzVJ
RGZvbzJBUHRpTWJQWlBxenp4WnRpVFV6N2l0a3RXQTVjVm9FMlBxTSs1MTVzZUVCMExib3FVCjBq
MGt4UUhmZXhjb3NjSGZLVm9QeUduN3dPMktzcWtvVWtTZ3lLMk9ubjhpcTU1U01IRkZtbHV1M0g2
WVlJUEkKb0pPWTl5ZVF6cVpKMFIvMHdKTTA1TEttbjVkOW5hYWFIUzFqWHZSYkRFMUVwT0FIenFm
KzMyOUVKYmdnQWwyaQpvOHNma3ZJK1J6UHd1YTlVVTdGQkhKeGFEck50VjVjY2lDdFJQMitRNVB4
ZVFZTUJKczFqM2dVOGpMbzBvbnFUClo2TDFvc2NNS0dZbkM3YjNmVWU2WHlKQUdWTnJEMHI1WmJt
YjI2Z0QzYlFSQ3piWmtPeFJSMXhiaWw2SFQwTjQKdlhpZVYvV0Uybk5XUlduejZLNWFSMWZudDlu
emRFYW1VUjYxV2VyN1RWY1A4Smh2SnV3UW90QVI0ZCt4ejhKSQoxQ3phMk9PMFMzR25zenBWUGRy
RWVqamhMVkNUN0ZDemtmeU0yb2hUWmRpdUpsMkZnZkJ2Z2c3d3lTZGRuUnJ6CnVJU21TWU9vNUpr
aFRMSWFLNkdKVlRMSVMzSHVWdkRqQXhyQmRJbz0KPVB2S2kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006afe6b06411fc3e1--
