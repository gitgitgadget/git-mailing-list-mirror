Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA02C324E
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748892048; cv=none; b=VKt7meRkpPnhZmhoBkkBuDv2+cT+UzFEut/5mf/dHx0mLbhmPZDTeFlKgSgRn8pbIthHVj2Vms9vViZXNKBm9ezkKZTDt/18ccp9ZuzmmW370Ma+4cFuVGgCsQypINAKH+qs/EbEJTBh6wwtIHa8AYwUSR+rWWyAJzrgmCRwxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748892048; c=relaxed/simple;
	bh=+MRLVHE2fadgzzUgGT8on/MjMNniUnEUGnVZ/8WQGu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LJa8TAZaV0AlRnbfEoF4IclEfEsgZRX6DEEVjUa+ZzP03USgXKUpAElPedSI8EWRQA+S8LU0M+uVrvAL3L7ejErEfHkIPSwal7mGL0hSLFjfm8ZJRz3Hiysz0SHJWsF4cnB015s6Kw3DSxj1AV9ugpOkWfZauzjorIa9EWoYw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFD+ri+T; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFD+ri+T"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-745fe311741so5349725b3a.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748892046; x=1749496846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq6n/Ac8SSmgNc15xPg2/UgePUA2ydkev4WYlPD7/nw=;
        b=JFD+ri+Td5m6hqnRhKIQ33bTMgODxli6bZj38pbN2blF3fnz8icxzeVZ3FGZzhC4BL
         +Etw5+QmeedN9811xgj9QerGc1wqst7Mmp3WrCscyKnAbZlXdvp2PkdkcA6ipRtQyFKU
         BzU+5jEwCkTC7yZsCYosoQFEDhE6eB4QAcSKHMMovDInu6MzCDYVCpevz+ui19MUup7v
         Cua1kyL+N76yDe53RECfMxzEStmImyyKdW93a97j7Grwo1YlB+wyQuuaNRXAwe6nPn98
         1PSJ1N7s+s+DDDql9MG7MzzLW8H8bbxEdFdyilIYrnKZ5PERi2hJTNL4ctD804X/0b3l
         P9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748892046; x=1749496846;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fq6n/Ac8SSmgNc15xPg2/UgePUA2ydkev4WYlPD7/nw=;
        b=icV91inFx28x3GYGFBPveN3HeCc16BGiicoaVr5+GPH4shi/9o1nTQTHuS6DGNd5nm
         nuNXg4hWBz0XyA1JLeDMRwsXmkgyIP1+mkN6ITiBq2GwKV28Fj3awd6azxoUsYOIPj4P
         3nMc+6Zr9lpsMelw0zzkQ9niBhYsttX+/WmFpilw/tGFQkbVmJfNRGPdr6UkzGWsRgwY
         hfJOqkQBZTWmsaZOu4QTv4DBjsPszixhyDalzXnlXBPrW9yC5QJeeJrYr6CgCJmEiEeU
         hb1ddmxTP6aoK27cO/C71HN7e0JsZELURTl0dR5bGD+RhDjbMe6NtlNpHVLhK+0+j2pO
         BrjA==
X-Gm-Message-State: AOJu0YyDIIs4wwtj80vNwKYUPFQ7JLQiJc0B9xXue/Ghb2dSblALWTSx
	oXq/qUoAJi41NrFmkvcI4N8YjDEfWvGtyMC5oMjpyo5dCrwe8c1xN8Sc
X-Gm-Gg: ASbGncvlPZYYUmO9fRrBMvV8YRlLfE9kVWv6ZlHYKBfc/WQv4jsZtqE20BgoB0tMFIn
	YMEqq88GEp7FZGBvuxlBWPy4f1GWfAR7TbCoTUJbaBw4Tu55S5C3M1ktIBE83zP7P2GYW/DFrMv
	lDM/KZ5iifJ4RsnSYD044IDSePElCvDPZZxdDeCYOclDvqqukSS+aMQAJRZirhw9k1UWBnH9kUr
	YcN7K+WpSZZCWqGmC7gUq27zcY7B5aY/BPe6qGZqzK8z110vgtIqR4G4GYLzK8d8BPGac905rcE
	4B5z1DVDjqTp7JYJSkXdtTuXcGviu7X3ntwnZDZ43g==
X-Google-Smtp-Source: AGHT+IFmedHNtDtMwfpo84mLIJmujiOcV3rdB8NZQnPyAuckCEDFfkwjbBDUbBnjA0XitsKA+M6KGw==
X-Received: by 2002:a05:6a00:1743:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-747bd980d13mr19612969b3a.12.1748892046362;
        Mon, 02 Jun 2025 12:20:46 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeaad78sm7950359b3a.46.2025.06.02.12.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 12:20:46 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Junio C Hamano
 <gitster@pobox.com>,  vital.had@gmail.com
Subject: Re: [PATCH] completion: Make sed command that generates
 config-list.h portable.
In-Reply-To: <4986157.GXAFRqVoOG@cayenne>
References: <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
	<4986157.GXAFRqVoOG@cayenne>
Date: Mon, 02 Jun 2025 12:20:44 -0700
Message-ID: <87iklet0fn.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Hello,
>
> I was on this issue here:=20
> https://github.com/git/git/commit/e1b81f54da80267edee2cb8fd0d0f75f03023019
>
> Your proposed fix is interesting in that it does not spawn an additional=
=20
> process, but it does not work for me (debian sh =3D dash).
>
> =E1=90=85 diff config-list.h config-list.h.new
> 281d280
> <       "gitcvs.dbPass",
> 283c282
> <       "gitcvs.dbUser",
> ---
>>       "gitcvs.dbUser","$nl"   "gitcvs.dbPass",
> 350,351c349
> <       "http.lowSpeedLimit",
> <       "http.lowSpeedTime",
> ---
>>       "http.lowSpeedLimit","$nl"      "http.lowSpeedTime",
>
> If you'd like to test your patch on different systems and happen to have =
a=20
> github account, you can open a PR to gitgitgadget/git . This will trigger=
=20
> builds on several targets.

Thank you very much for checking! On my system /bin/sh is linked to
/bin/bash, so I did not notice.

I will send a V2 that works with the dash packaged by Fedora 42. It
produces the same output as bash and works on OpenBSD.

Collin
