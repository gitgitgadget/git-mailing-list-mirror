Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33B13D60B
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384790; cv=none; b=rgDdLgNq7khJ6Nzbm27bBc5Mo8r16AOoztiVHUM4yV7rBnCQ+CYoAWuphjCsLPTIKUAXhhhULeAhnybdl6TntBVyPo9t0eoEfrjdzB4Vw0Fpli7pt8Te1EaD03So2D4Nt+9b5+OBHOOQdJ7KcZep8xh1imiUjmOAuSWFae57n2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384790; c=relaxed/simple;
	bh=faUTC6DT1CE/JX0K4Tpt3mSI7WwHoAaK5qh6NvnT8Kk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mso1UnBpI7glsC2hJWX/jWW9HF/whELQ/VVtAd3/Gxvpk2rv6OTMGu+TNUI+qWO6fYzWPEYH2i02r+0DMbgcNsX1XFOU/vb+BCzmFK8WDJGh0GsMSCoDZZY0S4g3uVIIZjn05xzuyObflW5NSsDMd5gVbAlUbxZtWeqVn+wCBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPohsAeS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPohsAeS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a474c4faf5eso190245866b.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384787; x=1711989587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YdUiAHasSFnKr8bTdJwlIGfs6TptO/RiR89VvBYzhwE=;
        b=CPohsAeS2Ajh2bEAEL22azZd6KCeDP+GkfJNOw7yH+w6zN7uVVRd9egzx1N1NPpGkI
         GWJ19I9WQFkf77/mipXOOAbtKSRbi7nSYhW6DF+FuMDy2PCBi+QdYAroAPhzfVtf8siA
         aqha3/VqhR1NgNWhubOUu9XBri0GR3AZ4Yd0oEUdWLJIfqi5nsr26WWzSZWhS/fezmiW
         E+kUP6GMfoK81sjCFDEqxuDdlBEYA2o+mpt/IEovtiT6sYKG+qGKi9rL/SLCvOmyHmB8
         xAhV/wtgB1ScjkFTMyTJqBAOScvQxZcsee4fwueLNv4A3BIgdLhOhJoOxc353vkpC69L
         yn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384787; x=1711989587;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdUiAHasSFnKr8bTdJwlIGfs6TptO/RiR89VvBYzhwE=;
        b=GtAqe2Be2FpBDW76hm8ARXzOveRZr81LByJDGzXti2S7pJuLvivRmg74Hz0GCWOOfG
         SDg0Zk3ZTgbIB+lrqZlHIa00y9IqGZq0jQ5rcwUDR841mvUxdXO+l9tbpGad9cHbqZWp
         QI87OIAqgTPnGDmYWID2kUijzI3gnUeeni8YdSg2mkmpBztSsc89VEnCatbukr6U2DkO
         BBZ1EV0oAbnROXQLAjGNNVlqrHkB6FKjCoLrh2RwFEbUjlX8bstLAqA04iAcQTJIkBfu
         jUiu0akpt+mv/68yzJ7Z0grC+f/o5S4h+9/kcbMY9oUDywVeM9A+x8ALDxPp+bBHCLuS
         9hJQ==
X-Gm-Message-State: AOJu0YzKsF48QOcs3hKd+RG+AyqUpDg2ho31L+uBwokTI7OLuwJqxigQ
	tecAM6ehQFskel/1gbDV/SB7mtC5wR4pbWJeg7jaNRKSkSZNrrH+
X-Google-Smtp-Source: AGHT+IFe/Ro7/rXGN3somAUa0uS/OiyMPP03mWhKxxaQjAwXJ5XCAlGyT3jtDrWM+r9Ej19Rn+PFBw==
X-Received: by 2002:a17:907:6d1c:b0:a49:182d:f121 with SMTP id sa28-20020a1709076d1c00b00a49182df121mr3039915ejc.74.1711384787276;
        Mon, 25 Mar 2024 09:39:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709062a8c00b00a45f39b2d16sm3220130eje.200.2024.03.25.09.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:39:47 -0700 (PDT)
Message-ID: <398f3763-be1e-40f3-8b91-d0a62a530f64@gmail.com>
Date: Mon, 25 Mar 2024 16:39:47 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
Content-Language: en-US
To: Max Gautier <mg@max.gautier.name>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com> <ZgE2pFt-pXurYnKU@framework>
 <03513931-7070-4430-bfae-aa039f73d74b@gmail.com> <ZgGAA7uwx3aqy0pH@framework>
In-Reply-To: <ZgGAA7uwx3aqy0pH@framework>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/03/2024 13:45, Max Gautier wrote:
> On Mon, Mar 25, 2024 at 10:06:29AM +0000, phillip.wood123@gmail.com wrote:
>>
>> It is possible to wait on a lock file but I'd be worried about building up
>> an endless queue of processes if the process holding the lock file crashed
>> leaving it in place without anyway to automatically remove it.
> 
> Side question: we can't use flock(2) in git, or lockf(3) ? The latter is
> in POSIX.

We need something cross-platform, I don't think there is any appetite to 
move away from our current lock file implementation. We can think about 
how to handle concurrent maintenance jobs once these patches are merged.

Best Wishes

Phillip


