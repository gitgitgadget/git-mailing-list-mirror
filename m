Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D72339A066
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714413; cv=none; b=X9Kn4GtURdMBUa8x51sxyvKhE9i9pMaoaWB7uyZPWL4Z8blJnkYyBgLVUmiHrNuiPl1adIq1SI3J/nn7X0AuwUAocap0eVirDUbhNwejABJx6dGr9DNmi0JZncxvklSTgSJNeO4wf0ygsg1tZkUEDvL9BpqZQ7YWYRtsTZdZqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714413; c=relaxed/simple;
	bh=w/tpZUb7Tr1O6/8Ko5xh7GMcIjQhFQUuG5L9oQ4+NF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VM8mLD5WSfF2+74+rnIUP+9Eh85/5xMEaE4/TtMMwck4ndAeYBYMYeo8KzFkZ99qIYM/vnnHGvVM9/mOazbz9GREtg2VjT9FaBhybaN5+C0Kz/B+N4ta69jbjKJk5GdhFrQw/M845WN+SODacFrsUAjmfAN/YIv6/G9hbu293o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIOb1LpR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIOb1LpR"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82980ceb244so164585b3a.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 04:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772714412; x=1773319212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjWcfsMuu4sSMsqyDdIS6b9mr9JIn8YM+J+SViSb2q0=;
        b=FIOb1LpRjrdt4ylWnTzru0fLz/+s+Xs5FU9B5UZVKsaDIKyyUZUbgfgNb79B55vQZZ
         Bg0CvZ4xWrPnwX3qXQQe82vYRjNzOGJ0f924yCj2tFWmK1zDLaqaP1DDXq1WAN1b6+TR
         XhsbllaB7gCpOXDdF0goJAi/yhzLq5CC+md28KfLRH5JuoTJHlCRRBVFZgUolwoDeTLR
         QS3nQUEXZtyAv3d/BaRaFVoL4crmlZCadtP4GW+IJLWZg14yRwPSFmnKXco5UunFzbTL
         KY+iKofkAlCDsNiT53H6lnanRWJQdIOkqGlGVdTn2BXuwLgvy7X/5DSKm/CE+Q7aqgsV
         GSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714412; x=1773319212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjWcfsMuu4sSMsqyDdIS6b9mr9JIn8YM+J+SViSb2q0=;
        b=kZdfA36+ByANwi3YOkynXY9qpCoNg5N6glfkdZ43WAq7uyeyWnA9vIUu284w3uVW8a
         J/B6IN+A5EEkWVt4nmS2k+64iaUvmyOxlH2vCyY4g68HH/Gbxo/45EZ1bpVTQG2aGlpi
         ZR0Z9PuqMclbfkdj3mqRwjGAUch/BKGnPPMjp2gp74T2WtAv+AKqaKNys80vACG8s9Fu
         uPR33iLruzRi63AZK34KFppkCKKkIfeXHkB0z5AWkl/ylJNd4LNK+oBL1/YWhT3iLJXI
         BISYkHpn8U2CVIFTmR6B4j1feWpIQ3zSPHUrNoEluqyIvu8AkYjgZkw4pkYX1sKzmEEj
         rygg==
X-Forwarded-Encrypted: i=1; AJvYcCWKSPtvHOqavQ6vhQCw7rEuX77KlrCPT9WGOvDFrLYpE8CVj73Vj+uF85WZCT1+sV2jsws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIA1u6hNXIw1t3ggLK5WQACw8We1GELYYDmi8+FgbhPr9DbB8Z
	khYTJOuc11ws5vKfxFeAf1uJTF/10MHUVj4KJPOVeicFWvvk8qiygNgR
X-Gm-Gg: ATEYQzy2oU1j0xbo5Mv2FDQ9SOACOsamG9vjlUMfUiVWZhyVKq21zIWeWGsggB3lIeP
	ChePn+83zJksttHT0GSdQToHA8l2rFTsCSFXssFBzOBTftEilSAnWNSSddOo/7MIH9QsKGDVZXn
	5BhZc6Ymrk4E7cOs7bvsTkJN4NHqyY+7a7/fVCvnUAff3uPsDRiPVv3Ah8DwKvtqXSvkK4bTOy0
	ZWQqlOHr26F5ijZ6RRXUWY6wDWvrgRFVn6gFLMfs9Rk/QMZA7w3boQQ9MoyTTAO9d7EWYy516o3
	0q7nBaoEvhsXaHV7ORo+dbTSwomrRfm52T++2MlEv8BVivfbH0aYSRfHt0ECzo74CLFf/Pm7LAe
	3EPLr7SugVNsZpL6tJhtlRps9KIVdHiKUE2ChMFdgeD1C5qpaf6+yq4ZAp6gx9Wc9X4gKj9cWtv
	jE8jiq2rMXT2FCE127PERirWtIKxcUnYX8QlnThocExTvwGEdHMtn0LgAuozu9e8zde5AldWDIT
	H7bQMzwUKLi
X-Received: by 2002:a17:902:d50e:b0:2ae:4e2b:f55e with SMTP id d9443c01a7336-2ae6aad6861mr42583835ad.4.1772714411567;
        Thu, 05 Mar 2026 04:40:11 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6bb5b2sm231365175ad.69.2026.03.05.04.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 04:40:11 -0800 (PST)
Message-ID: <a5e41bd1-af10-49cd-85dc-8e668f1d8970@gmail.com>
Date: Thu, 5 Mar 2026 20:40:08 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
 karthik.188@gmail.com, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20260222102928.377519-1-a3205153416@gmail.com>
 <20260223074410.917523-1-a3205153416@gmail.com> <xmqqpl5rumy0.fsf@gitster.g>
 <xmqqjyvu42pw.fsf@gitster.g> <460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
 <xmqqo6l49mrt.fsf@gitster.g> <99c6a437-3fc3-4d9a-9465-4c47a9777776@gmail.com>
 <xmqqfr6fa63h.fsf@gitster.g> <fc2aaed9-ecc3-4efa-bdef-e6ac951c1d5b@gmail.com>
 <xmqqcy1j8o5r.fsf@gitster.g> <00f6d468-7d00-4edc-886d-723322420539@gmail.com>
 <xmqqbjh35hvv.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqbjh35hvv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/26 06:50, Junio C Hamano wrote:
> Tian Yuchen <a3205153416@gmail.com> writes:
> 
>> Maybe, but my main concern was that adding 'die()' in
>> 'setup_git_directory_gently_1()' might not be the best choice.
>> Considering the implementations of the preceding functions, I though
>> locating 'die()' in 'setup_explicit_git_dir()' might be a better choice?
> 
> You may be right.  I didn't take a careful enough look to comment.
> 
>> By the way, I noticed there's a '(read_gitfile(path))' macro that
>> expands to 'read_gitfile(path, NULL)'. I was planning to pass
>> 'error_code' here, essentially moving the logic from the original
>> 'setup_git_directory_gently_1()' to this location, where the former
>> would only be responsible for returning the error status... The changes
>> would be a bit too extensive if I did it that way.
> 
> True.  It would be a lot more invasive change.  I do not know if it
> is worth our time _right_ _now_, or if it is better to be left for
> future iterations.

I will hold off on any further iterations and leave v12 as is, unless 
you or others spot any specific details in it that still need tweaking.

Thank you so much for the patience and guidance throughout this entire 
series! I really learned a lot from it.

Regards,

Yuchen
