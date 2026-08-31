Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C6470425
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191202; cv=none; b=His6Jx1PwgOFefMevkU8PkBr27EV1noAcxKrp1QEf779KaaSMK5HsIPGSn3tqY75eab+g3S7HRAVkT9dKmUkL1ZQzY7kAhs1TvCZX9Z6NKDDhHqMhfr/TWmkQ9lUByb6xWqibdF2KUAIRTCtKWUqHrjxby3Kvp5mDjOpLxpfYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191202; c=relaxed/simple;
	bh=VtnFVXabNvxIrouES7NSIK6VWjFfZJbCgTQjeAKYDTI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=scjxLZuoNJrPXlsFrcZUiF/9wivNWyfN7Alc17tnZVwQb9V/UdWsuaVliYE69OTIZ0UX4anQCWHrWKnSA995DcW6kklYh9vC+sxOeM3O8IZwzruTQC91ChJi6MEtbgItfSyHbSlwo2EefKnzYeXu0q4NA3x6uXmzfaGlEI5xGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIlk+Xuh; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIlk+Xuh"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c711b7f2aso3390146d50.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191200; x=1788796000; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mu1TvRGKvE06fi47HJR8qF2hsywregD1QnBHFgbi2fI=;
        b=bIlk+XuhVo6ZNMp5sQrcua9HDYCKZQsJ8taUcZWSNfO6iEGC4NjlW5RQOJGNpPiZBA
         VscJ56/uuh1XugTvIp/W1KbazwzdFu4Wn1v2CwKhXCjcgyJtTFP0Gy9OLU7wCZF1JvdF
         Vk3RvzzlTxYxBe3nPq4avXASK0w7PbH9q2JMajE708YtBI99nOW9C2dbzI9L4uzrXOCF
         uyYRR0e7tidVi+OAgyf05JzU6pmBI2F5lDVqCUQv6EbPCsVtHwuDzNzm0jNpvn14U5jQ
         r9YEhbvT802wOZHg/sgFPX9e0QAMTR6VCboXoUpQzEG6mzlmO0Ny51T+3yvkSebscxlF
         eUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191200; x=1788796000;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mu1TvRGKvE06fi47HJR8qF2hsywregD1QnBHFgbi2fI=;
        b=i82C0gIHQ6JmqfBkMRfZgat5vfJgktyhu4Mc48YcZBpS4tWgPiz0FCzPQ1S2G7uav/
         mmoR53nO/mialDh8uCISauqwhNQmRTthua1Y8exFpjldErCnXBB+X8Aqs57jqW6BnyeP
         JefIKb5xC8SxqbKFHcyf424IFPt5T0p5RoND5QXF9Xlcwrzrji34YPgiupKDPQ0859Io
         4zLx/S9/XuIypAr6uIq8l7MEy8iqY/jTah3SkzjFapJZxtJyLYgJWaNgGtPNXKGc+U4e
         kmSz+2kvUJMON24ytFLowbVsxVtUSK9W254UF9INPATaJKq+AwzTuRt4qVI/7BcseWmz
         mmTg==
X-Gm-Message-State: AFuF++ng23JtLlB/lDmod4U2uv3qaBRK3nDpf46luZP3TMlvRFb1g0fE
	WxATJvIdg/oB7RWDbzvvo52OjzJLDZeYGXRxPaDv8PpbT2XqOg+sxmIp
X-Gm-Gg: AYBFou1dpY9AC5WVqCaSk8xQ9FdzWudxhIfZACAw+0vxbAI0uPSLcrUv5xJQRNf9BTT
	euXTAksiUTH/13sX6nuzWZtHhCYgb6Q4IOcoGjAzmhsHD3kMhi3xKt2t37gc2KSpk/QUU6O7ycX
	4+R/9jxClehKbzmzLl6imm5sFmdG+mG373Rn7kHW8Ue71n02I2Ct+0Na+v77SmAtcXJM1mT/Rs/
	nrxpedg9EgHIBVBlDkXy+mRcxbUfoEr91zp4FocHg9mh87Kp+PejxDqFBhNtfYLXHcIdkydbhup
	2QCwzuAWK90kv35Zlit6zxlcxf/YpcjVH+HccWwv/DIgpynD267PxTzy5x7kKkJ8Yb4+6gfPtNa
	wuZkLJgIqJ0Hh+8RgDVvCKbnVTi9xyHXJlWW8g5ARsxs6q2JR6uTxIZ7M0ZaMAQ895yaIN0b8Nw
	zKrx7E1jY3GC50knZdkta7C+hp1jLCQ8aMxbeUGhvHp9Spv61FL1wRAz51RKkEa1bcuvwzNYRi8
	FL8M57ghaPNRvay7FGd3qa4rAyUP2FTNmcKKzK/EG419wk68Ll9PSd9/LiqTmbW5g5DxBu9Tzz7
	4V4iGuXn8DMIhMn0o31tzRn4STncY2qwC4zh4irun5RNuTlt
X-Received: by 2002:a53:e110:0:b0:666:b80a:6680 with SMTP id 956f58d0204a3-66f87477adamr484226d50.21.1788191200350;
        Mon, 31 Aug 2026 08:46:40 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:25e1:cea6:4059:91e4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ecf1f6fsm6246428d50.13.2026.08.31.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:46:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Mon, 31 Aug 2026 11:46:29 -0400
Message-Id: <40419516-56A6-4AA6-B0C9-4F15EA61480E@gmail.com>
References: <apVJCt4prIi2GgXp@pks.im>
Cc: git@vger.kernel.org, Olamide Caleb Bello <belkid98@gmail.com>,
 Todd Zullinger <tmz@pobox.com>, Yuchen Tian <cat@malon.dev>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <apVJCt4prIi2GgXp@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 31 ao=C3=BBt 2026 =C3=A0 11:31, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Sat, Aug 29, 2026 at 09:38:20AM -0400, D. Ben Knoble wrote:
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 241abd4332..8e0c25655f 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -130,7 +130,7 @@ static void xrmdir(const char *path)
>> static void avoid_racy(void)
>> {
>>    /*
>> -     * not use if we could usleep(10) if USE_NSEC is defined. The
>> +     * not use if we could usleep(10) if core.useNanosec is defined. The=

>=20
> Micronit: s/defined/enabled/
>=20
> Otherwise I'm happy with this patch. It looks a lot better now that we
> use less preprocessor directives. Thanks!
>=20
> Patrick

Thanks, queued locally. Will send out as v6 this evening (~5=E2=80=936h from=
 now) unless I hear differently from anyone. (That comment is hard to read t=
o begin with!)=
