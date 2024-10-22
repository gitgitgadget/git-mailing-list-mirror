Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32C1A269
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586843; cv=none; b=dCHq9YIsV9qALX6dlcbvp7+/q870cOQsf7WDhZo1dlxXw1B7S0daxXb2lb5XyTn781H2kurg6sxSigHJBrzr3XXBXMBfcqk225t8uVEXmtdh96fL7QFO1x+fSfp01HZioi5IqHR7I9f1KsbFvMuMk4u6JJjEIQ8K8m1ks8bOQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586843; c=relaxed/simple;
	bh=RUuqG4uRjqfyU+fyR3R6E3n0MD/os2rC8CAr0JkICjk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdwYIDNjBJhbHJBLTmdZ0fxeR+Li0W8fBzlXHfktl0uCYHcIJEz6OJxniA4mRVRXTtV9aHqWqs8xyEHnoqyDEh4Pegksh4AGRc2KpwV8ApHT6imMAZQHPgDJdb5/85LzZw4mj8dylPoJ5EkuVlHK2imVjfJRuhTvzo7K6G+mTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4lGJA80; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4lGJA80"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50d4a333a87so1668791e0c.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586841; x=1730191641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=suD48B6U4da+LZ243Je8R8wnB5EFgKieKKUvMJ8Aeuc=;
        b=H4lGJA805Bamqa8g8aZAn0pC4hHYaXpkFUOndZghHvYKhZGEMVsA3UQfu6u1ewoGU+
         SPb5fdJswba/eoyAIveQGVASzx6SfZHEoCW5bi/JnhDFgoo1NDj9XMU3MsjhFjc2GWxm
         vjv4VmLLDDtzfLHonsHpXViGThOcjL24fYX73J5HNW+qt4Vrn2gIIFGlnh1jOu0GS8Pf
         4WczV6gcz8Zhbq+zDTdZW0lB1vEWJ2yHCJwdizXL0DGOFRIbSiSpKiaqAzLGMMr8zyLy
         zsTrCk0wveNTE6nNN9R/1W8XCWtlDG+5wRMidqqBoo41p9J1S0fZkjP5bb7Mb9zPbU6q
         1Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586841; x=1730191641;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suD48B6U4da+LZ243Je8R8wnB5EFgKieKKUvMJ8Aeuc=;
        b=YfguN19vEkI1C1uaD3mUACmuGZUUV0jtySMpcFrSjpzMp0Pa9aHHz36/QeRc87yxMw
         FK9r1Zm/O6ytlbONUAZZYABKRhn6HJt0JuswCp+w/5hZyxq2l8mHDksrZQf7BpM2oH3e
         cIeaA7SzEl0Lj8gUJLPyxKl05Quvouky/UAL9l2KzSz/uywyKr3iuYORvAPaikwf90Bz
         UPx8etRlgXREaNJ0Q8LwBkLrnf/QRwYK1X+f4j6jlo2HXsTAT4gVHEYOUQLbIxT0OsiH
         T2DPmoXHN4HZj03ABB0OoG5eksWgkrzCsrRc52PEFqzhluqJNGEziTiI6kzVBiSanZGu
         6uGg==
X-Gm-Message-State: AOJu0YyBD2UOeS2mpE+XfKBQ3cgu482U1tQJ3rpOFRToop6vt0lzwvlo
	0LJSxX2LCzxezj/jGK18euh3RCs0tfB2LPPqIG2YR49QIOEp1s3IaZLoIuxPkoVqtTGlTA0UWsA
	7RpvV4lQ1FFZnGR2fxDHRkLQJ13s=
X-Google-Smtp-Source: AGHT+IEdXKrYMkGNaM8EG34HLk0kjviDM8iOOdSEBgWoTbKV0Qo42YG4O0aTyYUBdd4Whc6JK7KUDKHWFi46vLK0hQ8=
X-Received: by 2002:a05:6122:1790:b0:509:e7d:b7b2 with SMTP id
 71dfb90a1353d-50dda025c30mr10725936e0c.2.1729586840831; Tue, 22 Oct 2024
 01:47:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Oct 2024 01:47:19 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <aba3d76c-5234-4875-a1a7-b212bb27b266@app.fastmail.com>
References: <20241021124145.636561-1-karthik.188@gmail.com> <aba3d76c-5234-4875-a1a7-b212bb27b266@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 01:47:19 -0700
Message-ID: <CAOLa=ZSWTKzgep+r8Qk9rZM_W28WsOS-k=VF=R2PHNMHLR613g@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in
 function names
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="00000000000041aff106250cd1a5"

--00000000000041aff106250cd1a5
Content-Type: text/plain; charset="UTF-8"

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Oct 21, 2024, at 14:41, Karthik Nayak wrote:
>> We often name functions with arbitrary suffixes like `_1` as an
>> extension of another existing function. This created confusion and
>> doesn't provide good clarity into the functions purpose. Let's document
>> good function naming etiquette in our CodingGuidelines.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>
>> This is mostly in response to an ongoing thread [1] where I ran into one of
>> these functions and it really took me a while to wrap my head around what the
>> function does.
>>
>> [1]:
>> https://lore.kernel.org/git/CAOLa=ZREg3xuaT6mbM8+Havn3regZDhK45kGy0+Fw8t56c7Mpg@mail.gmail.com/#R
>
> I was wondering whether it would make sense to use that link in this
> document for the context.  But I see that there is only one instance
> of that in the current document.

Yeah, there are a few such functions in our codebase. I'd be happy to
make any improvements, but also think this is simple and clear at the
moment.

--00000000000041aff106250cd1a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5d41a77070d3c95c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jWFpwVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkJrREFDR3RYSllpbisxMlp3TVROTE00WUtnUXB4RgozelEzSDhWUDdW
WWppN3hXZ1hFbG9FcS9LVUUxOFJRR1B1dWp5emdBc2ltcCs0MmgxVWtYNWJnVWdoc3BkeG1VClNK
WW0vdFMwU2JibTh0SmNXeE85dUVuVGxHM2g1QTdWMWk2RmlGVDErcWQyZ2cvcGtZMURybG5Ub2pE
VFJQdTUKdmFuMDBZeW43NlUveUszRUYzUjY4Wnc1ZzBGMGRkY29yYS8rOWNha3A0eUpabGlNczBj
TS9oWmVSajR0dmdtWQpZUTRMTnc1aERDZGVsQlR5ZEZaUEUzN3Z1YncwK0pLTTdUaWJEdi9XUGI5
cVlsUVZjSXA3MVNkVVNCTUhBTWxPCjhCU3pYUmVwU1R4S3BheXBxVlErTGdVam5VWkZ5WDFiZm1G
TFZoVlpYNSszTi9nTy81azdLampPRXFYU0ViSU4Ka2h3V3ZkdTEzVXpwSGNyRC92YkJyOWxQeHZ4
TTdCamtZNlJEYklNZExjemJNVENSVm84OFZ4R0w0SmVqYjZUdQpaRCtmVXhXaFNIRFhOblhFdGJz
ZVNBM1NSTkVoMTNUcjlVK3lncG8yc1pFSlRQSzBwMmRqWVRTZ0RJa3p0bWFhClBnaEMySTZFNzda
NDRSV2Nld1RFY1B3R0dDcUJQenprbmw4bXh2OD0KPUpOa24KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000041aff106250cd1a5--
