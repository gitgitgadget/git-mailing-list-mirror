Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD702076C8
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916058; cv=none; b=Phoing30N4bVHsNa+QD1YurlQtNtczKPJW3hc/lvfIyNsDQnSZs/fU28F1TSqx+LYCrD1KBBvNhCPIK7HfgyBIaTZy1S3KRi+wEJlwhVHNCR42jEp5RQtK8lrCfRr6XeMPVpM1FgjI0SkcBW5JORM3XUDRdI/tt2oF1+mN4qPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916058; c=relaxed/simple;
	bh=E6Fp305VaEbD/WqX5tqPy/SxX4spXQkKPSYru0gEMgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiBS6AFCUztvU75mjkxIrm41vvhq7Z6Ki6x4a6EoLD7v0V4RJCjdvBWswDCRm4TDr5jASa6WoWNrZijsI2XSsqYjpAUwq7tWr7I/2gRi7H8HUtiewclWf8pgDcMSnQ2lerexRiF5igIo5oOJdPdqCTWv850H556d9Odf36vHA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gckQ3uAX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gckQ3uAX"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e3cdbc25a0so277857b3.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 10:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730916056; x=1731520856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6Fp305VaEbD/WqX5tqPy/SxX4spXQkKPSYru0gEMgE=;
        b=gckQ3uAXJxVdzOuluAT6MgqAIxMKv1GLYwhpY4PQ7mPpmkwcN3jyKZlzIUlAYdfZ3t
         sarX826oJD5Th6yfIblmLT/B1s5IRQJpJ8l6wIHECjeZ4dIPmRh1xHlD5FHFBbrUkjOd
         c5GSfFRC/KA2H/a10O57YGoVm8l94JnjaSIiDgE2Cj0hW6a0E9A3sPN9QRpt185OFvWF
         jVHHP3Qb22zfgoSHXfYgZeNaUfjmfnMNZcOIWkrGR14oFvpQaIKTtyXeytt+h4isGN4p
         o7vNA5CEHNw+1/xkHt0h5JyYP5UhnxsKkQIwEP/ldQ+dq9DQTW9Uj+egtH5a7HstenUE
         vlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916056; x=1731520856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6Fp305VaEbD/WqX5tqPy/SxX4spXQkKPSYru0gEMgE=;
        b=NLZI1hBxNVtj0ICgpP9Zf5bp74qxq5MhyUMTyxDdfn0qu63rQglvIRAno+8rwPFIoB
         Z5Z2R1sdULj8OXJMuL/yhImMbINeXp4th6FjCzrW3MRXekuUI4XuIsmTJ5+TWrtGxOU6
         hoDphsZ2cTQa0G00AbX7s6xeTuLgFJ+NAXuJzabaE2qOifMvXnZVhFxtM68J9nHXdXAj
         fQGSuwueLXGJzq3YktGUCT/RWRX3nWBz2M5GohqxBfdL7C8n8YdKiY7ZZc5GXJTZpe4U
         j9htMH9SW71nQ5/ZH8eVAPmCeeDZaeo8wZGdDKAvA155I/Pwi+HSKlyyqh7jH+gtWE/c
         77SA==
X-Forwarded-Encrypted: i=1; AJvYcCXvKJOSwVbkNH7kTIpjv0l6HR/307KmRQypcLQb843dY0d+kzdM8LfQT7MmCpoO5bjETeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/OZInEZSoNRwH+8P3rtc2UAfgXbQRLuZ+tXJGER+cZrqS43U
	8OQ8Zzq0ZShH+Z5Xkxff0spemq4U+xgb9KoobzioOd82pCKr28e9kNgY9DCDeXCih8M4lGmb7up
	3L1Dfx0XzF7aeuK+wrtxKuYDr4dM=
X-Google-Smtp-Source: AGHT+IG+/qRIWqx4ZSDGKaYMyf4B9riukTjTmGEZEAZv5Dir0qxOhi+OcQga4vfnKrhyu2H9vLJaBfdpgiiiTMTDZQU=
X-Received: by 2002:a81:d805:0:b0:6ea:7b00:4aa5 with SMTP id
 00721157ae682-6ea7b004ecemr130776087b3.33.1730916056121; Wed, 06 Nov 2024
 10:00:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241028203457.19715-1-eric.peijian@gmail.com> <20241028203457.19715-2-eric.peijian@gmail.com>
 <CAP8UFD0Yk1Twv9DMOYwO4R+7P0YHj1CgK8xN=2YdE8sdi4ukow@mail.gmail.com> <xmqqo72tqig8.fsf@gitster.g>
In-Reply-To: <xmqqo72tqig8.fsf@gitster.g>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Wed, 6 Nov 2024 13:00:45 -0500
Message-ID: <CAN2LT1CvM2oWD3Eni_f5agpzgycAjzaN5gPVU_9_KG9GxwP8dQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] fetch-pack: refactor packet writing
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, calvinwan@google.com, 
	jonathantanmy@google.com, chriscool@tuxfamily.org, karthik.188@gmail.com, 
	toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > It looks like other patches in the series, like patch 4/6, have
> > similar issues. Otherwise the other patches in the series look good to
> > me.
>
> Thanks for a review.

Thank you, sir. Yes, I noticed that. I will make sure my IDE respects
the .editorconfig and revise them in v6.
