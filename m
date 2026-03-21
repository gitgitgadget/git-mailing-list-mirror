Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A31D8E01
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774065937; cv=none; b=o+uY/Y1DyVJUmMWfS0rRSwDgsIrhoP6BWN7M5xR1KFriO1ZC76SXTGWRuC/tRatwMGJzrkCj3DSroSuzRZoQBinhArj9Xtzsd/5Ce6bP09PZamvtO4jMbndM379fWEtol9VxUSZd5LELe6TVIFiJScaZtq/cWNDUj2vhWgVg8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774065937; c=relaxed/simple;
	bh=mWvmNLswQEIPmkA2FkvI++ayYX2wxHjqNwBQXrgCXgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7QK8t+azxBXqVZz+yYH4ckq8Gy/oGy/e4Bw1+FXGixikNNaTml1R6CAJmLHA1A77OFdIRJM7qex0FKrBXFdxFIKmOhVvwx3XNm2WqhTOhk8pfpTAqeUXm5F2WmVCJImK5VKXOTwsA2zgshJp9zV6QnjmzSkkr9tid78CUfBhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrWvZlTu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrWvZlTu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aecab39ad2so2469065ad.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 21:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774065936; x=1774670736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=448D6pavBB0M+jLd8a60MPDtWHOu7k6kjyLKi/CaHnc=;
        b=YrWvZlTu8KQTO9dvVVto+6GlzfyjDSz9QMW4ZBbWCTMecyqHDyR+027Ia3PT2hbEom
         OH3NO4LSP42lZfFTNW7YLyAhDXbP0LR61CE/nENcWYFx1OGzXoXCmrSpk7yQtmNFw7Wn
         QHbmmyzpq2V3cBuvZafJ2xy5Y8dPSqHocu/c5PSnuGCrWsPrqOaPoU1/JJRdyYszlV1u
         qOD9v/cM4ZKcYJrxS3u3T8jAkrHOMhYMi5CWniRE8Zz8J3ZNEqSIx7T9W7way5TP6PDr
         7bxHOU+vZQ5xci0Q4jDDKvfCOb61HDLYaZAJwijULjb43cB+7CcYaeDRcBoJjEfuXQZU
         ETtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774065936; x=1774670736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=448D6pavBB0M+jLd8a60MPDtWHOu7k6kjyLKi/CaHnc=;
        b=Wi3efaAxxnWThbUM1Jp4/NuqSqVwtdxHIk3LmfIcjZbUs7AaYbAUMn9ueQslI/+iK8
         6fwY2VCFqdhe8z6AUfkfGMeaCnl9OUGVNAWq/lbK0pBH0LxpZe5VybYOYXABTSaAZiTY
         29ebOsdJf5BE9muzLm/QmWMTPn6a6Qw+rvgv1Dm5YzBEvJmj8RXB5WR2a6OxhgceLi5S
         KyHv9l9MF1hEiSG7gkqmztzoGH0P5CsCCutvRDidQSlZEnthxEdCSQqh8l6znRcTGhAy
         vuwpW+mzlU9D2lUB8r0tzVZSWPfCiHEudUoXFyv6SOZ92Q2spdAjQM9qoDGZniNzm0mF
         LXcw==
X-Forwarded-Encrypted: i=1; AJvYcCUUq27RuhnQVmGsJU1nhMb3jR5l8yTXZCBqFFcc1aRgiw8Q4UVxaBVcfJ4+pzWoRZ2N+F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0cr18OqJIoriFyuIKQBT2p82dQEDy+xSnH9Te5mHb37JW/ZI
	Tz1dFZoK8H1oZbwLO4E9s8brfut/1YYgq6Ldqsoo/qUjh0LQ6EkeE5iQl/8dYcv5
X-Gm-Gg: ATEYQzz6gFaNuWQI9fRHtsogV6kKIEazcx6XN+Qesc65Qxtbh9xVCrFDKTUwyLA13/7
	h8obVkBTfAQJs5EkGan+j5LZ0Sbbf9S+/Kca0jKktzjHdbteYnPX0mi/HzYjanpnVrIurfntSW7
	fJ32sZ/ONi6WwB1nllwcVqUJpfLrTrXl7pDirBJ+2p6jU31kU14J96Rf04kbVrsJsLWvKb+VYq2
	LQMjKg1snDn4NSr2Jt5aqMxtsmYMBMbxmBAtpylRHZ4H3a6DnSsRlQRrzhtVjWLJ3UQTNjfmVMq
	uDFvSmkP6r0DTVaJiV0vKgjBsT9ByCj8a16elWxyx7300wUTiQN/tSDedKlU0YpZ1d1mwADLUIv
	nQC5d0HXGjItPWvQ0FU97o4Y3TPVUSJ+Eboaqvjurpl9LsauzpUurnYHorRKInlvbH7PWhR12Az
	RjbsKvmt+3K6dyAAHvjvvrtvgfPftiMRgicH+bqYD7o8ULy6hSKM1hQZ5tjExMZtJq9RxEEa+bJ
	MIg1rOKzsA=
X-Received: by 2002:a17:903:1a0c:b0:2ae:3f3f:67c4 with SMTP id d9443c01a7336-2b0825d6f24mr33937565ad.0.1774065936007;
        Fri, 20 Mar 2026 21:05:36 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836556f6sm51634525ad.49.2026.03.20.21.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 21:05:35 -0700 (PDT)
Message-ID: <448b07eb-b274-4111-bd55-4ad25ffb94c3@gmail.com>
Date: Sat, 21 Mar 2026 12:05:30 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] path-walk: fix NULL pointer dereference in error message
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Yuvraj Singh Chauhan <ysinghcin@gmail.com>, git@vger.kernel.org,
 christian.couder@gmail.com, stolee@gmail.com
References: <20260320114556.3151040-1-ysinghcin@gmail.com>
 <eca1a469-2e15-4466-ae58-978ffc23c177@gmail.com>
 <9d0746d8-2194-4a13-812b-9b46d04c189a@gmail.com> <xmqqpl4ye6ll.fsf@gitster.g>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqpl4ye6ll.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/26 01:47, Junio C Hamano wrote:

> For that, you'd need to remove the block in question and duplicate
> the message generation, perhaps like so, to allow the message
> properly localized.
> 
> But that is way outside the scope of the patch that was posted,
> which was a surgical fix for a reference to an incorrect pointer, I
> would have to say.

Thank you for pointing that out, but I believe I already mentioned that 
this is not what the patch is intended to address, and I did not suggest 
making that change.

Yuchen

