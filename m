Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C240C26B094
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807638; cv=none; b=B045ECH/h6G5KKNclig+rWoEUxqifvb2PGEKT440Bc0S+1ygstXOX8TOgDNXcuCmdPke3JGQY4Nk+GsMdeXLRtOgK9BY9JnKfhPCfUqvGnXg4xEMGyVW7Jr8rrn5BfwYTJAtqdGAHN0Ao+5w32GioEM3DcJhUdfHVbtDadX29sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807638; c=relaxed/simple;
	bh=2B8JbJdWkecJkAsAVZ75z83YE41VJJweTRj9WsWn7qE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYhXiYxbVNZMemLNN2WI6az8jeVXNIRMw5WkrEVR3/LY8FOpgb5gOT4BWNDi6LFItPyyq4fo9odrKDKDZyOjm0BXmY79XMTWhmfc8frjeLqOeZqVY5j+2XfybCmPW8JrIDmmcASswQO0L5CpW/wXxrebX3SBXMQP+Z2fAMNhvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVlWhCTf; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVlWhCTf"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53140c33563so4220424e0c.3
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750807635; x=1751412435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ex4BXUFIDcNtGLq6rQ2gb0Bmr2yyG69HBmjRrPEVOe4=;
        b=NVlWhCTfQ+Fhn64ZimFcG4mwfBT3xJ4v+FjX0JIBWyEgZQ2E4l0zlpUPaHVo9+wsH4
         m2K4Ij8TUXGTrbtyIl4n7Vj95NpEqCdgn+jEgvpo4ge8PeQyPRocxoHQS7iDNHpgZfln
         hsD59AJeT49Rm9cKEEwCeK+syZkMhE2b5gSdBZYlC+gA1TrLYTdMp9rssLE/bgaeJiUH
         KrCENhMEs8EoM5JMx9sExYatTf4HS7QdkE7WUBxVRpvjpO/8Ziff5YFSkQx+dqXr6IF2
         jmq4fu4yJjtt1lHU8td4r6bHtKJEwilY73xTEInoEgKhjAV/09tfv8KWEKo3h4Ea5OW0
         L09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807635; x=1751412435;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ex4BXUFIDcNtGLq6rQ2gb0Bmr2yyG69HBmjRrPEVOe4=;
        b=oPBpuMup0cFtKlYj9ebBKFI2BZpkUyhg0RRbW/Y/IOy073caCdNx/qOxwXia4YP7lf
         za4j/Bcn5ZLMvSuzDKqbqiIEUQ92sDNH5SGupthxsaLlpOepFxOW2rRpgCx/OAcWrWHw
         /KyZlGCXLBDzyfb8UxypQEqGhjF93xA4QFYgGgBLS+XJ9IZKtWxuAH+Jo3wpiYSmH9xc
         tF2gVO1RHEiy4SXAGT7sTcWXDP5FrLDe01prnh0h2ntCq2PsTYrNdnAccNzKFSL0pvZX
         8QBIflJuSVFl3iebSRpeSOIBhWIQSWe/fvUtu14mXQaiYlx6yON9MhjZ0lLI1Q/L8LJ+
         KW8A==
X-Gm-Message-State: AOJu0YxTVnZV3o/qc3LfrGHhk7OfP1iKJhmOI3yFOFxxXAZwUxu3PTSW
	ZX0VAR0RLwTAUtWqk0mS1ZEOLimtUCmQmURXNq19Dzh4DTAvJuVcTgrC/Kqlwbv/Xau93rhtBF5
	Nef0KYptqogw6Ejug+DAd57GhRWDk1a0=
X-Gm-Gg: ASbGncvWtd5Rt5xGIFOMfhK4MNEFZnnNfG1mdUkdPpZyu95b0Ict1MzmF8yb1gdnajZ
	w+QpZMQYXjnvJVdQToQURMALY2Qf0/7XHu6pLl/gjiHQybCWUB+uPYlebcIk25QcAs/4jBvzvft
	AVWTWbxQ2tAOCKF0fcMSUb1mLGw4jnQiK9na0l5xCxCuEOqVXM8yzwIaXQpFpI9eUdObjniztGZ
	7ZSHw==
X-Google-Smtp-Source: AGHT+IE87noJYBCaK4acM1gh6SzCZRceNqf6oi+IezDoIgwoYbtYetPIgHUV6FMLdbwfNcXeegMqJspmC8YweN7mH+g=
X-Received: by 2002:a05:6102:6c7:b0:4e5:c51b:ace4 with SMTP id
 ada2fe7eead31-4ecc76797f5mr570695137.20.1750807635565; Tue, 24 Jun 2025
 16:27:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Jun 2025 16:27:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq34bq77b8.fsf@gitster.g>
References: <xmqqmsa3adpw.fsf@gitster.g> <CAOLa=ZSuEAwj==9+B-nYikyQtOxREf8ZEfJ9L_YxU8yU0ro-zA@mail.gmail.com>
 <xmqq34bq77b8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Jun 2025 16:27:14 -0700
X-Gm-Features: Ac12FXwZYi7ZAsaSbN_fBF5QWQwN9RYQr4VVv_OX8Z-OmeQhnfmyvYyLIXdj830
Message-ID: <CAOLa=ZQmsa22LcjeJSScSHHGz4AzCkJd74H1auLdq31AVPoGxA@mail.gmail.com>
Subject: Re: .clang-format: how useful, how often used, and how well maintained?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: multipart/mixed; boundary="00000000000030403e063859ab02"

--00000000000030403e063859ab02
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> For that, there are a few things we'd probably need to do:
>>>
>>>  - Improve our tooling so that the develper can check a range of
>>>    commits they made before running format-patch, and other
>>>    situations.
>>>
>>>  - Improve .clang-format rules to reduce false positives.
>>>
>>
>> I think the biggest issue for this is around line wrapping, I'm
>> considering just removing it from the '.clang-format'. Perhaps we could
>> add it to our '.editorconfig'?
>
> I would not stop others from trying to improve the rules in such a
> way that only an overly long lines (like >120 columns) are folded to
> reasonable length (line ~72 columns) without doing anything else
> (like not concatenating adjacent lines only because the result would
> be shorter than 80 columns), but if it is more involved than we can
> manage, removing it from .clang-format so that "make style" would
> not use would be the best (or "the least bad") approach.

Agreed. I would definitely like to see us solve this issue eventually.
For now, perhaps removing false positives is just more beneficial.

Let me send in some patches and we can see what everyone thinks.

--00000000000030403e063859ab02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1e16b6ef391f8b7a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oYk5FOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3JuQy9zRWlrVk0rbjNYRElTVjRvMXc4UjRzeEQvOApPdC9VSkgrQ1JJ
ZkxnYjBMd3dzM0dJekpUTUx6Tm42U1cwcVZMY0NkQzdJTUdteXdSMXZFNCtxclZhOHR3cmVECmtr
QU12b2pnTTRKalcyWGdsQ0F6cytlQmRaRjZKS0RxUkUzZXhkdkpmS0pMNlJwUkZnVEoxb2UwemNl
eCtMUXgKMXoxNStBMENsSEVvTmtqZmdmVnA5R3R1VzdGcFpPZER1TXdKekY2cUkzQThHM242aUxZ
RTViT1ZWVjVMQzdHYQpIeDRoblNrWk1NUFpUaWhaOUxhczVJRFhoejBlOGUrSjFta1F3Nk12RkZ5
TFVTbGtPRC80OERjRStucXlUUHFECkhMNGJQNWFZQlczRmUwdmJVcUNFeFR5dDd6Z1FSZ3NtaVh6
UDlIV2FMZys1YXM4bVlEVkFLd1FRRy9IYXVMM00KNUV2bThtVWdFQ2FuRjhSK0xCa1JMM2lxQnhm
amxKalhHWjcwQWNzYmNXcDY2cEo3SmdpK1RYQnR4djJPanRFUQorei9EbGFWVk5nWmUxQkZwa3hD
T0VyeVlIaDlhZjFnZVVrTHN4U1JPOG5wSVB6MUNWNmp5VFNyenRYOXVjS29WCmJQcnA1SWtDV2ds
dEpUZnlRSldCb2RUZ3ZUWFZmUlBtNmJiVmV5UT0KPTIxcW4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000030403e063859ab02--
