Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2219D8A6
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338814; cv=none; b=DQNLs7Xuh2YvTVP5dTGOySW8seIrQlfkeJii8UrenaQGXJpxRvwomZIOksc9Bz13unx+x6QJWDj0/WfemUuLdNVOjhhGjdddg8W0YuDRUI+C7ZmjAaHdBSUsqJF7kEGa7S4MLYvSGSaX+9Sc4QyzJO1pDLHE6myhGyQ8V5oN1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338814; c=relaxed/simple;
	bh=zh98w8rYIqk1CAhkqdPzOn029wzZsz9x4BBoBlcMAEo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Rs1i39aaKWrLE4a7aMu3UeUeCriFiXMMTQm0CMpD0olUxe3uDTGSFy8//dih7wS6ztonPY67zdmsKlDUma8OytkNT6tUxRpAi74rRz3sYQF7VuFiTadcquPBzVe3a70tUCNi6XFcRF7pqWfh5TpyljHBeZlTmmmRt754mqLfhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvhxAESU; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvhxAESU"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-260f863108fso2663892fac.1
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722338811; x=1722943611; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zh98w8rYIqk1CAhkqdPzOn029wzZsz9x4BBoBlcMAEo=;
        b=hvhxAESUqkTjm9xW2T0u+21Y+KN/GqRofile+PGZGyFc8HvAFc62TIC2PgSI4rvpqA
         TkRqUumfXRbSV858SUjXvrb0ZV5VKL9tt9iqOcdKuVtt2eeOCNX0dAfP0sP7z4+bGC+5
         5oZ5aZ73T2Ih4VEtN7XrTAinXRSKOwXj2RuFdMzEV7dthB0/8d3FCCUheirBRubrY52V
         jiKeH6s60jMDvIBsnSJNaSYh5WzcomlNLh4X4FhPOsSdDiE4qhmBEfgxEFXfKkk75DjK
         m+98haDgIagiCaP7Aefr2HMkgeFM6s+JXFlh0zt2ZchEetqDaKVyfnXQtF6EzY/NzP3C
         8Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722338811; x=1722943611;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zh98w8rYIqk1CAhkqdPzOn029wzZsz9x4BBoBlcMAEo=;
        b=YpjXZZMmnHfTTn+NCSkJ3xm91cyM40DI4MkEpCZkiag5pVrXLRqtcJ+kx38ZoufhUp
         wZFZckdTSh3KqHkREzI9w0B5FRdHC4u0ynr+TBW2wO1rp6Etd3oc9OsfjREoUkj168UW
         9RmOqTJXpdAp88FHq0FqmTz8qzWre+OEAqhCshbdbSYNWqYt91uPXa8oa67Rxwtkb9/l
         LnfQ9lOghxGQ5ULlpAk35Aqr0k3QwQOxa01bNpS+oYVlv+1YgcL+1vh9k9VkKv61xYVh
         bQSNev0rvsyXvUYEaBLOKn2f9XZ/+lRS1A8frZzXjl2JCYXG2Az5F6a8T+DS8VBuCbDX
         Go+A==
X-Forwarded-Encrypted: i=1; AJvYcCVPoNfjdySVV490Acl1NE8uGuSUX6udr4aRryihu5CXUNvHjc/PYSRRzkWRhQo6iJHxAr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CtVTT+Cm8s5h13QBPdRO2vQaaWJ2FMZLeYlllW70xTM4oQZJ
	corkbEECYTOg7HRhzcmTmSf1WHa4EdsSjeMZ8ngNmr0u3h2CJYlYl3sIVJ8NHrmrOMkQ6ZcVai9
	UubSQO79JF3Fo/3iXvcNSWrtf8iLBnQ==
X-Google-Smtp-Source: AGHT+IHck8GbVH5EHh7OEl8qEGorEYJNJKEEbxQ7izfLxpx5NoCfFZtSrkMxCy/CbktKgDVV9lh8hTLbQB2R9Eu34bA=
X-Received: by 2002:a05:6871:58a0:b0:250:171d:5c74 with SMTP id
 586e51a60fabf-267d4d5f684mr14255452fac.26.1722338811634; Tue, 30 Jul 2024
 04:26:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jul 2024 07:26:50 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1722316795.git.ps@pks.im>
References: <cover.1722316795.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 07:26:50 -0400
Message-ID: <CAOLa=ZR+2FV-pdk2nZ1vR5dUx3G2Ze8=18CUCn8r_JUXfvR6fQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] refs: stop using `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000d12b8061e75418b"

--0000000000000d12b8061e75418b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series removes use of `the_repository` in the refs subsystem
> and drops the `USE_THE_REPOSITORY_VARIABLE` macro define from those
> files.
>

So the idea is to slowly cleanup usages of `the_repository` and the
`USE_THE_REPOSITORY_VARIABLE` macro acts as a check for this. I think
the changes look great. I even ran clang-format on this series and apart
from line wrap suggestions, there were no issues.

Thanks for this.

[snip]

--0000000000000d12b8061e75418b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3b42b41a6977b2b9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hb3pma1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1V5REFDaFJyREFFdnZoUzNVUjRFeG1sYlJ5czArdgpSaWltTkJqY0pp
VGZna3FVbjMwQ1hqUzhFeGs3eldaa2FRcUFPdGxxN3lXYUM3U2tUNDBiSzZkN3BUeklQNXFECjI1
MUxlVHJ5SVVsUmY3VWRUcDh5K0RqajZvZVlFREhBZHhLci85TjZPcXhWQmRVUzNXZ095aHdjU3ZM
dXZNQkoKVHAxZjQ0UnorMy9uei9pOWxhTldCaGlFSzlGdGFkWmhBKy9pNFdZZmk3OVIyYUpScU9C
YVhEeEQrakJpbS9FOApHS045bFpKZWlwQmJrRzZWTGR4NTNaNGRDVFpvNmpoeTRTTWk5SE5aSG05
dHJhb1pRWjd5YklOUXNtVUNmeXFUCnVoUTdxby8xMVU3cE5maTJ4eGl2ZVhNRzYxUXl6VTRnbVdQ
bldyTENiUjBKdG5yN0RJdUNtZUx6RjdwdEJnbk8KR2RUL3JEVTNUUHBBK1ZxdlNCMVVCKzRibnk0
a3lzVmlnT29jTEplNUVoczRPZ0tUY2MrT1ZJRWVVS2hmN3F4TQpuS1ZWTUNodVFpSWRsK25NTGlL
aDE0SmxuajFxRXUzaitpZ2dHZEVTVzRSMHc5V2lXRkpKeEN5WTY4TEZtRzNXClpIeThEalhLYXVs
S1FKaDVONjlVOUNRa2dubURBZ3JDMC9iVm9NUT0KPWQwZWMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d12b8061e75418b--
