Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941715099B
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776978; cv=none; b=c9BFRcbHsszyaRNgy0fIoESlvKvP5gsrmudQskcgH9aPiKSQT69poHYcZnvZC6livhfiW6WKTZ1P9MGYh1Jnz1yHZwyg9LFC5DCip1bC0rIS+49DGRCJz7+VLU0x/XOdeuF4blchf/q30c7ha+hVax8thmJLi46R+a1CXg1bARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776978; c=relaxed/simple;
	bh=xwIZlreHzwHQpPh/nKqaqrrN1lbECqqf5T5shyMuVNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8Ow1VEwkMIpvm/a8W4caJI2BGQh7I1NtQ0Ru/r/dylhNWPKB78I7dHyWy+pAuvOdwuJ9VXUeZZJOGXULFgM67T9kffIKwXT1/GKWrCo2Ei4lNf5suA1OoY7/MQZpO/BxgVIOyWG1MRf2qxR430smjUHzUCBsQCXYtJPzKCG0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBcaoE/D; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBcaoE/D"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d4979b843so770087766b.3
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727776975; x=1728381775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VKDMN2TlXd29OdkItal9sTt/DsX9JIPZsuegL+BzUPA=;
        b=XBcaoE/D+mSArmqGWgnNlB/fB4TLhAtZhs8xp/3hQ58cI4oj0QquGY2ar0R9AcEsD6
         IHqJRZjvX4g1zejoqhN3yfPqmj8VhP79osesDnvqKOF2dUWnLVGhrMRmRASOxI2MUGrG
         RrNVR0rNDo0+pRtvp3svhWSDvE3o1IzbcIlESba6KKADWu1Ssb1YzTmqYfkzzJXGZUV8
         EKlC3YVi2xNA7WR8Jw8I9LZWKdX9oTlhHL/Crjk1MTAvAyu09htElwx9iMS0R6xEJGEC
         QsPcJZz4/f4fKOo4ZPbYRXaC8FxIoQDSNfZhvWnpTiWQcUGvAwICSGxMe8+9M++7ZXj5
         QIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776975; x=1728381775;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKDMN2TlXd29OdkItal9sTt/DsX9JIPZsuegL+BzUPA=;
        b=tRcO7ZPG9jRE31NXl/QuyxGQu1kfL0AHYSo0OYeHfb5DqFrYFocHNtbb4NZjSTIb42
         60QS48eFK78GyRQiBlN9ImDqSPoB71BT9TVqg1rUKhqWTwYz2s87AKZoyrWhFK8bLvQg
         bM5KvWjF6WAMq8w+fMkkZIf/13mJMVKrYAAcQeGiNXKyyfMSh0UUK/QiWy65TDnAIpst
         2FUIFwBXI3GtRzBF+lQ4fBoREBCRO4UmlsdHY3tR9OGoWkBfj/LLXl2neC79dQZapKIm
         Bo+fY+AtS2WpWnAhhK1w657DP3kO93JWd9RjkCM/sJrxff+5Alr/Qv8u/K6pGRBBCnCr
         Qsqw==
X-Forwarded-Encrypted: i=1; AJvYcCWoQ1C3Z0bMDLY86Kgys+b1bYLNRuobzXJ+YPVv4YId24TgCCuUqpYEuVwcH1gKSuSJGHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfV51Cs3OIYC7T2Y3/71lXD2aYp8QICl5kYVWyNkrnCMyHB5Q
	PSE9jrLNvpX4a2ek6fIZ36D1KbY6DcPDgva0kCoSlgsvKQgKlmQ+
X-Google-Smtp-Source: AGHT+IFAAA7pEqK6gmIs2XyxPu5+kbHQU3K8sQ8Mdp2apzbzLodgIkj9iADQubIljrhV02wPfxXJ/w==
X-Received: by 2002:a17:907:9492:b0:a7a:8da1:eb00 with SMTP id a640c23a62f3a-a93c48f6ea4mr1703569066b.7.1727776974562;
        Tue, 01 Oct 2024 03:02:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bc88sm692235566b.177.2024.10.01.03.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 03:02:54 -0700 (PDT)
Message-ID: <556ba87e-1eee-438d-848f-bbc5558289fe@gmail.com>
Date: Tue, 1 Oct 2024 11:02:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] add-patch: edit the hunk again
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <4dd5a2c7-26a8-470f-b651-e1fe2d1dbcec@gmail.com>
 <2ad1f7b1-714c-4d6e-89a6-fd65271222b9@gmail.com>
 <6f392446-10b4-4074-a993-97ac444275f8@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <6f392446-10b4-4074-a993-97ac444275f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 24/09/2024 23:54, Rubén Justo wrote:
> On Mon, Sep 23, 2024 at 10:07:08AM +0100, phillip.wood123@gmail.com wrote:
 >
> So, to me, it seems sensible to let the user review the faulty patch,
> even if it's only to discard it.

I agree we could add that option but not as the default

>>> If they really want to start over with a fresh patch they still can
>>> say "no" to cancel the "edit" and start anew [*].
>>
>> This is not very obvious to the user,
> 
> It has been so for a decade...

That does not make it obvious though

> Keep in mind that this message will probably only be shown very _very_
> rarely to users who are most likely very familiar with (e)dit.

I'd argue that users who are not familiar with (e)dit are more likely to 
make mistakes when editing hunks and are less likely to be able to fix them.

>>> +
>>> +	recolor_hunk(s, hunk);
>>> +
>>
>> This means we're now forking an external process when there is no hunk to
>> color. It would be better to avoid that by leaving this code where it was
>> and restoring the backup hunk above.
> 
> I don't see that external process. ¿?

Oh sorry, I thought we ran interactive.diffFilter on the edited hunk, 
but we don't. I'll try and find time to fix that.

>> This is still missing "n q". Apart from that the test is looking good.
> 
> I've been resisting the idea of "completeness", because I think "e y"
> should also be fine.  But I'm not going to resist anymore here :-),
> since I don't think the test has much more value without "n q".  So
> I'll add it.

The reason I think we should have it is that the tests ought to be 
testing realistic user input and not rely on getting EOF which is 
unlikely to happen in real life.

Best Wishes

Phillip

