Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EEE41C2FF
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651875; cv=none; b=QCQrs+zdxPHelnfmmE49ARCdhfN2LvlRpx49ShE8I1B6cxHBX09QEpGxrC/qRYRG9Ky/ZE9cre0rg0gqJUN4g3kvYOSrBJvemlaEWhg2OJwRiwbsl7oObPRJas+0oVJwPBxpoUROwyhZkX6eAOU3tLmQDIfMpoi/Bf34xYdFBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651875; c=relaxed/simple;
	bh=pZyIIO1/wHpMhI4AgQXGjCMdVdULud26sS0p5UH6uP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keJAAQyoOCatJX5g9jr7wYbNBE0wJdOlI7Sc9S2PyzbW8CRoTYef1wgka4IWJVZQb0J05ZSj/EFepBD79Ou6+awQCyktq1SN3AYwRkIPfRwTIt8ghGcfxbGDzxDFUH4ZmIbmsPlv4P469KkCdza89NAAqUr9mVLOg4e5GbR2oAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzAHlDN4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzAHlDN4"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c207cb16cf5so49633766b.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651872; x=1787256672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKuvTq3lsQRChWB90+EOtoJWiwJSmpQeXz2snn51FX0=;
        b=mzAHlDN4hL/YEOLYxQHJ2q4uPRGV4s847Cb6kqMi8cApToMuydlImfsD6DP5in3oPv
         WYFEJdXI4qyNu439vWF+r19X+diTN1QKun0aTTE9Lecjrwwtap3FhdaFXX5vx+Htfkzm
         m/ukFCBZ1a82fV5ysxdjAea3VfKnTi5o3J4NhqB0QS7dUkGQwGtPeH99LtpmFrpk6IVq
         if770Z7dDJWyVh/Zm3lJdqywBIt+1uGwnIPD5WLjo8F4adWCsQoVbgjHW3epQegssoFg
         Mn7x7EXg6eVUGKY6zTnxU/c8pjO3XUgBPSApoytCfERlZMgTe0D+VQmDZ2xkf61RGH5R
         DNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651872; x=1787256672;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKuvTq3lsQRChWB90+EOtoJWiwJSmpQeXz2snn51FX0=;
        b=AY05Ro4lxxGa4IGdl/FuOUHCIpFzyCNmbGnH5UrvQSNGcLyRs7hInYSjck9M10CDJw
         kBa3EHSN9qaSNzVI1+0y8dRZu/JnBFTY7TAD39tp56whXSWGu5xK2Ayu5IbnKKtLx7In
         I7f3ftQppxpXN5uKLaCAHSWfrZAbu4yYE9319muBm+OLu5bTLPKX8KRk4aGNYe0c2ovj
         YyQYip3EdRScV3Ebmtm+KuddIfD1RNczx9HmdE/z7Lg7VH/f2zc/s3EfD5RtVOpNjJxR
         V8W6mUulbr6JM0FzqyxrPvaPWORrhTpFx6GrPxZn6+xoro/S0lCz6bWeQMLCYkjpp0T2
         gYCA==
X-Forwarded-Encrypted: i=1; AHgh+RojKeKk3u68c6eKkk2Lkg2pxLt9TMgBAib0/MO3LkC3M/opoCmutLRL2/93rp2zy2j8AWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfaSAqSEXLxTan8bbGKxEmBpAYL/nJo/nLUPXvD2gMz11Pmxiq
	YvsElY6XkHCUuYb4KBOgcCxMI7Ytwvn+UHCHpaNs/rOmFnqkt6JoQvV1
X-Gm-Gg: AR+sD10VsW32DF7pHQ6EBMwajP9INPyiblVyWh6JbK2uufLoYjKaXFzTPeFIPDM3h+G
	7oLoocv5ArzFPuugAtqBqE7vDBvzHumgzxEXjKLuUcBBb+iYbnFn3NeLvdnxdKuzemrFEdGQymT
	IxpYMv3Xmb9QYPduJD0b35crBAFpdup5DIbNG4hTZ0CELLQi1a8YM6+ozk8FssWRIYcDgK362Y9
	fTvBCS3QSqn67bDpU87JFX+45iL0S02Bi1FrImvOIkMGTYQqvomiGGKdsJzBUqaS9NL2QVNclhM
	gUqjD7+JIKBtNjRCk4n/+NYT8lmIQ5l7FEzPJCOwH/AylKrjQfzPjaD3t9rLH19xTW2azNxd+uJ
	OQ5RYTnZbxV/w+lVPRJ/OjiFv+Ja789KelUu4+k6pyHWYjwsmbqJ7z9ZolVfhAuFMUC7Kpqg65l
	cfhyXcLI8uJXKWh/f9Rq/wFjYJnuPUsSYt5KW81WeoJlpEzK9H6W/DO76zCr+I/X+iBYq3tHo2o
	1U1/gtdGkbA/zMdx61ttYgMOfzkz0Cd+ExYRRdA6nlK4go=
X-Received: by 2002:a17:907:a606:b0:c12:67d2:3d6b with SMTP id a640c23a62f3a-c212a2036f4mr37457366b.11.1786651871961;
        Thu, 13 Aug 2026 13:11:11 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21233a18b0sm27317466b.8.2026.08.13.13.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 13:11:10 -0700 (PDT)
Message-ID: <6da65615-0870-402d-8630-9b486b512947@gmail.com>
Date: Thu, 13 Aug 2026 16:11:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] gitk: use more natural language for labels of
 color preferences
To: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
 <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
 <45d5b05281cd4f3f43290d128d631a47975225f3.1786540582.git.gitgitgadget@gmail.com>
 <787b9472-d9ac-4d1f-814c-f7be9318ff55@gmail.com>
 <d6754ded-89f6-48e9-9755-24c45c90845f@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <d6754ded-89f6-48e9-9755-24c45c90845f@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/13/26 3:35 PM, Johannes Sixt wrote:
> Am 13.08.26 um 19:00 schrieb Mark Levedahl:
>> On 8/12/26 9:16 AM, Johannes Sixt via GitGitGadget wrote:
>>>          markbg      markbgcolor {} \
>>> -                    [mc "Marked line bg"] \
>>> +                    [mc "Marked line background"] \
>>>                      [mc "marked line background"] \
>>>
>> Not a new issue, but "marked line" is not a good description. What this actually controls
>> is the background color of commit message text found by search criteria in the gui, not
>> lines of text, and (as far as I can tell) never any text found in the patch text.
> Actually, it is the background color of lines found via "Show origin of
> this line" in the diff panel.
>
> When reading this code for the first time, I thought it has to do with
> the "Mark this commit" in the commit list, but it doesn't.
>
> -- Hannes

Sorry, yes you are right, I confused myself. 
- Maybe "Marked line background"  should be something including "origin" hinting at the
menu item triggering it, e.g., "Origin line background"?

The highlight color associated with the problem I noted (gitk highlights text found in the
commit message, but not in the commits), is "foundbgcolor" in the config file, and is not
on the config page. There are many colors in the config file but not on the config page:
as long as no one is complaining, I'd leave that as-is.

Mark

, 
