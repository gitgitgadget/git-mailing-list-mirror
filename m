Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003F13A3F7
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999760; cv=none; b=SDiwqimHfOC4oom9RtLiQb+92jPWTEhJLKsPxcw0Z+klXydZKAey6DPd0G/Ss7nBxp/sMeWlC+jxwMbvqP4Kv0sesff1Yi8nFMh8CgQpFt9VmreBt4dFMXmVrWCTyhhm76acHW+Zh+0BjPOJXeN8tKUXbi0PIcCPVdccChyl9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999760; c=relaxed/simple;
	bh=ejjFaOYTvmtkc37AF6X5SeuX1+w9DnmQ8Y50fRWfHvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDhlW7qu2Qpz1Pj7wRsu/UpmbXNEDETyoo+5ZgAMJ1teBYYZYg6WELqwBdBKp25Hv0PVTw07IupDehttC8R/jgZUtZ7SBJT3XUba1HLPt+9Qya/KrQF2scLVtdl74XGB84XGpJ1vjXUR8xuYckhg6WZw+KlxVX6l2yY4YF1zKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiM0ot5V; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiM0ot5V"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-368584f9e36so1153743f8f.2
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721999757; x=1722604557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=701zhzA2IQEjTuJLbuQ8SbT8/ce+WVETItbhAASlyfw=;
        b=MiM0ot5VS90oFnI7IN7cC2M07wziY/dVo15NgY2pG7z3H2ZUntci2j6DcTwOfClgwL
         t3XjoEYrm8qQYoNlQY00xjf7sv7a4cS0POUpvqoA0P+WUxHIUiMc4vTW1Dwyw8BwsJ0u
         VTZXC4zAdWt76O/C3Adavho9kQLcVLVnKG5WagzOt4pAC+K81PEqKeTvP0FcwAlk3+i9
         StIoNCXKXQzuHsRgtA2pvtzHN7S/ixpLJtQInHY13+j+AkQO4Wd3IBZiEiSJnXrQRM3I
         HuvrXfhCNB5rXE67nCkodiuSsC9nRrVIiwUufwLSlGBLIMW9Nii6vqlob8kRfnKONxln
         jjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999757; x=1722604557;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=701zhzA2IQEjTuJLbuQ8SbT8/ce+WVETItbhAASlyfw=;
        b=IdyB46rmdn1qWgu1lhC6Ypa/YAQ7cgVuQzq1/3zsp4HaA5t93iE6+Ft3f/loNOtHyN
         l4rpg72TsQzFMGZTB5ChINgJYnROeh28r4LBECIa4rQF5zK9yOO6lOM/2EBRjM8FmHg+
         dEsrQiUWVHHhx/uzqYol379hn6lbReVbxU4hdyIbDY8kZ2jJIHHBn1B79ydSJ8BdKn3m
         J9a11kVipW5442z6dq78UCvoKjj6lmSe+86rcKJsjekcGj3FUqed2pSRvsv9Ssib4BCp
         gHdBlhnfBN4xjfolI5p9Ck3GSWY0WMNhFtwd/9jVdi1dhQ939ifhdjho6gKUvVUB8Zji
         cIPg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Q5Y3ROYaQUflRFOe7cDprDDRdcj5kZPP69zzvp6eEzsAvT5/Na6KrFA0xCH310Af5gBta3LklYRIMLhRBBer5bcS
X-Gm-Message-State: AOJu0Yw7BOUJnvFTSsO6BYpslCqaP0UoZXOCXc8S14MIlK0Y3dnfkxmZ
	hQgVWF6/ii2pswJQRrqAtjgyq0HPkSHkUfNqa8VI8mFBzZddHzft
X-Google-Smtp-Source: AGHT+IGa5icEfnbpSljy1JQ0o3aLic+s2S4Fhs+Sv5a9GBC2Cywq7eyO7LaqLzRBCfz8bPrfH67NIg==
X-Received: by 2002:a05:6000:e4c:b0:367:96d6:4c2d with SMTP id ffacd0b85a97d-36b36399eb2mr3515329f8f.25.1721999756881;
        Fri, 26 Jul 2024 06:15:56 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9b30sm5170959f8f.40.2024.07.26.06.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 06:15:56 -0700 (PDT)
Message-ID: <5b47c334-f536-48c6-a8ae-9f89910c51c8@gmail.com>
Date: Fri, 26 Jul 2024 15:15:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] check-non-portable-shell: improve `VAR=val
 shell-func` detection
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
References: <20240722065915.80760-1-ericsunshine@charter.net>
 <20240722065915.80760-4-ericsunshine@charter.net>
 <8c6559cd-d18b-442d-b692-f1611f1907f4@gmail.com>
 <CAPig+cRH+mVgCf3UMQmiG6QueELCrAKGMikc6OtZMK845QDccA@mail.gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <CAPig+cRH+mVgCf3UMQmiG6QueELCrAKGMikc6OtZMK845QDccA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jul 26, 2024 at 02:45:59AM -0400, Eric Sunshine wrote:
> On Mon, Jul 22, 2024 at 10:46 AM Rubén Justo <rjusto@gmail.com> wrote:
> > On Mon, Jul 22, 2024 at 02:59:13AM -0400, Eric Sunshine wrote:
> > > -     /^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
> > > +     /\b([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=/ and exists($func{$4}) and
> >
> > Losing "^\s*" means we'll cause false positives, such as:
> >
> >     # VAR=VAL shell-func
> >     echo VAR=VAL shell-func
> 
> True, though, considering that "shell-func" in these examples must
> match the name of a function actually defined in one of the input
> files, one would expect (or at least hope) that this sort of
> false-positive will be exceedingly rare. Indeed, there are no such
> false-positives in the existing test scripts. Of course, we can always
> tighten the regex later if it proves to be problematic.
> 
> > Regardless of that, the regex will continue to pose problems with:
> >
> >   VAR=$OTHER_VALUE shell-func
> >   VAR=$(cmd) shell-func
> >   VAR=VAL\ UE shell-func
> >   VAR="\"val\" shell-func UE" non-shell-func
> >
> > Which, of course, should be cases that should be written in a more
> > orthodox way.
> 
> Yes, it can be difficult to be thorough when "linting" a programming
> language merely via regular-expressions, and this particular
> expression is already almost unreadable. The effort involved in trying
> to make it perfect may very well outweigh the potential gain in
> coverage.

I tried to be exhaustive in the analysis of the change and explicit in
the conclusions so that it is clear, and documented in the list, that we
acknowledge the magnitude of the change.

I agree.  I don't think it's worth refining the regex any further.  It
might even be counterproductive.  It covers the cases it was already
covering and the new ones that have occurred.

A simple 'Acked-by: Rubén Justo <rjusto@gmail.com>' didn't seem
sufficient to me :), but perhaps it would have been clearer.

I have the same positive opinion of your new iteration:
20240722065915.80760-5-ericsunshine@charter.net

> 
> > But we will start to detect errors like the ones mentioned in the
> > message, which are more likely to happen.
> 
> Indeed.
