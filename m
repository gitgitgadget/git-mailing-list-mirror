Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C3EAF9
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748884436; cv=none; b=kcHljIiPPWjY20JI2S7Hz4V/VR8JB65zllEpU7zkBmJqYbeZxQiKOhuqA4oSi4aXJnRzzUhyKLQzxW2t8TwEvsERQwk8n/oKoI/7SkQcte3xbOXLvZhuSdzAHqgrXsXuv/ygbgZdzoI/HLbDYHpAZ5WA4W7ycalzKjtWrYCDXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748884436; c=relaxed/simple;
	bh=4j198l0kDfbYNWwt2Cl8tvR/DgE6ehIg39cthavVrPs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVzfYtKOPSUatNLXja3vqE+B1m2DaA8noh9n5zx6IEU6/bFL34EE9Fmfpt2lAIpMisG/omaY2J6eNM2WtuzadZ9/3QDFbSRSQH3vm0d55DYYWfC4k9mmWNF39YTITjXdBgu3zovA1MkH6Sp+lh/vO9Mp0n7vxEMX26rJLI9Ah7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gerjj0wk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gerjj0wk"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d09a17d2f7so389229185a.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748884433; x=1749489233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4j198l0kDfbYNWwt2Cl8tvR/DgE6ehIg39cthavVrPs=;
        b=Gerjj0wkTvxg80tpxdo3lMG942C/XyAlWpUmgGK/d+izxyEPJYVu+C3kinDj609PVC
         VkErz6dJURIqsMuS10uhkoC5Dj3GmCUM0mVsJy4QGLIH1D3V6pbPum8yTtgsdRDK/Ms3
         lYxz//Fo8tR+nrw8joaMym3wIueAIDUlPiECuWiH19YXRKHkbdrp75pr03fepwhyJmg8
         zUnBtpzcqKeqcY2Vl13M7v+0uxDoz0ZpdMC9mGvqCMdEMNNiuX9CzmbOh3K9mLzo5jht
         aTlxc78pdVS8avu5ZcBlnJknjl/PA2ZaHMX7Vl+R9jOxtnFJXxxJGbizTWvxr1Ho1uRK
         oLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748884433; x=1749489233;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4j198l0kDfbYNWwt2Cl8tvR/DgE6ehIg39cthavVrPs=;
        b=ucH661VOwl30/uhYZlNkpIba4PoznIpaTYeBvRMxdCks/23W6RC4JY0Ycw6DxWU44K
         0R93meM8xKRw/PxU7osjvFLY35Swjl740ZE6lfV/PT9JR41FrEzPlr+R13kmaYyZy8cn
         C7Gjqg4LQ6JaqwRwCzXFc6AwpVRWuBgEy9cyZwM8qRlBT9bLc06sCnnJ1ZKzif306/xL
         Vx4D+LlDAbQhgfSg3zVCnjzZrEE0l0OpPcyybMKjT7HmUZ35uQdkRrcAuDblnWwAgkbP
         71ATaGVDU/rY+y9UqW4nPfWLgNitKJN6hyrOe2U9gSePw7znykMaMjkLn6zm6wCiRD80
         w1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCU601frUq3PlsIJL+6OdQ4/lSkAhk1OO1MrzXAyz4ZgZSoBkoEMuv+NgF0ZvHvWoiwss9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZ/ZnDVD8HwkkPQJOXYyUWAulEdEtpxq/pY+T+EqtaaahGIaa
	BeWLlgRCu1ZSeTjMbqT/ZvhMWj9JIortGviE4QsjyYrzw+xcQ1COXle2XJK+0T3n3fQA8YF1qdC
	QptKntPfp6vmuixqBKRa+3d5sevfUWXM=
X-Gm-Gg: ASbGnctvxW3wkh092W/6zSkI6DCaMOcQadY4DbsL5v0Iu0awI7A4+aARUezhcvP0Ips
	Rbieijwjc8Y8wENuTnP7JGmJe/FWyg9mbJMIAl4QgPCuL03BXQeOO0eXDvK15JWAi02gh7Kgs1a
	aYkzY4N4gfqVKmhZslBPMMikfgKi/l0mKaUvXCMc3FFiCUJW9PyfRFwfwNvSRpJuyuOqg=
X-Google-Smtp-Source: AGHT+IHLQeUS1FWA4RtaP1FVe5WB10RObMgajy4Qhb/zUjUj9Oo12PpU2aLbEEd7TXnBFkdgHuyz/brYHC2QAYo5wsg=
X-Received: by 2002:a05:620a:4012:b0:7ca:c9cb:ac1 with SMTP id
 af79cd13be357-7d0eac3f065mr1272875785a.4.1748884430436; Mon, 02 Jun 2025
 10:13:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 10:13:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Jun 2025 10:13:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcybmuqrj.fsf@gitster.g>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-1-903d1db3f10e@gmail.com>
 <aD2SRmlSKZm8g8kn@pks.im> <CAOLa=ZQQCFA=jdOGDONGcsO_VDUAxfHjn_Wk5r+8weHMFXDQ3w@mail.gmail.com>
 <xmqqcybmuqrj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Jun 2025 10:13:49 -0700
X-Gm-Features: AX0GCFto8AyMM38i5YhzabBBbmBWECsACNZVcueH9UcYkzi_Fi2oBVLz-_VyyxI
Message-ID: <CAOLa=ZTP0i5q9Qw4g_ei+kSLyaRAMEoHf=PnPFbr7pRqgnyXAw@mail.gmail.com>
Subject: Re: [PATCH 1/3] refs/files: skip updates with errors in batched updates
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000003b2273063699e358"

--0000000000003b2273063699e358
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> Curious -- we do have tests, so why don't any of them hit this issue?
>>>
>>
>> We don't hit this edge case in any of our tests I presume. This
>> basically requires a deletion request with an expected old OID, however
>> the reference should be non-existent.
>
> I read Patrick's remart not as a question but as a rhetoric
> suggestion to make sure we have test coverage ;-)

Ah! Okay, all is good then, since my patch does add a test for this now.

--0000000000003b2273063699e358
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8d5f537d57ce5817_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nOTI4c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMDlpQy85eEdCL2pPYlliUmYwM1gwMDZaUHZMVVZraQpUaUsrUUhHVjdw
cFVRNzh5YTFiN2NiWGRaaTdBNHZYQXdRUWoxY3prb28vaDk3ZFpVRDFtVXhZK1cwemZGLzIzClc5
K3NIeU1FTmVRZUFoeTNxRnQva1o4ejFCWmIrYlJYU0s2SVN6S0hlcEdsUjdvVEdEVUhYeE9lUzJF
OGlRUzEKUkFsMEc4MFJscy9WeUp3ZUtwS2paQ2pIdUgzRzlmd1VzYVJkbTBKc01CcjNyYkpJelN1
S3RHdW1PQWlMb292Ygo0Q21tUDhaWlBDbUZLTUQ1dkt0WG44LzNhTnVZbGtpcGZVenpvTUY5aWR6
VEIvcEZYU0ZZYitpWERXazZrdWhnCkFZV3lnOUFWS3F0RzhJWnRxVm5FdUVpeU9DTG12N3RjcmtM
Z1daTDN2eHdCd0hKZkUzWFlWa1NFV2dzdDRxdDMKeGN1eGM4ZUJhY3FzVk56SmFPMTNrN0FXYzdZ
WFVrcjZ2MHVzMXZGRVA0V1lwWkd4Mjh5QmFEc25oSlk3UHdQMQpIdmFQbGE4R25SK2dOcDNFWUU1
NDlRR2VDbUxGYlNTdWdNMVNwRTY3by94TGhjQ2JETnJ2dmgvQnNacjJnTGxhCjFLV09hQ2NVMG5I
eHpOVTdrN0lTbHI2VUdWcFdWYXo0WXNkS1Jqaz0KPXp2SmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003b2273063699e358--
