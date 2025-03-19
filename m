Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD91D7E41
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401359; cv=none; b=T9Iqx517w2Fs1dCLYCholjuCKH97TiKHy672r+dfkL1YCYrSGYk7aVmAy+dRWg2E5vZxmtoBao92OGKzbYpo+2kqlPJLN2J6qN/OLDKRtZnNdsyPwXnOcKdbeJDFqMOR92Esyf1sMKHuBlLw61ETTmCTNV/zHAKiDCsIRhYXce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401359; c=relaxed/simple;
	bh=LasKJZxSq5nsFd39r6pZIyPogYQIKszTV412PagdSoQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwG8t4QmC/kd7+sx75MIDfGoNtaXuSjunyT3dkUpSaor/Ns9vOvgTpE2dopC+4qWRPrwzxfKUBvkVpul8rLm1aa+b3jEq7fqngLH2akjwxj/htkzHrGCThhZctFkm0+deGPH/IFtVmO6wz2kZY/FgNBT56xdxeJ/cY6SeC9pGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxYIu5dE; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxYIu5dE"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so835797241.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742401357; x=1743006157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4LaEO3yjMmUKhm684ST0mPNbUWzVzThoe4zVqkrcfI=;
        b=BxYIu5dEFIh5L+RTLjxHZjEpUqLxRvxD8GPXFnzCL+TFCuz0OzoLIm3kYgtJgzywxA
         7P3EfhE499somcU0DE3gbAALGmzUqA74JBCyyU8oFx4Y+i20W3HrUdXwPuuKFU675QQq
         pbQuFfw7weYiN16+IC8Du9yUcWB2Eq4m5sOe+XlITEBECW0tbNCGd9z3BUkqAK1k1qbp
         DxwbrPg/pUP1dzaD0iUArwuiETPML5tC95G0GXqaHqlxG6jOQzLkObHmQ/19MVdg/fYp
         NkKFEf8NQOCcIzTOKKFw110W0Ak7P2hprHTnW7ZdYqzXgZ6Fs+vUd0OdR1KPkR6+HUwo
         pkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401357; x=1743006157;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4LaEO3yjMmUKhm684ST0mPNbUWzVzThoe4zVqkrcfI=;
        b=KgGZvq7e6SdhdwYzd/H347QGWacLKz6oIMul6IK+5n0eqU8+hqkNnh5ZYYElVsll19
         LmOyUB1wzFrSkayZxRHLFzH0mr31wbb9r9rrBSEsqJJ8sIypnr1ui5p2PAWCZjwJL7I1
         iXkOqi4dTorfpmoZa+wAAeY75yNcWqyeY4ynEqtmniS3u5Wf3lJBgC/txejBcDbYY5Tv
         JXyvQUSQCK/1LiFJ5ehjhK7ZkLMqQFFO5632YhssDLS4BjNYYxOetJGY+R0lRpfJJb32
         WIkC+ZAx9YJnc/suc4xzXuH79EC4kp2ZyCR9w4kvewmqk8lQs74cElBUxpe9RP39LjAK
         K9hw==
X-Gm-Message-State: AOJu0Yw7hWNBA6rFEdGq3a+APTzzmdNI0QA/3a9MwZ99+jEMMBnmCgYy
	mdsRBmdMnZUwUf0SsV3QzNqjb7HVZvdcCRHjnRh2mtHjOS2701B6ZldCYrpY0qUQYM/5xMLfidy
	w7BYFi/piH/eEaDacdjNKm/ATH+0=
X-Gm-Gg: ASbGncthQR0VEEdmGV60M4iFFzA4yaqV7L3sZ6HscIuOMxD0KCSmT+vzmfqa6i720qh
	om43+pzl/YyyTwP/zKxRdZJRVPaJyp4RJF7RZkWPnfCxIxJnUzoYAxJqHVENsVIA23n614injaB
	68n36Gm3m7dsNl2tb8DCFV1EQa80MSOwcfQD7vwIUyNgqlaQCpyNAgisZwYBtL
X-Google-Smtp-Source: AGHT+IGQXXMFRaEpcH+F0YVWyvmBLis3dM588I/h681jehyWA2HOOXj4NvNEDjXxeJBsND+3JUZEv3jsRBEcodixahA=
X-Received: by 2002:a05:6122:2491:b0:51f:a02b:45d4 with SMTP id
 71dfb90a1353d-52595de9339mr123763e0c.1.1742401357134; Wed, 19 Mar 2025
 09:22:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Mar 2025 12:22:35 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z9qNNq0p10YJCZYo@pks.im>
References: <xmqqv7sbfra0.fsf@gitster.g> <20250314184130.GA578421@coredump.intra.peff.net>
 <xmqqy0x7cg9h.fsf@gitster.g> <xmqqmsdi49h8.fsf_-_@gitster.g>
 <CAOLa=ZRODjYfDXQ8m+hDosV7RBGDWeehzSvsR-+-HCmbS+tAcQ@mail.gmail.com>
 <xmqqiko613a0.fsf@gitster.g> <Z9qNNq0p10YJCZYo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Mar 2025 12:22:35 -0400
X-Gm-Features: AQ5f1Jqdgcr11uSrxmuKdLT2OY2NongRw6luddlIxcY2hru4XcUmjnU_MrWyqgU
Message-ID: <CAOLa=ZQHZEh=vzxUqBLmVDn3LWFrch0BtRAYMssLO9hL9a5sJg@mail.gmail.com>
Subject: Re: [PATCH] install meson for Documentation job
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000f2ec280630b46d9f"

--000000000000f2ec280630b46d9f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Mar 18, 2025 at 01:40:07PM -0700, Junio C Hamano wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > Weird. From the looks of
>> > https://github.com/git/git/actions/runs/13867157977/job/38808418127, it
>> > seems like the '$distro' variable in 'ci/install-dependencies.sh' is not
>> > being correctly initialized. We can see this in the logs of the CI:
>> >
>> >   CI setup via install-dependencies.sh
>> >     + set -e
>> >     + export TERM=dumb
>> >     + export MAKEFLAGS=
>> >     + test true = true
>> >     + CI_TYPE=github-actions
>> >     + CI_BRANCH=refs/heads/seen
>> >     + CI_COMMIT=d5389e37e21d864f40f4167280db799ffe8983c2
>> >     + echo Linux
>> >     + tr A-Z a-z
>> >     + CI_OS_NAME=linux
>> >     + test macos != linux
>> >     + CI_REPO_SLUG=git/git
>> >     + CI_JOB_ID=13867157977
>> >     + CC=gcc
>> >     + DONT_SKIP_TAGS=t
>> >     + cache_dir=/home/runner/none
>> >     + GIT_TEST_OPTS=--github-workflow-markup
>> >     + JOBS=10
>> >     + echo
>> >     + tr : -
>> >     + distro=
>> >     ...
>>
>> Nice digging.
>
> Thanks all for discovering and debugging this, I somehow missed this
> thread and haven't been able to keep up with the mailing list for the
> last couple days.
>
> I see 4451a164e5a (install meson for Documentation job, 2025-03-14) has
> been merged, but as far as I understand we also have to take Karthik's
> patch to fix installing dependencies? In case I'm correct, do you plan
> to send this as a proper patch, Karthik?
>

I had a patch locally and after your mail, I did test it out on GitHub
[1]. Will send it here, this should fix the issue and replace
4451a164e5a.

[1]: https://github.com/git/git/actions/runs/13944424140/job/39028258830?pr=1927

> Patrick

--000000000000f2ec280630b46d9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1fe7afc449ccf4f1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mYTcwa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHduQy85SHhKTFo5clRTY29WSmlmN0hFS25xOUlUeAp5VUZ0bC8xT3Zj
MlVHZklWQ2VkNlFWWXIxSi9rS0xuQTVJSmJiNEJ3dUxqSzlMRDJvZFVSSHAzT2V0UWc2SEFhCmIv
ZnBRa3ZmSFd2ZVBGL09SeSt4dEtrY0twY1YzQ2lPbFMvN2VCS2JDSlVjOElvdzEzREFQRDRIUzhK
amN5ZnAKNk1KUXNReFdIQlFXNS8wY2xSV3pBNmJSTjE4VldLYXNBc21sV0Z6Ym8reFZwdDYxL3hM
UXUxMXlaK0JoVUJYawo4RktUK2FGM0w1bzdWb0hTK04wNEdzbjV1M2xkMjdaVjRldDA4ZEswNi8w
bitjUUFyV0Q4ZkYrTllmTG9IZ0luCm13TGJEZWsyMU8zUWMwcFFIbTlweHg4MTg1SlVJbEk2bSs4
d1hTT1ZnKzIwZ2NBemU1QitzbmcwUnVlb1hqQzcKeUlBOEtkYTJPY09yK21mOWp3VUR4THRkZ3Bq
MDU2ejJCSnRXZTFZTzJKSmRPQTVLaElqcWRtSWlRSm1ha0phWQpTYW5Dc3I3MTBISG9tU3pHR09H
UGdYMGgyWHJKU2tKeHdtNFA4dUN5dFQ0bXBxMWNkWWpTNTl4L0IxeGtKVUJxCkUzenlENm5WQUNm
dS9qTG9DSXo5SDM0b0xsOWt5aFhZcEkvNTNhYz0KPU5Cc3oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f2ec280630b46d9f--
