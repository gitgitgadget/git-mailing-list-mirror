Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C029BDAA
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791571; cv=none; b=SfVtWNMOcg4rtii+0dsuAjHzksvlzWmwoBBHDb2jtsVrfI27x9cmxiAmdIFRh8Nq3jCMp79W773V5rOfSivzQsJvBm4Fh2lXElx5gchaK28av7mccouut8p1t7wTQUYKVXfGykDtGPVkd2ASR2PSHyBmnWTHBPWuvxp+kjU4y9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791571; c=relaxed/simple;
	bh=HdAa/TEObEvohWSWggM6E+4f6AcEFE+DHLESnLsCzio=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UXPq9masknuWGmyS+nMG2ThkEJ/vhvZj1WqsMtx1GOPWZeXPy9ytCPV1josu9byYl8MfbA5Cf54KsNkD9R4vKGdyAAh/sGsqJ7TZ7Hx4s2fs80fKRn7DvdsVgIc0yp0AF0YjbJoG0x4ymVHOmsp3qsR1H7UResu7DCg1PvPSptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW9T0SqS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW9T0SqS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so25876475e9.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 14:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785791568; x=1786396368; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+3hr08J4R7gjHmuroIrL+nRf/yKUDT5zIGRQe0Pyn/4=;
        b=SW9T0SqSIWHUuDqV32wIg0AtHi8/THiLTWpWcQ939cZIr/eKrzMnA8Z9lmsCuqPS0e
         kTSa3oZPcLnIdEB+duhqduvgaX/mEWARy2as22QH7t8nxJ8TFo/tSyzP4XRNYBXKnAoI
         hZgfMiyKfhNj6ZG8Jwd+VFJkveQ8TYP+u6zi01adx/orLe+Jf4GaRBjKo8et9btd/bSJ
         v7n/6NhkuQkU/xXxdPvZnVweQCiSsyeHZa68vGm/xAgZiUwY1ZpXx76rtUdy73SOEZQ0
         0NFKdqTQWsXK8bmsyyPADoxEjuMcCHCTfam4Qb9M3c2nA/+OvNjmtXRfiWKe0/Wc2uI6
         MSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791568; x=1786396368;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3hr08J4R7gjHmuroIrL+nRf/yKUDT5zIGRQe0Pyn/4=;
        b=DBegejOCX47c1xN2Fqo2OAX5E/Vj855+PRW76FrjljX9b/JOVPhyj8EQOwLx4/skBz
         Orxcwl6SV4rk5FJDevrH4uhGPctk0pXksHkMZbpzAmwuibgFodG84fVoSEDxSM6OXA56
         ejivfw2QqFFfh5A5eXxK4IWdoTaneXV3zW6JelqjP7q+N8PoYGLNxbmo2UEILfnxWuym
         PeawnnD34sufMBku3l+TDIXrvBwrjqbYR6nELUh1y1StwyLm5+TUBilw9cY7xFc1hvqj
         LmW6YQfvBt639E3CWNy6OgmXudT8QAfVqdb03WX4V4Vb7mKoq+snactiGAn5RM5Ge3is
         pTgg==
X-Gm-Message-State: AOJu0YxR8kKVNK+W1E0LNkhdfLDc+NdA23c5SqBb6d8pUvt1K6Tf4c9C
	A8rJixgledGAxytjAgFLMjiRWKXOAGYAJTzJ7zlLpqZmkBGs3jTxKYsfd2ugWxmw
X-Gm-Gg: AR+sD123BCKeAINKb4+ZBS64cjBdzzVU2L5tnhtgOEAS9QuOU2dz4+cB0O8VxOMAq9k
	tT4et5a2LWft/RFS/oObNt4u9muF4W8m6iM0oERQjA2BJcsrqXsZ/6233l2YxZsQ5kR3AO63pr5
	0rpqYqTsLlV2JmedpKJ6id2ncfZUOK5a9uQTkiAHz8IT+5/n2RCuHp+XwJ2DJn+Rg2cSvUjxrsT
	H+YqvGdN+BWVI7lCjHnz6dyy3IhmHCrmauVu9lQK2Wltd3k5ZUp0IKBetX7oETNOZRIBUlDuFCm
	9Yrmpy6AODGIwMs3ckgyFfNeRMGOq0+iIXSbbyd4qkB/h24Yed/4hvN728QW+OLG2g1byZpQAxa
	YhyZJXAPvdr+r3noUXhW8TUyAKT1ar9SZlKdmCwFUQ8pel5gBxAtFMND2D2HU+OWlr3q2CjlxXW
	u/sq/ERr0UVYPCVditC+uPDGttWtNxcQ9eDl/bMF9s/4oyQVP6xgpZMZGFQmSNYGUmIRpJzR3uv
	VN3sx6p7JsDNpTKRw961UTx7/lU9HwsbTfw/pWos4IBh+PWsFjFK+rGQjSP5cBotCZc7AlsGjGF
	rpZic9y4R9b9ED5b/K2nGbJihHDFQv5Dwib5qNQ2faN05itI1jyOurZxSR3b4NN/4HArAOTv+8A
	=
X-Received: by 2002:a05:600c:a45:b0:492:45a0:dcef with SMTP id 5b1f17b1804b1-4980c66d8a5mr224359465e9.5.1785791567805;
        Mon, 03 Aug 2026 14:12:47 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b4d8absm116561695e9.0.2026.08.03.14.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 14:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 23:12:46 +0200
Message-Id: <DKFM9ZZWDV6O.3GFN589ORNUZ0@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>
Subject: Re: [PATCH GSoC v3 1/8] t5701: use test_file_size() to get the size
 of a file
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
 <20260803-objecttype-support-v3-1-7176fecf7950@gmail.com>
 <xmqqbjbjyv9s.fsf@gitster.g>
In-Reply-To: <xmqqbjbjyv9s.fsf@gitster.g>

On Mon Aug 3, 2026 at 7:21 PM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> The 'basics of object-info' test runs 'wc -c | xargs' twice to get the
>> size of two.t. The pipe to xargs is only there to strip the blanks
>> that some platforms pad the output of wc with.
>>
>> Use the test_file_size() helper, which outputs the size directly, and
>> store the result in a variable. Because 'git rev-parse two:two.t' is
>> also run twice, store its output in a variable as well.
>
> It also has the benefit of retaining the exit status from commands
> run inside a $( ... ) construct placed within a HERE-document.
> Earlier, if your "git rev-parse" failed, you would not have noticed
> it directly (though you would probably have seen the "expect" file
> containing unexpected content).  Now your assignment fails when you
> compute two_oid, if your "git rev-parse" segfaults.

I will add that next reroll.

Thanks,
Pablo
