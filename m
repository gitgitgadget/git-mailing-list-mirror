Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799D3D6D
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003651; cv=none; b=egL0e16Et6TzYMbkj8fMMg4ZtwtSyU36kBc82cgmJ+AcYMfdtr8P35sc8rITkiMQc7znr9Llzpq82w3laSo5gOYQMFc1p9sU1BaiYi06uHeBWCxw0KIYyqY/kVRNDD3dcineV21Wt6w2l1zka6lvzDZ5Nrr2eA4q1fXlQewApts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003651; c=relaxed/simple;
	bh=PPkXcvSRmiQ7DTx+jAPNmKck2seMUNywC6V+IakakLA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=U6yqArZ35FnsmjzvVx2ANVHHCEo1urmzri6NtdXVdzjUs/NUUQAsFtUvWDdu4bbR56I1tsvj//rcZtnpHUUKuXIuwL6UuduwNcPwSGoZhyCmjTsDsf0ipEvf6hI9A1C/H9DLV1jRp8Grp+bu+VZG3urQBEpd18aqRMYQkPCUq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/3mn8pW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/3mn8pW"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70e4b1acf41so53033827b3.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 19:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749003649; x=1749608449; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8Ezvqx11elXGx67xYv2+OPQGmzA5NpQn9xJBiPo67o=;
        b=C/3mn8pWeHiPQPqaDunF690wyyYlAToDP5K59EoKGA8iYBPdr0QpH7rHE+ibcPN174
         /Q36Sp8XjzUkFnSzzNxX9exFEjwefLZH/8l5mxKSn2wr73Bn34kfk0xVzbuovE2fX7Cb
         7d3Tf3BAVTzi97wrmZMzOUGKkQRsgLBby+aImk4qRU0W6U2O6g9/18LvQeOt1o3q1HmX
         fT+uURC5rUoxIgt9uu7rDD4nnTIy8FkU3no8QujMvDoV47Iqw+nbmogCFk3jzqdl01oi
         j3LnrDSn8m3l14kYQBUot6K5aHVIMu+oYlA7HaIHNHYVU7u4ObHaQD+PHlA1XJDUIahI
         tXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749003649; x=1749608449;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t8Ezvqx11elXGx67xYv2+OPQGmzA5NpQn9xJBiPo67o=;
        b=hEm5tzpJf/Mk1IPGrfa4AFICdZ7AbnnAm6YHf6nZo9GLcGn70B7YTXyth/LNbbdbwd
         9rbo0sT75qudnkxnEjRVAyci0XuChi3dg6Zd04RA1tLPUjbZ86fwmynl8B9N7Ye2HovR
         D0c0Y6RL7GFNJrt2Wwb12RDw/jMacFhbFFxC9HN7w2hMZki+jDkqd4I1rHB8Oy3MeYdW
         hqPjfOmcY3AX/+9T49wufSw9fRsf6Wla7gfkmKMz0M0OLg6LG3fJQEBHL3wLywWJKZ7H
         rA7+AsEjzXzuJfMQE4X+OOw73IcDEWb/Rn0Ukh8m2qvfK8S/6Kqy0cHVcCGUvlYfK2+J
         38mg==
X-Forwarded-Encrypted: i=1; AJvYcCWTMKPQh6udbvSRbYmDN2Zfr0uhjAmb/VskCMGILcAWDgi0B2mOLY6fAz71sU6bCI14MW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9p5FbXuMS8J8j/Bn2Eupl2zHRPtW/bs+ey8rk6FzkBVh4hutW
	2ovVRx8IvqT1ec2s4nDQ1xj/XBDtwaW4OBlVK91SSa7z+57wsQgNez/UKZ5MhmJP
X-Gm-Gg: ASbGnctS42sPrQsE3btLMxtbCYo1EYU0jEJ36d+25YpjUMZPzQIc6ic5X6V1RNkaQvg
	114Y7Pwr7Uhc29H5hgwviNPNh8yEmdLMBTpKYjjq1yhItOda1c+95QXrt0Ry0vQrDXFTaawgb0B
	vaxyNnI8l5MyHBzVtnhI6x1fKzZ0J1LyKx27nu6zu2okvw00uLYMhC/7aIUD+SDkQ34Wb4uYAna
	lxhibE3MmeMEOrkz6fVOh9oo/E6huY1AcOvyFq2FnsUtODRya0DZzN6BxI6xbcgTiFamEGOF1Qx
	RpWnC4xuJMBWBQ82TnruZQFMp/AKjoQuPXkufcP5u5T7bFrpNUKzVi8kCuJ6GWSb/KoxkM15BKK
	GfC5Z
X-Google-Smtp-Source: AGHT+IE4S4c1N/0NMjGz8zxtwm7nyb8gGaVqNQC/TEZ7uS5dH8WHjKPZ0CxNV3f9TcS6UlMyA1mrpA==
X-Received: by 2002:a05:690c:ece:b0:710:c8bf:9929 with SMTP id 00721157ae682-710da018651mr14284377b3.34.1749003649055;
        Tue, 03 Jun 2025 19:20:49 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a6:1600:9ca7:9478:f3c6:e1eb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8ad003d6sm27913037b3.103.2025.06.03.19.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 19:20:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [GSOC PATCH] environment: move access to "core.sparsecheckout" into repo_settings
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <CAE7as+Y0hzkPUC-q7dd-eSJVi0H_nwzQL1AGZJnKMyYcrX1dLw@mail.gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 christian.couder@gmail.com, shyamthakkar001@gmail.com
Date: Tue, 3 Jun 2025 22:20:38 -0400
Message-Id: <4F074544-4E25-472D-A42C-C50A1E1CAC69@gmail.com>
References: <CAE7as+Y0hzkPUC-q7dd-eSJVi0H_nwzQL1AGZJnKMyYcrX1dLw@mail.gmail.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 3 juin 2025 =C3=A0 12:21, Ayush Chandekar <ayu.chandekar@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF
>> The config is called "core.sparseCheckout", so why is the variable
>> called `core_apply_sparse_checkout`? `core_sparse_checkout` I would've
>> understood, but where does "apply" come from? Also, for brevity I think
>> we could just call it `settings.sparse_checkout`.
> Yes, I had this thought as well that adding "apply" doesn't make a lot of s=
ense.
> But I thought since the global variable has this name for a long time, the=
re
> must have been some reason. I can change the name if the "apply" doesn't h=
old
> any value.

Perhaps "git log -S core_apply_sparse_checkout config.c" or similar will rev=
eal a reason? Or point us at a patch series that has some discussion?

>=20
>>> +{
>>> +     return repo->settings.core_apply_sparse_checkout;
>>> +}
>>> +
>>> +void repo_settings_set_apply_sparse_checkout(struct repository *repo, i=
nt value)
>>> +{
>>> +     repo->settings.core_apply_sparse_checkout =3D value;
>>> +}
>> Getters and setters only really help in the case where they actually
>> provide a benefit. These don't though, so it's dubious whether we should
>> have them.

My thoughts exactly; see below.

>> Also, shouldn't these functions call `prepare_repo_settings()`?
>> Otherwise we cannot guarantee that those settings have already been
>> parsed at all. And for the setter it could happen that the settings get
>> overwritten by the next caller of `prepare_repo_settings()`.
>=20
> Oh, yeah, you're right. So, if we use `prepare_repo_settings()` in
> them, wouldn't
> it be better to use getter and setter functions? Otherwise, I'd have to ca=
ll
> `prepare_repo_settings()` everywhere I'm using the setting.

Aren=E2=80=99t most of the consumers builtins? And from a recent look, don=E2=
=80=99t they (all?) initialize the repo settings? I agree it is relatively p=
ainful to require developers to make sure that prepare_repo_settings has bee=
n called on each (new) code path that reads this variable, but OTOH I would e=
xpect that to be a straightforward audit during this change and then (see fo=
llowing) relatively easy to catch going forward. Is already a code conventio=
n that reading things in repo->settings depends on having prepared them?=
