Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CB244661
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 23:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497203; cv=none; b=OD2TSn4nwopjsw+h1VvZFndwuy7WINBqpCJnLX+UAZY3LFPQHU1OKfbeh8sZLdXIAGcXmTvrdrwr+uo0K10SPChoQB59PyJxwfAc1XWNnqxLnoV9f3EBGpRnu/dw+12C9NAUEB0Zcbc7XS6+7fIelpfbvzHHavlJwRs5Rm1HgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497203; c=relaxed/simple;
	bh=dxNhzcdriy3xoMt9d9yY+3l+ZL0bw8mcwias3ZMAWro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpswjxLxUwmg55O9remcKE1FbodrB/sWPorB4mUVcyxVULp4x4x8WBj9RUbaboC4ZNU4zUCb7RICnWA/uEjOIrNoRWm7+kFouM2tOAubT+JWmGKC6Gxme2MiXRANFBtVT8L3h/laUxL92fRj0WfeXs8oeO14wr7RBmb6SWSHHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm8l0hAg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm8l0hAg"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747c2cc3419so6910618b3a.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 16:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497201; x=1752102001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qHvY7rWEZKDbHMzno8Fbm2AjHByLSATq+sn4qibwa1E=;
        b=hm8l0hAgaxXt9bL8rQNR0SRNMzaD744PPBhmYj5MNzZDCXxvzVfNtzXBtuqidZGd4M
         eV0s5mJJd9YozDy+9ffECUXf/LZOwP3bhRJSBKgt3s4FxA5lucphnpuFr3Ow3MiP4bpe
         E0hayCmsPnwGqpFu67iTOEt2ltqocpda0rqfasPxOdzdAgqULSGM5ZkdQsch1Hf9UeFo
         J6Re12jLX+v/eX/F1vpw9F6pegOJyYtUK2NYqP5xo93ZYU9gb+pN0XGJMB9Ra/ric+F8
         XcYPosD/YrQtP6ZUCjCfNnVU6TcLWrYhiAY6lT8nhRw/yL8kjrRaU65E1c2R7kbH8dLU
         yO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497201; x=1752102001;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHvY7rWEZKDbHMzno8Fbm2AjHByLSATq+sn4qibwa1E=;
        b=RLxWdG7/j46KnnVi95gsIgfgyYDVb1MITtiaF435TNSef51qeD/+qjbBZ7tkEdUEjU
         Uy39QpX7zACegfLb4HQARovkuK81C6SoiVEasiwnQ4QcKKogfvH24KJiFL/FPqTs3f6p
         isXhpWZ13SKwM7ry5j3nwCnRjupuvc6fitTOZRGGBY59LPQsvvztr7tWXr/UquBsLXwv
         ODHOZjOJLtF3e8Dsc56Q+dwsarEQL93cr0sgRSwU0B2qv89i3d9BXCxHQJeQWFW7Rr0o
         t88XfGo2q6tFuLiOkAYp2f2KIPUiu+DBp8rfLElMNPsOIduqxcOuQJhWAilkDFFHJPPD
         xnCA==
X-Gm-Message-State: AOJu0YzDMseilbnDKwJgxRdHrDHNdaaFmaxUVKOXqZ1lHvpeHDzdE4D2
	ceNcpFO+ESlrVUYA4cucuHEG68S0dBBqVze0RJbLdGnNoB4IJaixd91WcQ1dmg==
X-Gm-Gg: ASbGncuWxNxmf5MjSfuzNqxes0ncepNVDKLc6q/i90NXKVU/wCpLPckzvnKRAosgVnf
	Ps6DAEt4uv4lZzqAXQZHIqPTMQRJYULLx+BeWPrFJ8g5lzhEZyGIXY77Gjdxy8jIu0YBcvSFZUP
	62y3jkDidLJ3RzpTaMqjG2zbocNkxzkT7oqh/dMKaHwMVwkV+8BswMpq4x9Bj7x9m0i5DO/haa9
	IH4Gc6RZuJtLaSRuSEAEOlUHGR5xtY48QqEGbBG88GSmZMwInUx6cWlzTlxpP5egtXCjVhllTgr
	ABd2XfvzYzgYoNRANThERjfLniGcBV0Qvkali9SKuyCX1WYere2C1Q5cFpRaE/bmDadRncK9qV5
	1l0z29glbGiIVyzPgH9Kw9g6XJjc=
X-Google-Smtp-Source: AGHT+IGQT8Shb/V0EubudcCOYaXW11pb0S0EyMKcGv4fhOquQZMRYFrbjuoEZMQbHAybn9MfvJ9/BA==
X-Received: by 2002:a05:6a20:a123:b0:1ee:e20f:f14e with SMTP id adf61e73a8af0-2240cc8ba12mr1724410637.38.1751497200811;
        Wed, 02 Jul 2025 16:00:00 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e31beaa7sm13765211a12.35.2025.07.02.16.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:00:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  brad@comstyle.com,  collin.funk1@gmail.com,
  pclouds@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3] builtin/gc: correct total_ram calculation with
 HAVE_BSD_SYSCTL
In-Reply-To: <ep4q5xwbys4qwpkmmo5jujzjorrb24v5na4yuwpjr5owojwk2q@omb7xpp4oov5>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 2 Jul
 2025 15:42:03
	-0700")
References: <20250702154649.44210-1-carenas@gmail.com>
	<20250702202118.48742-1-carenas@gmail.com>
	<xmqq5xgacn2w.fsf@gitster.g>
	<ep4q5xwbys4qwpkmmo5jujzjorrb24v5na4yuwpjr5owojwk2q@omb7xpp4oov5>
Date: Wed, 02 Jul 2025 15:59:59 -0700
Message-ID: <xmqq1pqyci6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

>> > +			physical_memory <<= bits;
>> > +			physical_memory >>= bits;
>> 
>> I do not quite understand this version.  Does the correctness of
>> this depend on the machine having a certain byte-order?  
> ...
> the shifting was meant to be a cooler way to get those bits cleared,
> because I thought that relying in the initialization wasn't as cool
> from the previous comments.

I more often have seen a pattern like

	physical_memory &= ((1U << bits) - 1);

for clearing the upper bits, but that's fine.

> a fixed version of this, would allow at least a better return, and
> because most of the extra work is only needed in Big Endian (which
> could only affect Power) then it is almost a free upgrade.

OK.  As this is not a performance-critical operation anyway, I am
perfectly OK with the dumb "we ask for 8 and be happy if the answer
is 8 bytes long.  Otherwise if the answer is 4, we prepare a u32 and
ask again with 4; other "possible" answer width like 2 or 6 are
probably not worth worrying about" ;-).

Thanks.
