Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8B450410
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465632; cv=none; b=Gz6GU+1ElC8QU2byNK+k4gyhYKi6N/51S35zbfrbX4TpdwcO7QqCLIVsG1zvzY5LvkiG0EnIo2vrKfBBdkSPOyMH31oyGJ0hJpe8kF4Ip1hUjSqH1Fa9A5D/K0Q7QlnfZLUSS4n8AHXDDHL7A7R/SDAOQ3vW2cI8cOZygkf1zQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465632; c=relaxed/simple;
	bh=FT4gvzyDwAmAMLNgrUkWT1b03cmbRlI6iY8I63X5QL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPyVEzoZY2Iw+Ss/LHV+cfvfSccDbDtJOOmjxvhufbI9ct60IoMQnbDqeiJW8XmVGApQxeKBPglKSFeq2grnS8x+JVVkKkaETc7ijPAHwJPmkEABpLokqdw+ROkkC/lhRu5bCRc4ZmmD+dzR8QvSz85zaE8obU3hHYi1bXBblWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkuasKhY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkuasKhY"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4b62d118aso1840149a12.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791465630; x=1792070430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wYAxSjTQm7OzPG2hAvgWyHcQBbZ8M2Ypwyo8EwRWK8=;
        b=BkuasKhYDEiVpK8ZATpk97k08GU12BpmtEIIwN6uoAvj83rXrARa0ZWngXTSfdy5KE
         l02HvJ4Giv16Vw9zJnp6yO2uCelnU2YIPPJB/gWnXKbLfj8pywIeV6CcZfzMblTt2jyB
         fxsMsPhnKOj5nyHfqok1UGqw3tCKgdDrZs0C4PsoeGAkkJ01S0ORACwLFgJn5k/NfQJu
         4uGJ/azYV2vomyNF3Pdx8fHlR1TCc4BYAnqx93B7LhFSTepm8672xTTjzM0P9YAMQR0j
         eJuGEn8HD7bstNGM++KNx/jPugg3aVVaCUokWiFMaZxSbYnTXh3mm4D+1ARYAGPd0HS5
         +lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465630; x=1792070430;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8wYAxSjTQm7OzPG2hAvgWyHcQBbZ8M2Ypwyo8EwRWK8=;
        b=FyP+JzV+SiVGfyfzsOmARvEEgqdgvnOj22RlCSSJSXSG9g2tbC44ySymPOCue87Tl3
         ZnnHTqVmDuKzbBourdQJgAdNIJh1AiT3RVOOVfowJ6p9lhlxhmeM5zUeG9r7oZmNgsTN
         /6LbZuhxrQJqYqCA7e70WJV1pNxa6Sph6fEY6KCm2WjFs4Jc5+aqv6xmyUnhZrEKDmzU
         Y0yd2nO6bnluovIq/cgwtyxmRjxDDUHi8XipQJvWlxzVWwd9+FRx8IoAvI58fZvALzTF
         I4CEx0I/glY+jOsc5g07bt/D9HZNQAHhIiYqG33zp4HZnbiJtOykMOio3S0OpG6PUhqF
         DL0A==
X-Gm-Message-State: AFq9FYIYsrZtgyZRHwJK5iBi7IuMTr9eQySCjmhuA7yQoDt/1Ggcgzqd
	NomUYHq4LVaubA80hZU3a+oOC/eV6vz61f8wDwUNKXwgBqoJsXF9PHK5
X-Gm-Gg: AYBFou13qBnxr7P/muKy/aZNLnkYqQ/yMtP8OsRVk6cY8sJ9XP30GeS4jUkT0hovJXE
	NBIou9B79eou9Fnwm5JI7nMMdvw1NibNnYxwHEpyBJ5c6Y5aNt9umg1ZuonNf1QjgjtNQAXb1cT
	/VUzQNx1jb970K206hWCUK2cYjlO154fDohgyO498GGgJeg1B0PKcgyYFkUPGAkRIsmLNXeXT1A
	0GG10QSmLoMh8v9+lk3OO7WolHg74ye73XJKRfNfjWspHtegdRPgVmB1lmtKFVwJ0Fanx294im7
	YgYXbyAj13INCQjuUbllzOlsYnkUoPWurLMR6bnTw+CuCUGE8hmoD9MnGCyWeZFzxdE7pSpHaXM
	0rCs8xyqcvc2Y5ybiOi88wAEOp1shYoK/fXvKHcKkrtKBsjEISYB3G292jCn0mX7NkjLyn14Ibd
	A+hH6ziIFdU1CigIu3F0TA88lp6E7XDcgNFKF703uGvmDe6S7Lm0NiwSHc1SyRMu9DMAkUEPG92
	0/UOWlIXoPCaQ==
X-Received: by 2002:a17:90b:3b48:b0:3a4:97ea:f0d8 with SMTP id 98e67ed59e1d1-3a8a1187f01mr5405138a91.51.1791465630009;
        Thu, 08 Oct 2026 06:20:30 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a97c2e9dsm2981530a12.19.2026.10.08.06.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 06:20:29 -0700 (PDT)
Message-ID: <077dca6e-27dc-43fe-9acc-20cf53651b42@gmail.com>
Date: Thu, 8 Oct 2026 18:50:21 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Pablo Sabater <pabloosabaterr@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Git at SFC <git@sfconservancy.org>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>, Tian Yuchen <cat@malon.dev>
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
 <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
 <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
 <DLEWITFIKFFK.NSANTRY5XBCB@gmail.com>
 <1b904e64-e681-4744-b83e-690f3ca94ea1@gmail.com>
 <CAP8UFD3kd=6QHp2oB+t+g-2D8bY-Oe5+_Vk+RJeaCa_xhxGrsA@mail.gmail.com>
 <fbed7a60-57ab-439b-a550-2d2b76ff24c0@gmail.com>
 <CAP8UFD2VutDBA54c1e5uiCjFB8v3Y6yS3MTtY2P6sM5+Z9y7PA@mail.gmail.com>
 <DLX41DP10SBK.3JNC50ICRW1RO@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <DLX41DP10SBK.3JNC50ICRW1RO@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/5/26 23:49, Pablo Sabater wrote:
> On Sat Sep 19, 2026 at 2:43 PM WEST, Christian Couder wrote:
>> On Thu, Sep 17, 2026 at 1:07 PM Kaartic Sivaraam
>> <kaartic.sivaraam@gmail.com> wrote:
> 
> I wanted to let you know that I'm no longer sure I'll have the time
> needed to properly co-mentor, and I'm worried about ruining an
> intern's experience.
> 
> I'll still try to review patches and help where I can, but I think
> it's better if I'm not an official co-mentor.
>

No worries, Pablo. Thank you for letting us know earler.
> I'll wait before withdrawing on the Outreachy site, in case you'd like
> to reorganize things first.
> 

Cool. Feel free to withdraw, though. I think it shouldn't affect us from 
reorganizing.

With this change, I think we can stick to our mentoring capacity of 2. 
We can mentor 2 out of the following 3 projects:

   - Reduce Git’s global state to enable Git's libification

   - Improve how command arguments and options are scanned and parsed

   - Implement promisor remote fetch ordering

We previously had the following mentor allocation:

    - Reduce Git’s global state to enable Git's libification

      - Usman Akinyemi
      - Pablo Sabater

    - Improve how command arguments and options are scanned and parsed

      - Christian Couder
      - Siddarth Asthana

    - Implement promisor remote fetch ordering

      - Kaartic Sivaraam

With Pablo dropping off, I think we can keep mentor pair of Christian 
and Siddarth for the "Improve command arguments" project. I can pair 
with Usman to mentor the "Reduce global state" project.

If we get strong proposals for both the "promisor remote fetch ordering" 
project and the "Reduce global state" project, we might have to discuss 
how to break the tie. I suppose we can only pick one out of the two 
projects.

Feel free to share your thoughts.

-- 
Sivaraam

