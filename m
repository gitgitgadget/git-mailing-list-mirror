Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15CB42A91
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556080; cv=none; b=bBiXSdROOcL/3BTaQUrvkSLYq92AySsuxsWkkZ03z4qwZiPrALlrxYfm53lu1+w07W1+VoKeyM4bnKQ/vf4T2nKSZb91UObv/hKNxfvjUzqWb1Y96CQgfQrILm1FYIaKvRILrFIcqbzouyu/WgZ9mI0Bu6RB0MJWEt7hyGhWzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556080; c=relaxed/simple;
	bh=GuA4Yxy5BLxopCUeK0NTA7Is/afu0mSE0dhDft2ypnA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kWf33/O6MHx9vBZVUPsl4I7Tqzr6OPLG5IX8aN5XqAMTZntSV3fkvTchpHaPMRTp7tJ7X5uePkz4CY5w1az7ltB3CIrHeZhr2PTiacrek4+2SXxhx4oIAhblrOz4GkAd5oLZSTA9AEqx5EDcSDDDkyKg7czG8LWJEYPe5/Gz+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esCAL0L2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esCAL0L2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-414978a4a64so2269405e9.2
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711556077; x=1712160877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yA7lzhplfYzKoy5ceT7syJLTzVwz3jS4LAYXQFgwBWk=;
        b=esCAL0L2xLMcXK/rv23L/LU8bnEe24GTXoRScOdW0gZv7AjXYIuFN1UZBDL22zKM72
         C4rKy1jzrf+w464flbPgeyt6dMTDbqMZPZcejqIGQHSvF6iHQJgsCWocAS8EKmNTDYeC
         fhgI920dwmisFaYK3zUKNyKz+O4b++8pB7RTR9bwJ5qx6ji13THJ3p/TmODNH3zdCUZs
         qhgo2QfPAVH58mxAQU2DNxmG+erpB3T1P4By8S7OkXYRya2p9XYETo/QYAfMCCXQ5u7A
         tOlzL8DQZBDQUc/HiJgmLH0XbGemjG7scm4lt57DcY9NcxbKAp37LlU4QWQUtXAEGoFm
         CcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556077; x=1712160877;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yA7lzhplfYzKoy5ceT7syJLTzVwz3jS4LAYXQFgwBWk=;
        b=GUpZxQPuCia1bL5fJ8+PqvVzHcIuFqK/3Uf4wDJw6ruqMj3kQlWmdUc/EGnFF/k2FV
         WsYGzEdoDTKcL9gNvt86HX3B4T6k0M3eItO3GRRqnv1pQ5bS5UHBNRbCeILRUBSoIt2P
         zWP+rJST50/0KSVuRPh+1e4fMsKJoWeyiNJd6iZGKKEczEnYm6j9uHQsspxvfyQ+NNPR
         DnaOHK6f3FXuBa+2cXk7pEYS7hd0y73mUNoCmixs938md2jnGKB2y8qQIt95nyVTJvMQ
         0XMtx3lnUd6eBhPSttKVWtVTP7P5MA+Q+rVc1JRpqlT+JanBVgtFInWl9hi+9eLfnGVA
         7fCg==
X-Forwarded-Encrypted: i=1; AJvYcCWCJc6swKNvu8QQYbmwBWL2gC4+asIDaIZAldbdehn77SJiNInKLWvOc3V4UKXLCjCRH3LHP30TdIdq0f0zqkgo974+
X-Gm-Message-State: AOJu0Ywo1lnknZEmDLpAtUuJ00ce1PX9h4x8wYSEIV6blXtp+jt+/GZ5
	7QJa31HXI1GPogT2UTZOh+e3OCdSME13H7uWsM1iVfL7l7NWPh11
X-Google-Smtp-Source: AGHT+IES0G5GkG4jluICNP3kBdB3sX4v5OFoEUc4RTn6iDE/lAs2YmF4zEYar3gUXz5jzKST2jxPcg==
X-Received: by 2002:a05:600c:3c99:b0:414:88a2:fb7b with SMTP id bg25-20020a05600c3c9900b0041488a2fb7bmr354545wmb.11.1711556077175;
        Wed, 27 Mar 2024 09:14:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm2567655wms.20.2024.03.27.09.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:14:36 -0700 (PDT)
Message-ID: <c1aa4948-ef2b-470e-896a-1e7ea35d11cc@gmail.com>
Date: Wed, 27 Mar 2024 16:14:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] improve interactive-patch
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com> <xmqq5xx9dn6q.fsf@gitster.g>
 <8a05d7f7-6d94-4228-9507-d3af44f100e7@gmail.com> <xmqqttkr3ckz.fsf@gitster.g>
In-Reply-To: <xmqqttkr3ckz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2024 15:43, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> ... My
>> reasoning was that 'p' does not do anything useful for the user, if
>> they press it they end up with exactly the same content being printed
>> to the screen ...
> 
> Actually I do not agree that it necessarily is useless that the same
> content is shown.  Especially since we do not page, it is plausible
> for a user, who saw a huge hunk, to want to tweak terminal setting
> and raise scrollbuffer size (which may be set to 0 for usual
> sessions, like me), and say "please show it again".  Or even in a
> more primitive environment, just say "please show it again" and
> immediately type \C-s to stop while the early part of the hunk is
> shown ;-).

Good point, I'd not thought of that - it is useful after all.

> Thinking about the name of the option again, if we are omitting to
> show a hunk in some situations, the request to ask for the current
> hunk to be shown is "please show me", not "please reshow me", so the
> verb 'print' may apply to wider situations than the verb 'reprint',
> strictly speaking.

We're only omitting to show the hunk if we've already shown it so I 
think of it as showing it again but I don't mind much either way.

Thanks

Phillip
