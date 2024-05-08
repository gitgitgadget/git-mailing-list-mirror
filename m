Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C09127B54
	for <git@vger.kernel.org>; Wed,  8 May 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181952; cv=none; b=pamOl/tn0pmIeiljkrNmCVBGwkztD2hIEzNzGY+bjkmRQrtDm7JijfsENERvLkJe0mhckyOaYLZcI2qdHAeCnib2LFqQyNUH/7Z3vkLAQHpMf3oPjhf8S4Yl0+bjk9m/mz5+qeFI0kjPzY1mtL+Va7meiyiS3hrt2hRIfrkNpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181952; c=relaxed/simple;
	bh=kWDRAEDdswK4DsdeftQrIwjtDL2G6zBZdyNNGGyS0jM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VGoINaRwdZAweIeesQ0UKyQ823Wo+sQ2s64bbaRK2yd5fr8pHAA4oOhA0/YGzN5fhpR2SsMDDIhzDAfSStAvx9/I7wZE1NSDMrOckpn8yiOHlu5hxQ8XG0Nu4rRKP/qbfiaf9vOSTIqz7I6DM1bXjRLDgc7n1bwLMW9876oDGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxMf1AYc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxMf1AYc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34d8d11a523so2236033f8f.2
        for <git@vger.kernel.org>; Wed, 08 May 2024 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715181949; x=1715786749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySDaeDC3Fcc2ASPzE4UW2CZ2WD8l1+ESg30/FGXUfK4=;
        b=VxMf1AYctXPtyH3jqxY/EN9R+CJpnky6VvQnrTF49JnulvdLwkc20o2unqLYdcc5au
         3Tf+YnU1ABo4+WpaN3TlvOx/MiGWLKBNK+Rmkmi3VpLnY22evI49zKFIEwPWwT5iErls
         Xxwj95fgW3XIi91PvDnTBbNGHUc4nSh9vbgvGOE8NgXcvayKqEAz5D2ZoOm8ZgG+8hnB
         dCgSehDwdAbh2RFTuSxG//9QbAiGfzaNTiPfQxwgnRDf0wmmllqQNEcKQm3YspQCW5w2
         CFn0cXESrt+tQWAowXEeD5lznzkt4ZsvEgs5f6YvxuapWjIt5sOkyxlifWrh/eOAmd3i
         GHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181949; x=1715786749;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySDaeDC3Fcc2ASPzE4UW2CZ2WD8l1+ESg30/FGXUfK4=;
        b=OMBhbUb6aHQa96C3QKXGChiAwOq67xYUKSenRaojSygXI3zDs+vrPDiBKMhr8XHtKK
         EA5J8Gg+y+bGcHUiWcCMhsoxU0krRaybEfV+fvWqlCChIX9tZmp2+SKEXzjFxudw4iu4
         TSWVaYG/p1H+9+3dh5QeaPkjfuIvayhc+IQYX0Ypa7+v8YYx1sNaTPXl63iqYtpmc4/1
         3pSRMEhJLB/KKikp6ZnR30HPWXO3i86OYrh+myZJGJa+l+YlQvb6CUIMgCBMAelP9Wme
         JTnopEaTLmjXRb6P8h3mlcsOpGGLY5F83Jb24jyRfZU1bvfrPxtq381117qG2WUy4T7l
         3sBA==
X-Forwarded-Encrypted: i=1; AJvYcCVG0k4fXMxbnuxUSDzxyNlusiOHnbvCLtkJQMugvhr83t3l06QNq6tqG2eeFo+LVmY+HAE426JIQSfFNesmmMpKPBw1
X-Gm-Message-State: AOJu0YyF9Vhj2aq+HTqzJZaclaD0f3ajXyjU2mKWBVSEx0zIr/06jFB4
	/yyL2St0TmBcVv6AVKNSBBdYflR1KHcVaniFXqGOXYscWUUw+9Gj
X-Google-Smtp-Source: AGHT+IEjUqQgUCHVubw0Lr+cVd0FxrhHedrq0hx5FZ8M+2HV8qJyE/uWLT/sC2Hc7F/WMz8CF3X63Q==
X-Received: by 2002:adf:f34b:0:b0:349:8510:76b0 with SMTP id ffacd0b85a97d-34fca243df6mr2060249f8f.30.1715181948875;
        Wed, 08 May 2024 08:25:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4988000000b0034cceee9051sm15506435wrq.105.2024.05.08.08.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 08:25:48 -0700 (PDT)
Message-ID: <539926ac-4274-4b4b-a2ee-aa48af791124@gmail.com>
Date: Wed, 8 May 2024 16:25:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] diff: fix --exit-code with external diff
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 German Lashevich <german.lashevich@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <99337bc2-a691-45f7-9b6f-74ededbd9a78@gmail.com>
 <4bf12c41-a6ea-4939-ba76-e2c784952eaa@web.de>
Content-Language: en-US
In-Reply-To: <4bf12c41-a6ea-4939-ba76-e2c784952eaa@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 06/05/2024 19:23, René Scharfe wrote:
> Am 05.05.24 um 17:25 schrieb Phillip Wood:
>> Merge strategies are expected to exit 0 on success, 1 when there are
>> conflicts and another non-zero value for other errors - it would be
>> nice to do something similar here where 1 means "there were
>> differences" but it is probably too late to do that without a config
>> value to indicate that we should trust the exit code.
> Right, such a diff command protocol v2 would not need to pipe the
> output through an inspection loop.  Sounds like a good idea.  It's
> unfortunate that it would increase the configuration surface, which is
> not in an acute need to expand.  We could advertise the new option when
> dying due to the unsupported combination of --exit-code and external
> diff, but that's in equal parts helpful and obnoxious, I feel.

Yes, diff dying would be annoying but the message would be useful.

Thinking about the external diff and some of the other diff options I 
wonder what we should do when options like "--quiet" and "--name-only" 
are combined with an external diff (I haven't checked the current 
behavior). If we introduced a diff command protocol v2 we could include 
a way to pass through "--quiet" though maybe just redirecting the stdout 
of the external command to /dev/null and using the exit code would be 
sufficient.

Best Wishes

Phillip

P.S. I haven't forgotten about our unit-test discussion but I'm afraid 
it will probably be the middle of next month before I have time to reply.
