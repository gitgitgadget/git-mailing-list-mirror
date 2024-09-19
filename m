Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D385199FCD
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755750; cv=none; b=a1I+IzKZrghu6KDkXuz8uH1Wg3Rgun+tpdSTyLEG5cKvMdu2/S3nnVLpPuCew2MVEmisUAocSdAH7xmPuoJX3Db8HKPBPT9qgBY6RQEdhw77kHI46p3pXrpLVB2yPQXyZXyAPBH9t1Q7GKs8M9Pz2dn2Dt7l3EjrfQSJAUA4T/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755750; c=relaxed/simple;
	bh=KITcDSPmconpnSBO4y7A9GLFbddPu9ksOwSHF94rY1U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BrDd1vh5reY1/Hh0pzqZEikOQQDVdr7dEpHsqUojNgN+gXDW70b3uIWyVKv5MnurhFWdVpFctBrHsoTMrv1CLKbB4NqoiX0aGuMBo0LwSvGIQ2GQBiHuMmhS1Y6xRBjlCp9fCQHqICE9u+A1xiWydh8i7Pk6aJvsSxQyLTBYl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0oO7r9d; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0oO7r9d"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so569270f8f.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726755747; x=1727360547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HX+EYOjvxd3ShtoAe3SKYowdl0uFPGweUbX/ofdpCc0=;
        b=P0oO7r9dYXhYifI8qe+j1pukldXBF8OZN4R12bGIRKWU5E0tFDlJhq+DzhrB92IeUe
         FnP2zvI0pYPaug3eyGxpqQ4G1iGPbEaYDKsdFyFyr5F8w1hPrjrbEVaH5N1e9AodT6kT
         Za4YRCfH8PjkYOkkK/7T6iqoMnNiP2QCAvSZojuMptJp2n4TSUUZdWCAicowYLggy8bY
         F0O40ecYKBPzeFPnJFhs18XbdgrKYON0Hr09nuM2NuGPjy6JecSAbc/05CTbUTVdd5jQ
         BH04++rC6O91hZlPJmsZefOFNIjtXDE7ki1bXMmf6hFpi0qLjV3xWfBaO2+Oa5aVHtwC
         Fibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755747; x=1727360547;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX+EYOjvxd3ShtoAe3SKYowdl0uFPGweUbX/ofdpCc0=;
        b=HlxX5/ikH4IM3H53Ig73QiwvUF93BPzJFs/wp+oPjanzhktkcMZebaPfP/bWVb16yC
         wceq2rwdbhK1iPualYWAnfbmgk+k02JFx/eqM2kVXZ5pFDTUp64Dg2mzZcw1TOOjtBNh
         JWDzvqMeX2hXJLkzzQQ8xK5vUAT0OYVBIP2cQzPHqfcAC32SGpYmY5g3/epTYMJSsZM5
         6oWTp7nqiQDEvA0Gd9O3q+XZtS91ick/WIAI8Eq/To9dCW2oZcWpFvZfW6+Lg+tgmJgA
         ehLoRQYid9h6Y5F3BRFVz/FaB3MLqwUtI5JbA7LbEhK6XSAyETzO43OM3ebxW7tuTz9s
         6hhw==
X-Gm-Message-State: AOJu0YwOgIOCHaOhWl7TYckSUCaxx8F+zgX013EsvKItfrdyrlGmH/IB
	hXnA7dsvsu0hpYGASgAvSJqN52TTWI+Y3dEASEFZJycqQQV5xoPS
X-Google-Smtp-Source: AGHT+IGmsK182P4sg91emfvbcxhzVxwDlDqvrY6iSRF4aHVasVpxL9I6AP5uZCsRzz70Ha57KhqyGQ==
X-Received: by 2002:a05:6000:1042:b0:374:ca4f:bd78 with SMTP id ffacd0b85a97d-378c2cfeb64mr14810194f8f.10.1726755746646;
        Thu, 19 Sep 2024 07:22:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ba:6501:244f:f1e2:145d:427a? ([2a0a:ef40:6ba:6501:244f:f1e2:145d:427a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e49bfsm15172005f8f.21.2024.09.19.07.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 07:22:26 -0700 (PDT)
Message-ID: <467f6fb4-5f83-416b-bc09-572a82f210ea@gmail.com>
Date: Thu, 19 Sep 2024 15:22:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: fatal from submodule status --recursive when used with grep -q
To: Matt Liberty <mliberty@precisioninno.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
 <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com>
 <CAKDm0rMsXUpFSWRWkW0J0FUpEbot6wQqdzYTT5CLZ=3TGbV-OA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKDm0rMsXUpFSWRWkW0J0FUpEbot6wQqdzYTT5CLZ=3TGbV-OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/09/2024 15:28, Matt Liberty wrote:
> I'm not trying to capture the exit status of git but of grep.  Compare 
> it to "yes|grep -q y" which doesn't generate any error even though yes 
> generates endless output.

Sorry, I'd misunderstood your original message. So the problem is that 
you want "git submodule status" to be quiet (i.e. not print an error 
message) when it dies of SIGPIPE?

Best Wishes

Phillip

> Matt
> 
> On Wed, Sep 18, 2024 at 3:05 AM Phillip Wood <phillip.wood123@gmail.com 
> <mailto:phillip.wood123@gmail.com>> wrote:
> 
>     Hi Matt
> 
>     On 16/09/2024 16:08, Matt Liberty wrote:
>      >
>      > If I try to grep the output I get a fatal error:
>      >
>      > % git submodule status --recursive | grep -q "^+"
>      > fatal: failed to recurse into submodule 'tools/OpenROAD'
>      >
>      > I didn't expect any output but did want the return status (0).  I'm
>      > guessing git is unhappy that grep -q exits on the first occurrence of
>      > the pattern.  I don't feel fatal is appropriate here.
> 
>     I assume git is dying with SIGPIPE. As the only purpose of "git
>     submodule status" is to write the status information to stdout that
>     sounds reasonable. If you want to collect the exit status you need to
>     consume the whole output so that the command runs to completion.
> 
>     Best Wishes
> 
>     PhillipSo
> 
>      > I can work around this by writing to a tmpfile but would like to see
>      > this addressed.
>      >
>      > Thanks!
>      > Matt
>      >
> 
