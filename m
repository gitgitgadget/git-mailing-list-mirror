Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5912DDB3
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557455; cv=none; b=G0eWJT1u0YRiQmmgRUE4+bqVfvXsIMBo+EK3yZVER4GV0uNvCRkciZno7poGWc+woxGliLRqgZBMPDvPFcPaSnBiOFACerJcrTEeXEBFXS7Z6TGKO07mwafxJ75MVioeSRrHOD7zMjgFKoFcaaPOi8l4OebDUFZRMblNl3HZXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557455; c=relaxed/simple;
	bh=4wHxlQrzEzzbchLzWYSbttmJx+/tTrKQeJDtlcFRbX8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dnSBgmFHTd2uSawDsT9Brkpxuv83Z5WhRZcBZaSUaPepS32/NOLPTbtQMNBkjoDpQRmoV8t++v3SgSc6yAi31aw5snsWVEH61cQ2JaLl29jtVPAAF7NJ1L+CwgxtTWFLX5lekkPvUJtoEA0Y+IcaCKXEuMmHswH9af1bS5ZrAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPNHTXCY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPNHTXCY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3416a975840so5261713f8f.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557452; x=1712162252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZ0qrE8U6XFvlr4d8LERulMjhld8e14yPICl8zwK9hk=;
        b=XPNHTXCYw+StV1jlsXbKe9FZR8ZyqGrpxLy0Fyv9e5vqsmr5S7hud1pmtuUd46cSOn
         KIG74QnPB90aU8MXUaTbFx7szCwsKmuO0gx4NkdL0VupJRGNmZVQO7+w/o5G7n0B0+Sl
         95PUU6L5ND7p4P9gOVHE2EImedbo6UkX22WkgC30uOgwmKfpUCj9kVzPhF6JUWW4EaK1
         uOnt7EgzqtA21pmV07emJPLm6WxbMaN4Y//9C9R4ClHp5aozjmiVEagciWUVVrA5Fmts
         eEpY9TvWCiJ5HbaHPpVZG344VgrytBPBKDsYNxqQ8Yeenf/5P3UKaHbV6sT/1iEc7fgy
         6kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557452; x=1712162252;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ0qrE8U6XFvlr4d8LERulMjhld8e14yPICl8zwK9hk=;
        b=GLhOEueC2TxOSm9TF/iKmA5Mqq0NKEeMWNKK5ogcvAR5wqOK550MPL1HFERy4ddM9A
         Ef0V4hMEW4IVgXGA7z11iI3tMB0dsASJn8up2sE1C3m1InQ3s/Vujz03eqvOcLPeEDjb
         pbGvu27CdanmnhExSP38EYp/RUb5grUrzwj+x4evWXvMsfZp4yfPhNIpH22kNKYyskNP
         Zct4brwZ6vcPL2Pqtq0jxAypitFM2fZuqXhaYISMAGo73ue5BuctCksPyNAbSPOC37EJ
         2belVYBNHH993qrUPf4vumDlWZAUowigRiSvk62ernG14m5TKyuVhlESMNSDkVXQ/qDI
         V7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLtk3DB5PKZ7Z3CRNqrj6AvNYkr4/9qa3kBjnohOatur2cSH4cOfHBIohM8A1k8sPR13+1kuBBlQ23qfoWgQrZXD/p
X-Gm-Message-State: AOJu0YwohOVmynORtR3qiKX8XOHROnHMFdEKq3NWfeH2Bu1ihr95eXci
	zbNaR0uaUckPvHZAcFBCje65wILbvQXLHIzkSu1XQ+v6eMaw5kgv
X-Google-Smtp-Source: AGHT+IHy4nYCJcetC7/dk8+Wn316EmZ6a3jWaIc9R51IGtkDI6y/18imP+nYN5Ozrkw1RUfO5TlHaA==
X-Received: by 2002:adf:e803:0:b0:33d:a011:ae42 with SMTP id o3-20020adfe803000000b0033da011ae42mr299755wrm.38.1711557451908;
        Wed, 27 Mar 2024 09:37:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id q2-20020adfcd82000000b0033e7603987dsm15315954wrj.12.2024.03.27.09.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:37:31 -0700 (PDT)
Message-ID: <b952aee0-68f8-4df0-be40-109b28f4383f@gmail.com>
Date: Wed, 27 Mar 2024 16:37:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
To: Junio C Hamano <gitster@pobox.com>
Cc: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org,
 newren@gmail.com, me@ttaylorr.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240325232451.963946-1-brianmlyles@gmail.com>
 <a397f3dd-e4e1-4275-b17d-1daca9e166fe@gmail.com> <xmqqplvgalud.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqplvgalud.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2024 18:28, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>> Hi Brian
>> ...
>>>        +		head_commit = lookup_commit(r, &head_oid);
>>
>> This version is definitely more readable, thanks
>>
>> ...
>>
>> This looks strange, but if I do a range-diff locally from v4 to v5 I
>> only see the line wrapping changes above so I don't think it is
>> anything to worry about.
>>
>> Thanks for working on this
> 
> So, I take it as an Ack from the person who acted as the main
> reviewer for this series? 

Yes I'm happy

> If so, I'll mark the topic for 'next'.

Excellent

> Tanks, both of you.  The resulting series does look very good.

All credit to Brian - it has been a well structured and well written 
series since the first iteration.

Best Wishes

Phillip
