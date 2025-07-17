Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C87BA27
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728516; cv=none; b=NqrbFRwDbglC8yIsi1hOnm9pfsgirPk06eQiRrzZafxkrVM25PstimKkNxpwNL+pYrtRfhhrqZ3JM7NFe5XhXBbhYNZmoW5+9gmhNMgXf64McJKIXOlkBizpbIVpP4TIwX+69umMQWnTOTr6e75DP1MsxuoyvGCp8fPVcr1OL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728516; c=relaxed/simple;
	bh=R5HaNU1/bUb8NKFeQdtO1RTvk+50vC/aG3Dcjt7FGFo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Wg8oV1VWyYAGxhWQ8BWLrBBM5Spjw6Tol0sMLuU7IJjM8b3UyoM7LC2Y2rnSBDFVcIZR2AUgoBcu5fx3Fh/b2XzYpIUUKMl0dDxPEexzJpMtiOQJfxIGDsdLE1hj+sDDW/9tYpRWE23VGqLPdtVxK0lQuLiWs5QKPsgkNNwo0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2RpcVFu; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2RpcVFu"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-23dc5bcf49eso6441835ad.2
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 22:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752728514; x=1753333314; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt6xCYTMOQIwFfYS14q69PnfgB+hKvf6DdYF6G3UZRs=;
        b=N2RpcVFucMzHWfuNxuSC4Y6KC8PaF9gev8Y+2yHJv6qaAgTCUdSvZTaXIRhliLj9Bc
         y517qSiaICML8lZoAeDTSLOi/hqBU4cEAC4/+dEgMVve09Y6VC6DFctGZ22zIpUQ54Z4
         D0IPK4e8jFozIuJ7Wz+WPBoMrxA4/qx5CRcnuW825pz7LdKqMZ9YgmhtuXlegl02aOIb
         mDBpqThrz/y+2v3gnBtEu+jpCW0T39LLnt8ur/UtP8uMffrj/GBwTZhLLQ65pgyoeHWj
         DAT9ozV6MJ2DgxAbWF9842/7NvJILAPe8k45lDtJBH8tT5G7VA/udiU4aZztBsZIpYTT
         d1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752728514; x=1753333314;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jt6xCYTMOQIwFfYS14q69PnfgB+hKvf6DdYF6G3UZRs=;
        b=NiajKlR23qMMi28xBv7dna8MlQZkk0ybLFMwixvLW5Et9FVrm1h30Bpi+XK1ZLYTnB
         o+ROzglIz5uJh8WzFGchcN6nGHu9eKOpjLc15M4VDHAfQL2yUfHE6es+li/bJ8PWvL19
         /U0olVrnxBboiL04gEIbSZGbAmxiEoV9zcY6hLF6duPOWPpPlZuoPOtl6Z7RXcxvThF2
         NnR+RTFMRzzUz+U1pO1yY4DesXar1cAfSkjur5E6Cmv56TO2LS7eW3JXGynFzIna8moP
         lrcLJKhFfKxwr7I47JRBW45cMg+vm48Vuh3JCSD19TismHmN7xcqRelRso6hMYF1hx7T
         GpFw==
X-Forwarded-Encrypted: i=1; AJvYcCWmUpKWh5nuRYLB2aInWwWogtPQ0QhEU4uZ8ac9Hxfaah9P3SlDFa15ZgNNriz1C8ibqKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIay5RA1oIr6HWGyvoqPPD2cqgGJQi4zk3yttaKelKwvZrn5JO
	q8HSoOZYrI5dGfFqVONWmuXonO5lhnDYIBrsXg2U4fetN271eksk61QzQththpW96sk=
X-Gm-Gg: ASbGncvjNp2C6z093fYYlm1rkta/PujZzeAboMQY3KAJAhwexXbYp1s1eMpQZso5y9z
	vC4T8cs+r90ptDuhH/up7jWtc41n+8qJVnZ+jrbu+MGmKuffr3M2nLgaMw+jdLEyzlrstHEq7nj
	hGWIpJfz6ZxWNMPwR2pQBA+4vtOGJcJ0vNQHRkj21Gb4IMX6bfiGe1e899Rpa68pRppzqy6CFsv
	iOWkTkHdx80W8JGir6ny8EiI8aMZtP+cNuVjRKXlngVGUhACZU3moYjy8ciuKRBnpzF9UNJTp4F
	DTh+4KitKH1mtM1x2QyoE78U7ehQv0v583gTlK0jrZKp0imHwIJnt1nh7DWnBtfEBkKJynzZz8m
	V2IqsM8Yl7dC2arCHPqWlg7WwwwOkyChR
X-Google-Smtp-Source: AGHT+IEmxzo3q+f0v/CDwMbP3PKfGdw7oQvolKD4zzToT29LFAoXpP9IdOr4EK9m2j0cgUzPQQbJBw==
X-Received: by 2002:a17:903:3c2c:b0:234:c8f6:1b17 with SMTP id d9443c01a7336-23e3035f29bmr28304695ad.38.1752728514201;
        Wed, 16 Jul 2025 22:01:54 -0700 (PDT)
Received: from smtpclient.apple ([188.253.126.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4289274sm133940735ad.43.2025.07.16.22.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jul 2025 22:01:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] pull: add pull.autoStash config option
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqms938mbq.fsf@gitster.g>
Date: Thu, 17 Jul 2025 13:01:42 +0800
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 git@vger.kernel.org,
 j6t@kdbg.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <174669ED-8E02-49BB-BD61-277DBCA4D890@gmail.com>
References: <xmqq5xfsdv3w.fsf@gitster.g>
 <20250717030732.75106-1-yldhome2d2@gmail.com>
 <CAPig+cTQ017qGK_Qx04+R_0rCXEOirW+oLEjeaDoCFJiQbnsGw@mail.gmail.com>
 <78DFE806-5DAC-4A90-893B-77F32E393E07@gmail.com> <xmqqms938mbq.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> write:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>>>> +pull.autoStash::
>>>> +       When true, Git will automatically perform a `git stash` =
before the
>>>> +       operation and then restore the local changes with `git =
stash pop`
>>>> +       after the merge or rebase is complete. This means that you =
can run
>>>=20
>>> I wonder if you meant "pull" instead of "merge or rebase".
>>=20
>> Yes, I think I should also say that pull.autoStash only works if we =
set pull.rebase.
>=20
> Is that wise, though?  When pull.rebase is false, shouldn't =
pull.autostash
> pass --autostash to underlying "git merge" instead?

Here set pull.rebase means either set pull.rebase to true or false. And
my patch will autostash if pull.rebase =3D false.=20

> I've written about the interaction among three commands and
> autostash in another message several hours ago, so I won't repeat
> it.
>=20
> https://lore.kernel.org/git/xmqq5xfsdv3w.fsf@gitster.g/

Yeah. Though I considered that when pull.rebase =3D false, checking
merge.autoStash instead of rebase.autoStashmight confuse users
who rely on setting rebase.autoStash for their merge operations.=
