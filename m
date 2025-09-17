Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBF3064A2
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122685; cv=none; b=ppKs92JO5jQVAK97BGzBWabQMfh8UQEtQbtX8MIfZclM2kQ8SffWOPtv/5/lvHsIupNeFEW5zNyBleNJ39yXYfg8fMCSu7T/Hd8m9c2vTeHLvExe/cvTH/l/gYN3ibVbMZTjE907+5HFoV+QhQ9jFViCDdbqEJkoEoTywO9UHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122685; c=relaxed/simple;
	bh=BBEQ+9D7IAc+gxkH5kniTSHLoSj4V7l2LxlvzKPbmC4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUqmlT3aKco4emQp57JcL4m/ooAmrIg/RvBNAxse50EyMy0QSM12fhcqctzv8lC9CwGFn0ggnGLMkU0U92kpcQSUZJReTbgv7FcBrmlW4XWrrIT0BQ+EgxMMC1GQINjl9LPv28ubjjFoibbnCntScJtqmGZdUV8XKAffFxitk7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAId8rMM; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAId8rMM"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8e32821b5bcso227511241.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758122682; x=1758727482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBEQ+9D7IAc+gxkH5kniTSHLoSj4V7l2LxlvzKPbmC4=;
        b=BAId8rMM6+PPQ7o8PQrP/xiMOR/kiZ89sYQjKIHe+dUsU6S+0dQy8cpAbTtSbRR6gT
         j+c+16xHsuK2aXqC64rkNn5t0LRGyitvC5pF3QuojeYgLxBA8/C3PZGxFs+/FK9jM4of
         +W/9gF71kGEXP9QxiwIbwYgluWBbrb8HsGG/euXkw7RK8P+2dAsLbh/ON6rSSbLwo5Kb
         d2QoDqRl5KEcgCcJ8S4FX8erPZ86leZGt7B8fb+AHenYPBT318Wmp5YoW0EVrm3tB1Kx
         w1Z2O+GrFLjsUURhjwLPHLdaAYpwYB7FMNK9YIJQfYMKL6K7+CxJd6Mj/hgS350F5cAh
         atuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122682; x=1758727482;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBEQ+9D7IAc+gxkH5kniTSHLoSj4V7l2LxlvzKPbmC4=;
        b=IGKU79TSUzdgt1FQCp8IrCKxXvLAZlSc52KGGuTZWIPWA033XT7rJ0VcVxA9d+BzSR
         nmzZT8VRje3mA85qvfFxq8V/5s+dczBTP94JAcMVYHzJMmFAEBTlss2cltqzyNiFNcgp
         SwXs1Kh3XyDJ1d70VYb+dZV1SOXHIAm5JC1Lua6bGQZgoJjXstQ4WkeualGfGKlJzjws
         O0saUGYxQqpfK+aGgrynqYElwUH/WH1uonqfFLs2qa4+01w9oF1lD4j63PUKmDAKh6ti
         33N1pQKogo/ZkauAPMQaoiulmJ7fONjEgq1BGUqOwLjqYzYkRpYp5+M43HmD/l3Se+aP
         BuoA==
X-Gm-Message-State: AOJu0YzVKa23MOKAplNv3btRGUaU0y5j/VUJeGj1R70VbHMaVTFzCADw
	2dZXoMYzSMoC77mliqTsEoPzhTVOgNSPx/i18nTOS1mO6AnLs4PrAULzsmnrp+3YTIuC+pabBaS
	p7/1mkC7ImZNcqhJT8mFy1RPXfaRfzQQ=
X-Gm-Gg: ASbGncs9G9jrG/w1Prq6ZWWb2HJ/OOVD0SdtO6se0q3VX7iXqZ0FFUFMPSlZjBIO4l2
	kPk1aiIxfJo58UE0PS4e77nWTk5Y640yyl2yLDWqw1pXHnxPs6aYzR2TQ0ESFj6LPHWS290cDg6
	El/HbO2gR5OeQkJR/8k+AYWQbN3g7L6QdfQ9ZiR9sBU4KOxdGSelpJnaIDz/oYLvfVEbcrbeflx
	tD4C2K/baoHuomvVEq7iTbqIQqq3b+zKYVlyPaijw==
X-Google-Smtp-Source: AGHT+IFaSrE5JgLoCCRRRw5bQlC2Cltc3y55mDXujYGqol3BcLh88C1PQ9AgGBZ0I6K/qL1xL3tEJDFzYVigCc4ON6M=
X-Received: by 2002:a05:6102:4404:b0:522:2b10:7d07 with SMTP id
 ada2fe7eead31-56d6c536f8dmr739854137.30.1758122682197; Wed, 17 Sep 2025
 08:24:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 11:24:40 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Sep 2025 11:24:40 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <874it1noh2.fsf@iotcl.com>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <xmqqh5x2m5d3.fsf@gitster.g> <CAOLa=ZRvAMq7MNm6=dBneAXdDe6OjQ=NqYA9-Vd7E+nvDWGH0w@mail.gmail.com>
 <874it1noh2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Sep 2025 11:24:40 -0400
X-Gm-Features: AS18NWDhlkTJq1Uxg4afzrpdHThFseMdR9CnWAa2J9gEJnnRrfbJV8wwL-4EuWE
Message-ID: <CAOLa=ZSBpSyU0V08OBrr-QPrZPsYnO1bTZewESY=C7Jy4NTcWQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
To: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000f1d23b063f00d5e3"

--000000000000f1d23b063f00d5e3
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I did respond to Justin, I think there were a few small nits around
>> grammar in the commit messages and a question around error reporting.
>>
>> I have applied the grammar fixes locally and don't think they warrant a
>> re-roll. Regarding the error reporting. I think it is good the way it
>> is.
>>
>> So I would say this is good as is and I will refrain for sending in
>> a new version, unless there is some other concern.
>
> I also gave it a round of review, and I agree it's good to go.
>

Thanks, appreciate the review!

> I've noticed another issue though, at the moment it's possible to create
> a ref like `refs/heads/foo.Lock`. I can image this gives issue when the
> remote has `refs/heads/foo` and `refs/heads/foo.Lock` and you pull those
> in on a case-insensitive FS. Unfortunately I wasn't able to verify this.
> But anyhow, I don't think that any reason to hold back on this current
> patch series. I approve.

We don't fetch locks from remote. The locking mechanism is simply a
construct used to update files locally in race-free manner. Locking a
file ensures no other concurrent writes can happen.

In-short when you fetch references, the prepare stage of the reference
transaction will create the necessary lock files. This locks in the
updates with guarantee that no other process can update/create the refs.
The commit phase simply removes the lock files post updating the refs.

>
> -- Toon

--000000000000f1d23b063f00d5e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dac7aefb1d0354e3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSzByWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejlTQy80eWJWUVZXa2FZZ3J0Z0d1Z0JPU0lFOGtiQQp1NkZhU3JpTFpj
TDhzc0R4STZCTXMyVEhTbHRSeERPKzY2WnJFM1VzeUt5L1grYkhnc1RIdXZqanhGSHdsNWtDClg2
QXpKUVVRL09Ma0kzQWlUYUNjK0R6R3h3VVdFYVdmR0cvZkpvelZGZFMwZTQ5MWtTT0NoZGpwSDVK
ZkVkQ2YKYisxVHR3MjF1R2tra0xVZk9wWHdNa2lKazhmMHFiYStJWWl2V1lqOWJITGxmRURGYnJC
eGZEYnRGeEIwelljRwoxMFlnb2phQ2dOd2FYYldCb3NlRU4yeEo3eExNTG1adWxOQkZORlA4Rkph
QnQ5MThBSzRvOTYxbUhmV0pNZTlOCnVTaWl3WDgrK2l3M1ZqRmI0QnFUbkw0NGwzVG9rcTFSYytN
UjU1Rk5jV0x6M1lMTkwwNlgzUjFHTWxXYXZoS2wKdVdzanJkSVF4VlFGazZjKzhYQnZVMmlKUTlj
TDBpOFRJdnppRWdHakZwMTdja0NjUGtVeHdCNlFkd3VXMkIzYgpaM0psZXVkOUVaMzdCd1VUYys2
bDNYalUwTDRZcGpDN3N1YTRHY1FQTzBXQkJMNHhVOCszZm8xWDczY0Nud0RWCmVUNW03OStmS0t4
RE9BOUxFYlZnNlRLendMQzdoNjZoODRlMlhITT0KPXBrNVUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f1d23b063f00d5e3--
