Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353911;
	b=4d2nH7mip5D/9aSza1i9Dg+5ldSG+EXj5AiicYA7zdjw8ATpF5PBdMpJOJSmyQM9HBAQ
	 coaAWtKLiAcpH67AzI1UVrlzo0KbRo7h7RBlbdSvRWtKrdtBROwAaOQ+7b8Z5usGVUKMc
	 gs63ACHyNrUJXS8VGnm5kKyVwDYy/M5Py9dWFf6hbrQdZnx/QZ9JR5LACyDbQGgIxlze5
	 mwWDNKWzAzeNXODBOv+nKLUEVViuzWgSEUY74fo+dx+Qx6xcyzZc4LA4cOYDjAMj4UHej
	 TbliXIk7r0lePien9Zb6UuJvGaUov5dkrwmXlxY6CkIjORvLe+wQueUBHbo6Nkl0nVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353911;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7/y+u/36qkEX+af3+sO44Prs3iJGbHrHu8VkWo7rGi0=;
	b=bbVE23c0EeYbYEU5lz6k/k1949wGZj8VXY4DxUKAb2h6bRjgfr5mTP0hyaKpHiDpqJK5
	 lqfMtk+r02eMDLe9Tkm903AaasoJ06G4SqECkdLVTiIqa41f/Yjpr844cc7NUvJRrn0Ki
	 Z4u+k/SLvP+ww4tyQEobzgJUwaf8NYiTP78MHHCAzdBudxYWkSo7zWkLmrssJUD4ZmpQL
	 klVasRclHFzoL/ZYdheEvivc7QaHscF6xvFPzUtxJO0QF0vY0ZLs6v8uUACYvwWy+A3WN
	 2bZJQa0iodt+akgu/Uzi5QoWm11SGHL/RuhlkCmmh9//wAOrMqxxpLIq9FeAvdcEOJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b="j9EcZ+i/";
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8E606A32A
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 13:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D8E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=j9EcZ+i/
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AMDP3Z92228998
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 14:25:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795353904; bh=7/y+u/36qkEX+af3+sO44Prs3iJGbHrHu8VkWo7rGi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=j9EcZ+i/ayY13ARlQU/RKKlnhBPPX6Tb+NR27vUwh+eSl903CCW+a2lUj3xESC4gM
	 gtZx/jJfXPi9c8X9G1se7pXp+2YkIWPzJbMRJB0jtVjg76Efo40+MyJYSXxdC7yX+t
	 SxrWa1naqcW8PfprLXmbAkZkwpLYmirS2dqGDv3I=
From: Dirk Gouders <dirk@gouders.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/5] utf8: introduce bounds for
 display_mode_esc_sequence_len()
In-Reply-To: <CAHWeT-aetC12pnVs=rEH0kYt-RAunfULxkk9JpvmoMi4puYFng@mail.gmail.com>
References: <20261120-master-v4-0-5ff523db7285@gouders.net>
	<20261120-master-v4-1-5ff523db7285@gouders.net>
	<CAHWeT-aetC12pnVs=rEH0kYt-RAunfULxkk9JpvmoMi4puYFng@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 22 Nov 2026 14:25:03 +0100
Message-ID: <ghcxrxm21c.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22 2026, Andy Koppe wrote:

> In case you want to go back to a length parameter instead of the
> optional end pointer: I looked it up and functions such as strncmp()
> and POSIX strnlen() that take a length bound actually support passing
> SIZE_MAX as the length.
>
> The key is not to compute `s + len`, because that can create a pointer
> more than one past the end of the object, which is undefined behaviour
> even without dereferencing the pointer. Instead, the bounds need to be
> checked with something like `p - s < len` before reading `*p`, which
> avoids creating an undefined pointer.

That sounds very reasonable and also fixes the O(n=C2=B2) risk.

So, I will take Junio's function as suggested, check it for `s + len`
problems and the wrapper then simply calls it with SIZE_MAX.

Thanks for the review,

Dirk
