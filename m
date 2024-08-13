Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9061E498
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586332; cv=none; b=l2770eykeGH3mRAvR2byknGdsSSRZXdtgBL+PeKbLqNVxB3h9moH6aduJ95UhMnzezt1jy4JYgTuMcB8R6SDD2hdhPgr/ImU5d//dlvzd/C1OLSgKty3OYDoXTbg9qKboPyGEISQDwAV6Gd3U8crNBGC5miO8BpP3GghxmouLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586332; c=relaxed/simple;
	bh=XmjPJLU5SVYG1wljV3L3gcpmjunexylL22AJ9kLmQ/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdDmwqlbu/f+pzCeG2AH/o+Xwn+TnuKjAdI5GCLkRKdXiRclrwrCReN3uoW9s+5+EPJY03iP+Uh/WSCkD47nNMOJziBq3P61VEmSto0faCpjN4Iotziu5Kslr1JDgRqWkxH2ZwjvBPWIMiH1wyQ5wQca2nuaJEqeqhycK7JrVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRMumJzZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRMumJzZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281c164408so44414845e9.1
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723586329; x=1724191129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Lr01ddKY4LHfprwN1ioZiSwKac7V8WIQEs4K+HtWcg=;
        b=jRMumJzZHKb/IFQhhcqUEGRM+ISpLCeZPuC9atheDBlwe48B86kVnwQpkQlju0q/ao
         bGmhJrU7DeoRx+f/p5cAT2+5NY4ovWDX4DfgLbcKKlYEQKIkmCTqdVDfhE9ylW5oir4W
         CYI7VwAE00dNuuaTNurnRmeLtmEqyam3XOfePtx+RIEIYeV2SidQE6Qeh4CaGpf1alPt
         g6LNgv7zkgfGTWodwsdxsQpc6nb0gFoss7T6Z3Z4kufzOc97fhvE1yEV51rs6+Y0zaNF
         LT3ce2tMLgEQs7TQyxjRI3gaMLesaeIjPqTBcM8E5E1d5AuZiIL/8jU/iGqp6F/9u2dL
         ht6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723586329; x=1724191129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Lr01ddKY4LHfprwN1ioZiSwKac7V8WIQEs4K+HtWcg=;
        b=UsfFgopuYHHnZlzv0AoJjPbd3/dGAKcxaQ8G5REnw6kSpoKHNQ79H7xpbxKQ/sLKjh
         kE9ji2XMrRYot68tXbnH6xUOAqrukoZwd4TKms3q8E+jXXr5Ab5zvPlu8tASBfxwVjcq
         0rhxRG7D6Vv0TX2d3mftz6Gn2o416ZlqYargTSJWcBANZV+vQdkN5PWMKvf82VTNWOJ4
         kaysc+/byK+pfHm9H4WTyecrxGtz2iS2CTieH57P56yHYFb3gXfVTkMEOqKVCtgBUG19
         rB20rCiF/P4/E2FuBP6mB+OZ/5vSZ0WsATDDCspCEwf7LF81WZHsnCGmMnwDv7K3idfB
         DrKg==
X-Gm-Message-State: AOJu0YyyCCshBrExNd/NILZf551p9MEWRj7ATYKx8CsKVZEChZsnKkG9
	q2rs086yZNn6uQoq0YaroLzcyVhPtGwW6lcWFogGfV+qUFFGFsk/
X-Google-Smtp-Source: AGHT+IFR56izuzePAHx0JuSlryasA0Y7LDPmJy2g4BKafJ0cuXG5jOUdCapIK4htu1aT7Q2F1Qneow==
X-Received: by 2002:a05:6000:e50:b0:360:7812:6abc with SMTP id ffacd0b85a97d-3717780b5f7mr619520f8f.60.1723586328755;
        Tue, 13 Aug 2024 14:58:48 -0700 (PDT)
Received: from [192.168.1.6] ([197.40.202.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ec39sm11358928f8f.80.2024.08.13.14.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 14:58:48 -0700 (PDT)
Message-ID: <9a51779c-5404-40af-9e44-dfa05785c569@gmail.com>
Date: Wed, 14 Aug 2024 00:58:44 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] [Newcomer] t7004: modernize the style
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
References: <20240808163302.17521-1-abdobngad@gmail.com>
 <CAPig+cSLzNyik6x2FQo6T4fAtTAsH07=y3g=MTXcSTvR7S2Vqg@mail.gmail.com>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <CAPig+cSLzNyik6x2FQo6T4fAtTAsH07=y3g=MTXcSTvR7S2Vqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/24 10:57 PM, Eric Sunshine wrote:
> On Thu, Aug 8, 2024 at 12:34 PM AbdAlRahman Gad <abdobngad@gmail.com> wrote:
>> - Remove whitespace after the redirect operators.
>>
>> - Move number of expect files prepared outside of
>>    test_expect_success to be inside the tests that use it.
>> [...]
>> There are still tests that could lose exit status to pipe. This needs
>> to be modernized too, I will fix them in another patch series.
> 
> Thanks. This sort of information -- explaining the aim of the series
> and explaining what will be done later -- is appreciated by reviewers.
> 
> There are a few additional pieces of information you can include in
> the cover letter to make life even simpler for reviewers:
> 
> * provide a link to the previous version of the series
> 
> * explain what differs in this version as compared with the previous version
> 
> * include a range-diff showing the actual changes between this version
> and the previous version (see `git format-patch --range-diff=`
> 
> There are many good examples on the mailing which illustrate the above
> points; here is one such instance:
> https://lore.kernel.org/git/20240726081522.28015-1-ericsunshine@charter.net/

Thanks! I'll add this to my notes and start doing it in the next patch.
