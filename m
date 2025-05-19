Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BDD27B4EF
	for <git@vger.kernel.org>; Mon, 19 May 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664470; cv=none; b=VC0rCWKiii/VHAM/5u8T7BW7F/uBy5AGgILW/Vx6JPjdA3iGrNCuc2MlADFzftIhES6MRJrzrMgLkiWKTgB1gReTMdoVMetAon5D8ZVYL2ky3DHlU3iv4XBCZ8s+M5yFUaVaVSkoTwIBxcJOZW0mNPDryQRL3piQ9e9soVYcVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664470; c=relaxed/simple;
	bh=o9IUhXre6tW0MoPjt4njFeeOaSEea9A67DdU5AzkSLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6H2W7p3/LYDVSvXJHhf5xmKSwv4RqApZfgk/nLVHjyw40PgHpsKlS64ZxDCzb8UbmL4wO1cH6ZGhtxjVRGuCIQDeokj0q2neeKF+Y52Ovxn27WUHY/xY+ARum0FTJqpqiwkbgBToMExGflE10QypMm0x+4F9qeBDEmYjhQAxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I19dAU2K; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I19dAU2K"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a365a68057so1942583f8f.0
        for <git@vger.kernel.org>; Mon, 19 May 2025 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664467; x=1748269267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nb4X7H5zyXRo91PhJuEYBtU8NH7pp8Kg2DCtVoQ0YLU=;
        b=I19dAU2KMywzgMlO+iL+ywSoG7YVcFelRXx3eX5J3X4TO4f58zoJMxnuZErvVs7KJf
         8S3/P8lobTlOD9BwDFvLqDlVG7F+g5REfIgLyLPAHmATN0RgKbuFsq8K9weptNexU75L
         v1RdajA3cXNFAz/VGAezoU+E9Qj047unXCNyMw0AAs1y/ihj9yQWNev35zSTB2E3PGhy
         0e62H2VBTdw4vlvUQDCiDm/NRX9kkGZG5UJct8GXMS0736QLm3KkHicxpzDgZkifMcYF
         pKjAMmjsRwZ20Wf3E4rAk1fZRfGSUgaW7HQsZqkz0TejtrM5NDkrV+phe+4gzOsdfn8F
         IbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664467; x=1748269267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nb4X7H5zyXRo91PhJuEYBtU8NH7pp8Kg2DCtVoQ0YLU=;
        b=E0ksMR0/w1HUzC7ICPCMYERoKAs4gwoaJfjDKdQar/DcfTY4IhxIRwOFZGQJT/A7yW
         Bf6Y6mNkRxzm9EuhdNYq55qr1Ovq0do8whEV3Xf5EEOC7rYGW63eImXbFyUOQeqqXFCS
         Tiit7D99L5y4aKVqUPRSvW8owiFr4z7O/yzV6tp9g1OL2xkba35/o+Shu2dd8VjRdhGT
         in9MKLXf5PWnvIehW4ukOG5XnkP7/upfAwBOOhvMoK6N0bGBhHYYo2QIw4XXXsqy9Hw8
         wR7MZvD70qoauyRTwnlqiRr9G398EBfcNspxa6eRAuj1rVSaAOPrvQTYfjLObwhISaIR
         Hszw==
X-Forwarded-Encrypted: i=1; AJvYcCUue03wchSygwHqnKI6zdbwp0jsLLDrj9blu+i6afm50omuNTjghSbZqG04TPB64IUcBRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQTZsSC/DN6T92b8yRmFgha7A8gq2m2GhtpcsAw8tcmpd5Ulm
	BMZcL2WhwwwdPzcPV1pBAsrTMJh5Tcp7BUrrw+uWn5j+xi5QmLjeDU/q
X-Gm-Gg: ASbGncvkqZE0/ZRsgXWJZchFuHxk8z/+ko0A37lAiZywImmo+GCc4pIR5S+EkcHbdpm
	mzrxIH+KUD+bibRWsmultUFB9+tzzYF3PKDGC8RdDv/S1rq3YIU0b4mnPf0XI7JrXgXdiSi9mCO
	gu4o96jpKt7OafnvkTJc9bcS5u7Kh8EWhgXWeSod8G2aZb9ksyiLiDKn07Q/ZryN/9vtyCXC+ay
	qkFPQRJMaTACon2hmps+GGZHnGb3QzD6/pXggylCuHNrz4vAaHOg5Ob2ZXayGQ/nkLtZJ+94qKN
	+Z6b3skXGYyy6akTKUEy+YHQ3w4+aYtnxYYsicRQ+dRV52RNab6SMzK6BN28rDWByrf6X8zRgZ1
	Blzo4p5E4TOw8gPFdyHyFHVsEsZg=
X-Google-Smtp-Source: AGHT+IETNoVekMqCfD6I6R/iXvxgg8DOQUNsR3TrIRSBhU6/JAFiNVzfAvcx+qZyNtpnYS7NlLbDww==
X-Received: by 2002:a05:6000:a86:b0:3a3:6195:b971 with SMTP id ffacd0b85a97d-3a36195bbb6mr9030196f8f.25.1747664466822;
        Mon, 19 May 2025 07:21:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d26esm13197754f8f.13.2025.05.19.07.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 07:21:06 -0700 (PDT)
Message-ID: <e524f5ef-0def-44b8-81b4-a8a13ec5eace@gmail.com>
Date: Mon, 19 May 2025 15:21:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] contrib: update thunderbird-patch-inline
To: Patrick Steinhardt <ps@pks.im>
Cc: collin.funk1@gmail.com, git@matthieu-moy.fr, git@vger.kernel.org,
 kristofferhaugsbakk@fastmail.com, phillip.wood@dunelm.org.uk,
 sunshine@sunshineco.com, tmz@pobox.com
References: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
 <20250516135540.218937-1-phillip.wood123@gmail.com> <aCrD6RlO0xUmXr6i@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aCrD6RlO0xUmXr6i@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 19/05/2025 06:38, Patrick Steinhardt wrote:
> On Fri, May 16, 2025 at 02:53:55PM +0100, Phillip Wood wrote:
>> Changes since V1:
>>
>>    - removed the original definition of SEP (thanks to Junio for
>>      pointing that out)
> 
> What I still don't quite understand: who is this update for? The
> existing script is broken for years and nobody showed interest so far to
> fix it. So I don't think it makes sense to fix the script just to keep
> on dragging it with us.
> 
> If the answer is "you" then I'd be fine with it. But if the answer is
> a hypothetical "someone" then I'd honestly prefer to just remove dead
> weight and not bother with this update.

Personally I don't mind that much either way as I think using the 
"toggle line wrap" is more convenient for including patches in a mail 
(though that unfortunately only works with the current esr release and 
earlier). I agree with your previous mail that having this patch on the 
mailing list could be useful for anyone searching for this in the future 
so I re-rolled to fix the issue that Junio pointed out.

Note directly related to this series but looking at the format-patch 
documentation in mentions the "external editor" plugin which has been 
superseded by "external editor revived" and "toggle word wrap" which has 
been superseded by "toggle line wrap" so we should probably update that.

Best Wishes

Phillip
