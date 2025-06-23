Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F842A1D8
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668383; cv=none; b=VvhlySLkVkPFXWd9c92cTo/5OdaC84q/xNwJkw2/iTNxhvY5GJWWaM5j7myXBV5B/OT+8k/5edDGtworiELOzKa9LhWFuw8Cp0m4YU/ut/DEEMh3rCMo6yR1sI6IrfugxFvpwv/9Nu0F1qWNPgNKj7/qPw6kIxAaFpits6K9Pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668383; c=relaxed/simple;
	bh=7ve0129EZinHJalpB6qbQi7okCOdTkMiDmtYugjJcKE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSHwLjTdbgnz1zW4g38oLlAi6yTqQgqyg1Q65WWu1RNbujOqAYt3qY+GAL++fBe9kj7f1yPNOjzEHXakbdKsKpUZVKr9xGH3KXpCfJMut90Q3aTJmOlqUAduEL0MSdY1oHJ4L+EMKMZA2pVGlQZL3UcP8B9hoMTJA2rpT/U6t2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGBxjH6N; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGBxjH6N"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e7feaae0e1so2919948137.2
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750668381; x=1751273181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLytcS+X3ECRYbVNoVdgGexdeS5KYMeKOvnu8WmhkCo=;
        b=UGBxjH6NmlEuoHStc8zIV+z4PHbiLXzYrq1QvWRbH/j2yAkfGt7O8rlw1IU6f/zeYY
         I6uvXe/ae8RyuP8piU9YWU2SQZAb6ue7E0qRIp5WIJ90QEANB6yHzLTf47eviSBBHB6g
         UtGDtXtrn1a/IQIWqjhireRG6m5d2cj20vgIsgFQJekxGDl/xk/tgJloahPEUE3ZEGkt
         D/3gcnnCDt0jdHN4ULtSmJDLQoXv8FbT7A1YFYTioCzTKMT69uHwf6r7XgvYes+sE9pw
         onVCjlg5tjJE2rh2Ab2wAzrkuUwCbD7eSas+93cxm4Q9g2kJQxdyVARf8I/5tC7ilh52
         lRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750668381; x=1751273181;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLytcS+X3ECRYbVNoVdgGexdeS5KYMeKOvnu8WmhkCo=;
        b=hy8QO5Saq8YdBCLyegtUeuojOOaEDulYzbTG9Neq1NXn+p6MQTHrSo0N3Uiv9rnRc2
         8EIOaqHtaffhILO5q48FCPa2k2hG801B/aE9fx3lRF1SHy1eirZEVOYQS2SKx/Mq0LKI
         gOVhhh2ZTzrVlUXma2ITDxyKlrW7seofz1sSxM5EDmptPN/t++X23MYukLRAq/kidhKO
         a44+tazijHehnnUVRl4jEr3hCeZVRoWApKdYc8KGeDNxrNXY92t8/ddvuacQnKzR5VUt
         8i2qqHt0ZX964NBmY8pKZGY/eSfwmhqy/T+puyLgGCXojRx06Vb3j4MpzLl4uect7K0e
         Gfeg==
X-Forwarded-Encrypted: i=1; AJvYcCUsIy3j9C8GP2XDn1IgtgYwLZ/seQF+9GDZg/0GeBNcbjVIBrioqRyx0w9r3S70Xs597e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6vvBVW1+xyVswenMf46Z0r3wEUyyP4vHzsynC2ZSu22TWBga
	0+2/gIXxf3HX9A2OUOB/I0LQA1V0wovuA/q22J71h4+vFYiYODTxUSa9FpI2mfzfNGZr3N4Elfc
	GyNyIn6hcQIqy2sVghXO76fuWkAIHXoU=
X-Gm-Gg: ASbGncsJ1iXmnigHS2/S4UGTSK8gCwCBVN9rkT5t5OZt0FC4rIZwCMcOCg1jIJQHLQs
	Q1Zkjo4P+9DJSPW6QkgGTqv7kUQuD111+ndEs8bqB39ndGmsYpMGnqPHsWXdMlDtWh6OmHBZ0EV
	9S5jtzw52K8oTA/36KNfXBLAQRO7E0Af1ZWFb2Xk6qKe/vqeKCRR4=
X-Google-Smtp-Source: AGHT+IHkIpvRxhMqY4Y2qbEQKWZDLZfV2wTx2eV6a72FnAo/PJxHA4CJ9U6n9vmxZF6g7r1xViHnyXSFKKN8+K7LkUo=
X-Received: by 2002:a05:6102:570e:b0:4e5:8eb6:e8dd with SMTP id
 ada2fe7eead31-4e9c2a2d5b9mr6263209137.5.1750668380863; Mon, 23 Jun 2025
 01:46:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Jun 2025 03:46:18 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqmsa3adpw.fsf@gitster.g>
References: <xmqqmsa3adpw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Jun 2025 03:46:18 -0500
X-Gm-Features: Ac12FXzBNr-45YH0_DKCyIySYW4PENXImSbw5e2mKKhOLfVlE-oNDmyTLb_qIpA
Message-ID: <CAOLa=ZSuEAwj==9+B-nYikyQtOxREf8ZEfJ9L_YxU8yU0ro-zA@mail.gmail.com>
Subject: Re: .clang-format: how useful, how often used, and how well maintained?
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: multipart/mixed; boundary="000000000000f61b6c0638393ee8"

--000000000000f61b6c0638393ee8
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Cc-list chosen from "git shortlog --since=12.months --no-merges .clang-format".
>
> I am wondering how often our developers use "make style" aka
>
>     git clang-format --style file --diff --extensions c,h
>
> and also wondering if the suggested style fixes are really
> "improvements".  For example, taking randomly the latest patch I
> just injested into my tree, i.e.
>
>     $ git am a-single-patch-file.txt
>     $ git reset --soft HEAD^
>     $ make style
>
> I got the output attached at the end of the message.  The result is
> a mixed bag (I commented on the "patch" as if it were a patch
> submission).
>
> I have this suspicion that nobody complained these sub-par
> suggestions the tool makes based on what we have in .clang-format
> because not many folks run "make style", and "make style" is not
> very easy to use after you record your changes into a commit.  IOW,
> there is nothing packaged to help "I have four commits on top of the
> upstream, I want to run style checks before running format-patch",
> i.e.
>
>     git clang-format --diff HEAD~4
>
> Even the output from the tool is of mixed quality, there are good
> pieces that can be used to improve your patches.  So we may prefer
> to see the tool used more often, but not in a way to suggest its
> output is always better than what the human developer has written.
>
> For that, there are a few things we'd probably need to do:
>
>  - Improve our tooling so that the develper can check a range of
>    commits they made before running format-patch, and other
>    situations.
>
>  - Improve .clang-format rules to reduce false positives.
>

I think the biggest issue for this is around line wrapping, I'm
considering just removing it from the '.clang-format'. Perhaps we could
add it to our '.editorconfig'?

The issue itself is that we don't always wrap to 80 characters. We try
to wrap to 80 characters, but prioritize readability over this limit.

This is hard to do in '.clang-format' since it requires tuning the
penalties, which have arbitrary values. I did try to do that in
5e9fa0f9fa (clang-format: re-adjust line break penalties, 2024-10-18),
but as we see, that wasn't very successfull.

If that sounds okay, I can send in a patch to do that and also making
'RemoveBracesLLVM: true' a permanent rule.

[snip]

--000000000000f61b6c0638393ee8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 323e9e99f8d8e603_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oWkZGWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHlOQy85Y1RtUTYwZkJIV2ZzK01DSVk1R1VTbUNHRgoxTi9XeW9RakVT
NzJFSDcxakFVWFRYUVZLM0lhakZHZW5DV1p0UTJNUEtTTk55cUpLMHFZaHdiNERoZlVVTVE3CmRC
UnhFSEtiMk1BTG1INHlsdzRwSUZhTFk1dGJzZ1FidmRnV3ZDT3gwUzJjSnlmZnhsK25YNm1NOFlZ
WFhEMzMKM2NwalhjbmdRQzJXdHVWVkg3MjE1Mk1weEkwY0FCMUtONXoxQitRSVpEN3JwdjVJYW8y
WmNUdExWSVljL3dYZQpYSVdmMXczbnNnMEcxVU8yVU9DMlFQUklvM2xjUDRoYVJRTnpIeG1ObEQw
Y0NwV0Z6a1diM1UxT2NhT1ZNN2lSCjErZHI3TWFyU1MrMUY5bTVMRTFDaHdrbElERUduSzQvckYv
RTdFeTh2bHRwMGQzeWtBdVpVeHdmSTRZMXQvQkkKRE5qQXpKR3htdngyOGtBczdXWEJteHhPUXUw
cHFWYlJLOEl6M2hRaFhDOEt5eTRSajZRb1dva2pHODYzQm1xZgo2OTJ1K0IwWHVHSFlpMkxOSUdx
OG9KYnlrdnhFb1hDM2R1MGF1SXlCZTRXN2FVUUZTNmN2bzBmRUJMUUJIbjdhCkozT1NJUEpsZTlN
aTFFTHJKZ3UvNSsyTG9yT2hDQi80Qml1VzBnWT0KPXRVWUEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f61b6c0638393ee8--
