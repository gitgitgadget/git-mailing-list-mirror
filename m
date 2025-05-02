Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F91A2630
	for <git@vger.kernel.org>; Fri,  2 May 2025 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206010; cv=none; b=b7ig0Q7TPXvUvvN7Q6ImsrcrQl7LW/r8cV/eBEKN/+Z1M9pa6+j4LI8a01x1VkjBodRWtectr0Yt1X+PkudZeyioBoqKQaW+trJLk7PB8Kk078/0bcgXaibNc97UlodNrAgSg+5Ji6dBeBi6EE36kC3unqqiMJ8bueEaegcH4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206010; c=relaxed/simple;
	bh=6+gcNI2BswmqSgtgvudv4/fIsMywKMHF7EM2jkILBMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltAEGoAMs7GI1ExgR17zO8KQyrVrzqz+mhL1Axiv4CEYyCdx+evBHMZbnswHMoo7eDwFjt8aBgnETmGoyYRYA4NOYt4Xva97u2G51XAvKSqhfQkfz+YeiaPoRyEodhzOffBP+wCOyEEoeAAPztXgj/ghQr2Zct4JylYYdm4yFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCL3bzBp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCL3bzBp"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549967c72bcso2505162e87.3
        for <git@vger.kernel.org>; Fri, 02 May 2025 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746206006; x=1746810806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/t8AqFcol9VHoAHAiKk9bl4f5/VGEJ22yqNJNYN0oc=;
        b=KCL3bzBpIB1fzg0FimBPMEqQDNeQo6LAtJ7TnYE+vVtPNmL5wyKTwMdJMkXcIP+mge
         wbOYz9ZR/bUxAtQg7NBnTS9ZK1yAaDi03n3c0aFuZAeGA2kc0Zx0SKypEe9ZyYlcgUhe
         6DUSmSsp3edSWeoaZMeUmnM07oZeWahR+WK9AY/MDhECTQ/Eb79deWn3WlvPsrc4jz63
         1+iDpxHx/Q5KOhnG1daum/7ffvScDgn7/5ag/7Ytxst85hjN/TUZDA9jvL1FSizq7zIZ
         eQZM0LpMRHou0ZG81IXX6zAYCItCiwSBH/n8BqAKa8a4vTFi2OVlmIEqE69n+V1dffWx
         H3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746206006; x=1746810806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/t8AqFcol9VHoAHAiKk9bl4f5/VGEJ22yqNJNYN0oc=;
        b=Btv0XzGSnwt7U5ZvNfNu4FwqWxw6TqtOmZU8O0G2S2Vb24ywTS9SGIKqNMdB28I408
         ODNjBmgfAndaL5CCf6EDxtSwYrRvwt+eKxBGuKPLDvqc2V121zzEkCXcLMJ9VN1O0csR
         Qi9DL0OR9VNYftmUG31UwjZoBzD0IdStN9LfRoPbGhVYy6nPcmDbZ69aLYuPeYCiw5vw
         lC6YuRX9llez7Cjx/10hU3oUx9OpzYeL+H5Nnt8scWrmF0Y3742jTazLKKwYNzv2p4lh
         iCo82UFMlp6eEJ33QgIc5fZ4o2aNNgYaheB/r86hoHfQL/cuMWfxgh282jLozdErfflP
         sLHA==
X-Gm-Message-State: AOJu0YygyIGRkMpmu9q7oGSE8/YF9mCAegHEkaZE7znzRrA8waGN4x1c
	KmgioyAGl5rC6wWZIMEG0RbXsgOglYctW3Uvhe6YGmaf1pLvXZMK1x+tR7EKYTpEN52Ww4Cfnt3
	Ecq5KV++z3PVjEcZW1WfrwyjDbGk=
X-Gm-Gg: ASbGnctjxjn/8tGYH1FV2cCAJVhMkffez9P+GUYBc131yQFd+XAlX6jKGg/8se5Gbb7
	6/E/WlQ/1meL+EYpsI6PkzFz84WKr4cPrLG7X05KIjGjEYFoHO1WCTXh1/JpIVuOYNDAjtNxSUq
	zIp4mG3W8irNN51YDGL1bOBhF0VHzIaUSuDAQ6tczmrcu187elOyCl
X-Google-Smtp-Source: AGHT+IEe7qkbrJVXrP+ecpLnv6Pxo9ierYO7nex/jsPtN01XaMHinjXcQyL7/66ZgtEHiAp+iYAKm5lnXu33OAOUl30=
X-Received: by 2002:a05:6512:e93:b0:54b:117c:a3b6 with SMTP id
 2adb3069b0e04-54eac2394ebmr1007349e87.56.1746206006132; Fri, 02 May 2025
 10:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
 <bf7f6606-e719-4c3d-b7ab-ef7351f66f37@gmail.com> <CAP9jKjG+khoUmRpVJ8om-bs_qjB=VFCj3p3h0VSaBHVnqPLNVg@mail.gmail.com>
 <xmqqfrhnuf06.fsf@gitster.g>
In-Reply-To: <xmqqfrhnuf06.fsf@gitster.g>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Fri, 2 May 2025 18:13:15 +0100
X-Gm-Features: ATxdqUHPADSTmL4hh7Lj2SxQXq725jR7k4Iy41iK7DUFTJ5tnQXq3y4HkijszZw
Message-ID: <CAP9jKjEbb_ABmGmLNwn=ruh+BOR73QDqtzF-cCYv40cE47fEGQ@mail.gmail.com>
Subject: Re: Discussion for interactive --patch commands to get --unified support
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

This is what I have been using currently although the perfectionist in
me says that a user could pass `--unified=-1` and the code would treat
that as if nothing was passed by the user.

In practice, I guess this doesn't really matter. I think that was
probably a needed sanity check, thanks

On Fri, 2 May 2025, 17:57 Junio C Hamano, <gitster@pobox.com> wrote:
>
> Leon Michalak <leonmichalak6@gmail.com> writes:
>
> > Inheriting the diff.context setting is what scratches my itch the most, although
> > also being able to set the context in the command list of `add -i`
> > sounds interesting too. Personally, I don't think I would use the
> > command line overrides too much myself as most of the time (like with
> > diff) I'd like to set the option and forget it but it does have a
> > certain consistency to it.
>
> Sounds good.
>
> > Slightly off-topic to the discussion, but does anyone have advice on
> > how to deal with providing a sentinel value for something like
> > context?
>
> Seeing in diff.c
>
>     static int diff_context_default = 3;
>     static int diff_interhunk_context_default;
>
> that they are of signed type, and negative context would not make
> sense (would it???), wouldn't -1 be a good "they haven't touched
> this from the command line or configuration" value?
