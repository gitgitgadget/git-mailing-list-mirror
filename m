Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110357BB00
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538802; cv=none; b=PNN/2KiLH891vvzNnPMvE+JEI6s1/vCbcV3631bH3s6OeUUTqt73bi7Sl1bGotq7FpyeJq3axpxXSBui5KAzN8rKKtBppU0nkl+CnEW0d1ErKfGEpXM9KWizNr9dGGJNj2BXwbL0MFIgB+ep9+jwNMPZbmeZNcazVavK1/Byjw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538802; c=relaxed/simple;
	bh=BCb5aHDhjTVBwAIlbGoEVotILz+3mnfPGZS3Q340VEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWa2joNI/MXJYQok2sA9tG81I23GKxupvpDSsfSWjmQwNbU6pFrMk9edjW2NSzF5U7M5nU4N9TkKRXouCofkwdIA9MzMQD5majuzhlwamlBm4glfaRkGuX2jFVOna+OZA57oaKfcRQU8l5ELJWLk5GJFvdC0ZvMSHKtHYLEUrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlN9sERh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlN9sERh"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4127a0d8ae1so2619995e9.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 10:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708538799; x=1709143599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rok7Lo+/V4RrNXD1wWinOl4D3/aaX97D5F2RCuGtcE=;
        b=BlN9sERhfJM1ZVtzp/T5D18kmywa+fXFZan9afPdx7guTn9DSXeQ53cd5hhppoIP4/
         BxQduz0oBHTVEMVmldbyagzvHyRWk6qCrXUAvOGV6HII2u34E+kYxf+akZqx1TzKaffC
         gv9eDjfNO+dDJPbXAxNT84kejF2kSQ/veigVV7UvuIV3K15aazLeL7ZSel6H/ni4cKxd
         sE1rhuspcCfnpPvcnh6WAL83Lcn9N9wnzx6xVSTyVD4HPPuAxF95BrHZyxFEHhGVTUeA
         F0vaAz2JIpRE/UcBDUHhX7QPXIwmZblwMS8tnolCkcjNj38xgGdgeM1YuU8QAv4mSgDY
         fLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538799; x=1709143599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rok7Lo+/V4RrNXD1wWinOl4D3/aaX97D5F2RCuGtcE=;
        b=UMQyrVmHARL7K0iNPaJPYoEOhtsE9Lvt34xBm3N/nvyQmfm7hdwXvRLepBU9F+Njso
         vorhqt+i/797WpZvs+5ADXhhmYkdxss1W8VdKFoatJAharjIIHwv69xNLY8VxJ90r2LJ
         FsHUB5qQeJUaZbAu7SdKf+5B79PvsyXaxD93AhUqzmjtvBecAfv0sfq0l3/w/QaGjR98
         Cqh9lEvJkkrZugUT1GnKdkVarlOkrhswL5eVEWpw06JtwpAHpXtMNPuu4o0EFWeKk44J
         66BGMfdrZq/VqRX/QyF+RkI6moDpoK3/OJlO8sJTRNcR9JbHlcmL/E/BgR8lAvRKqfCf
         tLyA==
X-Gm-Message-State: AOJu0Yzm27wj7mMifq1D8Ccc7ZK9nb06RtO9ji9g6s4nWhFx60eY3mf4
	cylXztQ7F6xNJPmETM/xz1ekpFVlXZ00dkbYTVrrEWwyWZPilVpd
X-Google-Smtp-Source: AGHT+IFuYQ7DHP9ld1UBWKuFkelAxoSE4tZBzxgBFYSTfFLp8NqlXCkCqnOqGEtaVYiQff5skfO4EQ==
X-Received: by 2002:a05:600c:4506:b0:412:6488:bbff with SMTP id t6-20020a05600c450600b004126488bbffmr7424763wmo.30.1708538799177;
        Wed, 21 Feb 2024 10:06:39 -0800 (PST)
Received: from gmail.com (198.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.198])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c230d00b00411d640085csm18622426wmo.43.2024.02.21.10.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 10:06:38 -0800 (PST)
Message-ID: <abe1c96d-48f7-4355-8688-e1fb05c67448@gmail.com>
Date: Wed, 21 Feb 2024 19:06:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] completion: reflog with implicit "show"
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <5991b58c-770c-4aaa-bce5-f396d9f7f16f@gmail.com> <xmqq8r4cnfju.fsf@gitster.g>
 <dd106d87-3363-426a-90a2-16e1f2d04661@gmail.com> <xmqqwmqyr3mb.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqwmqyr3mb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Feb 20, 2024 at 17:46:20 -0800, Junio C Hamano wrote:

>     $ git reflog sho<TAB>
>     shot show
> 
> That is what I would expect.    

Thank you for responding.

Of course that's the logical expectation.

However I'm not sure if it is sensible to offer completion for
sub-commands mixed with branch names.

Furthermore, I am also worried that such an approach implies making the
user pay, probably unnecessarily many times, for __git_complete_refs in
cases such as:

    $ git reflog <TAB><TAB>  ;# the user may be just exploring the sub-commands
    $ git reflog s<TAB>      ;# the user may be lazy and just want "show "
    $ git reflog show<TAB>   ;# likewise, to complete the SP
    $ git reflog expir<TAB>  ;# how often a expir... branch is expected here?

The experienced user, if not most users, should be intuitive enough to
circumvent the corner cases:

    $ git reflog <TAB><TAB>
    delete expire show
    ...
    $ git reflog s<TAB>
    ...
    $ git reflog show s<TAB>
    ...
    $ git reflog show shot

This is why I choose to fallback to __git_complete_ref only when no
other option is available.

If you think, or anyone else, that these concerns don't make sense, I'm
open to make it work as you described.
