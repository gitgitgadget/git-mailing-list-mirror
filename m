Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450F377034
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870470; cv=pass; b=isrWnvc4eBNKRM06n7dAJJhkcAKvKbSt+1Y7jhMKi7RnaBsyFZYAvhEIcTQ1RTuPTSjNfHk3K5PKkpj2LtNHx1P/cESBekxmJ/A0mHoJfANEM119Ak3htksfi6j3XpRLNQxA2jdWOsLNSI8P9NPfK0w6VK09IXXnNCJhq3/gZqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870470; c=relaxed/simple;
	bh=39petTY5CC0UzueW5HYiqxCbSKtsz1/2KSMYhX1Wd10=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9WjcgAsBEFNmAs2RwoP6P9LLY5WJ3xGMrDaCgFQSwfHHvH9VTbtceYDo8Ett6kOQVOpghgS0m08nYRIP9DQw6nRG89k1EJLuPDW39Shm8msvg00MZGIKiROgZg8g8XIGw1UmLm3mnZ9f2egd4Hf7rZRwr+OrPROdmLioI0b+gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=qEehboDm; arc=pass smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="qEehboDm"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14ce76ce216so1407081c88.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 09:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870467; cv=none;
        d=google.com; s=arc-20260327;
        b=cbI7v9RCZ47f+F6HnBAl6EizC0QF8KcLSnYOOiFBs4OFhE1YEn9uVLO3YL1GidHxyt
         pXIj+ikSNbR6TQ3oXQLoXaTJsKtbudh3wgkXXf3YVsm/j8qWNgTOSv7hZIMoxWrXMvqV
         1ToSHgJKIMq0u9aGacasa4hEg4syPhMcosl3m7wlpDm/nq6nZly23z/ImeqXO5QqJF5W
         5LS+wjABqZ4HXPQhhDeQ/Yby40bhsRWRkXu40ZUcqhKzyad0pflFwt89CoUyMh6XimUQ
         2pXUj47QmBLphydGa6Ud5SgQKbdmXnF1HFlYAGTi17ORe11S36sA59ju7HUxV2MAf4ur
         gyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=39petTY5CC0UzueW5HYiqxCbSKtsz1/2KSMYhX1Wd10=;
        fh=2V0/zlUwjEmuYtVRRPN68To0+sbBfz0rn2sjuZIDoE4=;
        b=kKGBUaA/bEMVc7L6yha/EN7k5XpMhOpEOHlSspyEf7fijloqjUjP0vGGSaflI5gSIV
         6D0J+jiDQ7ojYd4OagiS7c34BonKyM8bcNbZa4gPMDBskbf8BwwJH22vtOwmM10gUGbT
         sSYevxySmcZxxky0sM7IR9CcQTP7FffkslKMFWZckI0O7fZwI2p9qieOm9OBNJxy9e33
         GLenj9dVGxvqJk3AXoFoVkKqePwaWENV+fwirEaLGpmQwa2Ncb4vcnlyeBw/3RYPh3Cu
         UfBks8nVB0I1EMs6a9zcDqQAi6qi5t1huccW6H+zxQmjSy+TCP8uYSAbZTD/A/mLme4f
         UH0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1790870467; x=1791475267; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39petTY5CC0UzueW5HYiqxCbSKtsz1/2KSMYhX1Wd10=;
        b=qEehboDm8hmQAlsYkxVQ3QGOKtgY/dT3Nf4uUi52RGHRX1kiMbzv0D+oKXI0y20THw
         napWn4/y+Ck3DFuAMtUxOXqVxDaJhblEDnOdqap/gt4sJ0jNZBpHpSWGdnK9hkik2J3v
         U3dBQw4He2RrsPxwkU30a0brx+ZvHcZN5fwZYXKNEU/e7iZtq2uMrGk+20NfzZnjXM++
         nlnGz1V1tMCG2DWB0bRepsTD6CJXw24Ioifs3SnrkOCwBaQfzlCwaeNSFDdAqzZQV9ar
         Mmdov7IYT04f6yyEZrhKvI6rGNlqIKirN136Koe5rY9sTt3fsCaUM4KU+5261LkwIvvF
         PQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790870467; x=1791475267;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=39petTY5CC0UzueW5HYiqxCbSKtsz1/2KSMYhX1Wd10=;
        b=mkqSqpQCfPebMXDJP9yjUoEeSxmI0sTfDnm7dhHx9qgHBYH7rT2B+A2oz+WxzJmoDg
         1UMU+SEuiGAUj7x6tIF+xLhTtn+8U4To4GYm7SskpsXDUz+O84G9/pPTqGXy0+CEeOhy
         LrsZqyR5H11Pa0uPp79yECp6WBT7BSpRCE7K6Yw3Vg5juGJzW5G5fvJ3IvOffwxUqr5h
         3U7qvo89HBVE+nhycfOIQfRgczPG25YNatby2rAWU29isJVzwc5WDTl2MrdE3jkCYjwB
         d+lKWPSZB/Fvju1Q0bjUGj1VVdz/FPGOwJ0RbTQZXEr1iX80Zi/Ln5yOm4sBsEnghFGa
         dvSg==
X-Gm-Message-State: AFuF++mIbl6XrglPSy0H712CkjMC7g6D1Y+6WOYsGMUg1Vbc6Qi9lMUq
	MeN0oO+kuDMFSxtglnCbr1k/E78PEjr3uIZDn2QyNvE4LpDJXUrXlOi5Ec2LbOVoCaWzD2e3YVb
	61hK/msn4cLCCMPh+zgKqx77zozIPQ+87eWBJpeJe1c0xSU5T+bRW38g=
X-Gm-Gg: AYBFou2vBZJmYA5QivGSW2m0BNQ4XmXTBLwfwvOejGX7SRzb+KEnMl81zcD+61aRB7U
	/asH1mffLRjaefheeA9kRSR6Y0hQ34lH9sZ8P2O4SD/t8yX+nKKXcJRJWN5ScJMJF5jmKeyT7uA
	yz8kFqdqa0xlmnwcM1RBNyP3Df+vE0jnvDGxsb4r0OoSO9gjfRVz+agIQKA8G8arfn63bhazXNB
	ZbGRFBziuus+AcNV+LSu2ts5LGAseCavf4KXCm/cg+NwpbJuded1HuAnsxnpkKpKSa6yLZ9S4BO
	amKqFqKTKMXhXX2/MwO7BtO/MUk0UnAGwC4jAg2qs9lYe4o1HUwH1mk=
X-Received: by 2002:a05:7022:7f03:b0:14c:e31e:5dd4 with SMTP id
 a92af1059eb24-14d33495892mr4789635c88.36.1790870466068; Thu, 01 Oct 2026
 09:01:06 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 1 Oct 2026 09:01:04 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 1 Oct 2026 09:01:04 -0700
In-Reply-To: <ar5EwwEt8-ADeLdr@pks.im>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com> <ar5EwwEt8-ADeLdr@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Date: Thu, 1 Oct 2026 09:01:04 -0700
X-Gm-Features: AclHuK82CxuJWnXqARA6ra_D-319T1WCNYBKUug7FGVvYrIFJYECjqtcY76fhUE
Message-ID: <CANUHOw3syiH81F_5q-S33Zmyfw5v_R8cS1hwgpPLqrBDQGu3FQ@mail.gmail.com>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
To: ps@pks.im
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com, 
	phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

Thanks for pointing this out, and sorry I did not understand the
expected review process here and sent v2 before replying to Phillip.

I'll reply to Phillip first and follow the proper order.

Thanks,

Kazumasa Shigeta


On Thu, 1 Oct 2026 13:32:19 +0200, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Oct 01, 2026 at 01:21:55PM +0900, Kazumasa Shigeta wrote:
>
> When sending a v2 in response to review feedback it's a good idea to
> both:
>
> - Respond to the reviewer to acknowledge their feedback and/or engage
> in a discussion.
>
> - As part of v2, send a range-diff as well as some documentation what
> has changed between the two versions.
>
> This ensures some netiquette in an age where we're increasingly only
> talking with AI, either directly or via a meat proxy. And makes it
> easier for the reviewer to see how exactly you have honored their
> feedback.
>
> Thanks!
>
> Patrick
