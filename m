Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865D482FF
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328349; cv=none; b=Qy3if6wGoxcDPFbGUYTzcr76B2fOLrJTJSsY1hgTnSWIPH+9PmwDKgftOiGj1IJGwVa/EFnYo5AWEJYiFjco2CQZlpAe5q/5LIRLKOuE0u7AQ0xlsAtgD49qJNrqz7MPk3oZAZF5a7+Ayf3/0hIDEkJbeuPL2S7ghPk4vfKU/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328349; c=relaxed/simple;
	bh=1JRSs/PSD2npfyXTV3ixquQ5ep1ClY2uhBXaeUzCG1c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A8+ErghUvDFshO+75cePfTGGQ9lzpPZRNCQ72RURP6AQjvRl8YKNOoIeL/tKROit5bSo7M6fTyoA3hE82wG0kkq0KSjebeEuc+vwuEPo+Yat9cUAchMstSlqh9SDcsMcPCrQM/hb1HIeL3Fp3poIKVikX7o6q/Lg11Ij2Abelh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N67o6xQl; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N67o6xQl"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-234b440afa7so5232965ad.0
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 20:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753328348; x=1753933148; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JRSs/PSD2npfyXTV3ixquQ5ep1ClY2uhBXaeUzCG1c=;
        b=N67o6xQlwTQMeNDPSz1GY0aUhPeGwKUks7YOtw9ZI+7FJZU2wDVVKvlH3+SMgT0EH+
         VbCyCXX/ieBmPU/GMGztq0GT+6QICS7HNzyonB7g2ngvWnOamRdNkcv+lIHSfIS1EcwL
         eeR/0rj8dPliKMLRuOxhtt15+Zr1TMeIXBvhUdAXqY7ouLPBLhjhkHjSPcAO5ZMwpWN9
         G9B5dYEUYEOf3H7HCq2KqTdi/lrdhSWhmOw3UCxqQL+XY8ihSmQQOrvH0Cl9B0QKGW1J
         ssjf8c1J30suc8QHmCb/T1k67AscX/S3e9aGLk8L5Io98gsbMtfwxMPryWXOC5YeKOsD
         5Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753328348; x=1753933148;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JRSs/PSD2npfyXTV3ixquQ5ep1ClY2uhBXaeUzCG1c=;
        b=UrYEb2BaLM5Nzn12Q2h5tXNIiImRtOGAQL2eZ18nSQqzuUKpXHYW7gYtIIiFb8kWP6
         1p+c9f6ug7XVATjOsKLFjl6nkHagoIhwiGRaJTz4a67SD2fowrnpNaYhqKjs4EMkdcA4
         eCQZAUjW1pGC0kO4m3k11lKQchb1dIF3bgowzJipkT/pUTs50Y6peLVlWndOvw+r95rI
         a/8EotAN2S0Wr1Vhtrt5FsA0y9roWonJoLPbpTp8p0CIBpaLM6BCJnieTfkGYCwIUH1j
         tCBhXqleshqv9K0Eo9fMtDkC9yHIqZV7lCpUT8rEATDcW6fzwMFloQGCTNVv8T1Nli0t
         7NLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWooQEVkMW2exANk/xacLTkdTG79Q85V4x5TSs6Obr0ySKRdqtkGyaT1Z/MP00gvxfCZdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKJLbfjXazCgEPSvcpLCz/y/QwYVfaLnz/om4YJ0+4oG4ASt+
	fqP7Hh1M0krskSvm9WcQW6jSQMGkzlYIwqkj0Yq0joinO7yhJ+D6y8nt
X-Gm-Gg: ASbGncsBfp7cegnOfH/CT+lybHtOm+f67r3qAyIrPtB3YASvCqIcO4xRIAv4lG2fNbx
	jZcLlVn4R2BHPuyZ2eAKkBFhu9RxKqql7NnvGFqcHyfNbeFRcm3O8MptB7Lo2QegizgnIpBDt/T
	lSt46uF85BEhzuCsg2XdNnsua74QIFmQKzT1z0kNgzm6IV0PS8UJyx3bXH94sokIOS6UH5lSeyH
	KNvfitVCIm0IO4XJJ2hzDEu0mALCY9rpI2/CYxt8JAoEkzNZhzUMlAWujL/XflPJTaHqsjukaiF
	nILgKoKqFVSmVPV3KsL6vmpIOzuh15Eik0lS/2kraaDgK90hLxjeUHtUaG0jAHI9ZApnNOo+Bnq
	DHNkNxVeL/zUzzeyQrAuY5nupKS0KguPYJTZiFqSl/YIj0n+k3KFcZcIYpeued2g8ira6XIMj3A
	PHFYKOPJE9LRPwyZahPzLDGb8=
X-Google-Smtp-Source: AGHT+IF5YBVdBz44iNl++uAa2jmgfjU6VZBDFqRCo2IUjco59OcJ1bMrFA0fjkpZ59uJ6OVcwZ909g==
X-Received: by 2002:a17:902:f688:b0:220:c164:6ee1 with SMTP id d9443c01a7336-23f981936cemr83996275ad.32.1753328347624;
        Wed, 23 Jul 2025 20:39:07 -0700 (PDT)
Received: from smtpclient.apple (awork062199.netvigator.com. [203.198.28.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e66390fffsm206454a91.34.2025.07.23.20.39.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 20:39:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <CAPig+cR7M1VL=9PQ1+xsj58=EPi0jR8oTdTnkGmMAD4gXeOnKw@mail.gmail.com>
Date: Thu, 24 Jul 2025 11:38:54 +0800
Cc: Junio C Hamano <gitster@pobox.com>,
 hi@arnes.space,
 git@vger.kernel.org,
 =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EE6292C-E03B-4E1B-B8D9-2352531034DF@gmail.com>
References: <87a54v8nmz.fsf@arnes.space>
 <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com> <xmqqqzy6omul.fsf@gitster.g>
 <23DF2497-D379-4EAD-9271-D01D7D8F3E8B@gmail.com>
 <CAPig+cR7M1VL=9PQ1+xsj58=EPi0jR8oTdTnkGmMAD4gXeOnKw@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> On Wed, Jul 23, 2025 at 9:56=E2=80=AFPM Lidong Yan =
<yldhome2d2@gmail.com> wrote:
>> Junio C Hamano <gitster@pobox.com> write:
>>> Lidong Yan <yldhome2d2@gmail.com> writes:
>>>> The `=E2=80=94ignore-matching-lines` options is introduced in =
296d4a94e72
>>>> (Micha=C5=82 K=C4=99pie=C5=84 2020-10-20 08:48:09 +0200 5803) Since =
the Git documentation
>>>=20
>>> WTH is that reference format?
>>=20
>> Sorry. I should use `git log --format=3D"%h (%s, %ad)" --date=3Dshort =
-n 1 296d4a`.
>=20
> Simpler: git log --format=3Dreference -n1 296d4a
>=20

Got it, thanks very much.
Lidong=
