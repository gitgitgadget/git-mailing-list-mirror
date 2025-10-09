Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E617BA6
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759973352; cv=none; b=dAuuAKeOamA5RYMhO6Hb1BRlwMQm8xNQlA27vGjB4PK7sUceXVT+HQq4eSo6zfAMTIwvJLpx5nUDXtSTjTPI22KZ7zVCYBg4Aj9oVtaLBHao7hCPSBlgKgshOPPmtL7iWxzFMSZejZdQDK66NCJ59n0pTA+eNzUL2OglG+BCBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759973352; c=relaxed/simple;
	bh=DE75jolDT2MHEyZGFEFBJee+9DmHhG6LqZDuf4PG9H8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BW1Q9qv57lzUwsVqDiV4GKHHgqKgxftZGoZlbYuEty0niVjppIfQN5cbycFG3AyM3dOMxyOfRJKO7AcnO8ksiuif/+tSH+4gmfHgSqmwbeWb6WK6aoAsUS4VNP44XUtp+2VQn0In9vp0bqxAfs5YcP4xI2KQHTdc0rjuOKMNPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLOqCVjz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLOqCVjz"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-796f9a8a088so66003b3a.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 18:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759973349; x=1760578149; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9bE56lo9o6gRry9DE+Bs59RQdYNBsYNt0RgmwY0x4g=;
        b=OLOqCVjzD1VBIuvnS20fBvbKQGFg0dT1pEdiwgv6tnGJOAUNsykaR1p4+GTdJ3bcl0
         WvQvQNghl74SygThlPYcrTl7SktldKfDdD8d9tcL7/wwo0KWFVOYz/Wtt2ODOGEt8pnF
         VrR0CECkTQggAQZQx6eb+Y0LhTtoEIJPOPB+bTtxiJC2CsQoeFFbpDWDV6ghiHUZ42Tx
         e3vHNFvZ9LCc4D4tut4ZrbTCn7Fp2SqoPqIGynabLa3tByZyyPDHEI4QqzygDIO6aw79
         cRwCXd2YEdK4Nf4y2soxBh5D5YL/eY0E0rIZ+MEZP2z8LN/rwQ1EZaLIbejd0KG0Bbt1
         Ow+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759973349; x=1760578149;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9bE56lo9o6gRry9DE+Bs59RQdYNBsYNt0RgmwY0x4g=;
        b=dCN9Avhl47wyhv6CCzVfothaFs00iioTRXJvrLd9eNjGd5mw804BGUXj7quY8zHOBY
         5vjLmVdgL4zuwSgAIjjRA1/WLPuw1/DasiMBGtI1sAJiLUQLCio8WtAWcsciUJY3SHTW
         wWqbdD0f02KB3bcGFpedGob7irR0iMfWgv9fHnaaxlBJgvc5V7TljRyiRUmElMeXQ8n/
         bPj6+pEf7isw0pjckFvzoI0FX+yXTZXQFMb48Hbmxi2kAwTkN0BJN4ZZC3Wn8XVu04w1
         VLHJHXkmOca3EFxpKZc6pruUUbORQgIOWWMwIiAX9+IbQiAh4Oi0Sdn6e+zKGLcdSh0y
         GqYA==
X-Forwarded-Encrypted: i=1; AJvYcCXgP14f600EW5benK8cM518jBoQDVleLYR/zpO96brHwcf5W1o+IiNXD9YVPXyQDpTKTgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0ABuIS4ncG2ZI+Kj883DFrlcMRXBIJfiYuXZW38kUZDKsgOe
	Bc9QxfS2MoEnSJtLQMA3C4KL3mi/Jv536et27yeTc1QCP4NK3Tbf7flN
X-Gm-Gg: ASbGncsKt2Mv0ILt55nDmxbRSy2LolNu1U/GCO+7LU5kaxPboyTfEQbVyhFhQUMsoRt
	nllo7OUGC+ET+2Dm93+SK8MI31laXGQzjqSY2TcHd8gkSWZQQRRZpHw6jv8WiLuHFvN3nOnWFKc
	R8DwZwTlo8bNPtWTZfhT9HhRkcpegsZAmT1z27xuwzBeLu/O3tThQsChvszmOJ3fLwF4BnwYz5d
	tL+Impfvtlne4xL3xKi1QWgNnj0GakTHMxVAJobNX6EbofkVvSlhqKthn/0QtV91WVLiXaoXwNX
	o6avU/eaoTvZzyL+JSPz3BxKxvKp7Gzq/CeqhFNKLXtmeSrENxYfR0Xe3hAPLy8p9cuCEv1PEZr
	GxXZ9kxVViv19kyy3+h37lExfc9Ax/85utLFwrU23T8ZF1lgNig==
X-Google-Smtp-Source: AGHT+IFPAZYOShK1plX5ue4QIH9mU3wjPpyyxIL7NNr5MCa2vGPurBCnuYv9X9bWj9vsip7Qvc/efQ==
X-Received: by 2002:a05:6a00:1741:b0:781:17ee:610 with SMTP id d2e1a72fcca58-79386e51022mr7580692b3a.17.1759973349094;
        Wed, 08 Oct 2025 18:29:09 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::e735])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e34e57bcsm1023429b3a.85.2025.10.08.18.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:29:08 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Junio C Hamano
 <gitster@pobox.com>,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/5] lib-gpg: allow tests with the GPGSM prereq first
In-Reply-To: <CAP8UFD2VRfZuaycCdWt4kpVpRv_UhNHdzqJ2vL8uyKJusUttnA@mail.gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
	<20251007122958.1089680-3-christian.couder@gmail.com>
	<aOYPTKG9t4ZB_Mbi@pks.im>
	<CAP8UFD2VRfZuaycCdWt4kpVpRv_UhNHdzqJ2vL8uyKJusUttnA@mail.gmail.com>
Date: Wed, 08 Oct 2025 18:29:07 -0700
Message-ID: <871pncdfrw.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> Okay. I wonder why we even have to create the directory manually. We
>> don't do it in the GPGSM prereq either, as gpgsm seems to handle this
>> for us.
>
> Yeah, the GPGSSH prereq does `mkdir -p "$GNUPGHOME"`, but not the GPGSM prereq.
>
>> Doesn't `gpg --homedir ... --import` create the home directory
>> in a similar way?
>
> I am not sure. It might depend on the gpg version. Or maybe gpgsm
>  does it but not gpg. I will check.

If $GNUPGHOME or --homedir is the default (usually ~/.gnupg) gets
created by 'gpg' and 'gpgsm':

    $ ls ~/.gnupg
    ls: cannot access '/root/.gnupg': No such file or directory
    $ gpgsm
    gpgsm: directory '/root/.gnupg' created
    gpgsm: invalid command (there is no implicit command)
    $ rm -rf ~/.gnupg && gpg
    gpg: directory '/root/.gnupg' created
    [...]

If it is not the default then it will not be created:

    $ GNUPGHOME=$HOME/test gpgsm
    gpgsm: keyblock resource '/root/test/pubring.kbx': No such file or directory
    $ GNUPGHOME=$HOME/test gpg
    gpg: keyblock resource '/root/test/pubring.kbx': No such file or directory

Collin
