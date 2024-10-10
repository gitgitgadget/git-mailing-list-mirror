Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82A199252
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578918; cv=none; b=opx04IgxxRuNRkv/ZxhyxrRY5Vdjc3Ri0Yfv5u6ut5yBCKc4Rs4aFNRuh5Us/Ht9XLmG7+TaLfi+cd/6u/TS0UKCEgVtqx5gS6wnwaQj434dy+vciTU6bJRiEgpIsG5dM4V1N35mX0CHC3aYlnmckjagYsf4ret1TAOlnqhfMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578918; c=relaxed/simple;
	bh=uMkEguiz0h1D9xvWykAjS9L82oJ/vMmRDZoz5fQuq4k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SO2sMU09Ib1USDu3Ddb0+N66btwJdZy945Et3TSqCTw9cQZZ62hKuoxXCD6FvY/XSUCSfNvv/0MLUGl48V4ZLKRohNKEuvEBtULwP52Qqv+G2a502xSNKW0zKeULPhOn7Tvq9IZpv+G1mSOtpEMPu2/gNvOZNW6XdJ6zzlNELIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcewQIMz; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcewQIMz"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a3af308745so360538137.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728578915; x=1729183715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMkEguiz0h1D9xvWykAjS9L82oJ/vMmRDZoz5fQuq4k=;
        b=OcewQIMzQsGOj5a1VcOX+6aE0ZadK5/rq2IPddC7LRGZYiNoEW0wTIFlde2kHD19LX
         9H6MwHHJd68AlEAoXEy4LJ0qMjlwLvBOS7QfF7VXGs/DdMLS2efsbrZDvlMzufp+dgLA
         mW4LO8X82gvbUg5qoqHccKVN1Rct14p5jiGNeTC/o4LOkHoUJZO/EekkmLU/B/70Xdzc
         dH8wkInwruCo6Y0wozkrHsYUr8G6W3QtvzqzWwstdY8ulu6g6kVS3M+sApkds3CB2f3t
         FnRQyvshXAMGsJ19p7oi1hF27FesgCJieSl/fcsXXWVxMFBV11GQjDkwsw/N+xYNZybO
         P7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728578915; x=1729183715;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uMkEguiz0h1D9xvWykAjS9L82oJ/vMmRDZoz5fQuq4k=;
        b=jGaofqC3U6PwtmHKcTsBzgWFlE95e8aAq8x7gOvEK2nF1y+S9BVUR6fdnn9Xzs7I3J
         Xu1nnjmPS2LqsuGXNeI04vVKJ9cvAHSUBh1sv2JMaV/t1LdHy95fB5cN8M8BppB24nbF
         B3mSleYVLty5crRrDW4sBNnq+WZFAYLFttp3VDA5m0RVeYPD5qg1qv6tiLQ2i4ZwOtzi
         CISeZMfzsCK2+w/nheuZwo0x8/svu+FUzAmhxPeKjZfGBF+ilAfJk7VbF04F/0nNRTHJ
         wqIAD3paQRg6JSfAFx4RpE//XAdT5G4pECdC//HX4pyDpLENHNZt0uCw5RdZUgJnFgGZ
         s9Nw==
X-Gm-Message-State: AOJu0YzGUjGTIa+S4FgCbHg8cEE8Lki5wz6UmGdp4IwF5+WcQZTJM43n
	Efg2i5iNj0fCTrRSklgGAlrbCmC4UqDEKwOkAURWbxwb+a8FgwQWF4t/nXOEeqc3lVYpEYuspG6
	dyEiuhnZ7QQ4jJ+VIsMkQDCFrQpg=
X-Google-Smtp-Source: AGHT+IH79C+iipi8P1fpG0XCjReUbKhVgVHO6v6riNsV5VqUGDQnpNRMbdMy7pj99jtjlNYo/jHysmhQheqSQHhChco=
X-Received: by 2002:a05:6102:290f:b0:4a3:a6f6:57d5 with SMTP id
 ada2fe7eead31-4a448d78035mr8163389137.12.1728578915341; Thu, 10 Oct 2024
 09:48:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Oct 2024 11:48:34 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqttdkoqks.fsf@gitster.g>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
 <CAOLa=ZS+naxOzJUkLLOZk++WVZ2dt3eQq9VmW+G-5O1ZLgggUA@mail.gmail.com>
 <zmqyj3v2h3hswoujpz2er5luvjipjl3i4ts6xjdeb43wp42xf2@i5xee2lsmriz> <xmqqttdkoqks.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 11:48:34 -0500
Message-ID: <CAOLa=ZRRHYwe7=aJogL0=R8SHyPkHeC7C34R3mkR-gmzkRQ9JA@mail.gmail.com>
Subject: Re: [PATCH 1/3] clang-format: don't enforce the column limit
To: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000374aca0624222438"

--000000000000374aca0624222438
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Justin Tobler <jltobler@gmail.com> writes:
>
>> On 24/10/09 05:55AM, Karthik Nayak wrote:
>>> The current value for the column limit is set to 80. While this is as
>>> expected, we often prefer readability over this strict limit. This means
>>> it is common to find code which extends over 80 characters. So let's
>>> change the column limit to be 0 instead. This ensures that the formatter
>>> doesn't complain about code strictly not following the column limit.
>>
>> The column limit does lead to quite a few false positives. At the same
>> time though, in some ways having a tool point out all the instances it
>> occurs does make it easier to review if any should be addressed.
>>
>> If the goal is to have a CI job that we generally expect to pass, then
>> it makes sense to remove it. I don't feel super strongly either way.
> Is it possible for gatekeeper jobs to complain only on newly added
> violations?

The CI job is indeed only checking the newly added code. We do this
using 'git clang-format' which takes in the basecommit as a param. This
is in 'ci/run-style-check.sh'.

> Then it is fine to have a limit with a bit of slack,
> say like 96 columns (with 16-column readability slack).

This is a good idea. Let me add change this in the next version.

--000000000000374aca0624222438
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f85813f687231bf0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jSUJXQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVpPREFDRjFNOUdzVmdNeDFpVXg0a0MrQWQwZmFPZgpoUDhPMGQ4WDhw
dmVldGx5LzY5UDlKQ1BWbk44TmhPWE1TbDBTMjU1TlNFK0o0VWdIMkxNMitmSVdONk9XejFBCjBs
a1Z2cEdhVktjeXA0RzRFTFVndWdISHdrMFJnOXBDYVlaVSsvZElxRGdZYTg1NHBsNWpSYkpydW4z
QlJ2cmIKZHU3R3RPbGkwbkZJYWFDeEhtbEtwU1E0dHJQZENsSys4emsxNHdKVkRtY25Vc3c3NGx4
Z2VhNStjaDFVMEJJTwpwZEh0aWxHQnZoQkRNcFlUVUpPM1FXam5oV1BGQmR2THV1eXhKeFBWbmZr
c241T0ptdFR1cmc0M1M0eGhRVGFSCm90cDE1T1lGRkl5ajVWaFVFb1UrZ1lZSzJwSnZ1Z0JWRklN
UkJ0QjVjdFBuZUZDLzk3SmJYdFJER3ZHcWplRkMKR2J1citUdmVoTWpwbnMvbXlKdjdJUnVGZU9M
d3Q0Y2l5TnNYejJPK2xrOUJzT2s4K0FSdk84S2w5UEs0dXJLOApLZDZHUmlkRUlHaGlRb0R1Qm5r
ZHlTU2RvL3ZYaHljWGY1dm9zVXR3a3prQisxakRFb3B3WVN0NWFVbzBYcXZPCkxXOWFuM2RIVHVo
Ly92cnFSdDBBNUcwSWNQK0FPWmVZUVVrYkdPRT0KPUxmTlMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000374aca0624222438--
