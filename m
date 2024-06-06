Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3751862A3
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668131; cv=none; b=oEfDyL+HyRUx+orY80QCWVMuEkqa9+RPp8tZTy7xHQKZAaw+cico7uDEB7IpcA6z66AFRzH8YEcw6IgFiJSljPEpBTFAQxeE/xHG/WGJBhkVqCv9pYtU9D0MEgmLAV3yLvpfguKTrYbKfm9j9Uwq8IASqzUEuOUutjP97pN63js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668131; c=relaxed/simple;
	bh=a+g++QTIxLL5ZQo8sjGzAeaH/EK2p765jeyZ+GxYl7I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ejsF+R7H00LgXp6c8Pdn0Y8qTS+JKdz2+w4GTQ1OQs0ww48YHOgn44aHY7bd8M+xBSS8xTvlQ25Yft5XTGlY/NdcUE0Qk8dngWTYEx/yUkXYrox6nfuLkNSuaM1GA2rOSd5Os7Sz53zlx9Q043MrXsDrAboztrt9WlJ33X3pVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYwgQj07; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYwgQj07"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-250d5bc7793so904338fac.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717668129; x=1718272929; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+g++QTIxLL5ZQo8sjGzAeaH/EK2p765jeyZ+GxYl7I=;
        b=DYwgQj07GkJEvRTremjCvONg2nZ20pXedcTuvFRO01buL1s/KPvNFc0e50bDIUZSLU
         JVG1xRHY9skHOdYgseykKwOimbwNi4YZ/yJyhf1DprDDh1U10LkX9QtZQGO4Ze0zmBIX
         Cq4DiV6b6vKj/nuY34cPEuRwut5Io0NDS6dBprZK5EdghhryRPHG6Hocn63dWgrgZ92A
         muhRQ9CZVCDBHmbKr4XDYrcasbsphpbut427v4ylsQrkg8GstG7nD7f0o0y2EXfOCgwV
         WiHQfCKq/rOZAQHOrD4Xj9DxDUoGX11n0kAczqsNhGezKNOLodORYvZYoih6i6P7M1lc
         sM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668129; x=1718272929;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+g++QTIxLL5ZQo8sjGzAeaH/EK2p765jeyZ+GxYl7I=;
        b=V8aINCAgvcKM4brhrQCZfzCZoh7wyNdJHC5VwGwEUg8ojeQyTsGDMlVH9Asx46lHQH
         xfOykyB3tx+H3s8F8j9rxdoDxgTFxut58HeBr7DsxutsG3+ad8G+5RFasxyAkqfYEu8t
         9oPfaIQKyXtVlXYt0igFau/Y6hwo1xNHtFmNHSzA/YQBca4aoqqjHsXN80lEC5Iipl+p
         P/Pssd86mAeT2nBQQK3rpnijPTzNCydr0wqdzpq5f9OtBzVj6V153KqbbKD8a+xTlNUT
         qqmsExJOkRVc7MXBAgaRYZ1N4e1QzxYooQNpQ9/wjhPSIZrSzqCQONrCvwGHX1eEs6GV
         y0qw==
X-Forwarded-Encrypted: i=1; AJvYcCVFaHYJBZqv5HexvGCL6ZDF3jK/FRU8AmOSM9Oyh9ftLJ0VL+dGyp2497qGptBM5+/s3ruJlja/Zslr0w3ZPwF3ve2P
X-Gm-Message-State: AOJu0Yz6JjX28RqaXGKeLkO5nefQ5PU4FLPQ9oem0UP95xdBXqBY51tU
	Zc/ZSEgrv1I0uHa3AblWgnyp41XZVyw6rIzGER0n4fZcIVyTJHt7qRgQf4a0e8dnrC5Db9pPlj0
	WqBwFZXnXo1ZG8A+gB3qjmzFiodA=
X-Google-Smtp-Source: AGHT+IElIBiLLEGFDlr89t1U9KSXmZVk71GRlw+PkDI3bKcSFZqyB4uWFZRlWefAJna9PJAd5DkQl5zziSv3vhUK+7U=
X-Received: by 2002:a05:6870:889d:b0:22a:57da:6fec with SMTP id
 586e51a60fabf-254404bf430mr1110017fac.16.1717668128647; Thu, 06 Jun 2024
 03:02:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 06:02:08 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <17a8f532752e005601b1cff5690a4dae16096b8b.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im> <17a8f532752e005601b1cff5690a4dae16096b8b.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Jun 2024 06:02:08 -0400
Message-ID: <CAOLa=ZQqGoVtG2uHRxf284H3JhYq09Dxy12Fj6UmiGyAjXwe=Q@mail.gmail.com>
Subject: Re: [PATCH 03/29] notes-utils: free note trees when releasing copied notes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a68686061a35c68c"

--000000000000a68686061a35c68c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> While we clear most of the members of `struct notet_rewrite_cfg` in
> `finish_copy_notes_for_rewrite()`, we do not clear the notes tree. Fix
> this to plug this memory leak.
>

Nit: s/notet_rewrite_cfg/notes_rewrite_cfg

The commit itself looks good.

--000000000000a68686061a35c68c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: baad19cf90dafaf8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aaGlSNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMy82Qy85ZjdYNFJXZWtDK2VRT1JteFl0OFpGZ3FFaAo1TjVnaXJSWTBH
NXNXQ2NMNkgwb1ZSeG41TnBYd2RlT1cvelFhRTN4NDhObzhUT0JpUzVwWkpZcUh2QXJzQnFJCkox
dTBidko5VzEzbzd4WXJEem9LYW84K1ZUK2krQzJ1dmprYVFVb1B4Y3hxamxBbG0zcGZpQ3doV0xx
NmhuazEKd0tZeng4NUM1SjB1QjN0WVdRaTJUaHRNanFsQ1BBS01WWVBMcWh0d0krc1hJNkdNUUkz
MjF5NHFJT3J2YTUycwpsUXpqaVpVMlNGdktlcklxdUlRZWZmejNVVWcrRTRGTVUrRHM1MVVlbzlV
djRuT3RNTy83NGRPVzJGVzZmeS9ICnNIMTFja2QxS2JnT20xckRiT2FROE04d2hQY25INkJiRlEx
WGYwMGNNYmtjakZCZkgwaDl3V2dNMXJSRGx3cE8KdFVsM1VxM0hoQXVObDZjMnNrR3pETXJpYTRK
ODh4TmV5UnAvVmJVZ2N4ZXJDMUFZdnZBREJJMDdaUEk0dk9PegpkU1AzYkQyR2FKVklrZlFPZWRU
c3ZKYmNQc2RvY29MVVpXcitnVk4rNGdaZ3hxREhSS3NPSktxZ2dyT29qWWphClBDU0hlSzdTWWNt
QWxNQXJtWVZWTTdZM2RaQ0JKbGwwTUNLRDhsTT0KPVNpc24KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a68686061a35c68c--
