Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF1318ED0
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678749; cv=none; b=oSq8Gw3yXp5ebEU66ZDkYeJhxh9Gmq1J15oEO0xIVO/GJGbC1ejMeB6HwTo8mXP6uR+eqz/oXbCsB4WVPaCdC21+6o6CYxxtyHvnD2JEqzTJ/pLNt+vvmF10XN+wocmFkE0cfYEWliKdWQ5DdHraHkSaukTZgGIzDUfBMW7D5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678749; c=relaxed/simple;
	bh=qHqSp5xICR/cmRtsMFTtoPyTiO+Uw3TDGjdnlyEO3Gc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=bGLha5EUEhPgvFB2Pu0wgniOZwk8zHCUDwhr4mfg37j527hyl//2h+PsHqgX7zMWpSodie+ygphCsW0yhAIKGrb5NBxrXnJpCOH7M9/w2hZl5aQdRzYxZ+eCVYg+s49HF2/Gg4Vo45jqQLrsKdO8sJfGjU35gfOcLYeNyVOTIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXxtFJIj; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXxtFJIj"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79430ef54c3so32414457b3.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 15:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770678747; x=1771283547; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/6b1rs4AD22HYKGqXAZBpgrH6NbBzxZ8cnv8uy7/QI=;
        b=HXxtFJIjM6iOEwWUx0WrOE4JrGXZFjHNwR6icV3HCD99Ii7RaRTS1N76V0SUwjzto/
         PofBsr647usBmXdW8k4pu41XEDSarsMJgHf2WLf3TOZ8LhMYIHrWo9f2k4nJZOKVWezU
         417EwTelHg3CaFlAvfSYJf5BreWqElLPBbEClxghx5oRgSsEiDoGwOD1KBf3xqUt8IFV
         rUr5JoDYimYaBkjcks+YAHXnZGfFFRAI0ULBDmDHNvTrov/W4KvJn/2T83oBIFJujnDF
         aZxMjdXhxazmZ9ZBa++CWiaTz2WRE7DrXaxaoU0BDtCryQNRaQY340ccBHb1EBzUm8bO
         HtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770678747; x=1771283547;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/6b1rs4AD22HYKGqXAZBpgrH6NbBzxZ8cnv8uy7/QI=;
        b=EvmLXdr48ZJVAta20/1AX1YdfUXqNgy+pd3nBfQ88evEUsC66eMUjIsmnsnf6uL/P/
         o8ad0IxaZraA0Pr08HQG7wvfZRd3iD7p54fc9BIoaUE6DMGVIromCyJ2esuCA61ZWXY+
         c7pozGkTYlWClmH7G80UZIBiLyJXXposc03tlf/Pn7q30xBJXBTOKcAaoBlH0s68Fh8k
         DtIzFRrsOSvdsSDkfAv7QpcUkIG71ZkXyGreNjXqePxeo4KZN7EJYdMb2f6nP1o2ZjJ1
         vVLCEblPvOOz0cSuW5HHdoXYQ/yBm8HSqto7eHEc+X//npjIUodBskAbUruNpaSjkQgv
         RM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVI9Suo4rKe7jsL6mFgXwkH5sjpBqk6N/9WQ23vf+qV3UtW+tw3wEAWVdpZUBRQ+u4ITZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWM68vD5W2lu/CqtwFK+70kFulyJM9SrEWjXjTvnbOs8e/mNTJ
	tlp7OB3rhfbZvNj03qiB9QqOXlr7/1UZTx2EWI7e2j27XI4Sg76JaTCD
X-Gm-Gg: AZuq6aIfgqe5Khf0GePzfFaJtt73FsaUPqdgy663sTMvHxzSivyEMu0ULVpxq0RDYIX
	xe1b94DLcXj1+p3Os1Y1VadXhkYj9MUI9pHPsS9hlIW8Z0IOt2b9ZP6MzBMMCQx+uMERzCNg8NK
	mIXzy5rvh5huC0zB+QIngQEPWWd9GjFcXD/FJtE8qDWDsMG/GQMVpzLiR1Zq1H5ZoMz1x1k+O0Y
	msyDX1u6zPUmfYRD0t2867baU6dE9lzJhOh5lZbIvtsTO0v/6TxSeTZ27QNUjC0kK2YPpbeqPgJ
	c8fwN3a+Y9GLEYjpfyaAMuzUZrBwiTietyiO4R/pyU2Yppnc/qdTLRTOfriATWptkNcpanudLCZ
	BY0h015g6yfAPfp/PV/VlMJ+oK/mWxBacbSZr0er5cxfh/vGnUBKrsiTmr59vSpuZiNhg4khdfF
	FrclsS1avAhjle2seXtIIRuRMaFOIbXYXY6ZQ2YX1P+D9Y9FpQVrqsnjhh+YV8plSeXeI5LNutP
	cd2gnKn/QsgQF9w1r3da11GWd7tOkqehQ==
X-Received: by 2002:a05:690c:d8b:b0:78c:6ae6:3c7c with SMTP id 00721157ae682-7952ab56762mr125475107b3.48.1770678747119;
        Mon, 09 Feb 2026 15:12:27 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:1cfa:97ae:441a:82ab])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7964da6641esm30370787b3.12.2026.02.09.15.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 15:12:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] doc: rerere-options.adoc: link to git-rerere(1)
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <xmqqzf5h36dc.fsf@gitster.g>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Date: Mon, 9 Feb 2026 18:12:16 -0500
Message-Id: <A9E7502B-3AAC-4242-9BAA-47D5B4C7D151@gmail.com>
References: <xmqqzf5h36dc.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 9 f=C3=A9vr. 2026 =C3=A0 17:21, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble@gmail.com> writes:
>=20
>>> diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-op=
tions.adoc
>>> index b0b920144a6..115882edab1 100644
>>> --- a/Documentation/rerere-options.adoc
>>> +++ b/Documentation/rerere-options.adoc
>>> @@ -4,6 +4,6 @@
>>>       the current conflict to update the files in the working
>>>       tree, allow it to also update the index with the result of
>>>       resolution.  `--no-rerere-autoupdate` is a good way to
>>> -       double-check what `rerere` did and catch potential
>>> +       double-check what linkgit:git-rerere[1] did and catch potential
>>>       mismerges, before committing the result to the index with a
>>>       separate `git add`.
>> Minor: should this adjacent be linkgit too? I thought yes, but on
>> second read we really are talking about the command.
>> Anyway, agreed that rerere should get linked. Thanks!
>=20
> If you are happy with the end result, I would not complain, but
> which _other_ potential thing were you wondering if it should
> acquire "linkgit:"?

Doh, typo: the =C2=AB git add =C2=BB as Kristoffer read my mind ;)=
