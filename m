Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF741D0143
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201055; cv=none; b=CnxM+7+AlsdSeFHv6QVEehqCjXGglskJQ5/d1NBH/tWJIv73+JWC0nGXmUtnbzMUoFI4+Sy3RZSIxKDPjO4tcxhH3luXaakQl4KpohxT3xY6tohb8VqgM4NcTkrDXdjgUjHhm8l8r8imEluORRFkjTzWvRDyhITw9y3/9r11Kc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201055; c=relaxed/simple;
	bh=1oNfUpGPspMMksAgiT5A1tIOpuAnvlYWVhvc10e3qgo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNuglAnR1jiwQ9H2RlyMCXOqCQipmucfv5GoY5mYPHJWHOLILssL+1wz/3UJlPakBc+tO+J8EtaWckNCKvL3q8TNlh6gX3uxceksQI/xzIRo29a5QJ2n1Zp4xwmHmot33vzrKWkwod7Q2lUZjL14giou5QyvMsCYFGeiBee0vSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoCfMVno; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoCfMVno"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5edfe8c17c4so530009eaf.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732201053; x=1732805853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1oNfUpGPspMMksAgiT5A1tIOpuAnvlYWVhvc10e3qgo=;
        b=PoCfMVnoGakKXTGljbEQuIAzKot6PHU/LW5AD4MR67UoiY1Bjzuf3+r2n1J6xNamR4
         56OM21j0zkjX2ZqhsSqv6AHJhTUIdWBcRyuC6nTuIkuYF1P/84+k8Wu5MraD7F1hpjdC
         RZ92p1DFObO8fEz8If9BlHLy8X56foZScJVGCy+zSscDbcg5bjYxvFJ1fXGbcGVoi0dP
         4T7AgDYTU9FFidLsIjUgfltSBgGt4FSifeHYJT7ki/3K/WQo/TSHig2b59W9ucPh9TR9
         OXPPVxiOEygAb5Quk3Cn9x1dryAQ4kB0Y9QSALrrGD+rI6HL2i1m1Rqut7tfblXdFCPc
         ou1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732201053; x=1732805853;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oNfUpGPspMMksAgiT5A1tIOpuAnvlYWVhvc10e3qgo=;
        b=Af8kGk3b/NrOTdWocHHjfzPaHinpI059vkve/aS5+7f3Vy5dBHBao2dCddAb8Ke9vD
         8kP0Z/N8eZ/SEfoRA0+mUtdIBzByOlevCKwA1jEQBWRT7C210uRwvoWkexyCo205IoMj
         h5FOM3WpN4QvqwuC47tduV+ztAaNe0Rl856HDYQFqm/7g0VSwoQBJPZr08SeMDP4mi0S
         qcEHy2Oyv45/uhjyoLUo4ekEgHeSfOFhz4aN+0tyrthm203iPaIcny9ef96bBHYedg/E
         UePlYqqMPPbLdQawvtxp5AB0afsK7y5NBHga5lBBvwATziO9kcQ+q7P+2E24KzDb9Etd
         W0Zw==
X-Gm-Message-State: AOJu0YyjLjm5inE4UUhaaAm79nrx7p/Oe7xxzJv/STNqPf4gfanlpC1n
	Kl68uANRF3Zk1KZy/HwZK9wt7tdauejmwZWx/glYnJzUlv1jDqzv7fjbkLqRSkhYnULtRR1ZDMX
	qOnjJLMv913tBcL97T4KNDu3ijAPFjwfY
X-Gm-Gg: ASbGncuL1YteU+Gskd6dN0PhdEDln1GLAsz5yOGvmm764Pc8hhmBI2zd2t/wQurGpi1
	9b14Lod7SPQBApoytInEGH6tklEqrLjhwJWsohSX4zpWfoEuYDOf4DBzQ0TYJm8C/AA==
X-Google-Smtp-Source: AGHT+IHMDi/s0y34lHQbRokXa1yZGyqSfC/YXzpZUlhktDIXZBvw6186BoQfaRY3RTQeRbudqbRVVnEwGA9rt5XABNk=
X-Received: by 2002:a05:6358:714b:b0:1c2:fe94:abda with SMTP id
 e5c5f4694b2df-1ca6648313emr413804555d.5.1732201053251; Thu, 21 Nov 2024
 06:57:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Nov 2024 08:57:32 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD0RpTXCdeYPA44yiS1E-LsmSHVrGxNKaUFkvUqq+zNTZw@mail.gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-2-e2f607174efc@gmail.com>
 <CAP8UFD0RpTXCdeYPA44yiS1E-LsmSHVrGxNKaUFkvUqq+zNTZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 08:57:32 -0600
Message-ID: <CAOLa=ZRRohwY85wbhJcb0zJhWx5MKfPJqSXDdSkPR5br1CBeCQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] midx-write: pass down repository to static functions
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="000000000000762e6b06276d7c92"

--000000000000762e6b06276d7c92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Nov 19, 2024 at 5:36=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> In 'midx-write.c' there are a lot of static functions which use global
>> variables `the_repository` or `the_hash_algo`. In a follow up commit,
>> the repository variable will be added to `write_midx_context`, which
>> some of the functions can use. But for functions which do not have
>> access to this struct, pass down the required information from
>> non-static functions `write_midx_file` and `write_midx_file_only`.
>>
>> This ensures that the usage of global variables is limited to these
>> non-static functions, which will be cleaned up in a follow up commits.
>
> s/commits/commit/
>

Will fix.

> There are a few places in the patch where hash_to_hex() is replaced
> with hash_to_hex_algop(). However hash_to_hex() is not quite a static
> function and is not defined in 'midx-write.c'. So you might want to
> mention this additional change in the commit message.
>

While I think it is obvious, that might not be the case, so I'll add in
a line to explain why we swap those functions.

> Thanks.

--000000000000762e6b06276d7c92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1c9e7feac1e368c8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jL1Nsa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWU4Qy9zRjlTVUdWbnhaTkc5RjlMYThMY0RGaUVrMApJaE90eFlHOEpa
SEF0enNkcmhld2x4YkZrQzZIK2Y5cWxEVmY1b1d5L2Vremc5SnBWUFNPa2ZhMlZXa1R3OGVIClFj
dzhQRS9GYWFBOFh5NEVORkI3RlJFaXJjNXZxcE1LenNPL3dmb29jUmpxRjUvVGo1alk4V3lDOXM2
dWpSdjYKeDEwWkpzNVRRQ2dYOTEwOURLbkRLYXhhMlZSZkFBVml1aDhDd2xiRTE2ZTJYUzFXNjdO
WWZzUExTM29wMkZEZAp6VEtxTEN5eUtqOWRCaGsvNUNkQ1Z0TTFhdUdVQ256MmYyVzA4VGdDVWJp
M3Q5eW5TSzBwb2c4bFVrT045UG5vCitvS3NSNVA5dTNPZVQvL1Y1dGRpbFgvcS92cUNPbERYemhq
NkhDK1NodUxCdERyMkMyMFlrQUZrdHpiOHUraC8KQktzMFcyaXhqS29RUEluN00yMFRqYTA4Y0ow
d0Vxc3RlNk54ejE0L3BuV0oyajNqcGVaalJtcU1zUUpQcHkwZwpXRllKTy9FczdybndUcDE3amQ0
bENMOWZyZUcydGhzTGdXS3ozRjZNVUFoSUZ2dGRFTU1EcTRCVFFaQkIxeUJMClBNK3kyS0Zha1oy
VGJBNUNWa1Y0Ly84TGdKU1FjR1V1Qytxbzl0Zz0KPUdSUWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000762e6b06276d7c92--
