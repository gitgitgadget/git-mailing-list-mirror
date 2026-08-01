Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5A22D7A1
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542760; cv=none; b=figDKq3TeXtk0Si4G1ZgbezrjuchbxxG0ucdnpWi/mw6FGJBQu4aH5l1HCpl961UoPi1zGLmjHARob8FZYkK9VeinoF0nDyCZLWlwegh2qZ6e6A7UbZaRhSUjchxFvTehWxWBo+4zE+bPBEs3p7kv+YEP2Qi/kJphcZdd6Q7CpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542760; c=relaxed/simple;
	bh=+hF2rFgMz4E7tdBrcN8d+IZS9M8CpiJ9GeeKVZI0Eyw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=oynAqNT3JazQ/jlg8oqATFLpIDCbZmEeyeCIYhr+j5FOzfVPrPdFltFqaORF2i5IJcR5K5svr2GbjE1OQcOgbKHkFDPPKLGnllHvNMFO6YP0tW7j2OTsiCDt2SQSI5wxKY/GpxlhNyjEsFlXkIJhrjoW8gFE3pMguCDAY6Kjuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJeL7DU6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJeL7DU6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1596603b3a.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785542757; x=1786147557; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIfpqtPDeWaSwDCrAdkkXMxUXffkPb77V8uRyfVbN7w=;
        b=JJeL7DU6JuAPv0dGjygd/bEv2KiQghkXyJ266rSu5s+9ZAX2ukjh7acMa5EhRVrflt
         VcgZ3P3YFV5Ip41egjGKjbLIqGc1Gtv6UQYGNQdutw5D8gGbPJnh/m6X+pDp14Z7T8P/
         LGo6WaOpVwtAG2jInST6zkOxCRLwd+oQDWtJYPmva7S/TIo//x96oDsAo1xwWDN9h7F2
         Ici+CDii4nLUw/rbpSpwT47IMsSvSKeJRzKOfSfYQ0LzZ7bOzn4ogX2eV4NICfUs+NkH
         GbvBpOIDuFSe2OQasma6k7+/eIO9o64Mgw4X2w7Ht84SCCDq7LzDOc7ztBfnyX9Uwlla
         Hw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542757; x=1786147557;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIfpqtPDeWaSwDCrAdkkXMxUXffkPb77V8uRyfVbN7w=;
        b=UnKfgrpi8tz+rHFmKkxEoYulUmp5WKNDZpmAUB4/514pAQF2n86G4Iib7hKbqsOjmR
         GUtNn6/TeyQZgfCiq0QQS0CdvTkdX4AG0uwZiqcjTidpiyJqjYGQOT5EZe02n4AZoRRZ
         FModaP0J342kPtfuu+VvjMemhuLxD3Xd6QtV2FzSd3bfPw5lT03vhFNFsmvysmtNRLQN
         Zxu0i+HcVfNaFVnxP+e6VniOs/abz7kDcdY0GxdmXUX0EbriepUNUQ52YfKHM7cf73mO
         VlD6PgMo8OOV2HXPIJzzK5qg5iTsY6J2qvmxR1UzbqHtgIjRBHnk4AKWpgIp+35x23Ip
         duow==
X-Forwarded-Encrypted: i=1; AHgh+RqlqecIIfaemhEUD9wsQk+8FSyulExgldIw+dv4GLGf7bQNHD5GtEhEheoBOjfKBP93IXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYtQyhOyfd+GW2zBrXYFnEi4naG04rYvpsHnbt+tY6vJP1JQN
	EWtKpsCmJmY9KGBu7rZDutBTZH8Z7SPnVDgpcRrA4m2l4F9JgBGGSWfk
X-Gm-Gg: AR+sD11F3+hybSLTndkoAhIMqHT44s1izn5DyWa4TPrCLdUVMOvEzQe6Dt7K2zChpkx
	iRNHz0GC5vhlKXF+PxUaqgOR4NpENW9MV4qW9tZVuuWLsrB/4nM6MtQm2RhYaRnmSDms/qNlNXB
	HVo+aTygTisITnUE8ZZ5+TbuSPdhGz3KtC76rV9ZMkgRBcQ97y9nYDge2NFwDE+vMIWWnlWa5kh
	brYtkDUvByg8naEIxSm4QHH4PGL2lBiI9Ce4Y3FajpRkQBMdVQ7gT8Vapab5do2YtIHk579wT5t
	q2tHkZDU9yUrzFDumKddVy2MilFI/L2OGk7S7/q2t2yas8gReCwaNry8wi3Js/KPdIA9phj0MkI
	yjXH8wRjAwoasNQhshVCjlYDkh8wR7r4blgCZpP0BVAoX3ReHhEoBB1N6VezP96wzCGHcpyjStg
	WDDERl0tA6liSSYKgul27zp2HaHAsjlom6IOsbnuoSe9a4kTexS0s3RbhgFT8UuFMf0H9vsnIbU
	+eLP4DgM7w94EZBAz/GOWSHUrAhyi6T3ApXLqxPBabTELX4X8F0K8H76dLCkEDih3x0iWd4GP4l
	prZkVJcoPQ/QAMVDbKMbv1KwaFn0H5gc/dNSj7sE2A==
X-Received: by 2002:a05:6a00:808:b0:837:e9cc:d46e with SMTP id d2e1a72fcca58-84ee4820bc2mr1419398b3a.21.1785542757081;
        Fri, 31 Jul 2026 17:05:57 -0700 (PDT)
Received: from smtpclient.apple ([114.202.151.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd310b2sm1035697b3a.5.2026.07.31.17.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 17:05:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Git trailing blank lines feature configuration
Date: Sat, 1 Aug 2026 09:05:45 +0900
Message-Id: <06230920-FCA6-495C-BFE5-04DF1CC2A426@gmail.com>
References: <5097209.GXAFRqVoOG@cixi>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <5097209.GXAFRqVoOG@cixi>
To: Thomas Nemeth <tnemeth@free.fr>
X-Mailer: iPhone Mail (23D8133)


> Le 31 juil. 2026 =C3=A0 20:55, Thomas Nemeth <tnemeth@free.fr> a =C3=A9cri=
t :
>=20
> =EF=BB=BFLe vendredi 31 juillet 2026, 13:08 Johannes Sixt a =C3=A9crit :
>>> Am 31.07.26 um 12:19 schrieb Thomas Nemeth:
>>>    I have the habit to keep 1 blank line at the end of my files. To
>>>    me,
>>>    it eases the EOF modifications (selecting code blocks, pasting
>>>    them)
>>>    in vim.
>>=20
>> (Call this is [x].)
>>=20
>>>    Would it be possible to have a configuration option to avoid
>>>    warnings
>>>    (because I see that as a warning) about trailing blank lines ?
>>=20
>> Hearing the first time that an extra blank line at EOF is necessary or
>> useful. Would the correct question then perhaps be: how do you all
>=20
>    I wouldn't say necessary, of course. It's -- at least -- my
>    preference. For _my_ use case, it's useful. When I move code
>    around, and that code is at the end of the file or to be put
>    at the end of the file, I find it easier to already have a
>    blank line there. That is... Because that's how I use vim to
>    code.

I use Vim, too, and I=E2=80=99ve not personally encountered the desire for k=
eeping a blank line at EOF (though occasionally certain operations benefit f=
rom placing one there first!).

I wonder if you could describe example workflows that lead to this desire? I=
 might learn something, and in exchange, if I see a way to accomplish the sa=
me thing with less hassle, I=E2=80=99ll suggest it ;)

Cheers=
