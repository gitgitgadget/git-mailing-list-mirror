Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32D187550
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730064372; cv=none; b=AsDYfQ2GAtMQq4EQLg0QK1o+zxYFg+mKIpc5jnVTxT/asO4L12Ar4sh7EPQYS0aMGkipNmDXLuCRB/JojtLLeczhJKSxTVG6E7Tr9OLMY4qCPQm3T1Biq7l1/dE7Z/63m2/rflfkNS/RK8Cj8FQFAkc+Z5ZyhwOffY6xqD8e780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730064372; c=relaxed/simple;
	bh=P0CA+4MODqM7oZt81XD7QP94tw8smkQkIck5xK37PDo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Rb+1ITL8SP5uQhGEMjVhKY72KSuwL3sEno3GNTsMf3lgnw3H5xcWiDWGO5Pgo6ZIrJSIB5XbUMYNQbsP8IGYFPwkDOA123czuJUGD4Vy28a5R4NnC8d9G7MOFOi5k9rggODZ6aDuKWeHF+REgGubYUB1NptGEa/j4uCU2SmPCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4LYiULN; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4LYiULN"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a47fd930b8so1047698137.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730064370; x=1730669170; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HPVNptbSuS8yWSZQyxzqXErzZL7aZKGPhRC6fj7b3w=;
        b=h4LYiULN6mnslH4QsAq0y8MEiLqoh2UVhdfmFsyYgb9dCkIbbLjo8pZ8ePCWecOZ84
         IAlKvSSPMYhsU3SNkWSX7tYU2sEU+WeB4M5eWY2e1S6PsPlrfJbTDzPpFA4rdf/onsX9
         m4+6uCHc75AF35w9nTtNVgTvzaT+4dJ1M/zPSZa86xLPY5GMVquDZyK8K/bydyqqSqL/
         oUeCJFsdjjAm+vSCUPo2xP7epBbF64Eh1og4g72c3Ukubr6OkkyWla/Ltc6lMeHYxqR8
         OCVlpldlbhgvznHp2dZetDkU3B9HmGgWrVsUEshc1Mk1zFJmJlW5x6N7c4/ssL+6ufr8
         jHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730064370; x=1730669170;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HPVNptbSuS8yWSZQyxzqXErzZL7aZKGPhRC6fj7b3w=;
        b=TdMUezUsMr/RzKP1kDyykwAdEawI0laFO3KD2mhHtFIIN5WC4BSQbDvAS8iFxMHtMr
         AsK1k+t8tF6o1ytp+cmPIYTpjqJXlPGVAJO7pdjdkQMQVirnpfJ4aKTi9D8NKqOufT90
         Ug/M0JJC250WRY+X9S4zQOv7slYBN8nnxtaFhpMoeKME2XiNs3IkKpcrlN87FHSMuY3b
         bQlqamZU2jadlQKJnS/mcwGLQdZ6k6l6ZfFxjLuVpcaT6UFDuV+JFdTzlniOOYEZkemX
         7VF+pZkrF20OW/dj941hcGYNxQGgljewvVojoe+8JZYdGpPVqIJFK0ke9a9MewtOwfod
         PsUA==
X-Forwarded-Encrypted: i=1; AJvYcCWr5gc79Hx7dPERIsBF2uF6P1dIMigmuybtuB4hM5YduFqP7JAS6pZmbNQzSdAF21XxNVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CP4Z4Ad1AmsZ5Q3+xAcwEVq7e6OLrH40L3opYFPtaQ6lwl7I
	9ER5nL2/MPwSv18AAI0f05ENLzV8x0Sk0NS4pI4QPwKMr1quAMX1dfhJIzcfcNVp1pi8e0y4o49
	C9aVALIS/ar5437FGWbVI0WxQNuKvJOg2
X-Google-Smtp-Source: AGHT+IHql/cCaQcn2a3GGu+MRNl4hMX9OfgIReoJYDJACmBvHKj69MgX4VLcyTzYWFqhBYU7Iq54rbZMKP0dOtCXZDY=
X-Received: by 2002:a05:6102:3910:b0:4a3:e3a5:1ed7 with SMTP id
 ada2fe7eead31-4a8cfd71209mr3864671137.28.1730064369646; Sun, 27 Oct 2024
 14:26:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 14:26:08 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zxv0SgY0oajpst8s@nand.local>
References: <Zxv0SgY0oajpst8s@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Oct 2024 14:26:08 -0700
Message-ID: <CAOLa=ZS3gqv6bB+gLxeYUmu70hJm3=8paJFWU5OLpG1dG9Zr5g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2024, #11; Fri, 25)
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000313af606257c001a"

--000000000000313af606257c001a
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

Hello,

[snip]

> * kn/arbitrary-suffixes (2024-10-24) 1 commit
>  - CodingGuidelines: discourage arbitrary suffixes in function names
>
>  Update the project's CodingGuidelines to discourage naming functions
>  with a "_1()" suffix.
>
>  Will merge to 'next'?
>  source: <20241024105357.2605168-1-karthik.188@gmail.com>
>

I think we can probably merge this down. We can always iterate on it if
needed.

[snip]

> * kn/ci-clang-format-tidy (2024-10-18) 2 commits
>  - clang-format: align consecutive macro definitions
>  - clang-format: re-adjust line break penalties
>
>  Updates the '.clang-format' to match project conventions.
>
>  Will merge to 'next'?
>  source: <cover.1729241030.git.karthik.188@gmail.com>
>

Justin did leave a review, so we could probably merge this too.

[snip]

- Karthik

--000000000000313af606257c001a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 38132b9b70cbfeb1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jZXIrOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjZ0Qy80anYvZ0lEa3hOUzI3RTJ0SGczd3B1ZVVleQpuQ0pkRGxvQWpG
T0pwc3pkQjgvam1pd3RXMkZqdkNsRGU5SFJSRVRKY2JVaFNYM3puVTk0a2J4QWV0NVhQbmwwCmJt
UW0wNXpPRzFvL3VMZ0lDNlpWQk5NNERQYnNBbDVqK0l2a2M0bWFMeUVyNjVSTGRybTBKOWJ3cW5W
ckp4bmwKT2tSemhET2JkRUM2RDFYbG1wek41TGhHbDlhQmVjREUvVm1Ha05vd0ZWREYzWnFrRzVq
UUpJNFBDV3h0VWJFbQp4NzQvcjVDQmdnZjN3SHlrMmJIN1A1OUV4bEFsZDZmNHBVbHA4TXdMZVNk
alRYZkdlRDV0LzF5L0VScHNZdG81Ckh1MlBFU0Q3YkRaMW5jS3pGNTJkQ2RxR1B0MGY5YkE3OEVu
MThTc3c3djE3M2FoVmZlTitBcXBFZ016ZnNJenUKaDRld2E5KzRpQURLMS83MU9URU9ESDZyQVF4
empTOW5EeWtrT2hYbERocitxM2M0UHhTbGlkay94UlJ0NXdMTQphWCsrbmxhSWJYT1haTzM1ejVN
Nm9rZ2tndnl1Nkp0V1dBL1JWTEE0NGJqM1BHKzhrWnlYTldWTWF2WTNwSkZoClN3WGlXdUMzWjE5
QlVCWWE2ZU80YzdWckFmc2tLdklCK3l1SE1vbz0KPVQza1oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000313af606257c001a--
