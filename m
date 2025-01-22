Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2EA215175
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737566923; cv=none; b=IaHYx1nlO43z1stl8bRhZGJ83IlyqRUi8BGSpQ69b6J2dybJkAs3R+dP3DbnPeUkMuXFFkmPbUnjb4on0xF2yE1D5tf/rl68I29SaKdLsatTai0iODdFygvOekFTfm/FLZuc2fzcx9GfOlDIPlSsCWN/LfRvo3z9jk+24HFXVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737566923; c=relaxed/simple;
	bh=fH/vRWRC3cspdJQe7Eor9J75BHHXiRkKm2LUyMogJOY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhJoODJtoAkzgcDjc/Qxbpn4GL3cJh9cNZCYq32zCnzj93UvEb7++5M4SDM9CBhUX4q2Z7l5AXvFlEc4q6sYjHRIuIumKMmfp56yU8m7+aowmZsd3Dz/0xHNwvUj5es/znW8+bDAtkhSORihLoRuToxtL8TnuV+eJAuDZKQ6z5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFg6ieYc; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFg6ieYc"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5187aa2c97dso6332e0c.2
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 09:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737566921; x=1738171721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsmZzVXJyX1Q2E8+tkcUzeOqTc8RVof5ZhSzUHFShZA=;
        b=eFg6ieYcOIdQYemvoQrj5Pkm33ICouMXmYFI9dKHmDbzFIsCv4lCd3nacLBBVu1TUw
         AO0613abPzGrV33gMtFokoRje96zJgkMrGennsKcpOGf6NHLj+hW3hAXD2GjF/ZMtn9E
         17yLlxN/ZDVN3FRAFj9F0kKUzsFQCNPrs2cVohDjSwlHIZOIvjlQRQzltMkvFgOW7TK4
         GrzzvNZ806WP8OpS/RYhohCZmvWjmmICWwe1NyEXcwxARyVuFfnDMI+jxItYvoazalL5
         WQjzXBGeXtzyrUOpn7C2LsXY6kyrk4B+iF0yVOy+SIrj+Vf5P56PPj9D2/j9vQ/MuuXY
         Ivaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737566921; x=1738171721;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsmZzVXJyX1Q2E8+tkcUzeOqTc8RVof5ZhSzUHFShZA=;
        b=rEYJoSWJjIIjxBo0AsDlpxwq80O4f1D5RnBwYJMUjYiHuFHcdWm88EG6EsZvzj6SIj
         TDheDONPwdjojCuhFPFHHJ7PG/SmKGgUDqRQTcgPUMb/fzJXyD+Gp4rHY9W0pZEQAhbp
         rt4xl+zF05T9tV4QsusuUqZwkOIjsRVf2GzAfJXTiJvsnEmLxu1akPbipgp+mrYEnFdv
         Gpq4P6WWSc1BXyIXNxm+31qW5/UbSDAnlLJH4RRlHPp0zeDW8B7Zkqf2tLnL6dwkoolo
         WXsXeEVsvAgYEWZBYDjVeqhQbKHByfwhAdEq22HGqQzI21lVHsa10SDlKjmQYsKV+6de
         gv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVML8/icScKEq33Zb+XxM/O04dB4Z+6y+ZKS1qNIcNFf/FWu0cBToZ8tAixDn/Q6kf0rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1lATpKL4vT0ai9PxuXVGTflyl57t2bLxAV9kyHm0fhkTf851
	fbsSvmW3W6ZLZhSPBuhk1QC5xP8xALILc3rKXIjkkmUKKs5LpTlqFcdcIcunHSNrAG0Ex9qXFnU
	//vIhGAVchT0vR+kYN9PQt4L97Vg=
X-Gm-Gg: ASbGncsKvEf3eFDQ737Z11R/klmtovxq2W3NWIXSvTJnQW6Eck2aJ0jFPs265SiCJo0
	o+8N3eK8XrPikexMVctd8V2nSTtVEeDukG7yeQoA31Mg3pKVgBfy0
X-Google-Smtp-Source: AGHT+IEBGQju2zBqzqhXAnHnqhvMa9h6Oe1VzeKSkWjE0rUqlL95BI5cg7tbm9zKrTs1+F6vc2CF3xlnmhPU3dyC92E=
X-Received: by 2002:a05:6122:4807:b0:51d:eb9b:bf3 with SMTP id
 71dfb90a1353d-51deb9b3286mr10780790e0c.8.1737566920905; Wed, 22 Jan 2025
 09:28:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jan 2025 09:28:40 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZSyEg8G9g1B78VRymgfk9eo=d3KkhD=+S14_BSqaAO2Mg@mail.gmail.com>
References: <xmqqwmetgdgm.fsf@gitster.g> <CAOLa=ZSyEg8G9g1B78VRymgfk9eo=d3KkhD=+S14_BSqaAO2Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Jan 2025 09:28:40 -0800
X-Gm-Features: AWEUYZn-Ul8ZJHteSsAvfHu3v1zatCaEAeMxNFWlrPkfFgEUmp-yORzeXFXJAWY
Message-ID: <CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="0000000000001850fc062c4ed3c2"

--0000000000001850fc062c4ed3c2
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * kn/reflog-migration-fix (2025-01-15) 1 commit
>>   (merged to 'next' on 2025-01-16 at ae8f9ce9a0)
>>  + reftable: write correct max_update_index to header
>>  (this branch is used by kn/reflog-migration-fix-followup.)
>>
>>  "git refs migrate" for migrating reflog data was broken.
>>
>>  Will merge to 'master'.
>>  cf. <Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net>
>>  source: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
>
> This seems to be breaking on 'next'. I tested it locally with
>
>   GIT_TEST_DEFAULT_REF_FORMAT=reftable meson test -v --test-args='-i' t1400-update-ref
>
> my local tests were made on files backend, and it didn't trigger on the
> CI either for some reason (I shall investigate that soon). But dscho
> (CC'd) reported that macos builds for reftable were failing [1] for his
> branch and I could bisect it to this.
>
> I'm yet to understand why this fails and also why the CI didn't notify
> of the issue. But that is something I shall do next. For now we need to
> remove it from next.
>
> [1]: https://github.com/dscho/git/actions/runs/12906424058/job/35987723223

This is reproducible when the leak sanitizier is enabled and tested
against reftable:

So setting up meson with:
  CC=clang meson setup --reconfigure -Db_sanitize=address,undefined build
and running the test in the build folder with:
  GIT_TEST_DEFAULT_REF_FORMAT=reftable meson test -v
--test-args='-ixd' t1400-update-ref

reproduces the issue. I haven't found the root cause yet, but will
mostly call it a day and get back to this tomorrow.

Karthik

--0000000000001850fc062c4ed3c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3c9be3f74e5a86c7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lUktzWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVlTREFDWG85M0p1L1ZZNm5EVnN3VUc5MmhDYW9HTgpNQTZxN1NBNWxD
UzFYUWRibjVsejRMTFN4Vm9rTXlxS1VLcUh3TjJRNmNEdjR0RmxicDVxSmF0YWttbE5sNDRJCkRN
RlVVNjQ0Vm9LazZoZFdpS3p5eG1MQ3ZzblU4ck9zNHVJRE5TQWpPWS9wVWtnOW5sN1hLS1dyK25t
S1pmWXUKL0tWWWRsRGxtWGFJd3VXL2h6K1R4ME84RGs1VXNSTktndmZ5UzU2TWtrditjQTRoVTJv
NXpyb0NkS0pLRmdheQo0RHM5VUs0eCtpNnFOMkNUUy8ya0k3Q0V6NXZTQVd1NE9lU0NIMXo5Tnhi
c2YwZVNYNmV5NDFVTFhPMzcrUnBtCktsNmJmSU9RM0hzQjgvSVRiSVFvdzhUdmRQVlR6M1RIZXlV
QTRUNkxTeHdkOXoxWTl5bkQ3U3dtNTFDbmJVaWgKQWhIV3lKRXdBUnE5YXU2TGdVdUZicmtkSi9Y
OFdaY2x4T0EyWFdXVkdNSUd0WHdaSlZOQjh1YW5XYjY5eWtEUApPOU1lSC9IV2JONVBIVXIvZlo5
YXZnQnRObjRaeDlvRTR3UzVhNU04ZlhtSGxkcFEzWTdTYmJpc3dVRnlqdWFlCnZFSitKSVZLTnR6
Y3ZCNGlaNi9OeWY4bVRqTlV1TmtiQ2VlYVdKUT0KPUk5QUMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001850fc062c4ed3c2--
