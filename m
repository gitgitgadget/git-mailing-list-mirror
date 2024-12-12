Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC22144A8
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013641; cv=none; b=bj4PzJfH9IwIp3SfNezGPJZMUWyxRPi8iPEfMd4vqVHhnMhYE9h78aBDbnPm8RKjL6PqzzoZ94TpUkHaViplr5Dk6jXnjd/N6taGnaW9Bx4cJLYTWOWrtIB2oQHOpCiK2+giRST6GOkaFdotB5dBjKnyDub2EIVHaks8j1S5nHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013641; c=relaxed/simple;
	bh=evh7uh0XXYhHG/hujHgbi9kMuSDvTmWu3pP5EZgk1tQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=me/C6C/yCzUQEOBKZ+8KbWGoCNg+E4FJLxcj+wb45ZFGqgJ3NClVoiY70L1QqCOdvuVpt5brek7Z8Ie3OJ8lI+vrq2A4ABI+dD8fIhvn0B5wXuFGxBsTPzl9gxeiEpd2IiqCfF6+tiPCO2zHoiIut0NzOHo5QL87QcVEVIbV/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3EkVFia; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3EkVFia"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85c48f5e2c1so154670241.3
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734013638; x=1734618438; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1QmR+5VT51vbwV1AX27DNZXjGOB8WfNhKVvY+0H4/6A=;
        b=R3EkVFiaqDFC1RWMpLkeYqeBek35A+TqQsUeJmm46JazZVcs54JZAcxE8gUEwMJEhD
         sraK+XZWD3djQZuUP3w6xK8O6aVRoR3LPw5mZXyE4rLv80A7+GhHpRl2nrEs8uy3AV61
         VqzlQ5BDRNdyC/SsdDOaN7eVR+b6q56xi2iFf1S6PoW3HVVlpVlNpTMHE0UPjFFGto+A
         qGof8qDvpj0gsoOHRG7v+2K2BAcvQDSnZoVafrVI/TCcTY7UMs902VsQ00rSiaQYvr6P
         Bk6roQ/076ya5JOz7KV2uXylWVlHuxqSmJUGDlJNtPLHmtXybULjgfWHSy64XJfery1M
         jDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734013638; x=1734618438;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QmR+5VT51vbwV1AX27DNZXjGOB8WfNhKVvY+0H4/6A=;
        b=X5xVv8/tj4rPwe7CGxhs1m5ahx9AJJTTn9dw4QoPvRhebqeZTQFC4NC/1IPfXlur95
         8XVoHs7nT84TlzNh/Kg7JtM0P6kCHglYCN9NgaeXi7/1kh9jrNR9F2BcXaXy6uoiFLwQ
         phG+4AQ3FqSov46aTp3mqXJWnBwQX6+q6HIJF/V2X5KPfireoboRmuU3sLY/IQLkZ+Q0
         A9+p9SaYyVlvaMe940M57iCZNypQhrmI/fNwv6vr+Lhg+jH7h4W3OgtLy8TJMKQ+IDjo
         oxGxhKCESp9ZLNoOVKkb3QFi21fuJ1fJNnZIBLFPazbfsgt3D5WEloDARkJDv5LkatY7
         LPpg==
X-Forwarded-Encrypted: i=1; AJvYcCVNEeLeUhU4Ij2hR3j5forBPibiYnZBrz/vwcVQ6buXEcjrNZ09VKUx+f8s9khtL9NiF70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3lEHUj2NtfL2+h10iSnm6fyd7ds4tXNnQagt6iiD37cP/Bw+
	vplStR9CrPeT+9hVHAyKqIARCmUM7taltiZMpkFKZmdd8eb8CU51Uhx0XGPt9Uhi3HsE0JQ8rLd
	kCOjEDsTU5fvPQCB1OZZU7WpWVQ/rPM8m
X-Gm-Gg: ASbGncumGsL2tLdPZHpCirdbvbUfFerk3J0jCJERUR+Jh3tmKQHtvHZPHh8mDme7stD
	5OZOXRPvCe6ryPojUWJUvDWmZW7Z3XImZCmx8
X-Google-Smtp-Source: AGHT+IE67NbW6bMPsbzzHtxYup598/I96TjT6Uok33aO4ot0If1MbXrMDwlRnHPAkVT44/XC3dSdGsPAPCfpDnLZmf0=
X-Received: by 2002:a05:6102:38d4:b0:4b1:2010:5cd7 with SMTP id
 ada2fe7eead31-4b257fb20a1mr640612137.8.1734013638058; Thu, 12 Dec 2024
 06:27:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 09:27:17 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8qslf5h1.fsf@gitster.g>
References: <xmqq8qslf5h1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 09:27:17 -0500
Message-ID: <CAOLa=ZQmDyy1yajNzASUkRZeizroyCXcgsRK+fOtstatg5r=2A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2024, #05; Thu, 12)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000eedb490629138258"

--000000000000eedb490629138258
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

[snip]

> * kn/reftable-writer-log-write-verify (2024-12-07) 1 commit
>  - reftable/writer: ensure valid range for log's update_index
>
>  source: <20241206-424-reftable-writer-add-check-for-limits-v2-1-82ca350b10be@gmail.com>
>

Hey Junio, this was reviewed by Patrick and Toon. I see this was added
to 'seen'. Is it also scheduled for 'next'?

[snip]

--000000000000eedb490629138258
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5ab65ac9de13ee6f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kYThzTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0ViQy8wZGd1cHF4bTZ1eXQxMURrc1l5Y29seGVXTwozVThaeWh6U3R4
eCtQUjY1VEtpN091dVdSTXVrNVJLTW9JeGpobVRVb08xY3kwbFROc2xtTHF4d3N4VzI4aHRUCmUr
V3laVzVhb2lRSWl4NDRiUXhJcWNzK0FjN3pNSE53blY1d0JDckQ3MUlvTEdHMWp3MjY5azhKMzlJ
YjRHcHQKRzVvUEVZbzN4QnNzbnFMYzZzdkRvRlBvVVNhcUpqVHh1M3R6bVpTNjJXcjMzRmFBYVY5
QUdJL0kyMzZ3WkxsRQpzMEx0MW9BSHFNeWFiNTR3MDMxV0pLYkViQ1J4OWdySndQTFlEQ3pwdTNu
NDEzcXJ0VE5nbG9VWDdya0tSenYzCk9iQnkvdzdlcG1Sa3cwRXl6TVQraXE2SWNqUlZOTlVEUlhk
bk9KanlRUTQ4WE51ckF4ZHB3VlpZVGlQU2MvWHIKcDduTit4YURZYmwwRmxaYkFBLzBiTXVvd2Ev
VVdhdi8rQzVyMDk0a3dmajZ4ZHUvYkdiOXhSM0xxVitULzJQSApjTi9zYy92MFZMcmFuSEdpTEZD
MXEwQVBNOHlyUS92OWJnZWVOUFhVeEthVUI2Z1c5cnlYbW5LTW1pWGtvMGd1Ck8vbm5Yb2xMK2pH
bHRvS0UyaWMzWndlUDJVdWNtNVFhRjhUUm5xdz0KPVY1K0EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eedb490629138258--
