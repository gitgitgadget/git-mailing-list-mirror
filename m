Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0221C9EE
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733869; cv=none; b=qAYo5EH4Qp0xGDxFVeeTp7QlFbn28jHC4lOSunjaQxxHgKGK4EMSPEjY+sg+RpNYyTDFmw28Tf5EZJ1uXf3aWLlIcXsbF7v5KtnQgFVlTWuXHVqYN4ZFdUWTh3ry/vOrPZIjTeIojRdzooe0UGLBjnC1gfOvWJ5um+BpYlagisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733869; c=relaxed/simple;
	bh=ASgL85X9W+TgbWgS7ltFeKjVnMk+PQ06ATOO3pAQYjw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDtV37Dmn7tD237numvfArhk3wWNkbeOEsW2NNuq8btYZ6siaZ3iab5kDEYdtF6Tl1ZWIuj42mkaXoo7Pdc3Te4laRT2aj5hfiZCWk9F8Gbv2XyEzoBjjvvOvGUZ7HXvlbJoDoinZmW0sAQXmTdR+moCS9mGAeXGOMktKYUNnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXdB8IIB; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXdB8IIB"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e149bf7f4eso1364523137.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747733866; x=1748338666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r9k6eBrVqTMX6ef072oj/BPfGiP9oBgS+ia17ohaJiY=;
        b=KXdB8IIBewn1A2cMJ3sJ56SIJvvVhB1kyPTUxkX8pnmRfIzH+WABcqP6EBORo1n7PZ
         f6R+gCY29U/rBLgR50BPtzZfF9U0WXlG/jKIU5Qg4x/vYT6Xgm2FeFud7X6F7lSN1+WX
         T+3mgUB2znBF/ldXQn3YwnJqYo+OvExnwliFqMIFrw4VyPeLkkfN4wSLKtp7snKsJdtB
         u7SK4t7trISm6Emo7PDlSeUddJioVJFPVoJpO+G1UAMo+bZv4XKfM0H/70ej+OReE2XE
         CYJ1GDdugn9Mr4G2wYMGEDnKbEJJib4sYRlBHqNEyZ7tm7DNpFkNqgDlojkl7YG6OIwR
         qYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733866; x=1748338666;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9k6eBrVqTMX6ef072oj/BPfGiP9oBgS+ia17ohaJiY=;
        b=n211l4NvyqEeroEzMlIieIC1aK79sWf5/L4nwCx7SWCVe2sCjYbqXXFI4lX/IeRzAn
         bzmQa/vqyhQG3Rv576zRjk9ba+g3GoOCq3VDdkRALpYIqXKVm2UyxiBViJKPLqkYaIbt
         egSxFR18u1RvmfyO64HZu1CFlEOS+cWVuf9ISm55qPjl8rbGpiN3iVpilyT+85yvdB1U
         fsMy9748Rec7/iweHkYOTEHzyjynIfd559oKTeNJljJ7BahEJDrkFSfIyAN6R/MMcPAa
         1T7PmD8zvqS6pgk6OoxhTabK67f9QZQJgnH9XooJvgyBnQ13XuTV5zcbdjYd4e7ur7qu
         sWTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOeRyq+r+5SzyiZa10qvYOz9bkbuDcBfto76crVr/LXIjqXn/cWJAPbu3LOWjkl84NzpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8qndZmKOshM5lwAaDlITb07luyMk6Wg7ItzfBavLb6fRHCD7
	VJNluvDwuriUe2k6WdXjPzT0sJmb/DRDY2Paiw0gMNFxNaSjr0ItCOGpVGXV31DojenQcYpyyy+
	6nhJ8bnidGvdCPJLlTmqaGY3LGsjMU5s=
X-Gm-Gg: ASbGncu3nPwaLGaNfn4yAXBSgCkGS/jS7HSM8B5gjGdm7+ImwREETK4+H9vJwD/FRgr
	A+CljpRI2VDPhlghrFkqJV+QiFhHZA2/k932p+IYC/QRbK9j6oADZzspWUf0c/9SucYENzail8A
	To0uOz57lptFWrPvvfveaEWN225L6W/C4=
X-Google-Smtp-Source: AGHT+IHxgTh0R5FaGzf2i1RWXVYheGo5a49GC974vT97ua1lc/rCWKtGOjgVw1RhaMy0qeF2PM8JX5n1/8o/1vvGRi4=
X-Received: by 2002:a05:6102:b15:b0:4df:8259:eab with SMTP id
 ada2fe7eead31-4dfa6c31c1fmr16164024137.19.1747733866045; Tue, 20 May 2025
 02:37:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 02:37:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 02:37:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250519141259.3061550-2-christian.couder@gmail.com>
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com> <20250519141259.3061550-2-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 May 2025 02:37:43 -0700
X-Gm-Features: AX0GCFvAQ06S7mr21pz4PPiShW1e-qErLzihIxiqf0Z5Fd3wqzu8GAeJ4znvjJI
Message-ID: <CAOLa=ZRnL_PLVpQrmHPMXtJd9e965B5iz8widkk5GNSDvh21Pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] promisor-remote: refactor to get rid of 'struct strvec'
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000003f969f06358e006e"

--0000000000003f969f06358e006e
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

[snip]

>
>  /*
> - * Find first index of 'nicks' where there is 'nick'. 'nick' is
> - * compared case sensitively to the strings in 'nicks'. If not found
> - * 'nicks->nr' is returned.
> + * Find first element of 'p' where the 'name' member is 'nick'. 'nick'
> + * is compared case sensitively to the strings in 'p'. If not found
> + * NULL is returned.
>   */
> -static size_t remote_nick_find(struct strvec *nicks, const char *nick)
> +static struct promisor_info *remote_nick_find(struct promisor_info *p, const char *nick)

Nit: while we're here wouldn't be nicer to rename this to
`promiser_info_list_find_name` or similar?

[snip]

--0000000000003f969f06358e006e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9db33afe8d8b57c5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nc1RXVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3ZBQy8wVndUL0xTSEY4RFpYZ3NtRkovNHdiVHoxNgplRk00aWdycEtL
ZXlib1ZtZmZPUTdFR0NkR1IwTWppRWZPa3VKTXJTZDczUGdMbHlOZmcxell2ejBqTmoyazRHCmVh
TW11a3E1WE5ZQVRHbFVnS3ZHWjRaQjZ6YXFVdlpqWmRsem4yOVg5cS85VkNCRFVrYXdnMDFMbDB4
ckNzMXQKWHVXcEtRK05XT0pCVWE4eXl0MVlLT2FxMmhha0RuR2N3N0VLYkpQVEQwVVFZSzJINndi
U3k0dnFYWXdid2ZjMAozRlNyVzZiT1c3UzRTR2R4SnJ2RDhCZkxNb2pMNFpweWZwck9lWXVXWVoy
OWYvNjhadEtlV0FMZ21aNS9JdkhFCnJWZUJqdFM1OFVFMHh6WW9kMW1yK3o3dVJNMm4vTWk4RkR3
M1dhaGF5bUtaRHAyMjdVS2N5OGZTeXFmejZua1AKeUh2RXdjbWZPWGt3NFQzME81VTRDa084QTBp
UVdtem1XUkE5VlEydzU2V3lwNjdLdzgyRWFyKzU4Ui9iVnFydQpvSHRHdHJBVVllYWVvUjR3L3lX
aGpIekY4YnZndExJNUV0ekczVDA3R3NmUkRjcjgwcGVnQzZTMW10aTBWa09FCk40SHdsOVlLc2pn
ZThvdnBrbFVZNENDVHBuRVMwcE5ValdKblpacz0KPVRKeWEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003f969f06358e006e--
