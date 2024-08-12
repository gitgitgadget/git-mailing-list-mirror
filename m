Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A5186E5C
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474757; cv=none; b=h0jzX+fvEEiGXRul5LiVZoVXGiOKsBM5aU1cc9eadHheNRuUbvnaZ+jNJqyuFOL445uoRwoHV9J/1voLJTJBtU0xqV/UPUpZzXvrUO6m3M8kslcfY7ldzVMFTW5XyrvgtgYiDkO6+880yiZFa2z0DREOeenKb+pRMaywxGD+liU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474757; c=relaxed/simple;
	bh=fSwWdfqPiagHlA5WjqSZY+MLUFV/P3X/qX0JNoEpFFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9/tBvrJv8PAT+KM7teibTSLeE1FFj5IMpEg6E/0rAoZvn5q9NSVq1mvwEHhH3G8ql5G3gpR7Hmjq7UKIZK5IxuGKqPWc7DlGq63byeUokgo9GDs3oul3f6KdCiGAsSPLgWlOouSruPaPQckB/JyamLs8AfLkzTIzl9UGYkEs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOYYZ5qk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOYYZ5qk"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso532514966b.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723474754; x=1724079554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSwWdfqPiagHlA5WjqSZY+MLUFV/P3X/qX0JNoEpFFs=;
        b=HOYYZ5qkcRaEP0cJqwCfm2D6DemsQ90S6ru1Sfup3TKJdFNzEDNA0vjntikcO0vujx
         +m+5bRpAZut47oijosle3gima35ZoMl6piyJDk4bNtNeUS0sxPCWNTrTyCyp5QVkCvci
         +6kQJowi78iwjqnfXhmZ3zvm+VwyvX2QpZB8dPbMa+jq1f+cxA5qzFm8hWj8qjoiAZb2
         IKT8mYe3RptnLFx4KMST85URXcEvL3jS+YC3NL+Xkxw8W51A4Bn8uSYYDP4KOvMVnR0z
         K/JJEpJ128ECg+Ymcy8hZ1vgEBwtyenu8dizbnMB6XhSDfjxuVmkcw+YFG0DR6LF8VO4
         m0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474754; x=1724079554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSwWdfqPiagHlA5WjqSZY+MLUFV/P3X/qX0JNoEpFFs=;
        b=GMtSxruj0WaHcpKZSZPFw510GJkj7HkJKAm4skU2LeRcoE6xDb1ypwD1vz5669xM4e
         b2KqCt29/aoscTp/KUghJEAxKCcARUg/72WK2d+hSjeQ4Yd6zJj/rQT4SLO69kQLWWUW
         FNtIeWunoq5TuAyev4qKmHw7xFBX1NSSaObgRDwCNifusn6qtSY3fJfLN8/KeiF2UINi
         oC+mDDDd8mEFTpu/nT4uWpl+s6PqDPTbfkjG3wRRNZ6mawDyGcCEDNLMlmuzO07U1O3l
         /Vv5xaOM2JsmGQevKKnyh+Q2NMJbQDjR7ZN6zMZQHfrjmc1B0Lr6JxxwI9xHQ5o4xfKY
         j3qg==
X-Gm-Message-State: AOJu0YzlP3tad5xto9+thrGSmHYtbpE936NtU8neSZbmOYw9x2RBQCy3
	o1yS4K6WnvoSc6ufKzfUsko3pvdNovxSCEPgmIfVHc6rffQ8RT0WYgksHW46+D++TsqV2L6+k/C
	XAWW+F5t+fuJC1e6LqdLo0myZh8TZ7A==
X-Google-Smtp-Source: AGHT+IGhZPOaiPtVmZWxoptK1Db3J5UzEQ09xRgzd1+bsJGXYO3j8RhalmfrnWhuUedrLKcR3wlyBLgSqZ/H1HeA1RA=
X-Received: by 2002:a17:907:9724:b0:a80:7193:bd93 with SMTP id
 a640c23a62f3a-a80ed24bc1fmr38912066b.25.1723474753820; Mon, 12 Aug 2024
 07:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
 <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
 <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com>
 <CA+J6zkSFCUYLRTRE0Gwug4-fF9f9-YbfRz_atArmMLLCtQDr1g@mail.gmail.com>
 <CA+J6zkSxcogPXdAdr7VL0B3MnQxQNYwOT5Kw2iK_YfPLW7CMcg@mail.gmail.com>
 <CA+J6zkTyVDJcOoZC-thRAOYNudVWB1wgye0Ezj3o1AO_5HOS6A@mail.gmail.com>
 <CA+J6zkQ7W=3+aqAHwzXzVM4-mZ9XpCkAfmP-GZ7T4i+i2Gi9aQ@mail.gmail.com>
 <CA+J6zkRxpnQ0E-KK8-rRDfDJar=9TwmG18ZkiA+zcxaavwPoqA@mail.gmail.com> <CA+J6zkTQQoWq6MSuYArwOx7iVT0qFhFd+QOP0vvO1NVczcvEJw@mail.gmail.com>
In-Reply-To: <CA+J6zkTQQoWq6MSuYArwOx7iVT0qFhFd+QOP0vvO1NVczcvEJw@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 12 Aug 2024 20:28:48 +0530
Message-ID: <CA+J6zkS5VE7ogELJVso6AvuYR=6-jwnap=oPPEL2y1kd+1JpKQ@mail.gmail.com>
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the eleventh week of
GSoC's official Coding period:
https://chand-ra.github.io/2024/08/11/Coding-Period-Week-11.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/
