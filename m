Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8A1474A4
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610742; cv=none; b=S1GISKn9tjSS3ILuho29vf2KyscDTKbqs3cc28XFM9LOWy3s+PDLZCga2tEgNzKl0bPBZpJEf+NjyhCbETP6x4+lNkj7iwRzLeuSjZH+U++5AGJbo4HwV9oPh94WAhh0YvPuV+rHcHv44lXaDKAadsAxV6MQ8S2+CIzyJt7p1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610742; c=relaxed/simple;
	bh=ZQlmb61nV+af1oIvL36w15Nahf/25QNsQW+a8INZ1BE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=M7iq49CH7Po41U4czI2akdXsI2sXWoAuBwHtPS5W8gF3pGlXmFTAJ5ynj+Zghz1RcHwKeY5O3ghSd1b4dUaEzri32OyZEXpqFGhGNyXxsLU4zG3DXpiBb/ak2GWZEEXtsZcSinkBJx0m2x1QbcdV+K3ET0tRiVBv40rUM3k6Q9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM+AaTzP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM+AaTzP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso4904107b3a.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708610740; x=1709215540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZQlmb61nV+af1oIvL36w15Nahf/25QNsQW+a8INZ1BE=;
        b=QM+AaTzPcchKzH5Nad0ZocZYELBolGA69BGlZyR2tnjOobacdMqVaq+TG9Q8COgJA3
         lDXTB2dOvEhJpm9d3M5sm90AWRjhC6XEldyNA99I7KPUpQs7mOlhQfA5OhyDbxDiSgw7
         /Pno6ryf1K+Ka330ZwNnnp21ofqapUBwPDZyQt6yaNnUmjQUo/EGYOLFEszk7iUUpdt3
         UWcKZjmiRh44N8L8YfUP1IydWxkTMWxBxLAQCAJHtVcMQs4Ga9lSxG4quNkxSNROrvLr
         B9jpCFeyvv7OTKVNOKVdVUrRVypwTqNT8LSVbEhU+HfYEasqTxpl9pXBzwFYVy069a7n
         oxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708610740; x=1709215540;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQlmb61nV+af1oIvL36w15Nahf/25QNsQW+a8INZ1BE=;
        b=hzPlZvENWFle360Br38PQH3C+r/ACZ6ddo4d82RD2Qf3eQQ/jR20DKBdT360Pun+Ud
         19gQApqtlpmzticaFRRzsfkpLkC/WgAevW+sFNW1QsZcdHMwbi7ZUOkdKAUKrqI/VXVo
         G1Ivkm35vwPhjrqc8B/5ZhxFYtaBMDKRwTUOCI1QTvvgvDadqnVjcztouZ6Lk0o3jsay
         +7hbiv0B9G2knT3J3ng9xaaExbLgpNIAqTZ4cSYnnwZgrvANiJbUEEVVzAPYbsciKOVG
         WcnAT9oMCPSR6vRTxnN63j1Gg8qVWch5ydjT2ZwK83+d1imh+SIWqOwJBWezjdgcTlEQ
         jqTw==
X-Forwarded-Encrypted: i=1; AJvYcCV/U++hfF/5ILdZn95PvlGCvtwhhuAn6yTeBZT825HWKWN3MFviqpXRZ34qnBkNw6LJFNOtk1R6ujALGdsrRrC/oVpG
X-Gm-Message-State: AOJu0Yy9Rn9RgdqzSXSBaFUn6wqvvwlyC+6snCwqLDKj6KkZVd2UpJIB
	WM8UQTl0XZ455GjgnkFLfrMw6O6ZyoNOhnbPs7mss7mVajI6Rif/
X-Google-Smtp-Source: AGHT+IElQ4xxDWfTRIeJPC31juMC5r1oLlqNoBMZbmIFlj/wRP2ichTDsgb4OML9l1Fso+BAZ26Ngw==
X-Received: by 2002:a17:90a:17a1:b0:299:d96f:9145 with SMTP id q30-20020a17090a17a100b00299d96f9145mr9144747pja.0.1708610740397;
        Thu, 22 Feb 2024 06:05:40 -0800 (PST)
Received: from ?IPv6:::1? ([2401:4900:4a93:b853:a7ad:da4d:d0b0:d7e2])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090ab38c00b00298e11b600dsm11755785pjr.27.2024.02.22.06.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 06:05:40 -0800 (PST)
Date: Thu, 22 Feb 2024 19:35:33 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
CC: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>,
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Victoria Dye <vdye@github.com>
Subject: Re: Git in GSoC 2024
User-Agent: K-9 Mail for Android
In-Reply-To: <Zdb8lnUSurutauRa@tanuki>
References: <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com> <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki> <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com> <Zbtmoo8qTmj-yt99@tanuki> <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com> <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com> <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com> <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com> <9cec06d8-971b-4c5d-9d85-969021b0dd48@gmail.com> <Zdb8lnUSurutauRa@tanuki>
Message-ID: <B6C95613-B316-404F-9076-FAC5955B8890@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Patrick, Karthik, Christian and all,


On 22 February 2024 1:19:42 pm IST, Patrick Steinhardt <ps@pks=2Eim> wrote=
:
>On Thu, Feb 22, 2024 at 10:01:54AM +0530, Kaartic Sivaraam wrote:
>> Hi Christian, Patrick, Karthik and all,
>>=20
>> On 21/02/24 10:32, Kaartic Sivaraam wrote:
>>=20
>> Also, it's official now=2E Git has been selected as one of the particip=
ating
>> organizations[2] in GSoC 2024!
>>=20
>> Let's look forward towards a summer with great GSoC contributors who
>> hopefully become continued contributors to the community :-)
>>=20
>> [[ References ]]
>>=20
>> [1]:
>> https://summerofcode=2Ewithgoogle=2Ecom/organizations/git/programs/2024=
/timeline
>>=20
>> [2]: https://summerofcode=2Ewithgoogle=2Ecom/programs/2024/organization=
s/git
>
>I can access the second link, but the first one is broken for me=2E First
>it claimed that my Google account wasn't connected to GSoC, and after a
>reload it stays blank now=2E
>

That's strange=2E Could you possibly try logging into the Summer of code w=
ebsite [3] directly in an incognito window using your GitLab account?

I've previously faced issues with logging into the summer of code website =
due to an add-on blocking access to other Google domains=2E So, if you have=
 add-ons that might block resources accessed by the website, could you poss=
ibly try disabling them?

If you face issues despite all this, the only resort is to write to GSoC s=
upport about this issue at gsoc-support@google=2Ecom

[3]: https://summerofcode=2Ewithgoogle=2Ecom/

Hope this helps,
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
