Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7B1B0439
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763225963; cv=none; b=fiO0GqaL44Lx6hO1KFko1GMrs0/v/zewqy1iwJf7c+B2J1WA6k/gcMlcUxbu1jdAvjRFxp4gmGrT40JS+5/kmu+Elg57EXwyqh91h5vqpmZYF3Xu2Fg2mSkOHOY3o0SlBsqX3wsQwoyHpACS5NvC3xWkjMhiOzum78B2TL47uhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763225963; c=relaxed/simple;
	bh=gEQa8/DEO8DytQq5vGlM+1Q9kmTvl4CAW9AJX7QW/X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4TLcKNemoBb+wzhbkawkN7URFlYiSqhONi2MQwNmR6SGi2uStduUqfaUvlCi12yS0Oc3c2bNTLcKn09tvstNzrt0keXPRpf5mSJNSUINxx2gMZc7LY0WV/my+WRh1JBibkBZgFvCiInle5/EUr7+eUEzkiO3e6wQrW0SZhU2YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAA7gncT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAA7gncT"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3437af8444cso3051460a91.2
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 08:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763225961; x=1763830761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP+ODB/m9iA7ir/xSI4Rdnn19EtE+JXX/Rqy1q03oo8=;
        b=dAA7gncT/TPE08tsbJud4UvZEWg7yU3FTz0JcebOOYWTqG/kIU7w8+bdn5PzKXGUJ1
         sOa4nfWVKNcgLNsBKczed5DPbpU9RF5x/jCDxLInulntdDpUBETGFQcyWxlQBayk06HW
         RlIsBJQYu2j4sTihxCOrxJKVsufBCZbDU+Zzi/Q569BYbua2NcQ7jiYhJHUe73PiVxYA
         BIZ5zgfO6KhvS7vqXx72/KRqPeXjzlvSBsaOZs41JEzhS5niboWcTeIg6iy2BT+Y+hE2
         Lp03BmulhNElSIrJyeGDLjsFLkYFgTLVSASkACOMkn4xLFg4BL1sCdkH12Pm2o2nQlox
         bE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763225961; x=1763830761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aP+ODB/m9iA7ir/xSI4Rdnn19EtE+JXX/Rqy1q03oo8=;
        b=VGIV4WMQWifMDi8gDRhsjJJc2MLExvA06UmOfNrwSO/JP9ZtHPwIlomcunotXYiloU
         BYvbi4tNVw6A+biQxMWgp3zQtBE2acVsSoV3+jO6ZvM2m/B3+l+z58+MeOAXaamCgXWL
         flpKaVNA9A5IBjiURZxvf4B8rCmvD8/mog5TWIG3pYzE/MtLV/LVJUuSdJbmmBEx72rC
         668+8Fpo0KH76b6SUVicAgnZsw+vyJNu4Ym1VGbqpNXE0pqGjiQq+7U/sZnLzx27yDwX
         c745jnK1J/UFozala10vy8dt10s4oAmmOeyJAb0EVTuZllDdAILmEyccPiLS6XxhJSGd
         vY2w==
X-Forwarded-Encrypted: i=1; AJvYcCVaXoD3BP5zXWkVeNrcY80Trf6GMUEL/NR7HjV2jwgzRT8bbqZYxNTr2UPpBMOR/EFP30o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxvs0jCccYZ626B0KAYPa9151sNVS11ACNP2ivYowbrfkWHP4Y
	YNdcjegNHCb17rl8s4ozEW2Rl61UJn7Imeze28i6+REOG8MiOzGVAFXAhl6CEHDVgM3ZuVL7UuC
	m4/dQHZ0k+5boiNV1HCCwtKyPNf6OOWE=
X-Gm-Gg: ASbGncvgx4WjM4+xILVStq8f4FOrOyKXYt5DsTJlm6SnQkATeVAawiHtzCb/2z6Mue5
	6CfelKuH2Vld9qk9TLPspgG6Nd3uXLydwJGfcj2nch7l8j9TXy+CieeJolSnJCnPs93QubMtyTi
	VMJrjJY9MXulC5uBsFgDfe+r48bM19IiM0ck4HThtm52qkf4CVl9SPoFVta2N7E7Jh8j7IBqvXg
	M7fyXw0DOtOR+cuR/78mKmr9W7gANFKdhAKSH3xy20dykgDrqZ+RiPz/nvPfi9QGc3yk9eGCEHz
	BUtcSf5rC4KpsiJTf3U=
X-Google-Smtp-Source: AGHT+IHL2xZirYdDLZv0Wifyjb3SQ3JHeb1VWpF0aPSaW+VVEQfK9Bjp9S2a+ZO7X6berc4/dIMPcztRU5ULVE18vZw=
X-Received: by 2002:a17:90b:17cc:b0:341:8c8e:38b5 with SMTP id
 98e67ed59e1d1-343fa74b8f0mr7322091a91.25.1763225961091; Sat, 15 Nov 2025
 08:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23b7fd8a-2b50-4da3-bc8a-3727ee99654f@ramsayjones.plus.com>
 <5A740EE4-D545-4828-8D38-E0E5E9F87A3E@gmail.com> <a30ad114-61c2-4eed-a24e-033b3b9d6d0c@ramsayjones.plus.com>
 <xmqqpl9jfdso.fsf@gitster.g>
In-Reply-To: <xmqqpl9jfdso.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 15 Nov 2025 11:59:08 -0500
X-Gm-Features: AWmQ_bmyT-RxJEdjObS5wULolt1pOTFwCxxWU8fHb9F5gQ75X33tvIJuU9LQmEk
Message-ID: <CALnO6CA-6waRpkqzLxR+f2yzwfhmf_jvbtEZC7FAFN9NLkqkXg@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] doc: define unambiguous type mappings across C
 and Rust
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Chris Torek <chris.torek@gmail.com>, 
	Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 11:42=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
> >> This was discussed briefly in replies to v2=E2=80=99s 2/10, where
> >> Ezekiel said that DEVELOPER=3D1 warned about sign issues whether
> >> char was compared to int or unsigned. [From mobile I cannot
> >> reliably paste the message ID or link and preserve a plain-text
> >> email, apologies for the oblique reference.]
> >
> > Err... sorry, but I don't see how this comment relates to my
> > email. puzzled! ;)
>
> Me neither, but I suspect it may mostly use of non-word "signless"
> that is the issue.  It is understandable for the -Wsign-compare
> warning (especially given that it very often complains about
> perfectly good pieces of code) to complain when you compare a "char"
> with a signed integer, saying "on a platform where 'char' is
> unsigned, you would be comparing signed and unsigned values with
> this expression", and at the same time complain when you compare a
> "char" with an unsigned integer, saying "on a platform where 'char'
> is signed...".

Agreed, and I suspect this is roughly the implementation.

My point was that Ezekiel seemed to justify (?) the use of "signless"
by pointing to those warnings (I personally am on the fence for how to
treat the combination of facts, but it seems useful to consider that
char is not easily comparable with integers of various signedness).

--=20
D. Ben Knoble
