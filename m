Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FECA322B9D
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366470; cv=none; b=oDFTaoB6UI5qTVcjOBAsF2j31SHQ/6jIanT/4KfLI7Csm9ANk2up9jdosqId1BczsFHDjwJqt34+crhYM0Y+vXHCBqFE/ol20aKbg3n6ATmVawwBif575D4Do7/yLWunmJpxWaCBEnG5XUqpxaC1rKARgHEZBzBzKSA2eT7206Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366470; c=relaxed/simple;
	bh=Xc7X+T27HJBLVbQ7qqqL74wh0sTwQvEO8E1sjPVe7Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoIliNsNaUhuuIPhDGkchLZVwSgXhNu//OuMX+y8QtRrCsO+BlmNwNNkChRcJomKm+gWGXJPLwjcnscHeMipyEjl2ZAixAAJ2K/Wa+0fl0bH3FL+dHqXkkF9N2N+6Xqu35IyW9+m6R9fXWdgmo6XgFL9Ax5mvv6mBVFLyUhNE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXpCTacX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXpCTacX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47790b080e4so39662105e9.3
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 03:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765366466; x=1765971266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gfHj0djbUEL7DLzVJ7OxBk7/DFHuAxF+BcbP4XrFlxE=;
        b=DXpCTacXVrNWgSDr9bvFOIk2/ZaV+9CyCBDQ8IySPHkJfSt90X+AjrUDCbPG/w+qPM
         ZGaeH9xBlf++2vpAtzALBclb9mPl4KWscVlwnY2+dkEoWdrzGKodDAZbMtmPvNH7O0ei
         kglPImlTHYdqxzFWnDpkj2J7HjhjP+kYvBI/6beFSX4VppVnoYweNjDeiHVUSeUnnAjo
         nZcnKHbv2PzixWPzYbhF9PLxYdQlvks1JsRpCU+J1ohp6uAJvg86miPe+y0oVRar1sFb
         RayaOC8WgccrLeOn4JbsGbwUqK2FLdbFhyE3rSuPRci75LRBrBZjwPJk8ATxjBTnX/gj
         uemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765366466; x=1765971266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfHj0djbUEL7DLzVJ7OxBk7/DFHuAxF+BcbP4XrFlxE=;
        b=gK6D3l+Su1MgbRPlvHHtVwKX+l/GTK1KBQdf3mRQbsruV271J3SrmkRCea4ChhGMP6
         ZzvxecalKmfGEm+OzRJch9Q3KMF+zlMPX8kCz8kWJ3vxOXOTB+Wo+0W4QNTAzHkORIJj
         VT8ZMz3yo2Ev4CZEQ2JIUr7aud1cVOqJnD2Xp564pWX50J6ZCVBtU0vPwUTatRCi0gny
         EpD2R/DJDoN/CDmqBq0bIUSLtieyYqSLQwomF10wlh8dGhnZ5ktA1LMphhjss+JkRGEb
         STp7S7JKbM7f8zMWPxLiav9Qxtuk/I6aSTkd9b42lv3Hyk5LmRpjRAlMLut814Yd2biF
         GN4A==
X-Forwarded-Encrypted: i=1; AJvYcCXvVlWxrj8qwr6MmKa3ucyWUR6kjJL3qd6qDBUEQCVlA+vASB5Lx5d1dQ1G0dxZTK58a1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YywWMaHD88/i4PC/hzOp5z/f40CztogdbMN2ZmnTLqDWZQ7Kk8O
	E6NwC5aNMRuohKoMCTl8gnjGAd/jWnyO5thX9zoFzyXe2T9vSbgZtSYjVIJ19w==
X-Gm-Gg: ASbGncvDB6TEwri923uHzfBlhlVZxr1X6pVUiu9in3Y+EzXy320otTKo0tDh9dbqctr
	0OupZgBp8HHl+lhkw0V+h0e52e1qbQfeJLnMCsJEGVXiFP7h2GaewH3JzZeaimHDt58ckPPf03M
	VY5s6SHzdEKVrRYsxskLeKXrtTeGKQXJ+YnA9e7Y80bRUDdYv+uFxaTkPgRSXPecfjyX5NXMlQi
	lCo2HAl6aY67udzKE4HmIvobGidON3qcSOgok4PA5eq0Yk+UaI2lf0MBsKMGoMECtCFbaOIM2hd
	W/evMzTUoRHujGpkFmSaPqadDkRP9T/bJu0m4uAfi3roCXaiV0z/44WkM4y2TMLCqnuPe2lyqnc
	8ESmc7qicPIKN/2g8pHMqTOT9jYlbC69Nsrk3f0kNm2525clyhOi1ukWdoEzrPbF5H9Z8G/Au+v
	h2VtsQCKKua3zDFRtpT/yBZ1PvEU2kVHKfLebsbL8FU6g2uEIqN5tXtEfO8kdsUVGUmirlp9Qp8
	Q==
X-Google-Smtp-Source: AGHT+IF/6sfgrvVestMQScpyR50MM4Ky+movj5U5AczetYLtlgRgEH4gfVChYm7YzoujwdbaHj9f1A==
X-Received: by 2002:a05:600c:1389:b0:471:1765:839c with SMTP id 5b1f17b1804b1-47a8383c89amr17616865e9.20.1765366466189;
        Wed, 10 Dec 2025 03:34:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d2734fsm39045015e9.6.2025.12.10.03.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 03:34:25 -0800 (PST)
Message-ID: <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com>
Date: Wed, 10 Dec 2025 11:34:20 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Martin von Zweigbergk
 <martinvonz@gmail.com>, git@vger.kernel.org
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev>
 <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com>
 <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/2025 10:37, Matthias Beyer wrote:
> Am Wed, Dec 10, 2025 at 09:58:13AM +0000, schrieb Phillip Wood:
>> On 03/12/2025 18:18, Matthias Beyer wrote:
>>> Am Wed, Sep 17, 2025 at 10:12:31PM +0200, schrieb SZEDER Gábor:
>>>
>>>> Let's suppose I have this piece of history, I'm on 'branch2', and I
>>>> drop commit B.  Which commits will be rewritten and which branches
>>>> will be repointed?
>>>>
>>>>      A---B---C---D   branch1
>>>>               \   \
>>>>                \   E---F   branch2
>>>>                 \       \
>>>>                  \       G---H---I   branch3
>>>>                   \
>>>>                    J---K---L   branch4
>>>>
>>>
>>> Just speaking as a user here, but my expectation in this scenario would
>>> be that rewriting B would be denied by default here, as branch{1..4}
>>> would be rewritten although I am at branch2.
>>>
>>> In the scenario at hand, I would expect that I can only rewrite G, H, I
>>> while on branch 3 and J, K, L while on branch4 (without passing some
>>> extra flags for "yes, please also rewrite the other branches").
>>
>> Is that because you have branches that you don't want to rewrite because
>> they've been merged upstream or is there another reason? If we start
>> rewriting multiple branches we should probably check that we're not
>> rewriting something that has been merged upstream but if I rewrite a commits
>> that's an ancestor of several branches it would be very helpful to rewrite
>> them all at the same time to keep them in sync.
> 
> Its mostly because I don't like too much magic and because I think being
> explicit is always better than not.
> 
> So from my POV, I would expect "the simple case" to be "the simple CLI
> call" and if I want the tool to do magic and "rewrite all the
> things"^tm, that I would need to specify a flag for that.

Thanks, that's useful to know. I'd assumed rewriting all the branches 
descended from the rewritten commit was the natural thing do do but 
clearly not everyone thinks it is.

Phillip

