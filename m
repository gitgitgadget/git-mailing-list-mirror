Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D54189BB2
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991224; cv=none; b=TjHXgiO2K15gcYQd9OlX9fA4O1Ch7j46WOw/wy8PdhzcLeT42JMn8ahNCTWK0EsCk/mv3IZH0o86ssM//AYnxGuGmucgCQLjZWWwcShtJO38TRK07zWSOWgrkMwxR8rKhE4Km4yAhfqtUAjNlZv0v9/Wl75ZZSfWraYpwBJLE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991224; c=relaxed/simple;
	bh=ibBMYbni6YBD2gGVWZv45tlD/2wiYzpc0/nROw2iYps=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftoX4lZvlOi3F9yMY3GbfIpolJ47UeFmcYKOs3MH7P9lJtia3ivy4bTWPJ97QVsAYRtKpTc4BKy6F+xAQiXpRKPvCZaJdmwZ/Fx5geffGd8/wk0uCU/kv9ARW4KkyEDMCx9eI1DjYgbOhhb/fURvLC5FZes4iRQxu7X1oeKUdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIXVWuub; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIXVWuub"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84fe06fbdc6so1245004241.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728991222; x=1729596022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhuKFsUnoP/6IkwNeF4SIB12PWubSUuFsxbYW9FUqYE=;
        b=ZIXVWuub5//qKSpj56N3ni2ii9gc4y9tzRW2eNEZqlyAot/x0I/FdibZYf5+rzOm4J
         XFmKgV99G62p/k/aas3mIuC6eWOYxCR6dUbfNSm1H/+Kq1+Rw+GBLkmlPOjUH1rkvIsN
         uZoJTojbji2kw7zXo2k2bOE2E0XtIrgrh8RuRETV4y1DrS/fWFV7+vLfYDDSBOqisbY5
         EYRqewkbJnGQPvlovGCEpkGhABEU4s0g5NxpiD3M8FV/eQgZCiEtypaPuMUjMtqxoiw+
         3SBJwKOMg+YOTlazkw/6ifxFPXv2vzwaIokydU1K56mG8jjTO4eUPETwkosN7nZU8AFg
         /XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991222; x=1729596022;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhuKFsUnoP/6IkwNeF4SIB12PWubSUuFsxbYW9FUqYE=;
        b=lPcslQ1OgoNanHVREETqBhRg3fzJXGX0YRDZ/lJo8mbqE9lZmCigoxCVG1h3o8p9su
         7GmSXuhke9TvCBFqG3+fxsdvDwveAm3LP21pNowYe3EupNqRoHcmE9kSEEp3/q9yZk2j
         obujYr7gVJ+lHprQwv6/DzTZA2nkzunO1Rc93DX8SLVzKI/QpItrvYzYLAdXT7opWeAs
         s2Rb0dTq7ORqilssl6HzLoN59bbnusf1b+fHnnBdJi+Jt2/0NXz7iME3bXuerZjFBqnd
         KOqceQSQY0MKPvHNFqJLquLBbFdNpwe3LZco+p65xjytLYD0Zbj9Gufl3+/QzvuRD+b1
         9ZwA==
X-Gm-Message-State: AOJu0YzsCpHLVm7+rUNpqx7YJR3tIGrboml5CNOi+X8OJKCVgpqMoVb0
	ifosbDGsxA5eO5tQhUf8exdwTxB94ZMxO00i1ZyfnpjW1Qcd0cIjscHP7E+dIUkkMLbAcy8FUiz
	j70VtgPTP9Tj5ezJGU5ADAtmzByHkq6ih
X-Google-Smtp-Source: AGHT+IE2+7ZIgf3GGXF7dlljZNOjgOgGsPE4HceOrvbyk/0lx2iGN7P/QcEbr6KzZ1ftLJomakHlXdSRXOGsAA4SN7I=
X-Received: by 2002:a05:6102:41ab:b0:4a5:6f41:211a with SMTP id
 ada2fe7eead31-4a56f412d7dmr3033468137.25.1728991221800; Tue, 15 Oct 2024
 04:20:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Oct 2024 04:20:19 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <871q0jrr02.fsf@iotcl.com>
References: <cover.1728697428.git.karthik.188@gmail.com> <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
 <871q0jrr02.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 04:20:19 -0700
Message-ID: <CAOLa=ZRFqgXuJQCMphwSX0d_saT4zzv8VNdXNkT_RhkfSHVPEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clang-format: re-adjust line break penalties
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, 
	johannes.schindelin@gmx.de, spectral@google.com
Content-Type: multipart/mixed; boundary="0000000000009884bb0624822392"

--0000000000009884bb0624822392
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
> [snip]
>
>> This avoids weird formatting like:
>>
>>    static const struct strbuf *
>>           a_really_really_large_function_name(struct strbuf resolved,
>>           const char *path, int flags)
>>
>> or
>>
>>    static const struct strbuf *a_really_really_large_function_name(
>>    	    struct strbuf resolved, const char *path, int flags)
>>
>> to instead have something more readable like:
>>
>>    static const struct strbuf *a_really_really_large_function_name(struct strbuf resolved,
>>           const char *path, int flags)
>>
>> This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
>> and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
>> few characters above the 80 column limit to make code more readable.
>
> I'm really liking the idea of penalties, but I feel we're relying too
> much on guestimation of these values. What do you think about adding

That is true indeed. There is a bit of guestimation done here, I had to
try various values to find the ones which worked well. I wish there was
a more formal way to do this...

> example files to our codebase? Having concrete examples at hand will
> allow us to tweak the values in the future, while preserving behavior
> for existing cases. Or when we decide to change them, we understand
> what and when.
>
> Now, I'm not sure where to put such files. I think I would suggest
> something like t/style-lint or t/clang-format. Anyway, for our tooling
> it doesn't seem to matter, because both `make style` and
> `ci/run-style-check.sh` pick up all .c and .h files anywhere in the
> source tree. Adding a README to that directory will help people
> understand why the files are there.
>

I'm not too keen on adding examples, for the mere facts that:
1. They will be outdated each time we change rules.
2. The commit message already has the information around each rule.

Karthik

--0000000000009884bb0624822392
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6677977e783e19e0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jT1QvRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3dKQy85ZklhMXllZlZyT2dlaFJiZDVNRlhvRUVMNgpaSE50R0xzT3Vj
MStaN2psYlBMczl5a2VBeS9yTnBTWWtBVmNTQmdSSGtLR2E1SEJQQ0RqNFZhOWpici9maytICkdI
UVRMYVU3dUdqbmVxa0w1bnh2czh6L1gwNjdaZkVCUzRiR1hiTFpzazJ3bmRYb2tPMFJudTRsU0Fw
L2xIYmEKRTFaQUZpaVpvc09waDBQWnpaRWczNDZJd2M2TVF5SHlPdGV4THgza3FBMWlrcWlmUktU
V21kalBBbUg1Z2VjSQoxRmUvNXRpVmpoN2l5TmtWdTJNRG11bThsb2w1UFB0ZHVtdHlxdWFhSGN6
dkNSQllQZUcxODlReW9LaDVRVWFJCi9IMStZZDhqVGw4T0FkMm5lVWdIZXBWQi8xZ0ozUmNmUXFR
K05BUW15R0JaK3FEM2lLTkRSMUhMUGJDdjQ3ZHcKZktFNkJiZ0JRMEhDZFYwK3lFTmRnZE9Uai9P
T1JnNVlMMjkvbkUwdmZkSVV6NmVjeWdDdDFFZW1xOHpmV3JZVgo3V1pFTEIrRDNpaGMyYXNEblVL
N3NMdlFkdVZhNmZTR01pcnhNVExqV2IzdkdVTDdyNW9Dd0JrdDhnbUpCQkdyCk1WZjJFa2twUnZr
cFdaRUIzS1gycUErYnNTd0pORmRXaHFNc2d4ST0KPVBNSU8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009884bb0624822392--
