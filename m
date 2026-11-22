Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339387;
	b=H1mlKSPT80n58b9sz0Xs+0vD2l3cf2+3CNiKkRf7XqIcs3CgjsMFKzVvbCnYZXMGBrpd
	 JL8WevkaalnDJ25TBtEO6JLrWzqesM8g02NqTvmJqpBS4jitgLSt5u+ta+blnbKSZhY8b
	 9DaCoHLtLyE+qiG0I/D768XRiunNQResIYGClj2OAt1srFZJowM8HdNYDumpUy75l65fM
	 26v4exsTuIe38SIgE0OLT29LZUhXT6/n4k37pTBIBGh/fh0ltqH7E7SN2lmfkrtm6nzfq
	 x8fYfn2Dumt/rzVh5Re32hb9uQv9a2a5OVEGO7OuHsVVGZJ+jmOjMKhsclci2gbxw8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339387;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=sWGEP4UGgJlPObQ8VU/Vcn05/jnVCQ0Px+k8myYo4ro=;
	b=YlnLkx6Gh/plmADOHfZFlZ9VupF6ufBZPVL6Ys9tvaqumTHSx9nt8wTU4LHAlt0d3Ue1
	 V8kme0w8jTgxsf+W479GTB/BvdXgreRfDc5ysxk3POsWMX4/kLq9/JWd+O6xbWHMaIko9
	 Ti0qCwYJ4RjlF+20PMBotFygHxCeRgLR2rDHg+NDD1pBIwNFEBJXHEbnWrI2rpZ2mQY5h
	 9T2pwuIThON84G7e8py3mYdfTUL7ubgtgKKjnbwlbLMiFjpbrCAenziDLP2IJox5Gmqlf
	 7PvC9UnZzEv3tF83lWozU0LrR/yrBgjeG/ZYX6jUSdAqI7efQQqNOlr47vd1IHecQSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=PZOvUDaj;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CEC606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CEC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=PZOvUDaj
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AM9N0oY2216680
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 22 Nov 2026 10:23:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795339381; bh=sWGEP4UGgJlPObQ8VU/Vcn05/jnVCQ0Px+k8myYo4ro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PZOvUDaj3K+Hx6PvmiUzYvSmMXcZtRVwZaXqXkXlZuaCTyGSQN1osfl8Pmd1pzNOt
	 IjvY8OJPazeKRsYYJLKr5+5bK0GxerQBRNRrbqs47bDJHfmN3PrAM814Tp22Fj6qQT
	 9tYyAcNjBCxdRk2HgDojfsQOYrWszD9TRC3V+z6U=
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
Date: Sun, 22 Nov 2026 10:23:00 +0100
Message-ID: <ghpkvxmd8r.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 22 2026, Andy Koppe wrote:

> Dirk Gouders wrote:
>> + * Return the length of the ANSI display mode escape sequence (e.g.,
>> + * "\033[1;31m") that appears at the beginning of the string starting at start,
>> + * or 0 if the string does not begin with a complete such sequence.
>> + * If end is NULL, assume a NUL terminated string, else never look at *end or
>> + * beyond.
>> + */
>> +size_t display_mode_esc_sequence_len(const char *start, const char *end)
>>  {
>> -       const char *p = s;
>> -       if (*p++ != '\033')
>> +       const char *p = start;
>> +
>> +       if ((end && end <= p) || *p++ != '\033')
>>                 return 0;
>> -       if (*p++ != '[')
>> +       if ((end && end <= p) || *p++ != '[')
>>                 return 0;
>> -       while (isdigit(*p) || *p == ';')
>> +       while (((end && p < end) || (!end && *p)) && (isdigit(*p) || *p == ';'))
>>                 p++;
>> -       if (*p++ != 'm')
>> +       if ((end && end <= p) || (!end && !*p) || *p++ != 'm')
>>                 return 0;
>
> Those checks can be simplified a bit:
>
>           while (!(end && p >= end) && (isdigit(*p) || *p == ';'))
>                   p++;
>           if ((end && p >= end) || *p++ != 'm')
>                   return 0;

Yes, thanks for spotting this.

Dirk
