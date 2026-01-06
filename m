Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583413375C3
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716899; cv=none; b=NGs/9RNvi/eM0qRzemKWGvzNAPFJCebjdD3VB5ab+sjpkdu4peIE5BMkxxWbm7PWqNcOqmSdowgV4cM5xihH2t0chTRsel6WAmxSnylsXjo754upHUAVD+S59Kj963rEzA0jZXW9gOcB7I4+pEJKIdkOI5thxbF4xZ689ixCf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716899; c=relaxed/simple;
	bh=Iwo0XUE7NqmGwfozjU3VodKJtiSbD/ApHze7t2XR0Ns=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnSwgHzVOQtuEbiYXGvbeGtddhfJTMbzKUGoO9bXmqYxEIt+hG3gvGSnM3H8sC+OMkJMgkC7xW6LDswCXaIdhbq0cugz+F1Q8QAGOJZcIO4TM5pfujrcJFfUyqM89fkrFzcwxoMw2UWN6M+yJ1MbVpo489Ogwj0HeDmjPoXci1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsmhR5bY; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsmhR5bY"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-941063da73eso716807241.3
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 08:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767716897; x=1768321697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7Qw28WehLpgmn9rzQ+qsYXQH6iKXEYv+TjXUgn1eHE=;
        b=fsmhR5bYr8V6jWAtfGCfMrntDE0RlwDDj4UvL1tIIiM7Awjwzf341re6O6/EOGEYXk
         xNgeA3dLp/5ObVv5fFn8t8g92PmMmT9ZuA2971zsRS1jU1KDX1tx3dwWQ86QWeNfEDND
         PijoOZttmhIITV2uTcnpzLyXUsp2T9lbvf4EhWFNLqVcNiAm5wHfXHSvKgQBhY5D54+V
         aq+mDZytCvXGo10CzUGcOGdEalI2srAD/x+BG0UQ3O90BL93RZLzBb/fLoxNs6pY9Ac4
         hMXXPH33U2pNXPhdwP+ywxh5ILPiMu6ozdMG7+MqzZOUfWYrrxuzEzG12+OpMFkY9iMd
         eN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716897; x=1768321697;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7Qw28WehLpgmn9rzQ+qsYXQH6iKXEYv+TjXUgn1eHE=;
        b=xOkVdvc106xH/9U7dYr09knP//HOI0VsqcbSVKHofiTGeWv6c2iN/FP7RND4DJY21W
         a9sYFfHwGQvdekUj0bD1kOLhCy68epWAqDROcJLijTpt8ipA7NZ7kZPGoPZs7NyK7PVQ
         nWo52AYWa2dnSsWrSqp9aF9WZXkfM8zHZSw9NGQyV3ddlwJC2B2R4y3Hko2dtnqgpU8F
         5cmI3auDvkP8PZ5pzZY/CipZ6ndcROwJPRLv2jHRICm7xGxYpw+CFgYIHVirSPuCJOKC
         sZMCFtJQL6Q1aBBeLi7DSTdlEasu7qpLILsQnCRuZTDR8gB/aYIYlvuqcO2TNIIJJCBd
         S27A==
X-Gm-Message-State: AOJu0Yzq9J1pDBE124qUUFGyuFxuQE3xGWepoAae3hpJUDtLhd2b89rh
	V11JMSYAHEoFmlxAG708YzaDqc4n6QZJoI1RW2rrRdS+SuGVL4+LLStYTxf0r4rsvmH07tYaft2
	2J1W3bwaw/HZHIUBUjOOR0bAAy6F/DiY=
X-Gm-Gg: AY/fxX6/zX95Wmo6QMMcCoojHFZyJEMBxN0tdftTJDXCPEOZF/HYZzyW/ETi1Fq7Tv8
	CFW7gi7yMrE0vm/lHbUD2w7cRYWThkzlVNatvB8rS/jAAmkkWoQ8qIptTdZjbMh61xd6+tF/njd
	erNfZ+0NHyMmmb94KmTxNdOe5oesiv1j35Pv41bQKfBwWw+yUqyBIQ/vISOoFRFYgev19gu9N0p
	aUbbfd+U4cZ6l/BkElXoXsXIrWpvbB0RC/4ZXgKFfKdyKsKKmuZdrND3SoJl+amtEpy97xCDVN1
	BRW0vgHZchUdp9PVeFtPIj2+WW/Nbw==
X-Google-Smtp-Source: AGHT+IHymObZi2iavEG4MmbNemUzztKLGZ0N4laYhWNuZBPgalQVK9i2wY9xz2BZwDdyxb6VBxFSRxZYi6ptBGRg6d0=
X-Received: by 2002:a05:6102:3f49:b0:5df:aff3:c42d with SMTP id
 ada2fe7eead31-5ec74500cd3mr1143042137.32.1767716896794; Tue, 06 Jan 2026
 08:28:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 08:28:15 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 08:28:15 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aVzvDGVEI2qVJv2F@pks.im>
References: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
 <20251206-b4-pks-clar-update-v2-1-9a14b10c1a36@pks.im> <CAOLa=ZQZnYVuK8mDi6Yb8_+hqw_TMugn6i7BJCj1gbNHOruNWA@mail.gmail.com>
 <aVzvDGVEI2qVJv2F@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Jan 2026 08:28:15 -0800
X-Gm-Features: AQt7F2oxYUMROcjsVtLK6W7phY8nM9VTVes57_NU2cx9MtW3b0X84cBIpyombNo
Message-ID: <CAOLa=ZTd7Tq6jPCefua07Rw1-zyOY98tjR2g-Em6CM8wui4KtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] t/unit-tests: update clar to 39f11fe
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000b28b220647baa914"

--000000000000b28b220647baa914
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 06, 2026 at 02:59:21AM -0800, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > Update clar to commit 39f11fe (Merge pull request #131 from
>> > pks-gitlab/pks-integer-double-evaluation, 2025-12-05). This commit
>> > includes the following changes relevant to Git:
>> >
>>
>> Nit: There is a newer commit merged into the clar repository, but I
>> don't think it is so important to include.
>
> Yeah, I don't really think it's necessary. If this series needs a reroll
> I'll include it, but otherwise I'll keep this series as-is.
>

Agreed.

>> > @@ -149,6 +150,7 @@ const char *cl_fixture_basename(const char *fixture_name);
>> >   * Forced failure/warning
>> >   */
>> >  #define cl_fail(desc) clar__fail(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, "Test failed.", desc, 1)
>> > +#define cl_failf(desc,...) clar__failf(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, "Test failed.", desc, __VA_ARGS__)
>>
>> Nit: While most of the function accept description with variable
>> arguments, this is the only one which has the '...f()' format explicitly
>> separated out. It would be nicer if we simply make this part of
>> 'cl_fail()', no?
>
> The problem is that we cannot do so easily. Varargs require at least one
> argument to be present, so we cannot make this `cl_fail(desc, ...)`
> without breaking the case where there are no variable arguments:
>
>   In file included from ../t/unit-tests/clar/clar.c:1053:
>   ../t/unit-tests/clar/clar/fs.h:460:3: error: expected expression
>     460 |                 cl_fail("Cannot copy; cannot stat destination");
>         |                 ^
>   ../t/unit-tests/clar/clar.h:152:132: note: expanded from macro 'cl_fail'
>     152 | #define cl_fail(desc,...) clar__failf(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC, CLAR_CURRENT_LINE, 1, "Test failed.", desc, __VA_ARGS__)
>         |                                                                                                                                    ^
>
> The alternative would be to make this `cl_fail(...)` instead, but to the
> best of my knowledge this isn't even a valid construct.
>
> Patrick

Ah right. Thanks for the explanation.

--000000000000b28b220647baa914
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 37fe33afb46550e7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sZE9CMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0w5REFDUFk1OWt1S080TE9DM0g1bEpidEdoRE5PVAp3RlR6WmFEdVg4
QWJ1eWFGS0lDNzgwbXd0b085dmc3S0tNZExWMUM3TUlPeGwySWk0L3NWK0tTVmdKaDhxV0lxCmpm
bXRvWU9YS0d4RzBzdGFpMFE5RlpraUUvZFRvek93cnN1OEJJTlVBVGZ3bHlobTVURnBvWWtkRzdZ
cUxEZjUKQzAvOFpMVFp1ZXpmYjJWQ1V6a3cvZzhWTld2MmVQKzhtR1ZadUowdWNsd2FXQ3hJLzR4
Smh2QkcvZUFjQ0JUZQp3N2xFRUpPVGpkcG9PVGZxRDM0bjRpbVIyRThwVmdZSjdYdXV5TDVVS3hE
bzRFNFJjRWp1dGZ0eGNWemtCbGJuCkw1UWFNNHBVVVJNSFhlM3B4N21LbGNkc3orV3orRTc1eEw0
NEZtbmtWSzByYjBpellWdjhGN3hEREk1Q2tsNjEKM05JcE9qZ2lGN05rWm1KdDAxWW9YejViREhq
YXBaanViVm9WY1oxb2dVZHYrajhha1lwREpUNnU1cS9BVDJMcApCc052L2J6cElQcHNjMXVrUjZQ
c1dOK0hyVmhER0VPTG5LbC9XSG9STElwUVNkWGpBUUtMN1cweFEwdVlXejk0Ck1na3ZnZUJReEdS
Vk5Ka1JENVZ0NWZtZXlQWWUwNVpGM3NOZm9zTT0KPUIxYmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b28b220647baa914--
