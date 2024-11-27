Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5DA1547E3
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698963; cv=none; b=YTXTOC9PqxzUAUhD8+p6ahhQSxrqjK8lwLIPP7b23EJbJhTO3QW7WkIs4KV5cc7b00d5hlKVnUPg2Fif8d/DPTdlBpW7vAKVBxsbL2EcgxJ5sacNpLgXqTftgTxHTEQnefBeeQJDWcf7CophB8MCffvjFtQV7+nGGGK+zCAme7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698963; c=relaxed/simple;
	bh=w04VVNtyW30o/AFhUKNg4rIHybooCl5sjDA+VjzsuKA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAnXYR5tAQzNxNctOV/iNI47gcy2JZYZclM0llnWBlf/LGqZ9/9H0l+zbKD9J9ZoGw9dFv29fENzVqx3xpD1rjPYESoMGjVzUFlw14rbktJVQc8unQfQkpB3StChMfinIFQ4ZLhd3kjA6jLIMhDUAV51D16u1unyQyL9o+Or8oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPlWaV5b; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPlWaV5b"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4af3c833017so463558137.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 01:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732698960; x=1733303760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w04VVNtyW30o/AFhUKNg4rIHybooCl5sjDA+VjzsuKA=;
        b=DPlWaV5bKUkXjioXmCLFR5Q0FuADaQX69q+xQYluO4gCkzS4CwZWTJuSiz1B8/M1Nh
         Cc8Jc2PcRZnbFfwyXyZoKa+SSZR9+AN4mE2vFgURDRUWF6Xy5VqlXK7upQZzQlgl7qgi
         PjBd8fbIwNylfLKnaS5dkEYwXqRhgrReN2aHu3mIKaaKmG1FqTsJA8FOXPQvMdnMx1Ea
         rJQo4f4KwfTMAbD/+ezRyCCnjJbB/ZsGo980jQ0GeaZCqjtnTqIt/ZndjqKhrDAR3ltp
         in85zeJMGIh+esU0u0RKJOhnZ+6FJGy6/cTBY2OodU+j594GgoHF61mTWG47s18MiaxC
         +pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732698960; x=1733303760;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w04VVNtyW30o/AFhUKNg4rIHybooCl5sjDA+VjzsuKA=;
        b=Ug97aldLm7d87NJ/GE1Cx74BMGXywaj4X9foctMaz99abeigS30QuwVuMXbi/TUjFm
         DjAZXSEWbJXlEM9dr9QtWLYiS4QIx2agr3nrl8GyAOxKB+VupoZkmqMpIstLsBf4zBc5
         b8u49bChs8pvQIBVdqPaRRTi8IH6mrjXlUZIirzDIn5EP47tPzPZONUtMJSxAJfOWH+P
         6+3kkJdZXaaHFo40yz7QwbolaBqySraLzke3wDs0J/ZeaBjCxqce0O1H+ydSURhMXR86
         UXYjmbE9xRo+6+6GlxQf/czPmvx9H7ipFyD6X95gkovPcYnm1dt5He2ixsHyr+mFdyJQ
         InlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCoqxMmOrMTgYqwVYlvsYyfBijagFtJ6YDlKFFictGjddiNvR+/YG82L7D9mH+iETjAVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVr0QVWu0LTEElerngEp/5O2Nog788aR4STTqNZsv9R4/oXDjQ
	UAcFySqSffLr2MibRtdblpGc081T0IuvFLeepP2KROBC8+X9kJdzfDh1QRNSSZJVtsoCJuURWNx
	W0mDrdyMoMFbFOq7bsyaDqdVxQ7sVqcqp
X-Gm-Gg: ASbGncs6yqf4Z7foqhkUJRpHZ6T8WupwMRVj7HVm4i8YjSL5wm/zYi5TSJ00ywEgE8y
	+Hs98iXe3Fm6U+NerVyn2RqGlHVYy/RzmDSiNCffDvhhcSE2jtOshv4qcKsoi6XuZNw==
X-Google-Smtp-Source: AGHT+IFtg+U01HYowR1//YGK3d9Cx+EmRuh/IItBqjMbe0o5vYgcOzQC0GeJVa2AHKgXNBJjjdRK5z6LreUqGF9ejFY=
X-Received: by 2002:a05:6102:1612:b0:4af:4ea6:f2a6 with SMTP id
 ada2fe7eead31-4af4ea6f2f8mr516781137.1.1732698960623; Wed, 27 Nov 2024
 01:16:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Nov 2024 01:15:59 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy115x0be.fsf@gitster.g>
References: <20241125-374-add-repository-to-subsubcommands-v1-1-637a5e22ba48@gmail.com>
 <20241126-374-add-repository-to-subsubcommands-v2-1-417e0dc66c75@gmail.com>
 <Z0W3rgHQhmUxjgfp@ArchLinux> <CAOLa=ZTeRUT6Ex5Pa-fM1i-QbTfnmDN=o=MU_N2VFeLQwbscgg@mail.gmail.com>
 <xmqqy115x0be.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 01:15:59 -0800
Message-ID: <CAOLa=ZQgKv4SEPRqQix8pJo1nr30Fpg2oF-LdDX1ynHeSjDcGw@mail.gmail.com>
Subject: Re: [PATCH v2] builtin: allow passing custom data to sub-commands
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000000d1ee90627e16a6d"

--0000000000000d1ee90627e16a6d
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> karthik nayak <karthik.188@gmail.com> writes:
>
>> Could you elaborate on why you think this is an over-optimization? We
>> don't loose functionality with this, nor do we have to have add
>> additional code to handle the typecasting to `struct repository *` if
>> needed. But would definitely like to resolve anything I missed.
>
> I do not know if it is an optimization, but if you know it is of a
> specific type, casting back and force with "void *" loses type
> safety, no?

That is true of course, I just thought that is the price to pay in C for
having to deal with generic data propagation. In the end I'm okay with
both scenarios, I see merits both ways. I do tend to incline on the
generic version in v2, since it is a lot more expandable.

--0000000000000d1ee90627e16a6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 55e6ef80847ffbb3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kRzQwd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHhjQy85RHpXdy9qK0R5c0xwSmVIekdCK0hocGl4WApFeC9SVHZTYVV4
dXNjZ3A4ZzJDbmpMUVlpK01vREFyeGNmYXR2RnVCRUFFMjJwZkZNSFFUd1hHU0VCTURWUlRZCldR
YkJvcVA5bVFLRTBhOVVZekZYS0ZNeHQxK201MVd2UHRnRTFPcm9UTHFWb1UwZVhlcis2bHp6MVZ2
ZzM4RVQKZ282OWVLZEh5akZGTVlTTTk2ZDFGZnVCSjIyN1Jsak9CY09qbWQ0M2JZZHVWb1lxaHBY
U1ZMejd3OGs1a2NOZgpNaDgwb2ZiMVFXT0FXSnltZGRCTUNUM242VEgrSmNtQjZ5dFFycC9CVlo4
NDhyRmwzeEhtRWE5ZGlwemNIRnEvCjJvaGczSnROaTV6cXU0RERMVkNseU4vSGNaclFseGE2Q044
WUJXUkVrT2ozMEd3UGlCVzhSRmlNaFB5SWsyTmwKeUtZNHE2cXVDekdhMkJUUkxSdUEydVFoNkFr
SS9vZElpZGpYZHU2dWhTMkdUODVyT2ZlYVJqTDJwWGo1S0NLUQpWMk8rc0k0dW9LNHhKQVdVTmdi
TzFueGlmakN3cXkwU2g5R1JENTlVekFlS25EMXZ3aU1STG1rWGpDbEJiRnFFCkdBZzBiVGcyd0g4
dGtyZ3pJTUxYemVkakIzd3Y4YWpCa3k3WExwbz0KPUhDQ2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d1ee90627e16a6d--
